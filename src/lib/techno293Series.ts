import {
  type Techno293Regatta,
  normalizeTechno293SailorName,
} from "./techno293";

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

export type Techno293SeriesRaceDetail = {
  globalRaceIndex: number;
  roundId: string;
  roundShortName: string;
  raceInRound: number;
  score: number;
  isDiscarded: boolean;
  code?: string;
};

export type Techno293SeriesSailorResult = {
  rank: number;
  name: string;
  sailNumber: string;
  gender: "M" | "F";
  ageCategory: string;
  schoolName?: string;
  club?: string;
  races: Techno293SeriesRaceDetail[];
  grossScore: number;
  nettScore: number;
  roundsAttended: string[];
};

export type Techno293RoundSummary = {
  id: string;
  name: string;
  shortName: string;
  dates: string;
  raceCount: number;
  attendeeCount: number;
  status: "Completed" | "Upcoming";
};

export type Techno293DivisionId = "open" | "u17" | "u15" | "women";

export type Techno293DivisionConfig = {
  id: Techno293DivisionId;
  name: string;
  shortLabel: string;
  subTitle?: string;
};

export const OFFICIAL_TECHNO293_DIVISIONS: Techno293DivisionConfig[] = [
  {
    id: "open",
    name: "Techno 293 Open division",
    shortLabel: "Open",
    subTitle: "Open to all competitors",
  },
  {
    id: "u17",
    name: "Techno 293 U17 division",
    shortLabel: "U17",
    subTitle: "Under 17 competitors (Techno 7.8m rig)",
  },
  {
    id: "women",
    name: "Techno 293 Women division",
    shortLabel: "Women",
    subTitle: "Female competitors",
  },
  {
    id: "u15",
    name: "Techno 293 U15 division",
    shortLabel: "U15",
    subTitle: "Under 15 competitors (Techno 6.8m rig)",
  },
];

export type Techno293DivisionStanding = {
  division: Techno293DivisionConfig;
  isConstituted: boolean;
  competitorCount: number;
  champion?: Techno293SeriesSailorResult;
  competitors: Techno293SeriesSailorResult[];
};

export type Techno293SeriesResult = {
  seriesName: string;
  rounds: Techno293RoundSummary[];
  totalRacesCompleted: number;
  discardsApplied: number;
  competitors: Techno293SeriesSailorResult[];
  divisions: Techno293DivisionStanding[];
  divisionChampions: {
    open?: Techno293SeriesSailorResult;
    u17?: Techno293SeriesSailorResult;
    women?: Techno293SeriesSailorResult;
    u15?: Techno293SeriesSailorResult;
  };
};

export function isTechno293SailorInDivision(
  sailor: { gender?: string; ageCategory?: string; name?: string; division?: string },
  divisionId: Techno293DivisionId
): boolean {
  const gender = (sailor.gender || "").toUpperCase();
  const rawCat = (sailor.ageCategory || sailor.division || "").toLowerCase().trim();

  if (divisionId === "open") return true;

  if (divisionId === "women") {
    return gender === "F" || rawCat.includes("women") || rawCat.includes("girl");
  }

  const isU15 = rawCat.includes("u15") || rawCat.includes("under 15");
  const isU17 = isU15 || rawCat.includes("u17") || rawCat.includes("under 17");

  switch (divisionId) {
    case "u17":
      return isU17;
    case "u15":
      return isU15;
    default:
      return true;
  }
}

/**
 * Compare two tiebreak sailor race scores per RRS Appendix A8.1 & A8.2.
 */
function breakSeriesTie(
  a: { races: Techno293SeriesRaceDetail[]; nettScore: number },
  b: { races: Techno293SeriesRaceDetail[]; nettScore: number }
): number {
  if (a.nettScore !== b.nettScore) {
    return a.nettScore - b.nettScore;
  }

  // A8.1: Most firsts, most seconds, most thirds, etc. (considering counting scores first)
  const aScores = a.races.map((r) => r.score).sort((x, y) => x - y);
  const bScores = b.races.map((r) => r.score).sort((x, y) => x - y);

  const maxLen = Math.max(aScores.length, bScores.length);
  for (let i = 0; i < maxLen; i++) {
    const sa = aScores[i] ?? 9999;
    const sb = bScores[i] ?? 9999;
    if (sa !== sb) return sa - sb;
  }

  // A8.2: Better score in the last race sailed
  for (let i = a.races.length - 1; i >= 0; i--) {
    const sa = a.races[i]?.score ?? 9999;
    const sb = b.races[i]?.score ?? 9999;
    if (sa !== sb) return sa - sb;
  }

  return 0;
}

export type Techno293SeriesKey = "sw-monsoon" | "ne-monsoon";

export const TECHNO293_SERIES_OPTIONS: {
  key: Techno293SeriesKey;
  name: string;
  shortName: string;
  season: string;
  websiteUrl: string;
  noticeBoardUrl?: string;
}[] = [
  {
    key: "sw-monsoon",
    name: "2026 Southwest Monsoon Grand Prix Series",
    shortName: "SW Monsoon GP (GP1 - GP3)",
    season: "Jul – Oct 2026",
    websiteUrl: "https://www.sailing.org.sg/events/357398",
  },
  {
    key: "ne-monsoon",
    name: "2026 Northeast Monsoon Grand Prix Series",
    shortName: "NE Monsoon GP (GP1 - GP3)",
    season: "Jan – Mar 2026",
    websiteUrl: "https://www.sailing.org.sg/events/329256",
  },
];

export function isTechnoNEMonsoonRegatta(regatta: Techno293Regatta): boolean {
  if (!regatta) return false;
  const s = `${regatta.id} ${regatta.name} ${regatta.shortName} ${regatta.seriesName || ""}`.toLowerCase();
  if (s.includes("sw-") || s.includes("southwest") || s.includes("sw monsoon")) return false;
  return s.includes("northeast") || s.includes("ne monsoon") || s.includes("ne-monsoon");
}

export function isTechnoSWMonsoonRegatta(regatta: Techno293Regatta): boolean {
  if (!regatta) return false;
  const s = `${regatta.id} ${regatta.name} ${regatta.shortName} ${regatta.seriesName || ""}`.toLowerCase();
  if (s.includes("ne-") || s.includes("northeast") || s.includes("ne monsoon")) return false;
  return s.includes("southwest") || s.includes("sw monsoon") || s.includes("sw-monsoon");
}

/**
 * Calculate cumulative Grand Prix series results for Techno 293 (SW or NE Monsoon).
 */
export function calculateTechno293SeriesResults(
  regattas: Techno293Regatta[],
  seriesKeyOrName: Techno293SeriesKey | string = "sw-monsoon"
): Techno293SeriesResult {
  const isNE =
    seriesKeyOrName === "ne-monsoon" ||
    seriesKeyOrName.toLowerCase().includes("northeast") ||
    seriesKeyOrName.toLowerCase().includes("ne monsoon");

  const seriesName = isNE
    ? "2026 Northeast Monsoon Grand Prix Series"
    : "2026 Southwest Monsoon Grand Prix Series";

  const filterFn = isNE ? isTechnoNEMonsoonRegatta : isTechnoSWMonsoonRegatta;

  // Filter regattas belonging to this series and sort in chronological order (GP1 -> GP2 -> GP3)
  const seriesRegattas = regattas
    .filter(filterFn)
    .sort((a, b) => {
      const getNum = (r: Techno293Regatta) => {
        const m = (r.seriesPart || r.shortName || r.name).match(/([123])/);
        return m ? parseInt(m[1], 10) : 0;
      };
      return getNum(a) - getNum(b);
    });

  const rounds: Techno293RoundSummary[] = [];
  const rawCompetitorsMap = new Map<
    string,
    {
      normalizedName: string;
      name: string;
      sailNumber: string;
      gender: "M" | "F";
      ageCategory: string;
      schoolName?: string;
      club?: string;
      roundsAttended: Set<string>;
      rawScores: {
        globalRaceIndex: number;
        roundId: string;
        roundShortName: string;
        raceInRound: number;
        score: number;
        code?: string;
      }[];
    }
  >();

  let totalRacesCompleted = 0;
  const roundRaceCounts: { roundId: string; shortName: string; raceCount: number; attendeeCount: number }[] = [];

  for (const regatta of seriesRegattas) {
    const hasResults = regatta.results && regatta.results.length > 0;
    const raceCount = hasResults
      ? Math.max(...regatta.results!.map((r) => r.races.length), 0)
      : 0;
    const attendeeCount = hasResults ? regatta.results!.length : 0;

    rounds.push({
      id: regatta.id,
      name: regatta.name,
      shortName: regatta.shortName,
      dates: regatta.dates,
      raceCount,
      attendeeCount,
      status: regatta.status,
    });

    roundRaceCounts.push({
      roundId: regatta.id,
      shortName: regatta.shortName,
      raceCount,
      attendeeCount,
    });

    if (hasResults) {
      for (const sailor of regatta.results!) {
        const norm = normalizeTechno293SailorName(sailor.name);
        if (!rawCompetitorsMap.has(norm)) {
          rawCompetitorsMap.set(norm, {
            normalizedName: norm,
            name: sailor.name,
            sailNumber: sailor.sailNumber,
            gender: sailor.gender,
            ageCategory: sailor.ageCategory || sailor.division || "Open",
            schoolName: sailor.schoolName,
            club: sailor.club,
            roundsAttended: new Set(),
            rawScores: [],
          });
        }

        const comp = rawCompetitorsMap.get(norm)!;
        comp.roundsAttended.add(regatta.id);
        if (sailor.sailNumber && (!comp.sailNumber || comp.sailNumber === "0")) {
          comp.sailNumber = sailor.sailNumber;
        }
        if (sailor.schoolName && !comp.schoolName) {
          comp.schoolName = sailor.schoolName;
        }
        if (sailor.club && !comp.club) {
          comp.club = sailor.club;
        }
        if (sailor.ageCategory && comp.ageCategory === "Open" && sailor.ageCategory !== "Open") {
          comp.ageCategory = sailor.ageCategory;
        }
      }
    }
  }

  // Count total completed races across rounds
  totalRacesCompleted = roundRaceCounts.reduce((acc, r) => acc + r.raceCount, 0);
  const discardsCount = getNoRDiscardsCount(totalRacesCompleted);
  const totalUniqueCompetitors = rawCompetitorsMap.size;

  // Build the complete matrix of scores for each competitor
  const competitorsList: Omit<Techno293SeriesSailorResult, "rank">[] = [];

  for (const comp of Array.from(rawCompetitorsMap.values())) {
    let globalRaceIndex = 1;
    const sailorRaces: Techno293SeriesRaceDetail[] = [];

    for (const round of roundRaceCounts) {
      if (round.raceCount === 0) continue;

      const regatta = seriesRegattas.find((r) => r.id === round.roundId);
      const roundSailorResult = regatta?.results?.find(
        (r) => normalizeTechno293SailorName(r.name) === comp.normalizedName
      );

      const roundDncScore = Math.max(round.attendeeCount + 2, totalUniqueCompetitors + 1);

      for (let rIdx = 0; rIdx < round.raceCount; rIdx++) {
        const raceScoreObj = roundSailorResult?.races[rIdx];

        if (raceScoreObj !== undefined) {
          sailorRaces.push({
            globalRaceIndex,
            roundId: round.roundId,
            roundShortName: round.shortName,
            raceInRound: rIdx + 1,
            score: raceScoreObj.score,
            isDiscarded: false,
            code: raceScoreObj.code,
          });
        } else {
          sailorRaces.push({
            globalRaceIndex,
            roundId: round.roundId,
            roundShortName: round.shortName,
            raceInRound: rIdx + 1,
            score: roundDncScore,
            isDiscarded: false,
            code: "DNC",
          });
        }
        globalRaceIndex++;
      }
    }

    // Apply cumulative discards: discard worst scores
    const sortedIndices = sailorRaces
      .map((r, idx) => ({ idx, score: r.score }))
      .sort((a, b) => b.score - a.score);

    const discardedSet = new Set<number>();
    for (let d = 0; d < discardsCount && d < sortedIndices.length; d++) {
      discardedSet.add(sortedIndices[d].idx);
    }

    let gross = 0;
    let nett = 0;
    for (let i = 0; i < sailorRaces.length; i++) {
      gross += sailorRaces[i].score;
      if (discardedSet.has(i)) {
        sailorRaces[i].isDiscarded = true;
      } else {
        sailorRaces[i].isDiscarded = false;
        nett += sailorRaces[i].score;
      }
    }

    competitorsList.push({
      name: comp.name,
      sailNumber: comp.sailNumber,
      gender: comp.gender,
      ageCategory: comp.ageCategory,
      schoolName: comp.schoolName,
      club: comp.club,
      races: sailorRaces,
      grossScore: Math.round(gross * 10) / 10,
      nettScore: Math.round(nett * 10) / 10,
      roundsAttended: Array.from(comp.roundsAttended),
    });
  }

  // Sort overall competitors by nettScore and tiebreaks
  competitorsList.sort(breakSeriesTie);

  const competitors: Techno293SeriesSailorResult[] = competitorsList.map((c, idx) => ({
    ...c,
    rank: idx + 1,
  }));

  // Build division standings per NoR Clause 4.1 & 4.2
  const divisions: Techno293DivisionStanding[] = OFFICIAL_TECHNO293_DIVISIONS.map((divConfig) => {
    const divCompetitors = competitors
      .filter((c) => isTechno293SailorInDivision(c, divConfig.id))
      .map((c, idx) => ({
        ...c,
        rank: idx + 1,
      }));

    const isConstituted = divCompetitors.length >= 3;
    const champion = isConstituted && divCompetitors.length > 0 ? divCompetitors[0] : undefined;

    return {
      division: divConfig,
      isConstituted,
      competitorCount: divCompetitors.length,
      champion,
      competitors: divCompetitors,
    };
  });

  const divisionChampions: Techno293SeriesResult["divisionChampions"] = {
    open: divisions.find((d) => d.division.id === "open")?.champion,
    u17: divisions.find((d) => d.division.id === "u17")?.champion,
    women: divisions.find((d) => d.division.id === "women")?.champion,
    u15: divisions.find((d) => d.division.id === "u15")?.champion,
  };

  return {
    seriesName,
    rounds,
    totalRacesCompleted,
    discardsApplied: discardsCount,
    competitors,
    divisions,
    divisionChampions,
  };
}
