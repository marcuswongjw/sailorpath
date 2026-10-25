import { getCachedPublicRegattas, getResultsForRegatta } from "@/lib/queries";
import { getRegattaPrizeSchedule, getPrizeDefinitionsForSheet, type RegattaPrizeSchedule } from "@/lib/regattaPrizes";
import { fillUnlistedPrizeWinners, eligibilityForCategory } from "@/lib/prizeWinnersFromResults";
import { resolvePrizeWinnerProfile } from "@/lib/prizeWinnerProfiles";
import { getSailorPrizes, type SailorPrizeAward } from "@/lib/sailorPrizes";

/** Share the event page's calculated NoR awards with a participant's profile.
 * Read only public sheets in which this exact sailor participated, one cached fleet at a time.
 * Keep other competitors' eligibility fields on the server. */
export async function loadSailorPrizeAwards(
  sailor: { id: string; name: string; handle: string },
  results: readonly { regattaId: string; regattaSlug?: string }[]
): Promise<SailorPrizeAward[]> {
  const needsCalculation = (schedule: RegattaPrizeSchedule | null) => schedule?.fleets.some((fleet) => fleet.categories.some((category) => !category.winners.length && eligibilityForCategory(category.categoryName)));
  const candidates = results.filter((result) => result.regattaSlug && needsCalculation(getRegattaPrizeSchedule(result.regattaSlug)));
  if (!candidates.length) return [];
  const regattas = await getCachedPublicRegattas();
  const wanted = new Set(candidates.map((result) => result.regattaId));
  const awards: SailorPrizeAward[] = [];
  for (const regatta of regattas.filter((row) => wanted.has(row.id))) {
    const schedule = getRegattaPrizeSchedule(regatta.slug);
    if (!schedule) continue;
    const fleets = getPrizeDefinitionsForSheet(regatta)?.fleets || [];
    if (!fleets.some((fleet) => fleet.categories.some((category) => !category.winners.length && eligibilityForCategory(category.categoryName)))) continue;
    try {
      const rows = await getResultsForRegatta(regatta.id);
      const filled = fillUnlistedPrizeWinners(fleets, rows, Number(regatta.date.slice(0, 4)));
      const personal: RegattaPrizeSchedule = { ...schedule, fleets: filled.map((fleet) => ({ ...fleet, categories: fleet.categories.map((category) => ({ ...category, winners: category.winners.flatMap((winner) => {
        // A crew award belongs to each matched participant, never just the helm.
        return winner.sailorName.split("/").flatMap((name) => {
          const person = resolvePrizeWinnerProfile({ ...winner, sailorName: name.trim(), sailorHandle: winner.sailorName.includes("/") ? undefined : winner.sailorHandle }, rows);
          return person?.sailorId === sailor.id ? [{ ...winner, sailorName: sailor.name, sailorHandle: sailor.handle }] : [];
        });
      }) })) })) };
      awards.push(...getSailorPrizes(sailor, [], [personal]).map((award) => ({ ...award, schoolName: undefined })));
    } catch {
      // A temporarily unavailable older fleet must not hide the rest of a public profile.
    }
  }
  return awards;
}
