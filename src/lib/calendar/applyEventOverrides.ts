import { getRegattaEvent } from "@/lib/regattaEvents";
import type { RegattaRecord } from "@/lib/ranking";

/** Saved weekend facts from admin. These are the public calendar card fields. */
export type CalendarEventOverride = {
  slug: string;
  name: string;
  startDate: string;
  endDate?: string | null;
  venue?: string | null;
  organizer?: string | null;
  classes?: string[] | null;
  norUrl?: string | null;
  registrationUrl?: string | null;
  countsForRanking?: boolean | null;
  isSelectionTrial?: boolean | null;
  keyDeadlines?: string | null;
};

export function canonicalCalendarEventSlug(slug: string): string {
  const raw = String(slug || "").trim().toLowerCase();
  if (!raw) return raw;
  return getRegattaEvent(raw)?.slug ?? raw;
}

/**
 * Apply an admin-saved weekend onto the static calendar card.
 * Sibling cards for the same weekend keep their own name and class chips.
 */
export function applyCalendarEventOverride(
  entry: RegattaRecord,
  saved: CalendarEventOverride | undefined,
  primary: boolean
): RegattaRecord {
  if (!saved) return entry;
  const classes = (saved.classes || []).map((item) => item.trim()).filter(Boolean);
  return {
    ...entry,
    name: primary && saved.name ? saved.name : entry.name,
    date: saved.startDate || entry.date,
    endDate: saved.endDate || undefined,
    venue: saved.venue || undefined,
    organizer: saved.organizer || undefined,
    norUrl: saved.norUrl || undefined,
    registrationUrl: saved.registrationUrl || undefined,
    countsForRanking: saved.countsForRanking ?? entry.countsForRanking,
    isSelectionTrial: saved.isSelectionTrial ?? entry.isSelectionTrial,
    keyDeadlines: saved.keyDeadlines || undefined,
    classes: primary && classes.length > 0 ? classes : entry.classes,
    boatClass: primary && classes.length > 0 ? classes[0] : entry.boatClass,
  };
}
