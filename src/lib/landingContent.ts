import type { RegattaRecord } from "@/lib/ranking";
import { organiserResultStatus } from "@/lib/resultCardStatus";
import { nationalityLabelForCode } from "@/lib/countries";
import { findEventSliceForRegattaSlug } from "@/lib/regattaEvents";
import { groupedHubForSlug, savedEventHubForSlug } from "@/lib/regattaEventGroups";

export function recentLandingResults(rows: RegattaRecord[], today: string, counts?: Record<string, number>) {
  return rows.filter((row) => {
    const end = String(row.endDate || row.date || "").slice(0, 10);
    return Boolean(end && end <= today && row.totalFleetSize > 0 && (row.raceCount || 0) > 0 &&
      (!counts || (counts[row.id] || 0) > 0));
  }).sort((a, b) => String(b.endDate || b.date).localeCompare(String(a.endDate || a.date)) || a.name.localeCompare(b.name));
}

export function landingEventGroupKey(row: RegattaRecord, allRows: RegattaRecord[]): string {
  if (row.eventSlug?.trim()) {
    return `event:${row.eventSlug.trim().toLowerCase()}`;
  }
  const saved = savedEventHubForSlug(row.slug, allRows);
  if (saved) {
    return `event:${saved.event.slug.toLowerCase()}`;
  }
  const registered = findEventSliceForRegattaSlug(row.slug);
  if (registered) {
    return `event:${registered.event.slug.toLowerCase()}`;
  }
  const grouped = groupedHubForSlug(row.slug, allRows);
  if (grouped) {
    return `group:${grouped.event.slug.toLowerCase()}`;
  }
  return `row:${row.id || row.slug}`;
}

/**
 * Selects up to `limit` recent completed scorecards, prioritising distinct
 * parent regatta events so a single multi-fleet regatta does not occupy every
 * featured slot on the landing page. Backfills from remaining fleet sheets only
 * when fewer than `limit` distinct events exist.
 */
export function distinctRecentLandingResults(
  rows: RegattaRecord[],
  today: string,
  counts?: Record<string, number>,
  limit = 3,
): RegattaRecord[] {
  const sorted = recentLandingResults(rows, today, counts);
  const seenEvents = new Set<string>();
  const primary: RegattaRecord[] = [];
  const overflow: RegattaRecord[] = [];

  for (const row of sorted) {
    const key = landingEventGroupKey(row, rows);
    if (!seenEvents.has(key)) {
      seenEvents.add(key);
      primary.push(row);
    } else {
      overflow.push(row);
    }
  }

  return [...primary, ...overflow].slice(0, limit);
}

export function landingAdditionalFleetCount(
  row: RegattaRecord,
  scoredRows: RegattaRecord[],
  allRows: RegattaRecord[],
): number {
  const key = landingEventGroupKey(row, allRows);
  if (key.startsWith("row:")) return 0;
  let matching = 0;
  for (const candidate of scoredRows) {
    if (landingEventGroupKey(candidate, allRows) === key) {
      matching += 1;
    }
  }
  return Math.max(0, matching - 1);
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
