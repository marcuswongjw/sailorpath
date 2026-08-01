/**
 * Gold-fleet performance comparison utilities.
 *
 * Aligns sailors by ranking-event sequence *after* gold promotion so
 * different promotion dates can be compared fairly.
 */

import { ageYears } from "@/lib/age";

export type AnalysisSailor = {
  id: string;
  name: string;
  gender?: string | null;
  dob?: string | Date | null;
  goldEntryDate?: string | Date | null;
  club?: string | null;
  sailNumber?: string | null;
  handle?: string | null;
};

export type AnalysisRegatta = {
  id: string;
  name: string;
  date: string | Date;
  division?: string | null;
  boatClass?: string | null;
  countsForRanking?: boolean | null;
  totalFleetSize?: number | null;
};

export type AnalysisResult = {
  sailorId: string;
  regattaId: string;
  rank: number;
  nettScore?: number | null;
  isDns?: boolean | null;
  isOverseasCommitment?: boolean | null;
};

export type PostPromoEvent = {
  /** 1-based index of ranking event after gold entry */
  seq: number;
  regattaId: string;
  regattaName: string;
  date: string;
  rank: number;
  nettScore: number | null;
  fleetSize: number | null;
  isDns: boolean;
  isOverseas: boolean;
};

export type SailorGoldSeries = {
  sailorId: string;
  name: string;
  gender: string | null;
  goldEntryDate: string;
  monthsInGold: number;
  age: number | null;
  club: string | null;
  sailNumber: string | null;
  handle: string | null;
  /** Ranking Optimist (or selected class) results on/after gold entry, chronological */
  postPromo: PostPromoEvent[];
  /** Average rank of first `window` post-promo finishes (immediate form) */
  immediateAvgRank: number | null;
  /** Average rank of last `window` post-promo finishes (current form) */
  currentAvgRank: number | null;
  bestPostRank: number | null;
  worstPostRank: number | null;
  lastRank: number | null;
  eventCount: number;
};

function ymd(v: string | Date | null | undefined): string {
  return String(v || "").slice(0, 10);
}

function monthsBetween(fromYmd: string, toYmd: string): number {
  if (!/^\d{4}-\d{2}-\d{2}$/.test(fromYmd) || !/^\d{4}-\d{2}-\d{2}$/.test(toYmd))
    return 0;
  const [fy, fm] = fromYmd.split("-").map(Number);
  const [ty, tm] = toYmd.split("-").map(Number);
  return Math.max(0, (ty - fy) * 12 + (tm - fm));
}

function avg(nums: number[]): number | null {
  if (!nums.length) return null;
  return Math.round((nums.reduce((a, b) => a + b, 0) / nums.length) * 10) / 10;
}

function genderNorm(g: string | null | undefined): string {
  const s = String(g || "")
    .trim()
    .toLowerCase();
  if (!s) return "";
  if (s === "f" || s === "female" || s === "girl" || s === "w" || s === "woman")
    return "F";
  if (s === "m" || s === "male" || s === "boy" || s === "man") return "M";
  return s.toUpperCase().slice(0, 1);
}

export function isGoldFleetSailor(s: AnalysisSailor): boolean {
  const g = ymd(s.goldEntryDate);
  return /^\d{4}-\d{2}-\d{2}$/.test(g);
}

/**
 * Ranking events eligible for gold comparison.
 * Default: Optimist ranking events (boat_class null/empty treated as Optimist legacy).
 */
export function isEligibleGoldRegatta(
  r: AnalysisRegatta,
  opts?: { boatClass?: string }
): boolean {
  if (r.countsForRanking === false) return false;
  const want = (opts?.boatClass || "Optimist").toLowerCase();
  const bc = String(r.boatClass || "Optimist")
    .trim()
    .toLowerCase();
  // Legacy rows often have null boat_class — treat as Optimist
  if (want === "optimist") {
    return !r.boatClass || bc === "optimist" || bc === "";
  }
  return bc === want;
}

export function buildSailorGoldSeries(
  sailor: AnalysisSailor,
  regattas: AnalysisRegatta[],
  results: AnalysisResult[],
  opts?: {
    boatClass?: string;
    window?: number;
    asOf?: string;
  }
): SailorGoldSeries | null {
  const gold = ymd(sailor.goldEntryDate);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(gold)) return null;

  const window = opts?.window ?? 3;
  const asOf =
    opts?.asOf ||
    new Date().toLocaleDateString("en-CA", { timeZone: "Asia/Singapore" });

  const regById = new Map(regattas.map((r) => [r.id, r]));
  const mine = results
    .filter((res) => res.sailorId === sailor.id)
    .map((res) => {
      const reg = regById.get(res.regattaId);
      if (!reg) return null;
      if (!isEligibleGoldRegatta(reg, { boatClass: opts?.boatClass })) return null;
      const d = ymd(reg.date);
      if (d < gold) return null;
      const rank = Number(res.rank);
      if (!Number.isFinite(rank)) return null;
      return {
        regattaId: reg.id,
        regattaName: reg.name,
        date: d,
        rank,
        nettScore:
          res.nettScore != null && Number.isFinite(Number(res.nettScore))
            ? Number(res.nettScore)
            : null,
        fleetSize: reg.totalFleetSize ?? null,
        isDns: Boolean(res.isDns),
        isOverseas: Boolean(res.isOverseasCommitment),
      };
    })
    .filter(Boolean) as Omit<PostPromoEvent, "seq">[];

  mine.sort((a, b) => a.date.localeCompare(b.date));

  const postPromo: PostPromoEvent[] = mine.map((e, i) => ({
    ...e,
    seq: i + 1,
  }));

  const ranks = postPromo.map((e) => e.rank);
  const first = ranks.slice(0, window);
  const last = ranks.slice(-window);

  return {
    sailorId: sailor.id,
    name: sailor.name,
    gender: genderNorm(sailor.gender) || null,
    goldEntryDate: gold,
    monthsInGold: monthsBetween(gold, asOf),
    age: ageYears(sailor.dob ?? null),
    club: sailor.club ?? null,
    sailNumber: sailor.sailNumber ?? null,
    handle: sailor.handle ?? null,
    postPromo,
    immediateAvgRank: avg(first),
    currentAvgRank: avg(last),
    bestPostRank: ranks.length ? Math.min(...ranks) : null,
    worstPostRank: ranks.length ? Math.max(...ranks) : null,
    lastRank: ranks.length ? ranks[ranks.length - 1]! : null,
    eventCount: postPromo.length,
  };
}

export function filterGoldSailors(
  sailors: AnalysisSailor[],
  opts?: { gender?: "all" | "F" | "M" }
): AnalysisSailor[] {
  return sailors
    .filter(isGoldFleetSailor)
    .filter((s) => {
      if (!opts?.gender || opts.gender === "all") return true;
      return genderNorm(s.gender) === opts.gender;
    })
    .sort((a, b) => a.name.localeCompare(b.name));
}

export function seriesForSailors(
  sailors: AnalysisSailor[],
  regattas: AnalysisRegatta[],
  results: AnalysisResult[],
  opts?: { boatClass?: string; window?: number }
): SailorGoldSeries[] {
  return sailors
    .map((s) => buildSailorGoldSeries(s, regattas, results, opts))
    .filter(Boolean) as SailorGoldSeries[];
}
