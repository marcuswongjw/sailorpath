export type AsianOptimistIndexDuplicateReview = {
  candidateHandle: string;
  confidence: "high" | "review";
  reason: string;
};

/**
 * Conservative, source-audited profile-review flags for the founding 2025
 * Asian Optimist Index cohort. These flags do not merge profiles or alter
 * results; they surface potential duplicate athlete records for an admin to
 * resolve after checking source evidence.
 */
export const ASIAN_OPTIMIST_INDEX_DUPLICATE_REVIEWS = {
  "IND:bannybongur": {
    candidateHandle: "bongur-banny-zicv5kk",
    confidence: "high",
    reason: "Same nationality, matching sail number, and reordered name.",
  },
  "THA:rachatasadtrakulwattana": {
    candidateHandle: "rachata-sadtrakulwatanna-823ho68",
    confidence: "high",
    reason: "Same nationality and sail number with a one-character name variant.",
  },
  "IND:shreyalakshminarayanan": {
    candidateHandle: "shreya-krishna-lakshminarayanan-yvqywlz",
    confidence: "high",
    reason: "Same nationality and sail number; existing profile includes a middle name.",
  },
  "SGP:ethanchia": {
    candidateHandle: "ethan-chia-han-wei",
    confidence: "high",
    reason: "Exact stored alias and matching sail number.",
  },
  "SGP:mikaelang": {
    candidateHandle: "mikaela-rae-ng",
    confidence: "high",
    reason: "Exact stored alias and matching sail number.",
  },
  "SGP:zhitongwai": {
    candidateHandle: "wai-zhi-tong",
    confidence: "review",
    reason: "Exact stored alias / reordered name, but a different sail number.",
  },
  "SGP:alyssawong": {
    candidateHandle: "alyssa-wong-li-lin",
    confidence: "review",
    reason: "Exact stored alias, but a different sail number.",
  },
  "SGP:teckwoonpee": {
    candidateHandle: "pee-teck-woon",
    confidence: "review",
    reason: "Exact stored alias / reordered name, but a different sail number.",
  },
  "HKG:scarletttao": {
    candidateHandle: "scarlett-tao-xinran-zn8iz60",
    confidence: "review",
    reason: "Exact stored alias, but a different sail number.",
  },
  "SGP:anyazahedi": {
    candidateHandle: "anya-alessia-zahedi",
    confidence: "review",
    reason: "Exact stored alias, but a different sail number.",
  },
  "SGP:ethanlow": {
    candidateHandle: "ethan-low-zhi-ren",
    confidence: "review",
    reason: "Exact stored alias, but a different sail number.",
  },
  "SGP:desireelee": {
    candidateHandle: "desiree-lee-yuet-chi",
    confidence: "review",
    reason: "Exact stored alias, but a different sail number.",
  },
  "CHN:linshi": {
    candidateHandle: "shi-lin-vysogv7",
    confidence: "review",
    reason: "Reordered name only; sail number is different.",
  },
} as const satisfies Record<string, AsianOptimistIndexDuplicateReview>;
