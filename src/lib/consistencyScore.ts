/**
 * Consistency score for a public sailor profile.
 *
 * Percentile badges are a pure function of one place and one fleet size.
 * This is the same kind of calculation: it reads finishes the profile has
 * already loaded and does not scan a ranking board.
 *
 * A finish becomes a place in its own fleet, from 0 (first) to 1 (last):
 *
 *   place = (finish − 1) / (fleet size − 1)
 *
 * The score is how tightly those places cluster. 100 means every counted
 * finish was the same place in the fleet. 0 means they split evenly between
 * first and last. Speed and consistency are separate: a sailor who always
 * finishes last can score 100.
 *
 *   score = round(100 × (1 − 2 × population standard deviation))
 *
 * Population standard deviation divides by the number of finishes, so a
 * perfect front/back split is exactly 0.5 and the score lands on 0.
 */

import { sailingClassKeyOf, sailingClassLabel, type SailingClassKey } from "@/lib/classRegistry";
import { periodBounds, periodLabel, type Period } from "@/lib/ranking";

/** Races required before a race-by-race score is shown. */
export const CONSISTENCY_MIN_RACES = 6;

/**
 * Regatta finishes required when race scores are thinner than
 * {@link CONSISTENCY_MIN_RACES}. One number per event, same scaling.
 */
export const CONSISTENCY_MIN_REGATTAS = 3;

/**
 * Fleets smaller than this are left out. One place in a 3-boat fleet is a
 * third of the scale, so it is not comparable with a national fleet.
 */
export const CONSISTENCY_MIN_FLEET = 5;

/** Score at or above this is "Very consistent" (spread of about a tenth of the fleet). */
export const CONSISTENCY_VERY_MIN = 80;

/** Score at or above this, and below very consistent, is "Consistent". */
export const CONSISTENCY_CONSISTENT_MIN = 60;

/** Letter codes may be glued to points, as in "(DNF97)" or "92.0 BFD". */
const SCORING_CODE_SOURCE =
  "(?:^|[^A-Z])(DNF|DNS|DNC|DSQ|OCS|BFD|UFD|NSC|DNE|DGM|RET|TLE|RAF|DPI|SCP|ZFP|RDG|RFP)(?![A-Z])";

/** Did not start / did not come. Not a raced finish. */
const ABSENCE_CODES = new Set(["DNS", "DNC"]);

/**
 * In the race, but no clean finish. Counted as the back of the fleet so a
 * black flag in a 12-boat fleet is not harsher than one in an 80-boat fleet.
 */
const BACK_OF_FLEET_CODES = new Set([
  "DNF",
  "RET",
  "DSQ",
  "OCS",
  "BFD",
  "UFD",
  "NSC",
  "DNE",
  "DGM",
  "RAF",
  "TLE",
]);

export type ConsistencyRaceInput = {
  score?: number | null;
  scoringCode?: string | null;
  discarded?: boolean | null;
  rawValue?: string | null;
};

export type ConsistencyResultInput = {
  regattaId?: string | null;
  regattaName?: string | null;
  regattaDate?: string | null;
  boatClass?: string | null;
  rank?: number | null;
  fleetSize?: number | null;
  totalFleetSize?: number | null;
  isDns?: boolean | null;
  isDNS?: boolean | null;
  isOverseasCommitment?: boolean | null;
  raceResults?: ConsistencyRaceInput[] | null;
};

export type ConsistencyBand = "very_consistent" | "consistent" | "variable";

export type ConsistencyScoreResult =
  | {
      status: "ready";
      score: number;
      band: ConsistencyBand;
      bandLabel: string;
      /** Race places when there are enough of them; otherwise regatta places. */
      level: "race" | "regatta";
      sampleSize: number;
      classKey: SailingClassKey;
      classLabel: string;
      periodLabel: string;
      /** Short line under the number, e.g. "16 Optimist races · Jul – Dec 2026". */
      basisLabel: string;
      explanation: string;
    }
  | {
      status: "insufficient";
      classKey: SailingClassKey;
      classLabel: string;
      periodLabel: string;
      countedRaces: number;
      countedRegattas: number;
      explanation: string;
    };

export function consistencyBand(score: number): {
  band: ConsistencyBand;
  bandLabel: string;
} {
  if (score >= CONSISTENCY_VERY_MIN) {
    return { band: "very_consistent", bandLabel: "Very consistent" };
  }
  if (score >= CONSISTENCY_CONSISTENT_MIN) {
    return { band: "consistent", bandLabel: "Consistent" };
  }
  return { band: "variable", bandLabel: "Variable" };
}

/**
 * Profile tabs use one ILCA list. Score ILCA 4 on that tab, unless the
 * sailor's ILCA results are only ILCA 6 or only ILCA 7 — then score that
 * class rather than mixing rigs together.
 */
export function consistencyClassForProfileTab(
  tab: string,
  results: readonly Pick<ConsistencyResultInput, "boatClass">[]
): SailingClassKey | null {
  const preferred = preferredClassForTab(tab);
  if (!preferred) return null;
  const present = new Set<SailingClassKey>();
  for (const result of results) {
    const key = sailingClassKeyOf(result.boatClass);
    if (key) present.add(key);
  }
  if (present.has(preferred)) return preferred;
  if (preferred === "ilca4") {
    const folded = (["ilca6", "ilca7"] as const).filter((key) => present.has(key));
    if (folded.length === 1) return folded[0];
  }
  return preferred;
}

function preferredClassForTab(tab: string): SailingClassKey | null {
  switch (tab) {
    case "optimist":
    case "ilca4":
    case "ilca6":
    case "ilca7":
    case "techno293":
    case "wingfoil":
    case "iqfoil":
    case "windsurfing":
      return tab;
    default:
      return null;
  }
}

/** Abbreviations in the scoring code and the published raw cell, uppercased. */
export function scoringCodesFromRace(
  scoringCode: string | null | undefined,
  rawValue: string | null | undefined
): string[] {
  const found: string[] = [];
  const collect = (value: string | null | undefined) => {
    if (!value) return;
    for (const match of value.toUpperCase().matchAll(new RegExp(SCORING_CODE_SOURCE, "gi"))) {
      const code = match[1];
      if (code && !found.includes(code)) found.push(code);
    }
  };
  collect(scoringCode);
  collect(rawValue);
  return found;
}

export type FinishPosition =
  | { ok: true; position: number; kind: "place" | "back" }
  | { ok: false; reason: "absence" | "tiny-fleet" | "no-place" };

/**
 * Fleet-scaled place for one race or one regatta finish.
 * Discarded races are the caller's choice to pass in; this function does
 * not drop them.
 */
export function fleetFinishPosition(input: {
  place: number | null | undefined;
  fleetSize: number | null | undefined;
  codes?: readonly string[];
}): FinishPosition {
  const codes = input.codes ?? [];
  if (codes.some((code) => ABSENCE_CODES.has(code))) {
    return { ok: false, reason: "absence" };
  }
  const fleet = Number(input.fleetSize);
  if (!Number.isFinite(fleet) || fleet < CONSISTENCY_MIN_FLEET) {
    return { ok: false, reason: "tiny-fleet" };
  }
  if (codes.some((code) => BACK_OF_FLEET_CODES.has(code))) {
    return { ok: true, position: 1, kind: "back" };
  }
  const place = Number(input.place);
  if (!Number.isFinite(place) || place < 1) {
    return { ok: false, reason: "no-place" };
  }
  if (place >= fleet) {
    return { ok: true, position: 1, kind: "place" };
  }
  const position = (place - 1) / (fleet - 1);
  return { ok: true, position: clamp01(position), kind: "place" };
}

export function computeConsistencyScore(
  results: readonly ConsistencyResultInput[],
  options: { classKey: SailingClassKey; period: Period }
): ConsistencyScoreResult {
  const classLabel = sailingClassLabel(options.classKey);
  const label = periodLabel(options.period);
  const { start, end } = periodBounds(options.period);
  const inScope = results.filter((result) => {
    if (sailingClassKeyOf(result.boatClass) !== options.classKey) return false;
    const date = String(result.regattaDate || "").slice(0, 10);
    if (!/^\d{4}-\d{2}-\d{2}$/.test(date)) return false;
    return date >= start && date <= end;
  });

  const racePositions: number[] = [];
  const regattaPositions: number[] = [];

  for (const result of inScope) {
    const fleet = result.totalFleetSize ?? result.fleetSize;
    const sailedRegatta =
      !result.isDns && !result.isDNS && !result.isOverseasCommitment;
    if (sailedRegatta) {
      const regattaPlace = fleetFinishPosition({
        place: result.rank,
        fleetSize: fleet,
      });
      if (regattaPlace.ok) regattaPositions.push(regattaPlace.position);
    }
    for (const race of result.raceResults ?? []) {
      const racePlace = fleetFinishPosition({
        place: race.score,
        fleetSize: fleet,
        codes: scoringCodesFromRace(race.scoringCode, race.rawValue),
      });
      if (racePlace.ok) racePositions.push(racePlace.position);
    }
  }

  const useRaces = racePositions.length >= CONSISTENCY_MIN_RACES;
  const useRegattas =
    !useRaces && regattaPositions.length >= CONSISTENCY_MIN_REGATTAS;

  if (!useRaces && !useRegattas) {
    return {
      status: "insufficient",
      classKey: options.classKey,
      classLabel,
      periodLabel: label,
      countedRaces: racePositions.length,
      countedRegattas: regattaPositions.length,
      explanation: insufficientExplanation(label, classLabel),
    };
  }

  const level = useRaces ? "race" : "regatta";
  const samples = useRaces ? racePositions : regattaPositions;
  const score = consistencyScoreFromPositions(samples);
  const { band, bandLabel } = consistencyBand(score);
  const sampleSize = samples.length;
  return {
    status: "ready",
    score,
    band,
    bandLabel,
    level,
    sampleSize,
    classKey: options.classKey,
    classLabel,
    periodLabel: label,
    basisLabel: basisLabel(level, sampleSize, classLabel, label),
    explanation: readyExplanation(level),
  };
}

/** 100 when every place matches. 0 when finishes split evenly between first and last. */
export function consistencyScoreFromPositions(positions: readonly number[]): number {
  if (positions.length === 0) return 0;
  const spread = populationStdDev(positions);
  const raw = 100 * (1 - Math.min(1, spread / 0.5));
  return clampScore(Math.round(raw));
}

export function populationStdDev(values: readonly number[]): number {
  const n = values.length;
  if (n === 0) return 0;
  const mean = values.reduce((sum, value) => sum + value, 0) / n;
  const variance =
    values.reduce((sum, value) => sum + (value - mean) ** 2, 0) / n;
  return Math.sqrt(variance);
}

function basisLabel(
  level: "race" | "regatta",
  sampleSize: number,
  classLabel: string,
  period: string
): string {
  const unit =
    level === "race"
      ? sampleSize === 1
        ? "race"
        : "races"
      : sampleSize === 1
        ? "regatta"
        : "regattas";
  return `${sampleSize} ${classLabel} ${unit} · ${period}`;
}

function readyExplanation(level: "race" | "regatta"): string {
  const source =
    level === "race"
      ? "It uses every counted race in this class during this ranking half."
      : "Race scores were too few, so it uses overall regatta places for this ranking half instead.";
  return `100 means every counted finish was the same place in the fleet, front or back. A lower score means the places jump around — a win and a deep result, or a black flag mixed with a top finish. Places are scaled by fleet size. Discarded races count. DNS and DNC do not. ${source}`;
}

function insufficientExplanation(period: string, classLabel: string): string {
  return `Not enough ${classLabel} races in ${period} yet. Consistency needs at least ${CONSISTENCY_MIN_RACES} races in fleets of ${CONSISTENCY_MIN_FLEET} or more, or ${CONSISTENCY_MIN_REGATTAS} regatta finishes when race scores are missing.`;
}

function clamp01(value: number): number {
  if (value < 0) return 0;
  if (value > 1) return 1;
  return value;
}

function clampScore(value: number): number {
  if (!Number.isFinite(value)) return 0;
  if (value < 0) return 0;
  if (value > 100) return 100;
  return value;
}
