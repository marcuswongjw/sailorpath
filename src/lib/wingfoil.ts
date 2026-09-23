export type WingfoilRaceScore = {
  score: number;
  isDiscarded?: boolean;
  code?: "DNF" | "DNS" | "DSQ" | "DNC" | "RDG";
};

export type WingfoilSailorResult = {
  rank: number;
  name: string;
  sailNumber: string;
  gender: "M" | "F";
  ageCategory: string;
  schoolName: string;
  club: string;
  races: WingfoilRaceScore[];
  grossScore: number;
  nettScore: number;
};

export type WingfoilRegatta = {
  id: string;
  name: string;
  shortName: string;
  dates: string;
  venue: string;
  organizer: string;
  format:
    | "Sprint Slalom"
    | "Course Race"
    | "Marathon"
    | "Slalom / Course / Marathon";
  status: "Completed" | "Upcoming";
  lifecycleStatus?: "draft" | "in_review" | "published" | "archived";
  scoringSystem: string;
  rulesNotes: string;
  seriesName?: string;
  seriesPart?: string;
  websiteUrl?: string;
  noticeBoardUrl?: string;
  results?: WingfoilSailorResult[];
};

export const WINGFOIL_SPECIFICATIONS = {
  formatName: "Sprint Slalom (Downwind Slalom)",
  scoringSystem: "World Sailing RRS Appendix A / B8 (Low Point System)",
  targetTime: "4–5 minutes per heat",
  mark1TimeLimit: "90 seconds",
  raceTimeLimit: "7 minutes",
  finishingWindow: "4 minutes",
  courseType: "Downwind Slalom (Delta Cube Buoy & Finishing Vessel)",
  equipmentRule: "Open equipment — Any board, any wing size, any foil mast, and any foils permitted",
  windLimit: "Minimum 8–10 knots sustained foiling breeze",
  rankingPolicy:
    "Unlike dinghy classes (Optimist Best-3-of-5 and ILCA 4 High Points), Singapore WingFoil is contested as standalone event series with no rolling national ranking.",
};


const WINGFOIL_MONTHS: Record<string, number> = {
  jan: 1, january: 1,
  feb: 2, february: 2,
  mar: 3, march: 3,
  apr: 4, april: 4,
  may: 5,
  jun: 6, june: 6,
  jul: 7, july: 7,
  aug: 8, august: 8,
  sep: 9, sept: 9, september: 9,
  oct: 10, october: 10,
  nov: 11, november: 11,
  dec: 12, december: 12,
};

/**
 * Parse a human-readable regatta dates string into an epoch timestamp for sorting.
 * e.g., "10 - 11 October 2026", "5–7 September 2026", "28 Feb – 1 Mar & 7–8 Mar 2026", etc.
 */
export function parseWingfoilRegattaDate(datesStr: string | undefined | null): number {
  if (!datesStr || typeof datesStr !== "string") return 0;
  const s = datesStr.trim();
  if (!s) return 0;

  // 1. Direct ISO format check (YYYY-MM-DD)
  if (/^\d{4}-\d{2}-\d{2}/.test(s)) {
    const t = Date.parse(s.slice(0, 10));
    if (!Number.isNaN(t)) return t;
  }

  // 2. Extract year (e.g. 2026)
  const yMatch = s.match(/\b(20\d\d|19\d\d)\b/);
  const year = yMatch ? parseInt(yMatch[1], 10) : 2026;

  // 3. Find month and day
  const tokens = s.toLowerCase().split(/[^a-z0-9]+/);
  let month = 1;
  let day = 1;
  let foundMonth = false;

  for (let i = 0; i < tokens.length; i++) {
    const t = tokens[i];
    if (WINGFOIL_MONTHS[t]) {
      month = WINGFOIL_MONTHS[t];
      foundMonth = true;
      if (i > 0 && /^\d{1,2}$/.test(tokens[i - 1])) {
        const d = parseInt(tokens[i - 1], 10);
        if (d >= 1 && d <= 31) day = d;
      } else if (i + 1 < tokens.length && /^\d{1,2}$/.test(tokens[i + 1])) {
        const d = parseInt(tokens[i + 1], 10);
        if (d >= 1 && d <= 31) day = d;
      }
      break;
    }
  }

  if (!foundMonth) {
    const parsed = Date.parse(s);
    if (!Number.isNaN(parsed)) return parsed;
  }

  return new Date(Date.UTC(year, month - 1, day)).getTime();
}

/**
 * Sort wingfoil regattas in chronological order, with the latest one at the top (descending by date).
 */
export function sortWingfoilRegattas(regattas: WingfoilRegatta[]): WingfoilRegatta[] {
  return [...regattas].sort((a, b) => {
    const timeA = parseWingfoilRegattaDate(a.dates);
    const timeB = parseWingfoilRegattaDate(b.dates);
    if (timeB !== timeA) return timeB - timeA;
    return (b.id || "").localeCompare(a.id || "");
  });
}

export const SINGAPORE_WINGFOIL_REGATTAS: WingfoilRegatta[] = [
  {
    id: "sw-monsoon-series-gp3-2026",
    name: "2026 SW Monsoon Grand Prix 3 (Round 3 of 3)",
    shortName: "SW Monsoon GP3",
    dates: "10 - 11 October 2026",
    venue: "National Sailing Centre, Singapore",
    organizer: "Singapore Sailing Federation & Windsurfing Association Singapore",
    format: "Slalom / Course / Marathon",
    status: "Upcoming",
    scoringSystem: "Up to 24 races, Series Grand Finale (RRS B8)",
    seriesName: "2026 SW Monsoon Grand Prix Series",
    seriesPart: "Round 3 of 3 (Grand Finale)",
    websiteUrl: "https://www.sailing.org.sg/events/357398",
    noticeBoardUrl: "https://www.racingrulesofsailing.org/documents/14698/event",
    rulesNotes:
      "Championship Grand Finale of the 2026 SW Monsoon Grand Prix Series held at National Sailing Centre. Series coronation across all divisions.",
  },
{
    id: "snsc-2026-wingfoil",
    name: "Singapore National Sailing Championships 2026 — WingFoil Sprint Slalom",
    shortName: "SNSC 2026",
    dates: "5–7 September 2026",
    venue: "National Sailing Centre (NSC), Singapore",
    organizer: "Singapore Sailing Federation (SSF)",
    format: "Sprint Slalom",
    status: "Completed",
    scoringSystem: "9 races, 1 discard",
    rulesNotes:
      "Delta Buoy Slalom course, 4–5 min heat target time, 1 discard after 4+ races. Awards: Open 1st-3rd, Female 1st-3rd, 16&U 1st-3rd.",
    websiteUrl: "https://www.sailing.org.sg/events/354194",
    noticeBoardUrl: "https://www.racingrulesofsailing.org/documents/14487/event",
    results: [
      {
        rank: 1,
        name: "Kate En Rui Bateman",
        sailNumber: "21",
        gender: "F",
        ageCategory: "16&U",
        schoolName: "CHIJ Secondary (Toa Payoh)",
        club: "Windsurfing Association of Singapore",
        races: [
          { score: 2 },
          { score: 1 },
          { score: 8, isDiscarded: true, code: "DNF" },
          { score: 1 },
          { score: 2 },
          { score: 4 },
          { score: 4 },
          { score: 4 },
          { score: 8, code: "DNF" },
        ],
        grossScore: 34,
        nettScore: 26,
      },
      {
        rank: 2,
        name: "Victoria Natasha Chew",
        sailNumber: "18",
        gender: "F",
        ageCategory: "16&U",
        schoolName: "Methodist Girls' School",
        club: "PAssion Wave",
        races: [
          { score: 8, isDiscarded: true, code: "DNF" },
          { score: 2 },
          { score: 8, code: "DNF" },
          { score: 8, code: "DNF" },
          { score: 1 },
          { score: 3 },
          { score: 1 },
          { score: 3 },
          { score: 1 },
        ],
        grossScore: 35,
        nettScore: 27,
      },
      {
        rank: 3,
        name: "Mason Qifeng Lau",
        sailNumber: "27",
        gender: "M",
        ageCategory: "16&U",
        schoolName: "Tao Nan School",
        club: "Constant Wind SeaSports",
        races: [
          { score: 1 },
          { score: 3 },
          { score: 8, isDiscarded: true, code: "DNF" },
          { score: 8, code: "DNF" },
          { score: 3 },
          { score: 1 },
          { score: 2 },
          { score: 1 },
          { score: 8, code: "DNF" },
        ],
        grossScore: 35,
        nettScore: 27,
      },
      {
        rank: 4,
        name: "Ange Chew",
        sailNumber: "3",
        gender: "M",
        ageCategory: "16&U",
        schoolName: "Home School",
        club: "Changi Sailing Club",
        races: [
          { score: 3 },
          { score: 4 },
          { score: 8, isDiscarded: true, code: "DNF" },
          { score: 2 },
          { score: 4 },
          { score: 2 },
          { score: 3 },
          { score: 2 },
          { score: 8, code: "DNF" },
        ],
        grossScore: 36,
        nettScore: 28,
      },
      {
        rank: 5,
        name: "Ryo En Hua Bateman",
        sailNumber: "23",
        gender: "M",
        ageCategory: "16&U",
        schoolName: "Anglo-Chinese School (Barker Road)",
        club: "Windsurfing Association of Singapore",
        races: [
          { score: 2, code: "RDG" },
          { score: 2, code: "RDG" },
          { score: 1 },
          { score: 3 },
          { score: 5 },
          { score: 5 },
          { score: 5 },
          { score: 8, isDiscarded: true, code: "DNF" },
          { score: 8, code: "DNF" },
        ],
        grossScore: 39,
        nettScore: 31,
      },
      {
        rank: 6,
        name: "Malo Pichoir",
        sailNumber: "5",
        gender: "M",
        ageCategory: "16&U",
        schoolName: "Tanglin Trust School",
        club: "ONE°15 Marina Club",
        races: [
          { score: 8, isDiscarded: true, code: "DSQ" },
          { score: 8, code: "DNS" },
          { score: 8, code: "DNS" },
          { score: 8, code: "DNS" },
          { score: 8, code: "DNS" },
          { score: 8, code: "DNC" },
          { score: 8, code: "DNC" },
          { score: 8, code: "DNC" },
          { score: 8, code: "DNC" },
        ],
        grossScore: 72,
        nettScore: 64,
      },
      {
        rank: 7,
        name: "Cyrus Jing Yi Chiam",
        sailNumber: "2",
        gender: "M",
        ageCategory: "16&U",
        schoolName: "St. Gabriel's Secondary School",
        club: "SAF Yacht Club",
        races: [
          { score: 8, isDiscarded: true, code: "DNF" },
          { score: 8, code: "DNF" },
          { score: 8, code: "DNF" },
          { score: 8, code: "DNF" },
          { score: 8, code: "DNF" },
          { score: 8, code: "DNS" },
          { score: 8, code: "DNF" },
          { score: 8, code: "DNS" },
          { score: 8, code: "DNF" },
        ],
        grossScore: 72,
        nettScore: 64,
      },
    ],
  },
  {
    id: "sw-monsoon-series-gp2-2026",
    name: "2026 SW Monsoon Grand Prix 2 (Round 2 of 3)",
    shortName: "SW Monsoon GP2",
    dates: "29 - 30 August 2026",
    venue: "PAssion Wave @ East Coast, Singapore",
    organizer: "Singapore Sailing Federation & Windsurfing Association Singapore",
    format: "Slalom / Course / Marathon",
    status: "Completed",
    scoringSystem: "5 races, 1 discard (Appendix A)",
    seriesName: "2026 SW Monsoon Grand Prix Series",
    seriesPart: "Round 2 of 3 (5 races completed)",
    websiteUrl: "https://www.sailing.org.sg/events/357398",
    noticeBoardUrl: "https://www.racingrulesofsailing.org/documents/14698/event",
    rulesNotes:
      "Sailed: 5, Discards: 1, To count: 4, Entries: 10, Scoring system: Appendix A. Round 2 of the 2026 SW Monsoon Grand Prix Series held at PAssion Wave @ East Coast.",
    results: [
      {
        rank: 1,
        name: "Ryusai Hatano",
        sailNumber: "22",
        gender: "M",
        ageCategory: "Open",
        schoolName: "",
        club: "PAssion Wave",
        races: [
          { score: 2 },
          { score: 5, isDiscarded: true },
          { score: 1 },
          { score: 1 },
          { score: 1 },
        ],
        grossScore: 10,
        nettScore: 5,
      },
      {
        rank: 2,
        name: "Malo Pichoir",
        sailNumber: "5",
        gender: "M",
        ageCategory: "U16,U19",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 1 },
          { score: 1 },
          { score: 2, isDiscarded: true },
          { score: 2 },
          { score: 2 },
        ],
        grossScore: 8,
        nettScore: 6,
      },
      {
        rank: 3,
        name: "Kate En Rui Bateman",
        sailNumber: "6",
        gender: "F",
        ageCategory: "U16,U19",
        schoolName: "CHIJ Secondary (Toa Payoh)",
        club: "Windsurfing Association of Singapore",
        races: [
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 3 },
          { score: 3 },
          { score: 4 },
          { score: 4 },
        ],
        grossScore: 25,
        nettScore: 14,
      },
      {
        rank: 4,
        name: "Victoria Natasha Chew",
        sailNumber: "1",
        gender: "F",
        ageCategory: "U16,U19",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 4 },
          { score: 11, code: "DNF" },
          { score: 3 },
          { score: 3 },
        ],
        grossScore: 32,
        nettScore: 21,
      },
      {
        rank: 5,
        name: "Mason Qifeng Lau",
        sailNumber: "8",
        gender: "M",
        ageCategory: "U16,U19",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 3 },
          { score: 7 },
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
        ],
        grossScore: 43,
        nettScore: 32,
      },
      {
        rank: 6,
        name: "Ryo En Hua Bateman",
        sailNumber: "23",
        gender: "F",
        ageCategory: "U16,U19",
        schoolName: "",
        club: "Windsurfing Association of Singapore",
        races: [
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 6 },
          { score: 11, code: "DNF" },
          { score: 5 },
          { score: 11, code: "DNF" },
        ],
        grossScore: 44,
        nettScore: 33,
      },
      {
        rank: 7,
        name: "Ange Chew",
        sailNumber: "3",
        gender: "F",
        ageCategory: "U16,U19",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 2 },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
        ],
        grossScore: 46,
        nettScore: 35,
      },
      {
        rank: 8,
        name: "Cyrus Jing Yi Chiam",
        sailNumber: "24",
        gender: "M",
        ageCategory: "U16,U19",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
        ],
        grossScore: 55,
        nettScore: 44,
      },
      {
        rank: 8,
        name: "Ker Wan Chew",
        sailNumber: "18",
        gender: "M",
        ageCategory: "Grand Master",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 11, code: "DNS", isDiscarded: true },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
        ],
        grossScore: 55,
        nettScore: 44,
      },
      {
        rank: 8,
        name: "Xavier Lau",
        sailNumber: "42",
        gender: "M",
        ageCategory: "Master",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 11, code: "DNS", isDiscarded: true },
          { score: 11, code: "DNC" },
          { score: 11, code: "DNC" },
          { score: 11, code: "DNC" },
          { score: 11, code: "DNC" },
        ],
        grossScore: 55,
        nettScore: 44,
      },
    ],
  },
  {
    id: "sw-monsoon-series-gp1-2026",
    name: "2026 SW Monsoon Grand Prix 1 (Round 1 of 3)",
    shortName: "SW Monsoon GP1",
    dates: "11 - 12 July 2026",
    venue: "Constant Wind Sea Sport Centre, Singapore",
    organizer: "Singapore Sailing Federation & Windsurfing Association Singapore",
    format: "Slalom / Course / Marathon",
    status: "Completed",
    scoringSystem: "11 races, 2 discards (Appendix A)",
    seriesName: "2026 SW Monsoon Grand Prix Series",
    seriesPart: "Round 1 of 3 (11 races completed)",
    websiteUrl: "https://www.sailing.org.sg/events/357398",
    noticeBoardUrl: "https://www.racingrulesofsailing.org/documents/14698/event",
    rulesNotes:
      "Sailed: 11, Discards: 2, To count: 9, Entries: 10, Scoring system: Appendix A. Round 1 of the 2026 SW Monsoon Grand Prix Series held at Constant Wind Sea Sport Centre.",
    results: [
      {
        rank: 1,
        name: "Victoria Natasha Chew",
        sailNumber: "1",
        gender: "F",
        ageCategory: "U16,U19",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 1 },
          { score: 4, isDiscarded: true },
          { score: 3 },
          { score: 1 },
          { score: 1 },
          { score: 3 },
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 2 },
          { score: 1 },
          { score: 4 },
          { score: 1 },
        ],
        grossScore: 32,
        nettScore: 17,
      },
      {
        rank: 2,
        name: "Mason Qifeng Lau",
        sailNumber: "8",
        gender: "M",
        ageCategory: "U16",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 2 },
          { score: 3 },
          { score: 4, isDiscarded: true },
          { score: 2 },
          { score: 2 },
          { score: 1 },
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 1 },
          { score: 2 },
          { score: 2 },
          { score: 3 },
        ],
        grossScore: 33,
        nettScore: 18,
      },
      {
        rank: 3,
        name: "Ange Chew",
        sailNumber: "3",
        gender: "F",
        ageCategory: "U16",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 5 },
          { score: 5 },
          { score: 3 },
          { score: 3 },
          { score: 2 },
          { score: 1 },
          { score: 4 },
          { score: 7, isDiscarded: true },
          { score: 3 },
          { score: 5 },
        ],
        grossScore: 49,
        nettScore: 31,
      },
      {
        rank: 4,
        name: "Ryo En Hua Bateman",
        sailNumber: "23",
        gender: "F",
        ageCategory: "U16,U19",
        schoolName: "",
        club: "Windsurfing Association of Singapore",
        races: [
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 1 },
          { score: 6 },
          { score: 6 },
          { score: 4 },
          { score: 4 },
          { score: 4 },
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 4 },
          { score: 1 },
          { score: 4 },
        ],
        grossScore: 56,
        nettScore: 34,
      },
      {
        rank: 5,
        name: "Kate En Rui Bateman",
        sailNumber: "6",
        gender: "F",
        ageCategory: "U16,U19",
        schoolName: "CHIJ Secondary (Toa Payoh)",
        club: "Windsurfing Association of Singapore",
        races: [
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 2 },
          { score: 2 },
          { score: 4 },
          { score: 5 },
          { score: 5 },
          { score: 3 },
          { score: 3 },
          { score: 5 },
          { score: 7, isDiscarded: true },
          { score: 6 },
        ],
        grossScore: 53,
        nettScore: 35,
      },
      {
        rank: 6,
        name: "Damien Gay",
        sailNumber: "40",
        gender: "M",
        ageCategory: "Master",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 1 },
          { score: 5 },
          { score: 11, code: "DNF" },
          { score: 7 },
          { score: 11, code: "DNF" },
          { score: 5 },
          { score: 6 },
          { score: 5 },
          { score: 7 },
        ],
        grossScore: 80,
        nettScore: 58,
      },
      {
        rank: 7,
        name: "Ker Wan Chew",
        sailNumber: "18",
        gender: "M",
        ageCategory: "Grand Master",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 7 },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 2 },
          { score: 6 },
          { score: 3 },
          { score: 6 },
          { score: 2 },
        ],
        grossScore: 81,
        nettScore: 59,
      },
      {
        rank: 8,
        name: "Xavier Lau",
        sailNumber: "42",
        gender: "M",
        ageCategory: "Master",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 6 },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
        ],
        grossScore: 116,
        nettScore: 94,
      },
      {
        rank: 9,
        name: "Cyrus Jing Yi Chiam",
        sailNumber: "2",
        gender: "M",
        ageCategory: "U16",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 11, code: "DNF", isDiscarded: true },
          { score: 8 },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
          { score: 11, code: "DNF" },
        ],
        grossScore: 118,
        nettScore: 96,
      },
      {
        rank: 10,
        name: "Sven Welak",
        sailNumber: "50",
        gender: "M",
        ageCategory: "Open",
        schoolName: "",
        club: "Constant Wind",
        races: [
          { score: 11, code: "DNC", isDiscarded: true },
          { score: 11, code: "DNC", isDiscarded: true },
          { score: 11, code: "DNC" },
          { score: 11, code: "DNC" },
          { score: 11, code: "DNC" },
          { score: 11, code: "DNC" },
          { score: 11, code: "DNC" },
          { score: 11, code: "DNC" },
          { score: 11, code: "DNC" },
          { score: 11, code: "DNC" },
          { score: 11, code: "DNC" },
        ],
        grossScore: 121,
        nettScore: 99,
      },
    ],
  },
  {
    id: "ne-monsoon-series-gp3-2026",
    name: "2026 Northeast Monsoon Grand Prix 3 (Round 3 of 3)",
    shortName: "NE Monsoon GP3",
    dates: "28 Feb – 1 Mar & 7–8 Mar 2026",
    venue: "East Coast Park / Constant Wind, Singapore",
    organizer: "Windsurfing Association of Singapore & Singapore Sailing Federation",
    format: "Sprint Slalom",
    status: "Upcoming",
    scoringSystem: "Up to 24 races, Series Grand Finale (Appendix A)",
    seriesName: "2026 Northeast Monsoon Grand Prix Series",
    seriesPart: "Round 3 of 3 (Grand Finale)",
    rulesNotes:
      "Championship Grand Finale of the 2026 NE Monsoon Grand Prix Series. Overall series championship coronation across all divisions.",
  },
  {
    id: "ne-monsoon-series-gp2-2026",
    name: "2026 Northeast Monsoon Grand Prix 2 (Round 2 of 3)",
    shortName: "NE Monsoon GP2",
    dates: "31 Jan – 1 Feb & 7–8 Feb 2026",
    venue: "Changi Coast / CSC, Singapore",
    organizer: "Windsurfing Association of Singapore & Singapore Sailing Federation",
    format: "Sprint Slalom",
    status: "Upcoming",
    scoringSystem: "Up to 24 races, Low Point System (Appendix A)",
    seriesName: "2026 Northeast Monsoon Grand Prix Series",
    seriesPart: "Round 2 of 3",
    rulesNotes:
      "Round 2 of the 2026 Northeast Monsoon Grand Prix Series. Sprint Slalom and Course racing across Open, Youth, and Masters categories.",
  },
{
    id: "ne-monsoon-series-gp1-2026",
    name: "2026 Northeast Monsoon Grand Prix 1 (Round 1 of 3)",
    shortName: "NE Monsoon GP1",
    dates: "10–11 January 2026",
    venue: "East Coast Park / Constant Wind, Singapore",
    organizer: "Windsurfing Association of Singapore & Singapore Sailing Federation",
    format: "Sprint Slalom",
    status: "Completed",
    scoringSystem: "20 races, 2 discards (Appendix A)",
    seriesName: "2026 Northeast Monsoon Grand Prix Series",
    seriesPart: "Round 1 of 3 (20 races completed)",
    rulesNotes:
      "Sailed: 20, Discards: 2, To count: 18, Entries: 21. Appendix A low point system across Open, U16/U19, Masters, Grand Masters, and Fun Open divisions.",
    results: [
      {
        rank: 1,
        name: "Jun Hao Lo",
        sailNumber: "43",
        gender: "M",
        ageCategory: "Open",
        schoolName: "",
        club: "Constant Wind SeaSports",
        races: [
          { score: 2 },
          { score: 1 },
          { score: 1 },
          { score: 22, isDiscarded: true, code: "DNS" },
          { score: 22, isDiscarded: true, code: "DNC" },
          { score: 1 },
          { score: 1 },
          { score: 1 },
          { score: 1 },
          { score: 1 },
          { score: 3 },
          { score: 1 },
          { score: 4 },
          { score: 1 },
          { score: 7 },
          { score: 22, code: "DNF" },
          { score: 1 },
          { score: 1 },
          { score: 1 },
          { score: 1 },
        ],
        grossScore: 95,
        nettScore: 51,
      },
      {
        rank: 2,
        name: "Wearn Haw Tan",
        sailNumber: "29",
        gender: "M",
        ageCategory: "Master",
        schoolName: "",
        club: "Singapore Sailing Federation",
        races: [
          { score: 5 },
          { score: 2 },
          { score: 5 },
          { score: 1 },
          { score: 1 },
          { score: 2 },
          { score: 2 },
          { score: 2 },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 1 },
          { score: 2 },
          { score: 1 },
          { score: 2 },
          { score: 1 },
          { score: 7 },
          { score: 2 },
          { score: 2 },
          { score: 2 },
          { score: 22, code: "DNF" },
        ],
        grossScore: 106,
        nettScore: 62,
      },
      {
        rank: 3,
        name: "Ker Wan Chew",
        sailNumber: "18",
        gender: "M",
        ageCategory: "Grand Master",
        schoolName: "",
        club: "Changi Sailing Club",
        races: [
          { score: 1 },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 2 },
          { score: 6 },
          { score: 2 },
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 2 },
          { score: 3 },
          { score: 3 },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 2 },
          { score: 13 },
          { score: 22, code: "DNF" },
          { score: 4 },
          { score: 4 },
          { score: 3 },
        ],
        grossScore: 126,
        nettScore: 82,
      },
      {
        rank: 4,
        name: "Damien Gay",
        sailNumber: "49",
        gender: "M",
        ageCategory: "Master",
        schoolName: "",
        club: "Constant Wind SeaSports",
        races: [
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 7 },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 9 },
          { score: 4 },
          { score: 4 },
          { score: 4 },
          { score: 2 },
          { score: 2 },
          { score: 7 },
          { score: 8 },
          { score: 5 },
          { score: 7 },
          { score: 4 },
          { score: 1 },
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 2 },
        ],
        grossScore: 141,
        nettScore: 97,
      },
      {
        rank: 5,
        name: "Jean-Marc Provost",
        sailNumber: "41",
        gender: "M",
        ageCategory: "Grand Master",
        schoolName: "",
        club: "ONE°15 Marina Club",
        races: [
          { score: 4 },
          { score: 3 },
          { score: 4 },
          { score: 3 },
          { score: 6 },
          { score: 7 },
          { score: 8 },
          { score: 5 },
          { score: 6 },
          { score: 5 },
          { score: 6 },
          { score: 10, isDiscarded: true },
          { score: 9, isDiscarded: true },
          { score: 6 },
          { score: 8 },
          { score: 5 },
          { score: 6 },
          { score: 8 },
          { score: 9 },
          { score: 6 },
        ],
        grossScore: 124,
        nettScore: 105,
      },
      {
        rank: 6,
        name: "Ange Chew",
        sailNumber: "3",
        gender: "M",
        ageCategory: "16&U",
        schoolName: "Home School",
        club: "Changi Sailing Club",
        races: [
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 8 },
          { score: 6 },
          { score: 4 },
          { score: 7 },
          { score: 13, isDiscarded: true },
          { score: 10 },
          { score: 12 },
          { score: 8 },
          { score: 8 },
          { score: 5 },
          { score: 6 },
          { score: 11 },
          { score: 4 },
          { score: 10 },
          { score: 4 },
          { score: 9 },
          { score: 7 },
          { score: 7 },
          { score: 13 },
        ],
        grossScore: 174,
        nettScore: 139,
      },
      {
        rank: 7,
        name: "Harun Talikov",
        sailNumber: "19",
        gender: "M",
        ageCategory: "Open",
        schoolName: "",
        club: "Windsurfing Association of Singapore",
        races: [
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 5 },
          { score: 3 },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 3 },
          { score: 8 },
          { score: 6 },
          { score: 8 },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 5 },
          { score: 6 },
          { score: 11 },
          { score: 9 },
          { score: 2 },
          { score: 4 },
          { score: 5 },
          { score: 6 },
          { score: 5 },
        ],
        grossScore: 196,
        nettScore: 152,
      },
      {
        rank: 8,
        name: "Victoria Natasha Chew",
        sailNumber: "1",
        gender: "F",
        ageCategory: "16&U",
        schoolName: "Methodist Girls' School",
        club: "PAssion Wave",
        races: [
          { score: 6 },
          { score: 9 },
          { score: 8 },
          { score: 5 },
          { score: 8 },
          { score: 14, isDiscarded: true },
          { score: 9 },
          { score: 10 },
          { score: 9 },
          { score: 9 },
          { score: 9 },
          { score: 9 },
          { score: 10 },
          { score: 5 },
          { score: 11 },
          { score: 6 },
          { score: 12, isDiscarded: true },
          { score: 11 },
          { score: 10 },
          { score: 11 },
        ],
        grossScore: 181,
        nettScore: 155,
      },
      {
        rank: 9,
        name: "Mason Qifeng Lau",
        sailNumber: "8",
        gender: "M",
        ageCategory: "16&U",
        schoolName: "Tao Nan School",
        club: "Constant Wind SeaSports",
        races: [
          { score: 3 },
          { score: 4 },
          { score: 9 },
          { score: 2 },
          { score: 5 },
          { score: 6 },
          { score: 11 },
          { score: 7 },
          { score: 5 },
          { score: 6 },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 3 },
          { score: 8 },
          { score: 6 },
          { score: 12 },
          { score: 8 },
        ],
        grossScore: 205,
        nettScore: 161,
      },
      {
        rank: 10,
        name: "Kate En Rui Bateman",
        sailNumber: "6",
        gender: "F",
        ageCategory: "16&U",
        schoolName: "CHIJ Secondary (Toa Payoh)",
        club: "Windsurfing Association of Singapore",
        races: [
          { score: 7 },
          { score: 10 },
          { score: 11 },
          { score: 7 },
          { score: 12 },
          { score: 12 },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 14, isDiscarded: true },
          { score: 11 },
          { score: 12 },
          { score: 10 },
          { score: 13 },
          { score: 12 },
          { score: 8 },
          { score: 14 },
          { score: 8 },
          { score: 10 },
          { score: 13 },
          { score: 13 },
          { score: 10 },
        ],
        grossScore: 229,
        nettScore: 193,
      },
      {
        rank: 11,
        name: "Ryo En Hua Bateman",
        sailNumber: "7",
        gender: "M",
        ageCategory: "16&U",
        schoolName: "Anglo-Chinese School (Barker Road)",
        club: "Windsurfing Association of Singapore",
        races: [
          { score: 9 },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 7 },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 11 },
          { score: 11 },
          { score: 13 },
          { score: 13 },
          { score: 10 },
          { score: 10 },
          { score: 11 },
          { score: 12 },
          { score: 13 },
          { score: 12 },
          { score: 13 },
          { score: 11 },
          { score: 14 },
          { score: 12 },
          { score: 15 },
          { score: 14 },
        ],
        grossScore: 255,
        nettScore: 211,
      },
      {
        rank: 12,
        name: "Pandora Chew",
        sailNumber: "13",
        gender: "F",
        ageCategory: "Open",
        schoolName: "",
        club: "Changi Sailing Club",
        races: [
          { score: 8 },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 10 },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 12 },
          { score: 11 },
          { score: 12 },
          { score: 11 },
          { score: 13 },
          { score: 11 },
          { score: 14 },
          { score: 10 },
          { score: 12 },
          { score: 9 },
          { score: 13 },
          { score: 15 },
          { score: 14 },
          { score: 12 },
        ],
        grossScore: 275,
        nettScore: 231,
      },
      {
        rank: 13,
        name: "Arthur Phan",
        sailNumber: "30",
        gender: "M",
        ageCategory: "Open",
        schoolName: "",
        club: "Constant Wind SeaSports",
        races: [
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 10 },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 8 },
          { score: 4 },
          { score: 8 },
          { score: 9 },
          { score: 3 },
          { score: 12 },
          { score: 11 },
          { score: 14 },
          { score: 5 },
          { score: 4 },
        ],
        grossScore: 286,
        nettScore: 242,
      },
      {
        rank: 14,
        name: "Malo Pichoir",
        sailNumber: "5",
        gender: "M",
        ageCategory: "16&U",
        schoolName: "Tanglin Trust School",
        club: "ONE°15 Marina Club",
        races: [
          { score: 22, isDiscarded: true, code: "DNC" },
          { score: 22, isDiscarded: true, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 12 },
          { score: 7 },
          { score: 7 },
          { score: 3 },
          { score: 5 },
          { score: 22, code: "DNF" },
          { score: 5 },
          { score: 10 },
          { score: 8 },
          { score: 7 },
        ],
        grossScore: 306,
        nettScore: 262,
      },
      {
        rank: 15,
        name: "Sven Welak",
        sailNumber: "50",
        gender: "M",
        ageCategory: "Open",
        schoolName: "",
        club: "Constant Wind SeaSports",
        races: [
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 6 },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 10 },
          { score: 9 },
          { score: 7 },
          { score: 6 },
          { score: 4 },
          { score: 4 },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
        ],
        grossScore: 332,
        nettScore: 288,
      },
      {
        rank: 16,
        name: "Xavier Lau",
        sailNumber: "42",
        gender: "M",
        ageCategory: "Master",
        schoolName: "",
        club: "Constant Wind SeaSports",
        races: [
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 9 },
          { score: 7 },
          { score: 7 },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 10 },
          { score: 7 },
          { score: 9 },
          { score: 11 },
          { score: 9 },
        ],
        grossScore: 333,
        nettScore: 289,
      },
      {
        rank: 17,
        name: "Guillaume Pichoir",
        sailNumber: "48",
        gender: "M",
        ageCategory: "Grand Master",
        schoolName: "",
        club: "ONE°15 Marina Club",
        races: [
          { score: 22, isDiscarded: true, code: "DNC" },
          { score: 22, isDiscarded: true, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 4 },
          { score: 22, code: "DNF" },
          { score: 2 },
          { score: 22, code: "DNF" },
          { score: 6 },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
        ],
        grossScore: 386,
        nettScore: 342,
      },
      {
        rank: 18,
        name: "Laurence Ng",
        sailNumber: "28",
        gender: "M",
        ageCategory: "Master",
        schoolName: "",
        club: "Windsurfing Association of Singapore",
        races: [
          { score: 22, isDiscarded: true, code: "DNS" },
          { score: 22, isDiscarded: true, code: "DNS" },
          { score: 22, code: "DNS" },
          { score: 22, code: "DNS" },
          { score: 4 },
          { score: 5 },
          { score: 5 },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
        ],
        grossScore: 388,
        nettScore: 344,
      },
      {
        rank: 19,
        name: "Felix Knick",
        sailNumber: "46",
        gender: "M",
        ageCategory: "Master",
        schoolName: "",
        club: "Windsurfing Association of Singapore",
        races: [
          { score: 22, isDiscarded: true, code: "DNC" },
          { score: 22, isDiscarded: true, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
        ],
        grossScore: 440,
        nettScore: 396,
      },
      {
        rank: 19,
        name: "Jayden Li",
        sailNumber: "4",
        gender: "M",
        ageCategory: "16&U",
        schoolName: "",
        club: "Constant Wind SeaSports",
        races: [
          { score: 22, isDiscarded: true, code: "DNC" },
          { score: 22, isDiscarded: true, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
          { score: 22, code: "DNC" },
        ],
        grossScore: 440,
        nettScore: 396,
      },
      {
        rank: 19,
        name: "Cyrus Jing Yi Chiam",
        sailNumber: "2",
        gender: "M",
        ageCategory: "16&U",
        schoolName: "St. Gabriel's Secondary School",
        club: "SAF Yacht Club",
        races: [
          { score: 22, isDiscarded: true, code: "DNS" },
          { score: 22, isDiscarded: true, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
          { score: 22, code: "DNF" },
        ],
        grossScore: 440,
        nettScore: 396,
      },
    ],
  },
];

/**
 * Extract regatta name and start date from an uploaded screenshot's filename.
 * Supports patterns such as:
 * - "SNSC_2026_WingFoil_2026-09-05.png"
 * - "Singapore_National_Sailing_Championships_2026-09-07.png"
 * - "2026-09-05_SNSC_Wingfoil_Results.png"
 * - "SW_Monsoon_GP_2026-07-15.jpg"
 * - "Screenshot 2026-09-07 at 4.31.22 PM.png"
 */
export function parseWingfoilScreenshotFilename(fileName: string): {
  regattaName: string;
  startDate: string;
} {
  // Strip file extension
  const base = fileName.replace(/\.[a-zA-Z0-9]+$/, "").trim();

  let startDate = "";
  let nameCandidate = base;

  // 1. Check for YYYYMMDD (e.g. "20260110 NE Monsoon Series GP1")
  const ymdMatch = base.match(/\b(20\d{2})(\d{2})(\d{2})\b/);
  if (ymdMatch) {
    startDate = `${ymdMatch[1]}-${ymdMatch[2]}-${ymdMatch[3]}`;
    nameCandidate = base.replace(ymdMatch[0], " ").trim();
  } else {
    // 2. Check for YYYY-MM-DD or YYYY_MM_DD
    const isoMatch = base.match(/(\d{4})[-_](\d{2})[-_](\d{2})/);
    if (isoMatch) {
      startDate = `${isoMatch[1]}-${isoMatch[2]}-${isoMatch[3]}`;
      nameCandidate = base.replace(isoMatch[0], " ").trim();
    } else {
      // 3. Check for DD-MM-YYYY
      const dmyMatch = base.match(/(\d{2})[-_](\d{2})[-_](\d{4})/);
      if (dmyMatch) {
        startDate = `${dmyMatch[3]}-${dmyMatch[2]}-${dmyMatch[1]}`;
        nameCandidate = base.replace(dmyMatch[0], " ").trim();
      } else {
        // 4. Fallback: Check for YYYY
        const yearMatch = base.match(/\b(20\d{2})\b/);
        if (yearMatch) {
          startDate = `${yearMatch[1]}-09-01`;
        } else {
          startDate = new Date().toISOString().split("T")[0];
        }
      }
    }
  }

  // Clean up name candidate
  let cleanName = nameCandidate
    .replace(/[_-]+/g, " ")
    .replace(/\s+/g, " ")
    .replace(/^(Screenshot|Results|Results are provisional as of)\s*/i, "")
    .replace(/\b(at \d{1,2}[.:]\d{2}(?:[.:]\d{2})?(?:\s*(?:AM|PM))?)\b/gi, "")
    .trim();

  // Remove leading/trailing dashes or symbols
  cleanName = cleanName.replace(/^[-–—:\s]+|[-–—:\s]+$/g, "").trim();

  if (!cleanName || cleanName.toLowerCase() === "screenshot") {
    cleanName = "Singapore WingFoil Sprint Slalom";
  }

  return {
    regattaName: cleanName,
    startDate,
  };
}

/**
 * Recalculate scores and discards for a single sailor's races according to
 * World Sailing RRS Appendix A (1 discard applied after 4+ completed races).
 */
export function computeWingfoilNett(
  races: WingfoilRaceScore[],
  discardsCount?: number
): {
  grossScore: number;
  nettScore: number;
  scoredRaces: WingfoilRaceScore[];
} {
  const grossScore = races.reduce((sum, r) => sum + (Number(r.score) || 0), 0);
  const completedCount = races.filter((r) => r.score != null).length;

  let numDiscards = discardsCount ?? 0;
  if (discardsCount == null) {
    if (completedCount >= 16) {
      numDiscards = 2;
    } else if (completedCount >= 4) {
      numDiscards = 1;
    } else {
      numDiscards = 0;
    }
  }

  // Find the N worst races
  const indicesWithScore = races
    .map((r, idx) => ({ score: Number(r.score) || 0, idx }))
    .sort((a, b) => b.score - a.score);

  const discardedSet = new Set(
    indicesWithScore.slice(0, numDiscards).map((item) => item.idx)
  );

  const scoredRaces = races.map((r, idx) => ({
    ...r,
    isDiscarded: discardedSet.has(idx),
  }));

  const nettScore = scoredRaces.reduce(
    (sum, r) => sum + (r.isDiscarded ? 0 : Number(r.score) || 0),
    0
  );

  return { grossScore, nettScore, scoredRaces };
}

/**
 * Recalculate and sort a full WingFoil scoreboard by nett points and tiebreaks.
 */
export function recalculateScoreboard(
  results: WingfoilSailorResult[],
  discardsCount?: number
): WingfoilSailorResult[] {
  const recalculated = results.map((sailor) => {
    const { grossScore, nettScore, scoredRaces } = computeWingfoilNett(
      sailor.races,
      discardsCount
    );
    return {
      ...sailor,
      races: scoredRaces,
      grossScore,
      nettScore,
    };
  });

  // Sort by nett score ascending, then by gross score, then alphabetical
  recalculated.sort((a, b) => {
    if (a.nettScore !== b.nettScore) {
      return a.nettScore - b.nettScore;
    }
    if (a.grossScore !== b.grossScore) {
      return a.grossScore - b.grossScore;
    }
    return a.name.localeCompare(b.name);
  });

  return recalculated.map((s, idx) => ({
    ...s,
    rank: idx + 1,
  }));
}

export const WINGFOIL_STORAGE_KEY = "sailorpath_wingfoil_regattas_v1";

/**
 * Load wingfoil regattas with persistent local overrides/uploads.
 * In browser environment, merges default master list with any uploaded/edited regattas in localStorage.
 */
export function loadWingfoilRegattas(): WingfoilRegatta[] {
  if (typeof window === "undefined") {
    return SINGAPORE_WINGFOIL_REGATTAS;
  }
  try {
    const raw = window.localStorage.getItem(WINGFOIL_STORAGE_KEY);
    if (!raw) return SINGAPORE_WINGFOIL_REGATTAS;
    const stored = JSON.parse(raw) as WingfoilRegatta[];
    if (Array.isArray(stored) && stored.length > 0) {
      // Create a map by id to merge any newly added default regattas while preserving user updates
      const storedMap = new Map(stored.map((r) => [r.id, r]));
      // Ensure all official default regattas exist
      const merged: WingfoilRegatta[] = [];
      const visited = new Set<string>();

      for (const def of SINGAPORE_WINGFOIL_REGATTAS) {
        if (storedMap.has(def.id)) {
          merged.push(storedMap.get(def.id)!);
        } else {
          merged.push(def);
        }
        visited.add(def.id);
      }
      // Add custom uploaded events not in default list
      for (const r of stored) {
        if (!visited.has(r.id)) {
          merged.push(r);
        }
      }
      return merged;
    }
  } catch (e) {
    console.warn("[wingfoil] Failed to load from localStorage:", e);
  }
  return SINGAPORE_WINGFOIL_REGATTAS;
}

/**
 * Persist wingfoil regattas to localStorage so uploads and edits survive page refreshes.
 */
export function saveWingfoilRegattas(regattas: WingfoilRegatta[]): void {
  if (typeof window === "undefined") return;
  try {
    window.localStorage.setItem(WINGFOIL_STORAGE_KEY, JSON.stringify(regattas));
  } catch (e) {
    console.warn("[wingfoil] Failed to save to localStorage:", e);
  }
}

/**
 * Find closest matching official regatta by name for auto-merging / tagging.
 * e.g. "NE Monsoon Series GP2" or "Northeast Monsoon GP 2" matches "ne-monsoon-series-gp2-2026".
 */
export function findMatchingWingfoilRegatta(
  query: string,
  regattas: WingfoilRegatta[] = SINGAPORE_WINGFOIL_REGATTAS
): WingfoilRegatta | undefined {
  if (!query) return undefined;
  const q = query.toLowerCase().replace(/[^a-z0-9]/g, "");

  // 1. Exact or normalized contains match
  for (const r of regattas) {
    const rNameNorm = r.name.toLowerCase().replace(/[^a-z0-9]/g, "");
    const rShortNorm = r.shortName.toLowerCase().replace(/[^a-z0-9]/g, "");
    if (rNameNorm === q || rShortNorm === q) return r;
  }

  // 2. Specific heuristics for NE Monsoon GP 1, 2, 3
  const gpMatch = query.match(/(?:gp|grand\s*prix|round)\s*([123])/i);
  if (gpMatch && /monsoon/i.test(query)) {
    const roundNum = gpMatch[1];
    const targetId = `ne-monsoon-series-gp${roundNum}-2026`;
    const found = regattas.find((r) => r.id === targetId);
    if (found) return found;
  }

  // 3. Fallback partial match
  return regattas.find((r) => {
    const rName = r.name.toLowerCase();
    const rShort = r.shortName.toLowerCase();
    return q.includes(rShort.replace(/[^a-z0-9]/g, "")) || rName.includes(query.toLowerCase());
  });
}

export const WINGFOIL_CATEGORIES = [
  "Open",
  "U16",
  "U19",
  "Masters",
  "Grand Masters",
] as const;

export type WingfoilCategory = (typeof WINGFOIL_CATEGORIES)[number];

export const WINGFOIL_OFFICIAL_DIVISIONS = [
  "Wing Foil Open division",
  "Wing Foil U16 division",
  "Wing Foil U19 division",
  "Wing Foil Masters division",
  "Wing Foil Grand Masters division",
] as const;

export type WingfoilOfficialDivision = (typeof WINGFOIL_OFFICIAL_DIVISIONS)[number];

export function normalizeWingfoilCategory(raw: string | undefined | null): WingfoilCategory {
  if (!raw) return "Open";
  const s = raw.toLowerCase().trim();
  if (s.includes("grand master")) return "Grand Masters";
  if (s.includes("master")) return "Masters";
  if (s.includes("16") || s.includes("u16") || s.includes("16&u")) return "U16";
  if (s.includes("19") || s.includes("u19") || s.includes("19&u")) return "U19";
  return "Open";
}

/**
 * Normalizes sailor name for cross-regatta matching.
 */
export function normalizeSailorName(name: string): string {
  if (!name) return "";
  return name
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[^a-z0-9]/g, "")
    .trim();
}

export type HistoricalSailNumber = {
  sailNumber: string;
  regattaId: string;
  regattaName: string;
};

/**
 * Compares two sail numbers, normalizing away prefix 'SGP', spaces, and symbols.
 */
export function areSailNumbersMatching(a?: string, b?: string): boolean {
  if (!a || !b) return false;
  const cleanA = a.toLowerCase().replace(/[^a-z0-9]/g, "").replace(/^sgp/, "");
  const cleanB = b.toLowerCase().replace(/[^a-z0-9]/g, "").replace(/^sgp/, "");
  return cleanA === cleanB;
}

/**
 * Builds a lookup of known prior sail numbers across regattas.
 */
export function buildHistoricalSailNumberMap(
  regattas: WingfoilRegatta[],
  excludeRegattaId?: string
): Map<string, HistoricalSailNumber> {
  const map = new Map<string, HistoricalSailNumber>();
  for (const r of regattas) {
    if (excludeRegattaId && r.id === excludeRegattaId) continue;
    for (const s of r.results || []) {
      const norm = normalizeSailorName(s.name);
      const sn = s.sailNumber?.trim();
      if (norm && sn && sn !== "-" && sn !== "—") {
        map.set(norm, {
          sailNumber: sn,
          regattaId: r.id,
          regattaName: r.shortName || r.name,
        });
      }
    }
  }
  return map;
}

/**
 * Auto-populates missing sail numbers using historical regatta records.
 */
export function applyHistoricalSailNumbers(
  results: WingfoilSailorResult[],
  historicalMap: Map<string, HistoricalSailNumber>
): { results: WingfoilSailorResult[]; autoAssignedCount: number } {
  let autoAssignedCount = 0;
  const updated = results.map((sailor) => {
    const norm = normalizeSailorName(sailor.name);
    const prior = historicalMap.get(norm);
    if (prior) {
      const currentSn = sailor.sailNumber?.trim();
      if (!currentSn || currentSn === "-" || currentSn === "—") {
        autoAssignedCount++;
        return { ...sailor, sailNumber: prior.sailNumber };
      }
    }
    return sailor;
  });
  return { results: updated, autoAssignedCount };
}

export async function fetchServerWingfoilRegattas(options?: {
  includeAll?: boolean;
}): Promise<WingfoilRegatta[] | null> {
  if (typeof window === "undefined") return null;
  try {
    const q = options?.includeAll ? "?all=1" : "";
    const endpoint = window.location?.origin
      ? `${window.location.origin}/api/wingfoil${q}`
      : `/api/wingfoil${q}`;
    const res = await fetch(endpoint, { cache: "no-store", credentials: "include" });
    if (!res.ok) return null;
    const data = await res.json();
    if (Array.isArray(data?.regattas) && data.regattas.length > 0) {
      // Only cache to localStorage if loaded from actual database, preventing
      // static empty fallback lists from blowing away user uploads
      if (data.source === "database") {
        saveWingfoilRegattas(data.regattas);
      }
      return data.regattas;
    }
  } catch (e) {
    if (process.env.NODE_ENV !== "test") {
      console.warn("[wingfoil] Failed to fetch from /api/wingfoil:", e);
    }
  }
  return null;
}

/**
 * Push updated wingfoil regattas to the server database for public persistence.
 */
export async function syncWingfoilToServer(
  regattas: WingfoilRegatta[]
): Promise<{ success: boolean; error?: string }> {
  if (typeof window === "undefined") return { success: false };
  try {
    const endpoint = window.location?.origin
      ? `${window.location.origin}/api/wingfoil`
      : "/api/wingfoil";
    const res = await fetch(endpoint, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      credentials: "include",
      body: JSON.stringify({ regattas }),
    });
    if (!res.ok) {
      const err = await res.json().catch(() => ({}));
      return { success: false, error: err?.error || `HTTP ${res.status}` };
    }
    return { success: true };
  } catch (e) {
    return {
      success: false,
      error: e instanceof Error ? e.message : "Network error",
    };
  }
}

/**
 * Delete a custom/uploaded wingfoil regatta from the server database.
 */
export async function deleteWingfoilFromServer(
  id: string
): Promise<{ success: boolean; error?: string }> {
  if (typeof window === "undefined" || !id) return { success: false };
  try {
    const endpoint = window.location?.origin
      ? `${window.location.origin}/api/wingfoil`
      : "/api/wingfoil";
    const res = await fetch(endpoint, {
      method: "DELETE",
      headers: { "Content-Type": "application/json" },
      credentials: "include",
      body: JSON.stringify({ id }),
    });
    if (!res.ok) {
      const err = await res.json().catch(() => ({}));
      return { success: false, error: err?.error || `HTTP ${res.status}` };
    }
    return { success: true };
  } catch (e) {
    return {
      success: false,
      error: e instanceof Error ? e.message : "Network error",
    };
  }
}

/**
 * Merge two wingfoil regatta lists without losing uploaded scorecard results.
 */
export function mergeWingfoilRegattaLists(
  primary: WingfoilRegatta[],
  secondary: WingfoilRegatta[]
): WingfoilRegatta[] {
  const map = new Map<string, WingfoilRegatta>();

  for (const r of secondary) {
    if (r && r.id) map.set(r.id, r);
  }

  for (const r of primary) {
    if (!r || !r.id) continue;
    const existing = map.get(r.id);
    if (!existing) {
      map.set(r.id, r);
    } else {
      const rHasResults = Array.isArray(r.results) && r.results.length > 0;
      const existHasResults = Array.isArray(existing.results) && existing.results.length > 0;
      if (rHasResults || !existHasResults) {
        map.set(r.id, r);
      }
    }
  }

  return sortWingfoilRegattas(Array.from(map.values()));
}
