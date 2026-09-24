export type Techno293RaceScore = {
  score: number;
  isDiscarded?: boolean;
  code?: "DNF" | "DNS" | "DSQ" | "DNC" | "RET" | "RDG";
};

export type Techno293SailorResult = {
  rank: number;
  name: string;
  sailNumber: string;
  gender: "M" | "F";
  ageCategory: string; // e.g., "U17", "Open", "U15"
  division?: string;
  schoolName?: string;
  club?: string;
  races: Techno293RaceScore[];
  grossScore: number;
  nettScore: number;
};

export type Techno293Regatta = {
  id: string;
  name: string;
  shortName: string;
  dates: string;
  venue: string;
  organizer: string;
  format:
    | "Course Race"
    | "Slalom / Course / Marathon"
    | "One Design";
  status: "Completed" | "Upcoming";
  lifecycleStatus?: "draft" | "in_review" | "published" | "archived";
  scoringSystem: string;
  rulesNotes: string;
  seriesName?: string;
  seriesPart?: string;
  websiteUrl?: string;
  noticeBoardUrl?: string;
  results?: Techno293SailorResult[];
};

export const TECHNO293_SPECIFICATIONS = {
  formatName: "One Design Windsurfing (Course Race / Slalom / Marathon)",
  scoringSystem: "World Sailing RRS Appendix A (Low Point System)",
  boardSpec: "Bic Techno 293 One Design (Length: 293 cm, Width: 79 cm, Volume: 205 L)",
  rigSizes: "Techno 293 OD 6.8 m² (U15), 7.8 m² (U17), 8.5 m² (Open / Techno Plus)",
  daggerboardFin: "Select 46 cm Ride Fin & 60 cm One Design Daggerboard",
  equipmentRule: "Strict One-Design Class — Only official World Sailing Techno 293 equipment permitted",
  windLimit: "3 to 30 knots (Pumping allowed per RRS Rule 42 and Class Rules)",
  rankingPolicy:
    "Singapore Techno 293 features the Southwest Monsoon Grand Prix Series, scored cumulatively across 3 Grand Prix regattas with RRS Appendix A scoring.",
};

const TECHNO293_MONTHS: Record<string, number> = {
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
 * e.g., "10 - 11 October 2026", "29 - 30 August 2026", "11 - 12 July 2026".
 */
export function parseTechno293RegattaDate(datesStr: string | undefined | null): number {
  if (!datesStr || typeof datesStr !== "string") return 0;
  const s = datesStr.trim();
  if (!s) return 0;

  if (/^\d{4}-\d{2}-\d{2}/.test(s)) {
    const t = Date.parse(s.slice(0, 10));
    if (!Number.isNaN(t)) return t;
  }

  const yMatch = s.match(/\b(20\d\d|19\d\d)\b/);
  const year = yMatch ? parseInt(yMatch[1], 10) : 2026;

  const tokens = s.toLowerCase().split(/[^a-z0-9]+/);
  let month = 1;
  let day = 1;
  let foundMonth = false;

  for (let i = 0; i < tokens.length; i++) {
    const t = tokens[i];
    if (TECHNO293_MONTHS[t]) {
      month = TECHNO293_MONTHS[t];
      foundMonth = true;
      if (i > 0) {
        const prevNum = parseInt(tokens[i - 1], 10);
        if (!Number.isNaN(prevNum) && prevNum >= 1 && prevNum <= 31) {
          day = prevNum;
        }
      }
      break;
    }
  }

  if (!foundMonth) {
    for (const t of tokens) {
      const n = parseInt(t, 10);
      if (!Number.isNaN(n) && n >= 1 && n <= 12) {
        month = n;
        break;
      }
    }
  }

  return Date.UTC(year, month - 1, day);
}

/**
 * Sort Techno 293 regattas in reverse chronological order (latest first).
 */
export function sortTechno293Regattas(regattas: Techno293Regatta[]): Techno293Regatta[] {
  return [...regattas].sort((a, b) => {
    const dateA = parseTechno293RegattaDate(a.dates);
    const dateB = parseTechno293RegattaDate(b.dates);
    return dateB - dateA;
  });
}

export function normalizeTechno293SailorName(name: string): string {
  return (name || "")
    .toLowerCase()
    .replace(/[^a-z0-9]/g, " ")
    .replace(/\s+/g, " ")
    .trim();
}

export const SINGAPORE_TECHNO293_REGATTAS: Techno293Regatta[] = [
  {
    id: "techno-snsc-2026",
    name: "Singapore National Sailing Championships 2026",
    shortName: "SNSC 2026",
    dates: "5 - 7 September 2026",
    venue: "National Sailing Centre, Singapore",
    organizer: "Singapore Sailing Federation",
    format: "One Design",
    status: "Completed",
    lifecycleStatus: "published",
    scoringSystem: "World Sailing RRS Appendix A (Low Point)",
    rulesNotes:
      "Techno 293 Class. 12 races completed, 2 discards applied per RRS Appendix A. 9 entries. Awards: Open 1st-3rd, Female 1st.",
    websiteUrl: "https://www.sailing.org.sg/events/354194",
    noticeBoardUrl: "https://www.racingrulesofsailing.org/documents/14487/event",
    results: [
      {
        rank: 1,
        name: "Axl Tan",
        sailNumber: "S24",
        gender: "M",
        ageCategory: "Open",
        division: "Open",
        schoolName: "Anglo-Chinese School (Barker Road)",
        club: "Constant Wind SeaSports",
        races: [
          { score: 1 },
          { score: 4, isDiscarded: true },
          { score: 1 },
          { score: 3 },
          { score: 3 },
          { score: 2 },
          { score: 5, isDiscarded: true },
          { score: 1 },
          { score: 2 },
          { score: 2 },
          { score: 3 },
          { score: 1 },
        ],
        grossScore: 28.0,
        nettScore: 19.0,
      },
      {
        rank: 2,
        name: "Shan Qi",
        sailNumber: "26",
        gender: "F",
        ageCategory: "Open",
        division: "Open",
        schoolName: "BEDOK VIEW SECONDARY SCHOOL",
        club: "SAF Yacht Club",
        races: [
          { score: 2 },
          { score: 5, isDiscarded: true },
          { score: 3 },
          { score: 2 },
          { score: 1 },
          { score: 1 },
          { score: 2 },
          { score: 4, isDiscarded: true },
          { score: 3 },
          { score: 1 },
          { score: 4 },
          { score: 2 },
        ],
        grossScore: 30.0,
        nettScore: 21.0,
      },
      {
        rank: 3,
        name: "Kate Teo",
        sailNumber: "4",
        gender: "F",
        ageCategory: "Open",
        division: "Open",
        schoolName: "PAYA LEBAR METHODIST GIRLS' SCHOOL",
        club: "Constant Wind SeaSports",
        races: [
          { score: 5, isDiscarded: true },
          { score: 2 },
          { score: 4 },
          { score: 7, isDiscarded: true },
          { score: 4 },
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 4 },
          { score: 3 },
          { score: 2 },
          { score: 3 },
        ],
        grossScore: 43.0,
        nettScore: 31.0,
      },
      {
        rank: 4,
        name: "Trevor Ng",
        sailNumber: "45",
        gender: "M",
        ageCategory: "Open",
        division: "Open",
        schoolName: "VICTORIA SCHOOL",
        club: "Constant Wind SeaSports",
        races: [
          { score: 3 },
          { score: 1 },
          { score: 2 },
          { score: 4 },
          { score: 6, isDiscarded: true },
          { score: 4 },
          { score: 1 },
          { score: 2 },
          { score: 5 },
          { score: 6, isDiscarded: true },
          { score: 5 },
          { score: 6 },
        ],
        grossScore: 45.0,
        nettScore: 33.0,
      },
      {
        rank: 5,
        name: "Addy Armand Anuar",
        sailNumber: "143",
        gender: "M",
        ageCategory: "Open",
        division: "Open",
        schoolName: "BEDOK GREEN SECONDARY SCHOOL",
        club: "Constant Wind SeaSports",
        races: [
          { score: 7, isDiscarded: true },
          { score: 7, isDiscarded: true },
          { score: 6 },
          { score: 1 },
          { score: 2 },
          { score: 7 },
          { score: 4 },
          { score: 5 },
          { score: 1 },
          { score: 4 },
          { score: 1 },
          { score: 4 },
        ],
        grossScore: 49.0,
        nettScore: 35.0,
      },
      {
        rank: 6,
        name: "Eunice Yi Ning Tan",
        sailNumber: "679",
        gender: "F",
        ageCategory: "Open",
        division: "Open",
        schoolName: "DUNMAN HIGH SCHOOL",
        club: "SAF Yacht Club",
        races: [
          { score: 6 },
          { score: 3 },
          { score: 7, isDiscarded: true },
          { score: 6 },
          { score: 5 },
          { score: 5 },
          { score: 7, isDiscarded: true },
          { score: 6 },
          { score: 6 },
          { score: 7 },
          { score: 6 },
          { score: 5 },
        ],
        grossScore: 69.0,
        nettScore: 55.0,
      },
      {
        rank: 7,
        name: "Honor Fyfe",
        sailNumber: "6",
        gender: "F",
        ageCategory: "Open",
        division: "Open",
        club: "Windsurfing Association of Singapore",
        races: [
          { score: 4 },
          { score: 6 },
          { score: 5 },
          { score: 5 },
          { score: 7, isDiscarded: true },
          { score: 6 },
          { score: 6 },
          { score: 7, isDiscarded: true },
          { score: 7 },
          { score: 5 },
          { score: 7 },
          { score: 7 },
        ],
        grossScore: 72.0,
        nettScore: 58.0,
      },
      {
        rank: 8,
        name: "Kah Hean Thye",
        sailNumber: "91",
        gender: "M",
        ageCategory: "Open",
        division: "Open",
        schoolName: "NAN HUA HIGH SCHOOL",
        club: "Constant Wind SeaSports",
        races: [
          { score: 9, isDiscarded: true },
          { score: 8, isDiscarded: true },
          { score: 8 },
          { score: 8 },
          { score: 8 },
          { score: 8 },
          { score: 8 },
          { score: 8 },
          { score: 8 },
          { score: 8 },
          { score: 8 },
          { score: 8 },
        ],
        grossScore: 97.0,
        nettScore: 80.0,
      },
      {
        rank: 9,
        name: "Kerraine Lee",
        sailNumber: "11",
        gender: "F",
        ageCategory: "Open",
        division: "Open",
        schoolName: "CHIJ ST. NICHOLAS GIRLS' SCHOOL",
        club: "Constant Wind SeaSports",
        races: [
          { score: 8 },
          { score: 9 },
          { score: 9 },
          { score: 9 },
          { score: 9 },
          { score: 9 },
          { score: 10, isDiscarded: true, code: "RET" },
          { score: 10, isDiscarded: true, code: "DNF" },
          { score: 9 },
          { score: 9 },
          { score: 9 },
          { score: 9 },
        ],
        grossScore: 109.0,
        nettScore: 89.0,
      },
    ],
  },
  {
    id: "techno-snsc-2025",
    name: "Singapore National Sailing Championships 2025",
    shortName: "SNSC 2025",
    dates: "6 - 9 September 2025",
    venue: "National Sailing Centre, Singapore",
    organizer: "Singapore Sailing Federation",
    format: "One Design",
    status: "Completed",
    lifecycleStatus: "published",
    scoringSystem: "World Sailing RRS Appendix A (Low Point)",
    rulesNotes:
      "Techno 293 Class. 12 races completed, 2 discards applied per RRS Appendix A. 14 entries. Awards: Open 1st-3rd, Female 1st, 15&U (6.8m) 1st-3rd, 17&U (7.8m) 1st-3rd.",
    websiteUrl: "https://www.sailing.org.sg/events/298131",
    noticeBoardUrl: "https://www.racingrulesofsailing.org/documents/11799/event",
    results: [
      {
        rank: 1,
        name: "Trevor Ng",
        sailNumber: "45",
        gender: "M",
        ageCategory: "17&U (7.8m)",
        division: "Open",
        schoolName: "VICTORIA SCHOOL",
        club: "CWSS",
        races: [
          {score: 2.0},
          {score: 3.0, isDiscarded: true},
          {score: 3.0, isDiscarded: true},
          {score: 3.0},
          {score: 2.0},
          {score: 1.0},
          {score: 1.0},
          {score: 1.0},
          {score: 1.0},
          {score: 1.0},
          {score: 3.0},
          {score: 3.0},
        ],
        grossScore: 24.0,
        nettScore: 18.0,
      },
      {
        rank: 2,
        name: "Axl Tan",
        sailNumber: "82",
        gender: "M",
        ageCategory: "17&U (7.8m)",
        division: "Open",
        schoolName: "ANGLO-CHINESE SCHOOL (BARKER ROAD)",
        club: "CWSS",
        races: [
          {score: 3.0},
          {score: 2.0},
          {score: 1.0},
          {score: 2.0},
          {score: 5.0, isDiscarded: true},
          {score: 2.0},
          {score: 5.0, isDiscarded: true},
          {score: 2.0},
          {score: 2.0},
          {score: 2.0},
          {score: 1.0},
          {score: 1.0},
        ],
        grossScore: 28.0,
        nettScore: 18.0,
      },
      {
        rank: 3,
        name: "Sai Patil",
        sailNumber: "27",
        gender: "M",
        ageCategory: "17&U (7.8m)",
        division: "Open",
        schoolName: "",
        club: "YAI",
        races: [
          {score: 1.0},
          {score: 1.0},
          {score: 2.0},
          {score: 1.0},
          {score: 1.0},
          {score: 3.0},
          {score: 3.0},
          {score: 4.0},
          {score: 5.0, isDiscarded: true},
          {score: 5.0, isDiscarded: true},
          {score: 2.0},
          {score: 2.0},
        ],
        grossScore: 30.0,
        nettScore: 20.0,
      },
      {
        rank: 4,
        name: "Udaiveer Singh Johal",
        sailNumber: "01",
        gender: "M",
        ageCategory: "15&U (6.8m)",
        division: "Open",
        schoolName: "",
        club: "YAI",
        races: [
          {score: 6.0, isDiscarded: true},
          {score: 4.0},
          {score: 4.0},
          {score: 4.0},
          {score: 4.0},
          {score: 6.0},
          {score: 2.0},
          {score: 3.0},
          {score: 4.0},
          {score: 8.0, isDiscarded: true},
          {score: 4.0},
          {score: 6.0},
        ],
        grossScore: 55.0,
        nettScore: 41.0,
      },
      {
        rank: 5,
        name: "Mohit Mhatre",
        sailNumber: "16",
        gender: "M",
        ageCategory: "15&U (6.8m)",
        division: "Open",
        schoolName: "",
        club: "YAI",
        races: [
          {score: 5.0},
          {score: 5.0},
          {score: 8.0, isDiscarded: true},
          {score: 6.0},
          {score: 6.0},
          {score: 4.0},
          {score: 4.0},
          {score: 5.0},
          {score: 3.0},
          {score: 4.0},
          {score: 8.0, isDiscarded: true},
          {score: 4.0},
        ],
        grossScore: 62.0,
        nettScore: 46.0,
      },
      {
        rank: 6,
        name: "Priyanshi Patil",
        sailNumber: "1",
        gender: "F",
        ageCategory: "15&U (6.8m)",
        division: "Open",
        schoolName: "",
        club: "YAI",
        races: [
          {score: 4.0},
          {score: 6.0},
          {score: 6.0},
          {score: 5.0},
          {score: 7.0},
          {score: 8.0, isDiscarded: true},
          {score: 15.0, isDiscarded: true, code: "DNF"},
          {score: 7.0},
          {score: 7.0},
          {score: 6.0},
          {score: 5.0},
          {score: 8.0},
        ],
        grossScore: 84.0,
        nettScore: 61.0,
      },
      {
        rank: 7,
        name: "Prathana Bhoi",
        sailNumber: "49",
        gender: "F",
        ageCategory: "17&U (7.8m)",
        division: "Open",
        schoolName: "",
        club: "YAI",
        races: [
          {score: 9.0},
          {score: 15.0, isDiscarded: true, code: "DNF"},
          {score: 10.0},
          {score: 7.0},
          {score: 3.0},
          {score: 7.0},
          {score: 15.0, isDiscarded: true, code: "DNF"},
          {score: 8.0},
          {score: 6.0},
          {score: 3.0},
          {score: 7.0},
          {score: 5.0},
        ],
        grossScore: 95.0,
        nettScore: 65.0,
      },
      {
        rank: 8,
        name: "Vaishnavi V Kajale",
        sailNumber: "02",
        gender: "F",
        ageCategory: "15&U (6.8m)",
        division: "Open",
        schoolName: "",
        club: "YAI",
        races: [
          {score: 7.0},
          {score: 7.0},
          {score: 5.0},
          {score: 9.0},
          {score: 10.0},
          {score: 11.0, isDiscarded: true},
          {score: 15.0, isDiscarded: true, code: "DNF"},
          {score: 9.0},
          {score: 8.0},
          {score: 9.0},
          {score: 10.0},
          {score: 7.0},
        ],
        grossScore: 107.0,
        nettScore: 81.0,
      },
      {
        rank: 9,
        name: "Michael Shi Jun Lim",
        sailNumber: "0",
        gender: "M",
        ageCategory: "17&U (7.8m)",
        division: "Open",
        schoolName: "",
        club: "CWSS",
        races: [
          {score: 10.0},
          {score: 9.0},
          {score: 9.0},
          {score: 8.0},
          {score: 8.0},
          {score: 9.0},
          {score: 15.0, isDiscarded: true, code: "RET"},
          {score: 6.0},
          {score: 9.0},
          {score: 7.0},
          {score: 6.0},
          {score: 15.0, isDiscarded: true, code: "DNC"},
        ],
        grossScore: 111.0,
        nettScore: 81.0,
      },
      {
        rank: 10,
        name: "Rashmita Thimiti",
        sailNumber: "18",
        gender: "F",
        ageCategory: "15&U (6.8m)",
        division: "Open",
        schoolName: "",
        club: "YAI",
        races: [
          {score: 12.0, isDiscarded: true},
          {score: 8.0},
          {score: 11.0},
          {score: 10.0},
          {score: 11.0},
          {score: 10.0},
          {score: 15.0, isDiscarded: true, code: "DNF"},
          {score: 10.0},
          {score: 10.0},
          {score: 10.0},
          {score: 9.0},
          {score: 9.0},
        ],
        grossScore: 125.0,
        nettScore: 98.0,
      },
      {
        rank: 11,
        name: "Addy Armand Anuar",
        sailNumber: "143",
        gender: "M",
        ageCategory: "15&U (6.8m)",
        division: "Open",
        schoolName: "",
        club: "CWSS",
        races: [
          {score: 8.0},
          {score: 10.0},
          {score: 7.0},
          {score: 11.0},
          {score: 9.0},
          {score: 5.0},
          {score: 6.0},
          {score: 15.0, isDiscarded: true, code: "DNF"},
          {score: 15.0, isDiscarded: true, code: "DNF"},
          {score: 15.0, code: "DNF"},
          {score: 15.0, code: "DNF"},
          {score: 15.0, code: "DNC"},
        ],
        grossScore: 131.0,
        nettScore: 101.0,
      },
      {
        rank: 12,
        name: "Ansley Inessa Suganda-Chin",
        sailNumber: "0",
        gender: "F",
        ageCategory: "17&U (7.8m)",
        division: "Open",
        schoolName: "RAFFLES GIRLS' SCHOOL (SECONDARY)",
        club: "WAS",
        races: [
          {score: 11.0},
          {score: 11.0},
          {score: 15.0, isDiscarded: true, code: "DNF"},
          {score: 15.0, isDiscarded: true, code: "DNF"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
        ],
        grossScore: 172.0,
        nettScore: 142.0,
      },
      {
        rank: 13,
        name: "Evan Teo",
        sailNumber: "86",
        gender: "M",
        ageCategory: "15&U (6.8m)",
        division: "Open",
        schoolName: "",
        club: "CWSS",
        races: [
          {score: 15.0, isDiscarded: true, code: "DNS"},
          {score: 15.0, isDiscarded: true, code: "DNF"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
        ],
        grossScore: 180.0,
        nettScore: 150.0,
      },
      {
        rank: 13,
        name: "Kai Ting Hannah Tan",
        sailNumber: "777",
        gender: "F",
        ageCategory: "15&U (6.8m)",
        division: "Open",
        schoolName: "KONG HWA SCHOOL",
        club: "CSC",
        races: [
          {score: 15.0, isDiscarded: true, code: "DNC"},
          {score: 15.0, isDiscarded: true, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNF"},
          {score: 15.0, code: "DNF"},
          {score: 15.0, code: "DNF"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
          {score: 15.0, code: "DNC"},
        ],
        grossScore: 180.0,
        nettScore: 150.0,
      }
    ],
  },
  {
    id: "techno-sw-gp3-2026",
    name: "2026 Southwest Monsoon Grand Prix Series 3 (Grand Finale)",
    shortName: "SW Monsoon GP3",
    dates: "10 - 11 October 2026",
    venue: "National Sailing Centre",
    organizer: "Singapore Sailing Federation & Windsurfing Association Singapore",
    format: "Course Race",
    status: "Upcoming",
    lifecycleStatus: "published",
    scoringSystem: "World Sailing RRS Appendix A (Low Point)",
    rulesNotes:
      "Series 3 of the 2026 SW Monsoon Grand Prix Series. Concluding event of the overall series championship.",
    seriesName: "2026 Southwest Monsoon Grand Prix Series",
    seriesPart: "Series 3",
    websiteUrl: "https://www.sailing.org.sg/events/357398",
  },
  {
    id: "techno-sw-gp2-2026",
    name: "2026 Southwest Monsoon Grand Prix Series 2",
    shortName: "SW Monsoon GP2",
    dates: "29 - 30 August 2026",
    venue: "PAssion Wave @ East Coast",
    organizer: "Singapore Sailing Federation & Windsurfing Association Singapore",
    format: "Course Race",
    status: "Completed",
    lifecycleStatus: "published",
    scoringSystem: "World Sailing RRS Appendix A (Low Point)",
    rulesNotes:
      "Series 2 of the 2026 SW Monsoon Grand Prix Series. 9 races completed, 2 discards applied per RRS Appendix A.",
    seriesName: "2026 Southwest Monsoon Grand Prix Series",
    seriesPart: "Series 2",
    websiteUrl: "https://www.sailing.org.sg/events/357398",
    results: [
      {
        rank: 1,
        name: "Trevor Ng",
        sailNumber: "SGP 45",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 3, isDiscarded: true },
          { score: 3, isDiscarded: true },
          { score: 1 },
          { score: 1 },
          { score: 2 },
          { score: 2 },
          { score: 2 },
          { score: 1 },
          { score: 1 },
        ],
        grossScore: 16.0,
        nettScore: 10.0,
      },
      {
        rank: 2,
        name: "Addy Armand Anuar",
        sailNumber: "SGP 143",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 1 },
          { score: 1 },
          { score: 2 },
          { score: 2 },
          { score: 1 },
          { score: 5, isDiscarded: true },
          { score: 3, isDiscarded: true },
          { score: 2 },
          { score: 2 },
        ],
        grossScore: 19.0,
        nettScore: 11.0,
      },
      {
        rank: 3,
        name: "Shan Qi",
        sailNumber: "SGP 26",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 2 },
          { score: 7, isDiscarded: true },
          { score: 4 },
          { score: 4 },
          { score: 4 },
          { score: 4 },
          { score: 1 },
          { score: 5, isDiscarded: true },
          { score: 3 },
        ],
        grossScore: 34.0,
        nettScore: 22.0,
      },
      {
        rank: 4,
        name: "Kate Teo",
        sailNumber: "SGP 87",
        gender: "F",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 6, isDiscarded: true },
          { score: 4 },
          { score: 6, isDiscarded: true },
          { score: 3 },
          { score: 3 },
          { score: 1 },
          { score: 4 },
          { score: 6 },
          { score: 4 },
        ],
        grossScore: 37.0,
        nettScore: 25.0,
      },
      {
        rank: 5,
        name: "Eunice Yi Ning Tan",
        sailNumber: "SGP 679",
        gender: "F",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 4 },
          { score: 2 },
          { score: 5, isDiscarded: true },
          { score: 5, isDiscarded: true },
          { score: 5 },
          { score: 3 },
          { score: 5 },
          { score: 3 },
          { score: 5 },
        ],
        grossScore: 37.0,
        nettScore: 27.0,
      },
      {
        rank: 6,
        name: "Kah Hean Thye",
        sailNumber: "SGP 417",
        gender: "M",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 7, isDiscarded: true },
          { score: 5 },
          { score: 7, isDiscarded: true },
          { score: 7 },
          { score: 6 },
          { score: 6 },
          { score: 6 },
          { score: 4 },
          { score: 6 },
        ],
        grossScore: 54.0,
        nettScore: 40.0,
      },
      {
        rank: 7,
        name: "Axl Tan",
        sailNumber: "64",
        gender: "M",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 5 },
          { score: 6 },
          { score: 3 },
          { score: 6 },
          { score: 9.0, isDiscarded: true, code: "DNC" },
          { score: 9.0, isDiscarded: true, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
        ],
        grossScore: 65.0,
        nettScore: 47.0,
      },
      {
        rank: 8,
        name: "Kerraine Lee",
        sailNumber: "11",
        gender: "F",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 8, isDiscarded: true },
          { score: 8 },
          { score: 8 },
          { score: 8 },
          { score: 7 },
          { score: 7 },
          { score: 7 },
          { score: 7 },
          { score: 9.0, isDiscarded: true, code: "DNF" },
        ],
        grossScore: 69.0,
        nettScore: 52.0,
      },
    ],
  },
  {
    id: "techno-sw-gp1-2026",
    name: "2026 Southwest Monsoon Grand Prix Series 1",
    shortName: "SW Monsoon GP1",
    dates: "11 - 12 July 2026",
    venue: "Constant Wind Sea Sport Centre",
    organizer: "Singapore Sailing Federation & Windsurfing Association Singapore",
    format: "Course Race",
    status: "Completed",
    lifecycleStatus: "published",
    scoringSystem: "World Sailing RRS Appendix A (Low Point)",
    rulesNotes:
      "Series 1 of the 2026 SW Monsoon Grand Prix Series. 8 races completed, 1 discard applied per RRS Appendix A.",
    seriesName: "2026 Southwest Monsoon Grand Prix Series",
    seriesPart: "Series 1",
    websiteUrl: "https://www.sailing.org.sg/events/357398",
    results: [
      {
        rank: 1,
        name: "Trevor Ng",
        sailNumber: "SGP 45",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 1 },
          { score: 1 },
          { score: 1 },
          { score: 3, isDiscarded: true },
          { score: 2 },
          { score: 2 },
          { score: 1 },
          { score: 1 },
        ],
        grossScore: 12.0,
        nettScore: 9.0,
      },
      {
        rank: 2,
        name: "Addy Armand Anuar",
        sailNumber: "SGP 143",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 2 },
          { score: 5, isDiscarded: true },
          { score: 5 },
          { score: 1 },
          { score: 1 },
          { score: 4 },
          { score: 3 },
          { score: 3 },
        ],
        grossScore: 24.0,
        nettScore: 19.0,
      },
      {
        rank: 3,
        name: "Axl Tan",
        sailNumber: "64",
        gender: "M",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 3 },
          { score: 4 },
          { score: 2 },
          { score: 2 },
          { score: 6, isDiscarded: true },
          { score: 5 },
          { score: 2 },
          { score: 2 },
        ],
        grossScore: 26.0,
        nettScore: 20.0,
      },
      {
        rank: 4,
        name: "Shan Qi",
        sailNumber: "SGP 26",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 5 },
          { score: 2 },
          { score: 3 },
          { score: 4 },
          { score: 3 },
          { score: 6, isDiscarded: true },
          { score: 5 },
          { score: 6 },
        ],
        grossScore: 34.0,
        nettScore: 28.0,
      },
      {
        rank: 5,
        name: "Kate Teo",
        sailNumber: "0",
        gender: "F",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 4 },
          { score: 3 },
          { score: 6, isDiscarded: true },
          { score: 5 },
          { score: 5 },
          { score: 3 },
          { score: 4 },
          { score: 4 },
        ],
        grossScore: 34.0,
        nettScore: 28.0,
      },
      {
        rank: 6,
        name: "Eunice Yi Ning Tan",
        sailNumber: "SGP 679",
        gender: "F",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 6, isDiscarded: true },
          { score: 6 },
          { score: 4 },
          { score: 6 },
          { score: 4 },
          { score: 1 },
          { score: 6 },
          { score: 5 },
        ],
        grossScore: 38.0,
        nettScore: 32.0,
      },
      {
        rank: 7,
        name: "Kah Hean Thye",
        sailNumber: "SGP 417",
        gender: "M",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 9.0, isDiscarded: true, code: "RET" },
          { score: 7 },
          { score: 7 },
          { score: 7 },
          { score: 7 },
          { score: 7 },
          { score: 7 },
          { score: 9.0, code: "DNF" },
        ],
        grossScore: 60.0,
        nettScore: 51.0,
      },
      {
        rank: 8,
        name: "Kerraine Lee",
        sailNumber: "SGP 8",
        gender: "F",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 9.0, isDiscarded: true, code: "RET" },
          { score: 9.0, code: "DNS" },
          { score: 9.0, code: "DNS" },
          { score: 9.0, code: "DNS" },
          { score: 8 },
          { score: 9.0, code: "RET" },
          { score: 9.0, code: "RET" },
          { score: 9.0, code: "RET" },
        ],
        grossScore: 71.0,
        nettScore: 62.0,
      },
    ],
  },
  {
    id: "techno-ne-gp3-2026",
    name: "2026 NE Monsoon Grand Prix Series 3",
    shortName: "NE Monsoon GP3",
    dates: "7 - 8 March 2026",
    venue: "Constant Wind Sea Sport Centre",
    organizer: "Singapore Sailing Federation & Windsurfing Association Singapore",
    format: "Course Race",
    status: "Completed",
    lifecycleStatus: "published",
    scoringSystem: "World Sailing RRS Appendix A (Low Point)",
    rulesNotes:
      "Series 3 of the 2026 NE Monsoon Grand Prix Series. 7 races completed, 1 discard applied per RRS Appendix A.",
    seriesName: "2026 Northeast Monsoon Grand Prix Series",
    seriesPart: "Series 3",
    websiteUrl: "https://www.sailing.org.sg/events/329256",
    results: [
      {
        rank: 1,
        name: "Axl Tan",
        sailNumber: "64",
        gender: "M",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 1 },
          { score: 3, isDiscarded: true },
          { score: 1 },
          { score: 2 },
          { score: 1 },
          { score: 2 },
          { score: 1 },
        ],
        grossScore: 11.0,
        nettScore: 8.0,
      },
      {
        rank: 2,
        name: "Trevor Ng",
        sailNumber: "SGP 45",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 2 },
          { score: 2 },
          { score: 4, isDiscarded: true },
          { score: 1 },
          { score: 2 },
          { score: 1 },
          { score: 3 },
        ],
        grossScore: 15.0,
        nettScore: 11.0,
      },
      {
        rank: 3,
        name: "Addy Armand Anuar",
        sailNumber: "SGP 143",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 3, isDiscarded: true },
          { score: 1 },
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 2 },
        ],
        grossScore: 18.0,
        nettScore: 15.0,
      },
      {
        rank: 4,
        name: "Eunice Yi Ning Tan",
        sailNumber: "SGP 679",
        gender: "F",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 4 },
          { score: 6, isDiscarded: true },
          { score: 5 },
          { score: 4 },
          { score: 4 },
          { score: 4 },
          { score: 5 },
        ],
        grossScore: 32.0,
        nettScore: 26.0,
      },
      {
        rank: 5,
        name: "Shan Qi",
        sailNumber: "SGP 26",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 5 },
          { score: 4 },
          { score: 6, isDiscarded: true },
          { score: 5 },
          { score: 5 },
          { score: 5 },
          { score: 4 },
        ],
        grossScore: 34.0,
        nettScore: 28.0,
      },
      {
        rank: 6,
        name: "Kate Teo",
        sailNumber: "235",
        gender: "F",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 6, isDiscarded: true },
          { score: 5 },
          { score: 2 },
          { score: 6 },
          { score: 6 },
          { score: 6 },
          { score: 6 },
        ],
        grossScore: 37.0,
        nettScore: 31.0,
      },
      {
        rank: 7,
        name: "Joy Chen",
        sailNumber: "88",
        gender: "F",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 9.0, isDiscarded: true, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
        ],
        grossScore: 63.0,
        nettScore: 54.0,
      },
      {
        rank: 7,
        name: "Michael Shi Jun Lim",
        sailNumber: "SGP 38",
        gender: "M",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 9.0, isDiscarded: true, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
        ],
        grossScore: 63.0,
        nettScore: 54.0,
      },
    ],
  },
  {
    id: "techno-ne-gp2-2026",
    name: "2026 NE Monsoon Grand Prix Series 2",
    shortName: "NE Monsoon GP2",
    dates: "31 January – 1 February 2026",
    venue: "Changi Beach Park",
    organizer: "Singapore Sailing Federation & Windsurfing Association Singapore",
    format: "Course Race",
    status: "Completed",
    lifecycleStatus: "published",
    scoringSystem: "World Sailing RRS Appendix A (Low Point)",
    rulesNotes:
      "Series 2 of the 2026 NE Monsoon Grand Prix Series. 14 races completed, 2 discards applied per RRS Appendix A.",
    seriesName: "2026 Northeast Monsoon Grand Prix Series",
    seriesPart: "Series 2",
    websiteUrl: "https://www.sailing.org.sg/events/329256",
    results: [
      {
        rank: 1,
        name: "Axl Tan",
        sailNumber: "64",
        gender: "M",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 1 },
          { score: 1 },
          { score: 2 },
          { score: 1 },
          { score: 1 },
          { score: 2 },
          { score: 2 },
          { score: 4, isDiscarded: true },
          { score: 2 },
          { score: 3, isDiscarded: true },
          { score: 2 },
          { score: 1 },
          { score: 1 },
          { score: 2 },
        ],
        grossScore: 25.0,
        nettScore: 18.0,
      },
      {
        rank: 2,
        name: "Addy Armand Anuar",
        sailNumber: "SGP 143",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 2 },
          { score: 2 },
          { score: 1 },
          { score: 3 },
          { score: 2 },
          { score: 1 },
          { score: 1 },
          { score: 2 },
          { score: 4, isDiscarded: true },
          { score: 2 },
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 5, isDiscarded: true },
        ],
        grossScore: 34.0,
        nettScore: 25.0,
      },
      {
        rank: 3,
        name: "Michael Shi Jun Lim",
        sailNumber: "SGP 38",
        gender: "M",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 2 },
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 4, isDiscarded: true },
          { score: 4, isDiscarded: true },
          { score: 4 },
          { score: 4 },
          { score: 3 },
        ],
        grossScore: 45.0,
        nettScore: 37.0,
      },
      {
        rank: 4,
        name: "Trevor Ng",
        sailNumber: "SGP 45",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 9.0, isDiscarded: true, code: "DNC" },
          { score: 9.0, isDiscarded: true, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 1 },
          { score: 1 },
          { score: 1 },
          { score: 1 },
          { score: 2 },
          { score: 2 },
          { score: 1 },
        ],
        grossScore: 72.0,
        nettScore: 54.0,
      },
      {
        rank: 5,
        name: "Eunice Yi Ning Tan",
        sailNumber: "SGP 679",
        gender: "F",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 5 },
          { score: 4 },
          { score: 4 },
          { score: 4 },
          { score: 6, isDiscarded: true },
          { score: 4 },
          { score: 4 },
          { score: 5 },
          { score: 5 },
          { score: 5 },
          { score: 5 },
          { score: 7, isDiscarded: true },
          { score: 5 },
          { score: 4 },
        ],
        grossScore: 67.0,
        nettScore: 54.0,
      },
      {
        rank: 6,
        name: "Kate Teo",
        sailNumber: "116",
        gender: "F",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 4 },
          { score: 6, isDiscarded: true },
          { score: 5 },
          { score: 5 },
          { score: 4 },
          { score: 5 },
          { score: 5 },
          { score: 6 },
          { score: 6 },
          { score: 6 },
          { score: 6 },
          { score: 6 },
          { score: 6 },
          { score: 7, isDiscarded: true },
        ],
        grossScore: 77.0,
        nettScore: 64.0,
      },
      {
        rank: 7,
        name: "Shan Qi",
        sailNumber: "SGP 26",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 6 },
          { score: 5 },
          { score: 6 },
          { score: 6 },
          { score: 5 },
          { score: 6 },
          { score: 6 },
          { score: 7, isDiscarded: true },
          { score: 7, isDiscarded: true },
          { score: 7 },
          { score: 7 },
          { score: 5 },
          { score: 7 },
          { score: 6 },
        ],
        grossScore: 86.0,
        nettScore: 72.0,
      },
      {
        rank: 8,
        name: "Joy Chen",
        sailNumber: "88",
        gender: "F",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 9.0, isDiscarded: true, code: "DNC" },
          { score: 9.0, isDiscarded: true, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
        ],
        grossScore: 126.0,
        nettScore: 108.0,
      },
    ],
  },
  {
    id: "techno-ne-gp1-2026",
    name: "2026 NE Monsoon Grand Prix Series 1",
    shortName: "NE Monsoon GP1",
    dates: "17 - 18 January 2026",
    venue: "Changi Beach Park",
    organizer: "Singapore Sailing Federation & Windsurfing Association Singapore",
    format: "Course Race",
    status: "Completed",
    lifecycleStatus: "published",
    scoringSystem: "World Sailing RRS Appendix A (Low Point)",
    rulesNotes:
      "Series 1 of the 2026 NE Monsoon Grand Prix Series. 11 races completed, 2 discards applied per RRS Appendix A.",
    seriesName: "2026 Northeast Monsoon Grand Prix Series",
    seriesPart: "Series 1",
    websiteUrl: "https://www.sailing.org.sg/events/329256",
    results: [
      {
        rank: 1,
        name: "Trevor Ng",
        sailNumber: "SGP 45",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 2, isDiscarded: true },
          { score: 1 },
          { score: 1 },
          { score: 2 },
          { score: 2 },
          { score: 1 },
          { score: 1 },
          { score: 2 },
          { score: 1 },
          { score: 1 },
          { score: 9.0, isDiscarded: true, code: "DNF" },
        ],
        grossScore: 23.0,
        nettScore: 12.0,
      },
      {
        rank: 2,
        name: "Axl Tan",
        sailNumber: "82",
        gender: "M",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 1 },
          { score: 2, isDiscarded: true },
          { score: 2 },
          { score: 3, isDiscarded: true },
          { score: 1 },
          { score: 2 },
          { score: 2 },
          { score: 1 },
          { score: 2 },
          { score: 2 },
          { score: 1 },
        ],
        grossScore: 19.0,
        nettScore: 14.0,
      },
      {
        rank: 3,
        name: "Addy Armand Anuar",
        sailNumber: "SGP 143",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 1 },
          { score: 4, isDiscarded: true },
          { score: 4 },
          { score: 4 },
          { score: 4 },
          { score: 3 },
          { score: 5, isDiscarded: true },
          { score: 3 },
        ],
        grossScore: 37.0,
        nettScore: 28.0,
      },
      {
        rank: 4,
        name: "Michael Shi Jun Lim",
        sailNumber: "SGP 38",
        gender: "M",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 4, isDiscarded: true },
          { score: 4, isDiscarded: true },
          { score: 4 },
          { score: 4 },
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 3 },
          { score: 4 },
          { score: 3 },
          { score: 2 },
        ],
        grossScore: 37.0,
        nettScore: 29.0,
      },
      {
        rank: 5,
        name: "Eunice Yi Ning Tan",
        sailNumber: "SGP 679",
        gender: "F",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 5 },
          { score: 5 },
          { score: 5 },
          { score: 7 },
          { score: 5 },
          { score: 9.0, isDiscarded: true, code: "DNF" },
          { score: 6 },
          { score: 9.0, isDiscarded: true, code: "DNF" },
          { score: 5 },
          { score: 4 },
          { score: 4 },
        ],
        grossScore: 64.0,
        nettScore: 46.0,
      },
      {
        rank: 6,
        name: "Joy Chen",
        sailNumber: "88",
        gender: "F",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 6 },
          { score: 6 },
          { score: 9.0, isDiscarded: true, code: "DNF" },
          { score: 5 },
          { score: 9.0, isDiscarded: true, code: "DNF" },
          { score: 5 },
          { score: 5 },
          { score: 9.0, code: "DNF" },
          { score: 9.0, code: "DNF" },
          { score: 9.0, code: "DNF" },
          { score: 9.0, code: "DNF" },
        ],
        grossScore: 81.0,
        nettScore: 63.0,
      },
      {
        rank: 7,
        name: "Shan Qi",
        sailNumber: "SGP 14",
        gender: "M",
        ageCategory: "U17",
        division: "U17",
        races: [
          { score: 9.0, isDiscarded: true, code: "DNF" },
          { score: 9.0, isDiscarded: true, code: "DNF" },
          { score: 9.0, code: "DNF" },
          { score: 6 },
          { score: 9.0, code: "DNF" },
          { score: 9.0, code: "DNF" },
          { score: 9.0, code: "DNF" },
          { score: 9.0, code: "DNF" },
          { score: 9.0, code: "DNF" },
          { score: 6 },
          { score: 5 },
        ],
        grossScore: 89.0,
        nettScore: 71.0,
      },
      {
        rank: 8,
        name: "Kate Teo",
        sailNumber: "0",
        gender: "F",
        ageCategory: "Open",
        division: "Open",
        races: [
          { score: 9.0, isDiscarded: true, code: "DNC" },
          { score: 9.0, isDiscarded: true, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
          { score: 9.0, code: "DNC" },
        ],
        grossScore: 99.0,
        nettScore: 81.0,
      },
    ],
  },
];

export const TECHNO293_STORAGE_KEY = "sailorpath_techno293_regattas_v1";

export function loadTechno293Regattas(): Techno293Regatta[] {
  if (typeof window === "undefined") {
    return SINGAPORE_TECHNO293_REGATTAS;
  }
  try {
    const raw = window.localStorage.getItem(TECHNO293_STORAGE_KEY);
    if (!raw) return SINGAPORE_TECHNO293_REGATTAS;
    const stored = JSON.parse(raw) as Techno293Regatta[];
    if (Array.isArray(stored) && stored.length > 0) {
      const storedMap = new Map(stored.map((r) => [r.id, r]));
      const merged: Techno293Regatta[] = [];
      const visited = new Set<string>();

      for (const def of SINGAPORE_TECHNO293_REGATTAS) {
        if (storedMap.has(def.id)) {
          merged.push(storedMap.get(def.id)!);
        } else {
          merged.push(def);
        }
        visited.add(def.id);
      }
      for (const r of stored) {
        if (!visited.has(r.id)) {
          merged.push(r);
        }
      }
      return merged;
    }
  } catch (e) {
    console.warn("[techno293] Failed to load from localStorage:", e);
  }
  return SINGAPORE_TECHNO293_REGATTAS;
}

export function saveTechno293Regattas(regattas: Techno293Regatta[]): void {
  if (typeof window === "undefined") return;
  try {
    window.localStorage.setItem(TECHNO293_STORAGE_KEY, JSON.stringify(regattas));
  } catch (e) {
    console.warn("[techno293] Failed to save to localStorage:", e);
  }
}

export async function fetchServerTechno293Regattas(options?: {
  includeAll?: boolean;
}): Promise<Techno293Regatta[] | null> {
  if (typeof window === "undefined") return null;
  try {
    const q = options?.includeAll ? "?all=1" : "";
    const endpoint = window.location?.origin
      ? `${window.location.origin}/api/techno293${q}`
      : `/api/techno293${q}`;
    const res = await fetch(endpoint, { cache: "no-store", credentials: "include" });
    if (!res.ok) return null;
    const data = await res.json();
    if (Array.isArray(data?.regattas) && data.regattas.length > 0) {
      if (data.source === "database") {
        saveTechno293Regattas(data.regattas);
      }
      return data.regattas;
    }
  } catch (e) {
    if (process.env.NODE_ENV !== "test") {
      console.warn("[techno293] Failed to fetch from /api/techno293:", e);
    }
  }
  return null;
}

export async function syncTechno293ToServer(
  regattas: Techno293Regatta[]
): Promise<{ success: boolean; error?: string }> {
  if (typeof window === "undefined") return { success: false };
  try {
    const endpoint = window.location?.origin
      ? `${window.location.origin}/api/techno293`
      : "/api/techno293";
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

export async function deleteTechno293FromServer(
  id: string
): Promise<{ success: boolean; error?: string }> {
  if (typeof window === "undefined" || !id) return { success: false };
  try {
    const endpoint = window.location?.origin
      ? `${window.location.origin}/api/techno293`
      : "/api/techno293";
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

export function mergeTechno293RegattaLists(
  primary: Techno293Regatta[],
  secondary: Techno293Regatta[]
): Techno293Regatta[] {
  const map = new Map<string, Techno293Regatta>();

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

  return sortTechno293Regattas(Array.from(map.values()));
}
