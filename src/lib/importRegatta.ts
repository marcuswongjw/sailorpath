/**
 * Pure helpers for regatta Excel import (no DB I/O).
 */

import { combinedNameSimilarity } from "@/lib/nameMatch";
import {
  normalizeDob,
  normalizeOptionalText,
  normalizeSailNumber,
  toNumber,
} from "@/lib/normalize";
import { normalizeNationality } from "@/lib/seriesMembership";
import type { ImportPossibleDuplicate } from "@/types/import";

export const IMPORT_MAX_DUPLICATE_FLAGS = 40;
export const IMPORT_RESULT_CHUNK = 15;

export type RawImportRow = {
  name: string;
  rank: number | null;
  nett: number | null;
  total?: number | null;
  club?: string | null;
  school?: string | null;
  nationality?: string | null;
  sailNumber?: string | null;
  dob?: string | number | null;
  birthYear?: string | number | null;
};

export type CleanImportRow = {
  name: string;
  rank: number | null;
  nett: number | null;
  total: number | null;
  club: string | null;
  school: string | null;
  nationality: string | null;
  sailNumber: string | null;
  dob: string | null;
  dobIsYearOnly: boolean;
};

/** Normalize client rows: trim names, numbers, DOB year-only flags. */
export function cleanImportRows(rows: RawImportRow[]): CleanImportRow[] {
  return rows
    .map((r) => {
      const sailNumber = normalizeSailNumber(r.sailNumber);
      const fullDob = normalizeDob(r.dob);
      const yearOnlyDob = !fullDob ? normalizeDob(r.birthYear) : null;
      const birthYearHint =
        r.birthYear != null && r.birthYear !== ""
          ? normalizeDob(r.birthYear)
          : null;
      const dob = fullDob || yearOnlyDob;
      const dobIsYearOnly = Boolean(
        yearOnlyDob ||
          (birthYearHint && fullDob && fullDob === birthYearHint)
      );
      return {
        name: String(r.name || "").trim(),
        rank: toNumber(r.rank),
        nett: toNumber(r.nett),
        total: toNumber((r as { total?: number | null }).total),
        club: normalizeOptionalText(r.club),
        school: normalizeOptionalText(
          (r as { school?: string | null }).school
        ),
        nationality:
          normalizeNationality(r.nationality) ||
          normalizeOptionalText(r.nationality),
        sailNumber,
        dob,
        dobIsYearOnly,
      };
    })
    .filter((r) => r.name.length > 0);
}

/**
 * Pairwise similar names within the import sheet (60%+).
 * Caps list size and pair count so O(n²) work cannot blow serverless limits.
 */
export function findWithinFileDuplicates(
  names: string[],
  opts?: {
    minSimilarity?: number;
    maxPairs?: number;
    maxNames?: number;
  }
): ImportPossibleDuplicate[] {
  const minSimilarity = opts?.minSimilarity ?? 0.6;
  const maxPairs = opts?.maxPairs ?? IMPORT_MAX_DUPLICATE_FLAGS;
  const maxNames = opts?.maxNames ?? 120;
  const out: ImportPossibleDuplicate[] = [];
  const seen = new Set<string>();
  const list = names.slice(0, maxNames);

  for (let i = 0; i < list.length; i++) {
    for (let j = i + 1; j < list.length; j++) {
      if (out.length >= maxPairs) {
        return out.sort((x, y) => y.similarity - x.similarity);
      }
      const a = list[i];
      const b = list[j];
      if (!a || !b || a === b) continue;
      const sim = combinedNameSimilarity(a, b);
      if (sim < minSimilarity) continue;
      const key = [a, b].map((n) => n.toLowerCase()).sort().join("|");
      if (seen.has(key)) continue;
      seen.add(key);
      out.push({
        kind: "within-file",
        importName: a,
        otherName: b,
        similarity: Math.round(sim * 100) / 100,
        band: sim >= 0.8 ? "high" : "medium",
        note: "Two rows in this file look like the same sailor",
      });
    }
  }
  return out.sort((x, y) => y.similarity - x.similarity);
}

export function buildImportMessage(input: {
  regattaName: string;
  matched: number;
  inputRows: number;
  created: number;
  updatedProfiles: number;
  silverUpdated: number;
  rowErrors: number;
  unmatchedCount: number;
  duplicateCount: number;
  needsNettMigration: boolean;
}): string {
  const {
    regattaName,
    matched,
    inputRows,
    created,
    updatedProfiles,
    silverUpdated,
    rowErrors,
    unmatchedCount,
    duplicateCount,
    needsNettMigration,
  } = input;

  if (matched === 0 && rowErrors > 0) {
    return `Import failed for all rows. ${
      needsNettMigration
        ? "Likely cause: nett_score is still INTEGER — run migration 003 in Supabase (allows 14.5 points)."
        : "See errors below."
    }`;
  }

  const dupeNote =
    duplicateCount > 0
      ? ` · ${duplicateCount} possible duplicate name(s) flagged (60%+ similar) — review below / merge in Database.`
      : "";

  return (
    `Imported ${regattaName}: ${matched}/${inputRows} results saved ` +
    `(${created} guests auto-created, ${updatedProfiles} profiles updated when event is latest, ` +
    `${silverUpdated} silver entry dates recomputed). ` +
    `Fleet tags unchanged — admit series members as Silver (then Gold) in Database. ` +
    `${rowErrors} row errors, ${unmatchedCount} unmatched.${dupeNote}`
  );
}

/** Browser TypeError when the connection drops (often after serverless timeout). */
export function isNetworkFetchError(message: string): boolean {
  return /failed to fetch|networkerror|load failed|network request failed|aborted|timeout/i.test(
    message
  );
}
