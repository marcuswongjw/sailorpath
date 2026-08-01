/**
 * Profile fields prefer the latest regatta data by date.
 *
 * Club & school: any class; newest regatta date wins.
 * Sail numbers: class-specific —
 *   - Optimist → sail_number
 *   - ILCA 4 → sail_number_ilca4
 * Sailors under 15 may hold both numbers.
 */

import { toYmd } from "@/lib/datesSg";
import { isIlcaSeriesClass } from "@/lib/ilcaRanking";

export type ProfileFieldSource = {
  sailNumber?: string | null;
  sailNumberIlca4?: string | null;
  club?: string | null;
  school?: string | null;
};

export function shouldApplyProfileFromRegatta(args: {
  regattaDate: string | null | undefined;
  /** Latest known result date for this sailor (YYYY-MM-DD), or null */
  latestResultDate: string | null | undefined;
}): boolean {
  const d = toYmd(args.regattaDate);
  if (!d) return false;
  const latest = toYmd(args.latestResultDate);
  if (!latest) return true;
  return d >= latest;
}

/**
 * Latest date among events that update a class-specific sail number.
 * Optimist uses all non-ILCA4 events; ILCA 4 uses ILCA 4 events only.
 */
export function shouldApplySailNumberFromRegatta(args: {
  regattaDate: string | null | undefined;
  boatClass: string | null | undefined;
  /** Latest Optimist (or other non-ILCA4) result date */
  latestOptimistDate: string | null | undefined;
  /** Latest ILCA 4 result date */
  latestIlca4Date: string | null | undefined;
}): boolean {
  const d = toYmd(args.regattaDate);
  if (!d) return false;
  if (isIlcaSeriesClass(args.boatClass, "ILCA 4")) {
    const latest = toYmd(args.latestIlca4Date);
    if (!latest) return true;
    return d >= latest;
  }
  const latest = toYmd(args.latestOptimistDate);
  if (!latest) return true;
  return d >= latest;
}

function cleanText(v: unknown): string | null {
  if (v == null || v === "") return null;
  const s = String(v).trim();
  return s || null;
}

/**
 * Build sail/club/school patch when this regatta is allowed to update profile.
 * Empty sheet values never clear existing fields.
 */
export function buildProfilePatchFromRow(
  row: ProfileFieldSource & { boatClass?: string | null },
  existing: ProfileFieldSource,
  applyClubSchool: boolean,
  applySail: boolean
): { patch: ProfileFieldSource; changed: string[] } {
  const patch: ProfileFieldSource = {};
  const changed: string[] = [];

  if (applySail) {
    const sail = cleanText(row.sailNumber);
    if (sail) {
      if (isIlcaSeriesClass(row.boatClass, "ILCA 4")) {
        const cur = (existing.sailNumberIlca4 || "").trim();
        if (!cur || cur.toLowerCase() !== sail.toLowerCase()) {
          patch.sailNumberIlca4 = sail;
          changed.push("sailNumberIlca4");
        }
      } else {
        const cur = (existing.sailNumber || "").trim();
        const isPlaceholder =
          !cur || /^SGP\s*0+$/i.test(cur) || cur === "N/A";
        if (isPlaceholder || cur.toLowerCase() !== sail.toLowerCase()) {
          patch.sailNumber = sail;
          changed.push("sailNumber");
        }
      }
    }
  }

  if (applyClubSchool) {
    const club = cleanText(row.club);
    if (club) {
      const cur = (existing.club || "").trim();
      if (!cur || cur === "N/A" || cur.toLowerCase() !== club.toLowerCase()) {
        patch.club = club;
        changed.push("club");
      }
    }

    const school = cleanText(row.school);
    if (school) {
      const cur = (existing.school || "").trim();
      if (!cur || cur.toLowerCase() !== school.toLowerCase()) {
        patch.school = school;
        changed.push("school");
      }
    }
  }

  return { patch, changed };
}
