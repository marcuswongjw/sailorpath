import type { SailorPrizeAward } from "./sailorPrizes";
import { nationalityLabelForCode } from "./countries";

export type AwardSort = "newest" | "oldest" | "placing" | "event" | "location";
export type AwardFilters = {
  query: string;
  year: string;
  location: string;
  boatClass: string;
  medal: string;
  from: string;
  to: string;
};
export const EMPTY_AWARD_FILTERS: AwardFilters = {
  query: "", year: "all", location: "all", boatClass: "all", medal: "all", from: "", to: "",
};

function isoDate(value?: string | null): string | null {
  const day = String(value || "").slice(0, 10);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(day)) return null;
  const date = new Date(day + "T00:00:00Z");
  return Number.isFinite(date.getTime()) && date.toISOString().slice(0, 10) === day ? day : null;
}

const MONTHS = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"];

/** Legacy schedules have readable date ranges; ignore publication notes in parentheses. */
export function awardScheduleEndDate(datesText: string | undefined, year: number): string | null {
  const text = String(datesText || "").replace(/\([^)]*\)/g, "");
  const matches = [...text.matchAll(/(\d{1,2})\s+(January|February|March|April|May|June|July|August|September|October|November|December)\b(?:\s+(\d{4}))?/gi)];
  const days = matches.flatMap((match) => {
    const month = MONTHS.indexOf(match[2].toLowerCase()) + 1;
    const day = isoDate(`${match[3] || year}-${String(month).padStart(2, "0")}-${match[1].padStart(2, "0")}`);
    return day ? [day] : [];
  });
  return days.sort().at(-1) || null;
}

/** The event's last day represents when its prizes were earned. */
export function awardDate(award: SailorPrizeAward): string | null {
  return isoDate(award.regattaEndDate) || isoDate(award.regattaDate) ||
    awardScheduleEndDate(award.datesText, award.year);
}
export function awardYear(award: SailorPrizeAward): string {
  return awardDate(award)?.slice(0, 4) || (award.year ? String(award.year) : "");
}
export function awardLocation(award: SailorPrizeAward): string {
  return award.venue?.trim() || (award.geography ? nationalityLabelForCode(award.geography) : "") || "";
}
export function awardDateLabel(award: SailorPrizeAward): string {
  const start = isoDate(award.regattaDate);
  const end = isoDate(award.regattaEndDate);
  const format = (date: string) => new Intl.DateTimeFormat("en-GB", {
    day: "numeric", month: "short", year: "numeric", timeZone: "UTC",
  }).format(new Date(date + "T00:00:00Z"));
  if (start) return end && end !== start ? `${format(start)} – ${format(end)}` : format(start);
  return award.datesText || (award.year ? String(award.year) : "Date not recorded");
}

function recentFirst(a: SailorPrizeAward, b: SailorPrizeAward, direction = -1): number {
  const years = Number(awardYear(a) || 0) - Number(awardYear(b) || 0);
  if (years) return direction * years;
  const ad = awardDate(a), bd = awardDate(b);
  if (!ad || !bd) return Number(!ad) - Number(!bd);
  return direction * ad.localeCompare(bd);
}

export function sortSailorAwards(awards: readonly SailorPrizeAward[], sort: AwardSort = "newest"): SailorPrizeAward[] {
  const medals = { gold: 0, silver: 1, bronze: 2, other: 3 };
  return [...awards].sort((a, b) => {
    const primary = sort === "oldest" ? recentFirst(a, b, 1)
      : sort === "placing" ? a.rank - b.rank
      : sort === "event" ? a.regattaName.localeCompare(b.regattaName)
      : sort === "location" ? Number(!awardLocation(a)) - Number(!awardLocation(b)) || awardLocation(a).localeCompare(awardLocation(b))
      : recentFirst(a, b);
    return primary || recentFirst(a, b) || medals[a.medal] - medals[b.medal] || a.rank - b.rank;
  });
}

export function browseSailorAwards(awards: readonly SailorPrizeAward[], filters: AwardFilters, sort: AwardSort): SailorPrizeAward[] {
  const terms = filters.query.trim().toLowerCase().split(/\s+/).filter(Boolean);
  return sortSailorAwards(awards.filter((award) => {
    const date = awardDate(award);
    const text = [award.regattaName, award.categoryName, award.prizeTitle, award.fleetName, award.boatClass, awardLocation(award)].join(" ").toLowerCase();
    return terms.every((term) => text.includes(term)) &&
      (filters.year === "all" || awardYear(award) === filters.year) &&
      (filters.location === "all" || awardLocation(award) === filters.location) &&
      (filters.boatClass === "all" || award.boatClass === filters.boatClass) &&
      (filters.medal === "all" || award.medal === filters.medal) &&
      (!filters.from || Boolean(date && date >= filters.from)) &&
      (!filters.to || Boolean(date && date <= filters.to));
  }), sort);
}
