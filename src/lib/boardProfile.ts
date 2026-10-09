import { ordinal, profileBoatClassGroup } from "@/lib/profileAnalytics";
import { sailingClassKeyOf } from "@/lib/classRegistry";

/** Board classes that can lead a sailor profile. Windsurfing is not WingFoil. */
export const BOARD_DISCIPLINES = [
  "techno293",
  "wingfoil",
  "iqfoil",
  "windsurfing",
] as const;

export type BoardDiscipline = (typeof BOARD_DISCIPLINES)[number];
export type ProfileDiscipline = "optimist" | "ilca4" | BoardDiscipline;

export type BoardResultRow = {
  boatClass?: string | null;
  regattaId?: string | null;
  regattaName?: string | null;
  regattaDate?: string | null;
  rank?: number | null;
  division?: string | null;
  isDns?: boolean;
  isDNS?: boolean;
};

export type BoardClassSummary = {
  discipline: BoardDiscipline;
  label: string;
  seasonYear: number;
  seasonEventCount: number;
  resultCount: number;
  bestFinish: number | null;
  bestFinishLabel: string | null;
  bestFinishEvent: string | null;
  /** Shown only when every recorded division agrees. */
  sharedDivision: string | null;
};

export function isBoardDiscipline(value: string | null | undefined): value is BoardDiscipline {
  return (BOARD_DISCIPLINES as readonly string[]).includes(String(value || ""));
}

/**
 * Techno 293, WingFoil, iQFOiL, and Windsurfing.
 * "wing" must not classify Windsurfing as WingFoil.
 */
export function boardDisciplineOf(
  boatClass: string | null | undefined
): BoardDiscipline | null {
  const classKey = sailingClassKeyOf(boatClass);
  if (classKey === "windsurfing") return "windsurfing";
  if (classKey === "wingfoil") return "wingfoil";
  if (classKey === "iqfoil") return "iqfoil";
  if (classKey === "techno293") return "techno293";
  return null;
}

export function profileDisciplineOf(
  boatClass: string | null | undefined
): ProfileDiscipline | null {
  const board = boardDisciplineOf(boatClass);
  if (board) return board;
  const group = profileBoatClassGroup(boatClass);
  if (group === "optimist" || group === "ilca4") return group;
  return null;
}

export function disciplineLabel(id: ProfileDiscipline): string {
  switch (id) {
    case "optimist":
      return "Optimist";
    case "ilca4":
      return "ILCA 4";
    case "techno293":
      return "Techno 293";
    case "wingfoil":
      return "WingFoil";
    case "iqfoil":
      return "iQFOiL";
    case "windsurfing":
      return "Windsurfing";
  }
}

export function boardClassLabel(
  discipline: BoardDiscipline,
  results: readonly Pick<BoardResultRow, "boatClass">[]
): string {
  if (discipline === "windsurfing") {
    const lt = results.some((row) =>
      /\blt\b/i.test(String(row.boatClass || ""))
    );
    return lt ? "Windsurfing LT" : "Windsurfing";
  }
  return disciplineLabel(discipline);
}

function eventKey(row: BoardResultRow): string {
  const id = String(row.regattaId || "").trim();
  if (id) return `id:${id}`;
  return `name:${String(row.regattaName || "").trim().toLowerCase()}|${String(
    row.regattaDate || ""
  ).slice(0, 10)}`;
}

function resultYear(row: BoardResultRow): number | null {
  const year = Number(String(row.regattaDate || "").slice(0, 4));
  return Number.isFinite(year) && year > 1900 ? year : null;
}

function sharedDivision(results: readonly BoardResultRow[]): string | null {
  const meaningful = new Set<string>();
  for (const row of results) {
    const raw = String(row.division || "").trim();
    if (!raw || /^(open|both|all|—|-)$/i.test(raw)) continue;
    meaningful.add(raw);
  }
  if (meaningful.size !== 1) return null;
  return [...meaningful][0];
}

/**
 * Season events and best finish for one board class.
 * There is no national rank here: a finish is shown only when a result has one.
 */
export function summarizeBoardClass(
  discipline: BoardDiscipline,
  results: readonly BoardResultRow[],
  nowYear?: number
): BoardClassSummary {
  const years = results
    .map(resultYear)
    .filter((year): year is number => year != null);
  const seasonYear =
    years.length > 0
      ? Math.max(...years)
      : nowYear ??
        Number(
          new Date()
            .toLocaleDateString("en-CA", { timeZone: "Asia/Singapore" })
            .slice(0, 4)
        );
  const seasonKeys = new Set<string>();
  for (const row of results) {
    if (resultYear(row) !== seasonYear) continue;
    seasonKeys.add(eventKey(row));
  }

  const finishes = results
    .map((row) => {
      if (row.isDns || row.isDNS) return null;
      const rank = Number(row.rank);
      if (!Number.isFinite(rank) || rank < 1) return null;
      return { rank, name: String(row.regattaName || "").trim(), date: String(row.regattaDate || "") };
    })
    .filter((row): row is { rank: number; name: string; date: string } => row != null)
    .sort((a, b) => a.rank - b.rank || b.date.localeCompare(a.date));
  const best = finishes[0] ?? null;

  return {
    discipline,
    label: boardClassLabel(discipline, results),
    seasonYear,
    seasonEventCount: seasonKeys.size,
    resultCount: results.length,
    bestFinish: best?.rank ?? null,
    bestFinishLabel: best ? ordinal(best.rank) : null,
    bestFinishEvent: best?.name || null,
    sharedDivision: sharedDivision(results),
  };
}

/** Most recent class with a real boat class. Blank classes stay out of this choice. */
export function pickInitialProfileClass(
  results: readonly Pick<BoardResultRow, "boatClass" | "regattaDate">[]
): ProfileDiscipline | null {
  const dated = [...results].sort((a, b) =>
    String(b.regattaDate || "").localeCompare(String(a.regattaDate || ""))
  );
  for (const row of dated) {
    if (!String(row.boatClass || "").trim()) continue;
    const discipline = profileDisciplineOf(row.boatClass);
    if (discipline) return discipline;
  }
  return null;
}
