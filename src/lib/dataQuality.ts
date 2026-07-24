/**
 * Data quality checks (admin / stats).
 */

import { toYmd } from "@/lib/datesSg";

export type GoldBeforeEntryIssue = {
  sailorId: string;
  name: string;
  goldEntryDate: string;
  earliestGoldRegattaDate: string;
  earliestGoldRegattaName: string;
};

export type GoldResultLink = {
  sailorId: string;
  sailorName: string;
  goldEntryDate: string | null | undefined;
  regattaDate: string | null | undefined;
  regattaName: string | null | undefined;
  division?: string | null;
  countsForRanking?: boolean | null;
};

/** Sailors with a Gold ranking result dated before gold_entry_date. */
export function findGoldBeforeEntryIssues(
  links: GoldResultLink[]
): GoldBeforeEntryIssue[] {
  const bySailor = new Map<
    string,
    {
      name: string;
      goldEntryDate: string;
      earliest: string | null;
      earliestName: string;
    }
  >();

  for (const l of links) {
    const gold = toYmd(l.goldEntryDate);
    if (!gold) continue;
    if (l.countsForRanking === false) continue;
    const div = String(l.division || "Gold").trim().toLowerCase();
    if (div !== "gold" && div !== "both") continue;
    const d = toYmd(l.regattaDate);
    if (!d || d >= gold) continue;

    const cur = bySailor.get(l.sailorId);
    if (!cur) {
      bySailor.set(l.sailorId, {
        name: l.sailorName,
        goldEntryDate: gold,
        earliest: d,
        earliestName: l.regattaName || "Regatta",
      });
    } else if (!cur.earliest || d < cur.earliest) {
      cur.earliest = d;
      cur.earliestName = l.regattaName || "Regatta";
    }
  }

  const out: GoldBeforeEntryIssue[] = [];
  for (const [sailorId, v] of bySailor) {
    if (!v.earliest) continue;
    out.push({
      sailorId,
      name: v.name,
      goldEntryDate: v.goldEntryDate,
      earliestGoldRegattaDate: v.earliest,
      earliestGoldRegattaName: v.earliestName,
    });
  }
  out.sort((a, b) => a.name.localeCompare(b.name));
  return out;
}
