import { birthYear as parseBirthYear } from "@/lib/age";
import { currentPeriodFromSgToday, periodHalfFromYmd, toYmd, todayYmdSg } from "@/lib/datesSg";
import {
  calculateRankings,
  periodLabel,
  regattaCountsForRanking,
  regattaMatchesSeriesClass,
  resolveSailorFleet,
  sharedOverallRanks,
  type RegattaRecord,
  type RegattaResultRecord,
  type SailorRecord,
} from "@/lib/ranking";

export type GoldFormScope = "sg_ranking" | "all_gold";

export type GoldFormSailorInput = {
  id: string;
  name: string;
  handle?: string | null;
  sailNumber?: string | null;
  club?: string | null;
  school?: string | null;
  gender?: string | null;
  nationality?: string | null;
  dob?: string | Date | null;
  birthYear?: number | null;
  goldEntryDate?: string | Date | null;
  silverEntryDate?: string | Date | null;
  dropDate?: string | Date | null;
  currentFleet?: string | null;
  nationalSquadStatus?: string | null;
};

export type GoldFormRegattaInput = {
  id: string;
  name: string;
  slug?: string | null;
  date: string | Date;
  division?: string | null;
  boatClass?: string | null;
  geography?: string | null;
  countsForRanking?: boolean | null;
  status?: string | null;
  totalFleetSize?: number | null;
};

export type GoldFormResultInput = {
  sailorId: string;
  regattaId: string;
  rank: number;
  nettScore?: number | null;
  isDns?: boolean | null;
  isOverseasCommitment?: boolean | null;
};

export type GoldStartPoint = {
  regattaId: string;
  regattaName: string;
  date: string;
  geography: string | null;
  countsForRanking: boolean;
  rank: number;
  fleetSize: number;
  /** 0-100 finish percentile inside Gold fleet (100 = 1st place) */
  percentile: number;
  nettScore: number | null;
  isRecentWindow: boolean;
  isPriorWindow: boolean;
};

export type GoldFormTier =
  | "best_form"
  | "up_and_coming"
  | "steady_core"
  | "developing"
  | "low_sample";

export type GoldSailorFormEntry = {
  sailorId: string;
  name: string;
  handle: string | null;
  sailNumber: string | null;
  club: string | null;
  gender: "F" | "M" | null;
  birthYear: number | null;
  goldEntryDate: string;
  monthsInGold: number;
  nationalSquadStatus: string | null;
  totalStarts: number;
  recentStarts: number;
  priorStarts: number;
  overseasStarts: number;
  /** 0-100 composite score capturing current Gold competitiveness + recency */
  formIndex: number;
  /** 0-100 watchlist score combining trajectory slope, breakout PB, and age headroom */
  watchlistIndex: number;
  /** 110-day half-life weighted finish percentile across Gold history */
  weightedPercentile: number;
  recentAvgPercentile: number | null;
  priorAvgPercentile: number | null;
  /** Confidence-adjusted percentile gain (recent window minus prior window) */
  momentumDelta: number | null;
  /** Weighted regression slope expressed in percentile points per 6 months */
  slopePerHalf: number | null;
  recentAvgRank: number | null;
  recentBestRank: number | null;
  bestEverRank: number | null;
  lastEventDate: string | null;
  /** Weighted percentile relative to active Gold peers of the same birth year */
  cohortPeerEdge: number | null;
  /** Projected next-half Gold percentile (0-99.5) */
  projectedPercentile: number;
  /** Projected finish position in a typical recent Gold fleet */
  projectedRank: number | null;
  /** Positive = projected climb in places vs current weighted rank */
  projectedRankGain: number | null;
  /** Current Singapore Gold National Ranking (Best 3 of 5 in current half) */
  currentNationalRank: number | null;
  /** Current half Best-3-of-5 national ranking score */
  currentBest3of5: number | null;
  /** True if born <= 2011 (ages out of Optimist after 2026) */
  agingOut2027: boolean;
  /** Composite Best-3-of-5-adjusted score used to rank 30 Jun 2027 projections */
  projectedJun2027Score: number;
  /** Projected Singapore Gold National Ranking by 30 Jun 2027 (null if aging out) */
  projectedNationalRankJun2027: number | null;
  /** Positive = projected climb in National Ranking places by 30 Jun 2027 */
  projectedNationalRankDelta: number | null;
  tier: GoldFormTier;
  confidence: "high" | "medium" | "low";
  tags: string[];
  history: GoldStartPoint[];
};

export type GoldFormIndexSummary = {
  asOfYmd: string;
  referenceYmd: string;
  recentCutoffYmd: string;
  priorCutoffYmd: string;
  currentPeriodLabel: string;
  projectionTargetDate: string;
  scope: GoldFormScope;
  activeGoldCount: number;
  eligible2027Count: number;
  qualifiedCount: number;
  regattaCount: number;
  recentRegattaCount: number;
  typicalFleetSize: number;
  medianBirthYear: number | null;
  cohortAverages: Array<{
    birthYear: number;
    count: number;
    avgWeightedPercentile: number;
  }>;
  entries: GoldSailorFormEntry[];
};

export type SnapshotEntrySummary = {
  sailorId: string;
  name: string;
  birthYear: number | null;
  currentNationalRank: number | null;
  projectedNationalRankJun2027: number | null;
  formIndex: number;
  watchlistIndex: number;
  projectedPercentile: number;
  agingOut2027: boolean;
};

export type SnapshotComparisonRow = {
  sailorId: string;
  name: string;
  birthYear: number | null;
  predictedRank: number;
  baselineRank: number | null;
  actualRank: number | null;
  /** predictedRank - actualRank (+ means finished better than predicted) */
  errorRanks: number | null;
};

export type SnapshotComparisonResult = {
  evaluatedCount: number;
  maeRanks: number | null;
  top10Hits: number;
  top10Total: number;
  top20Hits: number;
  top20Total: number;
  rows: SnapshotComparisonRow[];
};

const RECENT_WINDOW_DAYS = 180;
const PRIOR_WINDOW_DAYS = 420;
const SLOPE_WINDOW_DAYS = 450;
const FORM_HALF_LIFE_DAYS = 110;
const MS_PER_DAY = 86_400_000;
export const PROJECTION_TARGET_DATE = "2027-06-30";

function clamp(min: number, max: number, value: number): number {
  return Math.min(max, Math.max(min, value));
}

function round1(value: number): number {
  return Math.round(value * 10) / 10;
}

function parseYmdMs(ymd: string): number {
  return Date.parse(`${ymd}T12:00:00Z`);
}

function daysBetween(olderYmd: string, newerYmd: string): number {
  const diff = (parseYmdMs(newerYmd) - parseYmdMs(olderYmd)) / MS_PER_DAY;
  return Number.isFinite(diff) ? diff : 0;
}

function shiftDaysYmd(ymd: string, deltaDays: number): string {
  const ms = parseYmdMs(ymd) + deltaDays * MS_PER_DAY;
  if (!Number.isFinite(ms)) return ymd;
  return new Date(ms).toISOString().slice(0, 10);
}

function monthsBetweenYmd(fromYmd: string, toYmdVal: string): number {
  if (!/^\d{4}-\d{2}-\d{2}$/.test(fromYmd) || !/^\d{4}-\d{2}-\d{2}$/.test(toYmdVal)) {
    return 0;
  }
  const [fy, fm] = fromYmd.split("-").map(Number);
  const [ty, tm] = toYmdVal.split("-").map(Number);
  return Math.max(0, (ty - fy) * 12 + (tm - fm));
}

function normGender(g: string | null | undefined): "F" | "M" | null {
  const s = String(g ?? "").trim().toLowerCase();
  if (!s) return null;
  if (s === "f" || s === "female" || s === "girl" || s === "w" || s === "woman") return "F";
  if (s === "m" || s === "male" || s === "boy" || s === "man") return "M";
  return null;
}

function toSailorRecord(s: GoldFormSailorInput): SailorRecord {
  const resolvedBirthYear =
    s.birthYear != null && Number.isInteger(s.birthYear)
      ? s.birthYear
      : parseBirthYear(s.dob);
  const dob =
    toYmd(s.dob) ??
    (resolvedBirthYear != null ? `${resolvedBirthYear}-01-01` : null);
  return {
    id: s.id,
    name: s.name,
    handle: s.handle || s.id,
    sailNumber: s.sailNumber || "",
    club: s.club || "",
    school: s.school ?? null,
    nationality: s.nationality ?? null,
    goldEntryDate: toYmd(s.goldEntryDate),
    silverEntryDate: toYmd(s.silverEntryDate),
    dropDate: toYmd(s.dropDate),
    currentFleet: s.currentFleet ?? "Series",
    dob,
    gender: s.gender ?? null,
    nationalSquadStatus: s.nationalSquadStatus ?? null,
  };
}

function isGoldRegattaEligible(
  regatta: GoldFormRegattaInput,
  scope: GoldFormScope,
  asOfYmd: string,
): boolean {
  const status = String(regatta.status ?? "published").trim().toLowerCase();
  if (status && status !== "published") return false;
  const dateYmd = toYmd(regatta.date);
  if (!dateYmd || dateYmd > asOfYmd) return false;
  const asRecord: RegattaRecord = {
    id: regatta.id,
    name: regatta.name,
    slug: regatta.slug || regatta.id,
    date: dateYmd,
    totalFleetSize: regatta.totalFleetSize ?? 0,
    division: regatta.division ?? "Gold",
    boatClass: regatta.boatClass ?? "Optimist",
    countsForRanking: regatta.countsForRanking !== false,
  };
  if (!regattaMatchesSeriesClass(asRecord, "Optimist")) return false;
  const div = String(regatta.division ?? "Gold").trim().toLowerCase();
  if (div !== "gold" && div !== "both") return false;
  if (scope === "sg_ranking") {
    if (!regattaCountsForRanking(asRecord)) return false;
    const geo = String(regatta.geography ?? "").trim().toUpperCase();
    if (geo && geo !== "SGP") return false;
  }
  return true;
}

export function percentileFromRank(rank: number, fleetSize: number): number {
  const effectiveFleet = Math.max(fleetSize, rank, 2);
  const raw = ((effectiveFleet - rank) / (effectiveFleet - 1)) * 100;
  return round1(clamp(0, 100, raw));
}

export function rankFromPercentile(percentile: number, fleetSize: number): number {
  const n = Math.max(2, Math.round(fleetSize));
  const est = n - (clamp(0, 100, percentile) / 100) * (n - 1);
  return clamp(1, n, Math.round(est));
}

function medianNumber(values: number[]): number | null {
  if (values.length === 0) return null;
  const sorted = [...values].sort((a, b) => a - b);
  const mid = Math.floor(sorted.length / 2);
  if (sorted.length % 2 === 1) return sorted[mid]!;
  return (sorted[mid - 1]! + sorted[mid]!) / 2;
}

function weightedPercentileSlopePerHalf(points: GoldStartPoint[], referenceYmd: string): number | null {
  const windowPoints = points.filter((p) => {
    const ageDays = daysBetween(p.date, referenceYmd);
    return ageDays >= 0 && ageDays <= SLOPE_WINDOW_DAYS;
  });
  if (windowPoints.length < 3) return null;

  // x in units of 6 months (~182.625 days) relative to earliest point in window
  const firstYmd = windowPoints[0]!.date;
  const xs = windowPoints.map((p) => daysBetween(firstYmd, p.date) / 182.625);
  const spanHalves = xs[xs.length - 1]! - xs[0]!;
  if (spanHalves < 0.2) return null;

  const meanX = xs.reduce((a, b) => a + b, 0) / xs.length;
  const ys = windowPoints.map((p) => p.percentile);
  const meanY = ys.reduce((a, b) => a + b, 0) / ys.length;

  let num = 0;
  let den = 0;
  for (let i = 0; i < xs.length; i++) {
    const dx = xs[i]! - meanX;
    num += dx * (ys[i]! - meanY);
    den += dx * dx;
  }
  if (den <= 1e-6) return null;
  const rawSlope = num / den;
  // Shrink short-span / low-sample slopes so noisy 3-event runs stay realistic
  const sampleShrink = Math.min(1, windowPoints.length / 6) * Math.min(1, spanHalves / 0.8);
  return round1(clamp(-35, 40, rawSlope * sampleShrink));
}

function computeWeightedStats(points: GoldStartPoint[], referenceYmd: string) {
  if (points.length === 0) {
    return { weightedPercentile: 0, weightedStdDev: 0 };
  }
  const weights = points.map((p) => {
    const age = Math.max(0, daysBetween(p.date, referenceYmd));
    return Math.max(0.02, Math.exp((-Math.LN2 * age) / FORM_HALF_LIFE_DAYS));
  });
  const totalW = weights.reduce((a, b) => a + b, 0);
  const weightedPercentile =
    points.reduce((sum, p, i) => sum + p.percentile * weights[i]!, 0) / totalW;
  const variance =
    points.reduce(
      (sum, p, i) => sum + weights[i]! * (p.percentile - weightedPercentile) ** 2,
      0,
    ) / totalW;
  return {
    weightedPercentile: round1(weightedPercentile),
    weightedStdDev: round1(Math.sqrt(Math.max(0, variance))),
  };
}

function buildTags(params: {
  formIndex: number;
  watchlistIndex: number;
  momentumDelta: number | null;
  slopePerHalf: number | null;
  recentBestRank: number | null;
  bestEverRank: number | null;
  recentAvgPercentile: number | null;
  priorAvgPercentile: number | null;
  birthYear: number | null;
  medianBirthYear: number | null;
  cohortPeerEdge: number | null;
  monthsInGold: number;
  recentStarts: number;
}): string[] {
  const tags: string[] = [];
  if (params.formIndex >= 82 && params.recentStarts >= 2) {
    tags.push("Peak form");
  } else if (params.formIndex >= 72 && params.recentStarts >= 2) {
    tags.push("Top-tier form");
  }
  if (params.momentumDelta != null && params.momentumDelta >= 15) {
    tags.push("Surging momentum");
  } else if (
    (params.momentumDelta != null && params.momentumDelta >= 8) ||
    (params.slopePerHalf != null && params.slopePerHalf >= 10)
  ) {
    tags.push("Rising trend");
  }
  if (
    params.birthYear != null &&
    params.medianBirthYear != null &&
    params.birthYear >= Math.floor(params.medianBirthYear) + 1 &&
    ((params.cohortPeerEdge != null && params.cohortPeerEdge >= 10) ||
      (params.recentAvgPercentile != null && params.recentAvgPercentile >= 48))
  ) {
    tags.push("Young Gold riser");
  }
  if (
    params.recentBestRank != null &&
    params.recentBestRank <= 15 &&
    params.bestEverRank != null &&
    params.recentBestRank === params.bestEverRank &&
    params.priorAvgPercentile != null &&
    params.priorAvgPercentile < 72
  ) {
    tags.push("Breakout PB");
  }
  if (params.monthsInGold <= 12 && (params.recentAvgPercentile ?? 0) >= 45) {
    tags.push("Rookie Gold climber");
  }
  if (tags.length === 0 && params.recentStarts === 0) {
    tags.push("Limited recent starts");
  }
  return tags.slice(0, 3);
}

/**
 * Compute current Form Index, Up & Coming Watchlist score, and next-half
 * projections for active Optimist Gold fleet sailors using their Gold starts.
 */
export function buildGoldFormIndex(input: {
  sailors: GoldFormSailorInput[];
  regattas: GoldFormRegattaInput[];
  results: GoldFormResultInput[];
  scope?: GoldFormScope;
  asOfYmd?: string;
}): GoldFormIndexSummary {
  const scope: GoldFormScope = input.scope ?? "sg_ranking";
  const asOfYmd = toYmd(input.asOfYmd) ?? todayYmdSg();
  const period = periodHalfFromYmd(asOfYmd) ?? currentPeriodFromSgToday();

  const activeGoldSailors = input.sailors.filter((sailor) => {
    const dropYmd = toYmd(sailor.dropDate);
    if (dropYmd && dropYmd <= asOfYmd) return false;
    const rec = toSailorRecord(sailor);
    const resolved = resolveSailorFleet(rec, period, {
      hasOptimistHistoryByPeriodEnd: true,
    });
    return resolved?.active === true && resolved.fleet === "Gold";
  });

  // Official Singapore Gold National Ranking for the current series half
  const currentNationalRankById = new Map<string, number>();
  const currentBest3ById = new Map<string, number>();
  try {
    const rankingRegattas: RegattaRecord[] = input.regattas
      .filter((r) => isGoldRegattaEligible(r, "sg_ranking", asOfYmd))
      .map((r) => ({
        id: r.id,
        name: r.name,
        slug: r.slug || r.id,
        date: toYmd(r.date) || "",
        totalFleetSize: r.totalFleetSize ?? 0,
        division: r.division ?? "Gold",
        boatClass: r.boatClass ?? "Optimist",
        countsForRanking: r.countsForRanking !== false,
      }));
    const rankingResults: RegattaResultRecord[] = input.results.map((r) => ({
      sailorId: r.sailorId,
      regattaId: r.regattaId,
      rank: r.rank,
      nettScore: r.nettScore,
      isDns: r.isDns,
      isOverseasCommitment: r.isOverseasCommitment,
    }));
    const rankedGold = calculateRankings(
      period,
      activeGoldSailors.map(toSailorRecord),
      rankingRegattas,
      rankingResults,
      "Optimist",
    ).filter((x) => x.fleet === "Gold");
    const boardRanks = sharedOverallRanks(rankedGold);
    rankedGold.forEach((row, idx) => {
      const rank = boardRanks[idx];
      if (rank != null) currentNationalRankById.set(row.id, rank);
      if (Number.isFinite(row.overallScore) && row.overallScore < 9000) {
        currentBest3ById.set(row.id, row.overallScore);
      }
    });
  } catch {
    // Graceful fallback if regatta input lacks ranking metadata
  }

  const eligibleRegattas = input.regattas
    .filter((r) => isGoldRegattaEligible(r, scope, asOfYmd))
    .sort((a, b) => (toYmd(a.date) || "").localeCompare(toYmd(b.date) || ""));

  const regattaById = new Map(eligibleRegattas.map((r) => [r.id, r]));
  const referenceYmd =
    eligibleRegattas.length > 0
      ? toYmd(eligibleRegattas[eligibleRegattas.length - 1]!.date) || asOfYmd
      : asOfYmd;
  const recentCutoffYmd = shiftDaysYmd(referenceYmd, -RECENT_WINDOW_DAYS);
  const priorCutoffYmd = shiftDaysYmd(referenceYmd, -PRIOR_WINDOW_DAYS);

  // Measure actual started entries per eligible sheet so fleetSize is accurate
  const sheetStartedStats = new Map<string, { started: number; maxStartedRank: number }>();
  for (const res of input.results) {
    if (!regattaById.has(res.regattaId)) continue;
    if (res.isDns || res.isOverseasCommitment) continue;
    if (!Number.isFinite(res.rank) || res.rank <= 0) continue;
    const prev = sheetStartedStats.get(res.regattaId) ?? { started: 0, maxStartedRank: 0 };
    prev.started += 1;
    if (res.rank > prev.maxStartedRank) prev.maxStartedRank = res.rank;
    sheetStartedStats.set(res.regattaId, prev);
  }

  const effectiveFleetSizeByRegatta = new Map<string, number>();
  for (const reg of eligibleRegattas) {
    const stats = sheetStartedStats.get(reg.id);
    const size = Math.max(
      reg.totalFleetSize ?? 0,
      stats?.started ?? 0,
      stats?.maxStartedRank ?? 0,
      2,
    );
    effectiveFleetSizeByRegatta.set(reg.id, size);
  }

  const recentRegattas = eligibleRegattas.filter((r) => {
    const d = toYmd(r.date) || "";
    return d >= recentCutoffYmd && d <= referenceYmd;
  });
  const recentFleetSizes = recentRegattas
    .map((r) => effectiveFleetSizeByRegatta.get(r.id) ?? 0)
    .filter((n) => n > 1);
  const allFleetSizes = eligibleRegattas
    .map((r) => effectiveFleetSizeByRegatta.get(r.id) ?? 0)
    .filter((n) => n > 1);
  const typicalFleetSize = Math.round(
    medianNumber(recentFleetSizes) ?? medianNumber(allFleetSizes) ?? 80,
  );

  // Also track overseas published Optimist Gold starts separately for context badges
  const overseasGoldIds = new Set(
    input.regattas
      .filter((r) => {
        if (!isGoldRegattaEligible(r, "all_gold", asOfYmd)) return false;
        const geo = String(r.geography ?? "").trim().toUpperCase();
        return Boolean(geo) && geo !== "SGP";
      })
      .map((r) => r.id),
  );
  const overseasStartsBySailor = new Map<string, number>();
  const startedResultsBySailor = new Map<string, GoldStartPoint[]>();

  for (const res of input.results) {
    if (res.isDns || res.isOverseasCommitment) continue;
    if (!Number.isFinite(res.rank) || res.rank <= 0) continue;
    if (overseasGoldIds.has(res.regattaId)) {
      overseasStartsBySailor.set(
        res.sailorId,
        (overseasStartsBySailor.get(res.sailorId) ?? 0) + 1,
      );
    }
    const reg = regattaById.get(res.regattaId);
    if (!reg) continue;
    const date = toYmd(reg.date);
    if (!date) continue;
    const fleetSize = effectiveFleetSizeByRegatta.get(reg.id) ?? Math.max(res.rank, 2);
    const point: GoldStartPoint = {
      regattaId: reg.id,
      regattaName: reg.name,
      date,
      geography: reg.geography ?? null,
      countsForRanking: reg.countsForRanking !== false,
      rank: res.rank,
      fleetSize,
      percentile: percentileFromRank(res.rank, fleetSize),
      nettScore: res.nettScore ?? null,
      isRecentWindow: date >= recentCutoffYmd && date <= referenceYmd,
      isPriorWindow: date >= priorCutoffYmd && date < recentCutoffYmd,
    };
    const list = startedResultsBySailor.get(res.sailorId) ?? [];
    list.push(point);
    startedResultsBySailor.set(res.sailorId, list);
  }

  const birthYears = activeGoldSailors
    .map((s) =>
      s.birthYear != null && Number.isInteger(s.birthYear)
        ? s.birthYear
        : parseBirthYear(s.dob),
    )
    .filter((y): y is number => y != null);
  const medianBirthYear = medianNumber(birthYears);

  // First pass: weighted scores per sailor so we can compute exact birth-year peer baselines
  const draftRows = activeGoldSailors.map((sailor) => {
    const history = (startedResultsBySailor.get(sailor.id) ?? []).sort((a, b) =>
      a.date.localeCompare(b.date),
    );
    const recentPts = history.filter((p) => p.isRecentWindow);
    const priorPts = history.filter((p) => p.isPriorWindow);
    const bYear =
      sailor.birthYear != null && Number.isInteger(sailor.birthYear)
        ? sailor.birthYear
        : parseBirthYear(sailor.dob);
    const goldEntry = toYmd(sailor.goldEntryDate) || "";
    const { weightedPercentile, weightedStdDev } = computeWeightedStats(history, referenceYmd);
    return { sailor, history, recentPts, priorPts, bYear, goldEntry, weightedPercentile, weightedStdDev };
  });

  const cohortBucket = new Map<number, number[]>();
  for (const row of draftRows) {
    if (row.bYear == null || row.history.length === 0) continue;
    const arr = cohortBucket.get(row.bYear) ?? [];
    arr.push(row.weightedPercentile);
    cohortBucket.set(row.bYear, arr);
  }
  const cohortAvgByYear = new Map<number, { avg: number; count: number }>();
  for (const [year, vals] of cohortBucket.entries()) {
    const avg = vals.reduce((a, b) => a + b, 0) / vals.length;
    cohortAvgByYear.set(year, { avg: round1(avg), count: vals.length });
  }

  const entries: GoldSailorFormEntry[] = draftRows.map((row) => {
    const { sailor, history, recentPts, priorPts, bYear, goldEntry, weightedPercentile, weightedStdDev } = row;
    const recentAvgPercentile =
      recentPts.length > 0
        ? round1(recentPts.reduce((s, p) => s + p.percentile, 0) / recentPts.length)
        : null;
    const priorAvgPercentile =
      priorPts.length > 0
        ? round1(priorPts.reduce((s, p) => s + p.percentile, 0) / priorPts.length)
        : null;

    const recentRanks = recentPts.map((p) => p.rank);
    const recentAvgRank =
      recentRanks.length > 0
        ? round1(recentRanks.reduce((a, b) => a + b, 0) / recentRanks.length)
        : null;
    const recentBestRank = recentRanks.length > 0 ? Math.min(...recentRanks) : null;
    const bestEverRank =
      history.length > 0 ? Math.min(...history.map((p) => p.rank)) : null;
    const lastEventDate =
      history.length > 0 ? history[history.length - 1]!.date : null;

    // Top-2 recent ceiling protects against one bad regatta while requiring repeatability
    const recentSortedPct = [...recentPts.map((p) => p.percentile)].sort((a, b) => b - a);
    const recentPeakScore =
      recentSortedPct.length >= 2
        ? (recentSortedPct[0]! + recentSortedPct[1]!) / 2
        : recentSortedPct[0] ?? weightedPercentile;
    const consistencyScore = clamp(0, 100, weightedPercentile - 0.35 * weightedStdDev);
    const activityFactor =
      recentPts.length >= 4
        ? 1
        : recentPts.length === 3
          ? 0.96
          : recentPts.length === 2
            ? 0.9
            : recentPts.length === 1
              ? 0.8
              : 0.62;
    const formIndex =
      history.length === 0
        ? 0
        : round1(
            clamp(
              0,
              100,
              (0.72 * weightedPercentile +
                0.16 * recentPeakScore +
                0.12 * consistencyScore) *
                activityFactor,
            ),
          );

    const rawDelta =
      recentAvgPercentile != null && priorAvgPercentile != null
        ? recentAvgPercentile - priorAvgPercentile
        : null;
    const deltaConfidence =
      Math.min(1, recentPts.length / 3) * Math.min(1, priorPts.length / 3);
    const momentumDelta =
      rawDelta != null ? round1(rawDelta * deltaConfidence) : null;
    const slopePerHalf = weightedPercentileSlopePerHalf(history, referenceYmd);

    const cohortStats = bYear != null ? cohortAvgByYear.get(bYear) : undefined;
    const cohortPeerEdge =
      cohortStats && cohortStats.count >= 2 && history.length > 0
        ? round1(weightedPercentile - cohortStats.avg)
        : null;

    const monthsInGold = monthsBetweenYmd(goldEntry, asOfYmd);
    const yearsYoungerThanMedian =
      bYear != null && medianBirthYear != null
        ? clamp(-2, 3.5, bYear - medianBirthYear)
        : 0;

    // Breakout peak relative to prior baseline median
    const baselineMedianPct =
      medianNumber(priorPts.map((p) => p.percentile)) ??
      medianNumber(history.slice(0, -1).map((p) => p.percentile)) ??
      weightedPercentile;
    const recentBestPct = recentSortedPct[0] ?? weightedPercentile;
    const breakoutLift =
      recentBestPct >= 55 ? Math.max(0, recentBestPct - baselineMedianPct) : 0;

    // Watchlist (Up & Coming) score components (each 0-100)
    const positiveMomentum = Math.max(0, momentumDelta ?? 0);
    const positiveSlope = Math.max(0, slopePerHalf ?? 0);
    const climbSignal = clamp(0, 100, positiveMomentum * 2.1 + positiveSlope * 1.45);
    const ageRunway = clamp(
      0,
      100,
      ((yearsYoungerThanMedian + 1.2) / 4.2) * 52 +
        clamp(0, 48, Math.max(0, cohortPeerEdge ?? 0) * 1.45),
    );
    const competitiveLevel = clamp(
      0,
      100,
      0.62 * (recentAvgPercentile ?? weightedPercentile) +
        0.38 * clamp(0, 100, recentBestPct * 0.65 + breakoutLift * 1.1),
    );
    const rookieSignal =
      monthsInGold <= 12 ? 100 : monthsInGold <= 20 ? 60 : monthsInGold <= 30 ? 25 : 0;
    const levelGate = clamp(0.45, 1, ((recentAvgPercentile ?? weightedPercentile) + 18) / 68);
    const sampleGate =
      history.length >= 4 && recentPts.length >= 2
        ? 1
        : history.length >= 2 && recentPts.length >= 1
          ? 0.72
          : 0.35;

    const rawWatchlist =
      (0.42 * climbSignal +
        0.26 * ageRunway +
        0.22 * competitiveLevel +
        0.1 * rookieSignal) *
      levelGate *
      sampleGate;
    const watchlistIndex = history.length === 0 ? 0 : round1(clamp(0, 100, rawWatchlist));

    // Damped projection to 30 Jun 2027 constrained smoothly under the 100th percentile ceiling
    const anchorPct =
      recentAvgPercentile != null
        ? 0.62 * weightedPercentile + 0.38 * recentAvgPercentile
        : weightedPercentile;
    const trendSignal =
      slopePerHalf != null
        ? slopePerHalf
        : momentumDelta != null
          ? momentumDelta * 0.9
          : 0;
    const horizonHalves = clamp(
      0.5,
      1.5,
      daysBetween(referenceYmd, PROJECTION_TARGET_DATE) / 182.625,
    );
    const ageTailWind = clamp(-1.0, 4.5, yearsYoungerThanMedian * 1.4) * horizonHalves;
    const rawProjectedGain = trendSignal * 0.38 * horizonHalves + ageTailWind;
    const headroomScale =
      rawProjectedGain >= 0
        ? Math.sqrt(clamp(0.02, 1, (100 - anchorPct) / 100))
        : 0.55;
    const projectedPercentile =
      history.length === 0
        ? 0
        : round1(clamp(1, 99.5, anchorPct + rawProjectedGain * headroomScale));

    const currentApproxRank =
      history.length > 0 ? rankFromPercentile(anchorPct, typicalFleetSize) : null;
    const projectedRank =
      history.length > 0 ? rankFromPercentile(projectedPercentile, typicalFleetSize) : null;
    const projectedRankGain =
      currentApproxRank != null && projectedRank != null
        ? currentApproxRank - projectedRank
        : null;

    // Best-3-of-5 national board projection score (rewards demonstrated top-3 ceiling + domestic activity)
    const ceilingLift = Math.max(0, recentPeakScore - anchorPct);
    const projectedCeiling = clamp(0, 99.5, projectedPercentile + ceilingLift * 0.5);
    const activityReliability =
      recentPts.length >= 3 ? 1 : recentPts.length === 2 ? 0.96 : recentPts.length === 1 ? 0.88 : 0.72;
    const projectedJun2027Score =
      history.length === 0
        ? 0
        : round1((0.78 * projectedPercentile + 0.22 * projectedCeiling) * activityReliability);

    const currentNationalRank = currentNationalRankById.get(sailor.id) ?? null;
    const currentBest3of5 = currentBest3ById.get(sailor.id) ?? null;
    const agingOut2027 = bYear != null && bYear <= 2011;

    const confidence: "high" | "medium" | "low" =
      recentPts.length >= 3 && history.length >= 6
        ? "high"
        : recentPts.length >= 2 && history.length >= 3
          ? "medium"
          : "low";

    const tier: GoldFormTier =
      confidence === "low" || history.length < 2
        ? "low_sample"
        : formIndex >= 76 && (momentumDelta ?? 0) < 12
          ? "best_form"
          : watchlistIndex >= 54 ||
              ((momentumDelta ?? 0) >= 12 && (recentAvgPercentile ?? 0) >= 40)
            ? "up_and_coming"
            : formIndex >= 65
              ? "best_form"
              : formIndex >= 45
                ? "steady_core"
                : "developing";

    const tags = buildTags({
      formIndex,
      watchlistIndex,
      momentumDelta,
      slopePerHalf,
      recentBestRank,
      bestEverRank,
      recentAvgPercentile,
      priorAvgPercentile,
      birthYear: bYear,
      medianBirthYear,
      cohortPeerEdge,
      monthsInGold,
      recentStarts: recentPts.length,
    });

    return {
      sailorId: sailor.id,
      name: sailor.name,
      handle: sailor.handle ?? null,
      sailNumber: sailor.sailNumber ?? null,
      club: sailor.club ?? null,
      gender: normGender(sailor.gender),
      birthYear: bYear,
      goldEntryDate: goldEntry,
      monthsInGold,
      nationalSquadStatus: sailor.nationalSquadStatus ?? null,
      totalStarts: history.length,
      recentStarts: recentPts.length,
      priorStarts: priorPts.length,
      overseasStarts: overseasStartsBySailor.get(sailor.id) ?? 0,
      formIndex,
      watchlistIndex,
      weightedPercentile,
      recentAvgPercentile,
      priorAvgPercentile,
      momentumDelta,
      slopePerHalf,
      recentAvgRank,
      recentBestRank,
      bestEverRank,
      lastEventDate,
      cohortPeerEdge,
      projectedPercentile,
      projectedRank,
      projectedRankGain,
      currentNationalRank,
      currentBest3of5,
      agingOut2027,
      projectedJun2027Score,
      projectedNationalRankJun2027: null,
      projectedNationalRankDelta: null,
      tier,
      confidence,
      tags,
      history,
    };
  });

  // Assign projected 30 Jun 2027 National Ranking (1..M) across 2027-eligible sailors
  const eligible2027 = entries
    .filter((e) => !e.agingOut2027)
    .sort(
      (a, b) =>
        b.projectedJun2027Score - a.projectedJun2027Score ||
        b.formIndex - a.formIndex ||
        b.weightedPercentile - a.weightedPercentile,
    );
  eligible2027.forEach((entry, idx) => {
    const projNatRank = idx + 1;
    entry.projectedNationalRankJun2027 = projNatRank;
    entry.projectedNationalRankDelta =
      entry.currentNationalRank != null ? entry.currentNationalRank - projNatRank : null;
  });

  entries.sort((a, b) => b.formIndex - a.formIndex || b.watchlistIndex - a.watchlistIndex);

  const cohortAverages = [...cohortAvgByYear.entries()]
    .map(([birthYear, info]) => ({
      birthYear,
      count: info.count,
      avgWeightedPercentile: info.avg,
    }))
    .sort((a, b) => a.birthYear - b.birthYear);

  return {
    asOfYmd,
    referenceYmd,
    recentCutoffYmd,
    priorCutoffYmd,
    currentPeriodLabel: periodLabel(period),
    projectionTargetDate: PROJECTION_TARGET_DATE,
    scope,
    activeGoldCount: entries.length,
    eligible2027Count: eligible2027.length,
    qualifiedCount: entries.filter((e) => e.confidence !== "low").length,
    regattaCount: eligibleRegattas.length,
    recentRegattaCount: recentRegattas.length,
    typicalFleetSize,
    medianBirthYear,
    cohortAverages,
    entries,
  };
}

/**
 * Compare a saved prediction snapshot (e.g. from Nov 2026) against live
 * actual National Rankings (e.g. on 30 Jun 2027).
 */
export function compareSnapshotWithActuals(
  snapshotEntries: SnapshotEntrySummary[],
  liveEntries: GoldSailorFormEntry[],
): SnapshotComparisonResult {
  const liveById = new Map(liveEntries.map((e) => [e.sailorId, e]));
  const rows: SnapshotComparisonRow[] = [];

  for (const snap of snapshotEntries) {
    if (snap.projectedNationalRankJun2027 == null) continue;
    const live = liveById.get(snap.sailorId);
    const actualRank = live?.currentNationalRank ?? null;
    rows.push({
      sailorId: snap.sailorId,
      name: snap.name,
      birthYear: snap.birthYear,
      predictedRank: snap.projectedNationalRankJun2027,
      baselineRank: snap.currentNationalRank,
      actualRank,
      errorRanks: actualRank != null ? snap.projectedNationalRankJun2027 - actualRank : null,
    });
  }

  rows.sort((a, b) => a.predictedRank - b.predictedRank);

  const evaluated = rows.filter((r) => r.actualRank != null && r.errorRanks != null);
  const maeRanks =
    evaluated.length > 0
      ? round1(
          evaluated.reduce((sum, r) => sum + Math.abs(r.errorRanks!), 0) /
            evaluated.length,
        )
      : null;

  const predTop10 = evaluated.filter((r) => r.predictedRank <= 10);
  const top10Hits = predTop10.filter((r) => (r.actualRank ?? 999) <= 10).length;
  const predTop20 = evaluated.filter((r) => r.predictedRank <= 20);
  const top20Hits = predTop20.filter((r) => (r.actualRank ?? 999) <= 20).length;

  return {
    evaluatedCount: evaluated.length,
    maeRanks,
    top10Hits,
    top10Total: predTop10.length,
    top20Hits,
    top20Total: predTop20.length,
    rows,
  };
}
