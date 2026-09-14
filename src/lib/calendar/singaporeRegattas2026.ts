/**
 * 2026 Singapore Sailing Regatta Master Calendar
 *
 * Official and key youth regattas across Optimist, ILCA 4, ILCA 6, and WingFoil.
 * Includes Notice of Race (NOR), registration links, venues, and selection designations.
 */

export type RegattaCalendarEntry = {
  name: string;
  slug: string;
  startDate: string; // YYYY-MM-DD
  endDate?: string;  // YYYY-MM-DD
  boatClass: string; // e.g. "Optimist", "ILCA 4", "ILCA 6", "WingFoil", "All"
  division: string;  // e.g. "National", "Gold", "Silver", "Open"
  venue: string;     // e.g. "National Sailing Centre"
  organizer: string; // e.g. "Singapore Sailing Federation"
  countsForRanking: boolean;
  isSelectionTrial: boolean;
  norUrl?: string | null;
  registrationUrl?: string | null;
  scheduleNotes?: string | null;
  totalFleetSize: number;
};

export const SINGAPORE_REGATTAS_2026: RegattaCalendarEntry[] = [
  {
    name: "Singapore Youth Sailing Championships 2026",
    slug: "singapore-youth-sailing-championships-2026",
    startDate: "2026-06-20",
    endDate: "2026-06-23",
    boatClass: "Optimist",
    division: "National",
    venue: "National Sailing Centre, East Coast",
    organizer: "Singapore Sailing Federation",
    countsForRanking: true,
    isSelectionTrial: true,
    norUrl: "https://singaporesailing.org.sg/events/sysc-2026-nor.pdf",
    registrationUrl: "https://singaporesailing.org.sg/events/sysc-2026",
    scheduleNotes: "Official Selection Trial #1 for Optimist Asian Games & Perth Camp squad. 4 days of fleet racing.",
    totalFleetSize: 110,
  },
  {
    name: "Singapore Youth Sailing Championships 2026 (ILCA 4)",
    slug: "singapore-youth-sailing-championships-2026-ilca4",
    startDate: "2026-06-20",
    endDate: "2026-06-23",
    boatClass: "ILCA 4",
    division: "National",
    venue: "National Sailing Centre, East Coast",
    organizer: "Singapore Sailing Federation",
    countsForRanking: true,
    isSelectionTrial: true,
    norUrl: "https://singaporesailing.org.sg/events/sysc-2026-nor.pdf",
    registrationUrl: "https://singaporesailing.org.sg/events/sysc-2026",
    scheduleNotes: "National ranking series scoring event for ILCA 4 youth fleet.",
    totalFleetSize: 45,
  },
  {
    name: "Changi Sailing Club Youth Championship 2026",
    slug: "csc-youth-championship-2026",
    startDate: "2026-07-18",
    endDate: "2026-07-19",
    boatClass: "Optimist",
    division: "Gold / Silver",
    venue: "Changi Sailing Club",
    organizer: "Changi Sailing Club",
    countsForRanking: true,
    isSelectionTrial: false,
    norUrl: "https://csc.org.sg/sailing/youth-champ-2026-nor.pdf",
    registrationUrl: "https://csc.org.sg/regattas/youth-champ-2026",
    scheduleNotes: "Changi waters tidal racing. 6 races scheduled over 2 days.",
    totalFleetSize: 85,
  },
  {
    name: "Pesta Sukan Regatta 2026 (Optimist)",
    slug: "pesta-sukan-regatta-2026-optimist",
    startDate: "2026-08-01",
    endDate: "2026-08-03",
    boatClass: "Optimist",
    division: "Gold / Silver",
    venue: "National Sailing Centre, East Coast",
    organizer: "Singapore Sailing Federation",
    countsForRanking: true,
    isSelectionTrial: false,
    norUrl: "https://singaporesailing.org.sg/events/pesta-sukan-2026-nor.pdf",
    registrationUrl: "https://singaporesailing.org.sg/events/pesta-sukan-2026",
    scheduleNotes: "Annual national community sports festival regatta. Optimist Gold and Silver series scoring.",
    totalFleetSize: 120,
  },
  {
    name: "Pesta Sukan Regatta 2026 (ILCA & WingFoil)",
    slug: "pesta-sukan-regatta-2026-ilca-wingfoil",
    startDate: "2026-08-08",
    endDate: "2026-08-09",
    boatClass: "ILCA 4",
    division: "National",
    venue: "National Sailing Centre, East Coast",
    organizer: "Singapore Sailing Federation",
    countsForRanking: true,
    isSelectionTrial: false,
    norUrl: "https://singaporesailing.org.sg/events/pesta-sukan-2026-ilca-nor.pdf",
    registrationUrl: "https://singaporesailing.org.sg/events/pesta-sukan-2026",
    scheduleNotes: "ILCA 4, ILCA 6, and WingFoil slalom/course racing weekend.",
    totalFleetSize: 60,
  },
  {
    name: "2026 SSF Selection Trials",
    slug: "ssf-selection-trials-2026",
    startDate: "2026-08-22",
    endDate: "2026-08-30",
    boatClass: "Optimist",
    division: "Gold",
    venue: "National Sailing Centre, East Coast",
    organizer: "Singapore Sailing Federation",
    countsForRanking: true,
    isSelectionTrial: true,
    norUrl: "https://singaporesailing.org.sg/events/ssf-trials-2026-nor.pdf",
    registrationUrl: "https://singaporesailing.org.sg/events/selection-trials-2026",
    scheduleNotes: "High-intensity multi-weekend trials. Combined scores determine Asian Games & Perth Camp national squads.",
    totalFleetSize: 70,
  },
  {
    name: "Singapore National Sailing Championships 2026",
    slug: "singapore-national-sailing-championships-2026",
    startDate: "2026-09-11",
    endDate: "2026-09-13",
    boatClass: "Optimist",
    division: "National",
    venue: "National Sailing Centre, East Coast",
    organizer: "Singapore Sailing Federation",
    countsForRanking: true,
    isSelectionTrial: true,
    norUrl: "https://singaporesailing.org.sg/events/snsc-2026-nor.pdf",
    registrationUrl: "https://singaporesailing.org.sg/events/snsc-2026",
    scheduleNotes: "Final Optimist selection event. Determines final qualification cutoffs and national titles.",
    totalFleetSize: 130,
  },
  {
    name: "SAF Yacht Club Open Regatta 2026",
    slug: "safyc-open-regatta-2026",
    startDate: "2026-10-17",
    endDate: "2026-10-18",
    boatClass: "Optimist",
    division: "Gold / Silver",
    venue: "SAF Yacht Club, Sembawang",
    organizer: "SAF Yacht Club",
    countsForRanking: true,
    isSelectionTrial: false,
    norUrl: "https://safyc.org.sg/events/open-regatta-2026-nor.pdf",
    registrationUrl: "https://safyc.org.sg/events/open-regatta-2026",
    scheduleNotes: "Straits of Johor coastal waters. Pre-intake ranking points for 1 Jan intake.",
    totalFleetSize: 75,
  },
  {
    name: "2026 Optimist Asian & Oceania Championship",
    slug: "2026-optimist-asian-oceania-championship",
    startDate: "2026-12-12",
    endDate: "2026-12-19",
    boatClass: "Optimist",
    division: "International",
    venue: "Colombo, Sri Lanka",
    organizer: "IODA / Yachting Association of Sri Lanka",
    countsForRanking: false,
    isSelectionTrial: false,
    norUrl: "https://optiworld.org/events/asian-oceania-2026-nor.pdf",
    registrationUrl: "https://optiworld.org/events/asian-oceania-2026",
    scheduleNotes: "Official overseas campaign for the selected Singapore National Youth Team (Top 5 qualified).",
    totalFleetSize: 140,
  },
];
