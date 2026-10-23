/** Coalesce concurrent refreshes only; completed values/errors are never cached here. */
const pending = new Map<string, Promise<unknown>>();
export function singleFlight<T>(key: string, load: () => Promise<T>): Promise<T> {
  const existing = pending.get(key);
  if (existing) return existing as Promise<T>;
  const promise = Promise.resolve().then(load).finally(() => { pending.delete(key); });
  pending.set(key, promise);
  return promise;
}
