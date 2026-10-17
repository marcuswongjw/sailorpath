import { matchesRegattaClass } from "@/lib/calendar/publicRegattas";
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
};

export type RegattaDirectoryQuery = {
  q?: string;
  boatClass?: string;
  year?: string;
  when?: string;
};

function ymd(value: string | null | undefined): string {
  return String(value || "").slice(0, 10);
}

export function directoryFromPublished(rows: RegattaRecord[]): DirectoryRegatta[] {
  return rows
    .filter((row) => row.slug && row.name)
    .map((row) => ({
      id: row.id || row.slug,
      name: row.name,
      slug: row.slug,
      date: ymd(row.date),
      endDate: row.endDate ? ymd(row.endDate) : null,
      venue: row.venue || null,
      boatClass: row.boatClass || null,
      region: row.region || null,
    }));
}

export function directoryFromCalendar(rows: RegattaCalendarEntry[]): DirectoryRegatta[] {
  return rows.map((row) => ({
    id: row.slug,
    name: row.name,
    slug: row.slug,
    date: ymd(row.startDate),
    endDate: row.endDate ? ymd(row.endDate) : null,
    venue: row.venue || null,
    boatClass: row.boatClass || null,
    region: row.region || null,
  }));
}

/** Published rows win when a static calendar entry uses the same slug. */
export function mergeRegattaDirectory(
  published: DirectoryRegatta[],
  calendar: DirectoryRegatta[]
): DirectoryRegatta[] {
  const bySlug = new Map<string, DirectoryRegatta>();
  for (const row of calendar) bySlug.set(row.slug, row);
  for (const row of published) bySlug.set(row.slug, row);
  return [...bySlug.values()];
}

function matchesClass(row: DirectoryRegatta, boatClass: string): boolean {
  if (!boatClass || boatClass === "all") return true;
  if (matchesRegattaClass(row.boatClass, boatClass)) return true;
  return String(row.boatClass || "").toLowerCase().includes(boatClass.toLowerCase());
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
    if (year !== "all" && !row.date.startsWith(year)) return false;
    if (!matchesClass(row, query.boatClass || "all")) return false;
    const end = row.endDate || row.date;
    if (when === "upcoming" && end < today) return false;
    if (when === "past" && end >= today) return false;
    if (!q) return true;
    return `${row.name} ${row.venue || ""} ${row.boatClass || ""} ${row.region || ""}`
      .toLowerCase()
      .includes(q);
  });
  visible.sort((a, b) =>
    when === "upcoming" ? a.date.localeCompare(b.date) : b.date.localeCompare(a.date)
  );
  return visible;
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
