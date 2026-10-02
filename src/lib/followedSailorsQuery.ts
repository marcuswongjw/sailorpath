import { and, asc, desc, eq, gte, inArray } from "drizzle-orm";
import { db } from "@/db";
import {
  followedSailors,
  regattaResults,
  regattas,
  sailorClaims,
  sailors,
} from "@/db/schema";
import { currentPeriodFromSgToday, todayYmdSg } from "@/lib/datesSg";
import { decideFollow } from "@/lib/followSailors";
import {
  buildPersonalSeasonView,
  type FollowedSailorSummary,
  type PersonalSeasonFleet,
  type PersonalSeasonView,
  type SeasonSailorInput,
} from "@/lib/personalSeason";
import {
  defaultIlcaIntake,
  getCachedFleetRankings,
  getCachedIlcaRankings,
} from "@/lib/queries";

export type { FollowedSailorSummary };

export async function loadPersonalSeasons(
  rows: SeasonSailorInput[]
): Promise<Map<string, PersonalSeasonView>> {
  const seasons = new Map<string, PersonalSeasonView>();
  if (rows.length === 0) return seasons;

  const period = currentPeriodFromSgToday();
  const today = todayYmdSg();
  const ids = rows.map((row) => row.id);

  const [goldBoard, silverBoard, events, lastRows] = await Promise.all([
    getCachedFleetRankings("Gold", period.year, period.half).catch(() => []),
    getCachedFleetRankings("Silver", period.year, period.half).catch(() => []),
    db
      .select({
        id: regattas.id,
        name: regattas.name,
        date: regattas.date,
        slug: regattas.slug,
        boatClass: regattas.boatClass,
        division: regattas.division,
        countsForRanking: regattas.countsForRanking,
        raceCount: regattas.raceCount,
      })
      .from(regattas)
      .where(and(eq(regattas.status, "published"), gte(regattas.date, today)))
      .orderBy(asc(regattas.date))
      .limit(80)
      .catch(() => []),
    db
      .select({
        sailorId: regattaResults.sailorId,
        regattaDate: regattas.date,
      })
      .from(regattaResults)
      .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
      .where(
        and(
          inArray(regattaResults.sailorId, ids),
          eq(regattas.status, "published")
        )
      )
      .orderBy(desc(regattas.date))
      .catch(() => []),
  ]);

  const onOptimist = new Set([
    ...goldBoard.map((row) => row.id),
    ...silverBoard.map((row) => row.id),
  ]);
  const ilcaBoards: {
    boatClass: "ILCA 4" | "ILCA 6";
    ranked: Awaited<ReturnType<typeof getCachedIlcaRankings>>["ranked"];
    label: string;
  }[] = [];
  if (rows.some((row) => !onOptimist.has(row.id))) {
    const intake = defaultIlcaIntake();
    const [ilca4, ilca6] = await Promise.all([
      getCachedIlcaRankings("ILCA 4", intake.kind, intake.year).catch(() => null),
      getCachedIlcaRankings("ILCA 6", intake.kind, intake.year).catch(() => null),
    ]);
    if (ilca4) {
      ilcaBoards.push({
        boatClass: "ILCA 4",
        ranked: ilca4.ranked,
        label: ilca4.label,
      });
    }
    if (ilca6) {
      ilcaBoards.push({
        boatClass: "ILCA 6",
        ranked: ilca6.ranked,
        label: ilca6.label,
      });
    }
  }

  const lastBySailor = new Map<string, string>();
  for (const row of lastRows) {
    if (!lastBySailor.has(row.sailorId)) {
      lastBySailor.set(row.sailorId, String(row.regattaDate).slice(0, 10));
    }
  }

  for (const sailor of rows) {
    seasons.set(
      sailor.id,
      buildPersonalSeasonView({
        sailor,
        period,
        goldBoard,
        silverBoard,
        ilcaBoards,
        events: events.map((event) => ({
          id: event.id,
          name: event.name,
          date: String(event.date).slice(0, 10),
          slug: event.slug,
          boatClass: event.boatClass,
          division: event.division,
          countsForRanking: event.countsForRanking,
          raceCount: event.raceCount,
        })),
        today,
        lastResultDate: lastBySailor.get(sailor.id) ?? null,
      })
    );
  }
  return seasons;
}

export async function listFollowedSailorSummaries(
  userId: string
): Promise<FollowedSailorSummary[]> {
  const rows = await db
    .select({
      sailorId: sailors.id,
      name: sailors.name,
      handle: sailors.handle,
      club: sailors.club,
      sailNumber: sailors.sailNumber,
      nationality: sailors.nationality,
      currentFleet: sailors.currentFleet,
      goldEntryDate: sailors.goldEntryDate,
      silverEntryDate: sailors.silverEntryDate,
      dropDate: sailors.dropDate,
      sailNumberIlca4: sailors.sailNumberIlca4,
      ilca4NationalList: sailors.ilca4NationalList,
      ilca6NationalList: sailors.ilca6NationalList,
    })
    .from(followedSailors)
    .innerJoin(sailors, eq(followedSailors.sailorId, sailors.id))
    .where(eq(followedSailors.followerProfileId, userId))
    .orderBy(asc(sailors.name));

  const seasons = await loadPersonalSeasons(
    rows.map((row) => ({
      id: row.sailorId,
      name: row.name,
      handle: row.handle,
      club: row.club,
      sailNumber: row.sailNumber,
      nationality: row.nationality,
      currentFleet: row.currentFleet,
      goldEntryDate: row.goldEntryDate,
      silverEntryDate: row.silverEntryDate,
      dropDate: row.dropDate,
      sailNumberIlca4: row.sailNumberIlca4,
      ilca4NationalList: row.ilca4NationalList,
      ilca6NationalList: row.ilca6NationalList,
    }))
  );

  return rows.map((row) => {
    const season = seasons.get(row.sailorId)!;
    return {
      sailorId: row.sailorId,
      name: row.name,
      handle: row.handle,
      club: row.club,
      fleet: season.fleet,
      periodLabel: season.periodLabel,
      periodRank: season.rank,
      fleetSize: season.fleetSize,
      lastResultDate: season.lastResultDate,
      season,
    };
  });
}

export async function followSailorForProfile(
  userId: string,
  sailorId: string
): Promise<
  | { ok: true; alreadyFollowing: boolean }
  | { ok: false; status: number; error: string }
> {
  const [sailor] = await db
    .select({ id: sailors.id, parentId: sailors.parentId })
    .from(sailors)
    .where(eq(sailors.id, sailorId))
    .limit(1);
  if (!sailor) return { ok: false, status: 404, error: "Sailor not found" };

  const [claim] = await db
    .select({ id: sailorClaims.id })
    .from(sailorClaims)
    .where(
      and(
        eq(sailorClaims.requesterId, userId),
        eq(sailorClaims.sailorId, sailorId),
        eq(sailorClaims.status, "approved")
      )
    )
    .limit(1);
  const [existing] = await db
    .select({ id: followedSailors.id })
    .from(followedSailors)
    .where(
      and(
        eq(followedSailors.followerProfileId, userId),
        eq(followedSailors.sailorId, sailorId)
      )
    )
    .limit(1);

  const decision = decideFollow({
    followerProfileId: userId,
    sailorOwnerProfileId: sailor.parentId === userId || claim ? userId : null,
    existingFollowerProfileIds: existing ? [userId] : [],
  });
  if (!decision.ok) {
    return { ok: false, status: 409, error: "You already manage this sailor" };
  }
  if (!decision.alreadyFollowing) {
    await db
      .insert(followedSailors)
      .values({ followerProfileId: userId, sailorId })
      .onConflictDoNothing();
  }
  return { ok: true, alreadyFollowing: decision.alreadyFollowing };
}

export async function unfollowSailorForProfile(
  userId: string,
  sailorId: string
): Promise<void> {
  await db
    .delete(followedSailors)
    .where(
      and(
        eq(followedSailors.followerProfileId, userId),
        eq(followedSailors.sailorId, sailorId)
      )
    );
}

export async function getProfileFollowState(
  userId: string,
  sailorId: string,
  isOwner: boolean
): Promise<{ show: boolean; following: boolean; disabled: boolean }> {
  if (isOwner) return { show: true, following: false, disabled: true };
  try {
    const [row] = await db
      .select({ id: followedSailors.id })
      .from(followedSailors)
      .where(
        and(
          eq(followedSailors.followerProfileId, userId),
          eq(followedSailors.sailorId, sailorId)
        )
      )
      .limit(1);
    return { show: true, following: Boolean(row), disabled: false };
  } catch (error) {
    console.warn("[getProfileFollowState]", error);
    return { show: true, following: false, disabled: false };
  }
}

export type { PersonalSeasonFleet };
