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

  // 1. Check for YYYY-MM-DD or YYYY_MM_DD
  const isoMatch = base.match(/(\d{4})[-_](\d{2})[-_](\d{2})/);
  if (isoMatch) {
    startDate = `${isoMatch[1]}-${isoMatch[2]}-${isoMatch[3]}`;
    nameCandidate = base.replace(isoMatch[0], " ").trim();
  } else {
    // 2. Check for DD-MM-YYYY
    const dmyMatch = base.match(/(\d{2})[-_](\d{2})[-_](\d{4})/);
    if (dmyMatch) {
      startDate = `${dmyMatch[3]}-${dmyMatch[2]}-${dmyMatch[1]}`;
      nameCandidate = base.replace(dmyMatch[0], " ").trim();
    } else {
      // 3. Fallback: Check for YYYY
      const yearMatch = base.match(/\b(20\d{2})\b/);
      if (yearMatch) {
        startDate = `${yearMatch[1]}-09-01`;
      } else {
        startDate = new Date().toISOString().split("T")[0];
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
export function computeWingfoilNett(races: WingfoilRaceScore[]): {
  grossScore: number;
  nettScore: number;
  scoredRaces: WingfoilRaceScore[];
} {
  const grossScore = races.reduce((sum, r) => sum + (Number(r.score) || 0), 0);

  const completedCount = races.filter((r) => r.score != null).length;
  let worstIdx = -1;
  let maxScore = -1;

  if (completedCount >= 4) {
    races.forEach((r, idx) => {
      const s = Number(r.score) || 0;
      if (s > maxScore) {
        maxScore = s;
        worstIdx = idx;
      }
    });
  }

  const scoredRaces = races.map((r, idx) => ({
    ...r,
    isDiscarded: idx === worstIdx,
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
  results: WingfoilSailorResult[]
): WingfoilSailorResult[] {
  const recalculated = results.map((sailor) => {
    const { grossScore, nettScore, scoredRaces } = computeWingfoilNett(
      sailor.races
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
