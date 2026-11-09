import { sailingClassKeyOf } from "@/lib/classRegistry";
import type { RegattaRecord } from "@/lib/ranking";

export const X15_SOURCE_CHECKED_ON = "9 November 2026";

export const X15_WORLDS_2026 = {
  eventSlug: "x15-world-championships-2026",
  name: "X-15 World Championships 2026",
  boatClass: "X-15",
  startDate: "2026-11-04",
  endDate: "2026-11-08",
  dates: "4–8 November 2026",
  venue: "Port Nàutic Ibiza, Spain",
  organiser: "Club Mare Nostrum",
  websiteUrl: "https://x-15class.org/events/x-15-world-championships-2026/",
  noticeUrl: "https://x-15class.org/blog/entries-open-for-the-first-x-15-world-championships/",
  fleetReportUrl: "https://x-15class.org/blog/2026-x-15-world-championships-welcome-107-sailors-from-24-nations/",
  confirmedFleetSummary: "107 riders from 24 nations (including 53 youth and junior riders across U13, U15, U17 and U19)",
  countsForRanking: false,
  // Advertised titles are not an assumed list of independently scored fleets.
  advertisedTitles: ["Senior male", "Senior female", "Youth male U19", "Youth female U19", "Junior U15"],
} as const;

export const X15_ASIANS_2026 = {
  name: "X-15 Asian Cup 2026 (Asian Championships)",
  dates: "18–20 December 2026",
  training: "15–17 December training",
  clinicName: "X-15 Emerging Nations Clinic",
  clinicContactEmail: "ava@star-board.com",
  venue: "Amara Watersports Club, Jomtien, Thailand",
  registrationUrl: "https://docs.google.com/forms/d/e/1FAIpQLSeYowVodOh1-Au0k6MkYQvhzoq6gQbySHmdkgk8xrcjYwFEYA/viewform",
  calendarUrl: "https://x-15class.org/events/",
  sourceUrl: "https://wingfoil.or.jp/x-15-asian-championships-2026/",
} as const;

export const X15_AGM_2026 = {
  date: "14 November 2026",
  title: "International X-15 Class AGM & 2026 Elections",
  noticeUrl: "https://x-15class.org/blog/official-notice-international-x-15-class-agm-2026-elections-14-november-2026/",
} as const;

export const X15_QUICK_FACTS = [
  { label: "World Sailing status", value: "Official One-Design Class", detail: "Recognised 8 Nov 2025 (Dún Laoghaire)" },
  { label: "One-design board", value: "82L Lite Tech", detail: "Single hull across all youth & senior divisions" },
  { label: "Standard foil set", value: "880 cm² front · 200 cm² tail", detail: "69 cm fuselage + optional 560 / 1200 cm² front wings" },
  { label: "Age & gender divisions", value: "U13 · U15 · U17 · U19 · Senior", detail: "2-wing quiver limit from U15 upward" },
] as const;

export const X15_EQUIPMENT_OVERVIEW = {
  board: "82L Lite Tech (all divisions)",
  defaultFrontFoil: "880 cm² front wing (optional 560 cm² and 1200 cm²)",
  tailAndFuselage: "200 cm² tail wing · 69 cm fuselage · angled rake shims permitted",
  evolutionPolicy: "Two-year equipment evolution cycle; previous-generation masts, wings and foils remain class-legal for 2026 competition.",
  equipmentUrl: "https://x-15class.org/equipment/",
  rulesUrl: "https://x-15class.org/rules/",
  hardwareCards: [
    {
      title: "82L Lite Tech One-Design Board",
      subtitle: "All divisions (U13 to Senior)",
      description: "Every division races on the same 82-litre Starboard X-15 Lite Tech board with a compact outline, low-drag bottom rocker and dual footstrap rows. Each board removes 6 kg of coastal plastic and plants three mangrove trees.",
      imageSrc: "/classes/x15/equipment-board-82l.jpg",
      imageAlt: "Four red Starboard X-15 82L Lite Tech one-design wingfoil boards lined up on a sandy beach",
      width: 720,
      height: 719,
    },
    {
      title: "Division-Matched X-15 Wing Quiver",
      subtitle: "4.5m to 6.5m class wings",
      description: "Riders register up to two class-approved X-15 wings (one 4.5m wing in U13) matched to their age and gender division, keeping racing fair across 6 to 25+ knots without an expensive quiver arms race.",
      imageSrc: "/classes/x15/equipment-wing.jpg",
      imageAlt: "Overhead view of an X-15 wingfoil racer foiling upwind with a red and white X-15 one-design wing",
      width: 720,
      height: 719,
    },
    {
      title: "100cm Mast & Modular Foil System",
      subtitle: "880 cm² default · 560 / 1200 cm² options",
      description: "U13 and U15 use the 100cm V8 Aluminium DT mast, while U17, U19 and Seniors race on the 100cm Carbon DT mast—paired with a 69 cm fuselage, 200 cm² tail wing, and angled shims for rake tuning.",
      imageSrc: "/classes/x15/equipment-foil-system.jpg",
      imageAlt: "Exploded view of the X-15 100cm mast, 69cm fuselage, 200cm² tail wing, and 560, 880, and 1200 cm² front foil wings",
      width: 720,
      height: 720,
    },
  ],
  divisions: [
    { division: "U13", mastTier: "Alu Mast", wings: "4.5m (1 wing)", mast: "100cm V8 Alu DT Base", foil: "880 / 200 / 69" },
    { division: "U15", mastTier: "Alu Mast", wings: "5m & 4m", mast: "100cm V8 Alu DT Base", foil: "880 / 200 / 69" },
    { division: "U17", mastTier: "Carbon Mast", wings: "5.5m & 4m", mast: "100cm Carbon DT Base", foil: "880 / 200 / 69" },
    { division: "U19", mastTier: "Carbon Mast", wings: "6m & 4.5m", mast: "100cm Carbon DT Base", foil: "880 / 200 / 69" },
    { division: "Senior Female", mastTier: "Carbon Mast", wings: "6m & 4.5m", mast: "100cm Carbon DT Base", foil: "880 / 200 / 69" },
    { division: "Senior Male", mastTier: "Carbon Mast", wings: "6.5m & 5m", mast: "100cm Carbon DT Base", foil: "880 / 200 / 69" },
  ],
} as const;

export const X15_NATIONAL_ASSOCIATIONS = [
  { country: "Singapore", body: "Singapore Sailing Federation", href: "https://sailing.org.sg/" },
  { country: "Thailand", body: "Pattaya Wingfoil Club", href: "https://x-15class.org/national-associations/" },
  { country: "Hong Kong", body: "Windsurfing Association of Hong Kong (WAHK)", href: "https://www.windsurfing.org.hk/" },
  { country: "China", body: "RYHC Sailing Team", href: "https://x-15class.org/national-associations/" },
  { country: "Taiwan", body: "Chinese Taipei Sailing Association", href: "https://www.sailing.org.tw/" },
  { country: "Australia", body: "Australian Wing Foil Racing Class Association", href: "https://www.sailing.org.au/" },
  { country: "United Kingdom", body: "Royal Yachting Association (RYA)", href: "https://www.rya.org.uk/" },
  { country: "Norway", body: "Norsk Brettseilerklubb (NBK)", href: "https://nbk.no/" },
  { country: "Poland", body: "Polish Wing Sports Association", href: "https://pswing.pl/" },
  { country: "Netherlands", body: "Royal Netherlands Watersports Association", href: "https://www.watersportverbond.nl/" },
  { country: "Canada", body: "WeCANFoil", href: "https://wecanfoil.org/" },
  { country: "Argentina", body: "Argentine Wingfoil Association", href: "https://x-15class.org/national-associations/" },
] as const;

export const X15_HISTORY = [
  {
    date: "July 2023",
    title: "The first test event",
    copy: "Foiling Week at Lake Garda introduced the one-design racing format.",
    href: "https://x-15class.org/blog/news/foiling-week-2023-premieres-x-15-class-wingfoiling-event-at-lake-garda/",
  },
  {
    date: "December 2024",
    title: "Racing in Pattaya",
    copy: "The class expanded its Asian racing programme with a 25-rider event.",
    href: "https://x-15class.org/blog/news/x-15-class-wingfoil-one-design-shines-at-pattaya-international-windsurfing-championships/",
  },
  {
    date: "14–18 February 2025",
    title: "Singapore Open debut",
    copy: "X-15 joined the 44th Singapore Open at Constant Wind Sea Sports Centre.",
    href: "https://x-15class.org/blog/news/thailand-leads-the-charge-as-x-15-class-makes-impactful-debut-at-the-44th-singapore-open/",
  },
  {
    date: "8 November 2025",
    title: "World Sailing recognition",
    copy: "Recognised in Dún Laoghaire, Ireland as World Sailing’s first official one-design wingfoil class, named in tribute to windsurfing and winging pioneer Jim Drake.",
    href: "https://x-15class.org/about/",
  },
  {
    date: "February 2026",
    title: "Langkawi opens the season",
    copy: "Riders from seven nations raced 11 races at the 22nd Langkawi International Regatta Perdana in the class’s first official event after World Sailing recognition.",
    href: "https://x-15class.org/blog/langkawi-2026-x15-racing/",
  },
  {
    date: "24–26 May 2026",
    title: "Record 115-rider fleet in Portimão",
    copy: "Clube Naval de Portimão hosted 115 registered riders from more than 15 nations at the X-15 Wingfoil Series in Portugal.",
    href: "https://x-15class.org/blog/record-fleet/",
  },
  {
    date: "4–8 November 2026",
    title: "Inaugural World Championships in Ibiza",
    copy: "107 riders from 24 nations (including 53 youth and junior sailors) gathered at Port Nàutic Ibiza for the first X-15 World Championships.",
    href: "https://x-15class.org/blog/2026-x-15-world-championships-welcome-107-sailors-from-24-nations/",
  },
] as const;

export function x15WorldsStatus(today: string, hasReviewedResults = false): string {
  if (hasReviewedResults) return "Results available";
  if (today < X15_WORLDS_2026.startDate) return "Upcoming";
  if (today <= X15_WORLDS_2026.endDate) return "Racing window";
  return "Awaiting reviewed results";
}

/** Only recorded, published X-15 sheets; a scheduled event is not a scorecard. */
export function publishedX15Sheets(rows: readonly (RegattaRecord & { status?: string })[]): RegattaRecord[] {
  return rows.filter((row) => sailingClassKeyOf(row.boatClass) === "x15" &&
    (!row.status || row.status === "published") &&
    (row.importedEntryCount ?? row.totalFleetSize) > 0)
    .sort((a, b) => b.date.localeCompare(a.date) || a.name.localeCompare(b.name));
}
