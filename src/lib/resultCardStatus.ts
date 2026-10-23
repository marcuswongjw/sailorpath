import type { RegattaRecord } from "./ranking";

type ResultSource = Pick<RegattaRecord, "scheduleNotes" | "officialResultsSourceName"> & { name?: string };

/** Publication and import review do not establish an organiser's final result status. */
export function organiserResultStatus(row: ResultSource): "Final" | "Provisional" | "Final status not confirmed" {
  const evidence = `${row.officialResultsSourceName || ""} ${row.scheduleNotes || ""}`;
  if (/\bprovisional\b/i.test(`${row.name || ""} ${evidence}`)) return "Provisional";
  // A final fleet/selection round or a missing final sheet is not a final result.
  if (/\b(?:not|no|unconfirmed|awaiting|pending)\b[^.\n]*\bfinal\b|\bfinal(?:ity| status)?\b[^.\n]*(?:unconfirmed|not confirmed|pending)/i.test(evidence)) return "Final status not confirmed";
  if (/\bfinal(?:ised|ized)\b|\bfinal\s+(?:results?|classification|pdf|score(?:card|sheet)s?)\b|\bresults?(?:\s+are)?\s+final\b|\bsource status:\s*final\b/i.test(evidence)) return "Final";
  return "Final status not confirmed";
}

export function resultSourceStatus(row: ResultSource) {
  return `Organiser: ${organiserResultStatus(row)}`;
}

export function resultCoverageLabel(row: Pick<RegattaRecord, "totalFleetSize" | "importedEntryCount" | "scheduleNotes">) {
  if (row.importedEntryCount == null) return null;
  const missing = row.totalFleetSize - row.importedEntryCount;
  if (missing < 0) return `Coverage check needed: ${row.importedEntryCount} entries shown; recorded source fleet size ${row.totalFleetSize}`;
  if (missing === 0) return `${row.importedEntryCount} entries shown`;
  return `Partial import: ${row.importedEntryCount} of ${row.totalFleetSize} entries shown · ${missing} ${/awaiting identity review/i.test(row.scheduleNotes || "") ? "await identity review" : "not imported"}`;
}
