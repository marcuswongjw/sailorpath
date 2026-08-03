/**
 * Data quality checks (admin / stats).
 * Flags logical inconsistencies for Superadmin review.
 */

import { toYmd } from "@/lib/datesSg";
import { birthYear } from "@/lib/age";
import { isSeriesMember } from "@/lib/seriesMembership";

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
  boatClass?: string | null;
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
    if (!isOptimistRankingLink(l)) continue;
    const gold = toYmd(l.goldEntryDate);
    if (!gold) continue;
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

export type GoldWithoutEntryIssue = {
  sailorId: string;
  name: string;
  silverEntryDate: string | null;
  earliestGoldRegattaDate: string;
  earliestGoldRegattaName: string;
};

/**
 * Sailors who raced Optimist Gold but have no gold_entry_date
 * (often still stamped silver-only).
 */
export function findGoldResultsWithoutGoldEntry(
  links: GoldResultLink[],
  sailors: {
    id: string;
    name: string;
    goldEntryDate?: string | Date | null;
    silverEntryDate?: string | Date | null;
  }[]
): GoldWithoutEntryIssue[] {
  const byId = new Map(sailors.map((s) => [s.id, s]));
  const earliest = new Map<
    string,
    { date: string; name: string; sailorName: string }
  >();

  for (const l of links) {
    if (!isOptimistRankingLink(l)) continue;
    const div = String(l.division || "Gold").trim().toLowerCase();
    if (div !== "gold" && div !== "both") continue;
    const d = toYmd(l.regattaDate);
    if (!d) continue;
    const s = byId.get(l.sailorId);
    if (!s) continue;
    if (toYmd(s.goldEntryDate)) continue;
    const prev = earliest.get(l.sailorId);
    if (!prev || d < prev.date) {
      earliest.set(l.sailorId, {
        date: d,
        name: l.regattaName || "Regatta",
        sailorName: s.name || l.sailorName,
      });
    }
  }

  const out: GoldWithoutEntryIssue[] = [];
  for (const [sailorId, v] of earliest) {
    const s = byId.get(sailorId);
    out.push({
      sailorId,
      name: v.sailorName,
      silverEntryDate: toYmd(s?.silverEntryDate) || null,
      earliestGoldRegattaDate: v.date,
      earliestGoldRegattaName: v.name,
    });
  }
  out.sort((a, b) => a.name.localeCompare(b.name));
  return out;
}

export type OverAgeOptimistIssue = {
  sailorId: string;
  name: string;
  birthYear: number;
  ageYearsApprox: number;
  dropDate: string | null;
  currentFleet: string | null;
};

/**
 * Still active in Optimist series (not dropped) but age ≥ 16 in calendar year
 * (birth year + 16 already reached).
 */
export function findOverAgeOptimistIssues(
  sailors: {
    id: string;
    name: string;
    dob?: string | Date | null;
    dropDate?: string | Date | null;
    silverEntryDate?: string | Date | null;
    goldEntryDate?: string | Date | null;
    currentFleet?: string | null;
  }[],
  asOfYmd?: string
): OverAgeOptimistIssue[] {
  const today =
    asOfYmd ||
    new Date().toLocaleDateString("en-CA", { timeZone: "Asia/Singapore" });
  const cy = Number(today.slice(0, 4));
  const out: OverAgeOptimistIssue[] = [];

  for (const s of sailors) {
    if (!isSeriesMember(s)) continue;
    const by = birthYear(s.dob);
    if (by == null) continue;
    // Calendar age-out: year sailor turns 16
    if (cy < by + 16) continue;
    out.push({
      sailorId: s.id,
      name: s.name,
      birthYear: by,
      ageYearsApprox: cy - by,
      dropDate: toYmd(s.dropDate) || null,
      currentFleet: s.currentFleet ? String(s.currentFleet) : null,
    });
  }
  out.sort((a, b) => b.ageYearsApprox - a.ageYearsApprox || a.name.localeCompare(b.name));
  return out;
}

export type DataQualityReport = {
  emptySeries: number;
  goldBeforeEntry: GoldBeforeEntryIssue[];
  goldWithoutEntry: GoldWithoutEntryIssue[];
  overAgeOptimist: OverAgeOptimistIssue[];
};

function isOptimistRankingLink(l: {
  countsForRanking?: boolean | null;
  boatClass?: string | null;
}): boolean {
  if (l.countsForRanking === false) return false;
  const bc = String(l.boatClass || "Optimist")
    .trim()
    .toLowerCase();
  if (bc.includes("ilca")) return false;
  if (bc && bc !== "optimist" && bc !== "opti") return false;
  return true;
}

/** Full admin data-quality scan. */
export function buildDataQualityReport(
  sailors: {
    id: string;
    name: string;
    dob?: string | Date | null;
    dropDate?: string | Date | null;
    silverEntryDate?: string | Date | null;
    goldEntryDate?: string | Date | null;
    currentFleet?: string | null;
  }[],
  links: GoldResultLink[],
  asOfYmd?: string
): DataQualityReport {
  const emptySeries = sailors.filter((s) => {
    const cf = String(s.currentFleet || "")
      .trim()
      .toLowerCase();
    const isSeriesTag =
      cf === "series" ||
      cf === "gold" ||
      cf === "silver" ||
      cf === "in sg fleet" ||
      cf === "member";
    return isSeriesTag && !s.goldEntryDate && !s.silverEntryDate;
  }).length;

  // Ensure gold entry from sailor row on each link
  const linksWithGold: GoldResultLink[] = links.map((l) => {
    const s = sailors.find((x) => x.id === l.sailorId);
    return {
      sailorId: l.sailorId,
      sailorName: s?.name || l.sailorName,
      goldEntryDate:
        toYmd(s?.goldEntryDate) || toYmd(l.goldEntryDate) || null,
      regattaDate: l.regattaDate,
      regattaName: l.regattaName,
      division: l.division,
      countsForRanking: l.countsForRanking,
      boatClass: l.boatClass,
    };
  });

  return {
    emptySeries,
    goldBeforeEntry: findGoldBeforeEntryIssues(linksWithGold),
    goldWithoutEntry: findGoldResultsWithoutGoldEntry(linksWithGold, sailors),
    overAgeOptimist: findOverAgeOptimistIssues(sailors, asOfYmd),
  };
}

