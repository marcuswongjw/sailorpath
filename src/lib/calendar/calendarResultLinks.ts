import { isIlcaSeriesClass } from "@/lib/ilcaRanking";
import type { RegattaRecord } from "@/lib/ranking";

/**
 * Calendar entries and published results do not share slugs.
 * A card such as `temasek-regatta-2026` has to find
 * `202606-temasek-gold-2026-06-20`, not open that calendar slug itself.
 * Matching is explicit so "safyc" cannot jump from the July championships
 * to the March regatta, and "youth" cannot jump from the June championships
 * to the March SYSC results.
 */
export type PublicResultClass = "optimist" | "ilca4" | "ilca6" | "ilca7";

export type CalendarResultAlias = {
  /** Every token must appear in the published regatta slug. */
  slugIncludes: string[];
  /** Published slug must not include any of these. */
  slugExcludes?: string[];
  classes: PublicResultClass[];
};

export const CALENDAR_RESULT_ALIASES: Record<string, CalendarResultAlias> = {
  "temasek-regatta-2026": {
    slugIncludes: ["temasek", "2026"],
    classes: ["optimist", "ilca4"],
  },
  "22nd-safyc-regatta-2026": {
    slugIncludes: ["safyc", "mar-26", "2026"],
    classes: ["optimist", "ilca4"],
  },
  "2nd-safyc-optimist-championships-2026": {
    slugIncludes: ["safyc", "jul-26", "2026"],
    classes: ["optimist"],
  },
  "cincapura-regatta-2026": {
    slugIncludes: ["cincapura", "2026"],
    classes: ["optimist", "ilca4"],
  },
  "pesta-sukan-regatta-2026-optimist": {
    slugIncludes: ["pesta-sukan", "2026"],
    classes: ["optimist"],
  },
  "pesta-sukan-regatta-2026-ilca-wingfoil": {
    slugIncludes: ["pesta-sukan", "2026"],
    classes: ["ilca4"],
  },
  "pulau-ujong-regatta-2026": {
    slugIncludes: ["pulau-ujong", "2026"],
    classes: ["optimist", "ilca4"],
  },
  "ssf-selection-trials-2026": {
    slugIncludes: ["selection-trials", "2026"],
    classes: ["optimist", "ilca4"],
  },
};

export function publicResultClass(
  boatClass: string | null | undefined
): PublicResultClass | null {
  if (isIlcaSeriesClass(boatClass, "ILCA 4")) return "ilca4";
  if (isIlcaSeriesClass(boatClass, "ILCA 6")) return "ilca6";
  if (isIlcaSeriesClass(boatClass, "ILCA 7")) return "ilca7";
  const boat = String(boatClass || "").trim().toLowerCase();
  if (
    boat.includes("ilca") ||
    boat.includes("laser") ||
    boat.includes("radial") ||
    boat.includes("wing") ||
    boat.includes("techno") ||
    boat.includes("29") ||
    boat.includes("iqfoil") ||
    boat.includes("iq foil")
  ) {
    return null;
  }
  return "optimist";
}

export function classResultsHref(
  regatta: Pick<RegattaRecord, "slug" | "boatClass">
): string {
  const slug = encodeURIComponent(regatta.slug);
  const cls = publicResultClass(regatta.boatClass);
  if (cls === "ilca4") return `/sg/ilca4/regattas/${slug}`;
  if (cls === "ilca6") return `/sg/ilca6/regattas/${slug}`;
  if (cls === "ilca7") return `/sg/ilca7/regattas/${slug}`;
  return `/sg/optimist/regattas/${slug}`;
}

function divisionKey(row: Pick<RegattaRecord, "division" | "name" | "slug">): string {
  const blob = `${row.division || ""} ${row.name} ${row.slug}`.toLowerCase();
  if (blob.includes("silver")) return "silver";
  if (blob.includes("gold")) return "gold";
  return (row.division || "open").trim().toLowerCase() || "open";
}

/** Two imports of the same fleet: keep the fuller results sheet. */
function prefer(current: RegattaRecord, next: RegattaRecord): RegattaRecord {
  const races = (next.raceCount ?? 0) - (current.raceCount ?? 0);
  if (races !== 0) return races > 0 ? next : current;
  const fleet = (next.totalFleetSize ?? 0) - (current.totalFleetSize ?? 0);
  if (fleet !== 0) return fleet > 0 ? next : current;
  return current.slug.length <= next.slug.length ? current : next;
}

export function matchCalendarResults(
  calendarSlug: string,
  published: RegattaRecord[]
): RegattaRecord[] {
  const alias = CALENDAR_RESULT_ALIASES[calendarSlug];
  if (!alias) return [];

  const matches = published.filter((row) => {
    const slug = row.slug.toLowerCase();
    if (!alias.slugIncludes.every((token) => slug.includes(token))) return false;
    if (alias.slugExcludes?.some((token) => slug.includes(token))) return false;
    const family = publicResultClass(row.boatClass);
    return family != null && alias.classes.includes(family);
  });

  const best = new Map<string, RegattaRecord>();
  for (const row of matches) {
    const family = publicResultClass(row.boatClass) || "optimist";
    const key = `${family}:${divisionKey(row)}`;
    const current = best.get(key);
    best.set(key, current ? prefer(current, row) : row);
  }

  const rank = (row: RegattaRecord) => {
    const family = publicResultClass(row.boatClass) === "ilca4" ? 1 : 0;
    const division = divisionKey(row);
    const fleet = division === "gold" ? 0 : division === "silver" ? 1 : 2;
    return family * 10 + fleet;
  };

  return Array.from(best.values()).sort(
    (a, b) => rank(a) - rank(b) || a.name.localeCompare(b.name)
  );
}
