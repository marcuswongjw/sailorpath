/**
 * Optimist Gold Fleet — 2026 multi-event selection.
 *
 * The standard policy combines every non-medal race across the selection
 * events, applies the discard allowance to that combined series, and resolves
 * ties using RRS Appendix A8. This is separate from the normal ranking board.
 */

import { birthYear } from "@/lib/age";
import type { RegattaRecord, RegattaResultRecord, SailorRecord } from "@/lib/ranking";
import { normalizeSeriesBoatClass } from "@/lib/ranking";

export type SelectionEventDef = {
  id: string;
  label: string;
  dateFrom: string;
  dateTo: string;
  nameIncludes: string[];
};

export type CampaignDef = {
  id: string;
  title: string;
  subtitle: string;
  location?: string;
  when?: string;
  events: SelectionEventDef[];
  notes: string;
  funding: string;
};

export const OPTIMIST_2026_SELECTION_EVENTS: SelectionEventDef[] = [
  {
    id: "ssf-trials-2026",
    label: "SSF Selection Trials",
    dateFrom: "2026-08-22",
    dateTo: "2026-08-30",
    nameIncludes: ["ssf selection", "selection trial", "selection trials", "ssf trial"],
  },
  {
    id: "snsc-2026",
    label: "Singapore National Sailing Championships",
    dateFrom: "2026-09-11",
    dateTo: "2026-09-13",
    nameIncludes: [
      "national sailing championship",
      "singapore national",
      "snsc",
      "national championship",
    ],
  },
];

export const ASIAN_OCEANIA_2026: CampaignDef = {
  id: "asian-oceania-2026",
  title: "2026 Optimist Asian & Oceania Championship",
  subtitle: "Colombo, Sri Lanka · 12–19 December 2026",
  location: "Colombo, Sri Lanka",
  when: "12–19 December 2026",
  events: OPTIMIST_2026_SELECTION_EVENTS,
  notes:
    "Top 10 sailors by lowest combined race score, with at least 3 sailors of the opposite gender. Optimist Gold Fleet only.",
  funding: "Key Event funding category · intended travel 8–19 December 2026.",
};

export const PERTH_CAMP_2026: CampaignDef = {
  id: "perth-camp-2026",
  title: "Optimist Perth Training Camp 2026",
  subtitle: "Perth, Australia · November 2026",
  location: "Perth, Australia",
  when: "November 2026",
  events: OPTIMIST_2026_SELECTION_EVENTS,
  notes:
    "Born 2013: top boy and girl; born 2014: top 3 boys and girls; born 2015: top 2 boys and girls. Optimist Gold Fleet only.",
  funding: "100% self-funded.",
};

export type MatchedSelectionEvent = {
  def: SelectionEventDef;
  regatta: RegattaRecord | null;
  matched: boolean;
};

export type SailorRaceScore = {
  regattaId: string;
  raceNumber: number;
  score: number;
  missing: boolean;
  discarded: boolean;
  nonDiscardable: boolean;
};

export type SailorEventScore = {
  regattaId: string;
  regattaName: string;
  raceCount: number;
  grossScore: number;
  missingRaces: number;
  missingEvent: boolean;
};

export type CombinedSelectionRow = {
  sailorId: string;
  name: string;
  handle?: string | null;
  gender: "M" | "F" | null;
  birthYear: number | null;
  nationality?: string | null;
  eventScores: SailorEventScore[];
  raceScores: SailorRaceScore[];
  grossScore: number;
  combinedScore: number;
  discardCount: number;
  eventsSailed: number;
};

export type SelectionDataStatus = {
  usableRaceCount: number;
  discardCount: number;
  complete: boolean;
  warnings: string[];
};

function ymd(d: string | Date | null | undefined): string {
  return String(d || "").slice(0, 10);
}

function isOptimistGoldRegatta(r: RegattaRecord): boolean {
  if (normalizeSeriesBoatClass(r.boatClass) !== "optimist") return false;
  return !String(r.division || "").toLowerCase().includes("silver");
}

export function matchSelectionEvents(
  regattas: RegattaRecord[],
  defs: SelectionEventDef[]
): MatchedSelectionEvent[] {
  const optimist = regattas.filter(isOptimistGoldRegatta);
  return defs.map((def) => {
    const candidates = optimist.filter((r) => {
      const d = ymd(r.date);
      if (d < def.dateFrom || d > def.dateTo) return false;
      const name = String(r.name || "").toLowerCase();
      return def.nameIncludes.some((fragment) => name.includes(fragment.toLowerCase()));
    });
    candidates.sort((a, b) => {
      const rankingOrder = Number(a.countsForRanking === false) - Number(b.countsForRanking === false);
      if (rankingOrder) return rankingOrder;
      return (b.totalFleetSize || 0) - (a.totalFleetSize || 0);
    });
    const regatta = candidates[0] || null;
    return { def, regatta, matched: Boolean(regatta) };
  });
}

function normalizeGender(g: string | null | undefined): "M" | "F" | null {
  const value = String(g || "").trim().toLowerCase();
  if (["f", "female", "girl", "w", "woman"].includes(value)) return "F";
  if (["m", "male", "boy", "man"].includes(value)) return "M";
  return null;
}

function isMedalRace(scoringCode: string | null | undefined, rawValue: string): boolean {
  return /\bmedal\b/i.test(`${scoringCode || ""} ${rawValue}`);
}

/** RRS A5.3: a DNE score cannot be excluded from a series score. */
function isNonDiscardableRace(
  scoringCode: string | null | undefined,
  rawValue: string
): boolean {
  return /\bDNE\b/i.test(`${scoringCode || ""} ${rawValue}`);
}

export function combinedRaceDiscardCount(totalRaces: number): number {
  if (totalRaces < 7) return 0;
  if (totalRaces <= 14) return 1;
  if (totalRaces <= 21) return 2;
  if (totalRaces <= 28) return 3;
  return 4;
}

function expectedRaceNumbers(
  event: MatchedSelectionEvent,
  eventResults: RegattaResultRecord[]
): number[] {
  const imported = new Set<number>();
  for (const result of eventResults) {
    for (const race of result.raceResults || []) {
      if (!isMedalRace(race.scoringCode, race.rawValue)) imported.add(race.raceNumber);
    }
  }
  if (imported.size > 0) return [...imported].sort((a, b) => a - b);
  const configuredCount = Number(event.regatta?.raceCount) || 0;
  return Array.from({ length: configuredCount }, (_, index) => index + 1);
}

export function getSelectionDataStatus(
  matched: MatchedSelectionEvent[],
  results: RegattaResultRecord[]
): SelectionDataStatus {
  const warnings: string[] = [];
  let usableRaceCount = 0;
  for (const event of matched) {
    if (!event.regatta) {
      warnings.push(`${event.def.label} has not been matched yet.`);
      continue;
    }
    const eventResults = results.filter((result) => result.regattaId === event.regatta!.id);
    const hasOfficialRaces = eventResults.some((result) => (result.raceResults?.length || 0) > 0);
    const raceCount = expectedRaceNumbers(event, eventResults).length;
    if (!hasOfficialRaces || raceCount === 0) {
      warnings.push(`${event.regatta.name} has no official race-by-race scores.`);
      continue;
    }
    usableRaceCount += raceCount;
  }
  return {
    usableRaceCount,
    discardCount: combinedRaceDiscardCount(usableRaceCount),
    complete: warnings.length === 0,
    warnings,
  };
}

function compareNumberArrays(a: number[], b: number[]): number {
  const length = Math.max(a.length, b.length);
  for (let index = 0; index < length; index++) {
    const difference = (a[index] ?? Number.POSITIVE_INFINITY) - (b[index] ?? Number.POSITIVE_INFINITY);
    if (difference) return difference;
  }
  return 0;
}

/** Policy tie-break: A8.1 counting scores best-to-worst, then A8.2 latest races. */
export function compareCombinedSelectionRows(
  a: CombinedSelectionRow,
  b: CombinedSelectionRow
): number {
  if (a.combinedScore !== b.combinedScore) return a.combinedScore - b.combinedScore;
  const aCounting = a.raceScores.filter((race) => !race.discarded).map((race) => race.score).sort((x, y) => x - y);
  const bCounting = b.raceScores.filter((race) => !race.discarded).map((race) => race.score).sort((x, y) => x - y);
  const a81 = compareNumberArrays(aCounting, bCounting);
  if (a81) return a81;
  const aLatest = [...a.raceScores].reverse().map((race) => race.score);
  const bLatest = [...b.raceScores].reverse().map((race) => race.score);
  return compareNumberArrays(aLatest, bLatest) || a.name.localeCompare(b.name);
}

/**
 * Combine every usable race across matched events. A sailor absent from an
 * event receives fleet size + 1 for every race in that event. An event with no
 * imported race detail is omitted and reported by getSelectionDataStatus().
 */
export function computeCombinedSelectionScores(
  matched: MatchedSelectionEvent[],
  sailors: SailorRecord[],
  results: RegattaResultRecord[]
): CombinedSelectionRow[] {
  const usableEvents = matched.flatMap((event) => {
    if (!event.regatta) return [];
    const eventResults = results.filter((result) => result.regattaId === event.regatta!.id);
    if (!eventResults.some((result) => (result.raceResults?.length || 0) > 0)) return [];
    const raceNumbers = expectedRaceNumbers(event, eventResults);
    return raceNumbers.length > 0 ? [{ event, eventResults, raceNumbers }] : [];
  });
  if (!usableEvents.length) return [];

  const sailorIds = new Set<string>();
  for (const { eventResults } of usableEvents) {
    for (const result of eventResults) sailorIds.add(result.sailorId);
  }
  const sailorById = new Map(sailors.map((sailor) => [sailor.id, sailor]));
  const discardCount = combinedRaceDiscardCount(
    usableEvents.reduce((sum, event) => sum + event.raceNumbers.length, 0)
  );
  const rows: CombinedSelectionRow[] = [];

  for (const sailorId of sailorIds) {
    const sailor = sailorById.get(sailorId);
    if (!sailor) continue;
    const raceScores: SailorRaceScore[] = [];
    const eventScores: SailorEventScore[] = [];
    let eventsSailed = 0;

    for (const { event, eventResults, raceNumbers } of usableEvents) {
      const regatta = event.regatta!;
      const result = eventResults.find((row) => row.sailorId === sailorId);
      const races = new Map(
        (result?.raceResults || [])
          .filter((race) => !isMedalRace(race.scoringCode, race.rawValue))
          .map((race) => [race.raceNumber, race])
      );
      const penalty = Math.max(1, Number(regatta.totalFleetSize) || 1) + 1;
      let grossScore = 0;
      let missingRaces = 0;
      for (const raceNumber of raceNumbers) {
        const imported = races.get(raceNumber);
        const score = imported && Number.isFinite(imported.score) ? imported.score : penalty;
        const missing = !imported;
        if (missing) missingRaces++;
        grossScore += score;
        raceScores.push({
          regattaId: regatta.id,
          raceNumber,
          score,
          missing,
          discarded: false,
          nonDiscardable: imported
            ? isNonDiscardableRace(imported.scoringCode, imported.rawValue)
            : false,
        });
      }
      if (result && races.size > 0) eventsSailed++;
      eventScores.push({
        regattaId: regatta.id,
        regattaName: regatta.name,
        raceCount: raceNumbers.length,
        grossScore,
        missingRaces,
        missingEvent: !result,
      });
    }

    const discardIndexes = raceScores
      .map((race, index) => ({
        index,
        score: race.score,
        nonDiscardable: race.nonDiscardable,
      }))
      .filter((race) => !race.nonDiscardable)
      .sort((a, b) => b.score - a.score || b.index - a.index)
      .slice(0, discardCount)
      .map((entry) => entry.index);
    for (const index of discardIndexes) raceScores[index].discarded = true;

    const grossScore = raceScores.reduce((sum, race) => sum + race.score, 0);
    const combinedScore = raceScores.reduce((sum, race) => sum + (race.discarded ? 0 : race.score), 0);
    rows.push({
      sailorId,
      name: sailor.name,
      handle: sailor.handle,
      gender: normalizeGender(sailor.gender),
      birthYear: birthYear(sailor.dob),
      nationality: sailor.nationality,
      eventScores,
      raceScores,
      grossScore,
      combinedScore,
      discardCount,
      eventsSailed,
    });
  }
  return rows.sort(compareCombinedSelectionRows);
}

export function selectAsianOceaniaTeam(
  ranked: CombinedSelectionRow[],
  teamSize = 10,
  minPerGender = 3
): {
  selected: (CombinedSelectionRow & { teamRank: number })[];
  reserves: CombinedSelectionRow[];
  reason: string;
} {
  if (!ranked.length) {
    return { selected: [], reserves: [], reason: "No race-by-race selection scores yet." };
  }
  const selected = ranked.slice(0, teamSize);
  const used = new Set(selected.map((row) => row.sailorId));
  const countGender = (gender: "M" | "F") => selected.filter((row) => row.gender === gender).length;
  const rebalance = (gender: "M" | "F") => {
    while (countGender(gender) < minPerGender) {
      const next = ranked.find((row) => !used.has(row.sailorId) && row.gender === gender);
      if (!next) break;
      const other = gender === "M" ? "F" : "M";
      const dropIndex = selected.findLastIndex((row) => row.gender === other);
      if (dropIndex < 0) break;
      used.delete(selected[dropIndex].sailorId);
      selected.splice(dropIndex, 1, next);
      used.add(next.sailorId);
      selected.sort(compareCombinedSelectionRows);
    }
  };
  rebalance("M");
  rebalance("F");
  const maleCount = countGender("M");
  const femaleCount = countGender("F");
  return {
    selected: selected.map((row, index) => ({ ...row, teamRank: index + 1 })),
    reserves: ranked.filter((row) => !used.has(row.sailorId)),
    reason:
      maleCount < minPerGender || femaleCount < minPerGender
        ? `Provisional ${selected.length}: ${maleCount}M / ${femaleCount}F — insufficient candidates to meet the gender minimum.`
        : `Provisional top ${selected.length} by combined race score · ${maleCount}M / ${femaleCount}F.`,
  };
}

export type PerthBucketId = "by2013" | "by2014" | "by2015";
export type PerthPick = CombinedSelectionRow & {
  bucket: PerthBucketId;
  bucketLabel: string;
  slot: string;
};

export function selectPerthCamp(ranked: CombinedSelectionRow[]): { picks: PerthPick[]; notes: string[] } {
  const picks: PerthPick[] = [];
  const used = new Set<string>();
  const notes: string[] = [];
  const takeBucket = (
    year: number,
    maleSlots: number,
    femaleSlots: number,
    bucket: PerthBucketId,
    bucketLabel: string
  ) => {
    const pool = ranked.filter((row) => row.birthYear === year && !used.has(row.sailorId));
    const take = (gender: "M" | "F", count: number, slot: string) => {
      const matches = pool.filter((row) => row.gender === gender).slice(0, count);
      for (const row of matches) {
        picks.push({ ...row, bucket, bucketLabel, slot });
        used.add(row.sailorId);
      }
      return matches.length;
    };
    const males = take("M", maleSlots, `Boy · born ${year}`);
    const females = take("F", femaleSlots, `Girl · born ${year}`);
    if (males < maleSlots || females < femaleSlots) {
      notes.push(`Born ${year}: filled ${males}/${maleSlots} boys, ${females}/${femaleSlots} girls`);
    }
  };
  takeBucket(2013, 1, 1, "by2013", "Born 2013 · top boy & top girl");
  takeBucket(2014, 3, 3, "by2014", "Born 2014 · top 3 boys & top 3 girls");
  takeBucket(2015, 2, 2, "by2015", "Born 2015 · top 2 boys & top 2 girls");
  return { picks, notes };
}
