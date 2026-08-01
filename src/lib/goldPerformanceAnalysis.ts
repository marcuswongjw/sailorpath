/**
 * Gold-fleet performance comparison by series half-year.
 *
 * Immediate post-promotion form = 1st + 2nd series halves after gold entry.
 * Current form = current series half (Singapore calendar).
 * Ranking regattas only (countsForRanking !== false).
 */

import { ageYears } from "@/lib/age";
import {
  currentPeriodFromSgToday,
  periodHalfFromYmd,
} from "@/lib/datesSg";
import {
  calculateRankings,
  periodLabel,
  previousPeriod,
  type Period,
  type RankedSailor,
  type RegattaRecord,
  type RegattaResultRecord,
  type SailorRecord,
} from "@/lib/ranking";

export type AnalysisSailor = {
  id: string;
  name: string;
  gender?: string | null;
  dob?: string | Date | null;
  goldEntryDate?: string | Date | null;
  silverEntryDate?: string | Date | null;
  dropDate?: string | Date | null;
  currentFleet?: string | null;
  club?: string | null;
  sailNumber?: string | null;
  handle?: string | null;
};

export type AnalysisRegatta = {
  id: string;
  name: string;
  slug?: string | null;
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
  totalScore?: number | null;
  isDns?: boolean | null;
  isOverseasCommitment?: boolean | null;
};

export type HalfForm = {
  period: Period;
  periodLabel: string;
  /** Best 3 of 5 sum (lower better); null if no scoring window */
  best3of5: number | null;
  /** Series rank within Gold for that half; null if not ranked */
  seriesRank: number | null;
  fleetSize: number | null;
  /** How many ranking slots in the scoring window had a real result */
  eventsSailed: number;
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
  /** First series half containing / after gold entry */
  half1: HalfForm | null;
  /** Second series half after promotion */
  half2: HalfForm | null;
  /** Current Singapore series half */
  currentHalf: HalfForm | null;
  /** Average of half1 + half2 best3of5 (immediate post-promo form) */
  immediateBest3Avg: number | null;
  /** Current half best3of5 */
  currentBest3: number | null;
  /** Average of half1 + half2 series ranks */
  immediateRankAvg: number | null;
  currentSeriesRank: number | null;
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

/** Next half after a period (Jan–Jun → Jul–Dec same year, etc.). */
export function nextPeriod(period: Period): Period {
  if (period.half === "Jan-Jun") {
    return { year: period.year, half: "Jul-Dec" };
  }
  return { year: period.year + 1, half: "Jan-Jun" };
}

/**
 * First series half for post-promo analysis = half that contains gold entry
 * (entries are half-boundaries, so this is the promotion half).
 */
export function firstPostPromoPeriod(goldEntryYmd: string): Period | null {
  return periodHalfFromYmd(goldEntryYmd);
}

function toRegattaRecords(regattas: AnalysisRegatta[]): RegattaRecord[] {
  return regattas.map((r) => ({
    id: r.id,
    name: r.name,
    slug: r.slug || r.id,
    date: ymd(r.date),
    totalFleetSize: r.totalFleetSize ?? 50,
    division: r.division ?? "Gold",
    boatClass: r.boatClass ?? "Optimist",
    countsForRanking: r.countsForRanking !== false,
  }));
}

function toResultRecords(results: AnalysisResult[]): RegattaResultRecord[] {
  return results.map((r) => ({
    sailorId: r.sailorId,
    regattaId: r.regattaId,
    rank: r.rank,
    nettScore: r.nettScore,
    totalScore: r.totalScore,
    isDns: r.isDns,
    isOverseasCommitment: r.isOverseasCommitment,
  }));
}

function toSailorRecords(sailors: AnalysisSailor[]): SailorRecord[] {
  return sailors.map((s) => ({
    id: s.id,
    name: s.name,
    handle: s.handle || s.id,
    sailNumber: s.sailNumber || "",
    club: s.club || "",
    goldEntryDate: ymd(s.goldEntryDate) || null,
    silverEntryDate: ymd(s.silverEntryDate) || null,
    dropDate: ymd(s.dropDate) || null,
    currentFleet: s.currentFleet ?? "Series",
    dob: ymd(s.dob) || null,
    gender: s.gender,
  }));
}

/**
 * Gold series standing for one half: ranking regattas only via calculateRankings.
 */
export function goldHalfForm(
  sailorId: string,
  period: Period,
  allSailors: AnalysisSailor[],
  regattas: AnalysisRegatta[],
  results: AnalysisResult[]
): HalfForm {
  const label = periodLabel(period);
  const empty: HalfForm = {
    period,
    periodLabel: label,
    best3of5: null,
    seriesRank: null,
    fleetSize: null,
    eventsSailed: 0,
  };

  const sailorRecs = toSailorRecords(allSailors);
  const regRecs = toRegattaRecords(regattas);
  const resRecs = toResultRecords(results);

  // Only sailors who can be Gold in this period
  const goldPeers = sailorRecs.filter((s) => {
    // Must have gold entry by period end — calculateRankings uses resolveSailorFleet
    return Boolean(s.goldEntryDate || s.silverEntryDate);
  });

  if (!goldPeers.some((s) => s.id === sailorId)) return empty;

  let ranked: RankedSailor[] = [];
  try {
    ranked = calculateRankings(period, goldPeers, regRecs, resRecs).filter(
      (x) => x.fleet === "Gold"
    );
  } catch {
    return empty;
  }

  const me = ranked.find((x) => x.id === sailorId);
  if (!me) return empty;

  const seriesRank = ranked.findIndex((x) => x.id === sailorId) + 1;
  const eventsSailed = (me.regattaScores || []).filter(
    (rs) => !rs.isDNS || rs.isOverseasCommitment
  ).length;

  return {
    period,
    periodLabel: label,
    best3of5: me.overallScore,
    seriesRank: seriesRank > 0 ? seriesRank : null,
    fleetSize: ranked.length,
    eventsSailed,
  };
}

export function buildSailorGoldSeries(
  sailor: AnalysisSailor,
  allSailors: AnalysisSailor[],
  regattas: AnalysisRegatta[],
  results: AnalysisResult[],
  opts?: { asOf?: string }
): SailorGoldSeries | null {
  const gold = ymd(sailor.goldEntryDate);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(gold)) return null;

  const asOf =
    opts?.asOf ||
    new Date().toLocaleDateString("en-CA", { timeZone: "Asia/Singapore" });

  const half1Period = firstPostPromoPeriod(gold);
  if (!half1Period) return null;
  const half2Period = nextPeriod(half1Period);
  const currentPeriod = currentPeriodFromSgToday();

  const half1 = goldHalfForm(
    sailor.id,
    half1Period,
    allSailors,
    regattas,
    results
  );
  const half2 = goldHalfForm(
    sailor.id,
    half2Period,
    allSailors,
    regattas,
    results
  );
  const currentHalf = goldHalfForm(
    sailor.id,
    currentPeriod,
    allSailors,
    regattas,
    results
  );

  const halfScores = [half1.best3of5, half2.best3of5].filter(
    (n): n is number => n != null && Number.isFinite(n)
  );
  const halfRanks = [half1.seriesRank, half2.seriesRank].filter(
    (n): n is number => n != null && Number.isFinite(n)
  );

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
    half1,
    half2,
    currentHalf,
    immediateBest3Avg:
      halfScores.length > 0
        ? Math.round(
            (halfScores.reduce((a, b) => a + b, 0) / halfScores.length) * 10
          ) / 10
        : null,
    currentBest3: currentHalf.best3of5,
    immediateRankAvg:
      halfRanks.length > 0
        ? Math.round(
            (halfRanks.reduce((a, b) => a + b, 0) / halfRanks.length) * 10
          ) / 10
        : null,
    currentSeriesRank: currentHalf.seriesRank,
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
  selected: AnalysisSailor[],
  allSailors: AnalysisSailor[],
  regattas: AnalysisRegatta[],
  results: AnalysisResult[]
): SailorGoldSeries[] {
  return selected
    .map((s) => buildSailorGoldSeries(s, allSailors, regattas, results))
    .filter(Boolean) as SailorGoldSeries[];
}

// re-export for tests / UI
export { previousPeriod, periodLabel };
