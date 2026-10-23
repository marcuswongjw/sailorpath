import type { PublicClassRegattaRow } from "@/lib/publicDataLoader";

/**
 * Shared presentation contract for board and foil disciplines.
 *
 * The canonical class registry remains the authority for input aliases and
 * classification. This module defines the product-level language that public
 * and admin surfaces use once a class has been resolved.
 */
export const BOARD_CLASS_KEYS = ["wingfoil", "techno293", "iqfoil"] as const;

export type BoardClassKey = (typeof BOARD_CLASS_KEYS)[number];

export type BoardClassDefinition = {
  key: BoardClassKey;
  label: string;
  publicHref: string;
  calendarHref: string;
  summary: string;
  policyLabel: string;
  policyDescription: string;
  hasSpecialistScorecards: boolean;
  hasSeriesStandings: boolean;
  hasClassSpecifications: boolean;
};

export const BOARD_CLASS_DEFINITIONS: Record<
  BoardClassKey,
  BoardClassDefinition
> = {
  wingfoil: {
    key: "wingfoil",
    label: "WingFoil",
    publicHref: "/sg/wingfoil",
    calendarHref: "/calendar?class=wingfoil",
    summary: "Singapore WingFoil event results, race scorecards, and series standings.",
    policyLabel: "Event results and series",
    policyDescription:
      "Browse event results and series standings. SailorPath does not publish a national ranking for this class.",
    hasSpecialistScorecards: true,
    hasSeriesStandings: true,
    hasClassSpecifications: false,
  },
  techno293: {
    key: "techno293",
    label: "Techno 293",
    publicHref: "/sg/techno293",
    calendarHref: "/calendar?class=techno293",
    summary: "Singapore Techno 293 event results, monsoon-series standings, and class information.",
    policyLabel: "Event results and monsoon series",
    policyDescription:
      "Browse event results and monsoon-series standings. These are separate from national rankings.",
    hasSpecialistScorecards: true,
    hasSeriesStandings: true,
    hasClassSpecifications: true,
  },
  iqfoil: {
    key: "iqfoil",
    label: "iQFOiL",
    publicHref: "/sg/iqfoil",
    calendarHref: "/calendar?class=iqfoil",
    summary: "Singapore iQFOiL event results and race scores.",
    policyLabel: "Published event results",
    policyDescription:
      "Browse published event results. National rankings, selection standings and series standings are not available on SailorPath for this class.",
    hasSpecialistScorecards: false,
    hasSeriesStandings: false,
    hasClassSpecifications: false,
  },
};

export function boardClassDefinition(key: BoardClassKey): BoardClassDefinition {
  return BOARD_CLASS_DEFINITIONS[key];
}

export type BoardClassSourceCounts = {
  canonical: number;
  specialist: number;
};

/**
 * Keep public result discovery honest: canonical class sheets and specialist
 * scorecards are displayed together, but their provenance remains visible.
 * Rows are only de-duplicated when they are literally the same public record.
 * Similar names/dates are deliberately retained for editorial reconciliation.
 */
export function mergeBoardClassResultRows(
  canonicalRows: readonly PublicClassRegattaRow[],
  specialistRows: readonly PublicClassRegattaRow[]
): PublicClassRegattaRow[] {
  const seen = new Set<string>();
  return [...canonicalRows, ...specialistRows]
    .filter((row) => {
      const identity = `${row.source?.kind || "unknown"}:${row.id}`;
      if (seen.has(identity)) return false;
      seen.add(identity);
      return true;
    })
    .sort(
      (a, b) =>
        b.startDate.localeCompare(a.startDate) ||
        a.name.localeCompare(b.name) ||
        a.id.localeCompare(b.id)
    );
}

export function boardClassSourceCounts(
  rows: readonly PublicClassRegattaRow[]
): BoardClassSourceCounts {
  return rows.reduce<BoardClassSourceCounts>(
    (counts, row) => {
      if (row.source?.kind === "normalized_result") counts.canonical += 1;
      if (row.source?.kind === "special_scorecard") counts.specialist += 1;
      return counts;
    },
    { canonical: 0, specialist: 0 }
  );
}
