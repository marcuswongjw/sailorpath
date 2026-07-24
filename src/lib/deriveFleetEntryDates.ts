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
};

/**
 * Earliest Silver ranking regatta date for a sailor (YYYY-MM-DD), or null.
 * Division must be Silver (not Gold; Both excluded by default).
 */
export function deriveSilverEntryYmd(
  links: ResultRegattaLink[],
  sailorId: string
): string | null {
  let earliest: string | null = null;
  for (const l of links) {
    if (l.sailorId !== sailorId) continue;
    if (l.countsForRanking === false) continue;
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
    if (l.countsForRanking === false) continue;
    const div = String(l.division || "Gold").trim().toLowerCase();
    if (div !== "silver") continue;
    const d = toYmd(l.regattaDate);
    if (!d) continue;
    const prev = map.get(l.sailorId);
    if (!prev || d < prev) map.set(l.sailorId, d);
  }
  return map;
}
