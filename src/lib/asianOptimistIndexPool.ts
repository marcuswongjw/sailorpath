/** Select additional published Optimist scorecards for the Power Rating pool. */
export function selectPowerPool<T extends { slug: string; date: string; endDate: string | null; raceCount: number | null }>(
  regattas: T[], excludedSlugs: ReadonlySet<string>, cutoff: string
): T[] {
  return regattas.filter((regatta) =>
    !excludedSlugs.has(regatta.slug) &&
    (regatta.endDate ?? regatta.date) >= cutoff &&
    (regatta.raceCount ?? 0) >= 3
  );
}
