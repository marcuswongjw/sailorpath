import type { PendingRegatta } from "@/lib/calendar/pendingRegattas";
import type { RegattaCalendarEntry } from "@/lib/calendar/singaporeRegattas2026";

/**
 * Upcoming X-15 events from the class's official calendar:
 * https://x-15class.org/events/ (checked 8 November 2026).
 *
 * Events with published dates become dated calendar cards. Events the class
 * lists only by month, or as TBD, stay in the "Dates to be confirmed" section
 * until the organiser publishes exact dates. Nothing here is an invented date.
 */
export const X15_OFFICIAL_CALENDAR_URL = "https://x-15class.org/events/";
const CLASS_ORGANISER = "International X-15 Class Association";

type X15ListingBase = {
  slug: string;
  name: string;
  year: "2026" | "2027";
  /** Human date label: exact days when published, otherwise the listed month. */
  period: string;
  venue: string;
  region: RegattaCalendarEntry["region"];
  geography: string;
  organizer?: string;
  officialUrl?: string;
  registrationUrl?: string | null;
  notes?: string;
};

export type X15DatedListing = X15ListingBase & {
  startDate: string;
  endDate: string;
  clinicDates?: string;
};
export type X15MonthListing = X15ListingBase & { startDate?: undefined };
export type X15Listing = X15DatedListing | X15MonthListing;

const ASIAN_CUP_FORM =
  "https://docs.google.com/forms/d/e/1FAIpQLSeYowVodOh1-Au0k6MkYQvhzoq6gQbySHmdkgk8xrcjYwFEYA/viewform";

/** Chronological. Same-day items keep the class calendar's own order. */
export const X15_LISTINGS: readonly X15Listing[] = [
  {
    slug: "x15-world-championships-2026",
    name: "X-15 World Championships 2026",
    year: "2026",
    period: "4–8 November 2026",
    startDate: "2026-11-04",
    endDate: "2026-11-08",
    venue: "Port Nàutic Ibiza, Spain",
    region: "Europe",
    geography: "ES",
    organizer: "Club Mare Nostrum",
    officialUrl: "https://x-15class.org/events/x-15-world-championships-2026/",
    notes:
      "Inaugural X-15 World Championships. Registration on 4 November, racing from that afternoon to 8 November. Five World Championship titles are awarded: Senior Male, Senior Female, Youth Male (U19), Youth Female (U19) and Junior (U15). Valid X-15 Class membership is required.",
  },
  {
    slug: "x15-emerging-nations-clinic-2026",
    name: "X-15 Emerging Nations Clinic 2026",
    year: "2026",
    period: "15–17 December 2026",
    startDate: "2026-12-15",
    endDate: "2026-12-17",
    venue: "Amara Watersports Club, Jomtien, Pattaya, Thailand",
    region: "Asia",
    geography: "TH",
    organizer: "X-15 Class",
    officialUrl: X15_OFFICIAL_CALENDAR_URL,
    notes:
      "Clinic for emerging X-15 nations, listed on the official X-15 Class calendar. Sign-up is by email to the class manager (ava@star-board.com).",
  },
  {
    slug: "x15-asian-cup-2026",
    name: "X-15 Asian Cup 2026",
    year: "2026",
    period: "18–20 December 2026",
    startDate: "2026-12-18",
    endDate: "2026-12-20",
    clinicDates: "Training 15–17 December 2026",
    venue: "Amara Watersports Club, Jomtien, Pattaya, Thailand",
    region: "Asia",
    geography: "TH",
    organizer: "X-15 Class",
    officialUrl: X15_OFFICIAL_CALENDAR_URL,
    registrationUrl: ASIAN_CUP_FORM,
    notes:
      "Marked “new date” on the official X-15 Class calendar: training 15–17 December, racing 18–20 December. The class site's menu still labels it Asian Champs 2026. Entry needs X-15 Class membership; riders under 18 need a guardian consent form.",
  },
  {
    slug: "singapore-open-windsurfing-foiling-2027",
    name: "46th Singapore Open Windsurfing and Foiling Championships 2027",
    year: "2027",
    period: "27–31 January 2027",
    startDate: "2027-01-27",
    endDate: "2027-01-31",
    venue: "Singapore (venue to be confirmed by the organiser)",
    region: "Singapore",
    geography: "SG",
    organizer: "Event organiser (see the Notice of Race)",
    officialUrl: X15_OFFICIAL_CALENDAR_URL,
    notes:
      "Listed on the official X-15 Class calendar. X-15 raced at the 44th edition in February 2025. Confirm the X-15 fleet, entry and venue with the organiser's Notice of Race.",
  },
  { slug: "x15-games-malaysia-2027", name: "X-15 Games Malaysia", year: "2027", period: "February 2027", venue: "Langkawi, Malaysia", region: "Asia", geography: "MY" },
  { slug: "x15-african-continental-championships-2027", name: "X-15 African Continental Championships", year: "2027", period: "March 2027", venue: "Soma Bay, Egypt", region: "International", geography: "EG" },
  { slug: "x15-america-one-racing-tour-1-2027", name: "America One Racing Foiling Tour #1", year: "2027", period: "March 2027", venue: "Long Beach, California, USA", region: "International", geography: "US" },
  { slug: "x15-north-american-championships-2027", name: "X-15 North American Championships", year: "2027", period: "April 2027", venue: "Hawaii, USA", region: "International", geography: "US" },
  { slug: "x15-games-italy-2027", name: "X-15 Games Italy", year: "2027", period: "May 2027", venue: "Lake Garda, Italy", region: "Europe", geography: "IT" },
  { slug: "x15-games-caribbean-2027", name: "X-15 Games Caribbean", year: "2027", period: "May 2027", venue: "Dragon Bay Sailing and Watersports Club, Grand Cayman, Cayman Islands", region: "International", geography: "KY" },
  { slug: "garnier-king-of-bay-2027", name: "Garnier King of Bay", year: "2027", period: "May 2027 (TBC)", venue: "Avenue of the Meritorious of the Sea, Rewa, Poland", region: "Europe", geography: "PL" },
  { slug: "x15-america-one-racing-tour-2-2027", name: "America One Racing Foiling Tour #2", year: "2027", period: "May 2027", venue: "Kaneohe, Hawaii, USA", region: "International", geography: "US" },
  {
    slug: "x15-games-poland-2027",
    name: "X-15 Games Poland",
    year: "2027",
    period: "18–20 June 2027",
    startDate: "2027-06-18",
    endDate: "2027-06-20",
    venue: "Górki Zachodnie, Poland",
    region: "Europe",
    geography: "PL",
    organizer: "X-15 Class",
    officialUrl: X15_OFFICIAL_CALENDAR_URL,
    notes: "Listed on the official X-15 Class calendar. Venue and entry details are published by the organiser.",
  },
  { slug: "x15-america-one-racing-tour-3-2027", name: "America One Racing Foiling Tour #3", year: "2027", period: "July 2027", venue: "Cascade Locks, Oregon, USA", region: "International", geography: "US" },
  { slug: "us-wingfoil-nationals-2027", name: "US Wingfoil Nationals", year: "2027", period: "July 2027", venue: "San Francisco, California, USA", region: "International", geography: "US" },
  {
    slug: "x15-peru-exhibition-2027",
    name: "X-15 Peru Exhibition",
    year: "2027",
    period: "10–12 July 2027",
    startDate: "2027-07-10",
    endDate: "2027-07-12",
    venue: "Paracas, Peru",
    region: "International",
    geography: "PE",
    organizer: "X-15 Class",
    officialUrl: X15_OFFICIAL_CALENDAR_URL,
    notes: "Exhibition event listed on the official X-15 Class calendar.",
  },
  {
    slug: "x15-games-scotland-2027",
    name: "X-15 Games Scotland",
    year: "2027",
    period: "26 July – 1 August 2027",
    startDate: "2027-07-26",
    endDate: "2027-08-01",
    venue: "Scotland, United Kingdom",
    region: "Europe",
    geography: "GB",
    organizer: "X-15 Class",
    officialUrl: X15_OFFICIAL_CALENDAR_URL,
    notes: "Listed on the official X-15 Class calendar. Exact venue is not yet published.",
  },
  {
    slug: "x15-games-norway-2027",
    name: "X-15 Games Norway",
    year: "2027",
    period: "6–8 August 2027",
    startDate: "2027-08-06",
    endDate: "2027-08-08",
    venue: "Arendal, Norway",
    region: "Europe",
    geography: "NO",
    organizer: "X-15 Class",
    officialUrl: X15_OFFICIAL_CALENDAR_URL,
    notes: "Listed on the official X-15 Class calendar.",
  },
  { slug: "x15-games-uk-2027", name: "X-15 Games UK", year: "2027", period: "Late August 2027", venue: "Portland, United Kingdom", region: "Europe", geography: "GB" },
  { slug: "x15-south-american-championships-2027", name: "X-15 South American Championships", year: "2027", period: "September 2027", venue: "Búzios, Brazil", region: "International", geography: "BR" },
  { slug: "x15-world-championships-2027", name: "X-15 World Championships 2027", year: "2027", period: "October 2027", venue: "Soma Bay, Egypt", region: "International", geography: "EG" },
  { slug: "x15-games-hong-kong-2027", name: "X-15 Games Hong Kong", year: "2027", period: "October 2027", venue: "Hong Kong", region: "Asia", geography: "HK" },
  { slug: "x15-european-championships-2027", name: "X-15 European Championships", year: "2027", period: "November 2027", venue: "Ibiza, Spain", region: "Europe", geography: "ES" },
  { slug: "x15-america-one-racing-tour-4-2027", name: "America One Racing Foiling Tour #4", year: "2027", period: "November 2027", venue: "Pensacola, Florida, USA", region: "International", geography: "US" },
  {
    slug: "x15-youth-world-championships-2027",
    name: "X-15 Youth World Championships",
    year: "2027",
    period: "10–18 December 2027",
    startDate: "2027-12-10",
    endDate: "2027-12-18",
    venue: "La Palma, Spain",
    region: "Europe",
    geography: "ES",
    organizer: "X-15 Class",
    officialUrl: X15_OFFICIAL_CALENDAR_URL,
    notes: "Listed on the official X-15 Class calendar.",
  },
  { slug: "x15-games-thailand-2027", name: "X-15 Games Thailand", year: "2027", period: "December 2027", venue: "Thailand", region: "Asia", geography: "TH" },
  { slug: "x15-games-china-2027", name: "X-15 Games China", year: "2027", period: "Date to be announced", venue: "China", region: "Asia", geography: "CN" },
  { slug: "x15-games-france-2027", name: "X-15 Games France", year: "2027", period: "Date to be announced", venue: "Marseille, France", region: "Europe", geography: "FR" },
  { slug: "x15-games-malta-2027", name: "X-15 Games Malta", year: "2027", period: "Date to be announced", venue: "Malta", region: "Europe", geography: "MT" },
  { slug: "x15-games-turkey-2027", name: "X-15 Games Turkey", year: "2027", period: "Date to be announced", venue: "Turkey", region: "International", geography: "TR" },
];

function isDated(listing: X15Listing): listing is X15DatedListing {
  return listing.startDate !== undefined;
}

/** Cards for events with published dates. */
export const X15_CALENDAR_ENTRIES: readonly RegattaCalendarEntry[] = X15_LISTINGS.filter(isDated).map((event) => ({
  name: event.name,
  slug: event.slug,
  startDate: event.startDate,
  endDate: event.endDate,
  boatClass: "X-15",
  classes: ["X-15"],
  division: "International",
  venue: event.venue,
  region: event.region,
  geography: event.geography,
  organizer: event.organizer ?? CLASS_ORGANISER,
  countsForRanking: false,
  isSelectionTrial: false,
  norUrl: event.officialUrl ?? X15_OFFICIAL_CALENDAR_URL,
  registrationUrl: event.registrationUrl ?? null,
  clinicDates: event.clinicDates,
  scheduleNotes: event.notes ?? null,
  totalFleetSize: 0,
}));

/** Events the class lists by month or as TBD. */
export const X15_PENDING_EVENTS: readonly PendingRegatta[] = X15_LISTINGS.filter((event) => !isDated(event)).map((event) => ({
  slug: event.slug,
  name: event.name,
  year: event.year,
  period: event.period,
  boatClass: "X-15",
  region: event.region,
  venue: event.venue,
  organizer: event.organizer ?? CLASS_ORGANISER,
  officialUrl: event.officialUrl ?? X15_OFFICIAL_CALENDAR_URL,
  notice: `Listed on the official X-15 Class calendar for ${event.period.replace(/^Date to be announced$/, "a date still to be announced")}. Exact dates are not yet published.`,
}));
