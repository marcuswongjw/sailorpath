/** Stable key for matching a prize name to a published result name. */
export function prizeNameKey(name: string): string {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, " ")
    .trim();
}
