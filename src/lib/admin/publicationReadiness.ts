import {
  MIN_RACES_FOR_RANKING,
  regattaCountsForRanking,
} from "@/lib/ranking";

export type ReadinessSummary =
  | "blocked"
  | "incomplete"
  | "publishable_non_ranking"
  | "publishable_ranking";

export type ReadinessSeverity = "ok" | "warning" | "incomplete" | "blocked";

export type ReadinessCheck = {
  code: string;
  label: string;
  severity: ReadinessSeverity;
  field?: string;
};

export type PublicationReadiness = {
  summary: ReadinessSummary;
  checks: ReadinessCheck[];
};

const SUMMARY_ORDER: ReadinessSummary[] = [
  "blocked",
  "incomplete",
  "publishable_non_ranking",
  "publishable_ranking",
];

function summarize(checks: ReadinessCheck[]): ReadinessSummary {
  if (checks.some((check) => check.severity === "blocked")) return "blocked";
  if (checks.some((check) => check.severity === "incomplete")) return "incomplete";
  if (!regattaCountsForRankingFromChecks(checks)) return "publishable_non_ranking";
  return "publishable_ranking";
}

function regattaCountsForRankingFromChecks(checks: ReadinessCheck[]): boolean {
  return checks.every(
    (check) => check.code !== "ranking-excluded" && check.severity !== "blocked"
  );
}

export function publicationReadiness(input: {
  name?: string | null;
  date?: string | null;
  boatClass?: string | null;
  division?: string | null;
  totalFleetSize?: number | null;
  raceCount?: number | null;
  countsForRanking?: boolean | null;
  resultCount?: number | null;
  status?: string | null;
}): PublicationReadiness {
  const checks: ReadinessCheck[] = [];
  const name = String(input.name || "").trim();
  const date = String(input.date || "").slice(0, 10);
  const boatClass = String(input.boatClass || "").trim();
  const division = String(input.division || "").trim();

  if (input.status === "archived") {
    checks.push({
      code: "archived",
      label: "This class is archived and cannot be published.",
      severity: "blocked",
      field: "status",
    });
  }
  if (date && !/^\d{4}-\d{2}-\d{2}$/.test(date)) {
    checks.push({
      code: "date-invalid",
      label: "The event date is not a valid calendar date.",
      severity: "blocked",
      field: "date",
    });
  }

  if (!name) {
    checks.push({
      code: "name-missing",
      label: "Event name is missing.",
      severity: "incomplete",
      field: "name",
    });
  }
  if (!date) {
    checks.push({
      code: "date-missing",
      label: "Event date is missing.",
      severity: "incomplete",
      field: "date",
    });
  }
  if (!boatClass) {
    checks.push({
      code: "class-missing",
      label: "Sailing class is missing.",
      severity: "incomplete",
      field: "boatClass",
    });
  }
  if (!division) {
    checks.push({
      code: "division-missing",
      label: "Division is missing.",
      severity: "incomplete",
      field: "division",
    });
  }
  if (input.totalFleetSize == null || input.totalFleetSize <= 0) {
    checks.push({
      code: "fleet-size-missing",
      label: "Fleet size is missing.",
      severity: "incomplete",
      field: "totalFleetSize",
    });
  }
  if (input.raceCount == null) {
    checks.push({
      code: "race-count-unknown",
      label: "Race count is unknown. Enter 0 if no races were completed.",
      severity: "incomplete",
      field: "raceCount",
    });
  }
  // A confirmed zero-race class has no score rows by definition and is still
  // complete enough to publish as non-ranking. Once a race exists, results
  // are required before publication.
  if (input.raceCount !== 0 && (input.resultCount ?? 0) <= 0) {
    checks.push({
      code: "results-missing",
      label: "No results have been entered for this class.",
      severity: "incomplete",
      field: "results",
    });
  }

  const ranks = regattaCountsForRanking({
    countsForRanking: input.countsForRanking,
    raceCount: input.raceCount,
  });
  if (!ranks) {
    const few =
      input.raceCount != null && input.raceCount < MIN_RACES_FOR_RANKING;
    checks.push({
      code: "ranking-excluded",
      label: few
        ? `${input.raceCount} completed race(s). Ranking needs at least ${MIN_RACES_FOR_RANKING}, so this class is non-ranking.`
        : "This class is marked non-ranking.",
      severity: "warning",
      field: "countsForRanking",
    });
  } else {
    checks.push({
      code: "ranking-eligible",
      label: "Scoring rules include this class in the rankings.",
      severity: "ok",
      field: "countsForRanking",
    });
  }

  const summary = summarize(checks);
  if (!SUMMARY_ORDER.includes(summary)) {
    return { summary: "incomplete", checks };
  }
  return { summary, checks };
}
