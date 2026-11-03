import type { SailorPrizeAward, SailorMedalCounts } from "./sailorPrizes";

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
