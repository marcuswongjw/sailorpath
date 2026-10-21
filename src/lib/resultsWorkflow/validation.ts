import type { ExtractedResultTable } from "./types";

export function resultRowIssues(rows: ReadonlyArray<Pick<ExtractedResultTable["rows"][number], "name" | "sailNumber" | "rank" | "races" | "total" | "nett">>, raceCount: number): string[] {
  const issues: string[] = [];
  if (!rows.length || rows.length > 2000) issues.push("Fleet must contain 1–2000 named competitors.");
  if (!raceCount) issues.push("Individual race scores are missing.");
  const identities = new Set<string>();
  for (const [index, row] of rows.entries()) {
    const label = `Row ${index + 1} (${row.name})`;
    const key = `${row.name.trim().toLowerCase()}|${row.sailNumber}`;
    if (identities.has(key)) issues.push(`${label}: duplicate name and sail number.`);
    identities.add(key);
    if (!row.name || !row.sailNumber || !row.rank || !Number.isInteger(row.rank) || row.rank < 1) issues.push(`${label}: name, sail number, or rank missing/invalid.`);
    if (row.races.length !== raceCount || row.races.some((r, i) => r.raceNumber !== i + 1 || !Number.isFinite(r.score) || r.score < 0)) issues.push(`${label}: incomplete or invalid race sequence.`);
    const gross = row.races.reduce((sum, r) => sum + r.score, 0);
    const nett = row.races.reduce((sum, r) => sum + (r.discarded ? 0 : r.score), 0);
    if (row.total == null || Math.abs(gross - row.total) > 0.01) issues.push(`${label}: gross total does not reconcile.`);
    if (row.nett == null || Math.abs(nett - row.nett) > 0.01) issues.push(`${label}: net total does not reconcile.`);
  }
  return issues;
}

