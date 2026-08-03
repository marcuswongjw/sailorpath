/**
 * Idempotent ILCA roster fixes applied via admin action.
 * - Merge known duplicate profiles (keep correct name)
 * - Set known ILCA 4 sail numbers
 */

export const JONAS_TAN_KEEP_NAME = "Jonas Tan Kia Jeng";
export const JONAS_TAN_MERGE_NAME = "Jonas Tan Yi Jun";
/** Official ILCA 4 sail for Jonas Tan Kia Jeng */
export const JONAS_TAN_ILCA4_SAIL = "197840";

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
