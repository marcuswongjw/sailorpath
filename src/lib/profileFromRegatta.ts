/**
 * Profile fields (sail #, club, school) always follow the latest regatta.
 *
 * “Latest” = most recent by regatta date across all classes and ranking flags
 * (Optimist, ILCA 4, ranking, non-ranking). When details differ, the newest
 * event wins.
 */

import { toYmd } from "@/lib/datesSg";

export type ProfileFieldSource = {
  sailNumber?: string | null;
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
  if (!latest) return true; // no history — apply
  // Equal date allowed (same day re-import / multi-fleet same day)
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
  row: ProfileFieldSource,
  existing: ProfileFieldSource,
  apply: boolean
): { patch: ProfileFieldSource; changed: string[] } {
  if (!apply) return { patch: {}, changed: [] };
  const patch: ProfileFieldSource = {};
  const changed: string[] = [];

  const sail = cleanText(row.sailNumber);
  if (sail) {
    const cur = (existing.sailNumber || "").trim();
    const isPlaceholder =
      !cur || /^SGP\s*0+$/i.test(cur) || cur === "N/A";
    if (isPlaceholder || cur.toLowerCase() !== sail.toLowerCase()) {
      patch.sailNumber = sail;
      changed.push("sailNumber");
    }
  }

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

  return { patch, changed };
}
