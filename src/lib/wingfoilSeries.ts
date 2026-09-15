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

export type WingfoilSeriesResult = {
  seriesName: string;
  rounds: RoundSummary[];
  totalRacesCompleted: number;
  discardsApplied: number;
  competitors: SeriesSailorResult[];
  divisionChampions: {
    open?: SeriesSailorResult;
    women?: SeriesSailorResult;
    masters?: SeriesSailorResult;
    grandMasters?: SeriesSailorResult;
    youthU19?: SeriesSailorResult;
    youthU16?: SeriesSailorResult;
  };
};

/**
 * Filter for Northeast Monsoon Grand Prix Series events.
 */
export function isNEMonsoonSeriesRegatta(regatta: WingfoilRegatta): boolean {
  if (!regatta) return false;
  if (regatta.seriesName && /monsoon/i.test(regatta.seriesName)) return true;
  return (
    /monsoon/i.test(regatta.name || "") ||
    /monsoon/i.test(regatta.shortName || "") ||
    /^ne-monsoon-series-gp\d/i.test(regatta.id)
  );
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

  // 5. Extract Division Champions per NoR 12.4.1 & 16.1
  const openChamp = competitorRows[0];
  const womenChamp = competitorRows.find((r) => r.gender === "F");
  const mastersChamp = competitorRows.find(
    (r) => /master/i.test(r.ageCategory) && !/grand/i.test(r.ageCategory)
  );
  const grandMastersChamp = competitorRows.find((r) =>
    /grand\s*master/i.test(r.ageCategory)
  );
  const youthU19Champ = competitorRows.find(
    (r) => /u19/i.test(r.ageCategory) || /19&u/i.test(r.ageCategory)
  );
  const youthU16Champ = competitorRows.find(
    (r) =>
      /u16/i.test(r.ageCategory) ||
      /16&u/i.test(r.ageCategory) ||
      /under\s*16/i.test(r.ageCategory)
  );

  return {
    seriesName,
    rounds: roundsSummary,
    totalRacesCompleted,
    discardsApplied: discardsCount,
    competitors: competitorRows,
    divisionChampions: {
      open: openChamp,
      women: womenChamp,
      masters: mastersChamp,
      grandMasters: grandMastersChamp,
      youthU19: youthU19Champ,
      youthU16: youthU16Champ,
    },
  };
}
