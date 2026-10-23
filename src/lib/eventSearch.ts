/** Match complete words or word prefixes, never the middle of another word. */
export function eventSearchTokens(value: string): string[] {
  return value.normalize("NFKD").replace(/\p{M}/gu, "").toLowerCase()
    .replace(/([a-z])(\d)/g, "$1 $2").match(/[\p{L}\p{N}]+/gu) || [];
}
export function eventMatchesQuery(row: { name: string; slug?: string | null; venue?: string | null; boatClass?: string | null; division?: string | null; organizer?: string | null; region?: string | null }, query: string): boolean {
  const tokens = eventSearchTokens(query);
  if (!tokens.length) return !query.trim();
  const words = eventSearchTokens([row.name, row.slug, row.venue, row.boatClass, row.division, row.organizer, row.region].filter(Boolean).join(" "));
  return tokens.every((token) => words.some((word) => word.startsWith(token)));
}
