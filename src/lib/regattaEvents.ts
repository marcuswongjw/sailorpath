import type { RegattaRecord } from "@/lib/ranking";
import {
  SINGAPORE_WINGFOIL_REGATTAS,
  type WingfoilRegatta,
} from "@/lib/wingfoil";
import {
  SINGAPORE_TECHNO293_REGATTAS,
  type Techno293Regatta,
} from "@/lib/techno293";

/**
 * Event hub registry — pilot.
 *
 * One physical regatta (e.g. SNSC) is stored as several `regattas` rows,
 * one per class/division slice, plus static board-class entries. This
 * registry groups those slices under a single canonical event page
 * (/regattas/<event-slug>) until a proper event column exists on the
 * regattas table.
 */

export type RegattaEventSliceDef = {
  /** Value used in ?fleet= on the event hub page. */
  key: string;
  /** Tab label, e.g. "Optimist Gold". */
  label: string;
  series: "optimist" | "ilca4" | "wingfoil" | "techno293";
  /**
   * Regattas-table slice: lowercased regatta slug must contain every token.
   */
  slugIncludes?: string[];
  /** Static-data id for board classes served outside the regattas table. */
  staticId?: string;
};

export type RegattaEventDef = {
  slug: string;
  name: string;
  shortName: string;
  datesText: string;
  venue: string;
  organizer: string;
  noticeOfRaceUrl?: string;
  officialNoticeBoardUrl?: string;
  websiteUrl?: string;
  registrationUrl?: string;
  scheduleSummary?: string;
  scoringRules?: string;
  slices: RegattaEventSliceDef[];
};

export const SNSC_2026_EVENT: RegattaEventDef = {
  slug: "snsc-2026",
  name: "Singapore National Sailing Championships 2026",
  shortName: "SNSC 2026",
  datesText: "5–7 & 11–13 September 2026",
  venue: "National Sailing Centre, Singapore",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/14487/event",
  officialNoticeBoardUrl:
    "https://www.racingrulesofsailing.org/documents/14487/event",
  websiteUrl: "https://www.sailing.org.sg/events/354194",
  registrationUrl: "https://www.sailing.org.sg/events/323705",
  scheduleSummary:
    "Weekend 1 (5–7 Sep): Optimist Silver, Techno 293, WingFoil. Weekend 2 (11–13 Sep): Optimist Gold, ILCA 4, ILCA 6/7, 29er.",
  scoringRules:
    "1 race constitutes a series. 5–9 races: 1 discard. 10+ races: 2 discards (RRS Appendix A).",
  slices: [
    {
      key: "optimist-gold",
      label: "Optimist Gold",
      series: "optimist",
      slugIncludes: ["snsc", "gold", "sep-26"],
    },
    {
      key: "optimist-silver",
      label: "Optimist Silver",
      series: "optimist",
      slugIncludes: ["snsc", "silver", "sep-26"],
    },
    {
      key: "ilca-4",
      label: "ILCA 4",
      series: "ilca4",
      slugIncludes: ["snsc", "ilca", "sep-26"],
    },
    {
      key: "wingfoil",
      label: "WingFoil",
      series: "wingfoil",
      staticId: "snsc-2026-wingfoil",
    },
    {
      key: "techno-293",
      label: "Techno 293",
      series: "techno293",
      staticId: "techno-snsc-2026",
    },
  ],
};

export const REGATTA_EVENTS: RegattaEventDef[] = [SNSC_2026_EVENT];

export function getRegattaEvent(slug: string): RegattaEventDef | null {
  const s = String(slug || "").toLowerCase();
  if (!s) return null;
  return REGATTA_EVENTS.find((event) => event.slug === s) ?? null;
}

export function sliceMatchesRegattaSlug(
  slice: RegattaEventSliceDef,
  regattaSlug: string
): boolean {
  if (!slice.slugIncludes?.length) return false;
  const slug = String(regattaSlug || "").toLowerCase();
  return slice.slugIncludes.every((token) => slug.includes(token));
}

export type ResolvedEventSlice = {
  def: RegattaEventSliceDef;
  /** Matched regattas-table row for Optimist / ILCA slices, else null. */
  regatta: RegattaRecord | null;
};

/**
 * Match an event's class/division slices to live regattas rows.
 * Each regatta row is claimed by at most one slice (first match in
 * registry order wins).
 */
export function resolveEventSlices(
  event: RegattaEventDef,
  regattas: RegattaRecord[]
): ResolvedEventSlice[] {
  const claimed = new Set<string>();
  return event.slices.map((def) => {
    if (!def.slugIncludes?.length) return { def, regatta: null };
    const regatta =
      regattas.find(
        (r) => !claimed.has(r.id) && sliceMatchesRegattaSlug(def, r.slug)
      ) ?? null;
    if (regatta) claimed.add(regatta.id);
    return { def, regatta };
  });
}

/** Static scoreboard entry for board-class slices (WingFoil / Techno 293). */
export function getStaticBoardRegatta(
  slice: RegattaEventSliceDef
): WingfoilRegatta | Techno293Regatta | null {
  if (!slice.staticId) return null;
  if (slice.series === "wingfoil") {
    return (
      SINGAPORE_WINGFOIL_REGATTAS.find((r) => r.id === slice.staticId) ?? null
    );
  }
  if (slice.series === "techno293") {
    return (
      SINGAPORE_TECHNO293_REGATTAS.find((r) => r.id === slice.staticId) ?? null
    );
  }
  return null;
}

/**
 * Default tab: first slice that has any results to show (matched DB row or
 * static board data), falling back to the first slice in registry order.
 */
export function defaultEventFleetKey(
  event: RegattaEventDef,
  slices: ResolvedEventSlice[]
): string {
  const withData = slices.find(
    (slice) => slice.regatta || getStaticBoardRegatta(slice.def)
  );
  return withData?.def.key ?? slices[0]?.def.key ?? event.slices[0]?.key ?? "";
}
