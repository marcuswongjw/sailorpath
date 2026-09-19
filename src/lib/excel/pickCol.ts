function escapeRegex(s: string): string {
  return s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

/**
 * Find a cell by header aliases:
 * 1. Exact stripped match (ignoring whitespace and common punctuation)
 * 2. Word/token boundary match (prevents short aliases like "sail" or "ig" from matching "Sailor" or "Weight")
 */
export function pickCol(
  row: Record<string, unknown>,
  aliases: string[]
): unknown {
  const keys = Object.keys(row);
  const strip = (k: string) => k.toLowerCase().replace(/[\s_\-#.]+/g, "");

  // Pass 1: Exact stripped match
  for (const a of aliases) {
    const strippedA = strip(a);
    if (!strippedA) continue;
    const hit = keys.find((k) => strip(k) === strippedA);
    if (hit != null && row[hit] !== "" && row[hit] != null) return row[hit];
  }

  // Pass 2: Whole word / token boundary match
  for (const a of aliases) {
    const cleanAlias = a.trim().toLowerCase();
    if (!cleanAlias) continue;
    const pattern = new RegExp(
      `(?:^|[^a-z0-9])${escapeRegex(cleanAlias)}(?:$|[^a-z0-9])`,
      "i"
    );
    const hit = keys.find((k) => pattern.test(k));
    if (hit != null && row[hit] !== "" && row[hit] != null) return row[hit];
  }

  return null;
}
