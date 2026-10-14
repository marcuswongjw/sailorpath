export type AsianOptimistIndexDuplicateReview = {
  candidateHandle: string;
  confidence: "high" | "review";
  reason: string;
};

/**
 * Open public profile-review flags for the founding 2025 Asian Optimist Index
 * cohort. The 13 candidates identified in the initial audit were confirmed and
 * merged into their established SailorPath records on 14 October 2026, so no
 * open public review flags remain in this release. The resolved records remain
 * in the database audit ledger.
 */
export const ASIAN_OPTIMIST_INDEX_DUPLICATE_REVIEWS = {} as const satisfies Record<
  string,
  AsianOptimistIndexDuplicateReview
>;
