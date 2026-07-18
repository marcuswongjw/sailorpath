/**
 * Ensure fleet sailors have result rows for every ranking regatta in a period.
 * Missing results get DNS = totalFleetSize + 1 (editable later; overseas can override).
 * Aligns with calculateRankings eligibility (resolveSailorFleet + last 5 fleet events).
 */

import {
  resolveSailorFleet,
  rankingRegattasInPeriod,
  periodBounds,
  type Period,
  type SailorRecord,
  type RegattaRecord,
} from "@/lib/ranking";

export type FillDnsPair = {
  sailorId: string;
  sailorName: string;
  regattaId: string;
  regattaName: string;
  dnsPoints: number;
};

export { periodBounds };

/**
 * Period-only regatta pool for DNS fill (does not include carry-forward events).
 * Carry-forward scores use previous-period result rows that already exist.
 */
export function rankingRegattasForFleet(
  fleet: "Gold" | "Silver",
  period: Period,
  allRegattas: RegattaRecord[]
): RegattaRecord[] {
  return rankingRegattasInPeriod(fleet, period, allRegattas);
}

/**
 * Active sailors in a fleet for the period (same as ranking board).
 */
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
 * Pairs of (sailor, regatta) that need a DNS result row.
 * existingKeys = Set of "sailorId|regattaId"
 */
export function missingDnsPairs(args: {
  fleet: "Gold" | "Silver";
  period: Period;
  sailors: SailorRecord[];
  regattas: RegattaRecord[];
  existingKeys: Set<string>;
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
  const pairs: FillDnsPair[] = [];
  for (const s of fleetSailors) {
    for (const r of events) {
      const key = `${s.id}|${r.id}`;
      if (args.existingKeys.has(key)) continue;
      pairs.push({
        sailorId: s.id,
        sailorName: s.name,
        regattaId: r.id,
        regattaName: r.name,
        dnsPoints: Math.max(1, (r.totalFleetSize || 0) + 1),
      });
    }
  }
  return pairs;
}
