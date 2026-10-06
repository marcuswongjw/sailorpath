export type BulkMergePair<T> = {
  survivor: T;
  duplicate: T;
};

/**
 * Queue every duplicate in a group, but only one duplicate of each survivor
 * per request. hasMore is true whenever a duplicate was left for the next
 * request, including a second profile in a group smaller than the cap.
 */
export function planBulkMergeBatch<T extends { id: string }>(
  groups: readonly (readonly T[])[],
  compareSurvivor: (a: T, b: T) => number,
  limit: number
): { batch: BulkMergePair<T>[]; hasMore: boolean } {
  const queued: BulkMergePair<T>[] = [];
  for (const members of groups) {
    const [survivor, ...duplicates] = [...members].sort(compareSurvivor);
    if (!survivor) continue;
    for (const duplicate of duplicates) {
      queued.push({ survivor, duplicate });
    }
  }

  const batch: BulkMergePair<T>[] = [];
  const seenSurvivor = new Set<string>();
  let deferred = 0;
  for (const item of queued) {
    if (batch.length >= limit || seenSurvivor.has(item.survivor.id)) {
      deferred += 1;
      continue;
    }
    seenSurvivor.add(item.survivor.id);
    batch.push(item);
  }
  return { batch, hasMore: deferred > 0 };
}
