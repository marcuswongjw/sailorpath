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
  lifecycleStatus?: "draft" | "in_review" | "published" | "archived";
  scoringSystem: string;
  rulesNotes: string;
  seriesName?: string;
  seriesPart?: string;
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

/**
 * Standard competitive divisions / categories recognized in Singapore WingFoil.
 */
export const WINGFOIL_CATEGORIES = [
  "Open",
  "16&U",
  "U19",
  "Masters",
  "Grand Masters",
  "Women",
  "Fun Open",
] as const;

export type WingfoilCategory = (typeof WINGFOIL_CATEGORIES)[number];

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
    const res = await fetch(endpoint, { cache: "no-store" });
    if (!res.ok) return null;
    const data = await res.json();
    if (Array.isArray(data?.regattas) && data.regattas.length > 0) {
      saveWingfoilRegattas(data.regattas);
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
