/**
 * Run async work over items in parallel chunks (bounded concurrency).
 * Used by bulk admin import to avoid N sequential DB round-trips.
 */
export async function runInChunks<T, R = void>(
  items: T[],
  chunkSize: number,
  worker: (item: T, index: number) => Promise<R>
): Promise<R[]> {
  const size = Math.max(1, Math.floor(chunkSize) || 1);
  const out: R[] = [];
  for (let i = 0; i < items.length; i += size) {
    const slice = items.slice(i, i + size);
    const part = await Promise.all(
      slice.map((item, j) => worker(item, i + j))
    );
    out.push(...part);
  }
  return out;
}
