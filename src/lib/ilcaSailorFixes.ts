/**
 * Idempotent ILCA roster fixes applied via admin action.
 * - Merge known duplicate profiles (keep correct name)
 * - Set known ILCA 4 sail numbers
 * - Clear incorrect Optimist data on pure ILCA sailors
 */

export const JONAS_TAN_KEEP_NAME = "Jonas Tan Kia Jeng";
export const JONAS_TAN_MERGE_NAME = "Jonas Tan Yi Jun";
/** Official ILCA 4 sail for Jonas Tan Kia Jeng */
export const JONAS_TAN_ILCA4_SAIL = "197840";

/** ILCA-only sailor incorrectly stamped with Optimist silver data */
export const GOH_SIAK_YIAK_IAN_NAME = "Goh Siak Yiak Ian";

export type NamedMergeFix = {
  keepName: string;
  mergeName: string;
  /** Set sail_number_ilca4 on the kept sailor after merge */
  sailNumberIlca4?: string;
};

export const ILCA_NAMED_MERGES: readonly NamedMergeFix[] = [
  {
    keepName: JONAS_TAN_KEEP_NAME,
    mergeName: JONAS_TAN_MERGE_NAME,
    sailNumberIlca4: JONAS_TAN_ILCA4_SAIL,
  },
] as const;

/** True if this row is the Goh Siak Yiak Ian profile (name variants). */
export function isGohSiakYiakIanName(name: string | null | undefined): boolean {
  const n = String(name || "")
    .trim()
    .toLowerCase()
    .replace(/\s+/g, " ");
  if (!n) return false;
  if (n === "goh siak yiak ian") return true;
  if (n === "ian goh siak yiak") return true;
  // Distinctive middle tokens
  if (n.includes("siak") && n.includes("yiak") && n.includes("goh")) return true;
  return false;
}
