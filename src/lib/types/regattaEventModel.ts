/**
 * Canonical Event, Result Sheet, and Series Data Model definitions.
 *
 * Implements the architecture model:
 * 1. Event: A scheduled competition, potentially with several classes and racing weekends (e.g. 2025 NE Monsoon Series 2).
 * 2. Result Sheet: Results for one class / fleet slice at an event (e.g. Series 2 — Wingfoil).
 * 3. Series: A championship connecting several events (e.g. 2025 NE Monsoon Grand Prix).
 *
 * Status Orthogonality:
 * - Publication Status: 'draft' | 'in_review' | 'published' | 'archived'
 * - Timing Status: 'upcoming' | 'in_progress' | 'completed' (derived strictly from event schedule dates)
 * - Result Status: 'unavailable' | 'provisional' | 'final'
 */

export type PublicationStatus = "draft" | "in_review" | "published" | "archived";

export type EventTimingStatus = "upcoming" | "in_progress" | "completed";

export type ResultAvailabilityStatus = "unavailable" | "provisional" | "final";

export type EventScheduleOccurrence = {
  sessionId?: string;
  label?: string; // e.g. "Weekend 1", "Weekend 2", "GPS Window"
  startDate: string; // YYYY-MM-DD
  endDate: string; // YYYY-MM-DD
  venue?: string;
  isDateRange?: boolean; // For GPS Speed challenges or month-long trials
};

export type EventDocument = {
  id: string;
  eventId?: string;
  seriesId?: string;
  type: "nor" | "si" | "notice" | "results" | "entry_list" | "protest";
  title: string;
  url: string;
  revisionDate?: string;
};

export type CanonicalSeriesRoundMembership = {
  seriesId: string;
  eventId: string; // References canonical event
  roundNumber: number;
  roundLabel: string; // e.g. "GP1", "GP2", "Round 1"
  contributesToChampionship: boolean; // false for combined standings sheets or exhibition rounds
  displayOrder: number;
};

export type CanonicalSeries = {
  id: string;
  slug: string;
  year: number;
  name: string;
  shortName: string;
  boatClass: string; // e.g. "Wingfoil", "Techno 293", "ILCA 4", "Optimist"
  season: string;
  websiteUrl?: string;
  noticeBoardUrl?: string;
  scoringRulesNotes?: string;
  rounds: CanonicalSeriesRoundMembership[];
  hasPublishedCombinedStandings?: boolean;
  publishedCombinedSheetId?: string;
};

/**
 * Derives event timing status strictly from start/end dates in the event's local timezone.
 * Missing results must never make a past event appear upcoming!
 */
export function deriveEventTimingStatus(
  startDateStr: string,
  endDateStr?: string | null,
  referenceDate: Date = new Date()
): EventTimingStatus {
  if (!startDateStr) return "upcoming";

  // Use local date string comparison (YYYY-MM-DD)
  const todayStr = referenceDate.toISOString().slice(0, 10);
  const start = startDateStr.slice(0, 10);
  const end = (endDateStr || startDateStr).slice(0, 10);

  if (todayStr < start) {
    return "upcoming";
  }
  if (todayStr > end) {
    return "completed";
  }
  return "in_progress";
}

/**
 * Derives result status independently of event timing status.
 */
export function deriveResultAvailability(
  resultCount: number,
  isProvisional: boolean = false
): ResultAvailabilityStatus {
  if (resultCount <= 0) {
    return "unavailable";
  }
  return isProvisional ? "provisional" : "final";
}
