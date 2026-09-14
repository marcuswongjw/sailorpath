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
    scoringSystem: "9 races, 1 discard",
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
    id: "ne-monsoon-series-gp1-2026",
    name: "2026 Northeast Monsoon Series GP1",
    shortName: "NE Monsoon GP1",
    dates: "10–11 January 2026",
    venue: "East Coast Park / Constant Wind, Singapore",
    organizer: "Windsurfing Association of Singapore & Singapore Sailing Federation",
    format: "Sprint Slalom",
    status: "Completed",
    scoringSystem: "20 races, 2 discards (Appendix A)",
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
