import type { RegattaRecord } from "@/lib/ranking";
import {
  SINGAPORE_WINGFOIL_REGATTAS,
  type WingfoilRegatta,
} from "@/lib/wingfoil";
import {
  SINGAPORE_TECHNO293_REGATTAS,
  type Techno293Regatta,
} from "@/lib/techno293";
import { isIlcaSeriesClass } from "@/lib/ilcaRanking";

/**
 * Event hub registry — pilot.
 *
 * One physical regatta (e.g. SNSC) is stored as several `regattas` rows,
 * one per class/division slice, plus static board-class entries. This
 * registry groups those slices under a single canonical event page
 * (/regattas/<event-slug>) until a proper event column exists on the
 * regattas table.
 */

import type {
  PublicationStatus,
  EventTimingStatus,
  ResultAvailabilityStatus,
  EventScheduleOccurrence,
  EventDocument,
} from "@/lib/types/regattaEventModel";

export type RegattaEventSliceDef = {
  /** Value used in ?fleet= on the event hub page. */
  key: string;
  /** Tab label, e.g. "Optimist Gold". */
  label: string;
  series:
    | "optimist"
    | "ilca4"
    | "ilca6"
    | "ilca7"
    | "wingfoil"
    | "techno293"
    | "windsurfing"
    | "29er"
    | "iqfoil";
  /**
   * Regattas-table slice: lowercased regatta slug must contain every token.
   */
  slugIncludes?: string[];
  /** Alternate token sets: matches if any set has all its tokens in the slug. */
  alternateSlugIncludes?: string[][];
  /** Reject a slug that contains any of these tokens. */
  slugExcludes?: string[];
  /** Static-data id for board classes served outside the regattas table. */
  staticId?: string;
  /** Exact prize-schedule fleet name, when this slice has verified winners. */
  prizeFleetName?: string;
  /** Result availability status override if known, otherwise derived from results count */
  resultStatus?: ResultAvailabilityStatus;
  /** Result type: fleet race, GPS challenge, marathon, etc. */
  resultType?: string;
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
  publicationStatus?: PublicationStatus;
  schedules?: EventScheduleOccurrence[];
  documents?: EventDocument[];
  seriesLinks?: {
    seriesId: string;
    seriesName: string;
    seriesSlug: string;
    roundLabel: string;
  }[];
  slices: RegattaEventSliceDef[];
};

export const SNSC_2025_EVENT: RegattaEventDef = {
  slug: "snsc-2025",
  name: "Singapore National Sailing Championships 2025",
  shortName: "SNSC 2025",
  datesText: "6–9 September 2025",
  venue: "National Sailing Centre, Singapore",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/11799/event",
  officialNoticeBoardUrl:
    "https://www.racingrulesofsailing.org/documents/11799/event",
  websiteUrl: "https://www.sailing.org.sg/events/298131",
  scheduleSummary:
    "6–9 September 2025 at National Sailing Centre. Scoring: 10 or more races sailed = 2 discards.",
  scoringRules:
    "At least 3 races to constitute a series. 5–9 races: 1 discard. 10 or more races: 2 discards (RRS Appendix A). Section 20 Prizes: Category awards per NoR.",
  slices: [
    {
      key: "optimist-gold",
      label: "Optimist Gold",
      series: "optimist",
      slugIncludes: ["snsc", "gold", "sep-25"],
      alternateSlugIncludes: [
        ["singapore-national-sailing-championships-2025", "gold"],
        ["snsc-2025", "gold"],
      ],
      prizeFleetName: "Optimist Gold Fleet",
    },
    {
      key: "optimist-silver",
      label: "Optimist Silver",
      series: "optimist",
      slugIncludes: ["snsc", "silver", "sep-25"],
      alternateSlugIncludes: [
        ["singapore-national-sailing-championships-2025", "silver"],
        ["snsc-2025", "silver"],
      ],
      prizeFleetName: "Optimist Silver Fleet",
    },
    {
      key: "ilca-4",
      label: "ILCA 4",
      series: "ilca4",
      slugIncludes: ["snsc", "ilca-4", "sep-25"],
      alternateSlugIncludes: [
        ["singapore-national-sailing-championships-2025", "ilca4"],
        ["singapore-national-sailing-championships-2025", "ilca-4"],
        ["snsc-2025", "ilca4"],
        ["snsc-2025", "ilca-4"],
      ],
      prizeFleetName: "ILCA 4",
    },
    {
      key: "ilca-6",
      label: "ILCA 6",
      series: "ilca6",
      slugIncludes: ["snsc", "ilca-6", "sep-25"],
      alternateSlugIncludes: [
        ["singapore-national-sailing-championships-2025", "ilca6"],
        ["singapore-national-sailing-championships-2025", "ilca-6"],
        ["snsc-2025", "ilca6"],
        ["snsc-2025", "ilca-6"],
      ],
      prizeFleetName: "ILCA 6",
    },
    {
      key: "techno-293",
      label: "Techno 293",
      series: "techno293",
      slugIncludes: ["snsc", "techno-293", "sep-25"],
      staticId: "techno-snsc-2025",
      prizeFleetName: "Techno 293 / 293+",
    },
    {
      key: "wingfoil",
      label: "WingFoil",
      series: "wingfoil",
      slugIncludes: ["snsc", "wingfoil", "sep-25"],
      staticId: "snsc-2025-wingfoil",
      prizeFleetName: "WingFoil",
    },
    {
      key: "iqfoil",
      label: "iQFOiL",
      series: "iqfoil",
      slugIncludes: ["snsc", "iqfoil", "sep-25"],
      prizeFleetName: "iQFOiL",
    },
  ],
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
      alternateSlugIncludes: [
        ["singapore-national-sailing-championships-2026", "gold"],
        ["snsc-2026", "gold"],
      ],
      prizeFleetName: "Optimist Gold Fleet",
    },
    {
      key: "optimist-silver",
      label: "Optimist Silver",
      series: "optimist",
      slugIncludes: ["snsc", "silver", "sep-26"],
      alternateSlugIncludes: [
        ["singapore-national-sailing-championships-2026", "silver"],
        ["snsc-2026", "silver"],
      ],
      prizeFleetName: "Optimist Silver Fleet",
    },
    {
      key: "ilca-4",
      label: "ILCA 4",
      series: "ilca4",
      slugIncludes: ["snsc", "ilca-4", "sep-26"],
      alternateSlugIncludes: [
        ["singapore-national-sailing-championships-2026", "ilca4"],
        ["singapore-national-sailing-championships-2026", "ilca-4"],
        ["snsc-2026", "ilca4"],
        ["snsc-2026", "ilca-4"],
      ],
      prizeFleetName: "ILCA 4",
    },
    {
      key: "ilca-6",
      label: "ILCA 6",
      series: "ilca6",
      slugIncludes: ["snsc", "ilca-6", "sep-26"],
      alternateSlugIncludes: [
        ["singapore-national-sailing-championships-2026", "ilca6"],
        ["singapore-national-sailing-championships-2026", "ilca-6"],
        ["snsc-2026", "ilca6"],
        ["snsc-2026", "ilca-6"],
      ],
      prizeFleetName: "ILCA 6",
    },
    {
      key: "ilca-7",
      label: "ILCA 7",
      series: "ilca7",
      slugIncludes: ["snsc", "ilca-7", "sep-26"],
      alternateSlugIncludes: [
        ["singapore-national-sailing-championships-2026", "ilca7"],
        ["singapore-national-sailing-championships-2026", "ilca-7"],
        ["snsc-2026", "ilca7"],
        ["snsc-2026", "ilca-7"],
      ],
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
  datesText: "14–15 February 2026 (ILCA) & 28–29 March 2026 (Optimist)",
  venue: "NSRCC Seasports Centre, Singapore",
  organizer: "SAF Yacht Club",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/13551/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/13551/event",
  slices: fleetSlices("safyc", "2026", ["gold", "silver", "ilca4", "ilca6", "ilca7"], [], ["jul"]),
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
  slices: [
    ...fleetSlices("cincapura", "2026", ["gold", "silver", "ilca4", "ilca6"]),
    {
      key: "29er",
      label: "29er",
      series: "29er",
      slugIncludes: ["cincapura", "2026", "29er"],
      prizeFleetName: "29er",
    },
    {
      key: "techno-293",
      label: "Techno 293",
      series: "techno293",
      slugIncludes: ["cincapura", "2026", "techno-293"],
      prizeFleetName: "Techno 293",
    },
  ],
};

export const PESTA_SUKAN_2025_EVENT: RegattaEventDef = {
  slug: "pesta-sukan-2025",
  name: "Pesta Sukan Regatta 2025",
  shortName: "Pesta Sukan 2025",
  datesText: "2–3 August 2025",
  venue: "National Sailing Centre, Singapore",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl:
    "https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025",
  officialNoticeBoardUrl:
    "https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025",
  websiteUrl: "https://www.sailing.org.sg/events/293985",
  registrationUrl: "https://www.sailing.org.sg/events/293985",
  scheduleSummary:
    "2–3 August 2025 at National Sailing Centre. Official final results as of 4 August 2025. 3 races completed across all fleets (0 discards).",
  scoringRules:
    "1 race to constitute a series. Fewer than 4 races: all races count (0 discards per NoR 12.2a). Category awards per NoR Section 20.",
  slices: [
    {
      key: "optimist-gold",
      label: "Optimist Gold",
      series: "optimist",
      slugIncludes: ["pesta-sukan", "gold", "aug-25"],
      prizeFleetName: "Optimist Gold Fleet",
    },
    {
      key: "optimist-silver",
      label: "Optimist Silver",
      series: "optimist",
      slugIncludes: ["pesta-sukan", "silver", "aug-25"],
      prizeFleetName: "Optimist Silver Fleet",
    },
    {
      key: "ilca-4",
      label: "ILCA 4",
      series: "ilca4",
      slugIncludes: ["pesta-sukan", "ilca", "aug-25"],
      slugExcludes: ["ilca-6", "ilca6"],
      prizeFleetName: "ILCA 4",
    },
    {
      key: "ilca-6",
      label: "ILCA 6",
      series: "ilca6",
      slugIncludes: ["pesta-sukan", "ilca-6", "aug-25"],
      prizeFleetName: "ILCA 6",
    },
  ],
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
  slices: [
    ...fleetSlices("sysc", "2026", ["gold", "silver", "ilca4", "ilca6"]),
    {
      key: "29er",
      label: "29er",
      series: "29er",
      slugIncludes: ["sysc", "2026", "29er"],
      prizeFleetName: "29er",
    },
    {
      key: "techno-293",
      label: "Techno 293",
      series: "techno293",
      slugIncludes: ["sysc", "2026", "techno-293"],
      prizeFleetName: "Techno 293",
    },
    {
      key: "iqfoil",
      label: "iQFOiL",
      series: "iqfoil",
      slugIncludes: ["sysc", "2026", "iqfoil"],
      prizeFleetName: "iQFOiL",
    },
  ],
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

export const CSC_ILCA_29ER_2026_EVENT: RegattaEventDef = {
  slug: "6th-csc-ilca-29er-open-2026",
  name: "6th CSC ILCA & 29er Open 2026",
  shortName: "CSC ILCA & 29er 2026",
  datesText: "28 February & 1 March 2026",
  venue: "Changi Sailing Club, Singapore",
  organizer: "Changi Sailing Club",
  noticeOfRaceUrl: "https://www.csc.org.sg",
  officialNoticeBoardUrl: "https://www.csc.org.sg",
  registrationUrl: "https://www.csc.org.sg/csc-ilca-29er-championships-entry-form/",
  scheduleSummary:
    "28 February & 1 March 2026 at Changi Sailing Club. 7 races scheduled, max 5/day. Scoring: 5 or more races = 1 discard.",
  scoringRules:
    "At least 2 races to constitute a series. 5 or more races: 1 discard (RRS Appendix A). Section 15 Prizes: Top 3 for each category.",
  slices: [
    {
      key: "ilca-6",
      label: "ILCA 6",
      series: "ilca6",
      slugIncludes: ["csc", "2026", "ilca-6"],
      prizeFleetName: "ILCA 6",
    },
    {
      key: "29er",
      label: "29er",
      series: "29er",
      slugIncludes: ["csc", "2026", "29er"],
      prizeFleetName: "29er",
    },
  ],
};

export const RSYC_OPTIMIST_2026_EVENT: RegattaEventDef = {
  slug: "rsyc-optimist-silver-fleet-knockout-championship-2026",
  name: "RSYC Optimist Silver Fleet Knockout Championship 2026",
  shortName: "RSYC Silver Knockout 2026",
  datesText: "26–27 September 2026",
  venue: "Republic of Singapore Yacht Club, Singapore",
  organizer: "Republic of Singapore Yacht Club",
  noticeOfRaceUrl: "https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2026/",
  officialNoticeBoardUrl: "https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2026/",
  websiteUrl: "https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2026/",
  registrationUrl: "https://tinyurl.com/RSYCSilverFleetOKC2026",
  scheduleSummary:
    "26–27 September 2026 at Republic of Singapore Yacht Club. Knockout Series format: Qualifying Rounds, Repechage Round, Final Rounds, and Petite Final Rounds.",
  scoringRules:
    "Knockout progression format per Sailing Instructions. Appendix MR applies. Top 10 overall, Top 3 Female, Top 3 Under 10, Top 3 Under 8.",
  slices: [
    {
      key: "optimist-silver",
      label: "Optimist Silver",
      series: "optimist",
      slugIncludes: ["rsyc", "knockout", "2026"],
      slugExcludes: ["gold"],
      prizeFleetName: "Optimist Silver Fleet",
    },
  ],
};

export const RSYC_OPTIMIST_GOLD_2026_EVENT: RegattaEventDef = {
  slug: "rsyc-optimist-gold-fleet-knockout-championship-2026",
  name: "RSYC Optimist Gold Fleet Knockout Championship 2026",
  shortName: "RSYC Gold Knockout 2026",
  datesText: "3–4 October 2026",
  venue: "Republic of Singapore Yacht Club, Singapore",
  organizer: "Republic of Singapore Yacht Club",
  noticeOfRaceUrl: "https://rsyc.org.sg/wp-content/uploads/2026/08/NOR_RSYC_Gold_KO_2026.pdf",
  officialNoticeBoardUrl:
    "https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-gold-fleet-knockout-championship-2026/",
  websiteUrl:
    "https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-gold-fleet-knockout-championship-2026/",
  registrationUrl: "https://tinyurl.com/RSYCGoldFleetOKC2026",
  scheduleSummary:
    "3–4 October 2026 at Republic of Singapore Yacht Club. Knockout Series: Qualifying, Repechage, Final, and Petite Final rounds. Competitor briefing 0900; first warning 1100; no warning after 1700. Up to 8 races per competitor.",
  scoringRules:
    "Knockout progression format per Sailing Instructions. World Sailing RRS 2025–2028 and Appendix MR apply. Prizes: Overall top 10; Female top 3; Under 13 top 3.",
  slices: [
    {
      key: "optimist-gold",
      label: "Optimist Gold",
      series: "optimist",
      slugIncludes: ["rsyc", "knockout", "2026", "gold"],
      prizeFleetName: "Optimist Gold Fleet",
    },
  ],
};

export const RSYC_OPTIMIST_2025_EVENT: RegattaEventDef = {
  slug: "rsyc-optimist-knockout-championship-2025",
  name: "RSYC Optimist Knockout Championship 2025",
  shortName: "RSYC Knockout 2025",
  datesText: "23–24 & 30–31 August 2025",
  venue: "Republic of Singapore Yacht Club, Singapore",
  organizer: "Republic of Singapore Yacht Club",
  noticeOfRaceUrl:
    "https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2025/",
  officialNoticeBoardUrl:
    "https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2025/",
  websiteUrl:
    "https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2025/",
  scheduleSummary:
    "Weekend 1 (23–24 Aug): Optimist Silver Fleet Knockout. Weekend 2 (30–31 Aug): Optimist Gold Fleet Knockout Race. Republic of Singapore Yacht Club.",
  scoringRules:
    "Knockout progression format per Sailing Instructions. Appendix MR applies. Top 10 overall, Top 3 Female, Top 3 Under 10, Top 3 Under 8.",
  slices: [
    {
      key: "optimist-gold",
      label: "Optimist Gold",
      series: "optimist",
      slugIncludes: ["rsyc", "gold", "2025"],
      prizeFleetName: "Optimist Gold Fleet",
    },
    {
      key: "optimist-silver",
      label: "Optimist Silver",
      series: "optimist",
      slugIncludes: ["rsyc", "silver", "2025"],
      prizeFleetName: "Optimist Silver Fleet",
    },
  ],
};

export const SAFYC_OPTIMIST_2025_EVENT: RegattaEventDef = {
  slug: "1st-safyc-optimist-championship-2025",
  name: "1st SAFYC Optimist Championship 2025",
  shortName: "SAFYC Optimist 2025",
  datesText: "12–13 July 2025",
  venue: "NSRCC Seasports Centre, Singapore",
  organizer: "SAF Yacht Club",
  noticeOfRaceUrl:
    "https://www.racingrulesofsailing.org/documents/11991/event?name=1st%20SAFYC%20Optimist%20Championship",
  officialNoticeBoardUrl:
    "https://www.racingrulesofsailing.org/documents/11991/event?name=1st%20SAFYC%20Optimist%20Championship",
  websiteUrl: "https://www.safyc.org.sg",
  scheduleSummary:
    "12–13 July 2025 at NSRCC Seasports Centre. 7 races scheduled (max 4/day). 1 discard after 4 races.",
  scoringRules:
    "Low Point System (RRS Appendix A). 1 race constitutes a series. 4 or more races completed = 1 discard.",
  slices: [
    {
      key: "optimist-gold",
      label: "Optimist Gold",
      series: "optimist",
      slugIncludes: ["safyc", "2025", "gold"],
      slugExcludes: ["feb", "21st"],
      prizeFleetName: "Optimist Gold Fleet",
    },
    {
      key: "optimist-silver",
      label: "Optimist Silver",
      series: "optimist",
      slugIncludes: ["safyc", "2025", "silver"],
      slugExcludes: ["feb", "21st"],
      prizeFleetName: "Optimist Silver Fleet",
    },
  ],
};

export const RAFFLES_MARINA_OPTIMIST_2025_EVENT: RegattaEventDef = {
  slug: "raffles-marina-optimist-regatta-2025",
  name: "Raffles Marina Optimist Regatta 2025",
  shortName: "RMOR 2025",
  datesText: "5–6 July 2025",
  venue: "Raffles Marina, Singapore",
  organizer: "Raffles Marina",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/11647/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/11647/event",
  websiteUrl: "https://www.rafflesmarina.com.sg",
  registrationUrl: "https://forms.gle/NcZ2DYN5zpe2p93A9",
  scheduleSummary:
    "5–6 July 2025 at Raffles Marina. Optimist Gold (8 races, max 4/day) and Optimist Silver (6 races, max 4/day). 1 discard after 4 races.",
  scoringRules:
    "Low Point System (RRS Appendix A). 1 race constitutes a series. 4 or more races completed = 1 discard. Graded penalty system per NoR Addendum C.",
  slices: [
    {
      key: "optimist-gold",
      label: "Optimist Gold",
      series: "optimist",
      slugIncludes: ["raffles", "2025", "gold"],
      prizeFleetName: "Optimist Gold Fleet",
    },
    {
      key: "optimist-silver",
      label: "Optimist Silver",
      series: "optimist",
      slugIncludes: ["raffles", "2025", "silver"],
      prizeFleetName: "Optimist Silver Fleet",
    },
  ],
};

export const NSC_CUP_2_2025_EVENT: RegattaEventDef = {
  slug: "nsc-cup-2-2025",
  name: "NSC Cup 2 2025",
  shortName: "NSC Cup 2 2025",
  datesText: "31 May – 1 June 2025",
  venue: "National Sailing Centre, Singapore",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl:
    "https://www.racingrulesofsailing.org/documents/10790/event?name=NSC%20Cup%20II%202025",
  officialNoticeBoardUrl:
    "https://www.racingrulesofsailing.org/documents/10790/event?name=NSC%20Cup%20II%202025",
  websiteUrl: "https://www.sailing.org.sg/events/282728",
  registrationUrl: "https://www.sailing.org.sg/events/282728",
  scheduleSummary:
    "31 May – 1 June 2025 at National Sailing Centre. Optimist Gold / ILCA 4 / ILCA 6 / ILCA 7 / 29er (6 races), Optimist Silver (5 races), Techno 293 (8 races), iQFOiL / WingFoil (10 races).",
  scoringRules:
    "Low Point System (RRS Appendix A). 1 race constitutes a series. 4 or more races completed = 1 discard.",
  slices: [
    {
      key: "optimist-gold",
      label: "Optimist Gold",
      series: "optimist",
      slugIncludes: ["nsc", "cup-2", "gold"],
      prizeFleetName: "Optimist Gold Fleet",
    },
    {
      key: "optimist-silver",
      label: "Optimist Silver",
      series: "optimist",
      slugIncludes: ["nsc", "cup-2", "silver"],
      prizeFleetName: "Optimist Silver Fleet",
    },
    {
      key: "ilca-4",
      label: "ILCA 4",
      series: "ilca4",
      slugIncludes: ["nsc", "cup-2", "ilca-4"],
      prizeFleetName: "ILCA 4",
    },
    {
      key: "ilca-6",
      label: "ILCA 6",
      series: "ilca6",
      slugIncludes: ["nsc", "cup-2", "ilca-6"],
      prizeFleetName: "ILCA 6",
    },
    {
      key: "ilca-7",
      label: "ILCA 7",
      series: "ilca7",
      slugIncludes: ["nsc", "cup-2", "ilca-7"],
      prizeFleetName: "ILCA 7",
    },
    {
      key: "29er",
      label: "29er",
      series: "29er",
      slugIncludes: ["nsc", "cup-2", "29er"],
      prizeFleetName: "29er",
    },
    {
      key: "techno-293",
      label: "Techno 293",
      series: "techno293",
      slugIncludes: ["nsc", "cup-2", "techno"],
      staticId: "techno-nsc-cup-2-2025",
      prizeFleetName: "Techno 293",
    },
    {
      key: "iqfoil",
      label: "iQFOiL",
      series: "iqfoil",
      slugIncludes: ["nsc", "cup-2", "iqfoil"],
      prizeFleetName: "iQFOiL",
    },
    {
      key: "wingfoil",
      label: "WingFoil",
      series: "wingfoil",
      slugIncludes: ["nsc", "cup-2", "wingfoil"],
      staticId: "wingfoil-nsc-cup-2-2025",
      prizeFleetName: "WingFoil",
    },
  ],
};

export const PSA_NATIONAL_ELIMINATION_SERIES_2026_EVENT: RegattaEventDef = {
  slug: "psa-national-elimination-series-2026",
  name: "PSA National Elimination Series 2026",
  shortName: "PSA Elimination 2026",
  datesText: "2026 (year-long · Phase 1 Jul–Aug)",
  venue: "NSC Manila Bay, Philippines",
  organizer: "Philippine Sailing Association",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/15290/event",
  officialNoticeBoardUrl:
    "https://www.racingrulesofsailing.org/documents/15290/event",
  scheduleSummary:
    "PSA year-long national elimination series for 2027 National Training Pool (NTP) selection. Phase 1 at NSC Manila Bay. Open fleets. Does not count toward Singapore ranking.",
  slices: [
    {
      key: "optimist",
      label: "Optimist Open",
      series: "optimist",
      slugIncludes: ["psa-national-elimination-series-2026-optimist"],
      prizeFleetName: "Optimist Open",
    },
    {
      key: "ilca-4",
      label: "ILCA 4",
      series: "ilca4",
      slugIncludes: ["psa-national-elimination-series-2026-ilca-4"],
      prizeFleetName: "ILCA 4",
    },
    {
      key: "ilca-6",
      label: "ILCA 6",
      series: "ilca6",
      slugIncludes: ["psa-national-elimination-series-2026-ilca-6"],
      prizeFleetName: "ILCA 6",
    },
    {
      key: "ilca-7",
      label: "ILCA 7",
      series: "ilca7",
      slugIncludes: ["psa-national-elimination-series-2026-ilca-7"],
      prizeFleetName: "ILCA 7",
    },
  ],
};


export const YOUTH_THAILAND_NATIONAL_SAILING_CHAMPIONSHIP_2026_EVENT: RegattaEventDef = {
  slug: "youth-thailand-national-sailing-championship-2026",
  name: "Youth Thailand National Sailing Championship 2026",
  shortName: "Youth Thailand 2026",
  datesText: "18–20 September 2026",
  venue: "YRAT Sattahip / Ao Dongtan",
  organizer: "Yacht Racing Association of Thailand",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/15865/event",
  officialNoticeBoardUrl:
    "https://www.racingrulesofsailing.org/documents/15865/event",
  websiteUrl:
    "https://sailingtech.in.th/preview/results/youth-thailand-2026/optimist-overall.html",
  scheduleSummary:
    "Thai youth nationals; open fleets (Optimist Open, ILCA 4). Does not count toward Singapore ranking.",
  slices: [
    {
      key: "optimist",
      label: "Optimist Open",
      series: "optimist",
      slugIncludes: ["youth-thailand-national-sailing-championship-2026-optimist"],
      prizeFleetName: "Optimist Open",
    },
    {
      key: "ilca-4",
      label: "ILCA 4",
      series: "ilca4",
      slugIncludes: ["youth-thailand-national-sailing-championship-2026-ilca-4"],
      prizeFleetName: "ILCA 4",
    },
  ],
};

const NE_MONSOON_2025_EVENTS: RegattaEventDef[] = [
  {
    slug: "ne-monsoon-grand-prix-2025-series-2",
    name: "2025 Northeast Monsoon Grand Prix Series 2",
    shortName: "2025 NE Monsoon Series 2",
    datesText: "8–9 February 2025",
    venue: "Changi Beach Park CP 1 / Tanah Merah, Singapore",
    organizer: "Singapore Sailing Federation",
    noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/128729",
    officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/10645/event",
    websiteUrl: "https://www.sailing.org.sg/events/263406",
    publicationStatus: "published",
    schedules: [
      {
        sessionId: "weekend-1",
        label: "Series 2 Racing",
        startDate: "2025-02-08",
        endDate: "2025-02-09",
        venue: "Changi Beach Park CP 1 / Tanah Merah, Singapore",
      },
    ],
    seriesLinks: [
      {
        seriesId: "ne-monsoon-2025",
        seriesName: "2025 Northeast Monsoon Grand Prix",
        seriesSlug: "ne-monsoon-2025",
        roundLabel: "Series 2",
      },
    ],
    slices: [
      {
        key: "windfoil",
        label: "Windfoil",
        series: "windsurfing",
        slugIncludes: ["ne-monsoon-grand-prix-2025-series-2-windfoil"],
        resultStatus: "provisional",
        resultType: "Course Race",
      },
      {
        key: "wingfoil",
        label: "Wingfoil",
        series: "wingfoil",
        staticId: "ne-monsoon-grand-prix-2025-series-2-wingfoil",
        resultStatus: "provisional",
        resultType: "Sprint Slalom",
      },
      {
        key: "techno293",
        label: "Techno 293",
        series: "techno293",
        staticId: "ne-monsoon-grand-prix-2025-series-2-techno293",
        resultStatus: "provisional",
        resultType: "One Design",
      },
    ],
  },
  {
    slug: "ne-monsoon-grand-prix-2025-gps-speed-challenge",
    name: "2025 Northeast Monsoon Grand Prix Series 3 GPS Speed Challenge",
    shortName: "2025 NE Monsoon GPS Speed Challenge",
    datesText: "25 January – 8 February 2025",
    venue: "Singapore waters",
    organizer: "Singapore Sailing Federation",
    noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/128729",
    officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/10645/event",
    websiteUrl: "https://www.sailing.org.sg/events/263406",
    publicationStatus: "published",
    schedules: [
      {
        sessionId: "gps-window",
        label: "GPS Window",
        startDate: "2025-01-25",
        endDate: "2025-02-08",
        venue: "Singapore waters",
        isDateRange: true,
      },
    ],
    seriesLinks: [
      {
        seriesId: "ne-monsoon-2025",
        seriesName: "2025 Northeast Monsoon Grand Prix",
        seriesSlug: "ne-monsoon-2025",
        roundLabel: "Series 3 (GPS Challenge)",
      },
    ],
    slices: [
      {
        key: "windfoil",
        label: "Windfoil",
        series: "windsurfing",
        slugIncludes: ["ne-monsoon-grand-prix-2025-gps-speed-challenge-windfoil"],
        resultStatus: "final",
        resultType: "GPS Speed Challenge",
      },
      {
        key: "wingfoil",
        label: "Wingfoil",
        series: "wingfoil",
        staticId: "ne-monsoon-grand-prix-2025-gps-speed-challenge-wingfoil",
        resultStatus: "final",
        resultType: "GPS Speed Challenge",
      },
      {
        key: "techno293",
        label: "Techno 293",
        series: "techno293",
        staticId: "ne-monsoon-grand-prix-2025-gps-speed-challenge-techno293",
        resultStatus: "final",
        resultType: "GPS Speed Challenge",
      },
    ],
  },
  {
    slug: "ne-monsoon-grand-prix-2025-combined",
    name: "2025 Northeast Monsoon Grand Prix Combined Series",
    shortName: "2025 NE Monsoon Combined Standings",
    datesText: "25 January – 9 February 2025",
    venue: "Changi Beach Park CP 1 / Tanah Merah, Singapore",
    organizer: "Singapore Sailing Federation",
    noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/128729",
    officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/10645/event",
    websiteUrl: "https://www.sailing.org.sg/events/263406",
    publicationStatus: "published",
    schedules: [
      {
        sessionId: "combined-period",
        label: "Championship Period",
        startDate: "2025-01-25",
        endDate: "2025-02-09",
        venue: "Changi Beach Park CP 1 / Tanah Merah, Singapore",
      },
    ],
    seriesLinks: [
      {
        seriesId: "ne-monsoon-2025",
        seriesName: "2025 Northeast Monsoon Grand Prix",
        seriesSlug: "ne-monsoon-2025",
        roundLabel: "Combined Standings",
      },
    ],
    slices: [
      {
        key: "windfoil",
        label: "Windfoil",
        series: "windsurfing",
        slugIncludes: ["ne-monsoon-grand-prix-2025-combined-windfoil"],
        resultStatus: "final",
        resultType: "Combined Standings",
      },
      {
        key: "wingfoil",
        label: "Wingfoil",
        series: "wingfoil",
        staticId: "ne-monsoon-grand-prix-2025-combined-wingfoil",
        resultStatus: "final",
        resultType: "Combined Standings",
      },
      {
        key: "techno293",
        label: "Techno 293",
        series: "techno293",
        staticId: "ne-monsoon-grand-prix-2025-combined-techno293",
        resultStatus: "final",
        resultType: "Combined Standings",
      },
    ],
  },
];

export const REGATTA_EVENTS: RegattaEventDef[] = [
  ...NE_MONSOON_2025_EVENTS,
  RSYC_OPTIMIST_2026_EVENT,
  RSYC_OPTIMIST_GOLD_2026_EVENT,
  RSYC_OPTIMIST_2025_EVENT,
  SAFYC_OPTIMIST_2025_EVENT,
  RAFFLES_MARINA_OPTIMIST_2025_EVENT,
  NSC_CUP_2_2025_EVENT,
  CSC_ILCA_29ER_2026_EVENT,
  SNSC_2026_EVENT,
  SNSC_2025_EVENT,
  TEMASEK_2026_EVENT,
  SAFYC_REGATTA_2026_EVENT,
  SAFYC_OPTIMIST_2026_EVENT,
  CINCAPURA_2026_EVENT,
  PESTA_SUKAN_2026_EVENT,
  PESTA_SUKAN_2025_EVENT,
  PULAU_UJONG_2026_EVENT,
  SYSC_2026_EVENT,
  SELECTION_TRIALS_2026_EVENT,
  PSA_NATIONAL_ELIMINATION_SERIES_2026_EVENT,
  YOUTH_THAILAND_NATIONAL_SAILING_CHAMPIONSHIP_2026_EVENT,
];

const EVENT_SLUG_ALIASES: Record<string, string> = {
  "rsyc-optimist-knockout-2026": "rsyc-optimist-silver-fleet-knockout-championship-2026",
  "rsyc-knockout-2026": "rsyc-optimist-silver-fleet-knockout-championship-2026",
  "rsyc-optimist-knockout-2025": "rsyc-optimist-knockout-championship-2025",
  "rsyc-knockout-2025": "rsyc-optimist-knockout-championship-2025",
  "rsyc-optimist-silver-fleet-knockout-championship-2025": "rsyc-optimist-knockout-championship-2025",
  "rsyc-optimist-gold-fleet-knockout-championship-2025": "rsyc-optimist-knockout-championship-2025",
  "rsyc-optimist-knockout-race-2025": "rsyc-optimist-knockout-championship-2025",
  "safyc-optimist-championship-2025": "1st-safyc-optimist-championship-2025",
  "1st-safyc-optimist-championships-2025": "1st-safyc-optimist-championship-2025",
  "safyc-optimist-2025": "1st-safyc-optimist-championship-2025",
  "rmor-2025": "raffles-marina-optimist-regatta-2025",
  "raffles-marina-2025": "raffles-marina-optimist-regatta-2025",
  "nsc-cup-ii-2025": "nsc-cup-2-2025",
  "nsc-cup-2": "nsc-cup-2-2025",
  "csc-ilca-29er-championships-2026": "6th-csc-ilca-29er-open-2026",
  "csc-ilca-open-2026": "6th-csc-ilca-29er-open-2026",
  "csc-ilca-29er-2026": "6th-csc-ilca-29er-open-2026",
  "singapore-national-sailing-championships-2026": "snsc-2026",
  "singapore-national-sailing-championships-2026-ilca4": "snsc-2026",
  "singapore-national-sailing-championships-2026-gold": "snsc-2026",
  "singapore-national-sailing-championships-2026-silver": "snsc-2026",
  "singapore-national-sailing-championships-2025": "snsc-2025",
  "singapore-national-sailing-championships-2025-ilca4": "snsc-2025",
  "singapore-national-sailing-championships-2025-gold": "snsc-2025",
  "singapore-national-sailing-championships-2025-silver": "snsc-2025",
  "pesta-sukan-regatta-2026-optimist": "pesta-sukan-2026",
  "pesta-sukan-regatta-2026-ilca-wingfoil": "pesta-sukan-2026",
  "pesta-sukan-regatta-2025-optimist": "pesta-sukan-2025",
  "pesta-sukan-regatta-2025-ilca": "pesta-sukan-2025",
  "pesta-sukan-regatta-2025": "pesta-sukan-2025",
  "singapore-youth-sailing-championships-2026": "sysc-2026",
  "singapore-youth-sailing-championships-2026-ilca4": "sysc-2026",
  "singapore-youth-sailing-championships-2026-gold": "sysc-2026",
  "singapore-youth-sailing-championships-2026-silver": "sysc-2026",
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

export function eventHubHref(
  eventSlug: string,
  fleetKey: string,
  calendarView?: "past"
): string {
  const params = new URLSearchParams({ fleet: fleetKey });
  if (calendarView === "past") params.set("calendar", "past");
  return `/regattas/${eventSlug}?${params.toString()}`;
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
  if (!slice.slugIncludes?.length && !slice.alternateSlugIncludes?.length) return false;
  const slug = String(regattaSlug || "").toLowerCase();
  if (slice.slugExcludes?.some((token) => slug.includes(token))) return false;

  const matchesAll = (tokens: string[]) =>
    tokens.every((token) => slug.includes(token));

  if (slice.slugIncludes?.length && matchesAll(slice.slugIncludes)) {
    return true;
  }
  if (slice.alternateSlugIncludes?.some((tokens) => matchesAll(tokens))) {
    return true;
  }
  return false;
}

export function isRegattaLinkedToEventSlice(
  event: RegattaEventDef,
  slice: RegattaEventSliceDef,
  regatta: RegattaRecord
): boolean {
  const rEventSlug = String(regatta.eventSlug || "").trim().toLowerCase();
  const canonicalREvent = rEventSlug ? (EVENT_SLUG_ALIASES[rEventSlug] || rEventSlug) : null;
  const canonicalEvent = event.slug.toLowerCase();

  const isEventLinked =
    canonicalREvent === canonicalEvent ||
    regatta.slug.toLowerCase().startsWith(canonicalEvent) ||
    EVENT_SLUG_ALIASES[regatta.slug.toLowerCase()] === canonicalEvent;

  if (!isEventLinked) return false;

  const boat = String(regatta.boatClass || "").trim();
  const division = String(regatta.division || "").trim().toLowerCase();
  const name = String(regatta.name || "").toLowerCase();
  const slug = String(regatta.slug || "").toLowerCase();

  if (slice.series === "optimist") {
    const isOpt =
      boat.toLowerCase().includes("optimist") ||
      name.includes("optimist") ||
      slug.includes("optimist");
    if (!isOpt && boat && !boat.toLowerCase().includes("opti")) return false;

    if (slice.key === "optimist-gold" || slice.key === "gold") {
      return division === "gold" || slug.includes("gold") || name.includes("gold");
    }
    if (slice.key === "optimist-silver" || slice.key === "silver") {
      return division === "silver" || slug.includes("silver") || name.includes("silver");
    }
    return !division && !slug.includes("gold") && !slug.includes("silver");
  }

  if (slice.series === "ilca4") {
    return (
      isIlcaSeriesClass(boat, "ILCA 4") ||
      slug.includes("ilca-4") ||
      slug.includes("ilca4") ||
      name.includes("ilca 4") ||
      name.includes("ilca4")
    );
  }

  if (slice.series === "ilca6") {
    return (
      isIlcaSeriesClass(boat, "ILCA 6") ||
      slug.includes("ilca-6") ||
      slug.includes("ilca6") ||
      name.includes("ilca 6") ||
      name.includes("ilca6")
    );
  }

  if (slice.series === "ilca7") {
    return (
      isIlcaSeriesClass(boat, "ILCA 7") ||
      slug.includes("ilca-7") ||
      slug.includes("ilca7") ||
      name.includes("ilca 7") ||
      name.includes("ilca7")
    );
  }

  if (slice.series === "29er") {
    return slug.includes("29er") || name.includes("29er") || boat.includes("29");
  }

  return false;
}

function fullerResultSheet(current: RegattaRecord, next: RegattaRecord): RegattaRecord {
  const races = (next.raceCount ?? 0) - (current.raceCount ?? 0);
  if (races !== 0) return races > 0 ? next : current;
  const fleet = (next.totalFleetSize ?? 0) - (current.totalFleetSize ?? 0);
  if (fleet !== 0) return fleet > 0 ? next : current;
  return (current.slug || "").length <= (next.slug || "").length ? current : next;
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
    if (!def.slugIncludes?.length && !def.alternateSlugIncludes?.length) {
      return { def, regatta: null };
    }
    const matches = regattas.filter((r) => {
      if (claimed.has(r.id)) return false;
      if (sliceMatchesRegattaSlug(def, r.slug)) return true;
      if (isRegattaLinkedToEventSlice(event, def, r)) return true;
      return false;
    });
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

/**
 * Returns exact result availability status for an event slice:
 * - 'final' | 'provisional' | 'unavailable'
 */
export function getSliceResultAvailability(
  slice: ResolvedEventSlice
): {
  status: ResultAvailabilityStatus;
  competitorCount: number;
  label: string;
} {
  if (slice.def.resultStatus) {
    let count = 0;
    if (slice.regatta?.totalFleetSize) {
      count = slice.regatta.totalFleetSize;
    } else {
      const board = getStaticBoardRegatta(slice.def);
      count = board?.results?.length ?? 0;
    }
    const label =
      slice.def.resultStatus === "provisional"
        ? `Provisional · ${count} competitors`
        : slice.def.resultStatus === "final"
        ? `Final · ${count} competitors`
        : "Results unavailable";
    return { status: slice.def.resultStatus, competitorCount: count, label };
  }

  if (slice.regatta) {
    const count = slice.regatta.totalFleetSize || 0;
    const isProv = slice.regatta.name.toLowerCase().includes("provisional");
    const status: ResultAvailabilityStatus = isProv ? "provisional" : "final";
    const label = `${isProv ? "Provisional" : "Final"} · ${count} competitors`;
    return { status, competitorCount: count, label };
  }

  const board = getStaticBoardRegatta(slice.def);
  if (board?.results?.length) {
    const count = board.results.length;
    const isProv = board.name.toLowerCase().includes("provisional");
    const status: ResultAvailabilityStatus = isProv ? "provisional" : "final";
    const label = `${isProv ? "Provisional" : "Final"} · ${count} competitors`;
    return { status, competitorCount: count, label };
  }

  return {
    status: "unavailable",
    competitorCount: 0,
    label: "Results unavailable",
  };
}
