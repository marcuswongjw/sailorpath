/**
 * X-15 Global Ranking — Beta (v0.2) Module
 *
 * Implements the six governance & methodological principles in `docs/X15_GLOBAL_RANKING_FRAMEWORK.md`:
 * 1. Simplified counting: Best 6 eligible results (max 1x200, max 2x100, remaining up to 6 filled by 50).
 *    System automatically selects the combination that yields the highest total points.
 * 2. Rider-specific Worlds rollover: A rider counts their most recent eligible Worlds result in that division
 *    for up to 24 months. Competing in a subsequent eligible Worlds in the same division replaces the prior result,
 *    even if lower. Cancelled/invalid championships do not trigger replacement. Other results expire in 12 months.
 * 3. Fleet size (N) and valid starters: Starters must have started >=1 race (not all DNS/DNC). Re-index P in [1, N].
 *    Race-level DQs (DSQ, UFD, BFD, RET) retain valid starter status; series-level DQs (DGM/RRS 69) held for review.
 * 4. Division mapping & progression: Results map to 5 ladders via admin confirmation; Junior results stay on Junior ladder.
 * 5. Full breakdown over regional caps: Counted events, excluded events, points, grades, expiry and beta notes.
 * 6. Governance & proposed target grades: Provisional status support during 7-day correction window & post-window corrections.
 */

export type X15RankingDivisionKey =
  | "senior-men"
  | "senior-women"
  | "youth-men-u19-u17"
  | "youth-women-u19-u17"
  | "junior-u15-u13";

export type X15EventGradeValue = 200 | 100 | 50 | 0;

export type X15EventCategory =
  | "world-championship"
  | "youth-world-championship"
  | "continental-championship"
  | "major-international"
  | "class-circuit-open"
  | "national-championship"
  | "non-scoring";

export interface X15DivisionDefinition {
  key: X15RankingDivisionKey;
  label: string;
  shortLabel: string;
  acceptedSheetDivisions: readonly string[];
}

export const X15_RANKING_DIVISIONS: readonly X15DivisionDefinition[] = [
  {
    key: "senior-men",
    label: "Senior Men",
    shortLabel: "Senior Men",
    acceptedSheetDivisions: ["Senior Men", "Senior Male"],
  },
  {
    key: "senior-women",
    label: "Senior Women",
    shortLabel: "Senior Women",
    acceptedSheetDivisions: ["Senior Women", "Senior Female"],
  },
  {
    key: "youth-men-u19-u17",
    label: "Youth Men (U19 & U17)",
    shortLabel: "U19 & U17 Men",
    acceptedSheetDivisions: ["U19 and U17 Men", "Youth Male U19", "Youth Male (U19)", "U19 Men"],
  },
  {
    key: "youth-women-u19-u17",
    label: "Youth Women (U19 & U17)",
    shortLabel: "U19 & U17 Women",
    acceptedSheetDivisions: ["U19 and U17 Women", "Youth Female U19", "Youth Female (U19)", "U19 Women"],
  },
  {
    key: "junior-u15-u13",
    label: "Junior (U15 & U13)",
    shortLabel: "U15 & U13",
    acceptedSheetDivisions: ["U15 and U13", "Junior U15", "Junior (U15)", "U15"],
  },
] as const;

export function normalizeX15RankingDivision(rawDivision: string | null | undefined): X15RankingDivisionKey | null {
  if (!rawDivision) return null;
  const cleaned = rawDivision.trim().toLowerCase().replace(/\s+/g, " ");
  for (const def of X15_RANKING_DIVISIONS) {
    if (def.acceptedSheetDivisions.some((candidate) => candidate.toLowerCase() === cleaned)) {
      return def.key;
    }
  }
  return null;
}

/**
 * Valid starter check:
 * A rider is a valid starter if they started at least one race in the series.
 * A rider recorded only as DNS or DNC across all races is excluded from N.
 */
export function isAllDnsOrDnc(
  races: readonly { score?: number; code?: string | null }[] | undefined,
): boolean {
  if (!races || races.length === 0) return false;
  return races.every((r) => {
    const code = (r.code || "").toUpperCase();
    return code === "DNS" || code === "DNC";
  });
}

export interface RawRiderRaceRecord {
  officialRank: number;
  races?: readonly { score?: number; code?: string | null }[];
  seriesDisqualification?: boolean; // DGM, RRS 69 gross misconduct
  isProvisional?: boolean;
}

export interface ReindexedRiderRecord<T extends RawRiderRaceRecord> {
  record: T;
  isValidStarter: boolean;
  reindexedPlace: number | null; // P in [1, N]
  heldForReview: boolean;
}

/**
 * Filters and re-indexes valid starters in relative order of the official final results.
 * Excludes all-DNS/DNC entries from N, sets P in [1, N], and flags series-level DQs for review.
 */
export function reindexDivisionStarters<T extends RawRiderRaceRecord>(
  entries: readonly T[],
): {
  validStartersCount: number; // N
  reindexed: ReindexedRiderRecord<T>[];
} {
  const sorted = [...entries].sort((a, b) => a.officialRank - b.officialRank);
  let currentRank = 1;
  const reindexed: ReindexedRiderRecord<T>[] = [];

  for (const entry of sorted) {
    if (entry.seriesDisqualification) {
      reindexed.push({
        record: entry,
        isValidStarter: false,
        reindexedPlace: null,
        heldForReview: true,
      });
      continue;
    }

    if (isAllDnsOrDnc(entry.races)) {
      reindexed.push({
        record: entry,
        isValidStarter: false,
        reindexedPlace: null,
        heldForReview: false,
      });
      continue;
    }

    reindexed.push({
      record: entry,
      isValidStarter: true,
      reindexedPlace: currentRank++,
      heldForReview: Boolean(entry.isProvisional),
    });
  }

  const validStartersCount = currentRank - 1;
  return { validStartersCount, reindexed };
}

/**
 * Minimum completed races required for a division to score ranking points:
 * - World, Youth World & Continental Championships: >= 2 completed races (when valid under event SIs)
 * - Major Internationals, Class Circuit Opens & National Championships: >= 3 completed races
 */
export function minCompletedRacesForCategory(category: X15EventCategory): number {
  switch (category) {
    case "world-championship":
    case "youth-world-championship":
    case "continental-championship":
      return 2;
    case "major-international":
    case "class-circuit-open":
    case "national-championship":
      return 3;
    case "non-scoring":
      return Infinity;
  }
}

/**
 * Minimum valid starters across all X-15 scoring divisions at the event to hold its proposed target grade.
 */
export function minEventStartersForCategory(category: X15EventCategory): number {
  switch (category) {
    case "world-championship":
    case "youth-world-championship":
      return 3;
    case "continental-championship":
      return 15;
    case "major-international":
      return 25;
    case "class-circuit-open":
    case "national-championship":
      return 10;
    case "non-scoring":
      return Infinity;
  }
}

/**
 * Division fleet-size multiplier m(N):
 * - N >= 5: 1.0 (full grade points)
 * - N in {3, 4}: 0.8 (beta small-fleet scaling for emerging regional fleets)
 * - N < 3: 0.0 (visible on profile, 0 ranking points)
 */
export function smallFleetMultiplier(validStarters: number): number {
  if (!Number.isFinite(validStarters) || validStarters < 3) return 0;
  if (validStarters < 5) return 0.8;
  return 1.0;
}

export interface X15PointCalculationInput {
  grade: X15EventGradeValue;
  category: X15EventCategory;
  validStarters: number; // N
  place: number; // P (re-indexed among valid starters)
  completedRaces: number;
  didStartAtLeastOneRace?: boolean;
}

/**
 * Calculates single-event X-15 Global Ranking points rounded to 2 decimal places:
 * Points = E * m(N) * (N - P + 1) / N
 */
export function calculateX15EventPoints(input: X15PointCalculationInput): number {
  const {
    grade,
    category,
    validStarters: N,
    place: P,
    completedRaces,
    didStartAtLeastOneRace = true,
  } = input;

  if (grade === 0 || category === "non-scoring" || !didStartAtLeastOneRace) return 0;
  if (!Number.isInteger(N) || N < 3) return 0;
  if (!Number.isInteger(P) || P < 1 || P > N) return 0;
  if (completedRaces < minCompletedRacesForCategory(category)) return 0;

  const multiplier = smallFleetMultiplier(N);
  const rawPoints = (grade * multiplier * (N - P + 1)) / N;
  return Math.round(rawPoints * 100) / 100;
}

export interface X15RiderResultCandidate {
  eventId: string;
  eventSlug: string;
  eventName: string;
  division: X15RankingDivisionKey;
  eventEndDate: string; // YYYY-MM-DD
  grade: X15EventGradeValue;
  category: X15EventCategory;
  points: number;
  reindexedPlace: number;
  officialPlace: number;
  validStarters: number;
  isValidChampionship?: boolean; // defaults to true; if false (e.g. cancelled/invalid), cannot count
  isProvisional?: boolean;
}

export interface X15RiderRollingSeriesSummary {
  division: X15RankingDivisionKey;
  totalPoints: number;
  eventsCounted: number;
  countedEvents: X15RiderResultCandidate[];
  excludedEvents: Array<{
    candidate: X15RiderResultCandidate;
    reason:
      | "zero-points"
      | "invalid-championship"
      | "expired-12m"
      | "expired-24m-worlds"
      | "replaced-by-subsequent-worlds"
      | "surpassed-by-better-combination";
  }>;
  hasProvisionalResults: boolean;
  betaNotice: string;
}

export const X15_BETA_RANKING_NOTICE =
  "Beta Notice: Global ranking totals reflect a combination of competitive performance and rider access to pre-designated international events. Standings will evolve as regional calendar density expands.";

function addMonthsIso(isoDate: string, months: number): string {
  const [y, m, d] = isoDate.split("-").map(Number);
  const dt = new Date(Date.UTC(y, m - 1 + months, d));
  return dt.toISOString().slice(0, 10);
}

/**
 * Computes a rider's rolling series score for a specific ranking ladder:
 * - Best 6 eligible results (max 1x200, max 2x100, remaining up to 6 filled by 50).
 * - System automatically selects the combination that yields the highest total points.
 * - Rider-specific Worlds rollover: rider counts their most recent eligible Worlds in this division
 *   for up to 24 months. Competing in a subsequent valid Worlds in this division immediately replaces
 *   the prior Worlds result (even if lower).
 * - Standard 12-month expiry for Grade 100 & Grade 50 results.
 */
export function computeX15RiderRollingSeries(
  candidates: readonly X15RiderResultCandidate[],
  asOfDate: string,
  division: X15RankingDivisionKey,
): X15RiderRollingSeriesSummary {
  const divisionCandidates = candidates.filter((c) => c.division === division && c.eventEndDate <= asOfDate);
  const excludedEvents: X15RiderRollingSeriesSummary["excludedEvents"] = [];

  // Filter basic validity
  const validCandidates: X15RiderResultCandidate[] = [];
  for (const c of divisionCandidates) {
    if (c.points <= 0 || c.grade === 0) {
      excludedEvents.push({ candidate: c, reason: "zero-points" });
      continue;
    }
    if (c.isValidChampionship === false) {
      excludedEvents.push({ candidate: c, reason: "invalid-championship" });
      continue;
    }
    validCandidates.push(c);
  }

  // Handle rider-specific Worlds replacement
  // "A rider may count their most recent eligible Worlds result for that division, for up to 24 months.
  // When that rider competes in a subsequent eligible Worlds in the same division, the new result replaces
  // their previous Worlds result, even if it is lower."
  const worldsList = validCandidates
    .filter((c) => c.grade === 200)
    .sort((a, b) => a.eventEndDate.localeCompare(b.eventEndDate)); // chronological order

  let eligibleWorlds: X15RiderResultCandidate | null = null;
  if (worldsList.length > 0) {
    // The most recent valid Worlds this rider competed in
    const latestWorlds = worldsList[worldsList.length - 1];
    // Any prior Worlds they competed in are replaced
    for (let i = 0; i < worldsList.length - 1; i++) {
      excludedEvents.push({ candidate: worldsList[i], reason: "replaced-by-subsequent-worlds" });
    }

    // Check 24-month expiry on the latest Worlds
    const worldsExpiry = addMonthsIso(latestWorlds.eventEndDate, 24);
    if (asOfDate > worldsExpiry) {
      excludedEvents.push({ candidate: latestWorlds, reason: "expired-24m-worlds" });
    } else {
      eligibleWorlds = latestWorlds;
    }
  }

  // Filter 12-month expiry for Grade 100 and Grade 50
  const eligibleGrade100: X15RiderResultCandidate[] = [];
  const eligibleGrade50: X15RiderResultCandidate[] = [];

  for (const c of validCandidates) {
    if (c.grade === 200) continue; // Handled above
    const expiry = addMonthsIso(c.eventEndDate, 12);
    if (asOfDate > expiry) {
      excludedEvents.push({ candidate: c, reason: "expired-12m" });
      continue;
    }
    if (c.grade === 100) eligibleGrade100.push(c);
    if (c.grade === 50) eligibleGrade50.push(c);
  }

  // Sort candidates by points descending
  eligibleGrade100.sort((a, b) => b.points - a.points || b.eventEndDate.localeCompare(a.eventEndDate));
  eligibleGrade50.sort((a, b) => b.points - a.points || b.eventEndDate.localeCompare(a.eventEndDate));

  // Combinatorial selection to maximize total points:
  // - at most one Grade 200
  // - at most two Grade 100
  // - remaining up to 6 filled by Grade 50
  let bestSum = -1;
  let bestCounted: X15RiderResultCandidate[] = [];

  const includeWorldsOptions = eligibleWorlds ? [true, false] : [false];

  for (const incWorlds of includeWorldsOptions) {
    const worldsCount = incWorlds ? 1 : 0;
    const maxG100Count = Math.min(2, eligibleGrade100.length);

    for (let g100Count = 0; g100Count <= maxG100Count; g100Count++) {
      const remainingSlots = 6 - worldsCount - g100Count;
      const g50Count = Math.min(remainingSlots, eligibleGrade50.length);

      const candidateSet: X15RiderResultCandidate[] = [];
      if (incWorlds && eligibleWorlds) candidateSet.push(eligibleWorlds);
      candidateSet.push(...eligibleGrade100.slice(0, g100Count));
      candidateSet.push(...eligibleGrade50.slice(0, g50Count));

      const sum = Math.round(candidateSet.reduce((acc, c) => acc + c.points, 0) * 100) / 100;
      if (sum > bestSum) {
        bestSum = sum;
        bestCounted = candidateSet;
      }
    }
  }

  // Find remaining eligible events that were not counted
  const countedSet = new Set(bestCounted);
  const eligiblePool = [
    ...(eligibleWorlds ? [eligibleWorlds] : []),
    ...eligibleGrade100,
    ...eligibleGrade50,
  ];

  for (const c of eligiblePool) {
    if (!countedSet.has(c)) {
      excludedEvents.push({ candidate: c, reason: "surpassed-by-better-combination" });
    }
  }

  // Sort counted events by points descending
  bestCounted.sort((a, b) => b.points - a.points || b.eventEndDate.localeCompare(a.eventEndDate));

  const totalPoints = Math.max(0, bestSum);
  const hasProvisionalResults = bestCounted.some((c) => Boolean(c.isProvisional));

  return {
    division,
    totalPoints,
    eventsCounted: bestCounted.length,
    countedEvents: bestCounted,
    excludedEvents,
    hasProvisionalResults,
    betaNotice: X15_BETA_RANKING_NOTICE,
  };
}
