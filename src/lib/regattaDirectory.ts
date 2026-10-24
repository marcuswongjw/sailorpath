import { groupRegattaEvents, sheetClassLabel } from "@/lib/admin/groupRegattaEvents";
import { getRegattaEvent } from "@/lib/regattaEvents";
import { hubHrefForClassSlug } from "@/lib/regattaEventGroups";
import { classFilterMatches, classFilterOptions, sailingClassDisplayLabel } from "@/lib/classPresentation";
import type { RegattaCalendarEntry } from "@/lib/calendar/singaporeRegattas2026";
import type { RegattaRecord } from "@/lib/ranking";

export type DirectoryRegatta = {
  id: string;
  name: string;
  slug: string;
  date: string;
  endDate: string | null;
  venue: string | null;
  boatClass: string | null;
  region: string | null;
  hasPublishedResults?: boolean;
  classes?: string[];
  fleets?: { id: string; name: string; label: string; boatClass: string | null; href: string }[];
};

export type RegattaDirectoryQuery = {
  q?: string;
  boatClass?: string;
  year?: string;
  when?: string;
  results?: string;
};

function ymd(value: string | Date | null | undefined): string {
  return (value instanceof Date ? value.toISOString() : String(value || "")).slice(0, 10);
}

export function directoryFromPublished(rows: RegattaRecord[]): DirectoryRegatta[] {
  const valid = rows.filter((row) => row.slug && row.name);
  const byId = new Map(valid.map((row) => [row.id, row]));
  const eventSlugs = new Map(valid.filter((row) => row.eventId && row.eventSlug).map((row) => [row.eventId!, row.eventSlug!]));
  const grouped = groupRegattaEvents(valid, eventSlugs);

  function entry(members: RegattaRecord[], slug: string, name: string, date: string, endDate?: string, venue?: string): DirectoryRegatta {
    const sample = members[0];
    const fleets = members.filter((row) => (row.importedEntryCount ?? row.totalFleetSize) > 0).map((row) => ({
      id: row.id,
      name: row.name,
      label: directoryFleetLabel(row),
      boatClass: row.boatClass || null,
      href: hubHrefForClassSlug(row.slug, valid) || `/regattas/${encodeURIComponent(row.slug)}`,
    })).sort((a, b) => a.label.localeCompare(b.label) || a.name.localeCompare(b.name));
    const scoredMembers = members.filter((row) => (row.importedEntryCount ?? row.totalFleetSize) > 0);
    const classes = classFilterOptions((scoredMembers.length ? scoredMembers : members).map((row) => row.boatClass));
    return { id: slug, slug, name, date, endDate: endDate || null, venue: venue || sample.venue || null,
      boatClass: classes.length === 1 ? classes[0] : null, classes, region: sample.region || null,
      hasPublishedResults: fleets.length > 0, fleets };
  }

  return [
    ...grouped.events.map((event) => {
      const members = [...new Map([...event.sheets, ...event.shells].map((row) => [row.id, byId.get(row.id)!])).values()];
      const savedName = members.find((row) => row.eventSlug === event.slug && row.eventName)?.eventName;
      const ends = [event.endDate, ...members.map((row) => ymd(row.endDate || row.date))].filter((value): value is string => Boolean(value)).sort();
      return entry(members, event.slug, savedName || event.name, event.startDate, ends.at(-1), event.venue);
    }),
    ...grouped.unassigned.map((row) => entry([byId.get(row.id)!], row.slug, row.name, ymd(row.date), ymd(row.endDate), row.venue || undefined)),
  ];
}

export function directoryFromCalendar(rows: RegattaCalendarEntry[]): DirectoryRegatta[] {
  return rows.map((row) => {
    const event = getRegattaEvent(row.slug);
    return ({
    id: row.slug,
    name: event && event.slug !== row.slug ? event.name : row.name,
    slug: event?.slug || row.slug,
    date: ymd(row.startDate),
    endDate: row.endDate ? ymd(row.endDate) : null,
    venue: row.venue || null,
    boatClass: row.boatClass || null,
    classes: classFilterOptions(row.classes?.length ? row.classes : [row.boatClass]),
    region: row.region || null,
    hasPublishedResults: false,
  }); });
}

/** Published rows win when a static calendar entry uses the same slug. */
export function mergeRegattaDirectory(
  published: DirectoryRegatta[],
  calendar: DirectoryRegatta[]
): DirectoryRegatta[] {
  const bySlug = new Map<string, DirectoryRegatta>();
  for (const row of [...calendar, ...published]) {
    const current = bySlug.get(row.slug);
    bySlug.set(row.slug, { ...current, ...row,
      classes: classFilterOptions([...(current?.classes || []), ...(row.classes || [])]),
      endDate: [current?.endDate, row.endDate].filter(Boolean).sort().at(-1) || null,
    });
  }
  return [...bySlug.values()];
}

function matchesClass(row: DirectoryRegatta, boatClass: string): boolean {
  if (!boatClass || boatClass === "all") return true;
  if ((row.classes || [row.boatClass]).some((label) => classFilterMatches(label, boatClass))) return true;
  return false;
}


function directoryFleetLabel(row: RegattaRecord): string {
  const label = sailingClassDisplayLabel(sheetClassLabel(row));
  const division = String(row.division || "").trim();
  return division && !/^(open|both|national|international)$/i.test(division) && !label.toLowerCase().includes(division.toLowerCase())
    ? `${label} · ${division}` : label;
}

export function filterRegattaDirectory(
  rows: DirectoryRegatta[],
  query: RegattaDirectoryQuery,
  today = new Date().toISOString().slice(0, 10)
): DirectoryRegatta[] {
  const q = (query.q || "").trim().toLowerCase();
  const year = query.year && query.year !== "all" ? query.year : "all";
  const when = query.when === "upcoming" || query.when === "past" ? query.when : "all";
  const visible = rows.filter((row) => {
    if (query.results === "published" && !row.hasPublishedResults) return false;
    if (query.results === "published" && row.fleets && query.boatClass && query.boatClass !== "all" && !row.fleets.some((fleet) => classFilterMatches(fleet.boatClass, query.boatClass!))) return false;
    if (year !== "all" && !row.date.startsWith(year)) return false;
    if (!matchesClass(row, query.boatClass || "all")) return false;
    const end = row.endDate || row.date;
    if (when === "upcoming" && end < today) return false;
    if (when === "past" && end >= today) return false;
    if (!q) return true;
    return `${row.name} ${row.venue || ""} ${(row.classes || [row.boatClass]).join(" ")} ${row.region || ""} ${(row.fleets || []).map((fleet) => `${fleet.name} ${fleet.label}`).join(" ")}`
      .toLowerCase()
      .includes(q);
  });
  visible.sort((a, b) =>
    when === "upcoming" ? a.date.localeCompare(b.date) : b.date.localeCompare(a.date)
  );
  return visible.map((row) => ({ ...row, fleets: row.fleets?.filter((fleet) =>
    !query.boatClass || query.boatClass === "all" || classFilterMatches(fleet.boatClass, query.boatClass)
  ) }));
}

export function regattaDirectoryTitle(query: RegattaDirectoryQuery): string {
  const q = (query.q || "").trim();
  if (q) return `Regattas matching “${q}” | SailorPath`;
  const boatClass = (query.boatClass || "").trim();
  if (boatClass && boatClass !== "all") return `${boatClass} regattas | SailorPath`;
  if (query.when === "upcoming") return "Upcoming regattas | SailorPath";
  if (query.when === "past") return "Past regattas | SailorPath";
  return "Regattas | SailorPath";
}
