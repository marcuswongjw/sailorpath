/**
 * SailorPath Asian and Oceania Optimist Index — methodology V1 (Beta) constants.
 *
 * This defines the rolling 12-month methodology (V1 Beta) and candidate event
 * register for Asian and Oceanian Optimist sailors. Figures come from
 * SailorPath's imported official result sheets (starters and verified MNAs)
 * unless a note says otherwise.
 */

export const ASIAN_INDEX_BETA_VERSION = "V1 (Beta)";
export const ASIAN_INDEX_BETA_DRAFT_DATE = "18 October 2026";
export const ASIAN_INDEX_NAME = "SailorPath Asian and Oceania Optimist Index";
export const ASIAN_INDEX_PATH = "/optimist/asian-index";
export const ASIAN_INDEX_METHODOLOGY_PATH = `${ASIAN_INDEX_PATH}/methodology`;

export type AsianIndexGrade = 150 | 75 | 40;

export const ASIAN_INDEX_GRADES: readonly {
  grade: AsianIndexGrade;
  label: string;
  events: string;
  host: string;
  gates: string;
}[] = [
  {
    grade: 150,
    label: "Championship",
    events: "IODA World Championship and official IODA continental fleet-racing championships",
    host: "Anywhere",
    gates: "Official final individual classification; at least 5 completed races",
  },
  {
    grade: 75,
    label: "Major international open",
    events: "Designated major international Optimist opens that meet the published criteria",
    host: "Asia & Oceania by default; a few designated non-regional exceptions",
    gates: "At least 40 valid starters from at least 4 MNAs; at least 4 completed races",
  },
  {
    grade: 40,
    label: "National championship",
    events: "Designated national championships recognised by the national class association or sailing authority",
    host: "Asia & Oceania, and the host MNA's own championship",
    gates: "At least 30 valid starters; at least 4 completed races",
  },
] as const;

export const ASIAN_INDEX_SELECTION_LIMITS: readonly string[] = [
  "At most five results overall.",
  "At most two Grade 150 results.",
  "At most one World Championship result.",
  "At most four Grade 150 and Grade 75 results combined.",
  "At most one Grade 75 result per host MNA jurisdiction.",
  "At most one Grade 40 result per host MNA jurisdiction per calendar year.",
];

export const ASIAN_INDEX_GRADE_75_CRITERIA = {
  registeredSailors: 50,
  verifiedMnas: 4,
  starters: 40,
  completedRaces: 4,
} as const;

export const ASIAN_INDEX_MNA_REGIONS: readonly { region: string; codes: readonly string[] }[] = [
  { region: "East Asia", codes: ["CHN", "HKG", "JPN", "KOR", "PRK", "MAC", "MNG", "TPE"] },
  { region: "South Asia", codes: ["IND", "PAK", "SRI"] },
  {
    region: "Southeast Asia",
    codes: ["BRU", "CAM", "INA", "MAS", "MYA", "PHI", "SGP", "THA", "TLS", "VIE"],
  },
  { region: "Central Asia", codes: ["AZE", "IRI", "KAZ", "KGZ", "UZB"] },
  {
    region: "West Asia",
    codes: ["BRN", "IRQ", "JOR", "KUW", "LIB", "OMA", "PLE", "QAT", "KSA", "UAE"],
  },
  {
    region: "Oceania",
    codes: ["AUS", "NZL", "COK", "FIJ", "GUM", "PNG", "SAM", "VAN", "ASA"],
  },
];

/**
 * Index points for one result: E × (N − P + 1) / N.
 * `place` may be fractional where an official tie is averaged.
 */
export function asianIndexPoints(grade: AsianIndexGrade, starters: number, place: number): number {
  if (!Number.isFinite(starters) || starters < 1) throw new Error("starters must be at least 1");
  if (!Number.isFinite(place) || place < 1 || place > starters) {
    throw new Error("place must be between 1 and the number of starters");
  }
  return (grade * (starters - place + 1)) / starters;
}

export type RegisterCheck = "meets" | "meets_pending_verification" | "unverified" | "open";

export type AsianIndexRegisterEntry = {
  id: string;
  name: string;
  /** Host MNA code used for country caps. */
  host: string;
  dates: string;
  grade: AsianIndexGrade;
  starters: number | null;
  verifiedMnas: number | null;
  races: number | null;
  check: RegisterCheck;
  note: string;
};

/**
 * Proposed register. Every entry is a candidate only: nothing is designated
 * until SailorPath publishes the designation record with its timestamp.
 */
export const ASIAN_INDEX_PROPOSED_REGISTER: readonly AsianIndexRegisterEntry[] = [
  {
    id: "2025-iod-asian-oceanian",
    name: "2025 IODA Asian & Oceanian Championship",
    host: "OMA",
    dates: "25 Oct – 1 Nov 2025 · Mussanah",
    grade: 150,
    starters: 170,
    verifiedMnas: null,
    races: 7,
    check: "meets_pending_verification",
    note: "Baseline candidate. Leaves the 12-month window on its final-race anniversary, expected 1 Nov 2026; final race day to be verified.",
  },
  {
    id: "2026-iod-worlds",
    name: "2026 IODA World Championship",
    host: "MAR",
    dates: "18–28 Jun 2026 · Tangier",
    grade: 150,
    starters: 284,
    verifiedMnas: null,
    races: 12,
    check: "meets",
    note: "Baseline candidate. Counts until 28 Jun 2027. At most one World result per sailor.",
  },
  {
    id: "2026-iod-europeans",
    name: "2026 Optimist European Championship",
    host: "POL",
    dates: "24–31 Jul 2026 · Gdynia",
    grade: 150,
    starters: 292,
    verifiedMnas: null,
    races: 8,
    check: "meets",
    note: "Continental championship candidate scored in separate Boys (170 starters) and Girls (122 starters) premier divisions.",
  },
  {
    id: "2026-iod-asian-oceanian",
    name: "2026 IODA Asian & Oceanian Championship",
    host: "SRI",
    dates: "12–19 Dec 2026 · Colombo",
    grade: 150,
    starters: null,
    verifiedMnas: null,
    races: null,
    check: "open",
    note: "Pending verification. Scores only once the official final classification is confirmed.",
  },
  {
    id: "lirp-2026-gold",
    name: "22nd Langkawi International Regatta Perdana — Optimist Gold",
    host: "MAS",
    dates: "8–12 Feb 2026 · Langkawi",
    grade: 75,
    starters: 59,
    verifiedMnas: 4,
    races: 12,
    check: "meets",
    note: "Meets the criteria with no margin on MNAs (MAS, THA, SGP, TPE). One sailor has no recorded nationality.",
  },
  {
    id: "lysc-2026-gold",
    name: "5th Langkawi International Youth Sailing Championship — Optimist Gold",
    host: "MAS",
    dates: "24–28 Jun 2026 · Langkawi",
    grade: 75,
    starters: 50,
    verifiedMnas: 6,
    races: 10,
    check: "meets",
    note: "Meets the criteria at exactly 50 starters. Same host as LIRP, so only a sailor's better Malaysian Grade 75 result counts.",
  },
  {
    id: "thailand-international-2026",
    name: "Thailand International Sailing Championships — Optimist",
    host: "THA",
    dates: "15–18 Apr 2026 · Sattahip",
    grade: 75,
    starters: 65,
    verifiedMnas: 4,
    races: 12,
    check: "meets_pending_verification",
    note: "Meets the criteria only if all four MNAs hold (THA, MAS, CHN, HKG). Ten entries have no recorded nationality and must be resolved first.",
  },
  {
    id: "sysc-2026-gold",
    name: "Singapore Youth Sailing Championships — Optimist Gold",
    host: "SGP",
    dates: "14–17 Mar 2026 · Singapore",
    grade: 75,
    starters: 106,
    verifiedMnas: 6,
    races: 11,
    check: "meets",
    note: "Proposed as Singapore's Grade 75 open. Singapore's national championship is a separate Grade 40 candidate.",
  },
  {
    id: "hkrw-2026-optimist-main",
    name: "Hong Kong Race Week 2026 — Optimist Main",
    host: "HKG",
    dates: "27 Jan – 1 Feb 2026 · Hong Kong",
    grade: 75,
    starters: 77,
    verifiedMnas: 7,
    races: 9,
    check: "meets",
    note: "Meets criteria with 77 starters across 7 verified MNAs (HKG, CHN, MAC, SGP, THA, GRE, PUR) and 9 completed races.",
  },
  {
    id: "eastern-seaboard-2026",
    name: "Eastern Seaboard Regatta — Optimist",
    host: "THA",
    dates: "29–31 Oct 2026 · Thailand",
    grade: 75,
    starters: null,
    verifiedMnas: null,
    races: null,
    check: "open",
    note: "Open for nomination. Shares the Thailand host cap with the Thailand International.",
  },
  {
    id: "phuket-kings-cup",
    name: "Phuket King's Cup",
    host: "THA",
    dates: "Winter season",
    grade: 75,
    starters: null,
    verifiedMnas: null,
    races: null,
    check: "open",
    note: "Open for nomination. Needs entry-list evidence against the 50-sailor and 4-MNA criteria.",
  },
  {
    id: "mussanah-race-week",
    name: "Mussanah Race Week",
    host: "OMA",
    dates: "Open for nomination",
    grade: 75,
    starters: null,
    verifiedMnas: null,
    races: null,
    check: "open",
    note: "Open for nomination. Needs a Notice of Race and entry evidence.",
  },
  {
    id: "snsc-2026-gold",
    name: "Singapore National Sailing Championships — Optimist Gold",
    host: "SGP",
    dates: "11–13 Sep 2026 · Singapore",
    grade: 40,
    starters: 83,
    verifiedMnas: 7,
    races: 9,
    check: "meets",
    note: "Comfortably meets the Grade 40 gates. Foreign sailors are included in the scored classification.",
  },
  {
    id: "msa-nsc-milo-national-open",
    name: "MSA–NSC–MILO National Open (Overall / U16)",
    host: "MAS",
    dates: "To be confirmed",
    grade: 40,
    starters: null,
    verifiedMnas: null,
    races: null,
    check: "unverified",
    note: "No result data in SailorPath yet. Needs a final classification showing at least 30 starters and 4 races.",
  },
  {
    id: "youth-thailand-national-2026",
    name: "Youth Thailand National Sailing Championship 2026 (Optimist)",
    host: "THA",
    dates: "18–20 Sep 2026 · Sattahip",
    grade: 40,
    starters: 58,
    verifiedMnas: 1,
    races: 3,
    check: "meets",
    note: "Meets Grade 40 criteria with 58 starters. Scored for Asian & Oceania Index.",
  },
  {
    id: "australian-optimist-championship-2026",
    name: "2026 Musto Australian Optimist Championship (Optimist Gold)",
    host: "AUS",
    dates: "8–15 Jan 2026 · Hobart",
    grade: 40,
    starters: 45,
    verifiedMnas: 2,
    races: 11,
    check: "meets",
    note: "Meets Grade 40 criteria with 45 Gold starters and 11 completed races. Scored for Asian & Oceania Index.",
  },
  {
    id: "new-zealand-optimist-championship-2026",
    name: "2026 Toyota New Zealand Optimist National Championship (Optimist Gold)",
    host: "NZL",
    dates: "3–7 Apr 2026 · New Plymouth",
    grade: 40,
    starters: 43,
    verifiedMnas: 1,
    races: 11,
    check: "meets",
    note: "Meets Grade 40 criteria with 43 Gold starters and 11 completed races. Scored for Asian & Oceania Index.",
  },
  {
    id: "other-national-championships",
    name: "Hong Kong, Japan, UAE, Oman and other Asian & Oceanian national championships",
    host: "Various",
    dates: "Open for nomination",
    grade: 40,
    starters: null,
    verifiedMnas: null,
    races: null,
    check: "open",
    note: "Each country nominates its single premier national championship per year.",
  },
];

export const ASIAN_INDEX_CHECK_LABELS: Record<RegisterCheck, string> = {
  meets: "Meets criteria",
  meets_pending_verification: "Meets, to verify",
  unverified: "Unverified",
  open: "Open for nomination",
};
