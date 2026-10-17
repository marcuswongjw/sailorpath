/** Last successful public payload for this server process.
 * Next's data cache already serves a stale entry during background refresh.
 * This covers the cold miss, where that refresh throws before any entry exists.
 */
const memory = new Map<string, unknown>();

export function rememberPublicRead<T>(key: string, value: T): T {
  memory.set(key, value);
  return value;
}

export function recallPublicRead<T>(key: string): T | undefined {
  return memory.get(key) as T | undefined;
}

export function clearPublicReadMemory(): void {
  memory.clear();
}
