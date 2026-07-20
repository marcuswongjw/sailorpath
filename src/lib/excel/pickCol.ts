/**
 * Find a cell by header aliases (exact stripped match, then includes).
 */
export function pickCol(
  row: Record<string, unknown>,
  aliases: string[]
): unknown {
  const keys = Object.keys(row);
  const strip = (k: string) => k.toLowerCase().replace(/\s+/g, "");
  for (const a of aliases) {
    const hit = keys.find((k) => strip(k) === strip(a));
    if (hit != null && row[hit] !== "" && row[hit] != null) return row[hit];
  }
  for (const a of aliases) {
    const hit = keys.find((k) => k.toLowerCase().includes(a.toLowerCase()));
    if (hit != null && row[hit] !== "" && row[hit] != null) return row[hit];
  }
  return null;
}
