/**
 * Gold fleet participation rule:
 * If a Gold sailor does not sail in at least 2 ranking Optimist Gold regattas
 * in a six-month period (Jan–Jun or Jul–Dec), they are dropped from Gold.
 *
 * Drop date = first day of the next half (1 Jul or 1 Jan), matching product
 * half-boundary entry/drop conventions.
 */

import {
  periodBounds,
  regattaMatchesSeriesClass,
  type Period,
  type RegattaRecord,
  type RegattaResultRecord,
  type SailorRecord,
} from "@/lib/ranking";
import { isInSgSeries } from "@/lib/seriesMembership";
import { toYmd } from "@/lib/datesSg";

export const GOLD_MIN_RANKING_REGATTAS_PER_HALF = 2;

export type GoldDropCandidate = {
  sailorId: string;
  name: string;
  goldEntryDate: string;
  failedPeriod: Period;
  participationCount: number;
  /** Suggested drop date (half boundary after failed period) */
  dropDate: string;
};

function periodAfter(period: Period): { dropDate: string } {
  if (period.half === "Jan-Jun") {
    return { dropDate: `${period.year}-07-01` };
  }
  return { dropDate: `${period.year + 1}-01-01` };
}

/** Ranking Optimist Gold events in a half-year (not limited to last 5). */
export function rankingGoldRegattasInPeriod(
  period: Period,
  allRegattas: RegattaRecord[]
): RegattaRecord[] {
  const { start, end } = periodBounds(period);
  return allRegattas.filter((r) => {
    if (r.countsForRanking === false) return false;
    if (!regattaMatchesSeriesClass(r, "Optimist")) return false;
    const t = String(r.date || "").slice(0, 10);
    if (!/^\d{4}-\d{2}-\d{2}$/.test(t)) return false;
    if (t < start || t > end) return false;
    const div = r.division || "Gold";
    if (div === "Open" || div === "Fleet" || div === "NonRanking") return false;
    return div === "Gold" || div === "Both";
  });
}

/**
 * Completed halves that have fully ended before `asOfYmd` (SG calendar).
 * Never includes the half that contains `asOfYmd` (current half still in progress).
 * E.g. asOf 2026-08-03 includes Jan–Jun 2026 but not Jul–Dec 2026.
 */
export function completedPeriodsUpTo(asOfYmd: string): Period[] {
  const asOf = toYmd(asOfYmd) || asOfYmd;
  if (!/^\d{4}-\d{2}-\d{2}$/.test(asOf)) return [];
  const y = Number(asOf.slice(0, 4));
  const m = Number(asOf.slice(5, 7));
  const out: Period[] = [];
  // Start from a reasonable year
  for (let year = 2022; year <= y; year++) {
    // Half ends strictly before asOf → fully complete
    if (`${year}-06-30` < asOf) {
      out.push({ year, half: "Jan-Jun" });
    }
    if (`${year}-12-31` < asOf) {
      out.push({ year, half: "Jul-Dec" });
    }
  }
  // Explicitly never include the half that contains asOf (in-progress)
  const currentHalf: Period =
    m <= 6
      ? { year: y, half: "Jan-Jun" }
      : { year: y, half: "Jul-Dec" };
  return out.filter(
    (p) => !(p.year === currentHalf.year && p.half === currentHalf.half)
  );
}

function sailedRankingCount(
  sailorId: string,
  period: Period,
  regattas: RegattaRecord[],
  results: RegattaResultRecord[]
): number {
  const events = rankingGoldRegattasInPeriod(period, regattas);
  const ids = new Set(events.map((e) => e.id));
  let n = 0;
  for (const res of results) {
    if (res.sailorId !== sailorId) continue;
    if (!ids.has(res.regattaId)) continue;
    // DNS still counts as participation (they entered)
    n++;
  }
  return n;
}

/**
 * Find Gold sailors who should be auto-dropped (no drop date yet, or drop after candidate).
 * Only evaluates completed halves on/after their gold entry.
 */
export function findGoldParticipationDrops(
  sailors: SailorRecord[],
  regattas: RegattaRecord[],
  results: RegattaResultRecord[],
  asOfYmd: string
): GoldDropCandidate[] {
  const periods = completedPeriodsUpTo(asOfYmd);
  const out: GoldDropCandidate[] = [];

  for (const s of sailors) {
    if (!isInSgSeries(s)) continue;
    const gold = toYmd(s.goldEntryDate);
    if (!gold) continue;
    const existingDrop = toYmd(s.dropDate);

    // Already dropped in the past relative to evaluation — skip
    // (unless we need to find earliest failure; product: one drop date)

    for (const period of periods) {
      const { end } = periodBounds(period);
      // Must have been gold by end of this period
      if (gold > end) continue;
      // If already dropped before or during this period, not gold for it
      if (existingDrop && existingDrop <= end) continue;

      const count = sailedRankingCount(s.id, period, regattas, results);
      if (count >= GOLD_MIN_RANKING_REGATTAS_PER_HALF) continue;

      const { dropDate } = periodAfter(period);
      // Don't propose a drop in the future relative to asOf
      if (dropDate > asOfYmd) continue;
      // Don't move drop later if already dropped earlier
      if (existingDrop && existingDrop <= dropDate) continue;

      out.push({
        sailorId: s.id,
        name: s.name,
        goldEntryDate: gold,
        failedPeriod: period,
        participationCount: count,
        dropDate,
      });
      // Earliest failure only
      break;
    }
  }

  return out;
}

/** Months in gold from entry to drop (or asOf if still active). */
export function monthsInGoldTenure(
  goldEntryDate: string | null | undefined,
  dropDate: string | null | undefined,
  asOfYmd: string
): number | null {
  const start = toYmd(goldEntryDate);
  if (!start) return null;
  const end = toYmd(dropDate) || toYmd(asOfYmd) || asOfYmd;
  if (!/^\d{4}-\d{2}-\d{2}$/.test(start) || !/^\d{4}-\d{2}-\d{2}$/.test(end))
    return null;
  if (end < start) return 0;
  const [sy, sm] = start.split("-").map(Number);
  const [ey, em] = end.split("-").map(Number);
  return Math.max(0, (ey - sy) * 12 + (em - sm));
}
