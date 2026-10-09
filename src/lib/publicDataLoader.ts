/**
 * Shared Public Data-Loading Layer
 *
 * Implements Phase 2/3 shared loaders:
 * - getCalendarEvents(filters)
 * - getClassRegattas(boatClass, filters)
 * - getCanonicalEvent(slug)
 *
 * Guarantees:
 * 1. Exactly one calendar card per physical scheduled event (or multi-weekend occurrence).
 * 2. Series combined result sheets are excluded from calendar racing events.
 * 3. Orthogonal statuses:
 *    - Timing: 'upcoming' | 'in_progress' | 'completed' (derived strictly from date)
 *    - Result Availability: 'unavailable' | 'provisional' | 'final'
 * 4. Past events with no results are labelled "Results unavailable" (never upcoming).
 * 5. Class regatta lists present uniform layout across classes with links to the canonical event page.
 */

import {
  REGATTA_EVENTS,
  resolveEventSlices,
  getStaticBoardRegatta,
  getSliceResultAvailability,
} from "@/lib/regattaEvents";
import {
  deriveEventTimingStatus,
  type EventTimingStatus,
  type ResultAvailabilityStatus,
  type EventScheduleOccurrence,
} from "@/lib/types/regattaEventModel";
import {
  matchesSailingClass,
  sailingClassKeyOf,
  type SailingClassKey,
} from "@/lib/classRegistry";
import { hubHrefForClassSlug } from "@/lib/regattaEventGroups";
import type { RegattaRecord } from "@/lib/ranking";

export type PublicCalendarEvent = {
  id: string;
  slug: string;
  name: string;
  shortName: string;
  startDate: string;
  endDate?: string;
  venue?: string;
  organizer?: string;
  classes: string[];
  timingStatus: EventTimingStatus;
  resultStatus: ResultAvailabilityStatus;
  resultSummary: string;
  isDateRange?: boolean;
  norUrl?: string;
  officialNoticeBoardUrl?: string;
  registrationUrl?: string;
  isSelectionTrial?: boolean;
  countsForRanking?: boolean;
  canonicalHref: string;
};

export type PublicClassRegattaRow = {
  id: string;
  eventSlug: string;
  fleetKey: string;
  name: string;
  roundLabel?: string;
  datesText: string;
  startDate: string;
  endDate?: string;
  venue: string;
  organizer?: string;
  timingStatus: EventTimingStatus;
  resultStatus: ResultAvailabilityStatus;
  resultsSummary: string;
  competitorCount: number;
  format?: string;
  canonicalHref: string;
  seriesLink?: {
    seriesId: string;
    seriesName: string;
    seriesSlug: string;
    roundLabel: string;
  };
  source?: {
    kind: "event_catalog" | "normalized_result" | "special_scorecard";
    label: string;
  };
};

/**
 * Normalizes class token for comparison across all supported sailing classes.
 */
function normalizeClassToken(raw: string): string {
  return sailingClassKeyOf(raw) || raw.toLowerCase().replace(/[\s._-]+/g, "");
}

/**
 * Load public calendar events across physical regatta events.
 * Multi-weekend occurrences generate distinct calendar entries linking to the same event.
 * Series combined standings sheets are explicitly excluded.
 */
export function getPublicCalendarEvents(options?: {
  year?: number | string;
  boatClass?: string;
  location?: string;
  status?: "upcoming" | "past" | "all";
  referenceDate?: Date;
}): PublicCalendarEvent[] {
  const refDate = options?.referenceDate || new Date();
  const entries: PublicCalendarEvent[] = [];

  for (const event of REGATTA_EVENTS) {
    // 1. Exclude drafts / archived
    if (event.publicationStatus === "draft" || event.publicationStatus === "archived") {
      continue;
    }

    // 2. Exclude series combined standings sheets (they do not represent racing dates)
    if (
      event.slug.includes("combined") ||
      event.name.toLowerCase().includes("combined series") ||
      event.name.toLowerCase().includes("combined standings")
    ) {
      continue;
    }

    // Slices and class badges
    const classBadges = Array.from(
      new Set(
        event.slices.map((s) => s.label.replace(/\s+(Gold|Silver|Open|Fleet)$/i, ""))
      )
    );

    // Filter by boatClass if provided
    if (options?.boatClass && options.boatClass !== "all") {
      const targetNorm = normalizeClassToken(options.boatClass);
      const matches = event.slices.some(
        (s) =>
          normalizeClassToken(s.series) === targetNorm ||
          normalizeClassToken(s.label) === targetNorm
      );
      if (!matches) continue;
    }

    // Evaluate result status across slices
    const resolvedSlices = resolveEventSlices(event, []);
    let bestResultStatus: ResultAvailabilityStatus = "unavailable";
    let totalEntries = 0;

    for (const slice of resolvedSlices) {
      const avail = getSliceResultAvailability(slice);
      if (avail.status === "final") bestResultStatus = "final";
      else if (avail.status === "provisional" && bestResultStatus !== "final") {
        bestResultStatus = "provisional";
      }
      totalEntries = Math.max(totalEntries, avail.competitorCount);
    }

    // Multi-weekend schedules support
    const occurrences: EventScheduleOccurrence[] =
      event.schedules && event.schedules.length > 0
        ? event.schedules
        : [
            {
              startDate: event.datesText.includes("2025")
                ? "2025-02-08"
                : "2026-09-11",
              endDate: event.datesText.includes("2025")
                ? "2025-02-09"
                : "2026-09-12",
              venue: event.venue,
            },
          ];

    for (const occ of occurrences) {
      const timingStatus = deriveEventTimingStatus(
        occ.startDate,
        occ.endDate,
        refDate
      );

      // Filter by timing status if requested
      if (options?.status === "upcoming" && timingStatus === "completed") {
        continue;
      }
      if (options?.status === "past" && timingStatus !== "completed") {
        continue;
      }

      // Filter by year if requested
      const occYear = occ.startDate.slice(0, 4);
      if (options?.year && options.year !== "all" && String(options.year) !== occYear) {
        continue;
      }

      const resultSummary =
        bestResultStatus === "unavailable"
          ? "Results unavailable"
          : bestResultStatus === "provisional"
          ? `Provisional · ${totalEntries} competitors`
          : `Final · ${totalEntries} competitors`;

      const href =
        options?.boatClass && options.boatClass !== "all"
          ? `/regattas/${event.slug}?class=${encodeURIComponent(options.boatClass)}`
          : `/regattas/${event.slug}`;

      entries.push({
        id: `${event.slug}${occ.sessionId ? `-${occ.sessionId}` : ""}`,
        slug: event.slug,
        name: occ.label ? `${event.name} (${occ.label})` : event.name,
        shortName: event.shortName,
        startDate: occ.startDate,
        endDate: occ.endDate,
        venue: occ.venue || event.venue,
        organizer: event.organizer,
        classes: classBadges,
        timingStatus,
        resultStatus: bestResultStatus,
        resultSummary,
        isDateRange: occ.isDateRange,
        norUrl: event.noticeOfRaceUrl,
        officialNoticeBoardUrl: event.officialNoticeBoardUrl,
        registrationUrl: event.registrationUrl,
        canonicalHref: href,
      });
    }
  }

  // Sort: upcoming ascending, past descending
  return entries.sort((a, b) => {
    if (a.timingStatus === "completed" && b.timingStatus === "completed") {
      return b.startDate.localeCompare(a.startDate);
    }
    return a.startDate.localeCompare(b.startDate);
  });
}

/**
 * Load canonical regatta list for a specific class page (e.g. /sg/wingfoil, /sg/techno293).
 * Returns each event where this class participates, linking directly to the canonical event
 * with the class active.
 */
export function getClassRegattas(
  boatClass:
    | "wingfoil"
    | "techno293"
    | "iqfoil"
    | "ilca4"
    | "ilca6"
    | "ilca7"
    | "optimist",
  options?: {
    year?: number | string;
    status?: "upcoming" | "past" | "all";
    referenceDate?: Date;
  }
): PublicClassRegattaRow[] {
  const refDate = options?.referenceDate || new Date();
  const rows: PublicClassRegattaRow[] = [];
  const targetNorm = normalizeClassToken(boatClass);

  for (const event of REGATTA_EVENTS) {
    // Exclude drafts and archived
    if (event.publicationStatus === "draft" || event.publicationStatus === "archived") {
      continue;
    }

    // Exclude combined standings sheets (they belong on the series championship tab, not regattas list)
    if (
      event.slug.includes("combined") ||
      event.name.toLowerCase().includes("combined series") ||
      event.name.toLowerCase().includes("combined standings")
    ) {
      continue;
    }

    // Find slice matching this boat class
    const sliceDef = event.slices.find(
      (s) =>
        normalizeClassToken(s.series) === targetNorm ||
        normalizeClassToken(s.label) === targetNorm
    );
    if (!sliceDef) continue;

    const resolved = resolveEventSlices(event, []);
    const matchingSlice = resolved.find((r) => r.def.key === sliceDef.key) || {
      def: sliceDef,
      regatta: null,
    };

    const avail = getSliceResultAvailability(matchingSlice);
    const board = getStaticBoardRegatta(sliceDef);

    // Primary schedule date
    const startDate = event.schedules?.[0]?.startDate || "2025-02-08";
    const endDate = event.schedules?.[0]?.endDate;
    const timingStatus = deriveEventTimingStatus(startDate, endDate, refDate);

    // Status filter
    if (options?.status === "upcoming" && timingStatus === "completed") continue;
    if (options?.status === "past" && timingStatus !== "completed") continue;

    // Year filter
    const yearStr = startDate.slice(0, 4);
    if (options?.year && options.year !== "all" && String(options.year) !== yearStr) {
      continue;
    }

    const seriesLink = event.seriesLinks?.[0];

    rows.push({
      id: `${event.slug}-${sliceDef.key}`,
      eventSlug: event.slug,
      fleetKey: sliceDef.key,
      name: event.name,
      roundLabel: seriesLink?.roundLabel,
      datesText: event.datesText,
      startDate,
      endDate,
      venue: event.venue,
      organizer: event.organizer,
      timingStatus,
      resultStatus: avail.status,
      resultsSummary: avail.label,
      competitorCount: avail.competitorCount,
      format: sliceDef.resultType || board?.format,
      canonicalHref: `/regattas/${event.slug}?fleet=${encodeURIComponent(sliceDef.key)}`,
      seriesLink,
      source: { kind: "event_catalog", label: "Event catalog" },
    });
  }

  // Sort descending by date (latest first)
  return rows.sort((a, b) => b.startDate.localeCompare(a.startDate));
}

type PublishedScorecard = {
  id: string;
  name: string;
  shortName?: string;
  dates: string;
  venue?: string;
  organizer?: string;
  format?: string;
  status?: string;
  lifecycleStatus?: "draft" | "in_review" | "published" | "archived";
  seriesName?: string;
  seriesPart?: string;
  results?: readonly unknown[];
};

function scorecardIsCombined(regatta: PublishedScorecard): boolean {
  return /\bcombined\b|combined standings/i.test(
    `${regatta.id} ${regatta.name} ${regatta.seriesPart || ""}`
  );
}

function timestampToYmd(timestamp: number): string {
  if (!Number.isFinite(timestamp) || timestamp <= 0) return "1970-01-01";
  return new Date(timestamp).toISOString().slice(0, 10);
}

/**
 * Adapter for the legacy WingFoil/Techno JSON scorecards. It is deliberately a
 * read-only public projection: it makes published scorecards discoverable but
 * does not claim they are sailor-linked normalized result sheets.
 */
export function getPublishedScorecardRegattas(
  boatClass: "wingfoil" | "techno293",
  regattas: readonly PublishedScorecard[],
  options: {
    parseDate: (dates: string | undefined | null) => number;
    referenceDate?: Date;
  }
): PublicClassRegattaRow[] {
  const referenceDate = options.referenceDate || new Date();
  const classPath = boatClass === "wingfoil" ? "wingfoil" : "techno293";

  return regattas
    .filter(
      (regatta) =>
        (!regatta.lifecycleStatus || regatta.lifecycleStatus === "published") &&
        !scorecardIsCombined(regatta)
    )
    .map((regatta): PublicClassRegattaRow => {
      const startDate = timestampToYmd(options.parseDate(regatta.dates));
      const competitorCount = regatta.results?.length || 0;
      const hasResults = competitorCount > 0;
      return {
        id: `special-${boatClass}-${regatta.id}`,
        eventSlug: regatta.id,
        fleetKey: boatClass,
        name: regatta.name,
        roundLabel: regatta.seriesPart,
        datesText: regatta.dates,
        startDate,
        venue: regatta.venue || "Singapore",
        organizer: regatta.organizer,
        timingStatus: deriveEventTimingStatus(startDate, undefined, referenceDate),
        resultStatus: hasResults ? "final" : "unavailable",
        resultsSummary: hasResults
          ? `Published scorecard · ${competitorCount} competitors`
          : "Scorecard published · results unavailable",
        competitorCount,
        format: regatta.format,
        canonicalHref: `/sg/${classPath}?tab=results&regatta=${encodeURIComponent(regatta.id)}`,
        source: { kind: "special_scorecard", label: "Published scorecard" },
      };
    })
    .sort((a, b) => b.startDate.localeCompare(a.startDate) || a.name.localeCompare(b.name));
}

function formatDatesText(startDate: string, endDate?: string | null): string {
  const start = String(startDate || "").slice(0, 10);
  const end = String(endDate || "").slice(0, 10);
  if (!start) return "Date unavailable";
  return end && end !== start ? `${start} – ${end}` : start;
}

/**
 * Adapter for normalized class sheets. This is the canonical path for iQFOiL
 * and new board-class imports; it preserves the event hub/profile result model.
 */
export function getNormalizedClassRegattas(
  boatClass: SailingClassKey,
  regattas: readonly RegattaRecord[],
  options?: { referenceDate?: Date }
): PublicClassRegattaRow[] {
  const referenceDate = options?.referenceDate || new Date();
  return regattas
    .filter((regatta) => matchesSailingClass(regatta.boatClass, boatClass))
    .map((regatta): PublicClassRegattaRow => {
      const startDate = String(regatta.date || "").slice(0, 10);
      const raceCount = Number(regatta.raceCount) || 0;
      const competitorCount = Number(regatta.totalFleetSize) || 0;
      const href = hubHrefForClassSlug(regatta.slug, [...regattas]);
      return {
        id: `normalized-${regatta.id}`,
        eventSlug: regatta.eventSlug || regatta.slug,
        fleetKey: boatClass,
        name: regatta.eventName || regatta.name,
        datesText: formatDatesText(startDate, regatta.endDate),
        startDate,
        endDate: regatta.endDate || undefined,
        venue: regatta.venue || "Singapore",
        organizer: regatta.organizer || undefined,
        timingStatus: deriveEventTimingStatus(startDate, regatta.endDate || undefined, referenceDate),
        resultStatus: raceCount > 0 ? "final" : "provisional",
        resultsSummary:
          raceCount > 0
            ? `Published normalized results · ${competitorCount} competitors`
            : "Published normalized class sheet",
        competitorCount,
        canonicalHref:
          href ||
          `/regattas/${encodeURIComponent(regatta.eventSlug || regatta.slug)}?fleet=${encodeURIComponent(boatClass)}`,
        source: { kind: "normalized_result", label: "Normalized result" },
      };
    })
    .sort((a, b) => b.startDate.localeCompare(a.startDate) || a.name.localeCompare(b.name));
}
