/**
 * Admin fleet tags for national ranking boards.
 *
 * SG Optimist is currentFleet Series vs Guest. Gold vs Silver stays date-derived
 * (goldEntryDate / silverEntryDate) so resolveSailorFleet is unchanged.
 * ILCA 4 is the stored boolean. ILCA 6 is stored true/false, with the SSF name
 * seed shown only while the column is still null.
 */

import { todayYmdSg } from "@/lib/datesSg";
import { isOnIlca6NationalListByName } from "@/lib/ilca6NationalList";

export type OptimistDivision = "gold" | "silver";

export type FleetTagFields = {
  name?: string;
  currentFleet?: string;
  goldEntryDate?: string;
  silverEntryDate?: string;
  ilca4NationalList?: boolean;
  /** null = not saved yet; display falls back to the ILCA 6 name seed */
  ilca6NationalList?: boolean | null;
};

export function isSgOptimistTagged(currentFleet: string | null | undefined): boolean {
  return ["series", "gold", "silver"].includes(
    String(currentFleet || "").toLowerCase()
  );
}

/** Gold when a gold entry date is set; otherwise Silver while tagged in SG Optimist. */
export function optimistDivisionOf(fields: {
  goldEntryDate?: string | null;
}): OptimistDivision {
  return fields.goldEntryDate ? "gold" : "silver";
}

/** 1 Jan or 1 Jul that starts the half containing `today` (YYYY-MM-DD). */
export function currentHalfStartYmd(today = todayYmdSg()): string {
  const y = today.slice(0, 4);
  const month = Number(today.slice(5, 7));
  return month >= 7 ? `${y}-07-01` : `${y}-01-01`;
}

/**
 * Tag or untag SG Optimist.
 * Untagging sets Guest and keeps entry dates so history is not wiped.
 * Tagging with no dates stamps silver entry (same rule as the previous admit control).
 */
export function setSgOptimistTag<T extends FleetTagFields>(
  form: T,
  on: boolean,
  today = todayYmdSg()
): T {
  if (!on) {
    return { ...form, currentFleet: "Guest" };
  }
  const next: T = { ...form, currentFleet: "Series" };
  if (!next.silverEntryDate && !next.goldEntryDate) {
    next.silverEntryDate = today;
  }
  return next;
}

/**
 * Gold sets a half-boundary gold entry when empty and ensures a silver date
 * so validateGoldPromotion can pass. Silver clears the gold entry date.
 */
export function setOptimistDivision<T extends FleetTagFields>(
  form: T,
  division: OptimistDivision,
  today = todayYmdSg()
): T {
  const next: T = { ...form, currentFleet: "Series" };
  if (division === "silver") {
    next.goldEntryDate = "";
    if (!next.silverEntryDate) next.silverEntryDate = today;
    return next;
  }
  if (!next.goldEntryDate) {
    next.goldEntryDate = currentHalfStartYmd(today);
  }
  if (!next.silverEntryDate) {
    next.silverEntryDate = next.goldEntryDate;
  }
  return next;
}

/** Checkbox state: explicit flag wins; null uses the official ILCA 6 name seed. */
export function ilca6TagChecked(
  flag: boolean | null | undefined,
  name: string | null | undefined
): boolean {
  if (flag === true) return true;
  if (flag === false) return false;
  return isOnIlca6NationalListByName(name);
}

/** Values written by the sailor save. ILCA 6 is always an explicit boolean. */
export function fleetTagSaveValues(form: FleetTagFields): {
  currentFleet: "Series" | "Guest";
  ilca4NationalList: boolean;
  ilca6NationalList: boolean;
} {
  return {
    currentFleet: isSgOptimistTagged(form.currentFleet) ? "Series" : "Guest",
    ilca4NationalList: form.ilca4NationalList === true,
    ilca6NationalList: ilca6TagChecked(form.ilca6NationalList, form.name),
  };
}
