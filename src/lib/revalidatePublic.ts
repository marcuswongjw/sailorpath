import { revalidatePath, revalidateTag } from "next/cache";
import {
  CACHE_TAG_NEWS_ARTICLES,
  PUBLIC_RANKING_CACHE_TAGS,
} from "@/lib/cacheTags";

/**
 * Public ranking / regatta routes that use ISR (`export const revalidate`)
 * or shared `unstable_cache` payloads.
 */
const PUBLIC_RANKING_PATHS = [
  "/",
  "/rankings",
  "/search",
  "/calendar",
  "/sg/optimist/gold",
  "/sg/optimist/silver",
  "/sg/optimist/regattas",
  "/sg/optimist/selection",
  "/sg/ilca4",
  "/sg/ilca4/regattas",
  "/sg/ilca6",
  "/sg/ilca7",
  "/sg/wingfoil",
  "/sg/techno293",
  "/sg/iqfoil",
  "/api/rankings",
] as const;

/**
 * Mark public ranking caches stale after admin import / result / regatta writes.
 *
 * Uses `revalidateTag(..., "max")` (stale-while-revalidate) plus path
 * invalidation so the next visit to Gold/Silver/ILCA/regatta pages refreshes.
 * Safe to call from Route Handlers; never throws to the client.
 */
export function revalidatePublicRankings(reason?: string): void {
  try {
    for (const tag of PUBLIC_RANKING_CACHE_TAGS) {
      try {
        revalidateTag(tag, { expire: 0 });
      } catch {
        revalidateTag(tag, "max");
      }
    }
    for (const path of PUBLIC_RANKING_PATHS) {
      revalidatePath(path);
      revalidatePath(path, "page");
      revalidatePath(path, "layout");
    }
    if (reason && process.env.NODE_ENV !== "production") {
      console.info("[revalidatePublicRankings]", reason);
    }
  } catch (e) {
    console.warn("[revalidatePublicRankings] failed", reason || "", e);
  }
}

/** Refresh the published news index and an optional canonical article route. */
export function revalidatePublicNews(slug?: string): void {
  try {
    try {
      revalidateTag(CACHE_TAG_NEWS_ARTICLES, { expire: 0 });
    } catch {
      revalidateTag(CACHE_TAG_NEWS_ARTICLES, "max");
    }
    revalidatePath("/news");
    if (slug) revalidatePath(`/news/${encodeURIComponent(slug)}`);
  } catch (error) {
    console.warn("[revalidatePublicNews] failed", slug || "", error);
  }
}
