import { db } from "@/db";
import {
  coachFollowedSailors,
  coachSquadMembers,
  coachSquads,
  coachSailorNotes,
  regattaRaceResults,
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
  recentMovement: number | null;
  scoringEvents: Array<{
    regattaId: string; regattaName: string; date: string | null; score: number;
    selected: boolean; isDns: boolean; isOverseas: boolean;
  }>;
  recentResults: Array<{
    resultId: string; regattaName: string; regattaSlug: string; date: string;
    rank: number; nettScore: number | null; fleetSize: number;
    races: Array<{ raceNumber: number; score: number; code: string | null; discarded: boolean; rawValue: string }>;
  }>;
  coachNote: string;
  selectionReadiness: { tone: "ready" | "watch" | "development"; label: string; detail: string };
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
  following: CoachSquadMember[];
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

  if (!squad) return { squad: null, members: [], following: [], period };

  const [rows, followedRows] = await Promise.all([db
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
    .orderBy(asc(sailors.name)),
  db.select({
      memberId: coachFollowedSailors.id,
      sailorId: sailors.id,
      name: sailors.name,
      handle: sailors.handle,
      sailNumber: sailors.sailNumber,
      club: sailors.club,
      avatarUrl: sailors.avatarUrl,
    })
    .from(coachFollowedSailors)
    .innerJoin(sailors, eq(coachFollowedSailors.sailorId, sailors.id))
    .where(eq(coachFollowedSailors.coachId, coachId))
    .orderBy(asc(sailors.name))]);

  if (!rows.length && !followedRows.length) return { squad, members: [], following: [], period };

  const allRows = [...rows, ...followedRows];
  const sailorIds = [...new Set(allRows.map((row) => row.sailorId))];
  const [gold, silver, resultRows, noteRows] = await Promise.all([
    getCachedFleetRankings("Gold", period.year, period.half),
    getCachedFleetRankings("Silver", period.year, period.half),
    db
      .select({
        resultId: regattaResults.id,
        sailorId: regattaResults.sailorId,
        rank: regattaResults.rank,
        nettScore: regattaResults.nettScore,
        regattaName: regattas.name,
        regattaSlug: regattas.slug,
        date: regattas.date,
        fleetSize: regattas.totalFleetSize,
      })
      .from(regattaResults)
      .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
      .where(inArray(regattaResults.sailorId, sailorIds))
      .orderBy(desc(regattas.date)),
    db.select({ sailorId: coachSailorNotes.sailorId, note: coachSailorNotes.note })
      .from(coachSailorNotes)
      .where(and(eq(coachSailorNotes.coachId, coachId), inArray(coachSailorNotes.sailorId, sailorIds))),
  ]);

  const resultIds = resultRows.map((row) => row.resultId);
  const raceRows = resultIds.length ? await db
    .select({
      regattaResultId: regattaRaceResults.regattaResultId,
      raceNumber: regattaRaceResults.raceNumber,
      score: regattaRaceResults.score,
      code: regattaRaceResults.scoringCode,
      discarded: regattaRaceResults.discarded,
      rawValue: regattaRaceResults.rawValue,
    })
    .from(regattaRaceResults)
    .where(inArray(regattaRaceResults.regattaResultId, resultIds))
    .orderBy(asc(regattaRaceResults.raceNumber)) : [];
  const racesByResult = new Map<string, typeof raceRows>();
  for (const race of raceRows) {
    const list = racesByResult.get(race.regattaResultId) || [];
    list.push(race); racesByResult.set(race.regattaResultId, list);
  }
  const noteBySailor = new Map(noteRows.map((row) => [row.sailorId, row.note]));

  const standingBySailor = new Map<
    string,
    {
      fleet: "Gold" | "Silver";
      ranking: number;
      bestThreeOfFive: number;
      squadStatus: string | null;
      scoringEvents: CoachSquadMember["scoringEvents"];
    }
  >();
  for (const [index, sailor] of gold.entries()) {
    const selected = selectedScoreIndexes(sailor.regattaScores.map((score) => score.score), sailor.bestThreeScores);
    standingBySailor.set(sailor.id, {
      fleet: "Gold",
      ranking: index + 1,
      bestThreeOfFive: sailor.overallScore,
      squadStatus: sailor.nextPeriodSquadStatus || sailor.nationalSquadStatus || null,
      scoringEvents: sailor.regattaScores.map((score, scoreIndex) => ({
        regattaId: score.regattaId, regattaName: score.regattaName,
        date: score.regattaDate || null, score: score.score, selected: selected.has(scoreIndex),
        isDns: score.isDNS, isOverseas: Boolean(score.isOverseasCommitment),
      })),
    });
  }
  for (const [index, sailor] of silver.entries()) {
    const selected = selectedScoreIndexes(sailor.regattaScores.map((score) => score.score), sailor.bestThreeScores);
    standingBySailor.set(sailor.id, {
      fleet: "Silver",
      ranking: index + 1,
      bestThreeOfFive: sailor.overallScore,
      squadStatus: sailor.nextPeriodSquadStatus || sailor.nationalSquadStatus || null,
      scoringEvents: sailor.regattaScores.map((score, scoreIndex) => ({
        regattaId: score.regattaId, regattaName: score.regattaName,
        date: score.regattaDate || null, score: score.score, selected: selected.has(scoreIndex),
        isDns: score.isDNS, isOverseas: Boolean(score.isOverseasCommitment),
      })),
    });
  }
  const latestBySailor = new Map<string, (typeof resultRows)[number]>();
  const resultsBySailor = new Map<string, typeof resultRows>();
  for (const result of resultRows) {
    if (!latestBySailor.has(result.sailorId)) latestBySailor.set(result.sailorId, result);
    const list = resultsBySailor.get(result.sailorId) || [];
    if (list.length < 5) list.push(result);
    resultsBySailor.set(result.sailorId, list);
  }

  const buildMember = (row: (typeof allRows)[number]): CoachSquadMember => {
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
        recentMovement: (() => {
          const recent = resultsBySailor.get(row.sailorId) || [];
          return recent.length > 1 ? recent[1].rank - recent[0].rank : null;
        })(),
        scoringEvents: standing?.scoringEvents || [],
        recentResults: (resultsBySailor.get(row.sailorId) || []).map((result) => ({
          resultId: result.resultId, regattaName: result.regattaName,
          regattaSlug: result.regattaSlug, date: result.date, rank: result.rank,
          nettScore: result.nettScore, fleetSize: result.fleetSize,
          races: (racesByResult.get(result.resultId) || []).map((race) => ({
            raceNumber: race.raceNumber, score: race.score, code: race.code,
            discarded: race.discarded, rawValue: race.rawValue,
          })),
        })),
        coachNote: noteBySailor.get(row.sailorId) || "",
        selectionReadiness: standing?.fleet === "Gold"
          ? {
              tone: standing.scoringEvents.filter((event) => event.selected && !event.isDns).length >= 3 ? "ready" : "watch",
              label: standing.scoringEvents.filter((event) => event.selected && !event.isDns).length >= 3 ? "Ranking record established" : "Building selection record",
              detail: "Gold Fleet sailors may be considered when the published event criteria are met.",
            }
          : { tone: "development", label: "Silver development pathway", detail: "Current Optimist selection events require Gold Fleet eligibility." },
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
    };

  return {
    squad,
    period,
    members: rows.map(buildMember),
    following: followedRows.map(buildMember),
  };
}

/** Match duplicate scores by occurrence so exactly the calculated Best 3 are highlighted. */
export function selectedScoreIndexes(scores: number[], selectedScores: number[]): Set<number> {
  const remaining = [...selectedScores];
  const selected = new Set<number>();
  scores.forEach((score, index) => {
    const match = remaining.indexOf(score);
    if (match >= 0) { selected.add(index); remaining.splice(match, 1); }
  });
  return selected;
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
