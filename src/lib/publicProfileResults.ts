import { and, eq, inArray, like, or } from "drizzle-orm";
import { regattas } from "@/db/schema";

/** Public profiles never act as an alternate publication path for imports. */
export function publicProfileRegattaCondition() {
  return or(
    eq(regattas.status, "published"),
    // Personal logbook sheets use draft as their storage default. They remain
    // explicitly self-reported/pending, not official published imports.
    and(
      like(regattas.slug, "log-%"),
      eq(regattas.countsForRanking, false),
      inArray(regattas.status, ["draft", "in_review"])
    )
  );
}
