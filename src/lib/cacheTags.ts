/**
 * Next.js Data Cache tags for public rankings / regatta directories.
 * Keep in sync with `unstable_cache(..., { tags })` in queries.ts
 * and `revalidatePublicRankings()` after admin writes.
 */

export const CACHE_TAG_FLEET_RANKINGS = "fleet-rankings";
export const CACHE_TAG_ILCA_RANKINGS = "ilca-rankings";
export const CACHE_TAG_PUBLIC_REGATTAS = "public-regattas";
/** Lean admin Stats tab aggregates (`getCachedAdminStats`). */
export const CACHE_TAG_ADMIN_STATS = "admin-stats";

/** All tags invalidated when results / fleet membership / imports change. */
export const PUBLIC_RANKING_CACHE_TAGS = [
  CACHE_TAG_FLEET_RANKINGS,
  CACHE_TAG_ILCA_RANKINGS,
  CACHE_TAG_PUBLIC_REGATTAS,
] as const;
