/**
 * Singapore ILCA 4 / ILCA 6 ranking policy.
 *
 * High Ranking Points: in a fleet of N, 1st = N pts, 2nd = N−1, … last = 1.
 * Series: Best 3 of last 5 ranking regattas (higher sum wins).
 *
 * ILCA 4 national squad (up to 16, age ≤ 17 in intake year), ranked top 25 only:
 * Cutoffs: 30 Jun → July intake; 20 Dec → January intake (next calendar year).
 * Selection order:
 *  1. Top 2 males + top 2 females (overall)
 *  2. Top 2 males + top 2 females aged 16 in intake year
 *  3. Top 4 males + top 4 females aged ≤ 15 in intake year
 * Unfilled slots → next highest ranked same gender (still top 25).
 */

import { ageYears, birthYear } from "@/lib/age";
import { toYmd } from "@/lib/datesSg";
import { isSingleFleetClass } from "@/lib/countries";
import {
  isOnIlca4NationalList,
  isSingaporeNationality,
} from "@/lib/ilca4NationalList";

export type IlcaBoatClass = "ILCA 4" | "ILCA 6";

export type IlcaRegatta = {
  id: string;
  name: string;
  date: string | Date;
  totalFleetSize: number;
  boatClass?: string | null;
  countsForRanking?: boolean | null;
  division?: string | null;
};

export type IlcaResult = {
  sailorId: string;
  regattaId: string;
  rank: number;
  isDns?: boolean | null;
  isOverseasCommitment?: boolean | null;
};

export type IlcaSailor = {
  id: string;
  name: string;
  gender?: string | null;
  dob?: string | Date | null;
  nationality?: string | null;
  sailNumber?: string | null;
  sailNumberIlca4?: string | null;
  club?: string | null;
  handle?: string | null;
};

export type IlcaEventScore = {
  regattaId: string;
  regattaName: string;
  date: string;
  place: number;
  fleetSize: number;
  points: number;
  isDns: boolean;
};

export type IlcaRankedSailor = {
  sailorId: string;
  name: string;
  gender: "M" | "F" | null;
  /** Calendar birth year (public-facing; not age) */
  birthYear: number | null;
  /** Internal: whole years old as of 31 Dec intake year (squad buckets) */
  ageInIntakeYear: number | null;
  nationality: string | null;
  eventScores: IlcaEventScore[];
  /** Best 3 of up to 5 (highest points) */
  bestThreePoints: number[];
  totalPoints: number;
  rank: number;
};

export type SquadPickReason =
  | "top2_overall"
  | "age16"
  | "age15_or_under"
  | "fill_same_gender";

export type SquadSelection = {
  sailorId: string;
  name: string;
  gender: "M" | "F";
  rankingPosition: number;
  ageInIntakeYear: number | null;
  totalPoints: number;
  reason: SquadPickReason;
};

function ymd(v: string | Date | null | undefined): string {
  return String(v || "").slice(0, 10);
}

export function normalizeGender(g: string | null | undefined): "M" | "F" | null {
  const s = String(g || "")
    .trim()
    .toLowerCase();
  if (s === "f" || s === "female" || s === "girl" || s === "w" || s === "woman")
    return "F";
  if (s === "m" || s === "male" || s === "boy" || s === "man") return "M";
  return null;
}

/** Age as of 31 Dec of intake year (year of birth → age in intake year). */
export function ageInIntakeYear(
  dob: string | Date | null | undefined,
  intakeYear: number
): number | null {
  const d = toYmd(dob);
  if (!d) return null;
  return ageYears(d, new Date(`${intakeYear}-12-31T12:00:00`));
}

/**
 * High Ranking Points for a finishing place in a fleet of N.
 * 1st → N, 2nd → N−1, … DNS / invalid → 0.
 */
export function highRankingPoints(
  place: number,
  fleetSize: number,
  opts?: { isDns?: boolean }
): number {
  if (opts?.isDns) return 0;
  const n = Math.max(0, Math.floor(fleetSize));
  const p = Math.floor(place);
  if (!Number.isFinite(n) || n < 1) return 0;
  if (!Number.isFinite(p) || p < 1) return 0;
  if (p > n) return 0;
  return n - p + 1;
}

/** Best 3 (highest) of available points; pad with 0 if fewer than 3. */
export function bestThreeHighPoints(points: number[]): {
  bestThree: number[];
  total: number;
} {
  const sorted = [...points]
    .filter((n) => Number.isFinite(n) && n >= 0)
    .sort((a, b) => b - a);
  const bestThree = sorted.slice(0, 3);
  while (bestThree.length < 3) bestThree.push(0);
  const total = bestThree.reduce((s, x) => s + x, 0);
  return { bestThree, total };
}

export function isIlcaSeriesClass(
  boatClass: string | null | undefined,
  target: IlcaBoatClass
): boolean {
  const a = String(boatClass || "")
    .trim()
    .toLowerCase()
    .replace(/\s+/g, " ");
  const b = target.toLowerCase();
  if (a === b) return true;
  if (target === "ILCA 4" && (a === "ilca4" || a === "laser 4.7" || a === "laser4.7"))
    return true;
  if (target === "ILCA 6" && (a === "ilca6" || a === "laser radial" || a === "radial"))
    return true;
  return false;
}

/**
 * Last 5 ranking regattas for an ILCA class with date ≤ asOf, oldest → newest.
 */
export function ilcaRankingRegattas(
  allRegattas: IlcaRegatta[],
  boatClass: IlcaBoatClass,
  asOfYmd: string
): IlcaRegatta[] {
  const asOf = toYmd(asOfYmd) || asOfYmd;
  return allRegattas
    .filter((r) => {
      if (r.countsForRanking === false) return false;
      if (!isIlcaSeriesClass(r.boatClass, boatClass)) return false;
      const d = ymd(r.date);
      if (!/^\d{4}-\d{2}-\d{2}$/.test(d)) return false;
      if (d > asOf) return false;
      return true;
    })
    .sort((a, b) => ymd(b.date).localeCompare(ymd(a.date)))
    .slice(0, 5)
    .reverse();
}

export function computeIlcaRankings(
  boatClass: IlcaBoatClass,
  asOfYmd: string,
  sailors: IlcaSailor[],
  regattas: IlcaRegatta[],
  results: IlcaResult[],
  opts?: {
    intakeYear?: number;
    /**
     * ILCA 4 only: restrict to official national list (default true).
     * Pass false for unit tests / unrestricted admin preview.
     */
    restrictToNationalList?: boolean;
  }
): IlcaRankedSailor[] {
  const window = ilcaRankingRegattas(regattas, boatClass, asOfYmd);
  if (!window.length) return [];

  const intakeYear =
    opts?.intakeYear ??
    Number((toYmd(asOfYmd) || asOfYmd).slice(0, 4));

  const regById = new Map(window.map((r) => [r.id, r]));
  const sailorIdsWithResults = new Set(
    results
      .filter((r) => regById.has(r.regattaId))
      .map((r) => r.sailorId)
  );

  const useNationalList =
    boatClass === "ILCA 4" && opts?.restrictToNationalList !== false;

  const candidates = sailors.filter((s) => {
    if (!sailorIdsWithResults.has(s.id)) return false;
    if (useNationalList && !isOnIlca4NationalList(s.name)) return false;
    return true;
  });

  const ranked: Omit<IlcaRankedSailor, "rank">[] = candidates.map((s) => {
    const eventScores: IlcaEventScore[] = window.map((reg) => {
      const res = results.find(
        (x) => x.sailorId === s.id && x.regattaId === reg.id
      );
      const fleetSize = Math.max(1, Number(reg.totalFleetSize) || 1);
      const isDns = Boolean(res?.isDns) && !res?.isOverseasCommitment;
      const place = res && !isDns ? Number(res.rank) : fleetSize + 1;
      const points = highRankingPoints(place, fleetSize, { isDns: !res || isDns });
      return {
        regattaId: reg.id,
        regattaName: reg.name,
        date: ymd(reg.date),
        place: res && !isDns ? Number(res.rank) : 0,
        fleetSize,
        points,
        isDns: !res || isDns,
      };
    });
    const { bestThree, total } = bestThreeHighPoints(
      eventScores.map((e) => e.points)
    );
    return {
      sailorId: s.id,
      name: s.name,
      gender: normalizeGender(s.gender),
      birthYear: birthYear(s.dob),
      ageInIntakeYear: ageInIntakeYear(s.dob, intakeYear),
      nationality: s.nationality ?? null,
      eventScores,
      bestThreePoints: bestThree,
      totalPoints: total,
    };
  });

  ranked.sort((a, b) => {
    if (b.totalPoints !== a.totalPoints) return b.totalPoints - a.totalPoints;
    // Tie-break: better best-three sequence
    for (let i = 0; i < 3; i++) {
      const da = a.bestThreePoints[i] ?? 0;
      const db = b.bestThreePoints[i] ?? 0;
      if (db !== da) return db - da;
    }
    return a.name.localeCompare(b.name);
  });

  return ranked.map((r, i) => ({ ...r, rank: i + 1 }));
}

export type IlcaIntakeKind = "july" | "january";

/** Ranking cutoff + intake year for squad selection. */
export function ilcaSquadCutoff(
  kind: IlcaIntakeKind,
  /** Calendar year of the intake (July Y or January Y) */
  intakeYear: number
): { asOf: string; intakeYear: number; label: string } {
  if (kind === "july") {
    return {
      asOf: `${intakeYear}-06-30`,
      intakeYear,
      label: `July ${intakeYear} intake · ranking as of 30 Jun ${intakeYear}`,
    };
  }
  // January intake year Y uses ranking as of 20 Dec of previous year
  const asOfYear = intakeYear - 1;
  return {
    asOf: `${asOfYear}-12-20`,
    intakeYear,
    label: `January ${intakeYear} intake · ranking as of 20 Dec ${asOfYear}`,
  };
}

/**
 * ILCA 4 national squad selection (max 16), from high-points ranking.
 * Only SGP nationals; top 25; birth-year-derived age ≤ 17 in intake year (31 Dec).
 */
export function selectIlca4NationalSquad(
  ranked: IlcaRankedSailor[]
): SquadSelection[] {
  const eligible = ranked
    .filter((r) => r.rank <= 25)
    .filter((r) => isSingaporeNationality(r.nationality))
    .filter((r) => r.gender === "M" || r.gender === "F")
    .filter((r) => r.ageInIntakeYear == null || r.ageInIntakeYear <= 17);

  const picked = new Set<string>();
  const out: SquadSelection[] = [];

  const take = (
    list: IlcaRankedSailor[],
    n: number,
    reason: SquadPickReason
  ) => {
    let taken = 0;
    for (const r of list) {
      if (taken >= n) break;
      if (picked.has(r.sailorId)) continue;
      if (r.gender !== "M" && r.gender !== "F") continue;
      picked.add(r.sailorId);
      out.push({
        sailorId: r.sailorId,
        name: r.name,
        gender: r.gender,
        rankingPosition: r.rank,
        ageInIntakeYear: r.ageInIntakeYear,
        totalPoints: r.totalPoints,
        reason,
      });
      taken++;
    }
    return taken;
  };

  const males = eligible.filter((r) => r.gender === "M");
  const females = eligible.filter((r) => r.gender === "F");

  // 1) Top 2 M + top 2 F overall
  const needM1 = 2 - take(males, 2, "top2_overall");
  const needF1 = 2 - take(females, 2, "top2_overall");

  // 2) Top 2 M + top 2 F aged 16
  const m16 = males.filter((r) => r.ageInIntakeYear === 16);
  const f16 = females.filter((r) => r.ageInIntakeYear === 16);
  const needM2 = 2 - take(m16, 2, "age16");
  const needF2 = 2 - take(f16, 2, "age16");

  // 3) Top 4 M + top 4 F aged ≤ 15
  const m15 = males.filter(
    (r) => r.ageInIntakeYear != null && r.ageInIntakeYear <= 15
  );
  const f15 = females.filter(
    (r) => r.ageInIntakeYear != null && r.ageInIntakeYear <= 15
  );
  const needM3 = 4 - take(m15, 4, "age15_or_under");
  const needF3 = 4 - take(f15, 4, "age15_or_under");

  // Fill unfilled slots by next highest same gender
  const unfilledM = needM1 + needM2 + needM3;
  const unfilledF = needF1 + needF2 + needF3;
  take(males, unfilledM, "fill_same_gender");
  take(females, unfilledF, "fill_same_gender");

  // Cap 16 (should already be)
  return out.slice(0, 16);
}

/** Policy notes for UI */
export const ILCA_POLICY_NOTES = {
  dualSail:
    "Sailors younger than 15 may hold two sail numbers: one Optimist and one ILCA 4. Each is updated from the latest regatta of that class.",
  highPoints:
    "ILCA 4 and ILCA 6 use High Ranking Points: in a fleet of N, 1st earns N points, 2nd earns N−1, and so on. Best 3 of the last 5 ranking regattas (higher total is better).",
  nationalList:
    "Only sailors on the official ILCA 4 national ranking list appear on the public board.",
  squad:
    "ILCA 4 national squad (≤16, SGP nationality only, birth year implies ≤17 in intake year): ranking as of 30 Jun (July intake) or 20 Dec (January intake). From top 25: top 2 M/F overall, then top 2 M/F in the intake-year-16 bucket, then top 4 M/F in ≤15 bucket; fill remaining with next highest same gender.",
} as const;

// Re-export helper used by import notes
export { isSingleFleetClass };
