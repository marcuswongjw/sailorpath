import type { RegattaRecord } from "./ranking";

/** Publication on SailorPath does not prove the organiser marked a source final. */
export function resultSourceStatus(row: Pick<RegattaRecord, "scheduleNotes" | "officialResultsSourceName">) {
  const evidence = `${row.officialResultsSourceName || ""} ${row.scheduleNotes || ""}`;
  if (/\bprovisional\b/i.test(evidence)) return "Provisional source";
  if (/\bfinal(?:ised|ized)?(?:\s+results?)?\b/i.test(evidence)) return "Final source";
  return "Published · source finality unconfirmed";
}

export function resultCoverageLabel(row: Pick<RegattaRecord, "totalFleetSize" | "importedEntryCount" | "scheduleNotes">) {
  if (row.importedEntryCount == null) return null;
  const missing = row.totalFleetSize - row.importedEntryCount;
  if (missing <= 0) return `${row.importedEntryCount} entries shown`;
  return `Partial import: ${row.importedEntryCount} of ${row.totalFleetSize} entries shown · ${missing} ${/awaiting identity review/i.test(row.scheduleNotes || "") ? "await identity review" : "not imported"}`;
}
