import { regattaCountsForRanking, type RegattaRecord } from "@/lib/ranking";
import { matchesSailingClass } from "@/lib/classRegistry";

export function matchesRegattaClass(label: string | null | undefined, filter: string): boolean {
  const requested = filter as
    | "all"
    | "ilca"
    | "optimist"
    | "ilca4"
    | "ilca6"
    | "ilca7"
    | "wingfoil"
    | "techno293"
    | "iqfoil"
    | "windsurfing"
    | "29er";
  return matchesSailingClass(label, requested);
}

/** National ranking is a property of a Singapore class sheet, never its calendar card. */
export function nationalRankingLabel(sheet: RegattaRecord): string | null {
  if (!["SG", "SGP"].includes(String(sheet.geography || "").toUpperCase())) return null;
  if (!["optimist", "ilca4", "ilca6"].some((cls) => matchesRegattaClass(sheet.boatClass, cls))) return null;
  if (sheet.raceCount == null) return "National ranking eligibility pending";
  return regattaCountsForRanking(sheet) ? "Counts for Singapore national ranking" : "Does not count for Singapore national ranking";
}
