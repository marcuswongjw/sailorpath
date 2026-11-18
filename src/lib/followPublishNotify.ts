import { and, eq, inArray, isNotNull, isNull } from "drizzle-orm";
import { db } from "@/db";
import {
  followedSailors,
  profiles,
  regattaResults,
  sailors,
  telegramSubscriptions,
} from "@/db/schema";
import {
  buildFollowerPublishNotices,
  deliverFollowerPublishNotices,
  type FollowerLink,
  type PublishedFinisher,
} from "@/lib/followNotify";
import { sendTelegramAlert } from "@/lib/telegram/bot/deliver";

/**
 * After a dinghy regatta moves to published, email followers of sailors
 * who have a result on that sheet. Missing Resend config or a query
 * problem must not fail the publish.
 */
export async function notifyFollowersOfPublishedRegatta(input: {
  regattaId: string;
  eventName: string;
  slug: string | null;
  boatClass: string | null;
}): Promise<{ sent: number; skipped: number; failed: number }> {
  try {
    const rows = await db
      .select({
        sailorId: regattaResults.sailorId,
        place: regattaResults.rank,
        sailorName: sailors.name,
        sailorHandle: sailors.handle,
        followerProfileId: followedSailors.followerProfileId,
        followerEmail: profiles.email,
        notifyFollowedResults: profiles.notifyFollowedResults,
      })
      .from(regattaResults)
      .innerJoin(sailors, eq(regattaResults.sailorId, sailors.id))
      .innerJoin(followedSailors, eq(followedSailors.sailorId, sailors.id))
      .innerJoin(profiles, eq(profiles.id, followedSailors.followerProfileId))
      .where(eq(regattaResults.regattaId, input.regattaId));

    const finishers: PublishedFinisher[] = [];
    const seen = new Set<string>();
    const follows: FollowerLink[] = [];
    for (const row of rows) {
      if (!seen.has(row.sailorId)) {
        seen.add(row.sailorId);
        finishers.push({
          sailorId: row.sailorId,
          sailorName: row.sailorName,
          sailorHandle: row.sailorHandle,
          place: row.place,
        });
      }
      follows.push({
        followerProfileId: row.followerProfileId,
        followerEmail: row.followerEmail,
        notifyFollowedResults: row.notifyFollowedResults,
        sailorId: row.sailorId,
      });
    }

    const notices = buildFollowerPublishNotices({
      eventName: input.eventName,
      slug: input.slug,
      boatClass: input.boatClass,
      finishers,
      follows,
    });
    const emailResult = await deliverFollowerPublishNotices(notices);

    // Also notify opted-in Telegram owners and followers of published finishers.
    try {
      const ownerRows = await db
        .select({
          sailorId: regattaResults.sailorId,
          place: regattaResults.rank,
          sailorName: sailors.name,
          sailorHandle: sailors.handle,
          userId: sailors.parentId,
        })
        .from(regattaResults)
        .innerJoin(sailors, eq(regattaResults.sailorId, sailors.id))
        .innerJoin(
          telegramSubscriptions,
          eq(telegramSubscriptions.userId, sailors.parentId)
        )
        .where(
          and(
            eq(regattaResults.regattaId, input.regattaId),
            isNotNull(sailors.parentId),
            eq(telegramSubscriptions.optedIn, true),
            isNull(telegramSubscriptions.blockedAt)
          )
        );

      const sentKeys = new Set<string>();
      for (const row of ownerRows) {
        if (!row.userId) continue;
        const key = `${row.userId}:${row.sailorId}`;
        if (sentKeys.has(key)) continue;
        sentKeys.add(key);
        const placeText = row.place != null ? ` (Rank #${row.place})` : "";
        await sendTelegramAlert({
          userId: row.userId,
          text: `New regatta result published for ${row.sailorName}${placeText} in ${input.eventName}.`,
          buttonLabel: "View profile",
          buttonUrl: `https://sailorpath.com/sailors/${encodeURIComponent(row.sailorHandle)}`,
        });
      }
    } catch (tgError) {
      console.warn("[notifyFollowersOfPublishedRegatta:telegram]", tgError);
    }

    return emailResult;
  } catch (error) {
    console.warn("[notifyFollowersOfPublishedRegatta]", error);
    return { sent: 0, skipped: 0, failed: 0 };
  }
}

export type RankingChangeNotice = {
  sailorId: string;
  sailorName: string;
  sailorHandle: string;
  previousRank: number | null;
  nextRank: number;
  fleetLabel: string;
};

/**
 * Send opt-in Telegram alerts to claimed owners when a sailor's ranking changes.
 */
export async function notifyRankingChangesViaTelegram(
  changes: RankingChangeNotice[]
): Promise<{ sent: number; skipped: number }> {
  const meaningful = changes.filter(
    (c) => c.previousRank !== c.nextRank && c.nextRank > 0
  );
  if (meaningful.length === 0) return { sent: 0, skipped: 0 };

  let sent = 0;
  let skipped = 0;
  try {
    const sailorIds = [...new Set(meaningful.map((c) => c.sailorId))];
    const ownerRows = await db
      .select({
        sailorId: sailors.id,
        userId: sailors.parentId,
      })
      .from(sailors)
      .innerJoin(
        telegramSubscriptions,
        eq(telegramSubscriptions.userId, sailors.parentId)
      )
      .where(
        and(
          inArray(sailors.id, sailorIds),
          isNotNull(sailors.parentId),
          eq(telegramSubscriptions.optedIn, true),
          isNull(telegramSubscriptions.blockedAt)
        )
      );

    const ownerBySailor = new Map<string, string>();
    for (const row of ownerRows) {
      if (row.userId) ownerBySailor.set(row.sailorId, row.userId);
    }

    for (const change of meaningful) {
      const userId = ownerBySailor.get(change.sailorId);
      if (!userId) {
        skipped += 1;
        continue;
      }
      const deltaText =
        change.previousRank != null
          ? `moved from #${change.previousRank} to #${change.nextRank}`
          : `is now ranked #${change.nextRank}`;
      const status = await sendTelegramAlert({
        userId,
        text: `${change.sailorName} ${deltaText} in ${change.fleetLabel}.`,
        buttonLabel: "View profile",
        buttonUrl: `https://sailorpath.com/sailors/${encodeURIComponent(change.sailorHandle)}`,
      });
      if (status === "sent") sent += 1;
      else skipped += 1;
    }
  } catch (error) {
    console.warn("[notifyRankingChangesViaTelegram]", error);
  }
  return { sent, skipped };
}
