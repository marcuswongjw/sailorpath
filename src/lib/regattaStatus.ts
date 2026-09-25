/**
 * Regatta lifecycle: draft → in_review → published → archived.
 * Public ranking boards (Optimist Gold/Silver, ILCA) must only score
 * published events. Admin staging (draft / in_review) and archived
 * events are excluded at the ranking data-load boundary.
 */

export const PUBLIC_RANKING_REGATTA_STATUS = "published" as const;

export type RegattaLifecycleStatus =
  | "draft"
  | "in_review"
  | "published"
  | "archived";

export const REGATTA_LIFECYCLE_STATUSES: readonly RegattaLifecycleStatus[] = [
  "draft",
  "in_review",
  "published",
  "archived",
] as const;

export function isRegattaLifecycleStatus(
  status: unknown
): status is RegattaLifecycleStatus {
  return (
    typeof status === "string" &&
    (REGATTA_LIFECYCLE_STATUSES as readonly string[]).includes(status)
  );
}

/** True when a regatta may contribute starts/scores to public rankings. */
export function isPublicRankingRegattaStatus(
  status: string | null | undefined
): boolean {
  return status === PUBLIC_RANKING_REGATTA_STATUS;
}

/**
 * Keep only rows whose lifecycle status is public-ranking-eligible.
 * Rows without a status field are dropped (callers that already filtered
 * in SQL need not use this).
 */
export function filterPublicRankingRegattas<
  T extends { status?: string | null; id?: string },
>(rows: T[]): T[] {
  return rows.filter((r) => isPublicRankingRegattaStatus(r.status));
}
