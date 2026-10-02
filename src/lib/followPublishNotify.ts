import { eq } from "drizzle-orm";
import { db } from "@/db";
import {
  followedSailors,
  profiles,
  regattaResults,
  sailors,
} from "@/db/schema";
import {
  buildFollowerPublishNotices,
  deliverFollowerPublishNotices,
  type FollowerLink,
  type PublishedFinisher,
} from "@/lib/followNotify";

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
    return await deliverFollowerPublishNotices(notices);
  } catch (error) {
    console.warn("[notifyFollowersOfPublishedRegatta]", error);
    return { sent: 0, skipped: 0, failed: 0 };
  }
}
