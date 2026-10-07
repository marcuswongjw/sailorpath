import { regattaCountsForRanking, type RegattaRecord } from "@/lib/ranking";

export function matchesRegattaClass(label: string | null | undefined, filter: string): boolean {
  const value = String(label || "").toLowerCase().replace(/[^a-z0-9]/g, "");
  if (filter === "all") return true;
  if (filter === "ilca") return value.startsWith("ilca") || ["radial", "standard"].includes(value);
  if (filter === "optimist") return value.startsWith("optimist") || value === "opti";
  if (filter === "ilca6" && value === "radial") return true;
  if (filter === "ilca7" && value === "standard") return true;
  if (filter === "techno293") return value.startsWith("techno293") || value === "t293";
  return value.startsWith(filter);
}

/** National ranking is a property of a Singapore class sheet, never its calendar card. */
export function nationalRankingLabel(sheet: RegattaRecord): string | null {
  if (!["SG", "SGP"].includes(String(sheet.geography || "").toUpperCase())) return null;
  if (!["optimist", "ilca4", "ilca6"].some((cls) => matchesRegattaClass(sheet.boatClass, cls))) return null;
  if (sheet.raceCount == null) return "National ranking eligibility pending";
  return regattaCountsForRanking(sheet) ? "Counts for Singapore national ranking" : "Does not count for Singapore national ranking";
}
