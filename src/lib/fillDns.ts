/**
 * @deprecated Creating fill-DNS result rows is removed from admin UX/API.
 * Optimist national DNS scores are computed at ranking time:
 *   Group 1 (on sheet, isDns): starters + 1
 *   Group 2 (not on sheet):    max(sheet place) + 1
 * (`optimistSheetStatsByRegattaId` in `@/lib/ranking`).
 *
 * Helpers remain for diagnostics and the one-time rewrite script.
 */

import {
  resolveSailorFleet,
  rankingRegattasInPeriod,
  periodBounds,
  optimistSheetStatsByRegattaId,
  optimistUnregisteredScore,
  type Period,
  type SailorRecord,
  type RegattaRecord,
  type RegattaResultRecord,
} from "@/lib/ranking";

export type FillDnsPair = {
  sailorId: string;
  sailorName: string;
  regattaId: string;
  regattaName: string;
  /** Group 2 points = max(sheet place) + 1 when sheet has results; else null */
  dnsPoints: number | null;
};

export { periodBounds };

/** Period-only ranking regatta pool (no carry-forward). */
export function rankingRegattasForFleet(
  fleet: "Gold" | "Silver",
  period: Period,
  allRegattas: RegattaRecord[]
): RegattaRecord[] {
  return rankingRegattasInPeriod(fleet, period, allRegattas);
}

/** Active sailors in a fleet for the period (same as ranking board). */
export function activeSailorsForFleet(
  fleet: "Gold" | "Silver",
  period: Period,
  allSailors: SailorRecord[]
): SailorRecord[] {
  const out: SailorRecord[] = [];
  for (const s of allSailors) {
    const res = resolveSailorFleet(s, period);
    if (res?.active && res.fleet === fleet) out.push(s);
  }
  return out;
}

/**
 * Diagnostic: (sailor, regatta) pairs with no result row (Group 2).
 * dnsPoints = max(sheet place) + 1 when the regatta has uploaded results;
 * null when the sheet is empty.
 */
export function missingDnsPairs(args: {
  fleet: "Gold" | "Silver";
  period: Period;
  sailors: SailorRecord[];
  regattas: RegattaRecord[];
  existingKeys: Set<string>;
  /** Optional result rows to derive registered/started per regatta */
  results?: RegattaResultRecord[];
}): FillDnsPair[] {
  const fleetSailors = activeSailorsForFleet(
    args.fleet,
    args.period,
    args.sailors
  );
  const events = rankingRegattasForFleet(
    args.fleet,
    args.period,
    args.regattas
  );
  const statsByRegatta = optimistSheetStatsByRegattaId(args.results || []);
  const pairs: FillDnsPair[] = [];
  for (const s of fleetSailors) {
    for (const r of events) {
      const key = `${s.id}|${r.id}`;
      if (args.existingKeys.has(key)) continue;
      const stats = statsByRegatta.get(r.id);
      pairs.push({
        sailorId: s.id,
        sailorName: s.name,
        regattaId: r.id,
        regattaName: r.name,
        dnsPoints: optimistUnregisteredScore(stats?.maxRank),
      });
    }
  }
  return pairs;
}
