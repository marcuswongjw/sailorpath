/** Identifies recurring championship series using reviewed names, not venue or grade alone.
 * Keep boys and girls classifications separate. Add a rule when a new recurring
 * event is designated; unrecognised events use the ordinary 12-month window.
 */
export function annualSeriesKey(event: { name: string; indexRole: string; isWorlds: boolean }): string | null {
  const name = event.name.toLowerCase();
  const division = /\b(boys|girls)\b/.exec(name)?.[1] ?? "overall";
  if (event.isWorlds && /world championship/.test(name)) return `worlds:${division}`;
  if (/asian\s*(?:&|and)\s*oceanian championship/.test(name)) return `asian-oceanian:${division}`;
  if (/european championship/.test(name)) return `europeans:${division}`;
  const series: Array<[RegExp, string]> = [
    [/all japan optimist sailing championship/, "all-japan"],
    [/australian optimist championship/, "australian-nationals"],
    [/new zealand optimist national championship/, "new-zealand-nationals"],
    [/hong kong race week/, "hong-kong-race-week"],
    [/langkawi international regatta perdana/, "langkawi-regatta-perdana"],
    [/langkawi international youth sailing championship/, "langkawi-youth"],
    [/singapore youth sailing championships?/, "singapore-youth"],
    [/singapore national sailing championships?/, "singapore-nationals"],
    [/thailand international sailing championships?/, "thailand-international"],
    [/youth thailand national sailing championship/, "thailand-youth-nationals"],
    [/president.s cup national youth sailing championships?/, "korean-youth-nationals"],
    [/national president.s cup/, "taiwan-presidents-cup"],
    [/hkoda open and national championships?/, "hkoda-open"],
    [/mussanah race week/, "mussanah-race-week"],
    [/eastern seaboard regatta/, "eastern-seaboard"],
    [/regatta of champions/, "regatta-of-champions"],
    [/r\.o\.c\. kosmos/, "roc-kosmos"],
  ];
  const match = series.find(([pattern]) => pattern.test(name));
  return match ? `${match[1]}:${division}` : null;
}

type Event = { name: string; indexRole: string; isWorlds: boolean; endDate: string; resultStatus: string; grade: number | null; regattaSlugs: string[] };

/** Apply the published numerical gates to recorded register values. */
export function meetsRecordedIndexGates(event: { grade: number | null; fleetSize: number | null; raceCount: number | null; verifiedMnas: number | null }): boolean {
  const races = event.raceCount ?? 0;
  if (event.grade === 200 || event.grade === 150) return races >= 5;
  if (event.grade === 75) return (event.fleetSize ?? 0) >= 40 && (event.verifiedMnas ?? 0) >= 4 && races >= 4;
  if (event.grade === 40) return (event.fleetSize ?? 0) >= 25 && races >= 4;
  return false;
}

/** The newest completed, verified edition replaces earlier matching editions. */
export function selectActiveIndexEvents<T extends Event>(events: T[], now: Date): T[] {
  const today = now.toISOString().slice(0, 10);
  const cutoff = new Date(`${today}T00:00:00Z`);
  cutoff.setUTCFullYear(cutoff.getUTCFullYear() - 1);
  const cutoffDay = cutoff.toISOString().slice(0, 10);
  const valid = events.filter((event) =>
    event.resultStatus === "verified" && event.grade != null && event.regattaSlugs.length > 0 && event.endDate <= today
  );
  const latest = new Map<string, string>();
  for (const event of valid) {
    const key = annualSeriesKey(event);
    if (key && (!latest.has(key) || event.endDate > latest.get(key)!)) latest.set(key, event.endDate);
  }
  return events.filter((event) => {
    if (event.resultStatus === "scheduled") return true;
    if (!valid.includes(event)) return false;
    const key = annualSeriesKey(event);
    return key ? latest.get(key) === event.endDate : event.endDate >= cutoffDay;
  });
}
