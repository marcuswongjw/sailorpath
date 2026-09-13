import { inferLikelyDnsRows, parseRegattaResultRows } from "./parseRegattaResultsSheet";
import { tableRowsToRecords } from "./parseTabularFile";
import { MAX_IMPORT_ROWS } from "../importLimits";

export type ResultsSheet = { sheet: string; data: readonly (readonly unknown[])[] };

/** Locate result tables, preserving typed values supplied by the Excel reader. */
export function readResultsWorkbook(sheets: readonly ResultsSheet[]) {
  const candidates = [];
  for (const { sheet: sheetName, data } of sheets) {
    const headerIndex = data.slice(0, 50).findIndex((row) =>
      row.some((v) => /^(name|sailor|sailor name|competitor|competitor name|helm name)$/i.test(String(v).trim())) &&
      row.some((v) => /^(rank|pos\.?|place|position|nett?|total|r(?:ace\s*)?\d+)$/i.test(String(v).trim()))
    );
    if (headerIndex < 0) continue;
    const records = tableRowsToRecords(data.slice(headerIndex));
    for (const record of records) {
      for (const [header, value] of Object.entries(record)) {
        if (/^r(?:ace\s*)?\d+$/i.test(header) && value != null && String(value).trim() && !/\d/.test(String(value))) {
          throw new Error(`${sheetName}: ${header} contains “${value}” without points. Include the published numeric penalty (for example, “52 DNS”) before importing.`);
        }
        if (value instanceof Date) record[header] = value.toISOString().slice(0, 10);
      }
    }
    const rows = inferLikelyDnsRows(parseRegattaResultRows(records));
    if (!rows.length) continue;
    if (rows.length > MAX_IMPORT_ROWS) throw new Error(`The sheet has ${rows.length} competitors; maximum ${MAX_IMPORT_ROWS}. Do not split an existing event into replacement uploads.`);
    candidates.push({ sheetName, rows, raceCount: new Set(rows.flatMap((row) => row.races.map((race) => race.raceNumber))).size });
  }
  if (!candidates.length) throw new Error("No results table found. Include a Name and Rank or Nett header within the first 50 rows.");
  return candidates;
}
