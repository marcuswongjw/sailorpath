import { canonicalBoatClass } from "@/lib/classRegistry";
import { findEventSliceForRegattaSlug } from "@/lib/regattaEvents";

export type ResultSheetIdentity = {
  id: string;
  slug: string;
  name: string;
  date: string | Date;
  boatClass?: string | null;
  division?: string | null;
};

/** Compare verified event/fleet aliases, never a loose event-name substring. */
export function sameResultSheet(a: ResultSheetIdentity, b: ResultSheetIdentity): boolean {
  if (a.id === b.id || a.slug === b.slug) return true;
  if (canonicalBoatClass(a.boatClass) !== canonicalBoatClass(b.boatClass)) return false;
  const division = (value: string | null | undefined) => (value || "Open").trim().toLowerCase();
  if (division(a.division) !== division(b.division)) return false;
  const left = findEventSliceForRegattaSlug(a.slug);
  const right = findEventSliceForRegattaSlug(b.slug);
  if (left && right) return left.event.slug === right.event.slug && left.slice.key === right.slice.key;
  const date = (value: string | Date) => value instanceof Date ? value.toISOString().slice(0, 10) : value.slice(0, 10);
  return date(a.date) === date(b.date) && a.name.trim().toLowerCase() === b.name.trim().toLowerCase();
}

/** Database sheets take precedence; static sheets only fill missing history. */
export function missingFallbackSheets<T extends ResultSheetIdentity>(saved: ResultSheetIdentity[], fallback: T[]): T[] {
  return fallback.filter((candidate) => !saved.some((row) => sameResultSheet(row, candidate)));
}
