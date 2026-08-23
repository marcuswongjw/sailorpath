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

export type RegattaImportDiscrepancy = {
  kind:
    | "metadata"
    | "sailor-added"
    | "sailor-removed"
    | "result"
    | "race-added"
    | "race-removed"
    | "race-changed";
  sailorName?: string | null;
  field: string;
  before: string | number | null;
  after: string | number | null;
};

export type RegattaImportReview = {
  reviewToken: string;
  regattaId: string;
  regattaName: string;
  uploadedName: string;
  discrepancies: RegattaImportDiscrepancy[];
  truncated: boolean;
  summary: {
    addedSailors: number;
    removedSailors: number;
    changedResults: number;
    addedRaces: number;
    removedRaces: number;
    changedRaces: number;
    metadataChanges: number;
  };
};
