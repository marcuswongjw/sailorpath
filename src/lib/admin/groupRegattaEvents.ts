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
  selectionEventId?: string | null;
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
  /** Public card line. Schedule notes stay off the card. */
  keyDeadlines?: string;
  /** Paragraph under the regatta name. Blank uses the built-in description. */
  scheduleSummary?: string;
  /** Text after "Scoring:" on the public event page. */
  scoringRules?: string;
  expectedClasses: string[];
  missingClasses: string[];
  sheets: GroupableRegatta[];
  /** Every calendar row stored for this weekend. All of them stay selectable. */
  shells: GroupableRegatta[];
  /** Earliest calendar row. Kept for callers that only need one. */
  shell: GroupableRegatta | null;
};

function ymd(value: string | Date | null | undefined): string {
  if (value == null) return "";
  return String(value).slice(0, 10);
}

function canonicalEventSlug(slug: string): string {
  return getRegattaEvent(slug)?.slug ?? slug.toLowerCase();
}

/**
 * A regatta row whose slug names the weekend itself, not a class results sheet.
 * Aliases such as `…-ilca4` are the same weekend and must stay selectable.
 */
export function eventShellSlug(rowSlug: string): string | null {
  const slug = String(rowSlug || "").trim().toLowerCase();
  if (!slug) return null;
  const event = getRegattaEvent(slug);
  if (event) return event.slug;
  if (SINGAPORE_REGATTAS_2026.some((item) => item.slug === slug)) {
    return canonicalEventSlug(slug);
  }
  if (Object.prototype.hasOwnProperty.call(CALENDAR_RESULT_ALIASES, slug)) {
    return canonicalEventSlug(slug);
  }
  return null;
}

function sheetEventSlug(row: GroupableRegatta): string | null {
  const shell = eventShellSlug(row.slug);
  if (shell) return shell;
  const slice = findEventSliceForRegattaSlug(row.slug);
  if (slice) return slice.event.slug;
  const slug = String(row.slug || "").toLowerCase();
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

export function missingClassesFor(
  expected: string[],
  sheets: GroupableRegatta[]
): string[] {
  return expected.filter((label) => !classCovered(label, sheets));
}

function classCovered(expected: string, sheets: GroupableRegatta[]): boolean {
  const family = regattaClassFamily(expected);
  if (family === "optimist") {
    const expectedFleet = /gold/i.test(expected)
      ? "gold"
      : /silver/i.test(expected)
        ? "silver"
        : null;
    if (expectedFleet) {
      return sheets.some(
        (row) =>
          regattaClassFamily(row.boatClass) === "optimist" &&
          String(row.division || "").toLowerCase() === expectedFleet
      );
    }
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

export function eventClassProgress(event: AdminEventGroup): {
  published: number;
  total: number;
} {
  const published = event.sheets.filter((row) => row.status === "published").length;
  const total = Math.max(event.expectedClasses.length, event.sheets.length);
  return { published, total };
}

export function eventStatusLabel(event: AdminEventGroup): string {
  if (event.slug === UNASSIGNED_EVENT_SLUG) {
    return `${event.sheets.length} class sheet${event.sheets.length === 1 ? "" : "s"}`;
  }
  const { published, total } = eventClassProgress(event);
  if (total === 0) return "Awaiting results";
  return `${published} of ${total} classes published`;
}

/** Class sheets and calendar shells that belong to one weekend. */
export function sheetIdsForEvent(
  grouped: { events: AdminEventGroup[]; unassigned: GroupableRegatta[] },
  slug: string
): string[] {
  if (slug === UNASSIGNED_EVENT_SLUG) {
    return grouped.unassigned.map((row) => row.id);
  }
  const event = grouped.events.find((item) => item.slug === slug);
  if (!event) return [];
  const ids = new Set<string>();
  for (const row of event.sheets) ids.add(row.id);
  for (const row of event.shells) ids.add(row.id);
  return [...ids];
}

export function groupRegattaEvents(
  rows: GroupableRegatta[],
  eventSlugsById: ReadonlyMap<string, string> = new Map()
): {
  events: AdminEventGroup[];
  unassigned: GroupableRegatta[];
} {
  const sheets = new Map<string, GroupableRegatta[]>();
  const shells = new Map<string, GroupableRegatta[]>();
  const unassigned: GroupableRegatta[] = [];

  for (const row of rows) {
    const shellSlug = eventShellSlug(row.slug);
    const linkedRaw = row.eventId ? eventSlugsById.get(row.eventId) : null;
    // Database events are distinct destinations, even when a legacy public
    // alias combines their slugs into one hub (RSYC Gold/Silver 2025).
    const linkedSlug = linkedRaw ? linkedRaw.trim().toLowerCase() : null;
    // A saved link to a different regatta moves the class, even when its slug
    // is also a calendar shell of the regatta it is leaving.
    if (linkedSlug && linkedSlug !== shellSlug) {
      const list = sheets.get(linkedSlug) ?? [];
      list.push(row);
      sheets.set(linkedSlug, list);
      continue;
    }
    if (shellSlug) {
      const list = shells.get(shellSlug) ?? [];
      list.push(row);
      shells.set(shellSlug, list);
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
    const eventShells = (shells.get(slug) ?? [])
      .slice()
      .sort((a, b) => ymd(a.date).localeCompare(ymd(b.date)) || a.name.localeCompare(b.name));
    const shell = eventShells[0] ?? null;
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
      isSelectionTrial:
        Boolean(primary?.isSelectionTrial) ||
        eventSheets.some((row) => row.isSelectionTrial) ||
        eventShells.some((row) => row.isSelectionTrial),
      keyDeadlines: primary?.keyDeadlines || undefined,
      scheduleSummary: registry?.scheduleSummary,
      scoringRules: registry?.scoringRules,
      expectedClasses,
      missingClasses: missingClassesFor(expectedClasses, [
        ...eventSheets,
        ...eventShells,
      ]),
      sheets: eventSheets,
      shells: eventShells,
      shell,
    });
  }

  events.sort((a, b) => b.startDate.localeCompare(a.startDate) || a.name.localeCompare(b.name));
  unassigned.sort((a, b) => ymd(b.date).localeCompare(ymd(a.date)));
  return { events, unassigned };
}

export type ImportCalendarEvent = {
  id: string;
  slug: string;
  name: string;
  startDate: string | Date;
};

export type ImportTargetEvent = {
  slug: string;
  name: string;
  sheets: Array<{ id: string; label: string; date: string }>;
};

/**
 * Every saved main regatta, including ones that do not yet have a class sheet.
 * Class sheets are attached by their stored event id, then by slug.
 */
export function importTargetEvents(
  rows: GroupableRegatta[],
  saved: ImportCalendarEvent[]
): ImportTargetEvent[] {
  const slugsById = new Map(
    saved.map((event) => [event.id, String(event.slug || "").trim()])
  );
  const grouped = groupRegattaEvents(rows, slugsById);
  const savedBySlug = new Map(
    saved.map((event) => [String(event.slug || "").trim().toLowerCase(), event])
  );
  const options = new Map<
    string,
    ImportTargetEvent & { startDate: string }
  >();

  for (const event of grouped.events) {
    if (event.slug === UNASSIGNED_EVENT_SLUG) continue;
    const savedEvent = savedBySlug.get(event.slug);
    options.set(event.slug, {
      slug: event.slug,
      name: savedEvent?.name || event.name,
      startDate: ymd(savedEvent?.startDate) || event.startDate,
      sheets: event.sheets.map((sheet) => ({
        id: sheet.id,
        label: `${sheet.boatClass || "Class"}${
          sheet.division ? ` · ${sheet.division}` : ""
        }`,
        date: ymd(sheet.date),
      })),
    });
  }

  for (const event of saved) {
    const slug = String(event.slug || "").trim().toLowerCase();
    if (!slug || options.has(slug)) continue;
    options.set(slug, {
      slug,
      name: event.name,
      startDate: ymd(event.startDate),
      sheets: [],
    });
  }

  return [...options.values()]
    .sort(
      (a, b) => b.startDate.localeCompare(a.startDate) || a.name.localeCompare(b.name)
    )
    .map(({ slug, name, sheets }) => ({ slug, name, sheets }));
}
