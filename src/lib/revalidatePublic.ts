import { revalidatePath, revalidateTag } from "next/cache";
import { PUBLIC_RANKING_CACHE_TAGS } from "@/lib/cacheTags";

/**
 * Public ranking / regatta routes that use ISR (`export const revalidate`)
 * or shared `unstable_cache` payloads.
 */
const PUBLIC_RANKING_PATHS = [
  "/",
  "/rankings",
  "/sg/optimist/gold",
  "/sg/optimist/silver",
  "/sg/optimist/regattas",
  "/sg/ilca4",
  "/sg/ilca4/regattas",
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
      revalidateTag(tag, "max");
    }
    for (const path of PUBLIC_RANKING_PATHS) {
      revalidatePath(path);
    }
    if (reason && process.env.NODE_ENV !== "production") {
      console.info("[revalidatePublicRankings]", reason);
    }
  } catch (e) {
    console.warn("[revalidatePublicRankings] failed", reason || "", e);
  }
}
