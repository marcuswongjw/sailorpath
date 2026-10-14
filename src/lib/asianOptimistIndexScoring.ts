import {
  ASIAN_OPTIMIST_INDEX_EVENT,
  createAsianOptimistIndexBaseline,
  type AsianOptimistIndexEntry,
} from "@/lib/asianOptimistIndex";

/**
 * A transparent bridge release before the 2026 Asian & Oceanian Championship.
 *
 * Eligibility is deliberately fixed to Asian sailors in the verified 2025
 * championship final classification. Once the 2026 championship is final, its
 * official overall result will replace this cohort and championship anchor.
 */
export const ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE = {
  version: "Provisional v1.0",
  name: "2026 Provisional Asian Optimist Index",
  cohortEvent: "2025 Optimist Asian & Oceanian Championship",
  cohortSize: 122,
  anchorWeight: 0.6,
  qualifierWeights: [0.28, 0.08, 0.04],
  asOf: "13 September 2026",
} as const;

export type AsianOptimistIndexQualifierTier = "international" | "national";

export type AsianOptimistIndexScoredQualifier = {
  id: string;
  shortName: string;
  hostCountry: string;
  fleetSize: number;
  tier: AsianOptimistIndexQualifierTier;
  /** National-event performance cannot contribute more than 70 / 100. */
  scoreCap: number;
};

/**
 * This is a source-verified input table, not a directory. Each entry identifies
 * a 2025 cohort sailor by exact normalised name + NOC match only.
 */
export const ASIAN_OPTIMIST_INDEX_SCORED_QUALIFIERS = {
  "langkawi-international-regatta-perdana-2026": {
    id: "langkawi-international-regatta-perdana-2026",
    shortName: "LIRP",
    hostCountry: "Malaysia",
    fleetSize: 59,
    tier: "international",
    scoreCap: 100,
  },
  "sysc-2026-gold": {
    id: "sysc-2026-gold",
    shortName: "SYSC",
    hostCountry: "Singapore",
    fleetSize: 106,
    tier: "national",
    scoreCap: 70,
  },
  "thailand-international-sailing-championships-2026": {
    id: "thailand-international-sailing-championships-2026",
    shortName: "Thailand International",
    hostCountry: "Thailand",
    fleetSize: 65,
    tier: "international",
    scoreCap: 100,
  },
  "snsc-gold-sep-26-2026-09-11": {
    id: "snsc-gold-sep-26-2026-09-11",
    shortName: "SNSC",
    hostCountry: "Singapore",
    fleetSize: 83,
    tier: "national",
    scoreCap: 70,
  },
} as const satisfies Record<string, AsianOptimistIndexScoredQualifier>;

export type AsianOptimistIndexScoredQualifierId = keyof typeof ASIAN_OPTIMIST_INDEX_SCORED_QUALIFIERS;

export type AsianOptimistIndexQualifierResultInput = {
  qualifierId: AsianOptimistIndexScoredQualifierId;
  name: string;
  nationality: string;
  rank: number;
};

/**
 * All source-reviewed qualifying finishes for the fixed 2025 cohort as at the
 * provisional release date. Sail numbers are deliberately not used to match
 * young sailors across events.
 */
export const ASIAN_OPTIMIST_INDEX_PROVISIONAL_QUALIFIER_RESULTS = [
  {
    qualifierId: "langkawi-international-regatta-perdana-2026",
    name: "Suthinan Nakpasom",
    nationality: "THA",
    rank: 2,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Wenyu Cheng",
    nationality: "CHN",
    rank: 1,
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
] as const satisfies readonly AsianOptimistIndexQualifierResultInput[];

export type AsianOptimistIndexQualifierScore = {
  qualifier: AsianOptimistIndexScoredQualifier;
  rank: number;
  rawScore: number;
  cappedScore: number;
  pointsContribution: number;
};

export type AsianOptimistIndexProvisionalEntry = AsianOptimistIndexEntry & {
  provisionalRank: number;
  /** The score is rounded only for public display; rank uses the exact value. */
  provisionalScore: number;
  championshipScore: number;
  championshipPoints: number;
  qualifierPoints: number;
  eligibleStarts: number;
  hostCountryCount: number;
  scoredQualifiers: AsianOptimistIndexQualifierScore[];
};

function identityKey(name: string, nationality: string): string {
  return `${nationality.toUpperCase()}:${name.toLowerCase().replace(/[^a-z0-9]/g, "")}`;
}

function roundScore(value: number): number {
  return Math.round(value * 10) / 10;
}

export function normalisedFleetScore(rank: number, fleetSize: number): number {
  if (!Number.isInteger(rank) || !Number.isInteger(fleetSize) || fleetSize < 2) {
    throw new Error("A scored result needs a valid rank and a fleet of at least two sailors.");
  }
  if (rank < 1 || rank > fleetSize) {
    throw new Error("A scored result rank must be inside the final fleet.");
  }

  return (100 * (fleetSize - rank)) / (fleetSize - 1);
}

function compareQualifierScores(
  a: AsianOptimistIndexQualifierScore,
  b: AsianOptimistIndexQualifierScore
): number {
  return (
    b.cappedScore - a.cappedScore ||
    b.rawScore - a.rawScore ||
    a.rank - b.rank ||
    a.qualifier.id.localeCompare(b.qualifier.id)
  );
}

function bestCountryScores(
  scores: AsianOptimistIndexQualifierScore[]
): AsianOptimistIndexQualifierScore[] {
  const byCountry = new Map<string, AsianOptimistIndexQualifierScore>();

  for (const score of scores) {
    const current = byCountry.get(score.qualifier.hostCountry);
    if (!current || compareQualifierScores(score, current) < 0) {
      byCountry.set(score.qualifier.hostCountry, score);
    }
  }

  return [...byCountry.values()].sort(compareQualifierScores);
}

/**
 * Calculate the fixed-cohort provisional release.
 *
 * Formula: 60% 2025 Asian & Oceanian performance + 28% / 8% / 4% from the
 * sailor's strongest verified qualifying result in distinct host countries.
 * Missing country slots remain zero; points are never redistributed merely for
 * participation. National events have a 70-point event-score ceiling.
 */
export function createAsianOptimistIndexProvisionalEntries(
  baseline: AsianOptimistIndexEntry[] = createAsianOptimistIndexBaseline(),
  qualifierInputs: readonly AsianOptimistIndexQualifierResultInput[] =
    ASIAN_OPTIMIST_INDEX_PROVISIONAL_QUALIFIER_RESULTS
): AsianOptimistIndexProvisionalEntry[] {
  const resultsBySailor = new Map<string, AsianOptimistIndexQualifierScore[]>();

  for (const input of qualifierInputs) {
    const qualifier = ASIAN_OPTIMIST_INDEX_SCORED_QUALIFIERS[input.qualifierId];
    const rawScore = normalisedFleetScore(input.rank, qualifier.fleetSize);
    const cappedScore = Math.min(rawScore, qualifier.scoreCap);
    const score: AsianOptimistIndexQualifierScore = {
      qualifier,
      rank: input.rank,
      rawScore,
      cappedScore,
      pointsContribution: 0,
    };
    const key = identityKey(input.name, input.nationality);
    resultsBySailor.set(key, [...(resultsBySailor.get(key) ?? []), score]);
  }

  const scored = baseline.map((entry) => {
    const championshipScore = normalisedFleetScore(
      entry.overallPlace,
      ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize
    );
    const championshipPoints =
      championshipScore * ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE.anchorWeight;
    const allQualifierScores = resultsBySailor.get(
      identityKey(entry.name, entry.nationality)
    ) ?? [];
    const countryScores = bestCountryScores(allQualifierScores).map((score, index) => ({
      ...score,
      pointsContribution:
        score.cappedScore *
        (ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE.qualifierWeights[index] ?? 0),
    }));
    const qualifierPoints = countryScores.reduce(
      (sum, score) => sum + score.pointsContribution,
      0
    );
    const preciseScore = championshipPoints + qualifierPoints;

    return {
      ...entry,
      provisionalRank: 0,
      provisionalScore: roundScore(preciseScore),
      championshipScore: roundScore(championshipScore),
      championshipPoints: roundScore(championshipPoints),
      qualifierPoints: roundScore(qualifierPoints),
      eligibleStarts: allQualifierScores.length,
      hostCountryCount: countryScores.length,
      scoredQualifiers: countryScores,
      preciseScore,
    };
  });

  scored.sort(
    (a, b) =>
      b.preciseScore - a.preciseScore ||
      a.overallPlace - b.overallPlace ||
      a.name.localeCompare(b.name)
  );

  return scored.map((entry, index) => {
    const { preciseScore, ...publicEntry } = entry;
    void preciseScore;
    return { ...publicEntry, provisionalRank: index + 1 };
  });
}
