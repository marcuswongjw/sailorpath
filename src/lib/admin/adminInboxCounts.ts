export type AdminInboxQueueCounts = Readonly<{
  suggestions: number;
  claims: number;
  coaches: number;
  support: number;
}>;

/** Counts only work waiting in inbox queues, never recent audit activity. */
export function totalPendingAdminInboxItems(
  queues: AdminInboxQueueCounts
): number {
  return queues.suggestions + queues.claims + queues.coaches + queues.support;
}
