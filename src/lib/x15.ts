import { sailingClassKeyOf } from "@/lib/classRegistry";
import type { RegattaRecord } from "@/lib/ranking";

export const X15_SOURCE_CHECKED_ON = "27 October 2026";
export const X15_WORLDS_2026 = {
  eventSlug: "x15-world-championships-2026",
  name: "X-15 World Championships 2026",
  boatClass: "X-15",
  startDate: "2026-11-04",
  endDate: "2026-11-08",
  dates: "4–8 November 2026",
  venue: "Port Nàutic Ibiza, Spain",
  organiser: "Club Mare Nostrum",
  websiteUrl: "https://x-15class.org/events/x-15-world-championships-2026/",
  noticeUrl: "https://x-15class.org/blog/entries-open-for-the-first-x-15-world-championships/",
  countsForRanking: false,
  // Advertised titles are not an assumed list of independently scored fleets.
  advertisedTitles: ["Senior male", "Senior female", "Youth male U19", "Youth female U19", "Junior U15"],
} as const;

export const X15_ASIANS_2026 = {
  name: "X-15 Asian Championships 2026",
  dates: "18–20 December 2026",
  training: "15–17 December training",
  venue: "Amara Watersports Club, Jomtien, Thailand",
  registrationUrl: "https://docs.google.com/forms/d/e/1FAIpQLSeYowVodOh1-Au0k6MkYQvhzoq6gQbySHmdkgk8xrcjYwFEYA/viewform",
  sourceUrl: "https://wingfoil.or.jp/x-15-asian-championships-2026/",
} as const;

export function x15WorldsStatus(today: string, hasReviewedResults = false): string {
  if (hasReviewedResults) return "Results available";
  if (today < X15_WORLDS_2026.startDate) return "Upcoming";
  if (today <= X15_WORLDS_2026.endDate) return "Racing window";
  return "Awaiting reviewed results";
}

/** Only recorded, published X-15 sheets; a scheduled event is not a scorecard. */
export function publishedX15Sheets(rows: readonly (RegattaRecord & { status?: string })[]): RegattaRecord[] {
  return rows.filter((row) => sailingClassKeyOf(row.boatClass) === "x15" &&
    (!row.status || row.status === "published") &&
    (row.importedEntryCount ?? row.totalFleetSize) > 0)
    .sort((a, b) => b.date.localeCompare(a.date) || a.name.localeCompare(b.name));
}
