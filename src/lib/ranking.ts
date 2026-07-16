export interface SailorRecord {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  club: string;
  goldEntryDate: string | null;
  silverEntryDate: string | null;
  dropDate: string | null;
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
  worlds?: number | null;
  european?: number | null;
  asian?: number | null;
  seaGames?: number | null;
}

export interface RegattaRecord {
  id: string;
  name: string;
  slug: string;
  date: string; // ISO format
  totalFleetSize: number;
  division?: string;
}

export interface RegattaResultRecord {
  sailorId: string;
  regattaId: string;
  rank: number;
  nettScore: number;
}

export interface Period {
  year: number;
  half: "Jan-Jun" | "Jul-Dec";
}

export interface RankedSailor extends SailorRecord {
  fleet: "Gold" | "Silver";
  regattaScores: {
    regattaId: string;
    regattaName: string;
    score: number;
    isDNS: boolean;
  }[];
  bestThreeScores: number[];
  overallScore: number;
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

// Check if a sailor is active in a period and resolve their fleet
export function resolveSailorFleet(
  sailor: SailorRecord,
  period: Period
): { active: boolean; fleet: "Gold" | "Silver" } | null {
  const pStartStr = period.half === "Jan-Jun" ? `${period.year}-01-01` : `${period.year}-07-01`;
  const pEndStr = period.half === "Jan-Jun" ? `${period.year}-06-30` : `${period.year}-12-31`;

  const pStart = new Date(pStartStr).getTime();
  const pEnd = new Date(pEndStr).getTime();

  const goldDate = sailor.goldEntryDate ? new Date(sailor.goldEntryDate).getTime() : null;
  const silverDate = sailor.silverEntryDate ? new Date(sailor.silverEntryDate).getTime() : null;
  const dropDate = sailor.dropDate ? new Date(sailor.dropDate).getTime() : null;

  // 1. If period is prior to both entry dates, they do not appear
  const earliestEntry = Math.min(
    goldDate ?? Infinity,
    silverDate ?? Infinity
  );

  if (earliestEntry === Infinity || earliestEntry > pEnd) {
    return null;
  }

  // 2. Drop: exclusive from the drop date onward (inclusive of drop day)
  // If drop is on or before period end and on or before "now in period", exclude when
  // drop is before period start OR drop falls within the period (left series that half).
  if (dropDate !== null) {
    if (dropDate < pStart) return null;
    // Drop during this half-year → not active for the full period board
    if (dropDate <= pEnd) return null;
  }

  // 3. Gold is sticky once gold entry is on or before period end
  const isGold = goldDate !== null && goldDate <= pEnd;
  // Silver only if not gold and silver entry is on or before period end
  if (!isGold) {
    if (silverDate === null || silverDate > pEnd) return null;
  }

  return {
    active: true,
    fleet: isGold ? "Gold" : "Silver",
  };
}

// Core Ranking Engine
export function calculateRankings(
  period: Period,
  sailors: SailorRecord[],
  regattas: RegattaRecord[],
  results: RegattaResultRecord[]
): RankedSailor[] {
  const pEndStr = period.half === "Jan-Jun" ? `${period.year}-06-30` : `${period.year}-12-31`;
  const pEnd = new Date(pEndStr).getTime();

  // 2. Resolve active sailors for the period and partition them
  const activeSailors: (SailorRecord & { fleet: "Gold" | "Silver" })[] = [];
  for (const s of sailors) {
    const res = resolveSailorFleet(s, period);
    if (res && res.active) {
      activeSailors.push({ ...s, fleet: res.fleet });
    }
  }

  // 3. Compute scores for each sailor
  const rankedSailors: RankedSailor[] = activeSailors.map((sailor) => {
    // 1. Get the 5 most recent regattas that occurred on or before period end and match sailor's fleet
    const sailorRegattas = regattas
      .filter((r) => {
        const occurred = new Date(r.date).getTime() <= pEnd;
        if (!occurred) return false;
        
        const div = r.division || "Gold";
        if (sailor.fleet === "Gold") {
          return div === "Gold" || div === "Both";
        } else {
          return div === "Silver" || div === "Both";
        }
      })
      .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
      .slice(0, 5);

    const regattaScores = sailorRegattas.map((regatta) => {
      const result = results.find(
        (res) => res.sailorId === sailor.id && res.regattaId === regatta.id
      );

      if (result) {
        return {
          regattaId: regatta.id,
          regattaName: regatta.name,
          score: result.rank, // using rank as scoring basis
          isDNS: false,
        };
      } else {
        // DNS Score: total fleet size + 1
        return {
          regattaId: regatta.id,
          regattaName: regatta.name,
          score: regatta.totalFleetSize + 1,
          isDNS: true,
        };
      }
    });

    // Best 3 of 5
    const sortedScores = [...regattaScores]
      .map((rs) => rs.score)
      .sort((a, b) => a - b);
    
    // Take top 3 (lowest is best)
    const bestThreeScores = sortedScores.slice(0, 3);
    
    // Pad to 3 scores with large penalty if we don't have enough regattas
    while (bestThreeScores.length < 3) {
      bestThreeScores.push(9999);
    }

    const overallScore = bestThreeScores.reduce((sum, score) => sum + score, 0);

    return {
      ...sailor,
      regattaScores,
      bestThreeScores,
      overallScore,
    };
  });

  // 4. Sort and Tie-Breaking
  // "Tie-Breaking: If overall scores are tied, break the tie by sorting the sailors' individual regatta scores in ascending order and comparing them head-to-head (lowest rank wins). If still tied, fall back to alphabetical order."
  rankedSailors.sort((a, b) => {
    if (a.overallScore !== b.overallScore) {
      return a.overallScore - b.overallScore;
    }

    // Sort all individual regatta scores in ascending order
    const sortedA = [...a.regattaScores].map((rs) => rs.score).sort((x, y) => x - y);
    const sortedB = [...b.regattaScores].map((rs) => rs.score).sort((x, y) => x - y);

    for (let i = 0; i < Math.max(sortedA.length, sortedB.length); i++) {
      const scoreA = sortedA[i] ?? 9999;
      const scoreB = sortedB[i] ?? 9999;
      if (scoreA !== scoreB) {
        return scoreA - scoreB;
      }
    }

    // Alphabetical fallback
    const nameA = a.name.toLowerCase();
    const nameB = b.name.toLowerCase();
    return nameA.localeCompare(nameB);
  });

  return rankedSailors;
}
