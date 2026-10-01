/**
 * Labels for the profile rank so a visitor can tell an official-list
 * place from a rank calculated only from recorded results.
 */

export type ProfileBoatClass = "optimist" | "ilca4";

export type RankBasisKind = "official-list" | "recorded-results" | "series";

type StandingLike = {
  overallRank?: number | null;
  fleetSize?: number | null;
  periodLabel?: string | null;
  fleet?: string | null;
  unrestricted?: boolean | null;
  rankBasis?: "official-list" | "recorded-results" | null;
} | null;

export type ProfileRankPresentation = {
  hasRank: boolean;
  /** Spoken form, e.g. "12 of 36". */
  rankLabel: string;
  rank: number | null;
  fleetSize: number | null;
  /** Short basis next to the figure. */
  basisLabel: string;
  /** One-sentence explanation for the info control. */
  basisDetail: string;
  /** Series or cutoff, without repeating the basis. */
  cycleLabel: string;
  emptyMessage: string;
};

export function rankBasisKind(
  standing: StandingLike,
  boatClass: ProfileBoatClass
): RankBasisKind {
  if (boatClass !== "ilca4") return "series";
  if (
    standing?.rankBasis === "recorded-results" ||
    standing?.unrestricted === true
  ) {
    return "recorded-results";
  }
  return "official-list";
}

function usableRank(standing: StandingLike): {
  rank: number;
  fleetSize: number;
} | null {
  const rank = Number(standing?.overallRank);
  const fleetSize = Number(standing?.fleetSize);
  if (!Number.isFinite(rank) || rank <= 0) return null;
  if (!Number.isFinite(fleetSize) || fleetSize <= 0) return null;
  return { rank, fleetSize };
}

export function describeProfileRank(input: {
  standing: StandingLike;
  boatClass: ProfileBoatClass;
}): ProfileRankPresentation {
  const { standing, boatClass } = input;
  const kind = rankBasisKind(standing, boatClass);
  const numbers = usableRank(standing);
  const className = boatClass === "ilca4" ? "ILCA 4" : "Optimist";
  const rawCycle = String(standing?.periodLabel || "").trim();
  const cycleLabel =
    rawCycle.replace(/^ILCA\s*4\s*·\s*/i, "").trim() || "This series";

  const basisLabel =
    kind === "recorded-results"
      ? "Recorded results"
      : kind === "official-list"
        ? "Official national list"
        : standing?.fleet
          ? `${standing.fleet} fleet series`
          : "Series ranking";

  const basisDetail =
    kind === "recorded-results"
      ? "Calculated from recorded ILCA 4 results. This sailor is not on the managed national ranking list."
      : kind === "official-list"
        ? "Place on the managed ILCA 4 national ranking list for this series."
        : "Optimist series rank for this ranking cycle.";

  return {
    hasRank: numbers != null,
    rankLabel: numbers ? `${numbers.rank} of ${numbers.fleetSize}` : "",
    rank: numbers?.rank ?? null,
    fleetSize: numbers?.fleetSize ?? null,
    basisLabel,
    basisDetail,
    cycleLabel,
    emptyMessage: `No ranked ${className} results for this series yet.`,
  };
}
