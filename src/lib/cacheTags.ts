/**
 * Next.js Data Cache tags for public rankings / regatta directories.
 * Keep in sync with `unstable_cache(..., { tags })` in queries.ts
 * and `revalidatePublicRankings()` after admin writes.
 */

export const CACHE_TAG_FLEET_RANKINGS = "fleet-rankings";
export const CACHE_TAG_ILCA_RANKINGS = "ilca-rankings";
export const CACHE_TAG_PUBLIC_REGATTAS = "public-regattas";
export const CACHE_TAG_NEWS_ARTICLES = "news-articles";

/**
 * Backstop for public data caches. Admin imports and owner edits call
 * `revalidatePublicRankings()`, so visitors normally see changes immediately.
 * This TTL only applies when a write path does not invalidate tags.
 */
export const PUBLIC_DATA_REVALIDATE_SECONDS = 60 * 60;

/**
 * Ranking and selection snapshots move thousands of database rows per refresh.
 * Their tags are invalidated on every relevant write, so this longer interval is
 * only a fallback for out-of-band changes and limits pooler egress otherwise.
 */
export const PUBLIC_EXPENSIVE_DATA_REVALIDATE_SECONDS = 6 * 60 * 60;

/** All tags invalidated when results / fleet membership / imports change. */
export const PUBLIC_RANKING_CACHE_TAGS = [
  CACHE_TAG_FLEET_RANKINGS,
  CACHE_TAG_ILCA_RANKINGS,
  CACHE_TAG_PUBLIC_REGATTAS,
] as const;
