import {
  type WingfoilRegatta,
  type WingfoilSailorResult,
  normalizeSailorName,
} from "./wingfoil";

/**
 * Official discard table per Singapore Sailing Federation / WAS NoR Clause 12.5.2:
 * Discards applied based on total series races completed.
 */
export function getNoRDiscardsCount(racesCompleted: number): number {
  if (racesCompleted <= 4) return 0;
  if (racesCompleted <= 8) return 1;
  if (racesCompleted <= 12) return 2;
  if (racesCompleted <= 16) return 3;
  if (racesCompleted <= 20) return 4;
  if (racesCompleted <= 25) return 5;
  if (racesCompleted <= 30) return 6;
  if (racesCompleted <= 38) return 7;
  if (racesCompleted <= 46) return 8;
  if (racesCompleted <= 54) return 9;
  if (racesCompleted <= 62) return 10;
  if (racesCompleted <= 70) return 11;
  return 12; // 71 - 72 races
}

export type SeriesRaceDetail = {
  globalRaceIndex: number;
  roundId: string;
  roundShortName: string;
  raceInRound: number;
  score: number;
  isDiscarded: boolean;
  code?: string;
};

export type SeriesSailorResult = {
  rank: number;
  name: string;
  sailNumber: string;
  gender: "M" | "F";
  ageCategory: string;
  schoolName?: string;
  club?: string;
  races: SeriesRaceDetail[];
  grossScore: number;
  nettScore: number;
  roundsAttended: string[];
};

export type RoundSummary = {
  id: string;
  name: string;
  shortName: string;
  dates: string;
  raceCount: number;
  attendeeCount: number;
  status: "Completed" | "Upcoming";
};

export type SeriesDivisionId =
  | "open"
  | "women"
  | "u16_boys"
  | "u16_girls"
  | "u19_boys"
  | "u19_girls"
  | "masters"
  | "fun_masters"
  | "grand_masters"
  | "fun_open";

export type SeriesDivisionConfig = {
  id: SeriesDivisionId;
  name: string;
  shortLabel: string;
  subTitle?: string;
};

/**
 * 10 Official Wing Foil classes / divisions per NoR Clause 4.1.
 */
export const OFFICIAL_WINGFOIL_DIVISIONS: SeriesDivisionConfig[] = [
  {
    id: "open",
    name: "Wing Foil Open division",
    shortLabel: "Open",
    subTitle: "Open to all competitors",
  },
  {
    id: "women",
    name: "Wing Foil Women division",
    shortLabel: "Women",
    subTitle: "Open to all female competitors",
  },
  {
    id: "u16_boys",
    name: "Wing Foil U16 Boys division",
    shortLabel: "U16 Boys",
    subTitle: "Under 16 in 2026 (Born after 31 Dec 2010)",
  },
  {
    id: "u16_girls",
    name: "Wing Foil U16 Girls division",
    shortLabel: "U16 Girls",
    subTitle: "Under 16 in 2026 (Born after 31 Dec 2010)",
  },
  {
    id: "u19_boys",
    name: "Wing Foil U19 Boys division",
    shortLabel: "U19 Boys",
    subTitle: "Under 19 in 2026 (Born after 31 Dec 2007)",
  },
  {
    id: "u19_girls",
    name: "Wing Foil U19 Girls division",
    shortLabel: "U19 Girls",
    subTitle: "Under 19 in 2026 (Born after 31 Dec 2007)",
  },
  {
    id: "masters",
    name: "Wing Foil Masters division",
    shortLabel: "Masters (40+)",
    subTitle: "40+ in 2026 (Born before 1 Jan 1987)",
  },
  {
    id: "fun_masters",
    name: "Wing Foil Fun Masters Division",
    shortLabel: "Fun Masters",
    subTitle: "Fun Fleet 40+ (Born before 1 Jan 1987)",
  },
  {
    id: "grand_masters",
    name: "Wing Foil Grand Masters division",
    shortLabel: "Grand Masters (50+)",
    subTitle: "50+ in 2026 (Born before 1 Jan 1977)",
  },
  {
    id: "fun_open",
    name: "Wing Foil Fun Open Division",
    shortLabel: "Fun Open",
    subTitle: "Fun Fleet Open",
  },
];

export type SeriesDivisionStanding = {
  division: SeriesDivisionConfig;
  isConstituted: boolean;
  competitorCount: number;
  champion?: SeriesSailorResult;
  competitors: SeriesSailorResult[];
};

export type WingfoilSeriesResult = {
  seriesName: string;
  rounds: RoundSummary[];
  totalRacesCompleted: number;
  discardsApplied: number;
  competitors: SeriesSailorResult[];
  divisions: SeriesDivisionStanding[];
  divisionChampions: {
    open?: SeriesSailorResult;
    women?: SeriesSailorResult;
    masters?: SeriesSailorResult;
    grandMasters?: SeriesSailorResult;
    youthU19?: SeriesSailorResult;
    youthU16?: SeriesSailorResult;
    u16Boys?: SeriesSailorResult;
    u16Girls?: SeriesSailorResult;
    u19Boys?: SeriesSailorResult;
    u19Girls?: SeriesSailorResult;
    funMasters?: SeriesSailorResult;
    funOpen?: SeriesSailorResult;
  };
};

/**
 * Checks if a sailor is eligible for a specific division.
 * Follows NoR 4.1 & 5.2 eligibility rules.
 */
export function isSailorInDivision(
  sailor: { gender?: string; ageCategory?: string; name?: string },
  divisionId: SeriesDivisionId
): boolean {
  const gender = (sailor.gender || "").toUpperCase();
  const rawCat = (sailor.ageCategory || "").toLowerCase().trim();

  // Open: all competitors qualify
  if (divisionId === "open") return true;

  // Women: female competitors
  if (divisionId === "women") {
    return gender === "F" || rawCat.includes("women") || rawCat.includes("girl");
  }

  // Fun divisions:
  if (rawCat.includes("fun open") || rawCat === "wing foil fun open division") {
    return divisionId === "fun_open";
  }
  if (
    rawCat.includes("fun master") ||
    rawCat.includes("fun masters") ||
    rawCat.includes("fun masters3")
  ) {
    return divisionId === "fun_masters";
  }

  const isU16 =
    rawCat.includes("u16") ||
    rawCat.includes("16&u") ||
    rawCat.includes("16 & u") ||
    rawCat.includes("under 16") ||
    rawCat.includes("u161");

  const isU19 =
    isU16 || // Anyone under 16 is also eligible for under 19
    rawCat.includes("u19") ||
    rawCat.includes("19&u") ||
    rawCat.includes("19 & u") ||
    rawCat.includes("under 19") ||
    rawCat.includes("u192");

  const isGrandMaster =
    rawCat.includes("grand master") ||
    rawCat.includes("grandmaster") ||
    rawCat.includes("grand masters") ||
    rawCat.includes("grand masters4");

  const isMaster =
    (rawCat.includes("master") && !rawCat.includes("fun")) ||
    isGrandMaster; // Grand Master (50+) is also Master (40+)

  switch (divisionId) {
    case "u16_boys":
      return (gender === "M" || !gender) && isU16;
    case "u16_girls":
      return gender === "F" && isU16;
    case "u19_boys":
      return (gender === "M" || !gender) && isU19;
    case "u19_girls":
      return gender === "F" && isU19;
    case "masters":
      return isMaster;
    case "fun_masters":
      return rawCat.includes("fun") && rawCat.includes("master");
    case "grand_masters":
      return isGrandMaster;
    case "fun_open":
      return rawCat.includes("fun");
    default:
      return true;
  }
}

/**
 * Filter strictly for 2026 Northeast Monsoon Grand Prix Series events (GP1, GP2, GP3).
 * Explicitly rejects Southwest Monsoon and non-series regattas.
 */
export function isNEMonsoonSeriesRegatta(regatta: WingfoilRegatta): boolean {
  if (!regatta) return false;
  const id = (regatta.id || "").toLowerCase();
  const name = (regatta.name || "").toLowerCase();
  const shortName = (regatta.shortName || "").toLowerCase();
  const seriesName = (regatta.seriesName || "").toLowerCase();

  // 1. Explicitly reject Southwest Monsoon or other non-NE events
  if (
    id.includes("sw-") ||
    shortName.includes("sw ") ||
    name.includes("southwest") ||
    seriesName.includes("southwest")
  ) {
    return false;
  }

  // 2. Must specifically match Northeast Monsoon or NE Monsoon
  const isNE =
    seriesName.includes("northeast") ||
    seriesName.includes("ne monsoon") ||
    name.includes("northeast") ||
    name.includes("ne monsoon") ||
    shortName.includes("ne monsoon") ||
    id.startsWith("ne-monsoon");

  if (!isNE) return false;

  // 3. Strictly limited to GP1, GP2, and GP3
  const isGP123 =
    /\b(gp\s*[123]|round\s*[123]|gp[123]|prix\s*[123])\b/i.test(name) ||
    /\b(gp\s*[123]|gp[123])\b/i.test(shortName) ||
    /gp[123]/i.test(id);

  return isGP123;
}

/**
 * Calculate overall series results across all Grand Prix rounds per official NoR 12.
 */
export function calculateWingfoilSeries(
  allRegattas: WingfoilRegatta[]
): WingfoilSeriesResult {
  const seriesName = "2026 Northeast Monsoon Grand Prix Series";

  // 1. Identify and order the NE Monsoon Grand Prix rounds (GP1 -> GP2 -> GP3)
  const seriesRounds = allRegattas
    .filter(isNEMonsoonSeriesRegatta)
    .sort((a, b) => {
      const getNum = (str: string) => {
        const m = str.match(/gp\s*(\d)/i) || str.match(/round\s*(\d)/i);
        return m ? parseInt(m[1], 10) : 99;
      };
      return getNum(a.id || a.shortName) - getNum(b.id || b.shortName);
    });

  const roundsSummary: RoundSummary[] = [];
  let totalRacesCompleted = 0;

  // Analyze each round
  for (const round of seriesRounds) {
    const results = round.results || [];
    const attendeeCount = results.length;
    let roundRaceCount = 0;
    if (results.length > 0) {
      roundRaceCount = results.reduce(
        (max, r) => Math.max(max, r.races?.length || 0),
        0
      );
    }
    totalRacesCompleted += roundRaceCount;
    roundsSummary.push({
      id: round.id,
      name: round.name,
      shortName: round.shortName,
      dates: round.dates,
      raceCount: roundRaceCount,
      attendeeCount,
      status: round.status,
    });
  }

  const discardsCount = getNoRDiscardsCount(totalRacesCompleted);

  // 2. Aggregate all unique competitors across all rounds
  type CompetitorRecord = {
    normalizedName: string;
    canonicalName: string;
    sailNumber: string;
    gender: "M" | "F";
    ageCategory: string;
    schoolName?: string;
    club?: string;
    roundsAttended: Set<string>;
    // Map of roundId -> map of raceIndex -> score info
    roundScores: Map<
      string,
      Map<number, { score: number; code?: string }>
    >;
  };

  const competitorsMap = new Map<string, CompetitorRecord>();

  for (const round of seriesRounds) {
    const results = round.results || [];
    for (const sailor of results) {
      const key = normalizeSailorName(sailor.name);
      if (!key) continue;

      let rec = competitorsMap.get(key);
      if (!rec) {
        rec = {
          normalizedName: key,
          canonicalName: sailor.name,
          sailNumber: sailor.sailNumber || "",
          gender: sailor.gender || "M",
          ageCategory: sailor.ageCategory || "Open",
          schoolName: sailor.schoolName,
          club: sailor.club,
          roundsAttended: new Set<string>(),
          roundScores: new Map(),
        };
        competitorsMap.set(key, rec);
      }

      rec.roundsAttended.add(round.id);
      if (!rec.sailNumber && sailor.sailNumber) {
        rec.sailNumber = sailor.sailNumber;
      }
      if (!rec.club && sailor.club) {
        rec.club = sailor.club;
      }
      if (!rec.schoolName && sailor.schoolName) {
        rec.schoolName = sailor.schoolName;
      }

      // Record this round's race scores
      const raceMap = new Map<number, { score: number; code?: string }>();
      (sailor.races || []).forEach((r, idx) => {
        raceMap.set(idx, { score: r.score, code: r.code });
      });
      rec.roundScores.set(round.id, raceMap);
    }
  }

  // 3. For each competitor, assemble the series race array per NoR Clause 12.3:
  // - Sailed race: actual score
  // - Did not attend round (NoR 12.3.2): attendeeCount + 2 (code: "DNC")
  const competitorRows: SeriesSailorResult[] = [];

  for (const rec of competitorsMap.values()) {
    const seriesRaces: SeriesRaceDetail[] = [];
    let globalRaceCounter = 0;

    for (const round of seriesRounds) {
      const roundSummary = roundsSummary.find((s) => s.id === round.id);
      const raceCount = roundSummary?.raceCount || 0;
      if (raceCount === 0) continue;

      const attendeeCount = roundSummary?.attendeeCount || 20;
      // NoR 12.3.2: Competitors who do not attend a Series shall score two more than the number of competitors attending that Series
      const dncScore = attendeeCount + 2;

      const attendedThisRound = rec.roundsAttended.has(round.id);
      const raceMap = rec.roundScores.get(round.id);

      for (let rIdx = 0; rIdx < raceCount; rIdx++) {
        const raceInRound = rIdx + 1;
        let score = dncScore;
        let code: string | undefined = "DNC";

        if (attendedThisRound && raceMap?.has(rIdx)) {
          const entry = raceMap.get(rIdx)!;
          score = entry.score;
          code = entry.code;
        }

        seriesRaces.push({
          globalRaceIndex: globalRaceCounter++,
          roundId: round.id,
          roundShortName: round.shortName,
          raceInRound,
          score,
          isDiscarded: false,
          code,
        });
      }
    }

    // Apply discards: sort race indices by score descending, discard top N
    if (discardsCount > 0 && seriesRaces.length > 0) {
      const indexedScores = seriesRaces.map((r, i) => ({ idx: i, score: r.score }));
      indexedScores.sort((a, b) => b.score - a.score);
      const discardIndices = new Set(
        indexedScores.slice(0, discardsCount).map((item) => item.idx)
      );
      seriesRaces.forEach((r, i) => {
        if (discardIndices.has(i)) {
          r.isDiscarded = true;
        }
      });
    }

    const grossScore = seriesRaces.reduce((sum, r) => sum + r.score, 0);
    const nettScore = seriesRaces.reduce(
      (sum, r) => sum + (r.isDiscarded ? 0 : r.score),
      0
    );

    competitorRows.push({
      rank: 0,
      name: rec.canonicalName,
      sailNumber: rec.sailNumber,
      gender: rec.gender,
      ageCategory: rec.ageCategory,
      schoolName: rec.schoolName,
      club: rec.club,
      races: seriesRaces,
      grossScore,
      nettScore,
      roundsAttended: Array.from(rec.roundsAttended),
    });
  }

  // 4. Sort competitors by nett score ascending with RRS A8 tie-breakers
  competitorRows.sort((a, b) => {
    if (a.nettScore !== b.nettScore) {
      return a.nettScore - b.nettScore;
    }

    // RRS A8.1: Most 1st places, then 2nds, etc.
    const getFinishCounts = (races: SeriesRaceDetail[]) => {
      const counts: Record<number, number> = {};
      for (const r of races) {
        counts[r.score] = (counts[r.score] || 0) + 1;
      }
      return counts;
    };

    const countsA = getFinishCounts(a.races);
    const countsB = getFinishCounts(b.races);

    for (let place = 1; place <= 50; place++) {
      const diff = (countsB[place] || 0) - (countsA[place] || 0);
      if (diff !== 0) return diff;
    }

    // RRS A8.2: Finish in the last completed race
    const lastA = a.races[a.races.length - 1]?.score || 999;
    const lastB = b.races[b.races.length - 1]?.score || 999;
    return lastA - lastB;
  });

  // Assign ranks
  competitorRows.forEach((r, idx) => {
    r.rank = idx + 1;
  });

  // 5. Evaluate all 10 official classes / divisions per NoR Clause 4.1 & 4.2
  // NoR 4.2: A minimum of 3 competitors is required to constitute a class and/or division.
  const MIN_COMPETITORS_TO_CONSTITUTE = 3;

  const divisionStandings: SeriesDivisionStanding[] = OFFICIAL_WINGFOIL_DIVISIONS.map(
    (div) => {
      const divisionCompetitors = competitorRows.filter((c) =>
        isSailorInDivision(c, div.id)
      );
      const isConstituted = divisionCompetitors.length >= MIN_COMPETITORS_TO_CONSTITUTE;
      const champion = isConstituted ? divisionCompetitors[0] : undefined;

      return {
        division: div,
        isConstituted,
        competitorCount: divisionCompetitors.length,
        champion,
        competitors: divisionCompetitors,
      };
    }
  );

  const getDivChamp = (id: SeriesDivisionId) =>
    divisionStandings.find((d) => d.division.id === id && d.isConstituted)?.champion;

  return {
    seriesName,
    rounds: roundsSummary,
    totalRacesCompleted,
    discardsApplied: discardsCount,
    competitors: competitorRows,
    divisions: divisionStandings,
    divisionChampions: {
      open: getDivChamp("open"),
      women: getDivChamp("women"),
      masters: getDivChamp("masters"),
      grandMasters: getDivChamp("grand_masters"),
      youthU19: getDivChamp("u19_boys") || getDivChamp("u19_girls"),
      youthU16: getDivChamp("u16_boys") || getDivChamp("u16_girls"),
      u16Boys: getDivChamp("u16_boys"),
      u16Girls: getDivChamp("u16_girls"),
      u19Boys: getDivChamp("u19_boys"),
      u19Girls: getDivChamp("u19_girls"),
      funMasters: getDivChamp("fun_masters"),
      funOpen: getDivChamp("fun_open"),
    },
  };
}
