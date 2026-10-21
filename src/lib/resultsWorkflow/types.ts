import type { RegattaImportRow } from "@/lib/excel/parseRegattaResultsSheet";

export type ExtractedResultTable = {
  title: string;
  rows: RegattaImportRow[];
  raceCount: number;
  issues: string[];
};
export type ResultsSource = {
  url: string;
  title: string;
  kind: "html" | "pdf";
  sha256: string | null;
  finalLabelSeen: boolean;
  tables: ExtractedResultTable[];
};
export type ResultsScan = {
  checkedAt: string;
  status: "waiting" | "needs_review" | "error";
  sources: ResultsSource[];
  searchedUrls: string[];
  errors: string[];
  pdfCorroboration: "visual_review_required" | "not_found_in_checked_pages";
};
