import { db } from "@/db";
import {
  coachSquadMembers,
  coachSquads,
  regattaResults,
  regattas,
  sailors,
} from "@/db/schema";
import { currentPeriodFromSgToday } from "@/lib/datesSg";
import { getCachedFleetRankings } from "@/lib/queries";
import { and, asc, desc, eq, inArray } from "drizzle-orm";

export type CoachSquadMember = {
  id: string;
  sailorId: string;
  name: string;
  handle: string;
  sailNumber: string;
  club: string;
  avatarUrl: string | null;
  fleet: "Gold" | "Silver" | null;
  ranking: number | null;
  bestThreeOfFive: number | null;
  squadStatus: string | null;
  latestResult: {
    regattaName: string;
    regattaSlug: string;
    date: string;
    rank: number;
    fleetSize: number;
  } | null;
};

export type CoachSquadDashboard = {
  squad: { id: string; name: string } | null;
  members: CoachSquadMember[];
  period: { year: number; half: "Jan-Jun" | "Jul-Dec" };
};

export async function getCoachSquadDashboard(
  coachId: string
): Promise<CoachSquadDashboard> {
  const period = currentPeriodFromSgToday();
  const [squad] = await db
    .select({ id: coachSquads.id, name: coachSquads.name })
    .from(coachSquads)
    .where(eq(coachSquads.coachId, coachId))
    .orderBy(asc(coachSquads.createdAt))
    .limit(1);

  if (!squad) return { squad: null, members: [], period };

  const rows = await db
    .select({
      memberId: coachSquadMembers.id,
      sailorId: sailors.id,
      name: sailors.name,
      handle: sailors.handle,
      sailNumber: sailors.sailNumber,
      club: sailors.club,
      avatarUrl: sailors.avatarUrl,
    })
    .from(coachSquadMembers)
    .innerJoin(sailors, eq(coachSquadMembers.sailorId, sailors.id))
    .where(eq(coachSquadMembers.squadId, squad.id))
    .orderBy(asc(sailors.name));

  if (!rows.length) return { squad, members: [], period };

  const sailorIds = rows.map((row) => row.sailorId);
  const [gold, silver, resultRows] = await Promise.all([
    getCachedFleetRankings("Gold", period.year, period.half),
    getCachedFleetRankings("Silver", period.year, period.half),
    db
      .select({
        sailorId: regattaResults.sailorId,
        rank: regattaResults.rank,
        regattaName: regattas.name,
        regattaSlug: regattas.slug,
        date: regattas.date,
        fleetSize: regattas.totalFleetSize,
      })
      .from(regattaResults)
      .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
      .where(inArray(regattaResults.sailorId, sailorIds))
      .orderBy(desc(regattas.date)),
  ]);

  const standingBySailor = new Map<
    string,
    {
      fleet: "Gold" | "Silver";
      ranking: number;
      bestThreeOfFive: number;
      squadStatus: string | null;
    }
  >();
  for (const [index, sailor] of gold.entries()) {
    standingBySailor.set(sailor.id, {
      fleet: "Gold",
      ranking: index + 1,
      bestThreeOfFive: sailor.overallScore,
      squadStatus: sailor.nextPeriodSquadStatus || sailor.nationalSquadStatus || null,
    });
  }
  for (const [index, sailor] of silver.entries()) {
    standingBySailor.set(sailor.id, {
      fleet: "Silver",
      ranking: index + 1,
      bestThreeOfFive: sailor.overallScore,
      squadStatus: sailor.nextPeriodSquadStatus || sailor.nationalSquadStatus || null,
    });
  }
  const latestBySailor = new Map<string, (typeof resultRows)[number]>();
  for (const result of resultRows) {
    if (!latestBySailor.has(result.sailorId)) latestBySailor.set(result.sailorId, result);
  }

  return {
    squad,
    period,
    members: rows.map((row) => {
      const standing = standingBySailor.get(row.sailorId);
      const latest = latestBySailor.get(row.sailorId);
      return {
        id: row.memberId,
        sailorId: row.sailorId,
        name: row.name,
        handle: row.handle,
        sailNumber: row.sailNumber,
        club: row.club,
        avatarUrl: row.avatarUrl,
        fleet: standing?.fleet || null,
        ranking: standing?.ranking || null,
        bestThreeOfFive: standing?.bestThreeOfFive ?? null,
        squadStatus: standing?.squadStatus || null,
        latestResult: latest
          ? {
              regattaName: latest.regattaName,
              regattaSlug: latest.regattaSlug,
              date: latest.date,
              rank: latest.rank,
              fleetSize: latest.fleetSize,
            }
          : null,
      };
    }),
  };
}

export async function ensureCoachSquad(coachId: string) {
  const [existing] = await db
    .select({ id: coachSquads.id, name: coachSquads.name })
    .from(coachSquads)
    .where(eq(coachSquads.coachId, coachId))
    .orderBy(asc(coachSquads.createdAt))
    .limit(1);
  if (existing) return existing;

  await db
    .insert(coachSquads)
    .values({ coachId, name: "My squad" })
    .onConflictDoNothing();
  const [created] = await db
    .select({ id: coachSquads.id, name: coachSquads.name })
    .from(coachSquads)
    .where(and(eq(coachSquads.coachId, coachId), eq(coachSquads.name, "My squad")))
    .limit(1);
  if (!created) throw new Error("Unable to create squad");
  return created;
}
