import type { RegattaRecord } from "@/lib/ranking";
import { organiserResultStatus } from "@/lib/resultCardStatus";
import { nationalityLabelForCode } from "@/lib/countries";

export function recentLandingResults(rows: RegattaRecord[], today: string, counts?: Record<string, number>) {
  return rows.filter((row) => {
    const end = String(row.endDate || row.date || "").slice(0, 10);
    return Boolean(end && end <= today && row.totalFleetSize > 0 && (row.raceCount || 0) > 0 &&
      (!counts || (counts[row.id] || 0) > 0));
  }).sort((a, b) => String(b.endDate || b.date).localeCompare(String(a.endDate || a.date)) || a.name.localeCompare(b.name));
}

export function landingResultStatus(row: RegattaRecord) {
  return organiserResultStatus(row);
}

export function landingCountry(row: RegattaRecord): string {
  const label = nationalityLabelForCode(row.geography);
  return label === "—" ? "" : label.split(" — ").at(-1) || label;
}

export function formatLandingDate(value: string): string {
  const ymd = String(value).slice(0, 10);
  const date = new Date(`${ymd}T00:00:00Z`);
  if (Number.isNaN(date.getTime())) return "Date to be confirmed";
  return new Intl.DateTimeFormat("en-SG", { day: "numeric", month: "short", year: "numeric", timeZone: "UTC" }).format(date);
}

export function upcomingLandingEvents(rows: RegattaRecord[], today: string) {
  return rows.filter((row) => String(row.endDate || row.date).slice(0, 10) >= today)
    .sort((a, b) => a.date.localeCompare(b.date) || a.name.localeCompare(b.name)).slice(0, 3);
}
