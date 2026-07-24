export interface SailorRecord {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  club: string;
  school?: string | null;
  nationality?: string | null;
  avatarUrl?: string | null;
  parentId?: string | null;
  goldEntryDate: string | null;
  silverEntryDate: string | null;
  dropDate: string | null;
  /** Gold | Silver — explicit fleet for the current half (e.g. Jul–Dec 2026) */
  currentFleet?: string | null;
  /** Left Optimist without normal drop; not ranked, may still appear on gold register */
  manuallyDropped?: boolean | null;
  dob?: string | null;
  weight?: number | null;
  bio?: string | null;
  gender?: string | null;
  nationalSquadStatus?: string | null;
  instagram?: string | null;
  facebook?: string | null;
  natSquadStatusJan25?: string | null;
  natSquadStatusJul25?: string | null;
  natSquadStatusJan26?: string | null;
  natSquadStatusJul26?: string | null;
  histRankingJun24?: number | null;
  histRankingDec24?: number | null;
  histRankingJun25?: number | null;
  histRankingDec25?: number | null;
  histRankingJun26?: number | null;
  /** One or more years, e.g. "2023, 2025" (or legacy single number) */
  worlds?: string | number | null;
  european?: string | number | null;
  asian?: string | number | null;
  seaGames?: string | number | null;
}

export interface RegattaRecord {
  id: string;
  name: string;
  slug: string;
  date: string; // ISO format
  totalFleetSize: number;
  division?: string;
  /** Number of races in the event (for race-by-race logs) */
  raceCount?: number | null;
  /** e.g. SG, MY */
  geography?: string | null;
  /** e.g. Optimist, ILCA 6 */
  boatClass?: string | null;
  /** false = personal / overseas logbook only — not in Best 3 of 5 */
  countsForRanking?: boolean | null;
}

export interface RegattaResultRecord {
  sailorId: string;
  regattaId: string;
  rank: number;
  /** May be fractional (e.g. 14.5); optional when only rank/points apply */
  nettScore?: number | null;
  /** Gross total before discards, if provided */
  totalScore?: number | null;
  /** Stored DNS / non-start — score still uses rank (editable) */
  isDns?: boolean | null;
  /**
   * Missed ranking regatta due to SSF overseas commitment;
   * points usually = standing before the trip (editable).
   */
  isOverseasCommitment?: boolean | null;
}

export interface Period {
  year: number;
  half: "Jan-Jun" | "Jul-Dec";
}

export type RegattaScoreSlot = {
  regattaId: string;
  regattaName: string;
  score: number;
  isDNS: boolean;
  isOverseasCommitment?: boolean;
  /** Score borrowed from previous half-year while current period has &lt; 5 events */
  isCarryForward?: boolean;
  periodLabel?: string;
};

export interface RankedSailor extends SailorRecord {
  fleet: "Gold" | "Silver";
  regattaScores: RegattaScoreSlot[];
  bestThreeScores: number[];
  overallScore: number;
  /** Nat squad for the ranking period being viewed */
  periodSquadStatus?: string | null;
}

// Map percentile to badges
export function getPercentileBadge(rank: number, totalFleetSize: number): {
  label: string;
  className: string;
} {
  if (totalFleetSize <= 0) return { label: "N/A", className: "bg-gray-500 text-white" };
  const pct = (rank / totalFleetSize) * 100;
  if (pct <= 25) {
    return { label: "Top 25%", className: "bg-emerald-500/10 text-emerald-500 border border-emerald-500/20" };
  } else if (pct <= 50) {
    return { label: "Top 50%", className: "bg-blue-500/10 text-blue-500 border border-blue-500/20" };
  } else if (pct <= 75) {
    return { label: "Top 75%", className: "bg-amber-500/10 text-amber-500 border border-amber-500/20" };
  } else {
    return { label: "Bottom 25%", className: "bg-rose-500/10 text-rose-500 border border-rose-500/20" };
  }
}

export function periodLabel(period: Period): string {
  return period.half === "Jan-Jun"
    ? `Jan – Jun ${period.year}`
    : `Jul – Dec ${period.year}`;
}

export function previousPeriod(period: Period): Period {
  if (period.half === "Jul-Dec") {
    return { year: period.year, half: "Jan-Jun" };
  }
  return { year: period.year - 1, half: "Jul-Dec" };
}

/** Nat squad is fixed for a whole half-year (Jan–Jun or Jul–Dec). */
export function natSquadFieldForPeriod(
  period: Period
): keyof SailorRecord | null {
  if (period.year === 2025 && period.half === "Jan-Jun") return "natSquadStatusJan25";
  if (period.year === 2025 && period.half === "Jul-Dec") return "natSquadStatusJul25";
  if (period.year === 2026 && period.half === "Jan-Jun") return "natSquadStatusJan26";
  if (period.year === 2026 && period.half === "Jul-Dec") return "natSquadStatusJul26";
  return null;
}

export function squadStatusForPeriod(
  sailor: SailorRecord,
  period: Period
): string | null {
  const field = natSquadFieldForPeriod(period);
  if (field) {
    const v = sailor[field];
    if (v != null && String(v).trim()) return String(v).trim();
  }
  // Fallback for current / unmapped periods
  if (sailor.nationalSquadStatus) return String(sailor.nationalSquadStatus);
  return null;
}

/** Ordered historical nat squad slots for profile / admin display */
export const NAT_SQUAD_HISTORY: {
  key: keyof SailorRecord;
  period: Period;
  label: string;
}[] = [
  { key: "natSquadStatusJan25", period: { year: 2025, half: "Jan-Jun" }, label: "Jan – Jun 2025" },
  { key: "natSquadStatusJul25", period: { year: 2025, half: "Jul-Dec" }, label: "Jul – Dec 2025" },
  { key: "natSquadStatusJan26", period: { year: 2026, half: "Jan-Jun" }, label: "Jan – Jun 2026" },
  { key: "natSquadStatusJul26", period: { year: 2026, half: "Jul-Dec" }, label: "Jul – Dec 2026" },
];

export function periodBounds(period: Period): { start: string; end: string } {
  if (period.half === "Jan-Jun") {
    return { start: `${period.year}-01-01`, end: `${period.year}-06-30` };
  }
  return { start: `${period.year}-07-01`, end: `${period.year}-12-31` };
}

/** Up to 5 ranking events for a fleet in a half-year (oldest → newest = R1…R5). */
export function rankingRegattasInPeriod(
  fleet: "Gold" | "Silver",
  period: Period,
  allRegattas: RegattaRecord[]
): RegattaRecord[] {
  const { start, end } = periodBounds(period);
  const pStart = new Date(start).getTime();
  const pEnd = new Date(end).getTime();

  return allRegattas
    .filter((r) => {
      // Personal / overseas logbook events never count for series ranking
      if (r.countsForRanking === false) return false;
      const t = new Date(r.date).getTime();
      if (t < pStart || t > pEnd) return false;
      const div = r.division || "Gold";
      if (fleet === "Gold") return div === "Gold" || div === "Both";
      return div === "Silver" || div === "Both";
    })
    .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
    .slice(0, 5)
    .reverse();
}

/**
 * Scoring window for a fleet/period:
 * - Prefer up to 5 events in the period
 * - If fewer than 5, pad with the most recent events from the previous period
 *   (e.g. 1 current + last 4 of prior half = Best 3 of 5 window)
 */
export function scoringRegattasForFleet(
  fleet: "Gold" | "Silver",
  period: Period,
  allRegattas: RegattaRecord[]
): { regatta: RegattaRecord; isCarryForward: boolean; periodLabel: string }[] {
  const current = rankingRegattasInPeriod(fleet, period, allRegattas);
  const need = Math.max(0, 5 - current.length);
  let carry: RegattaRecord[] = [];
  if (need > 0) {
    const prev = previousPeriod(period);
    const prevEvents = rankingRegattasInPeriod(fleet, prev, allRegattas);
    // Most recent N from previous period
    carry = prevEvents.slice(-need);
  }

  const curLabel = periodLabel(period);
  const prevLabel = periodLabel(previousPeriod(period));

  return [
    ...carry.map((regatta) => ({
      regatta,
      isCarryForward: true as const,
      periodLabel: prevLabel,
    })),
    ...current.map((regatta) => ({
      regatta,
      isCarryForward: false as const,
      periodLabel: curLabel,
    })),
  ];
}

/**
 * Period ranking membership.
 *
 * 1) Manually dropped (no drop date) → never ranked
 * 2) Guest (not In SG Fleet) → never ranked
 * 3) Drop date: out of Gold/Silver from that day (drop in half → out for that half)
 * 4) In SG Fleet + goldEntryDate ≤ period end → Gold (from that date until drop)
 * 5) Else In SG Fleet → Silver
 *
 * `currentFleet` stores Guest | Series only (legacy Gold/Silver = Series).
 * It does NOT pick Gold vs Silver for a half-year.
 */
export function resolveSailorFleet(
  sailor: SailorRecord,
  period: Period
): { active: boolean; fleet: "Gold" | "Silver" } | null {
  if (sailor.manuallyDropped) {
    return null;
  }

  const cf = String(sailor.currentFleet || "")
    .trim()
    .toLowerCase();
  const isGuest = cf === "guest";
  const isSeries =
    cf === "series" ||
    cf === "gold" ||
    cf === "silver" ||
    cf === "in sg fleet" ||
    cf === "member" ||
    // Legacy rows with entry dates but no flag
    (!cf && Boolean(sailor.goldEntryDate || sailor.silverEntryDate));
  if (isGuest || !isSeries) {
    return null;
  }

  const pStartStr =
    period.half === "Jan-Jun"
      ? `${period.year}-01-01`
      : `${period.year}-07-01`;
  const pEndStr =
    period.half === "Jan-Jun"
      ? `${period.year}-06-30`
      : `${period.year}-12-31`;

  const pStart = new Date(pStartStr).getTime();
  const pEnd = new Date(pEndStr).getTime();

  const goldDate = sailor.goldEntryDate
    ? new Date(sailor.goldEntryDate).getTime()
    : null;
  const dropDate = sailor.dropDate
    ? new Date(sailor.dropDate).getTime()
    : null;

  // Drop: exclusive from the drop date onward (inclusive of drop day)
  if (dropDate !== null) {
    if (dropDate < pStart) return null;
    if (dropDate <= pEnd) return null;
  }

  // Gold from gold entry date until drop; otherwise Silver while In SG Fleet
  const isGold = goldDate !== null && goldDate <= pEnd;

  return {
    active: true,
    fleet: isGold ? "Gold" : "Silver",
  };
}

function scoreForResult(
  sailorId: string,
  regatta: RegattaRecord,
  results: RegattaResultRecord[]
): Pick<
  RegattaScoreSlot,
  "score" | "isDNS" | "isOverseasCommitment"
> {
  const result = results.find(
    (res) => res.sailorId === sailorId && res.regattaId === regatta.id
  );
  if (result) {
    return {
      score: result.rank,
      isDNS: Boolean(result.isDns) && !result.isOverseasCommitment,
      isOverseasCommitment: Boolean(result.isOverseasCommitment),
    };
  }
  return {
    score: regatta.totalFleetSize + 1,
    isDNS: true,
    isOverseasCommitment: false,
  };
}

/** Best 3 (lowest) of available scores; pad with 9999 if fewer than 3. */
export function bestThreeOf(scores: number[]): {
  bestThreeScores: number[];
  overallScore: number;
} {
  const sorted = [...scores]
    .filter((n) => Number.isFinite(n))
    .sort((a, b) => a - b);
  const bestThreeScores = sorted.slice(0, 3);
  while (bestThreeScores.length < 3) {
    bestThreeScores.push(9999);
  }
  const overallScore = bestThreeScores.reduce((sum, s) => sum + s, 0);
  return { bestThreeScores, overallScore };
}

/**
 * Sort order for the ranking board:
 * 1) Lower Best 3 of 5 (overallScore) wins
 * 2) If tied, compare all regatta ranks ascending (best first):
 *    e.g. A: 1,3,5,7,18 vs B: 2,2,5,6,9 — both Best3 = 9, A ranks higher
 *    because 1 beats 2; if still tied continue 3 vs 2, etc.
 * 3) Alphabetical name
 */
export function compareRankedSailors(
  a: Pick<RankedSailor, "overallScore" | "regattaScores" | "name">,
  b: Pick<RankedSailor, "overallScore" | "regattaScores" | "name">,
  scoreFilter?: (rs: RegattaScoreSlot) => boolean
): number {
  if (a.overallScore !== b.overallScore) {
    return a.overallScore - b.overallScore;
  }

  const ranksOf = (s: typeof a) =>
    (s.regattaScores || [])
      .filter((rs) => (scoreFilter ? scoreFilter(rs) : true))
      .map((rs) => rs.score)
      .filter((n) => Number.isFinite(n))
      .sort((x, y) => x - y);

  const sortedA = ranksOf(a);
  const sortedB = ranksOf(b);

  const n = Math.max(sortedA.length, sortedB.length);
  for (let i = 0; i < n; i++) {
    const scoreA = sortedA[i] ?? 9999;
    const scoreB = sortedB[i] ?? 9999;
    if (scoreA !== scoreB) return scoreA - scoreB;
  }

  return a.name.toLowerCase().localeCompare(b.name.toLowerCase());
}

/**
 * Recompute ranking board after excluding some regatta IDs (client “what-if”).
 * Order is re-sorted by new overall score + regatta-rank tie-breakers.
 */
type RankedWithTiebreak = RankedSailor & {
  _tiebreakScores?: RegattaScoreSlot[];
};

export function reRankWithExcluded(
  ranked: RankedSailor[],
  excludedRegattaIds: Set<string>
): RankedSailor[] {
  const next: RankedWithTiebreak[] = ranked.map((s) => {
    const kept = (s.regattaScores || []).filter(
      (rs) => !excludedRegattaIds.has(rs.regattaId)
    );
    const { bestThreeScores, overallScore } = bestThreeOf(
      kept.map((rs) => rs.score)
    );
    // Keep full regattaScores for display; only overallScore uses exclusions
    return { ...s, bestThreeScores, overallScore, _tiebreakScores: kept };
  });

  next.sort((a, b) =>
    compareRankedSailors(
      {
        overallScore: a.overallScore,
        name: a.name,
        regattaScores: a._tiebreakScores || a.regattaScores,
      },
      {
        overallScore: b.overallScore,
        name: b.name,
        regattaScores: b._tiebreakScores || b.regattaScores,
      }
    )
  );

  return next.map(({ _tiebreakScores: _tb, ...rest }) => rest as RankedSailor);
}

// Core Ranking Engine
export function calculateRankings(
  period: Period,
  sailors: SailorRecord[],
  regattas: RegattaRecord[],
  results: RegattaResultRecord[]
): RankedSailor[] {
  // Resolve active sailors for the period and partition them
  const activeSailors: (SailorRecord & { fleet: "Gold" | "Silver" })[] = [];
  for (const s of sailors) {
    const res = resolveSailorFleet(s, period);
    if (res && res.active) {
      activeSailors.push({ ...s, fleet: res.fleet });
    }
  }

  // Precompute scoring windows per fleet (carry-forward shared within fleet)
  const goldSlots = scoringRegattasForFleet("Gold", period, regattas);
  const silverSlots = scoringRegattasForFleet("Silver", period, regattas);

  const rankedSailors: RankedSailor[] = activeSailors.map((sailor) => {
    const slots = sailor.fleet === "Gold" ? goldSlots : silverSlots;

    const regattaScores: RegattaScoreSlot[] = slots.map((slot) => {
      const scored = scoreForResult(sailor.id, slot.regatta, results);
      return {
        regattaId: slot.regatta.id,
        regattaName: slot.regatta.name,
        score: scored.score,
        isDNS: scored.isDNS,
        isOverseasCommitment: scored.isOverseasCommitment,
        isCarryForward: slot.isCarryForward,
        periodLabel: slot.periodLabel,
      };
    });

    const { bestThreeScores, overallScore } = bestThreeOf(
      regattaScores.map((rs) => rs.score)
    );

    return {
      ...sailor,
      regattaScores,
      bestThreeScores,
      overallScore,
      periodSquadStatus: squadStatusForPeriod(sailor, period),
    };
  });

  // Best 3 of 5, then best-to-worst regatta ranks, then name
  rankedSailors.sort((a, b) => compareRankedSailors(a, b));

  return rankedSailors;
}
