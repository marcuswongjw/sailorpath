export type { RegattaImportRow } from "@/lib/excel/parseRegattaResultsSheet";
export type { RosterImportRow } from "@/lib/excel/parseRosterSheet";

export type ImportPossibleDuplicate = {
  kind: "within-file" | "vs-db";
  importName: string;
  otherName: string;
  otherId?: string | null;
  similarity: number;
  band: "high" | "medium";
  note: string;
};
