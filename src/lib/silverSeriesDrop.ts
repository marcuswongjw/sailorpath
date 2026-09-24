/**
 * Silver / series inactivity drop:
 * If a sailor does not take part in even one Optimist ranking regatta in half N,
 * they are dropped from the national ranking in the next period (drop date =
 * 1 Jul or 1 Jan after the failed half).
 *
 * Applies to Silver-track sailors only. Gold participation uses goldFleetDrop
 * (≥2 Gold ranking regattas per half).
 *
 * Persistence of `sailors.drop_date` is admin-only
 * (`applySilverInactivityDrops` in adminSailorActions). Public ranking reads
 * must never write drop dates.
 *
 * `findSilverInactivityDrops` no-ops when called from `computeFleetRankings`
 * so public ranking reads cannot stamp drop_date; admin calls still detect.
 * Prefer `detectSilverInactivityDrops` in new admin code.
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
import { isExplicitGuest, isInSgSeries } from "@/lib/seriesMembership";
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

/**
 * Series members (or stamped entry dates) only — bare SGP nationality alone
 * is not enough. Guests are never candidates.
 */
export function isSilverInactivityCandidate(s: SailorRecord): boolean {
  if (isExplicitGuest(s)) return false;
  if (isInSgSeries(s)) return true;
  if (s.silverEntryDate || s.goldEntryDate) return true;
  return false;
}

/** Earliest Optimist ranking result date (any division; foothold signal). */
export function earliestOptimistRankingDate(
  sailorId: string,
  regattas: RegattaRecord[],
  results: RegattaResultRecord[]
): string | undefined {
  const regById = new Map(regattas.map((r) => [r.id, r]));
  let earliest: string | undefined;
  for (const res of results) {
    if (res.sailorId !== sailorId) continue;
    const r = regById.get(res.regattaId);
    if (!r) continue;
    if (r.countsForRanking === false) continue;
    if (!regattaMatchesSeriesClass(r, "Optimist")) continue;
    const d = toYmd(r.date);
    if (!d) continue;
    if (!earliest || d < earliest) earliest = d;
  }
  return earliest;
}

/**
 * Silver-track sailors who missed every ranking start in a completed half.
 * Earliest failure only. Does not overwrite an existing earlier drop date.
 * Skips halves where the sailor was Gold (goldFleetDrop owns those).
 *
 * Requires a real foothold (entry stamp or Optimist ranking history) before
 * any half is evaluated — idle Series / SGP profiles are not stamped with
 * ancient drop dates from walking completed halves since 2022.
 *
 * Admin-only consumer: `applySilverInactivityDrops`. Do not call from public
 * ranking reads.
 */
export function detectSilverInactivityDrops(
  sailors: SailorRecord[],
  regattas: RegattaRecord[],
  results: RegattaResultRecord[],
  asOfYmd: string
): SilverDropCandidate[] {
  const periods = completedPeriodsUpTo(asOfYmd);
  const out: SilverDropCandidate[] = [];

  for (const s of sailors) {
    if (!isSilverInactivityCandidate(s)) continue;
    const gold = toYmd(s.goldEntryDate);
    const silver = toYmd(s.silverEntryDate);
    const existingDrop = toYmd(s.dropDate);

    // Already has an Optimist drop — do not overwrite
    if (existingDrop) continue;
    // Active gold track → goldFleetDrop owns participation drops
    if (gold) continue;

    const earliestEntry = [silver, gold].filter(Boolean).sort()[0] as
      | string
      | undefined;
    const historyFoothold = earliestOptimistRankingDate(s.id, regattas, results);
    const foothold = earliestEntry || historyFoothold;
    // No entry stamp and no Optimist history → do not evaluate halves
    if (!foothold) continue;

    for (const period of periods) {
      const { end } = periodBounds(period);

      // Need foothold by period end (do not stamp pre-membership halves)
      if (foothold > end) continue;

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

/**
 * Legacy entry point. Public `computeFleetRankings` may still call this and
 * attempt to persist; when the call stack includes that function, return []
 * so drop_date is never stamped on a ranking read. Admin
 * `applySilverInactivityDrops` calls this outside that stack and gets real
 * candidates (same as `detectSilverInactivityDrops`). Prefer calling detect
 * explicitly from new admin code.
 */
export function findSilverInactivityDrops(
  sailors: SailorRecord[],
  regattas: RegattaRecord[],
  results: RegattaResultRecord[],
  asOfYmd: string
): SilverDropCandidate[] {
  const stack = new Error().stack ?? "";
  if (stack.includes("computeFleetRankings")) {
    return [];
  }
  return detectSilverInactivityDrops(sailors, regattas, results, asOfYmd);
}
