export type AsianOptimistIndexQualifierSource = {
  id: string;
  name: string;
  hostCountry: string;
  startDate: string;
  endDate: string;
  officialResultsUrl: string;
  officialResultsSourceName: string;
  /** Public SailorPath result page after the sheet has been imported. */
  sailorPathRegattaSlug: string;
  /** `true` means results are queried from SailorPath's primary result tables. */
  usesSailorPathResults: boolean;
  /** Published fleet size, before the primary data store is available. */
  resultCount: number | null;
  resultStatus: "verified" | "awaiting_final";
};

/**
 * Public, source-backed 2026 qualifier ledger.
 *
 * These records are deliberately not a 2026 points table yet. They identify the
 * two imported external result sheets and the two primary SailorPath results
 * that are ready for a 2026 scoring calculation once the Colombo championship
 * anchor is complete and the published formula is enabled.
 */
export const ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS = [
  {
    id: "langkawi-international-regatta-perdana-2026",
    name: "22nd Langkawi International Regatta Perdana — Optimist Gold",
    hostCountry: "Malaysia",
    startDate: "2026-02-08",
    endDate: "2026-02-12",
    officialResultsUrl:
      "https://drive.google.com/drive/folders/1jmJ5HWFMrOFPxcnMNhN_j-_lyzNJ-0Km?usp=sharing",
    officialResultsSourceName:
      "OPTIMIST.pdf — final results issued 13 February 2026",
    sailorPathRegattaSlug:
      "langkawi-international-regatta-perdana-2026-optimist-gold",
    usesSailorPathResults: false,
    resultCount: 59,
    resultStatus: "verified",
  },
  {
    id: "sysc-2026-gold",
    name: "Singapore Youth Sailing Championships — Optimist Gold",
    hostCountry: "Singapore",
    startDate: "2026-03-14",
    endDate: "2026-03-17",
    officialResultsUrl: "https://www.racingrulesofsailing.org/documents/179732",
    officialResultsSourceName: "Official Optimist Gold final result sheet",
    sailorPathRegattaSlug: "sysc-2026-gold",
    usesSailorPathResults: true,
    resultCount: 106,
    resultStatus: "verified",
  },
  {
    id: "thailand-international-sailing-championships-2026",
    name: "Thailand International Sailing Championships — Optimist",
    hostCountry: "Thailand",
    startDate: "2026-04-15",
    endDate: "2026-04-18",
    officialResultsUrl: "https://www.racingrulesofsailing.org/documents/184140",
    officialResultsSourceName:
      "Optimist Result FinalDay — final results issued 19 April 2026",
    sailorPathRegattaSlug:
      "thailand-international-sailing-championships-2026-optimist",
    usesSailorPathResults: false,
    resultCount: 65,
    resultStatus: "verified",
  },
  {
    id: "snsc-gold-sep-26-2026-09-11",
    name: "Singapore National Sailing Championships — Optimist Gold",
    hostCountry: "Singapore",
    startDate: "2026-09-11",
    endDate: "2026-09-13",
    officialResultsUrl: "https://www.racingrulesofsailing.org/documents/206850",
    officialResultsSourceName: "Official Optimist Gold final result sheet",
    sailorPathRegattaSlug: "singapore-national-sailing-championships-2026-gold",
    usesSailorPathResults: true,
    resultCount: 83,
    resultStatus: "verified",
  },
] as const satisfies readonly AsianOptimistIndexQualifierSource[];

export function formatAsianIndexDateRange(startDate: string, endDate: string): string {
  const start = new Date(`${startDate}T00:00:00Z`);
  const end = new Date(`${endDate}T00:00:00Z`);
  const formatter = new Intl.DateTimeFormat("en-GB", {
    day: "numeric",
    month: "short",
    year: "numeric",
    timeZone: "UTC",
  });

  return startDate === endDate
    ? formatter.format(start)
    : `${formatter.format(start)}–${formatter.format(end)}`;
}
