/**
 * Sailor Prizes & Awards Linking System
 *
 * Discovers and links official Notice of Race (NoR) awards, podium finishes,
 * and trophies won by a sailor across all regattas to their personal profile.
 */

import {
  ALL_REGATTA_PRIZE_SCHEDULES,
  prizeNameKey,
} from "./regattaPrizes";

export interface SailorPrizeAward {
  id: string;
  regattaName: string;
  regattaSlug: string;
  regattaDate?: string;
  datesText?: string;
  year: number;
  boatClass: string;
  fleetName: string;
  categoryName: string;
  prizeTitle: string; // e.g. "1st (National Champion)", "1st Female", "2nd Place", "1st (11–12)"
  rank: number;
  medal: "gold" | "silver" | "bronze" | "other";
  notes?: string;
  sailNumber?: string;
  schoolName?: string;
  club?: string;
  isOfficialNoR: boolean;
}

export interface SailorMedalCounts {
  gold: number;
  silver: number;
  bronze: number;
  total: number;
}

function wordsOf(name: string): string[] {
  return prizeNameKey(name)
    .split(/\s+/)
    .filter((w) => w.length > 1);
}

/**
 * Checks whether a sailor name matches an award winner entry.
 * Supports exact match, token subset (e.g. "Keira Carlyle" matching "Keira Marie Carlyle"),
 * and double-handed pair slash separation (e.g. "Cheryl Yong / Febe Wong").
 */
export function matchesSailorName(winnerName: string, sailorName: string): boolean {
  if (!winnerName || !sailorName) return false;

  const wKey = prizeNameKey(winnerName);
  const sKey = prizeNameKey(sailorName);
  if (wKey === sKey) return true;

  // Double-handed team handling (e.g. "Cheryl Yong / Febe Wong")
  if (winnerName.includes("/")) {
    const parts = winnerName.split("/").map((p) => prizeNameKey(p.trim()));
    if (parts.some((p) => p === sKey || matchesSailorName(p, sailorName))) {
      return true;
    }
  }

  // Token subset matching
  const wWords = wordsOf(winnerName);
  const sWords = wordsOf(sailorName);

  if (wWords.length >= 2 && sWords.length >= 2) {
    // Both share same first name and last name
    const sameFirst = wWords[0] === sWords[0];
    const sameLast = wWords[wWords.length - 1] === sWords[sWords.length - 1];
    if (sameFirst && sameLast) return true;

    // One is a strict subset of the other with at least 2 tokens
    const isSubset =
      sWords.every((w) => wWords.includes(w)) ||
      wWords.every((w) => sWords.includes(w));
    if (isSubset) return true;
  }

  return false;
}

/**
 * Derives medal tier from numerical rank or prize title.
 */
export function deriveMedalTier(
  rank: number,
  prizeTitle?: string
): "gold" | "silver" | "bronze" | "other" {
  const title = (prizeTitle || "").toLowerCase();
  if (title.includes("1st") || title.includes("champion") || title.includes("gold") || rank === 1) {
    return "gold";
  }
  if (title.includes("2nd") || title.includes("silver") || rank === 2) {
    return "silver";
  }
  if (title.includes("3rd") || title.includes("bronze") || rank === 3) {
    return "bronze";
  }
  return "other";
}

/**
 * Retrieves all official NoR prizes and regatta podium awards won by a sailor.
 */
export function getSailorPrizes(
  sailor: {
    id?: string | null;
    name: string;
    handle?: string | null;
    sailNumber?: string | null;
    sailNumberIlca4?: string | null;
    club?: string | null;
    school?: string | null;
  },
  results: {
    id?: string;
    regattaId?: string;
    regattaSlug?: string;
    regattaName?: string;
    regattaDate?: string;
    boatClass?: string;
    division?: string;
    fleetSize?: number;
    rank?: number | null;
    nettScore?: number | null;
    sailNumber?: string | null;
    countsForRanking?: boolean;
    isDns?: boolean;
  }[] = []
): SailorPrizeAward[] {
  if (!sailor || !sailor.name) return [];

  const awards: SailorPrizeAward[] = [];
  const seenKeys = new Set<string>();

  const sailorSailNumbers = new Set(
    [sailor.sailNumber, sailor.sailNumberIlca4, ...results.map((r) => r.sailNumber)]
      .filter(Boolean)
      .map((s) => String(s).trim().replace(/\s+/g, ""))
  );

  // 1. Search in Official NoR Prize Schedules
  for (const schedule of ALL_REGATTA_PRIZE_SCHEDULES) {
    for (const fleet of schedule.fleets) {
      for (const cat of fleet.categories) {
        // Skip purely internal school divisions per user rule
        const catLower = cat.categoryName.toLowerCase();
        if (
          catLower.includes("primary school") ||
          catLower.includes("secondary school") ||
          catLower.includes("junior college") ||
          catLower.includes("polytechnic")
        ) {
          continue;
        }

        for (const w of cat.winners) {
          const wSail = String(w.sailNumber || "").trim().replace(/\s+/g, "");
          const nameMatches = matchesSailorName(w.sailorName, sailor.name);
          const sailMatches = Boolean(wSail && sailorSailNumbers.has(wSail));

          if (nameMatches || (sailMatches && wordsOf(w.sailorName)[0] === wordsOf(sailor.name)[0])) {
            const medal = deriveMedalTier(w.rank, w.prizeTitle);
            const awardId = `${schedule.regattaSlug}-${fleet.boatClass}-${cat.categoryName}-${w.rank}`;

            if (!seenKeys.has(awardId)) {
              seenKeys.add(awardId);
              awards.push({
                id: awardId,
                regattaName: schedule.regattaName,
                regattaSlug: schedule.regattaSlug,
                datesText: schedule.datesText,
                year: schedule.year,
                boatClass: fleet.boatClass,
                fleetName: fleet.fleetName,
                categoryName: cat.categoryName,
                prizeTitle: w.prizeTitle || `${w.rank}${w.rank === 1 ? "st" : w.rank === 2 ? "nd" : w.rank === 3 ? "rd" : "th"} Place`,
                rank: w.rank,
                medal,
                notes: w.notes,
                sailNumber: w.sailNumber || sailor.sailNumber || undefined,
                schoolName: w.schoolName || sailor.school || undefined,
                club: w.club || sailor.club || undefined,
                isOfficialNoR: true,
              });
            }
          }
        }
      }
    }
  }

  // 2. Synthesize awards for podium finishes in regattas not already covered in NoR schedules
  for (const res of results) {
    if (
      res.rank != null &&
      res.rank >= 1 &&
      res.rank <= 3 &&
      !res.isDns &&
      res.countsForRanking !== false
    ) {
      const regSlug = res.regattaSlug || (res.regattaName || "").toLowerCase().replace(/[^a-z0-9]+/g, "-");
      const boatClass = res.boatClass || "Optimist";
      const year = Number(String(res.regattaDate || "").slice(0, 4)) || 2026;
      const dedupeKey = `${regSlug}-${boatClass}-overall-${res.rank}`;

      // Only add if not already captured under NoR schedule
      const alreadyHas = awards.some(
        (a) =>
          a.regattaSlug === regSlug ||
          a.regattaName.toLowerCase() === (res.regattaName || "").toLowerCase()
      );

      if (!alreadyHas && !seenKeys.has(dedupeKey)) {
        seenKeys.add(dedupeKey);
        awards.push({
          id: dedupeKey,
          regattaName: res.regattaName || "Regatta",
          regattaSlug: regSlug,
          regattaDate: res.regattaDate,
          year,
          boatClass,
          fleetName: res.division || "Open Fleet",
          categoryName: "Open",
          prizeTitle: `${res.rank}${res.rank === 1 ? "st" : res.rank === 2 ? "nd" : "3rd"} Place`,
          rank: res.rank,
          medal: res.rank === 1 ? "gold" : res.rank === 2 ? "silver" : "bronze",
          notes: res.fleetSize ? `Fleet size: ${res.fleetSize}` : undefined,
          sailNumber: res.sailNumber || sailor.sailNumber || undefined,
          club: sailor.club || undefined,
          schoolName: sailor.school || undefined,
          isOfficialNoR: false,
        });
      }
    }
  }

  // Sort awards: Gold first, then Silver, then Bronze, then newest year/regatta
  awards.sort((a, b) => {
    const medalOrder = { gold: 0, silver: 1, bronze: 2, other: 3 };
    const diff = medalOrder[a.medal] - medalOrder[b.medal];
    if (diff !== 0) return diff;
    return a.rank - b.rank;
  });

  return awards;
}

/**
 * Calculates medal counts from a list of sailor awards.
 */
export function getSailorMedalCounts(awards: SailorPrizeAward[]): SailorMedalCounts {
  let gold = 0;
  let silver = 0;
  let bronze = 0;

  for (const a of awards) {
    if (a.medal === "gold") gold++;
    else if (a.medal === "silver") silver++;
    else if (a.medal === "bronze") bronze++;
  }

  return {
    gold,
    silver,
    bronze,
    total: awards.length,
  };
}
