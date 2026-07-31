/**
 * Derived stats for the public sailor profile (new gold vs established gold).
 */

export type ProfileResult = {
  id?: string;
  resultId?: string;
  regattaId?: string;
  regattaName?: string;
  regattaDate?: string | null;
  regattaSlug?: string;
  rank?: number | null;
  nettScore?: number | null;
  totalScore?: number | null;
  isDns?: boolean;
  isDNS?: boolean;
  isOverseasCommitment?: boolean;
  division?: string | null;
  fleetSize?: number | null;
  totalFleetSize?: number | null;
  geography?: string | null;
  raceCount?: number | null;
  countsForRanking?: boolean;
};

export type ProfileObservation = {
  id?: string;
  regattaId?: string | null;
  raceNumber?: number | null;
  position?: number | null;
  note?: string | null;
  wind?: string | null;
  isPrivate?: boolean;
  regattaDate?: string | null;
};

function ymd(v: unknown): string {
  return String(v || "").slice(0, 10);
}

function isValidYmd(d: string): boolean {
  return /^\d{4}-\d{2}-\d{2}$/.test(d);
}

function parseRank(r: ProfileResult): number | null {
  const dns = Boolean(r.isDns || r.isDNS);
  if (dns || r.rank == null || !Number.isFinite(Number(r.rank))) return null;
  return Number(r.rank);
}

/** Gold vs Silver for a result (division first, then gold entry date). */
export function fleetLabelForResult(
  r: ProfileResult,
  goldEntryDate?: string | null
): "Gold" | "Silver" | "—" {
  const div = String(r.division || "").toLowerCase();
  if (div.includes("gold")) return "Gold";
  if (div.includes("silver")) return "Silver";
  const d = ymd(r.regattaDate);
  const gold = ymd(goldEntryDate);
  if (isValidYmd(gold) && isValidYmd(d) && d >= gold) return "Gold";
  if (isValidYmd(d) || div) return "Silver";
  return "—";
}

function monthsBetween(fromYmd: string, toYmd: string): number {
  if (!isValidYmd(fromYmd) || !isValidYmd(toYmd)) return 0;
  const [fy, fm] = fromYmd.split("-").map(Number);
  const [ty, tm] = toYmd.split("-").map(Number);
  return Math.max(0, (ty - fy) * 12 + (tm - fm));
}

function formatMonthsInGold(months: number): string {
  if (months < 1) return "<1 mo";
  if (months === 1) return "1 mo";
  if (months < 12) return `${months} mo`;
  const y = Math.floor(months / 12);
  const m = months % 12;
  if (m === 0) return y === 1 ? "1 yr" : `${y} yr`;
  return `${y}y ${m}mo`;
}

export function ordinal(n: number): string {
  const v = n % 100;
  if (v >= 11 && v <= 13) return `${n}th`;
  switch (n % 10) {
    case 1:
      return `${n}st`;
    case 2:
      return `${n}nd`;
    case 3:
      return `${n}rd`;
    default:
      return `${n}th`;
  }
}

export type TrendPoint = {
  date: string;
  rank: number;
  name: string;
  fleet: "Gold" | "Silver" | "—";
};

export type ResultTag = {
  label: string;
  className: string;
};

export type MedalTally = {
  gold: number;
  silver: number;
  bronze: number;
  top10: number;
  /** True when any of 1st / 2nd / 3rd / top-10 exists */
  show: boolean;
};

export type ProfileMode = "new_gold" | "established_gold" | "other";

export type ProfileAnalytics = {
  mode: ProfileMode;
  /** Total regattas logged (all fleets, local + overseas) */
  regattaCount: number;
  monthsInGold: number | null;
  timeInGoldLabel: string | null;
  goldEntryDate: string | null;
  isGoldFleet: boolean;
  /** Best finish overall among ranked results in scope */
  bestFinish: number | null;
  bestFinishLabel: string;
  bestGoldFinish: number | null;
  bestGoldLabel: string;
  bestSilverFinish: number | null;
  bestSilverLabel: string;
  top10Count: number;
  avgFinish: number | null;
  avgFinishLabel: string;
  podiumCount: number;
  medals: MedalTally;
  /** Last 10 points for the chart (mode-filtered) */
  trend: TrendPoint[];
  /**
   * Mode-filtered results newest first (silver excluded for established gold).
   * UI shows first 8 by default; “View all” reveals the full list.
   */
  listResults: ProfileResult[];
  /** @deprecated alias — first 8 of listResults */
  displayResults: ProfileResult[];
  /** All results newest first (unfiltered) */
  sortedResults: ProfileResult[];
};

export function buildResultTags(
  r: ProfileResult,
  goldEntryDate?: string | null
): ResultTag[] {
  const tags: ResultTag[] = [];
  const rank = parseRank(r);
  const dns = Boolean(r.isDns || r.isDNS);
  const overseas = Boolean(r.isOverseasCommitment);
  const nonRanking = r.countsForRanking === false;
  const fleet = fleetLabelForResult(r, goldEntryDate);
  const geo = String(r.geography || "").toUpperCase();
  const isOverseasGeo =
    overseas ||
    (geo &&
      geo !== "SG" &&
      geo !== "SGP" &&
      geo !== "SIN" &&
      geo !== "SINGAPORE");

  if (dns) {
    tags.push({
      label: "DNS",
      className: "bg-rose-500/15 text-rose-300 border border-rose-500/25",
    });
  } else if (rank != null && rank <= 10) {
    tags.push({
      label: "Top 10",
      className: "bg-emerald-500/15 text-emerald-400 border border-emerald-500/25",
    });
  }

  if (fleet === "Gold") {
    tags.push({
      label: "Gold fleet",
      className: "bg-amber-500/15 text-amber-400 border border-amber-500/25",
    });
  } else if (fleet === "Silver") {
    tags.push({
      label: "Silver fleet",
      className: "bg-neutral-500/15 text-neutral-300 border border-neutral-500/25",
    });
  }

  if (nonRanking) {
    tags.push({
      label: "Non-ranking",
      className: "bg-sky-500/10 text-sky-300 border border-sky-500/25",
    });
  }
  if (isOverseasGeo) {
    tags.push({
      label: "Overseas",
      className: "bg-violet-500/10 text-violet-300 border border-violet-500/25",
    });
  }

  return tags;
}

export function buildProfileAnalytics(
  sailor: {
    goldEntryDate?: string | null;
    silverEntryDate?: string | null;
    dropDate?: string | null;
    currentFleet?: string | null;
  },
  results: ProfileResult[],
  _observations: ProfileObservation[] = [],
  _seriesStanding?: {
    overallRank: number;
    fleetSize: number;
    fleet: string;
  } | null
): ProfileAnalytics {
  const today = new Date().toLocaleDateString("en-CA", {
    timeZone: "Asia/Singapore",
  });
  const goldEntry = ymd(sailor.goldEntryDate) || null;
  const goldOk = goldEntry && isValidYmd(goldEntry) ? goldEntry : null;
  const monthsInGold = goldOk ? monthsBetween(goldOk, today) : null;
  const isGoldFleet = Boolean(goldOk);
  /** Established = in gold ≥ 12 months */
  const mode: ProfileMode =
    goldOk && monthsInGold != null && monthsInGold >= 12
      ? "established_gold"
      : goldOk
        ? "new_gold"
        : "other";

  const byDateDesc = [...results].sort((a, b) =>
    ymd(b.regattaDate).localeCompare(ymd(a.regattaDate))
  );

  const rankedAll = results
    .map((r) => ({
      r,
      rank: parseRank(r),
      date: ymd(r.regattaDate),
      fleet: fleetLabelForResult(r, goldOk),
    }))
    .filter((x) => x.rank != null) as {
    r: ProfileResult;
    rank: number;
    date: string;
    fleet: "Gold" | "Silver" | "—";
  }[];

  const chronoAll = [...rankedAll].sort((a, b) => a.date.localeCompare(b.date));
  const goldRanked = rankedAll.filter((x) => x.fleet === "Gold");
  const silverRanked = rankedAll.filter((x) => x.fleet === "Silver");

  const bestOf = (list: typeof rankedAll) =>
    list.reduce<{ rank: number; r: ProfileResult } | null>((acc, cur) => {
      if (!acc || cur.rank < acc.rank) return { rank: cur.rank, r: cur.r };
      return acc;
    }, null);

  const bestGold = bestOf(goldRanked);
  const bestSilver = bestOf(silverRanked);
  const bestAll = bestOf(rankedAll);

  // Scope for avg / top10 / medals / best-for-stats
  const statsPool =
    mode === "established_gold" ? goldRanked : rankedAll;

  const top10Count = statsPool.filter((x) => x.rank <= 10).length;
  const podiumCount = statsPool.filter((x) => x.rank <= 3).length;
  const avgFinish =
    statsPool.length > 0
      ? statsPool.reduce((s, x) => s + x.rank, 0) / statsPool.length
      : null;

  const medals: MedalTally = {
    gold: statsPool.filter((x) => x.rank === 1).length,
    silver: statsPool.filter((x) => x.rank === 2).length,
    bronze: statsPool.filter((x) => x.rank === 3).length,
    top10: top10Count,
    show: statsPool.some((x) => x.rank <= 10),
  };

  // Trend: last 10 (chrono order for chart = oldest→newest among those 10)
  let trendSource = chronoAll;
  if (mode === "established_gold") {
    trendSource = chronoAll.filter((x) => x.fleet === "Gold");
  }
  // other / new_gold: include silver + gold
  const trendSlice = trendSource.slice(-10);
  const trend: TrendPoint[] = trendSlice.map((c) => ({
    date: c.date,
    rank: c.rank,
    name: c.r.regattaName || "Regatta",
    fleet: c.fleet,
  }));

  // Display results: last 8 newest first, filtered by mode
  let listSource = byDateDesc;
  if (mode === "established_gold") {
    listSource = byDateDesc.filter(
      (r) => fleetLabelForResult(r, goldOk) === "Gold"
    );
  }
  const listResults = listSource;
  const displayResults = listResults.slice(0, 8);

  const bestForMode =
    mode === "established_gold" ? bestGold : bestAll;

  return {
    mode,
    regattaCount: results.length,
    monthsInGold,
    timeInGoldLabel:
      monthsInGold != null ? formatMonthsInGold(monthsInGold) : null,
    goldEntryDate: goldOk,
    isGoldFleet,
    bestFinish: bestForMode?.rank ?? null,
    bestFinishLabel: bestForMode ? ordinal(bestForMode.rank) : "—",
    bestGoldFinish: bestGold?.rank ?? null,
    bestGoldLabel: bestGold ? ordinal(bestGold.rank) : "—",
    bestSilverFinish: bestSilver?.rank ?? null,
    bestSilverLabel: bestSilver ? ordinal(bestSilver.rank) : "—",
    top10Count,
    avgFinish,
    avgFinishLabel:
      avgFinish != null
        ? (Math.round(avgFinish * 10) / 10).toFixed(1)
        : "—",
    podiumCount,
    medals,
    trend,
    listResults,
    displayResults,
    sortedResults: byDateDesc,
  };
}

export function placeColorClass(rank: number | null | undefined): string {
  if (rank == null) return "text-neutral-500";
  if (rank <= 3) return "text-emerald-400";
  if (rank <= 10) return "text-emerald-400/90";
  if (rank <= 20) return "text-neutral-200";
  return "text-neutral-400";
}

export { monthYearLabel };

function monthYearLabel(d: string): string {
  if (!isValidYmd(d)) return d || "—";
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  return `${months[Number(d.slice(5, 7)) - 1]} ${d.slice(0, 4)}`;
}
