/**
 * Derive silver_entry_date from first Silver ranking regatta (exact date).
 * Gold entry stays admin half-boundary only.
 */

import { toYmd } from "@/lib/datesSg";

export type ResultRegattaLink = {
  sailorId: string;
  regattaDate: string | null | undefined;
  division?: string | null;
  countsForRanking?: boolean | null;
  boatClass?: string | null;
};

function isOptimistSeriesLink(l: ResultRegattaLink): boolean {
  if (l.countsForRanking === false) return false;
  const bc = String(l.boatClass || "Optimist")
    .trim()
    .toLowerCase();
  // Legacy null/empty boat_class = Optimist; exclude ILCA etc.
  if (bc && bc !== "optimist") return false;
  const div = String(l.division || "Gold").trim().toLowerCase();
  // Single-fleet Open never drives Optimist silver entry
  if (div === "open" || div === "fleet") return false;
  return true;
}

/**
 * Earliest Silver ranking regatta date for a sailor (YYYY-MM-DD), or null.
 * Division must be Silver (not Gold; Both excluded by default).
 * Optimist ranking only — ILCA 4 / other classes ignored.
 */
export function deriveSilverEntryYmd(
  links: ResultRegattaLink[],
  sailorId: string
): string | null {
  let earliest: string | null = null;
  for (const l of links) {
    if (l.sailorId !== sailorId) continue;
    if (!isOptimistSeriesLink(l)) continue;
    const div = String(l.division || "Gold").trim().toLowerCase();
    if (div !== "silver") continue;
    const d = toYmd(l.regattaDate);
    if (!d) continue;
    if (!earliest || d < earliest) earliest = d;
  }
  return earliest;
}

/**
 * Map of sailorId → earliest silver entry date across all links.
 */
export function deriveAllSilverEntryDates(
  links: ResultRegattaLink[]
): Map<string, string> {
  const map = new Map<string, string>();
  for (const l of links) {
    if (!isOptimistSeriesLink(l)) continue;
    const div = String(l.division || "Gold").trim().toLowerCase();
    if (div !== "silver") continue;
    const d = toYmd(l.regattaDate);
    if (!d) continue;
    const prev = map.get(l.sailorId);
    if (!prev || d < prev) map.set(l.sailorId, d);
  }
  return map;
}
