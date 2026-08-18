/**
 * Silver / series inactivity drop:
 * If a sailor does not take part in even one Optimist ranking regatta in half N,
 * they are dropped from the national ranking in the next period (drop date =
 * 1 Jul or 1 Jan after the failed half).
 *
 * Applies to Silver-track sailors only. Gold participation uses goldFleetDrop
 * (≥2 Gold ranking regattas per half).
 */

import { completedPeriodsUpTo } from "@/lib/goldFleetDrop";
import {
  periodBounds,
  regattaMatchesSeriesClass,
  type Period,
  type RegattaRecord,
  type RegattaResultRecord,
  type SailorRecord,
} from "@/lib/ranking";
import {
  isExplicitGuest,
  isInSgSeries,
  isSgpNationality,
} from "@/lib/seriesMembership";
import { toYmd } from "@/lib/datesSg";

export type SilverDropCandidate = {
  sailorId: string;
  name: string;
  failedPeriod: Period;
  /** Suggested Optimist drop date (half boundary after failed period) */
  dropDate: string;
};

function periodAfter(period: Period): { dropDate: string } {
  if (period.half === "Jan-Jun") {
    return { dropDate: `${period.year}-07-01` };
  }
  return { dropDate: `${period.year + 1}-01-01` };
}

/** Non-DNS Optimist ranking starts in a half (DNS does not count as taking part). */
export function countOptimistRankingStartsInPeriod(
  sailorId: string,
  period: Period,
  regattas: RegattaRecord[],
  results: RegattaResultRecord[]
): number {
  const { start, end } = periodBounds(period);
  const eventIds = new Set(
    regattas
      .filter((r) => {
        if (r.countsForRanking === false) return false;
        if (!regattaMatchesSeriesClass(r, "Optimist")) return false;
        const d = String(r.date || "").slice(0, 10);
        if (!/^\d{4}-\d{2}-\d{2}$/.test(d)) return false;
        if (d < start || d > end) return false;
        const div = r.division || "Gold";
        if (div === "Open" || div === "Fleet" || div === "NonRanking") {
          return false;
        }
        // Silver track: Silver, Both, or Gold (sailed gold still counts as a start)
        return (
          div === "Silver" ||
          div === "Both" ||
          div === "Gold" ||
          /\bsilver\b/i.test(div) ||
          /\bgold\b/i.test(div)
        );
      })
      .map((r) => r.id)
  );
  let n = 0;
  for (const res of results) {
    if (res.sailorId !== sailorId) continue;
    if (!eventIds.has(res.regattaId)) continue;
    if (Boolean(res.isDns)) continue;
    n++;
  }
  return n;
}

function isSeriesCandidate(s: SailorRecord): boolean {
  if (isExplicitGuest(s)) return false;
  if (isInSgSeries(s)) return true;
  if (s.silverEntryDate || s.goldEntryDate) return true;
  if (isSgpNationality(s.nationality)) return true;
  return false;
}

/**
 * Silver-track sailors who missed every ranking start in a completed half.
 * Earliest failure only. Does not overwrite an existing earlier drop date.
 * Skips halves where the sailor was Gold (goldFleetDrop owns those).
 */
export function findSilverInactivityDrops(
  sailors: SailorRecord[],
  regattas: RegattaRecord[],
  results: RegattaResultRecord[],
  asOfYmd: string
): SilverDropCandidate[] {
  const periods = completedPeriodsUpTo(asOfYmd);
  const out: SilverDropCandidate[] = [];

  for (const s of sailors) {
    if (!isSeriesCandidate(s)) continue;
    const gold = toYmd(s.goldEntryDate);
    const silver = toYmd(s.silverEntryDate);
    const existingDrop = toYmd(s.dropDate);

    // Already has an Optimist drop — do not overwrite
    if (existingDrop) continue;
    // Active gold track → goldFleetDrop owns participation drops
    if (gold) continue;

    for (const period of periods) {
      const { end } = periodBounds(period);

      // Need some series foothold by period end (entry stamp or series member)
      const earliestEntry = [silver, gold].filter(Boolean).sort()[0] as
        | string
        | undefined;
      if (earliestEntry && earliestEntry > end) continue;
      if (
        !earliestEntry &&
        !isInSgSeries(s) &&
        !isSgpNationality(s.nationality)
      ) {
        continue;
      }

      const starts = countOptimistRankingStartsInPeriod(
        s.id,
        period,
        regattas,
        results
      );
      if (starts >= 1) continue;

      const { dropDate } = periodAfter(period);
      if (dropDate > asOfYmd) continue;

      out.push({
        sailorId: s.id,
        name: s.name,
        failedPeriod: period,
        dropDate,
      });
      break;
    }
  }

  return out;
}
