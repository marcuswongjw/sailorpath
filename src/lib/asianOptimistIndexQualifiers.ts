export type AsianOptimistIndexQualifierSource = {
  id: string;
  name: string;
  hostCountry: string;
  startDate: string;
  endDate: string;
  officialResultsUrl: string;
  officialResultsSourceName: string;
  /** Public SailorPath result page after the sheet has been imported. */
  sailorPathRegattaSlug: string | null;
  /** `true` means results are queried from SailorPath's primary result tables. */
  usesSailorPathResults: boolean;
  /** Published fleet size, before the primary data store is available. */
  resultCount: number | null;
  resultStatus: "verified" | "awaiting_final" | "scheduled";
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
    id: "optimist-worlds-2026",
    name: "2026 IODA World Championship",
    hostCountry: "Morocco",
    startDate: "2026-06-18",
    endDate: "2026-06-28",
    officialResultsUrl:
      "https://2026worlds.optiworld.org/en/default/races/race-resultsall",
    officialResultsSourceName:
      "Official World Championship overall classification",
    sailorPathRegattaSlug: "2026-optimist-world-championship",
    usesSailorPathResults: true,
    resultCount: 284,
    resultStatus: "verified",
  },
  {
    id: "optimist-europeans-2026",
    name: "2026 Optimist European Championship",
    hostCountry: "Poland",
    startDate: "2026-07-24",
    endDate: "2026-07-31",
    officialResultsUrl:
      "https://2026europeans.optiworld.org/en/default/races/race-resultsall",
    officialResultsSourceName:
      "Official European Championship Boys and Girls classifications",
    sailorPathRegattaSlug: "2026-optimist-european-championship",
    usesSailorPathResults: true,
    resultCount: 292,
    resultStatus: "verified",
  },
  {
    id: "lysc-2026-optimist-gold",
    name: "5th Langkawi International Youth Sailing Championship — Optimist Gold",
    hostCountry: "Malaysia",
    startDate: "2026-06-24",
    endDate: "2026-06-28",
    officialResultsUrl:
      "https://sailorpath.com/results/the-5th-lysc-2026-optimist-final.pdf",
    officialResultsSourceName:
      "THE 5TH LYSC 2026 _ Optimist.pdf — final results issued 28 June 2026",
    sailorPathRegattaSlug:
      "langkawi-international-youth-sailing-championship-2026-optimist-gold",
    usesSailorPathResults: true,
    resultCount: 50,
    resultStatus: "verified",
  },
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
  {
    id: "hong-kong-race-week-2026-optimist-main",
    name: "Hong Kong Race Week 2026 — Optimist Main",
    hostCountry: "Hong Kong",
    startDate: "2026-01-27",
    endDate: "2026-02-01",
    officialResultsUrl:
      "https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/OptimistMain.htm",
    officialResultsSourceName:
      "Official Optimist Main provisional results — 1 February 2026",
    sailorPathRegattaSlug: "hong-kong-race-week-2026",
    usesSailorPathResults: true,
    resultCount: 77,
    resultStatus: "verified",
  },
  {
    id: "youth-thailand-national-sailing-championship-2026-optimist",
    name: "Youth Thailand National Sailing Championship 2026 — Optimist",
    hostCountry: "Thailand",
    startDate: "2026-09-18",
    endDate: "2026-09-20",
    officialResultsUrl:
      "https://sailingtech.in.th/preview/results/youth-thailand-2026/optimist-overall.html",
    officialResultsSourceName:
      "Official Youth Thailand National Sailing Championship 2026 final result sheet",
    sailorPathRegattaSlug:
      "youth-thailand-national-sailing-championship-2026-optimist",
    usesSailorPathResults: true,
    resultCount: 58,
    resultStatus: "verified",
  },
  {
    id: "2026-musto-australian-optimist-championship-optimist-gold",
    name: "2026 Musto Australian Optimist Championship — Optimist Gold",
    hostCountry: "Australia",
    startDate: "2026-01-08",
    endDate: "2026-01-15",
    officialResultsUrl:
      "https://sailingresults.net/sa/results/overall.aspx?ID=82277.3",
    officialResultsSourceName:
      "Official Australian Optimist Championship Gold final results",
    sailorPathRegattaSlug:
      "2026-musto-australian-optimist-championship-optimist-gold",
    usesSailorPathResults: true,
    resultCount: 45,
    resultStatus: "verified",
  },
  {
    id: "2026-toyota-new-zealand-optimist-national-championship-optimist-gold",
    name: "2026 Toyota New Zealand Optimist National Championship — Optimist Gold",
    hostCountry: "New Zealand",
    startDate: "2026-04-03",
    endDate: "2026-04-07",
    officialResultsUrl:
      "https://www.sailwave.com/results/NPYC/2026%20Toyota%20NZ%20Optimist%20National%20Championships%20-%20Open%20Fleet.htm",
    officialResultsSourceName:
      "Official Toyota NZ Optimist National Championship Gold final results",
    sailorPathRegattaSlug:
      "2026-toyota-new-zealand-optimist-national-championship-optimist-gold",
    usesSailorPathResults: true,
    resultCount: 43,
    resultStatus: "verified",
  },
  {
    id: "eastern-seaboard-regatta-2026",
    name: "Eastern Seaboard Regatta — Optimist",
    hostCountry: "Thailand",
    startDate: "2026-10-29",
    endDate: "2026-10-31",
    officialResultsUrl: "https://www.racingrulesofsailing.org/documents/198658",
    officialResultsSourceName:
      "18th Eastern Seaboard Regatta Notice of Race — final classification pending",
    sailorPathRegattaSlug: null,
    usesSailorPathResults: false,
    resultCount: null,
    resultStatus: "scheduled",
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
