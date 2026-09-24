import type { RegattaRecord } from "./ranking";
import type { PublicRegattaResult } from "./ilca6ResultsData";

export interface CompetitorResult29er {
  rank: number;
  sailorName: string;
  sailNumber: string;
  gender: "M" | "F";
  birthYear?: number;
  schoolName?: string;
  club?: string;
  nationality?: string;
  totalScore: number;
  nettScore: number;
  isDns?: boolean;
  races: Array<{
    raceNumber: number;
    score: number;
    scoringCode?: string;
    discarded?: boolean;
    rawValue: string;
  }>;
}

export const CSC_2026_29ER_RESULTS: CompetitorResult29er[] = [
  {
    rank: 1,
    sailorName: "Cheryl Yong Heng Xi",
    sailNumber: "2466",
    gender: "F",
    club: "Changi Sailing Club",
    nationality: "SGP",
    totalScore: 12,
    nettScore: 9,
    races: [
      { raceNumber: 1, score: 2, rawValue: "2" },
      { raceNumber: 2, score: 3, discarded: true, rawValue: "3" },
      { raceNumber: 3, score: 2, rawValue: "2" },
      { raceNumber: 4, score: 1, rawValue: "1" },
      { raceNumber: 5, score: 2, rawValue: "2" },
      { raceNumber: 6, score: 1, rawValue: "1" },
      { raceNumber: 7, score: 1, rawValue: "1" },
    ],
  },
  {
    rank: 2,
    sailorName: "Sean Kum",
    sailNumber: "2472",
    gender: "M",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 13,
    nettScore: 10,
    races: [
      { raceNumber: 1, score: 3, discarded: true, rawValue: "3" },
      { raceNumber: 2, score: 1, rawValue: "1" },
      { raceNumber: 3, score: 1, rawValue: "1" },
      { raceNumber: 4, score: 2, rawValue: "2" },
      { raceNumber: 5, score: 1, rawValue: "1" },
      { raceNumber: 6, score: 3, rawValue: "3" },
      { raceNumber: 7, score: 2, rawValue: "2" },
    ],
  },
  {
    rank: 3,
    sailorName: "Cheryl Ho",
    sailNumber: "2869",
    gender: "F",
    schoolName: "Raffles Girls' School",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 17,
    nettScore: 14,
    races: [
      { raceNumber: 1, score: 1, rawValue: "1" },
      { raceNumber: 2, score: 2, rawValue: "2" },
      { raceNumber: 3, score: 3, discarded: true, rawValue: "3" },
      { raceNumber: 4, score: 3, rawValue: "3" },
      { raceNumber: 5, score: 3, rawValue: "3" },
      { raceNumber: 6, score: 2, rawValue: "2" },
      { raceNumber: 7, score: 3, rawValue: "3" },
    ],
  },
];

export const TWENTY_NINER_STATIC_REGATTAS: RegattaRecord[] = [
  {
    id: "csc-2026-29er",
    name: "6th CSC ILCA & 29er Open 2026 (29er)",
    slug: "csc-2026-29er",
    date: "2026-02-28",
    endDate: "2026-03-01",
    boatClass: "29er",
    division: "Youth",
    totalFleetSize: 3,
    raceCount: 7,
    geography: "SG",
    countsForRanking: true,
    venue: "Changi Sailing Club, Singapore",
    organizer: "Changi Sailing Club",
    norUrl: "https://www.csc.org.sg",
    registrationUrl: "https://www.csc.org.sg/csc-ilca-29er-championships-entry-form/",
    scheduleNotes: "6th CSC ILCA & 29er Open 2026 29er fleet: 3 entries, 7 races sailed (1 discard).",
  },
];

function slugifyName(name: string): string {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
}

export function getStatic29erResults(
  regattaIdOrSlug: string
): PublicRegattaResult[] | null {
  const norm = regattaIdOrSlug.toLowerCase();
  let entries: CompetitorResult29er[] | null = null;
  let regatta: RegattaRecord | null = null;

  const directMatch = TWENTY_NINER_STATIC_REGATTAS.find(
    (r) => r.id.toLowerCase() === norm || r.slug.toLowerCase() === norm
  );

  if (directMatch) {
    regatta = directMatch;
    entries = CSC_2026_29ER_RESULTS;
  } else if (norm.includes("csc") && norm.includes("29er")) {
    regatta = TWENTY_NINER_STATIC_REGATTAS[0];
    entries = CSC_2026_29ER_RESULTS;
  }

  if (!entries || !regatta) return null;

  return entries.map((c, index) => {
    const sailorId = `sailor-29er-${slugifyName(c.sailorName)}`;
    const resultId = `res-${regatta.id}-${index + 1}`;
    return {
      resultId,
      sailorId,
      regattaId: regatta.id,
      rank: c.rank,
      nettScore: c.nettScore,
      totalScore: c.totalScore,
      isDns: c.isDns ?? false,
      isOverseasCommitment: false,
      sailorName: c.sailorName,
      sailNumber: c.sailNumber,
      handle: slugifyName(c.sailorName),
      school: c.schoolName ?? null,
      club: c.club ?? null,
      gender: c.gender,
      sailorGender: c.gender,
      birthYear: c.birthYear ?? null,
      dob: null,
      nationality: c.nationality ?? "SGP",
      sailorNationality: c.nationality ?? "SGP",
      verificationStatus: "verified",
      regattaSlug: regatta.slug,
      regattaName: regatta.name,
      raceResults: c.races.map((r) => ({
        regattaResultId: resultId,
        raceNumber: r.raceNumber,
        score: r.score,
        scoringCode: r.scoringCode ?? null,
        discarded: r.discarded ?? false,
        rawValue: r.rawValue,
      })),
    };
  });
}
