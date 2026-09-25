/**
 * Gold fleet participation rule:
 * If a Gold sailor does not sail in at least 2 ranking Optimist Gold regattas
 * in a six-month period (Jan–Jun or Jul–Dec), they are dropped from Gold.
 *
 * Drop date = first day of the next half (1 Jul or 1 Jan), matching product
 * half-boundary entry/drop conventions.
 */

import { todayYmdSg } from "@/lib/datesSg";
import { withProjectedNextSquadStatus } from "@/lib/optimistSquadPreview";
import {
  periodBounds,
  regattaCountsForRanking,
  regattaMatchesSeriesClass,
  type Period,
  type RankedSailor,
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
    if (!regattaCountsForRanking(r)) return false;
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

/**
 * Gold ("Go") fleet ranking participations in a half.
 * - Plain DNS / never-started = does NOT count.
 * - Overseas commitment representing Singapore DOES count (even if DNS-like
 *   for national points display).
 * Need ≥2 of these per half to stay in Gold.
 */
export function countGoldRankingParticipations(
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
    // Overseas Singapore representation counts as a completed ranking event
    if (Boolean(res.isOverseasCommitment)) {
      n++;
      continue;
    }
    // Plain DNS / no-show / absent = NOT participation
    if (Boolean(res.isDns)) continue;
    n++;
  }
  return n;
}

/** @deprecated use countGoldRankingParticipations */
function sailedRankingCount(
  sailorId: string,
  period: Period,
  regattas: RegattaRecord[],
  results: RegattaResultRecord[]
): number {
  return countGoldRankingParticipations(sailorId, period, regattas, results);
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

function regattaYmd(regatta: RegattaRecord): string {
  return String(regatta.date || "").slice(0, 10);
}

/**
 * Gold starts already sailed in this half, and ranking regattas still ahead.
 * A sailor is Drop when starts so far plus regattas still to come cannot
 * reach 2. Zero starts with one regatta left is Drop: the last event can
 * only make it one.
 */
export function goldParticipationOutlook(
  sailorId: string,
  period: Period,
  regattas: RegattaRecord[],
  results: RegattaResultRecord[],
  asOfYmd: string
): { soFar: number; remaining: number; meetsMinimum: boolean } {
  const events = rankingGoldRegattasInPeriod(period, regattas);
  const held = events.filter((regatta) => regattaYmd(regatta) <= asOfYmd);
  const remaining = events.length - held.length;
  const soFar = countGoldRankingParticipations(
    sailorId,
    period,
    held,
    results
  );
  return {
    soFar,
    remaining,
    meetsMinimum: soFar + remaining >= GOLD_MIN_RANKING_REGATTAS_PER_HALF,
  };
}

/**
 * Proj. Squad for the next half.
 * Sailors who cannot reach 2 Gold ranking starts are "Drop" and do not take
 * a Nat A or Nat B place. Everyone else is projected from the remaining order.
 */
export function applyProjectedGoldParticipationDropped(
  ranked: RankedSailor[],
  period: Period,
  regattas: RegattaRecord[],
  results: RegattaResultRecord[],
  asOfYmd?: string
): RankedSailor[] {
  const asOf = asOfYmd || todayYmdSg();
  const dropIds = new Set(
    ranked
      .filter(
        (sailor) =>
          !goldParticipationOutlook(
            sailor.id,
            period,
            regattas,
            results,
            asOf
          ).meetsMinimum
      )
      .map((sailor) => sailor.id)
  );
  const projected = withProjectedNextSquadStatus(
    ranked.filter((sailor) => !dropIds.has(sailor.id)),
    period
  );
  const statusById = new Map(
    projected.map((sailor) => [sailor.id, sailor.nextPeriodSquadStatus])
  );
  return ranked.map((sailor) => ({
    ...sailor,
    nextPeriodSquadStatus: dropIds.has(sailor.id)
      ? "Drop"
      : (statusById.get(sailor.id) ?? null),
  }));
}
