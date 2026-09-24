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
  series: "optimist" | "ilca4" | "ilca6" | "ilca7" | "wingfoil" | "techno293";
  /**
   * Regattas-table slice: lowercased regatta slug must contain every token.
   */
  slugIncludes?: string[];
  /** Reject a slug that contains any of these tokens. */
  slugExcludes?: string[];
  /** Static-data id for board classes served outside the regattas table. */
  staticId?: string;
  /** Exact prize-schedule fleet name, when this slice has verified winners. */
  prizeFleetName?: string;
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
      prizeFleetName: "Optimist Gold Fleet",
    },
    {
      key: "optimist-silver",
      label: "Optimist Silver",
      series: "optimist",
      slugIncludes: ["snsc", "silver", "sep-26"],
      prizeFleetName: "Optimist Silver Fleet",
    },
    {
      key: "ilca-4",
      label: "ILCA 4",
      series: "ilca4",
      slugIncludes: ["snsc", "ilca-4", "sep-26"],
      prizeFleetName: "ILCA 4",
    },
    {
      key: "ilca-6",
      label: "ILCA 6",
      series: "ilca6",
      slugIncludes: ["snsc", "ilca-6", "sep-26"],
      prizeFleetName: "ILCA 6",
    },
    {
      key: "ilca-7",
      label: "ILCA 7",
      series: "ilca7",
      slugIncludes: ["snsc", "ilca-7", "sep-26"],
      prizeFleetName: "ILCA 7",
    },
    {
      key: "wingfoil",
      label: "WingFoil",
      series: "wingfoil",
      staticId: "snsc-2026-wingfoil",
      prizeFleetName: "WingFoil",
    },
    {
      key: "techno-293",
      label: "Techno 293",
      series: "techno293",
      staticId: "techno-snsc-2026",
      prizeFleetName: "Techno 293 / 293+",
    },
  ],
};

const ILCA4_EXCLUDES = ["gold", "silver", "ilca-6", "ilca6", "ilca-7", "ilca7", "29er"];
const ILCA6_EXCLUDES = ["gold", "silver", "ilca-4", "ilca4", "ilca-7", "ilca7", "29er"];
const ILCA7_EXCLUDES = ["gold", "silver", "ilca-4", "ilca4", "ilca-6", "ilca6", "29er"];

function fleetSlices(
  eventToken: string,
  yearToken: string,
  fleets: Array<"gold" | "silver" | "ilca4" | "ilca6" | "ilca7">,
  extraIncludes: string[] = [],
  extraExcludes: string[] = []
): RegattaEventSliceDef[] {
  return fleets.map((fleet) => {
    if (fleet === "ilca4") {
      return {
        key: "ilca-4",
        label: "ILCA 4",
        series: "ilca4" as const,
        slugIncludes: [eventToken, yearToken, "ilca", ...extraIncludes],
        slugExcludes: [...ILCA4_EXCLUDES, ...extraExcludes],
        prizeFleetName: "ILCA 4",
      };
    }
    if (fleet === "ilca6") {
      return {
        key: "ilca-6",
        label: "ILCA 6",
        series: "ilca6" as const,
        slugIncludes: [eventToken, yearToken, "ilca-6", ...extraIncludes],
        slugExcludes: [...ILCA6_EXCLUDES, ...extraExcludes],
        prizeFleetName: "ILCA 6",
      };
    }
    if (fleet === "ilca7") {
      return {
        key: "ilca-7",
        label: "ILCA 7",
        series: "ilca7" as const,
        slugIncludes: [eventToken, yearToken, "ilca-7", ...extraIncludes],
        slugExcludes: [...ILCA7_EXCLUDES, ...extraExcludes],
        prizeFleetName: "ILCA 7",
      };
    }
    const gold = fleet === "gold";
    return {
      key: gold ? "optimist-gold" : "optimist-silver",
      label: gold ? "Optimist Gold" : "Optimist Silver",
      series: "optimist" as const,
      slugIncludes: [eventToken, yearToken, fleet, ...extraIncludes],
      slugExcludes: ["ilca", ...extraExcludes],
      prizeFleetName: gold ? "Optimist Gold Fleet" : "Optimist Silver Fleet",
    };
  });
}

export const TEMASEK_2026_EVENT: RegattaEventDef = {
  slug: "temasek-regatta-2026",
  name: "Temasek Regatta 2026",
  shortName: "Temasek 2026",
  datesText: "20–21 June 2026",
  venue: "National Sailing Centre, Singapore",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/13596/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/13596/event",
  registrationUrl: "https://www.sailing.org.sg/events/335514",
  slices: fleetSlices("temasek", "2026", ["gold", "silver", "ilca4", "ilca6", "ilca7"]),
};

export const SAFYC_REGATTA_2026_EVENT: RegattaEventDef = {
  slug: "22nd-safyc-regatta-2026",
  name: "22nd SAFYC Regatta 2026",
  shortName: "SAFYC Regatta 2026",
  datesText: "28–29 March 2026",
  venue: "SAF Yacht Club, Sembawang",
  organizer: "SAF Yacht Club",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/13551/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/13551/event",
  slices: fleetSlices("safyc", "2026", ["gold", "silver"], ["mar-26"]),
};

export const SAFYC_OPTIMIST_2026_EVENT: RegattaEventDef = {
  slug: "2nd-safyc-optimist-championships-2026",
  name: "2nd SAFYC Optimist Championships 2026",
  shortName: "SAFYC Optimist 2026",
  datesText: "4–5 July 2026",
  venue: "NSRCC Seasports Centre, Singapore",
  organizer: "SAF Yacht Club",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/14691/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/14691/event",
  slices: fleetSlices("safyc", "2026", ["gold", "silver"], ["jul-26"]),
};

export const CINCAPURA_2026_EVENT: RegattaEventDef = {
  slug: "cincapura-regatta-2026",
  name: "Cincapura Regatta 2026",
  shortName: "Cincapura 2026",
  datesText: "20–21 July 2026",
  venue: "National Sailing Centre, Singapore",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/14587/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/14587/event",
  registrationUrl: "https://www.sailing.org.sg/events/356060",
  slices: fleetSlices("cincapura", "2026", ["gold", "silver", "ilca4", "ilca6"]),
};

export const PESTA_SUKAN_2026_EVENT: RegattaEventDef = {
  slug: "pesta-sukan-2026",
  name: "Pesta Sukan 2026",
  shortName: "Pesta Sukan 2026",
  datesText: "25–26 July & 1–2 August 2026",
  venue: "National Sailing Centre, Singapore",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl:
    "https://www.racingrulesofsailing.org/documents/14397/event?name=pesta-sukan-2026",
  officialNoticeBoardUrl:
    "https://www.racingrulesofsailing.org/documents/14397/event?name=pesta-sukan-2026",
  registrationUrl: "https://www.sailing.org.sg/events/351968",
  slices: fleetSlices("pesta-sukan", "2026", ["gold", "silver", "ilca4", "ilca6"]),
};

export const PULAU_UJONG_2026_EVENT: RegattaEventDef = {
  slug: "pulau-ujong-regatta-2026",
  name: "Pulau Ujong Regatta 2026",
  shortName: "Pulau Ujong 2026",
  datesText: "21–22 February 2026",
  venue: "National Sailing Centre, Singapore",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/13180/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/13180/event",
  slices: fleetSlices("pulau-ujong", "2026", ["gold", "silver", "ilca4", "ilca6"]),
};

export const SYSC_2026_EVENT: RegattaEventDef = {
  slug: "sysc-2026",
  name: "Singapore Youth Sailing Championships 2026",
  shortName: "SYSC 2026",
  datesText: "14–17 March 2026",
  venue: "National Sailing Centre, Singapore",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/13601/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/13601/event",
  slices: fleetSlices("sysc", "2026", ["gold", "silver", "ilca4", "ilca6"]),
};

export const SELECTION_TRIALS_2026_EVENT: RegattaEventDef = {
  slug: "ssf-selection-trials-2026",
  name: "2026 SSF Selection Trials",
  shortName: "Selection Trials 2026",
  datesText: "22–30 August 2026",
  venue: "National Sailing Centre, Singapore",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/200930",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/200930",
  slices: [
    {
      key: "optimist",
      label: "Optimist",
      series: "optimist",
      slugIncludes: ["selection-trials", "2026"],
      prizeFleetName: "Optimist Gold Fleet",
    },
  ],
};

export const REGATTA_EVENTS: RegattaEventDef[] = [
  SNSC_2026_EVENT,
  TEMASEK_2026_EVENT,
  SAFYC_REGATTA_2026_EVENT,
  SAFYC_OPTIMIST_2026_EVENT,
  CINCAPURA_2026_EVENT,
  PESTA_SUKAN_2026_EVENT,
  PULAU_UJONG_2026_EVENT,
  SYSC_2026_EVENT,
  SELECTION_TRIALS_2026_EVENT,
];

const EVENT_SLUG_ALIASES: Record<string, string> = {
  "singapore-national-sailing-championships-2026": "snsc-2026",
  "singapore-national-sailing-championships-2026-ilca4": "snsc-2026",
  "pesta-sukan-regatta-2026-optimist": "pesta-sukan-2026",
  "pesta-sukan-regatta-2026-ilca-wingfoil": "pesta-sukan-2026",
  "singapore-youth-sailing-championships-2026": "sysc-2026",
  "singapore-youth-sailing-championships-2026-ilca4": "sysc-2026",
};

/** Event hub entry for a class-slice slug such as snsc-ilca-4-sep-26-… */
export function findEventSliceForRegattaSlug(regattaSlug: string): {
  event: RegattaEventDef;
  slice: RegattaEventSliceDef;
} | null {
  for (const event of REGATTA_EVENTS) {
    const slice = event.slices.find((candidate) =>
      sliceMatchesRegattaSlug(candidate, regattaSlug)
    );
    if (slice) return { event, slice };
  }
  return null;
}

export function eventHubHref(eventSlug: string, fleetKey: string): string {
  return `/regattas/${eventSlug}?fleet=${encodeURIComponent(fleetKey)}`;
}

export function getRegattaEvent(slug: string): RegattaEventDef | null {
  const s = String(slug || "").toLowerCase();
  if (!s) return null;
  const canonical = EVENT_SLUG_ALIASES[s] || s;
  return REGATTA_EVENTS.find((event) => event.slug === canonical) ?? null;
}

export function sliceMatchesRegattaSlug(
  slice: RegattaEventSliceDef,
  regattaSlug: string
): boolean {
  if (!slice.slugIncludes?.length) return false;
  const slug = String(regattaSlug || "").toLowerCase();
  if (!slice.slugIncludes.every((token) => slug.includes(token))) return false;
  return !slice.slugExcludes?.some((token) => slug.includes(token));
}

function fullerResultSheet(current: RegattaRecord, next: RegattaRecord): RegattaRecord {
  const races = (next.raceCount ?? 0) - (current.raceCount ?? 0);
  if (races !== 0) return races > 0 ? next : current;
  const fleet = (next.totalFleetSize ?? 0) - (current.totalFleetSize ?? 0);
  if (fleet !== 0) return fleet > 0 ? next : current;
  return current.slug.length <= next.slug.length ? current : next;
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
    const matches = regattas.filter(
      (r) => !claimed.has(r.id) && sliceMatchesRegattaSlug(def, r.slug)
    );
    const regatta = matches.reduce<RegattaRecord | null>(
      (best, row) => (best ? fullerResultSheet(best, row) : row),
      null
    );
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
  const withData = slices.find((slice) => {
    if (slice.regatta) return true;
    return (getStaticBoardRegatta(slice.def)?.results?.length ?? 0) > 0;
  });
  return withData?.def.key ?? slices[0]?.def.key ?? event.slices[0]?.key ?? "";
}
