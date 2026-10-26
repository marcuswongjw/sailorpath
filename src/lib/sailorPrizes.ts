/**
 * Sailor Prizes & Awards Linking System
 *
 * Discovers and links official Notice of Race (NoR) awards, podium finishes,
 * and trophies won by a sailor across all regattas to their personal profile.
 */

import {
  ALL_REGATTA_PRIZE_SCHEDULES,
  getRegattaPrizeSchedule,
  type RegattaPrizeSchedule,
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
  sourceUrl?: string;
}

export interface SailorMedalCounts {
  gold: number;
  silver: number;
  bronze: number;
  /** All recorded honours, including finishing-place prizes outside the podium. */
  total: number;
  podiums: number;
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
  // Category placing is authoritative. “Silver Fleet” and “Vice Champion”
  // describe an award, but must not turn a bronze or non-podium place into gold.
  if (Number.isFinite(rank) && rank > 0) {
    return rank === 1 ? "gold" : rank === 2 ? "silver" : rank === 3 ? "bronze" : "other";
  }
  const title = (prizeTitle || "").toLowerCase();
  if (/\b1st\b/.test(title)) return "gold";
  if (/\b2nd\b/.test(title)) return "silver";
  if (/\b3rd\b/.test(title)) return "bronze";
  return "other";
}

function ordinal(rank: number): string {
  const mod100 = rank % 100;
  if (mod100 >= 11 && mod100 <= 13) return `${rank}th`;
  if (rank % 10 === 1) return `${rank}st`;
  if (rank % 10 === 2) return `${rank}nd`;
  if (rank % 10 === 3) return `${rank}rd`;
  return `${rank}th`;
}

function regattaNameKey(name: string): string {
  return name
    .toLowerCase()
    .replace(/\([^)]*\)/g, " ")
    .replace(/[^a-z0-9]+/g, " ")
    .trim();
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
    isOverseasCommitment?: boolean;
  }[] = [],
  schedules: readonly RegattaPrizeSchedule[] = ALL_REGATTA_PRIZE_SCHEDULES
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
  for (const schedule of schedules) {
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

          if (w.sailorHandle ? w.sailorHandle === sailor.handle : nameMatches || (sailMatches && wordsOf(w.sailorName)[0] === wordsOf(sailor.name)[0])) {
            const medal = deriveMedalTier(w.rank, w.prizeTitle);
            const awardId = `${schedule.regattaSlug}-${fleet.fleetName}-${cat.categoryName}-${w.rank}`;

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
                prizeTitle: w.prizeTitle || `${ordinal(w.rank)} Place`,
                rank: w.rank,
                medal,
                notes: w.notes,
                sailNumber: w.sailNumber || sailor.sailNumber || undefined,
                schoolName: w.schoolName || sailor.school || undefined,
                club: w.club || sailor.club || undefined,
                isOfficialNoR: (cat.sourceKind || schedule.sourceKind) !== "organiser-report",
                sourceUrl: cat.sourceUrl || schedule.sourceUrl || schedule.noticeOfRaceUrl || undefined,
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
      !res.isOverseasCommitment &&
      !String(res.regattaSlug || "").startsWith("log-")
    ) {
      const regSlug = res.regattaSlug || (res.regattaName || "").toLowerCase().replace(/[^a-z0-9]+/g, "-");
      const boatClass = res.boatClass || "Optimist";
      const year = Number(String(res.regattaDate || "").slice(0, 4)) || 2026;
      const dedupeKey = `${regSlug}-${boatClass}-overall-${res.rank}`;

      // Only add if not already captured under NoR schedule
      const alreadyHas = awards.some(
        (a) =>
          /^(open|overall)(?:$|\s|\()/i.test(a.categoryName) &&
          a.boatClass === boatClass &&
          (!/gold|silver/i.test(res.division || "") || a.fleetName.toLowerCase().includes((res.division || "").toLowerCase())) &&
          (a.regattaSlug === regSlug ||
          getRegattaPrizeSchedule(regSlug)?.regattaSlug === a.regattaSlug ||
          regattaNameKey(a.regattaName) === regattaNameKey(res.regattaName || ""))
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
          prizeTitle: `${ordinal(res.rank)} Place`,
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
    podiums: gold + silver + bronze,
  };
}


/** Prefer the same event's named/NoR award over a duplicate generic podium. */
export function mergeSailorPrizes(...groups: SailorPrizeAward[][]): SailorPrizeAward[] {
  const all = [...new Map(groups.flat().map((award) => [award.id, award])).values()];
  const eventKey = (award: SailorPrizeAward) => getRegattaPrizeSchedule(award.regattaSlug)?.regattaSlug || award.regattaSlug;
  return all.filter((award) => award.sourceUrl || award.isOfficialNoR || !all.some((other) =>
    other !== award && /^(open|overall)(?:$|\s|\()/i.test(other.categoryName) && (other.sourceUrl || other.isOfficialNoR) && eventKey(other) === eventKey(award) && other.boatClass === award.boatClass &&
    (!/gold|silver/i.test(award.fleetName) || other.fleetName.toLowerCase().includes(award.fleetName.toLowerCase()))));
}
