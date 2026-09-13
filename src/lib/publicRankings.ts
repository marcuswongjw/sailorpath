import { birthYear } from "@/lib/age";
import {
  stripProjectedNextSquadStatus,
  type RankedSailor,
} from "@/lib/ranking";

/**
 * Produces a ranking record safe to serialize to an anonymous browser.
 * Ranking screens need only a birth-year signal; preserve their existing date
 * shape with a synthetic 1 January value so client-side age calculations keep
 * their current behaviour without disclosing the actual day or month.
 */
export function toPublicRankedSailor(sailor: RankedSailor): RankedSailor {
  const year = birthYear(sailor.dob);
  return {
    ...sailor,
    dob: year == null ? null : `${year}-01-01`,
  };
}

export function toPublicRankedSailors(
  sailors: RankedSailor[]
): RankedSailor[] {
  return stripProjectedNextSquadStatus(sailors.map(toPublicRankedSailor));
}
