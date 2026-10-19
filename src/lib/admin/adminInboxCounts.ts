export type AdminInboxQueueCounts = Readonly<{
  suggestions: number;
  claims: number;
  coaches: number;
  support: number;
}>;

export type AdminQueueState = {
  status: "loading" | "ready" | "stale" | "unavailable";
  updatedAt: number;
};
export type AdminInboxQueueStates = Record<
  keyof AdminInboxQueueCounts,
  AdminQueueState
>;

/** A zero only means clear when every source has succeeded. */
export function inboxIsComplete(states?: AdminInboxQueueStates): boolean {
  return (
    states != null &&
    Object.values(states).every((state) => state.status === "ready")
  );
}

/** Counts only work waiting in inbox queues, never recent audit activity. */
export function totalPendingAdminInboxItems(
  queues: AdminInboxQueueCounts,
): number {
  return queues.suggestions + queues.claims + queues.coaches + queues.support;
}
