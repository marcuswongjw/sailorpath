/** Admin regatta list/form shape. */
export type RegattaAdmin = {
  id: string;
  name: string;
  slug: string;
  /** Prefer ISO string; may be Date from Drizzle until serialized. */
  date: string | Date;
  totalFleetSize: number;
  division?: string | null;
  raceCount?: number | null;
  geography?: string | null;
  boatClass?: string | null;
  countsForRanking?: boolean | null;
  endDate?: string | Date | null;
  venue?: string | null;
  organizer?: string | null;
  norUrl?: string | null;
  registrationUrl?: string | null;
  isSelectionTrial?: boolean | null;
  scheduleNotes?: string | null;
  status?: string | null;
  reviewedAt?: string | Date | null;
  createdAt?: string | Date | null;
  updatedAt?: string | Date | null;
};

/** Safe display for date cells */
export function regattaDateLabel(d: string | Date | null | undefined): string {
  if (d == null) return "—";
  return String(d).slice(0, 10);
}
