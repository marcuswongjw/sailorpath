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
  format: "Sprint Slalom" | "Course Race" | "Marathon";
  status: "Completed" | "Upcoming";
  scoringSystem: string;
  rulesNotes: string;
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

export const SINGAPORE_WINGFOIL_REGATTAS: WingfoilRegatta[] = [
  {
    id: "snsc-2026-wingfoil",
    name: "Singapore National Sailing Championships 2026 — WingFoil Sprint Slalom",
    shortName: "SNSC 2026",
    dates: "5–7 September 2026",
    venue: "National Sailing Centre (NSC), Singapore",
    organizer: "Singapore Sailing Federation (SSF)",
    format: "Sprint Slalom",
    status: "Completed",
    scoringSystem: "Appendix A (9 races, 1 discard)",
    rulesNotes: "Delta Buoy Slalom course, 4–5 min heat target time, 1 discard after 4+ races.",
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
    id: "sw-monsoon-gp-2026",
    name: "2026 Southwest Monsoon Grand Prix Series 1–3",
    shortName: "SW Monsoon GP",
    dates: "July – September 2026",
    venue: "Marine Parade / East Coast Park, Singapore",
    organizer: "Singapore Sailing Federation & Windsurfing Association Singapore",
    format: "Sprint Slalom",
    status: "Completed",
    scoringSystem: "Series Points (Low Point System RRS B8)",
    rulesNotes:
      "Slalom, Course, Marathon and GPS Speed challenges across Open, U19, U16, Masters and Women divisions.",
  },
];
