import { unstable_cache } from "next/cache";
import { getCachedPublicRegattas } from "@/lib/queries";
import {
  CACHE_TAG_PUBLIC_REGATTAS,
  PUBLIC_DATA_REVALIDATE_SECONDS,
} from "@/lib/cacheTags";
import { SINGAPORE_REGATTAS_2026 } from "@/lib/calendar/singaporeRegattas2026";
import {
  applyCalendarEventOverride,
  filterDeletedCalendarEvents,
  canonicalCalendarEventSlug,
  type CalendarEventOverride,
} from "@/lib/calendar/applyEventOverrides";
import { groupRegattaEvents } from "@/lib/admin/groupRegattaEvents";
import { db, withDatabaseRetry } from "@/db";
import { regattaEventDeletions, regattaEvents } from "@/db/schema";
import type { RegattaRecord } from "@/lib/ranking";


const getCachedCalendarEvents = unstable_cache(
  async () =>
    withDatabaseRetry(() =>
      db
        .select({
          id: regattaEvents.id,
          slug: regattaEvents.slug,
          name: regattaEvents.name,
          startDate: regattaEvents.startDate,
          endDate: regattaEvents.endDate,
          venue: regattaEvents.venue,
          organizer: regattaEvents.organizer,
          classes: regattaEvents.classes,
          norUrl: regattaEvents.norUrl,
          registrationUrl: regattaEvents.registrationUrl,
          countsForRanking: regattaEvents.countsForRanking,
          isSelectionTrial: regattaEvents.isSelectionTrial,
          keyDeadlines: regattaEvents.keyDeadlines,
        })
        .from(regattaEvents)
    ),
  ["calendar-events-v1"],
  {
    revalidate: PUBLIC_DATA_REVALIDATE_SECONDS,
    tags: [CACHE_TAG_PUBLIC_REGATTAS],
  }
);

const getCachedCalendarDeletions = unstable_cache(
  () => withDatabaseRetry(
    () => db.select({ slug: regattaEventDeletions.slug }).from(regattaEventDeletions),
    { label: "calendar.deleted_events" }
  ),
  ["calendar-event-deletions-v1"],
  { revalidate: PUBLIC_DATA_REVALIDATE_SECONDS, tags: [CACHE_TAG_PUBLIC_REGATTAS] }
);

export function dedupeEventSheets(sheets: RegattaRecord[]): RegattaRecord[] {
  const map = new Map<string, RegattaRecord>();
  for (const sheet of sheets) {
    const key = `${(sheet.boatClass || "Optimist").trim().toLowerCase()}:${(sheet.division || "open").trim().toLowerCase()}`;
    const existing = map.get(key);
    if (!existing) {
      map.set(key, sheet);
      continue;
    }
    const existingRaces = existing.raceCount ?? 0;
    const sheetRaces = sheet.raceCount ?? 0;
    if (sheetRaces !== existingRaces) {
      if (sheetRaces > existingRaces) map.set(key, sheet);
      continue;
    }
    const existingFleet = existing.totalFleetSize ?? 0;
    const sheetFleet = sheet.totalFleetSize ?? 0;
    if (sheetFleet !== existingFleet) {
      if (sheetFleet > existingFleet) map.set(key, sheet);
      continue;
    }
    if (existing.id.startsWith("reg-") && !sheet.id.startsWith("reg-")) {
      map.set(key, sheet);
      continue;
    }
  }
  return Array.from(map.values());
}

/** The shared calendar inventory, including saved overrides and deletions. */
export async function getPublicCalendarData() {
  let dbRegattas: RegattaRecord[] = [];
  let eventSlugsById = new Map<string, string>();
  let savedEvents: CalendarEventOverride[] = [];
  let deletedSlugs: string[] = [];
  try {
    dbRegattas = await getCachedPublicRegattas();
  } catch {
    dbRegattas = [];
  }
  try {
    const [rows, deleted] = await Promise.all([getCachedCalendarEvents(), getCachedCalendarDeletions()]);
    deletedSlugs = deleted.map((row) => row.slug);
    eventSlugsById = new Map(rows.map((row) => [row.id, row.slug]));
    savedEvents = rows.map((row) => ({
      slug: row.slug,
      name: row.name,
      startDate: String(row.startDate).slice(0, 10),
      endDate: row.endDate ? String(row.endDate).slice(0, 10) : null,
      venue: row.venue,
      organizer: row.organizer,
      classes: row.classes,
      norUrl: row.norUrl,
      registrationUrl: row.registrationUrl,
      countsForRanking: row.countsForRanking,
      isSelectionTrial: row.isSelectionTrial,
      keyDeadlines: row.keyDeadlines,
    }));
  } catch {
    // Do not fall back to built-in entries when deletion state cannot be checked.
    throw new Error("Calendar is temporarily unavailable");
  }

  // Load 2026 master schedule events
  const combinedMap = new Map<string, RegattaRecord>();

  for (const item of SINGAPORE_REGATTAS_2026) {
    combinedMap.set(item.slug, {
      id: item.slug,
      name: item.name,
      slug: item.slug,
      date: item.startDate,
      endDate: item.endDate,
      totalFleetSize: item.totalFleetSize,
      division: item.division,
      venue: item.venue,
      region: item.region,
      organizer: item.organizer,
      countsForRanking: item.countsForRanking,
      isSelectionTrial: item.isSelectionTrial,
      targetFleet: item.targetFleet,
      keyDeadlines: item.keyDeadlines,
      clinicDates: item.clinicDates,
      norUrl: item.norUrl,
      registrationUrl: item.registrationUrl,
      scheduleNotes: item.scheduleNotes,
      prizesSummary: item.prizesSummary,
      boatClass: item.boatClass,
      classes: item.classes,
      geography: item.geography || "SG",
    });
  }

  // Then overlay database metadata for matching schedule events ONLY (do not inject class-specific DB results)
  for (const r of dbRegattas) {
    const existing = combinedMap.get(r.slug);
    if (!existing) continue;
    combinedMap.set(r.slug, {
      ...existing,
      venue: r.venue || existing.venue,
      endDate: r.endDate || existing.endDate,
      norUrl: r.norUrl || existing.norUrl,
      registrationUrl: r.registrationUrl || existing.registrationUrl,
      isSelectionTrial: r.isSelectionTrial ?? existing.isSelectionTrial ?? false,
      organizer: r.organizer || existing.organizer,
      scheduleNotes: r.scheduleNotes || existing.scheduleNotes,
      region: r.region || existing.region,
      targetFleet: r.targetFleet || existing.targetFleet,
      keyDeadlines: r.keyDeadlines || existing.keyDeadlines,
      clinicDates: r.clinicDates || existing.clinicDates,
      hasResults: true,
    });
  }

  const savedBySlug = new Map(savedEvents.map((event) => [event.slug, event]));
  const publicEvents = new Map<string, RegattaRecord>();

  // One public card per weekend. Static entries sometimes split a weekend by
  // class (for example Pesta Sukan Optimist and ILCA); combine those classes
  // under the canonical event before applying the saved admin record.
  for (const entry of combinedMap.values()) {
    const canonical = canonicalCalendarEventSlug(entry.slug);
    const current = publicEvents.get(canonical);
    const mergedClasses = [
      ...new Set([
        ...(current?.classes || (current?.boatClass ? [current.boatClass] : [])),
        ...(entry.classes || (entry.boatClass ? [entry.boatClass] : [])),
      ]),
    ];
    if (!current) {
      publicEvents.set(canonical, {
        ...entry,
        id: canonical,
        slug: canonical,
        classes: mergedClasses,
      });
    } else {
      publicEvents.set(canonical, {
        ...current,
        classes: mergedClasses,
        hasResults: Boolean(current.hasResults || entry.hasResults),
      });
    }
  }

  for (const [slug, entry] of publicEvents) {
    publicEvents.set(
      slug,
      applyCalendarEventOverride(entry, savedBySlug.get(slug), true)
    );
  }

  // Saved calendar weekends are authoritative public records even when they
  // have no matching static schedule row or attached class sheet yet.
  for (const saved of savedEvents) {
    if (publicEvents.has(saved.slug)) continue;
    publicEvents.set(saved.slug, {
      id: saved.slug,
      name: saved.name,
      slug: saved.slug,
      date: saved.startDate,
      endDate: saved.endDate || undefined,
      totalFleetSize: 0,
      division: "Open",
      venue: saved.venue || undefined,
      region: "Singapore",
      organizer: saved.organizer || undefined,
      countsForRanking: saved.countsForRanking !== false,
      isSelectionTrial: Boolean(saved.isSelectionTrial),
      keyDeadlines: saved.keyDeadlines || undefined,
      norUrl: saved.norUrl || undefined,
      registrationUrl: saved.registrationUrl || undefined,
      boatClass: saved.classes?.[0] || "Optimist",
      classes: saved.classes || [],
      geography: "SG",
    });
  }

  for (const sheet of dbRegattas) {
    if (sheet.eventId && sheet.eventSlug) eventSlugsById.set(sheet.eventId, sheet.eventSlug);
  }
  const grouped = groupRegattaEvents(dbRegattas, eventSlugsById);
  const resultSheetsByEvent: Record<string, RegattaRecord[]> = {};
  for (const event of grouped.events) {
    const rawSheets = dbRegattas.filter((sheet) => [...event.sheets, ...event.shells.filter((row) => (row.totalFleetSize || 0) > 0)].some((row) => row.id === sheet.id));
    const sheets = dedupeEventSheets(rawSheets);
    resultSheetsByEvent[event.slug] = sheets;
    const existing = publicEvents.get(event.slug);
    if (existing) {
      publicEvents.set(event.slug, { ...existing, classes: [...new Set([...(existing.classes || []), ...sheets.map((sheet) => sheet.boatClass || "Optimist")])] });
    } else if (sheets.length) {
      publicEvents.set(event.slug, { ...sheets[0], id: event.slug, slug: event.slug, name: event.name,
        date: event.startDate, endDate: event.endDate, classes: sheets.map((sheet) => sheet.boatClass || "Optimist"),
        region: sheets[0].region || (["SG", "SGP"].includes(sheets[0].geography || "") ? "Singapore" : "International") });
    }
  }
  // Preserve published sheets that have not yet been assigned to a weekend.
  for (const row of grouped.unassigned) {
    const sheet = dbRegattas.find((item) => item.id === row.id);
    if (!sheet) continue;
    if (!publicEvents.has(sheet.slug)) publicEvents.set(sheet.slug, { ...sheet, region: sheet.region || (["SG", "SGP"].includes(sheet.geography || "") ? "Singapore" : "International") });
    resultSheetsByEvent[sheet.slug] = [sheet];
  }

  const allRegattas = filterDeletedCalendarEvents(
    Array.from(publicEvents.values()), deletedSlugs, savedEvents.map((event) => event.slug)
  );

  return { allRegattas, resultSheetsByEvent };
}
