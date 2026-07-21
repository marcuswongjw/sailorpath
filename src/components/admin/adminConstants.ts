/** Database Management — sailors table columns (visibility prefs in localStorage) */
export const DB_SAILOR_COLUMNS: {
  key: string;
  label: string;
  defaultOn: boolean;
}[] = [
  { key: "name", label: "Name", defaultOn: true },
  { key: "sailNumber", label: "Sail #", defaultOn: false },
  { key: "series", label: "Series", defaultOn: false },
  { key: "best3", label: "Best 3 of 5", defaultOn: true },
  { key: "gender", label: "Gender", defaultOn: true },
  { key: "age", label: "Age", defaultOn: true },
  { key: "club", label: "Club", defaultOn: false },
  { key: "nationality", label: "Nationality", defaultOn: false },
  { key: "school", label: "School", defaultOn: false },
  { key: "goldEntry", label: "Gold Entry", defaultOn: true },
  { key: "silverEntry", label: "Silver Entry", defaultOn: true },
  { key: "dropDate", label: "Drop Date", defaultOn: true },
  { key: "squadJan25", label: "Squad Jan 25", defaultOn: false },
  { key: "squadJul25", label: "Squad Jul 25", defaultOn: false },
  { key: "squadJan26", label: "Squad Jan 26", defaultOn: false },
  { key: "squadJul26", label: "Squad Jul 26", defaultOn: true },
  { key: "histJun24", label: "Hist Jun 24", defaultOn: false },
  { key: "histDec24", label: "Hist Dec 24", defaultOn: false },
  { key: "histJun25", label: "Hist Jun 25", defaultOn: false },
  { key: "histDec25", label: "Hist Dec 25", defaultOn: false },
  { key: "histJun26", label: "Hist Jun 26", defaultOn: false },
  { key: "worlds", label: "Worlds", defaultOn: false },
  { key: "european", label: "European", defaultOn: false },
  { key: "asian", label: "Asian", defaultOn: false },
  { key: "seaGames", label: "SEA Games", defaultOn: false },
];

export const DB_COLS_STORAGE = "sp-admin-db-sailor-cols";

export function defaultDbColVisible(): Record<string, boolean> {
  const o: Record<string, boolean> = {};
  for (const c of DB_SAILOR_COLUMNS) o[c.key] = c.defaultOn;
  return o;
}
