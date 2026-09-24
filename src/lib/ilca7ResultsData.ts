/**
 * ILCA 7 Regatta Results Data for:
 * 1. Temasek Regatta 2026 (ILCA 7) - 7 entries, 5 races, 1 discard (20–21 June 2026)
 *
 * Source: Official Singapore Sailing Federation Sailwave scoring sheets.
 */

import type { RegattaRecord, SailorRecord, RegattaResultRecord } from "@/lib/ranking";
import type { PublicRegattaResult } from "@/lib/ilca6ResultsData";

export interface Ilca7RaceScore {
  raceNumber: number;
  score: number;
  rawValue: string;
  scoringCode?: string | null;
  discarded?: boolean;
}

export interface Ilca7CompetitorResult {
  rank: number;
  sailorName: string;
  sailNumber: string;
  ageCategory?: string | null;
  novice?: boolean;
  gender: "M" | "F";
  schoolName?: string | null;
  club: string;
  nationality?: string | null;
  yearOfBirth?: number;
  totalScore: number;
  nettScore: number;
  isDns?: boolean;
  races: Ilca7RaceScore[];
}

export const TEMASEK_2026_ILCA7_RESULTS: Ilca7CompetitorResult[] = [
  {
    rank: 1,
    sailorName: "Andrew Crombie",
    sailNumber: "224714",
    gender: "M",
    club: "Changi Sailing Club",
    nationality: "SGP",
    totalScore: 9,
    nettScore: 6,
    races: [
      { raceNumber: 1, score: 1, rawValue: "1" },
      { raceNumber: 2, score: 2, rawValue: "2" },
      { raceNumber: 3, score: 1, rawValue: "1" },
      { raceNumber: 4, score: 3, rawValue: "3", discarded: true },
      { raceNumber: 5, score: 2, rawValue: "2" },
    ],
  },
  {
    rank: 2,
    sailorName: "Yeo Ngak Hoe",
    sailNumber: "193939",
    gender: "M",
    club: "Constant Wind SeaSports",
    nationality: "SGP",
    totalScore: 15,
    nettScore: 10,
    races: [
      { raceNumber: 1, score: 4, rawValue: "4" },
      { raceNumber: 2, score: 1, rawValue: "1" },
      { raceNumber: 3, score: 5, rawValue: "5", discarded: true },
      { raceNumber: 4, score: 1, rawValue: "1" },
      { raceNumber: 5, score: 4, rawValue: "4" },
    ],
  },
  {
    rank: 3,
    sailorName: "Rohit Behl",
    sailNumber: "224860",
    gender: "M",
    club: "Changi Sailing Club",
    nationality: "SGP",
    totalScore: 14,
    nettScore: 10,
    races: [
      { raceNumber: 1, score: 2, rawValue: "2" },
      { raceNumber: 2, score: 4, rawValue: "4", discarded: true },
      { raceNumber: 3, score: 3, rawValue: "3" },
      { raceNumber: 4, score: 4, rawValue: "4" },
      { raceNumber: 5, score: 1, rawValue: "1" },
    ],
  },
  {
    rank: 4,
    sailorName: "Sarfraz Ahmad Khan",
    sailNumber: "222436",
    gender: "M",
    club: "Constant Wind SeaSports",
    nationality: "SGP",
    totalScore: 18,
    nettScore: 13,
    races: [
      { raceNumber: 1, score: 3, rawValue: "3" },
      { raceNumber: 2, score: 3, rawValue: "3" },
      { raceNumber: 3, score: 2, rawValue: "2" },
      { raceNumber: 4, score: 5, rawValue: "5", discarded: true },
      { raceNumber: 5, score: 5, rawValue: "5" },
    ],
  },
  {
    rank: 5,
    sailorName: "Lucien Franciscus Henricus van Riel",
    sailNumber: "193945",
    gender: "M",
    club: "Constant Wind SeaSports",
    nationality: "SGP",
    totalScore: 19,
    nettScore: 14,
    races: [
      { raceNumber: 1, score: 5, rawValue: "5", discarded: true },
      { raceNumber: 2, score: 5, rawValue: "5" },
      { raceNumber: 3, score: 4, rawValue: "4" },
      { raceNumber: 4, score: 2, rawValue: "2" },
      { raceNumber: 5, score: 3, rawValue: "3" },
    ],
  },
  {
    rank: 6,
    sailorName: "Romzi Damiri",
    sailNumber: "218246",
    gender: "M",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 32,
    nettScore: 24,
    races: [
      { raceNumber: 1, score: 6, rawValue: "6" },
      { raceNumber: 2, score: 6, rawValue: "6" },
      { raceNumber: 3, score: 6, rawValue: "6" },
      { raceNumber: 4, score: 6, rawValue: "6" },
      { raceNumber: 5, score: 8, rawValue: "8 DNS", scoringCode: "DNS", discarded: true },
    ],
  },
  {
    rank: 7,
    sailorName: "Justiin Ang",
    sailNumber: "158031",
    gender: "M",
    club: "Constant Wind SeaSports",
    nationality: "SGP",
    totalScore: 40,
    nettScore: 32,
    isDns: true,
    races: [
      { raceNumber: 1, score: 8, rawValue: "8 DNC", scoringCode: "DNC", discarded: true },
      { raceNumber: 2, score: 8, rawValue: "8 DNC", scoringCode: "DNC" },
      { raceNumber: 3, score: 8, rawValue: "8 DNC", scoringCode: "DNC" },
      { raceNumber: 4, score: 8, rawValue: "8 DNC", scoringCode: "DNC" },
      { raceNumber: 5, score: 8, rawValue: "8 DNC", scoringCode: "DNC" },
    ],
  },
];



export const ILCA7_STATIC_REGATTAS: RegattaRecord[] = [
  {
    id: "reg-temasek-2026-ilca-7",
    name: "Temasek Regatta 2026 (ILCA 7)",
    slug: "temasek-2026-ilca-7",
    date: "2026-06-20",
    endDate: "2026-06-21",
    boatClass: "ILCA 7",
    division: "Open",
    totalFleetSize: 7,
    raceCount: 5,
    geography: "SG",
    countsForRanking: true,
    venue: "National Sailing Centre, Singapore",
    organizer: "Singapore Sailing Federation",
    norUrl: "https://www.racingrulesofsailing.org/documents/13596/event",
    registrationUrl: "https://www.sailing.org.sg/events/335514",
    scheduleNotes: "Temasek Regatta 2026 ILCA 7 fleet: 7 entries, 5 races sailed (1 discard).",
  },
];

function slugifyName(name: string): string {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
}

export function getStaticIlca7Results(
  regattaIdOrSlug: string
): PublicRegattaResult[] | null {
  const norm = regattaIdOrSlug.toLowerCase();
  let entries: Ilca7CompetitorResult[] | null = null;
  let regatta: RegattaRecord | null = null;

  const directMatch = ILCA7_STATIC_REGATTAS.find(
    (r) => r.id.toLowerCase() === norm || r.slug.toLowerCase() === norm
  );
  if (directMatch) {
    regatta = directMatch;
    entries = TEMASEK_2026_ILCA7_RESULTS;
  } else if (norm.includes("temasek") && (norm.includes("ilca-7") || norm.includes("ilca7"))) {
    entries = TEMASEK_2026_ILCA7_RESULTS;
    regatta = ILCA7_STATIC_REGATTAS[0];
  }

  if (!entries || !regatta) return null;

  return entries.map((c, i) => {
    const resultId = `${regatta!.id}-res-${i + 1}`;
    const sailorId = `sailor-ilca7-${slugifyName(c.sailorName)}`;
    return {
      resultId,
      sailorId,
      regattaId: regatta!.id,
      rank: c.rank,
      nettScore: c.nettScore,
      totalScore: c.totalScore,
      isDns: c.isDns || false,
      isOverseasCommitment: false,
      sailorName: c.sailorName,
      sailNumber: c.sailNumber,
      handle: slugifyName(c.sailorName),
      school: c.schoolName || null,
      club: c.club || null,
      gender: c.gender,
      sailorGender: c.gender,
      birthYear: c.yearOfBirth || null,
      dob: null,
      nationality: c.nationality || "SGP",
      sailorNationality: c.nationality || "SGP",
      verificationStatus: "verified" as const,
      regattaSlug: regatta!.slug,
      regattaName: regatta!.name,
      raceResults: c.races.map((r) => ({
        regattaResultId: resultId,
        raceNumber: r.raceNumber,
        score: r.score,
        scoringCode: r.scoringCode || null,
        discarded: r.discarded || false,
        rawValue: r.rawValue,
      })),
    };
  });
}

export function getStaticIlca7RankingsData(): {
  sailors: SailorRecord[];
  regattas: RegattaRecord[];
  results: RegattaResultRecord[];
} {
  const regattas = ILCA7_STATIC_REGATTAS;
  const sailorMap = new Map<string, SailorRecord>();
  const results: RegattaResultRecord[] = [];

  const datasets = [
    { regatta: regattas[0], list: TEMASEK_2026_ILCA7_RESULTS },
  ];

  for (const { regatta, list } of datasets) {
    for (const c of list) {
      const id = `sailor-ilca7-${slugifyName(c.sailorName)}`;
      if (!sailorMap.has(id)) {
        sailorMap.set(id, {
          id,
          name: c.sailorName,
          handle: slugifyName(c.sailorName),
          gender: c.gender,
          nationality: c.nationality || "SGP",
          sailNumber: c.sailNumber,
          club: c.club,
          school: c.schoolName,
          ilca7NationalList: true,
          currentFleet: "Series",
          goldEntryDate: null,
          silverEntryDate: null,
          dropDate: null,
        });
      }
      results.push({
        sailorId: id,
        regattaId: regatta.id,
        rank: c.rank,
        nettScore: c.nettScore,
        totalScore: c.totalScore,
        isDns: c.isDns || false,
      });
    }
  }

  return {
    sailors: Array.from(sailorMap.values()),
    regattas,
    results,
  };
}
