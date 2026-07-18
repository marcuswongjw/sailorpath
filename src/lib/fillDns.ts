/**
 * Ensure fleet sailors have result rows for every ranking regatta in a period.
 * Missing results get DNS = totalFleetSize + 1 (editable later; overseas can override).
 * Aligns with calculateRankings eligibility (resolveSailorFleet + last 5 fleet events).
 */

import {
  resolveSailorFleet,
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

export function periodBounds(period: Period): { start: string; end: string } {
  if (period.half === "Jan-Jun") {
    return { start: `${period.year}-01-01`, end: `${period.year}-06-30` };
  }
  return { start: `${period.year}-07-01`, end: `${period.year}-12-31` };
}

/** Same regatta pool as ranking engine for a fleet in a period (up to 5, oldest→newest as R1–R5). */
export function rankingRegattasForFleet(
  fleet: "Gold" | "Silver",
  period: Period,
  allRegattas: RegattaRecord[]
): RegattaRecord[] {
  const pEnd = new Date(
    period.half === "Jan-Jun" ? `${period.year}-06-30` : `${period.year}-12-31`
  ).getTime();

  return allRegattas
    .filter((r) => {
      const occurred = new Date(r.date).getTime() <= pEnd;
      if (!occurred) return false;
      // Only events inside the half-year period (not all history up to period end)
      const { start } = periodBounds(period);
      if (new Date(r.date).getTime() < new Date(start).getTime()) return false;

      const div = r.division || "Gold";
      if (fleet === "Gold") return div === "Gold" || div === "Both";
      return div === "Silver" || div === "Both";
    })
    .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
    .slice(0, 5)
    .reverse();
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
