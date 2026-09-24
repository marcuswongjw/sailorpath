import { SINGAPORE_REGATTAS_2026 } from "@/lib/calendar/singaporeRegattas2026";
import { CALENDAR_RESULT_ALIASES } from "@/lib/calendar/calendarResultLinks";
import {
  ilcaFleetOf,
  regattaClassFamily,
} from "@/lib/admin/regattaClass";
import {
  findEventSliceForRegattaSlug,
  getRegattaEvent,
  REGATTA_EVENTS,
} from "@/lib/regattaEvents";

/** Sheets that match no calendar event. */
export const UNASSIGNED_EVENT_SLUG = "__unassigned__";

export type GroupableRegatta = {
  id: string;
  name: string;
  slug: string;
  date: string | Date;
  boatClass?: string | null;
  division?: string | null;
  status?: string | null;
  venue?: string | null;
  endDate?: string | Date | null;
  geography?: string | null;
  scheduleNotes?: string | null;
  organizer?: string | null;
  norUrl?: string | null;
  registrationUrl?: string | null;
  countsForRanking?: boolean | null;
  isSelectionTrial?: boolean | null;
  eventId?: string | null;
  totalFleetSize?: number | null;
  raceCount?: number | null;
};

export type AdminEventGroup = {
  slug: string;
  name: string;
  startDate: string;
  endDate?: string;
  venue?: string;
  organizer?: string;
  norUrl?: string;
  registrationUrl?: string;
  countsForRanking: boolean;
  isSelectionTrial: boolean;
  expectedClasses: string[];
  missingClasses: string[];
  sheets: GroupableRegatta[];
  /** Calendar row that was stored in `regattas` and is not a class scoreboard. */
  shell: GroupableRegatta | null;
};

function ymd(value: string | Date | null | undefined): string {
  if (value == null) return "";
  return String(value).slice(0, 10);
}

function canonicalEventSlug(slug: string): string {
  return getRegattaEvent(slug)?.slug ?? slug.toLowerCase();
}

/** A regatta row whose slug is the weekend itself, not a class results sheet. */
export function eventShellSlug(rowSlug: string): string | null {
  const slug = String(rowSlug || "").trim().toLowerCase();
  if (!slug) return null;
  const knownCalendar = SINGAPORE_REGATTAS_2026.some((item) => item.slug === slug);
  const knownAlias = Object.prototype.hasOwnProperty.call(
    CALENDAR_RESULT_ALIASES,
    slug
  );
  const event = getRegattaEvent(slug);
  if (event && (event.slug === slug || knownCalendar || knownAlias)) {
    return event.slug;
  }
  if (knownCalendar || knownAlias) return canonicalEventSlug(slug);
  if (event && event.slug === slug) return event.slug;
  return null;
}

function sheetEventSlug(row: GroupableRegatta): string | null {
  const shell = eventShellSlug(row.slug);
  if (shell) return shell;
  const slice = findEventSliceForRegattaSlug(row.slug);
  if (slice) return slice.event.slug;
  const slug = row.slug.toLowerCase();
  for (const [calendarSlug, alias] of Object.entries(CALENDAR_RESULT_ALIASES)) {
    if (!alias.slugIncludes.every((token) => slug.includes(token))) continue;
    if (alias.slugExcludes?.some((token) => slug.includes(token))) continue;
    return canonicalEventSlug(calendarSlug);
  }
  return null;
}

export function sheetClassLabel(row: GroupableRegatta): string {
  const boat = String(row.boatClass || "").trim();
  const division = String(row.division || "").trim();
  const family = regattaClassFamily(boat);
  if (family === "optimist" && /gold|silver/i.test(division)) {
    return `Optimist ${division}`;
  }
  if (family === "ilca") return ilcaFleetOf(boat) || boat || "ILCA";
  return boat || division || "Class";
}

function classCovered(expected: string, sheets: GroupableRegatta[]): boolean {
  const family = regattaClassFamily(expected);
  if (family === "optimist") {
    return sheets.some((row) => regattaClassFamily(row.boatClass) === "optimist");
  }
  if (family === "ilca") {
    const fleet = ilcaFleetOf(expected);
    if (!fleet) {
      return sheets.some((row) => regattaClassFamily(row.boatClass) === "ilca");
    }
    return sheets.some((row) => ilcaFleetOf(row.boatClass) === fleet);
  }
  if (family === "other") {
    const want = expected.toLowerCase();
    return sheets.some((row) => String(row.boatClass || "").toLowerCase() === want);
  }
  return sheets.some((row) => regattaClassFamily(row.boatClass) === family);
}

function calendarItemsFor(slug: string) {
  return SINGAPORE_REGATTAS_2026.filter(
    (item) => canonicalEventSlug(item.slug) === slug
  );
}

export function eventStatusLabel(event: AdminEventGroup): string {
  if (event.slug === UNASSIGNED_EVENT_SLUG) {
    return `${event.sheets.length} class sheet${event.sheets.length === 1 ? "" : "s"}`;
  }
  const published = event.sheets.filter((row) => row.status === "published").length;
  const total = Math.max(event.expectedClasses.length, event.sheets.length);
  if (total === 0) return "Awaiting results";
  return `${published} of ${total} classes published`;
}

export function groupRegattaEvents(rows: GroupableRegatta[]): {
  events: AdminEventGroup[];
  unassigned: GroupableRegatta[];
} {
  const sheets = new Map<string, GroupableRegatta[]>();
  const shells = new Map<string, GroupableRegatta>();
  const unassigned: GroupableRegatta[] = [];

  for (const row of rows) {
    const shellSlug = eventShellSlug(row.slug);
    if (shellSlug) {
      const current = shells.get(shellSlug);
      if (!current || ymd(row.date) < ymd(current.date)) shells.set(shellSlug, row);
      continue;
    }
    const eventSlug = sheetEventSlug(row);
    if (!eventSlug) {
      unassigned.push(row);
      continue;
    }
    const list = sheets.get(eventSlug) ?? [];
    list.push(row);
    sheets.set(eventSlug, list);
  }

  const slugs = new Set<string>([...sheets.keys(), ...shells.keys()]);
  const events: AdminEventGroup[] = [];
  for (const slug of slugs) {
    const calendarItems = calendarItemsFor(slug);
    const registry = REGATTA_EVENTS.find((event) => event.slug === slug);
    const eventSheets = (sheets.get(slug) ?? []).slice().sort((a, b) =>
      sheetClassLabel(a).localeCompare(sheetClassLabel(b))
    );
    const shell = shells.get(slug) ?? null;
    const primary = calendarItems[0];
    const expectedClasses = [
      ...new Set(
        calendarItems.flatMap((item) =>
          item.classes?.length ? item.classes : item.boatClass ? [item.boatClass] : []
        )
      ),
    ];
    const startDates = [
      ...calendarItems.map((item) => item.startDate),
      ...eventSheets.map((row) => ymd(row.date)),
      shell ? ymd(shell.date) : "",
    ].filter(Boolean);
    startDates.sort();
    events.push({
      slug,
      name: primary?.name || registry?.name || shell?.name || eventSheets[0]?.name || slug,
      startDate: startDates[0] || "",
      endDate: primary?.endDate || ymd(shell?.endDate) || undefined,
      venue: primary?.venue || registry?.venue || shell?.venue || undefined,
      organizer: primary?.organizer || registry?.organizer || shell?.organizer || undefined,
      norUrl: primary?.norUrl || registry?.noticeOfRaceUrl || shell?.norUrl || undefined,
      registrationUrl:
        primary?.registrationUrl ||
        registry?.registrationUrl ||
        shell?.registrationUrl ||
        undefined,
      countsForRanking: primary
        ? primary.countsForRanking
        : eventSheets.some((row) => row.countsForRanking !== false),
      isSelectionTrial: primary
        ? primary.isSelectionTrial
        : Boolean(shell?.isSelectionTrial),
      expectedClasses,
      missingClasses: expectedClasses.filter((label) => !classCovered(label, eventSheets)),
      sheets: eventSheets,
      shell,
    });
  }

  events.sort((a, b) => b.startDate.localeCompare(a.startDate) || a.name.localeCompare(b.name));
  unassigned.sort((a, b) => ymd(b.date).localeCompare(ymd(a.date)));
  return { events, unassigned };
}
