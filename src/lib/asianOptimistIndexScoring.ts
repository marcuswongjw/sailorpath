import {
  ASIAN_OPTIMIST_INDEX_EVENT,
  createAsianOptimistIndexBaseline,
  type AsianOptimistIndexEntry,
} from "@/lib/asianOptimistIndex";
import {
  asianIndexPoints,
  type AsianIndexGrade,
} from "@/lib/asianOptimistIndexBeta";

/**
 * SailorPath Asian and Oceania Optimist Index — V1 (Beta) scoring release.
 *
 * Scored using the official V1 (Beta) rolling 12-month methodology:
 * Points = E * (N - P + 1) / N for each designated event, selecting the sailor's
 * optimal subset of eligible finishes subject to the 6 published selection limits:
 *   1. At most five results overall.
 *   2. At most two Grade 150 results.
 *   3. At most one World Championship result.
 *   4. At most four Grade 150 and Grade 75 results combined.
 *   5. At most one Grade 75 result per host MNA jurisdiction.
 *   6. At most one Grade 40 result per host MNA jurisdiction per calendar year.
 */
export const ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE = {
  version: "V1 (Beta)",
  name: "SailorPath Asian and Oceania Optimist Index",
  cohortEvent: "2025 Optimist Asian & Oceanian Championship",
  cohortSize: 136,
  maxResultsCounted: 5,
  maxGrade150: 2,
  maxWorlds: 1,
  maxUpperGrade: 4,
  asOf: "18 October 2026",
} as const;

export type AsianOptimistIndexQualifierTier = "international" | "national";

export type AsianOptimistIndexScoredQualifier = {
  id: string;
  shortName: string;
  hostCountry: string;
  hostMna: string;
  fleetSize: number;
  grade: AsianIndexGrade;
  year: number;
  tier: AsianOptimistIndexQualifierTier;
  isWorlds: boolean;
  scoreCap: number;
};

/**
 * Source-verified input table of qualifying events in the rolling window.
 */
export const ASIAN_OPTIMIST_INDEX_SCORED_QUALIFIERS = {
  "lysc-2026-optimist-gold": {
    id: "lysc-2026-optimist-gold",
    shortName: "LYSC",
    hostCountry: "Malaysia",
    hostMna: "MAS",
    fleetSize: 50,
    grade: 75,
    year: 2026,
    tier: "international",
    isWorlds: false,
    scoreCap: 75,
  },
  "langkawi-international-regatta-perdana-2026": {
    id: "langkawi-international-regatta-perdana-2026",
    shortName: "LIRP",
    hostCountry: "Malaysia",
    hostMna: "MAS",
    fleetSize: 59,
    grade: 75,
    year: 2026,
    tier: "international",
    isWorlds: false,
    scoreCap: 75,
  },
  "sysc-2026-gold": {
    id: "sysc-2026-gold",
    shortName: "SYSC",
    hostCountry: "Singapore",
    hostMna: "SGP",
    fleetSize: 106,
    grade: 75,
    year: 2026,
    tier: "international",
    isWorlds: false,
    scoreCap: 75,
  },
  "thailand-international-sailing-championships-2026": {
    id: "thailand-international-sailing-championships-2026",
    shortName: "Thailand Int'l",
    hostCountry: "Thailand",
    hostMna: "THA",
    fleetSize: 65,
    grade: 75,
    year: 2026,
    tier: "international",
    isWorlds: false,
    scoreCap: 75,
  },
  "snsc-gold-sep-26-2026-09-11": {
    id: "snsc-gold-sep-26-2026-09-11",
    shortName: "SNSC",
    hostCountry: "Singapore",
    hostMna: "SGP",
    fleetSize: 83,
    grade: 40,
    year: 2026,
    tier: "national",
    isWorlds: false,
    scoreCap: 40,
  },
} as const satisfies Record<string, AsianOptimistIndexScoredQualifier>;

export type AsianOptimistIndexScoredQualifierId =
  keyof typeof ASIAN_OPTIMIST_INDEX_SCORED_QUALIFIERS;

export type AsianOptimistIndexQualifierResultInput = {
  qualifierId: AsianOptimistIndexScoredQualifierId;
  name: string;
  nationality: string;
  rank: number;
};

/**
 * All source-reviewed qualifying finishes for the cohort as at the release date.
 */
export const ASIAN_OPTIMIST_INDEX_PROVISIONAL_QUALIFIER_RESULTS = [
  {
    qualifierId: "lysc-2026-optimist-gold",
    name: "Yaasin Syahrizan",
    nationality: "MAS",
    rank: 1,
  },
  {
    qualifierId: "lysc-2026-optimist-gold",
    name: "Sitt May Chit Po",
    nationality: "MYA",
    rank: 4,
  },
  {
    qualifierId: "lysc-2026-optimist-gold",
    name: "Khairulilzani Afendy",
    nationality: "MAS",
    rank: 9,
  },
  {
    qualifierId: "lysc-2026-optimist-gold",
    name: "Mia Azrania",
    nationality: "MAS",
    rank: 10,
  },
  {
    qualifierId: "lysc-2026-optimist-gold",
    name: "Gon Yee Zaw",
    nationality: "MYA",
    rank: 34,
  },
  {
    qualifierId: "langkawi-international-regatta-perdana-2026",
    name: "Suthinan Nakpasom",
    nationality: "THA",
    rank: 2,
  },
  {
    // Confirmed full/compact identity; official OPTIMIST.pdf, page 1,
    // rank 4, MAS 119. Retain the original cohort name as the scoring key.
    qualifierId: "langkawi-international-regatta-perdana-2026",
    name: "Khairulilzani Afendy",
    nationality: "MAS",
    rank: 4,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Wenyu Cheng",
    nationality: "CHN",
    rank: 1,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Anya Zahedi",
    nationality: "SGP",
    rank: 3,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Youjia Xu",
    nationality: "CHN",
    rank: 4,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Sorawit Naksuk",
    nationality: "THA",
    rank: 5,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Rachata Sadtrakulwattana",
    nationality: "THA",
    rank: 6,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Alyssa Wong",
    nationality: "SGP",
    rank: 9,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Ethan Low",
    nationality: "SGP",
    rank: 20,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Shringhari Roy",
    nationality: "IND",
    rank: 42,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Siddhi Tandon",
    nationality: "IND",
    rank: 90,
  },
  {
    qualifierId: "thailand-international-sailing-championships-2026",
    name: "Suthinan Nakpasom",
    nationality: "THA",
    rank: 1,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Alyssa Wong",
    nationality: "SGP",
    rank: 1,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Anya Zahedi",
    nationality: "SGP",
    rank: 7,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Rohan Maliah",
    nationality: "HKG",
    rank: 8,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Wenyu Cheng",
    nationality: "CHN",
    rank: 18,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Ethan Low",
    nationality: "SGP",
    rank: 22,
  },
] as const satisfies readonly AsianOptimistIndexQualifierResultInput[];

export type AsianOptimistIndexQualifierScore = {
  qualifier: AsianOptimistIndexScoredQualifier;
  rank: number;
  points: number;
  counted: boolean;
  dropReason?: string;
  /** Backwards compatibility field matching raw points */
  rawScore: number;
  /** Backwards compatibility field matching raw points */
  cappedScore: number;
  /** Backwards compatibility field matching counted points contribution */
  pointsContribution: number;
};

export type AsianOptimistIndexProvisionalEntry = AsianOptimistIndexEntry & {
  provisionalRank: number;
  /** The score is rounded to 2 decimal places for public display; rank uses exact points. */
  provisionalScore: number;
  championshipScore: number;
  championshipPoints: number;
  qualifierPoints: number;
  eligibleStarts: number;
  countedResultsCount: number;
  hostCountryCount: number;
  /** Every verified qualifying finish, shown as a rank in the public table. */
  qualifierResults: AsianOptimistIndexQualifierScore[];
  /** The subset of qualifierResults that contributes to the current score. */
  scoredQualifiers: AsianOptimistIndexQualifierScore[];
};

function identityKey(name: string, nationality: string): string {
  return `${nationality.toUpperCase()}:${name.toLowerCase().replace(/[^a-z0-9]/g, "")}`;
}

function roundScore(value: number): number {
  return Math.round(value * 100) / 100;
}

/**
 * Normalised finish percentage helper preserved for backwards compatibility.
 */
export function normalisedFleetScore(rank: number, fleetSize: number): number {
  if (!Number.isInteger(rank) || !Number.isInteger(fleetSize) || fleetSize < 2) {
    throw new Error("A scored result needs a valid rank and a fleet of at least two sailors.");
  }
  if (rank < 1 || rank > fleetSize) {
    throw new Error("A scored result rank must be inside the final fleet.");
  }

  return (100 * (fleetSize - rank)) / (fleetSize - 1);
}

type CandidateScoredResult = {
  id: string;
  name: string;
  shortName: string;
  grade: AsianIndexGrade;
  starters: number;
  rank: number;
  points: number;
  hostMna: string;
  hostCountry: string;
  year: number;
  isWorlds: boolean;
  qualifierScore?: AsianOptimistIndexQualifierScore;
};

/**
 * Check whether a subset of results satisfies the 6 V1 (Beta) selection limits:
 *   1. <= 5 results overall.
 *   2. <= 2 Grade 150 results.
 *   3. <= 1 World Championship result.
 *   4. <= 4 Grade 150 and Grade 75 results combined.
 *   5. At most 1 Grade 75 result per host MNA.
 *   6. At most 1 Grade 40 result per host MNA per calendar year.
 */
function isValidSubset(subset: CandidateScoredResult[]): boolean {
  if (subset.length > 5) return false;

  const g150 = subset.filter((r) => r.grade === 150).length;
  if (g150 > 2) return false;

  const worlds = subset.filter((r) => r.isWorlds).length;
  if (worlds > 1) return false;

  const upper = subset.filter((r) => r.grade === 150 || r.grade === 75).length;
  if (upper > 4) return false;

  const g75Hosts = new Set<string>();
  for (const r of subset) {
    if (r.grade === 75) {
      if (g75Hosts.has(r.hostMna)) return false;
      g75Hosts.add(r.hostMna);
    }
  }

  const g40HostYears = new Set<string>();
  for (const r of subset) {
    if (r.grade === 40) {
      const key = `${r.hostMna}:${r.year}`;
      if (g40HostYears.has(key)) return false;
      g40HostYears.add(key);
    }
  }

  return true;
}

/**
 * Finds the subset of candidate results that maximizes total points while
 * strictly honoring the 6 selection rules.
 */
function selectOptimalResults(results: CandidateScoredResult[]): CandidateScoredResult[] {
  let bestSubset: CandidateScoredResult[] = [];
  let bestSum = -1;

  function backtrack(idx: number, current: CandidateScoredResult[]) {
    if (isValidSubset(current)) {
      const sum = current.reduce((s, r) => s + r.points, 0);
      if (sum > bestSum) {
        bestSum = sum;
        bestSubset = [...current];
      }
    } else {
      return;
    }

    for (let i = idx; i < results.length; i++) {
      current.push(results[i]);
      backtrack(i + 1, current);
      current.pop();
    }
  }

  backtrack(0, []);
  return bestSubset;
}

/**
 * Calculate the fixed-cohort V1 (Beta) standings.
 *
 * Scored using the official V1 (Beta) points formula:
 *   Points = E * (N - P + 1) / N
 * Optimal combination of up to 5 best results subject to event-grade and host-country caps.
 */
export function createAsianOptimistIndexProvisionalEntries(
  baseline: AsianOptimistIndexEntry[] = createAsianOptimistIndexBaseline(),
  qualifierInputs: readonly AsianOptimistIndexQualifierResultInput[] =
    ASIAN_OPTIMIST_INDEX_PROVISIONAL_QUALIFIER_RESULTS
): AsianOptimistIndexProvisionalEntry[] {
  const qualifiersBySailor = new Map<string, AsianOptimistIndexQualifierScore[]>();

  for (const input of qualifierInputs) {
    const qualifier = ASIAN_OPTIMIST_INDEX_SCORED_QUALIFIERS[input.qualifierId];
    const points = asianIndexPoints(qualifier.grade, qualifier.fleetSize, input.rank);
    const score: AsianOptimistIndexQualifierScore = {
      qualifier,
      rank: input.rank,
      points,
      counted: false,
      rawScore: points,
      cappedScore: points,
      pointsContribution: 0,
    };
    const key = identityKey(input.name, input.nationality);
    qualifiersBySailor.set(key, [...(qualifiersBySailor.get(key) ?? []), score]);
  }

  const scored = baseline.map((entry) => {
    const anchorPoints = asianIndexPoints(
      150,
      ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize,
      entry.overallPlace
    );

    const anchorCandidate: CandidateScoredResult = {
      id: "2025-iod-asian-oceanian",
      name: entry.name,
      shortName: "2025 Asians",
      grade: 150,
      starters: ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize,
      rank: entry.overallPlace,
      points: anchorPoints,
      hostMna: "OMA",
      hostCountry: "Oman",
      year: 2025,
      isWorlds: false,
    };

    const sailorKey = identityKey(entry.name, entry.nationality);
    const sailorQualifiers = qualifiersBySailor.get(sailorKey) ?? [];

    const qualifierCandidates: CandidateScoredResult[] = sailorQualifiers.map((q) => ({
      id: q.qualifier.id,
      name: entry.name,
      shortName: q.qualifier.shortName,
      grade: q.qualifier.grade,
      starters: q.qualifier.fleetSize,
      rank: q.rank,
      points: q.points,
      hostMna: q.qualifier.hostMna,
      hostCountry: q.qualifier.hostCountry,
      year: q.qualifier.year,
      isWorlds: q.qualifier.isWorlds,
      qualifierScore: q,
    }));

    const allCandidates = [anchorCandidate, ...qualifierCandidates];
    const optimalSubset = selectOptimalResults(allCandidates);
    const optimalIds = new Set(optimalSubset.map((r) => r.id));

    // Mark counted status on qualifier results
    const markedQualifiers: AsianOptimistIndexQualifierScore[] = sailorQualifiers.map((q) => {
      const isCounted = optimalIds.has(q.qualifier.id);
      return {
        ...q,
        counted: isCounted,
        pointsContribution: isCounted ? q.points : 0,
        dropReason: isCounted
          ? undefined
          : `Dropped by V1 (Beta) selection limits (e.g. host cap or optimal combination limit)`,
      };
    });

    const scoredQualifiers = markedQualifiers.filter((q) => q.counted);
    const qualifierPoints = scoredQualifiers.reduce((sum, q) => sum + q.points, 0);
    const preciseScore = anchorPoints + qualifierPoints;

    // Distinct host countries across scored qualifiers
    const hostCountryCount = new Set(scoredQualifiers.map((q) => q.qualifier.hostCountry)).size;

    return {
      ...entry,
      provisionalRank: 0,
      provisionalScore: roundScore(preciseScore),
      championshipScore: roundScore(anchorPoints),
      championshipPoints: roundScore(anchorPoints),
      qualifierPoints: roundScore(qualifierPoints),
      eligibleStarts: sailorQualifiers.length,
      countedResultsCount: optimalSubset.length,
      hostCountryCount,
      qualifierResults: [...markedQualifiers].sort(
        (a, b) =>
          a.qualifier.id.localeCompare(b.qualifier.id) ||
          a.rank - b.rank
      ),
      scoredQualifiers,
      preciseScore,
    };
  });

  scored.sort(
    (a, b) =>
      b.preciseScore - a.preciseScore ||
      b.championshipPoints - a.championshipPoints ||
      a.overallPlace - b.overallPlace ||
      a.name.localeCompare(b.name)
  );

  return scored.map((entry, index) => {
    const { preciseScore, ...publicEntry } = entry;
    void preciseScore;
    return { ...publicEntry, provisionalRank: index + 1 };
  });
}
