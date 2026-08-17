/**
 * Tiny process-local cache for expensive admin stats.
 * Survives within a warm serverless instance; no cross-instance guarantees.
 */

type Entry<T> = { at: number; value: T };

const store = new Map<string, Entry<unknown>>();

export function cacheGet<T>(key: string, maxAgeMs: number): T | null {
  const e = store.get(key);
  if (!e) return null;
  if (Date.now() - e.at > maxAgeMs) {
    store.delete(key);
    return null;
  }
  return e.value as T;
}

export function cacheSet<T>(key: string, value: T): void {
  store.set(key, { at: Date.now(), value });
  // Bound memory: drop oldest when large
  if (store.size > 40) {
    const first = store.keys().next().value;
    if (first != null) store.delete(first);
  }
}

export function cacheAgeMs(key: string): number | null {
  const e = store.get(key);
  if (!e) return null;
  return Date.now() - e.at;
}
