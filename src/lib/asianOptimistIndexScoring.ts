import {
  ASIAN_OPTIMIST_INDEX_EVENT,
  createAsianOptimistIndexBaseline,
  type AsianOptimistIndexEntry,
} from "@/lib/asianOptimistIndex";
import {
  asianIndexPoints,
  type AsianIndexGrade,
} from "@/lib/asianOptimistIndexBeta";

/**
 * SailorPath Asian and Oceania Optimist Index — V1 (Beta) scoring release.
 *
 * Scored using the official V1 (Beta) rolling 12-month methodology:
 * Points = E * (N - P + 1) / N for each designated event, selecting the sailor's
 * optimal subset of eligible finishes subject to the 6 published selection limits:
 *   1. At most five results overall.
 *   2. At most two Grade 150 results.
 *   3. At most one World Championship result.
 *   4. At most four Grade 150 and Grade 75 results combined.
 *   5. At most one Grade 75 result per host MNA jurisdiction.
 *   6. At most one Grade 40 result per host MNA jurisdiction per calendar year.
 */
export const ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE = {
  version: "V1 (Beta)",
  name: "SailorPath Asian and Oceania Optimist Index",
  cohortEvent: "Verified international and continental championships",
  cohortSize: 176,
  maxResultsCounted: 5,
  maxGrade150: 2,
  maxWorlds: 1,
  maxUpperGrade: 4,
  asOf: "18 October 2026",
} as const;

export type AsianOptimistIndexQualifierTier =
  | "championship"
  | "international"
  | "national";

export type AsianOptimistIndexScoredQualifier = {
  id: string;
  shortName: string;
  hostCountry: string;
  hostMna: string;
  fleetSize: number;
  grade: AsianIndexGrade;
  year: number;
  tier: AsianOptimistIndexQualifierTier;
  isWorlds: boolean;
  scoreCap: number;
};

/**
 * Source-verified input table of qualifying events in the rolling window.
 */
export const ASIAN_OPTIMIST_INDEX_SCORED_QUALIFIERS = {
  "optimist-worlds-2026": {
    id: "optimist-worlds-2026",
    shortName: "2026 Worlds",
    hostCountry: "Morocco",
    hostMna: "MAR",
    fleetSize: 284,
    grade: 150,
    year: 2026,
    tier: "championship",
    isWorlds: true,
    scoreCap: 150,
  },
  "optimist-europeans-2026-boys": {
    id: "optimist-europeans-2026-boys",
    shortName: "2026 Europeans",
    hostCountry: "Poland",
    hostMna: "POL",
    fleetSize: 170,
    grade: 150,
    year: 2026,
    tier: "championship",
    isWorlds: false,
    scoreCap: 150,
  },
  "optimist-europeans-2026-girls": {
    id: "optimist-europeans-2026-girls",
    shortName: "2026 Europeans",
    hostCountry: "Poland",
    hostMna: "POL",
    fleetSize: 122,
    grade: 150,
    year: 2026,
    tier: "championship",
    isWorlds: false,
    scoreCap: 150,
  },
  "lysc-2026-optimist-gold": {
    id: "lysc-2026-optimist-gold",
    shortName: "2026 LYSC",
    hostCountry: "Malaysia",
    hostMna: "MAS",
    fleetSize: 50,
    grade: 75,
    year: 2026,
    tier: "international",
    isWorlds: false,
    scoreCap: 75,
  },
  "langkawi-international-regatta-perdana-2026": {
    id: "langkawi-international-regatta-perdana-2026",
    shortName: "2026 LIRP",
    hostCountry: "Malaysia",
    hostMna: "MAS",
    fleetSize: 59,
    grade: 75,
    year: 2026,
    tier: "international",
    isWorlds: false,
    scoreCap: 75,
  },
  "sysc-2026-gold": {
    id: "sysc-2026-gold",
    shortName: "2026 SYSC",
    hostCountry: "Singapore",
    hostMna: "SGP",
    fleetSize: 106,
    grade: 75,
    year: 2026,
    tier: "international",
    isWorlds: false,
    scoreCap: 75,
  },
  "thailand-international-sailing-championships-2026": {
    id: "thailand-international-sailing-championships-2026",
    shortName: "2026 Thailand Int'l",
    hostCountry: "Thailand",
    hostMna: "THA",
    fleetSize: 65,
    grade: 75,
    year: 2026,
    tier: "international",
    isWorlds: false,
    scoreCap: 75,
  },
  "hong-kong-race-week-2026-optimist-main": {
    id: "hong-kong-race-week-2026-optimist-main",
    shortName: "2026 HKRW",
    hostCountry: "Hong Kong",
    hostMna: "HKG",
    fleetSize: 77,
    grade: 75,
    year: 2026,
    tier: "international",
    isWorlds: false,
    scoreCap: 75,
  },
  "snsc-gold-sep-26-2026-09-11": {
    id: "snsc-gold-sep-26-2026-09-11",
    shortName: "2026 SNSC",
    hostCountry: "Singapore",
    hostMna: "SGP",
    fleetSize: 83,
    grade: 40,
    year: 2026,
    tier: "national",
    isWorlds: false,
    scoreCap: 40,
  },
  "youth-thailand-national-sailing-championship-2026-optimist": {
    id: "youth-thailand-national-sailing-championship-2026-optimist",
    shortName: "2026 Thailand Nationals",
    hostCountry: "Thailand",
    hostMna: "THA",
    fleetSize: 58,
    grade: 40,
    year: 2026,
    tier: "national",
    isWorlds: false,
    scoreCap: 40,
  },
  "2026-musto-australian-optimist-championship-optimist-gold": {
    id: "2026-musto-australian-optimist-championship-optimist-gold",
    shortName: "2026 Australian Nationals",
    hostCountry: "Australia",
    hostMna: "AUS",
    fleetSize: 45,
    grade: 40,
    year: 2026,
    tier: "national",
    isWorlds: false,
    scoreCap: 40,
  },
  "2026-toyota-new-zealand-optimist-national-championship-optimist-gold": {
    id: "2026-toyota-new-zealand-optimist-national-championship-optimist-gold",
    shortName: "2026 NZ Nationals",
    hostCountry: "New Zealand",
    hostMna: "NZL",
    fleetSize: 43,
    grade: 40,
    year: 2026,
    tier: "national",
    isWorlds: false,
    scoreCap: 40,
  },
} as const satisfies Record<string, AsianOptimistIndexScoredQualifier>;

export const ASIAN_OPTIMIST_INDEX_DISPLAY_COLUMNS = [
  // Grade 150 · Championships
  { id: "optimist-worlds-2026", shortName: "2026 Worlds", grade: 150 },
  { id: "optimist-europeans-2026", shortName: "2026 Europeans", grade: 150 },
  // Grade 75 · International Opens
  { id: "hong-kong-race-week-2026-optimist-main", shortName: "2026 HKRW", grade: 75 },
  { id: "lysc-2026-optimist-gold", shortName: "2026 LYSC", grade: 75 },
  { id: "langkawi-international-regatta-perdana-2026", shortName: "2026 LIRP", grade: 75 },
  { id: "sysc-2026-gold", shortName: "2026 SYSC", grade: 75 },
  { id: "thailand-international-sailing-championships-2026", shortName: "2026 Thailand Int'l", grade: 75 },
  // Grade 40 · National Championships
  { id: "snsc-gold-sep-26-2026-09-11", shortName: "2026 SNSC", grade: 40 },
  { id: "youth-thailand-national-sailing-championship-2026-optimist", shortName: "2026 Thailand Nationals", grade: 40 },
  { id: "2026-musto-australian-optimist-championship-optimist-gold", shortName: "2026 Australian Nationals", grade: 40 },
  { id: "2026-toyota-new-zealand-optimist-national-championship-optimist-gold", shortName: "2026 NZ Nationals", grade: 40 },
] as const;


export type AsianOptimistIndexScoredQualifierId =
  keyof typeof ASIAN_OPTIMIST_INDEX_SCORED_QUALIFIERS;

export type AsianOptimistIndexQualifierResultInput = {
  qualifierId: AsianOptimistIndexScoredQualifierId;
  name: string;
  nationality: string;
  rank: number;
};

/**
 * All source-reviewed qualifying finishes for the cohort as at the release date.
 */
export const ASIAN_OPTIMIST_INDEX_PROVISIONAL_QUALIFIER_RESULTS = [
  // 5th LYSC 2026 Gold (Grade 75, N=50)
  {
    qualifierId: "lysc-2026-optimist-gold",
    name: "Yaasin Syahrizan",
    nationality: "MAS",
    rank: 1,
  },
  {
    qualifierId: "lysc-2026-optimist-gold",
    name: "Sitt May Chit Po",
    nationality: "MYA",
    rank: 4,
  },
  {
    qualifierId: "lysc-2026-optimist-gold",
    name: "Khairulilzani Afendy",
    nationality: "MAS",
    rank: 9,
  },
  {
    qualifierId: "lysc-2026-optimist-gold",
    name: "Mia Azrania",
    nationality: "MAS",
    rank: 10,
  },
  {
    qualifierId: "lysc-2026-optimist-gold",
    name: "Lydia Lukman",
    nationality: "MAS",
    rank: 23,
  },
  {
    qualifierId: "lysc-2026-optimist-gold",
    name: "Gon Yee Zaw",
    nationality: "MYA",
    rank: 34,
  },
  {
    qualifierId: "lysc-2026-optimist-gold",
    name: "Nicole Wong Jing Chen",
    nationality: "SGP",
    rank: 35,
  },

  // Langkawi International Regatta Perdana 2026 (Grade 75, N=59)
  {
    qualifierId: "langkawi-international-regatta-perdana-2026",
    name: "Yaasin Syahrizan",
    nationality: "MAS",
    rank: 1,
  },
  {
    qualifierId: "langkawi-international-regatta-perdana-2026",
    name: "Suthinan Nakpasom",
    nationality: "THA",
    rank: 2,
  },
  {
    // Confirmed full/compact identity; official OPTIMIST.pdf, page 1,
    // rank 4, MAS 119. Retain the original cohort name as the scoring key.
    qualifierId: "langkawi-international-regatta-perdana-2026",
    name: "Khairulilzani Afendy",
    nationality: "MAS",
    rank: 4,
  },
  {
    qualifierId: "langkawi-international-regatta-perdana-2026",
    name: "Lydia Lukman",
    nationality: "MAS",
    rank: 9,
  },
  {
    qualifierId: "langkawi-international-regatta-perdana-2026",
    name: "Mia Azrania",
    nationality: "MAS",
    rank: 12,
  },
  {
    qualifierId: "langkawi-international-regatta-perdana-2026",
    name: "Itthichai Tiathongchai",
    nationality: "THA",
    rank: 15,
  },
  {
    qualifierId: "langkawi-international-regatta-perdana-2026",
    name: "PUNTHITA WEROTJANAKUL",
    nationality: "THA",
    rank: 30,
  },

  // Singapore Youth Sailing Championships 2026 (Grade 75, N=106)
  {
    qualifierId: "sysc-2026-gold",
    name: "Wenyu Cheng",
    nationality: "CHN",
    rank: 1,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Ashlyn Tham Yan Lin",
    nationality: "SGP",
    rank: 2,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Anya Zahedi",
    nationality: "SGP",
    rank: 3,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Youjia Xu",
    nationality: "CHN",
    rank: 4,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Sorawit Naksuk",
    nationality: "THA",
    rank: 5,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Rachata Sadtrakulwattana",
    nationality: "THA",
    rank: 6,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Kevin Ho Jun Yi",
    nationality: "SGP",
    rank: 7,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Alyssa Wong",
    nationality: "SGP",
    rank: 9,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Xuan Ya Tong",
    nationality: "KSA",
    rank: 10,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Ethan Lee",
    nationality: "SGP",
    rank: 11,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Pariyaporn Chantarawong",
    nationality: "THA",
    rank: 12,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Elijah Ong",
    nationality: "SGP",
    rank: 13,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Lucas Cao",
    nationality: "SGP",
    rank: 18,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Decimus Chan",
    nationality: "HKG",
    rank: 19,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Ethan Low",
    nationality: "SGP",
    rank: 20,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Surapha Muangngam",
    nationality: "THA",
    rank: 22,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Darian Huang",
    nationality: "SGP",
    rank: 26,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Wang Sun Chen",
    nationality: "MAC",
    rank: 29,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Shringhari Roy",
    nationality: "IND",
    rank: 42,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Nicole Wong Jing Chen",
    nationality: "SGP",
    rank: 43,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Ravi Kumar Benneollu",
    nationality: "IND",
    rank: 46,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Krishna Ramakrishnan",
    nationality: "IND",
    rank: 47,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Rameeza Bh Sk",
    nationality: "IND",
    rank: 48,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "Siddhi Tandon",
    nationality: "IND",
    rank: 90,
  },
  {
    qualifierId: "sysc-2026-gold",
    name: "William Poon",
    nationality: "INA",
    rank: 104,
  },

  // Thailand International Sailing Championships 2026 (Grade 75, N=65)
  {
    qualifierId: "thailand-international-sailing-championships-2026",
    name: "Suthinan Nakpasom",
    nationality: "THA",
    rank: 1,
  },
  {
    qualifierId: "thailand-international-sailing-championships-2026",
    name: "Thawaree Raksapun",
    nationality: "THA",
    rank: 2,
  },
  {
    qualifierId: "thailand-international-sailing-championships-2026",
    name: "Itthichai Tiathongchai",
    nationality: "THA",
    rank: 3,
  },
  {
    qualifierId: "thailand-international-sailing-championships-2026",
    name: "Pakornkiat Chaiya-o-cha",
    nationality: "THA",
    rank: 8,
  },
  {
    qualifierId: "thailand-international-sailing-championships-2026",
    name: "PUNTHITA WEROTJANAKUL",
    nationality: "THA",
    rank: 11,
  },

  // Singapore National Sailing Championships 2026 (Grade 40, N=83)
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Alyssa Wong",
    nationality: "SGP",
    rank: 1,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Ashlyn Tham Yan Lin",
    nationality: "SGP",
    rank: 2,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Kevin Ho Jun Yi",
    nationality: "SGP",
    rank: 5,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Elijah Ong",
    nationality: "SGP",
    rank: 6,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Anya Zahedi",
    nationality: "SGP",
    rank: 7,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Rohan Maliah",
    nationality: "HKG",
    rank: 8,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Darian Huang",
    nationality: "SGP",
    rank: 10,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "William Poon",
    nationality: "INA",
    rank: 16,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Wenyu Cheng",
    nationality: "CHN",
    rank: 18,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Ethan Low",
    nationality: "SGP",
    rank: 22,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Nicole Wong Jing Chen",
    nationality: "SGP",
    rank: 30,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Liu Qi Heng",
    nationality: "HKG",
    rank: 49,
  },
  {
    qualifierId: "snsc-gold-sep-26-2026-09-11",
    name: "Lyric Li Yuxuan",
    nationality: "SGP",
    rank: 81,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Margaux Nguyen-Minh",
    nationality: "HKG",
    rank: 14,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Walter Heeley",
    nationality: "AUS",
    rank: 17,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Kotaro Matsunaga",
    nationality: "JPN",
    rank: 21,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Lucas Cao",
    nationality: "SGP",
    rank: 29,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Jean Luc Herve",
    nationality: "UAE",
    rank: 33,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Kevin Ho Jun Yi",
    nationality: "SGP",
    rank: 79,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Ashlyn Tham Yan Lin",
    nationality: "SGP",
    rank: 83,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Tara Maliah",
    nationality: "HKG",
    rank: 85,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Ethan Lee",
    nationality: "SGP",
    rank: 89,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "William Handley",
    nationality: "NZL",
    rank: 91,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Xuan Ya Tong",
    nationality: "KSA",
    rank: 94,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Natsumi Kubota",
    nationality: "JPN",
    rank: 99,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Nicholas Cooper",
    nationality: "AUS",
    rank: 101,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Soki Higuchi",
    nationality: "JPN",
    rank: 104,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Pariyaporn Chantarawong",
    nationality: "THA",
    rank: 105,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Toby Phillips",
    nationality: "AUS",
    rank: 114,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Jeffrey Chenglin Du",
    nationality: "NZL",
    rank: 123,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Noah Petersen",
    nationality: "NZL",
    rank: 133,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Alix Nguyen-Minh",
    nationality: "HKG",
    rank: 144,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Rohan Maliah",
    nationality: "HKG",
    rank: 147,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Sorawit Naksuk",
    nationality: "THA",
    rank: 149,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Lyric Li Yuxuan",
    nationality: "SGP",
    rank: 154,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Kornelia Pajak",
    nationality: "UAE",
    rank: 160,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Rachata Sadtrakulwattana",
    nationality: "THA",
    rank: 163,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Suthinan Nakpasom",
    nationality: "THA",
    rank: 169,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Jo YAMADA",
    nationality: "JPN",
    rank: 172,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Chantal HENRIKSSON",
    nationality: "HKG",
    rank: 174,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Nana Muranaka",
    nationality: "JPN",
    rank: 176,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Balthazar Roche",
    nationality: "AUS",
    rank: 181,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Surapha Muangngam",
    nationality: "THA",
    rank: 188,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Tom Hall",
    nationality: "NZL",
    rank: 189,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Khalifa Alromaithi",
    nationality: "UAE",
    rank: 190,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Charlie Purt",
    nationality: "AUS",
    rank: 191,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Ally Burfoot",
    nationality: "NZL",
    rank: 195,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Muyu Lu",
    nationality: "MAC",
    rank: 207,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Krishna Ramakrishnan",
    nationality: "IND",
    rank: 219,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Wang Sun Chen",
    nationality: "MAC",
    rank: 225,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Tameem Shams",
    nationality: "QAT",
    rank: 227,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Haren Wickramatillake ",
    nationality: "SRI",
    rank: 228,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Ravi Kumar Benneollu",
    nationality: "IND",
    rank: 229,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Theyab Almheiri",
    nationality: "UAE",
    rank: 242,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Shringhari Roy",
    nationality: "IND",
    rank: 243,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Antony ALDRIN",
    nationality: "IND",
    rank: 246,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Rameeza Bh Sk",
    nationality: "IND",
    rank: 248,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Mohammed Al Qasmi",
    nationality: "OMA",
    rank: 249,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "William Poon",
    nationality: "INA",
    rank: 251,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Zayed Alhosani",
    nationality: "UAE",
    rank: 254,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Khalid Al Sarihi",
    nationality: "OMA",
    rank: 260,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Gianna MAYOR",
    nationality: "PHI",
    rank: 262,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Chi In Jasper Tang",
    nationality: "MAC",
    rank: 265,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Zakareya Bohamad",
    nationality: "KUW",
    rank: 272,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Mohammed Nabil AL-BALUSHI",
    nationality: "OMA",
    rank: 273,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Yunxi Jin",
    nationality: "MAC",
    rank: 274,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Mohammed Al Balushi",
    nationality: "OMA",
    rank: 277,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Mohammed AL-QARTOUBI",
    nationality: "OMA",
    rank: 280,
  },
  {
    qualifierId: "optimist-worlds-2026",
    name: "Saleh ALMETHEN",
    nationality: "KUW",
    rank: 284,
  },
  {
    qualifierId: "optimist-europeans-2026-boys",
    name: "Zac Loader",
    nationality: "NZL",
    rank: 81,
  },
  {
    qualifierId: "optimist-europeans-2026-boys",
    name: "Luca De Giosa",
    nationality: "AUS",
    rank: 86,
  },
  {
    qualifierId: "optimist-europeans-2026-boys",
    name: "Kian Anderson",
    nationality: "HKG",
    rank: 90,
  },
  {
    qualifierId: "optimist-europeans-2026-boys",
    name: "Haruya Hirano",
    nationality: "JPN",
    rank: 95,
  },
  {
    qualifierId: "optimist-europeans-2026-boys",
    name: "Zephyr Lane",
    nationality: "NZL",
    rank: 100,
  },
  {
    qualifierId: "optimist-europeans-2026-boys",
    name: "Genta Naoi",
    nationality: "JPN",
    rank: 103,
  },
  {
    qualifierId: "optimist-europeans-2026-boys",
    name: "Sebastian Tucker",
    nationality: "AUS",
    rank: 107,
  },
  {
    qualifierId: "optimist-europeans-2026-boys",
    name: "Pakornkiat Chaiya-o-cha",
    nationality: "THA",
    rank: 124,
  },
  {
    qualifierId: "optimist-europeans-2026-boys",
    name: "Itthichai Tiathongchai",
    nationality: "THA",
    rank: 125,
  },
  {
    qualifierId: "optimist-europeans-2026-boys",
    name: "Elijah Ong",
    nationality: "SGP",
    rank: 128,
  },
  {
    qualifierId: "optimist-europeans-2026-boys",
    name: "Hansu Tsunomori",
    nationality: "JPN",
    rank: 130,
  },
  {
    qualifierId: "optimist-europeans-2026-boys",
    name: "Liu Qi Heng",
    nationality: "HKG",
    rank: 137,
  },
  {
    qualifierId: "optimist-europeans-2026-boys",
    name: "Decimus Chan",
    nationality: "HKG",
    rank: 140,
  },
  {
    qualifierId: "optimist-europeans-2026-boys",
    name: "Darian Huang",
    nationality: "SGP",
    rank: 153,
  },
  {
    qualifierId: "optimist-europeans-2026-girls",
    name: "Aurora Edhouse",
    nationality: "NZL",
    rank: 20,
  },
  {
    qualifierId: "optimist-europeans-2026-girls",
    name: "Nao Toda",
    nationality: "JPN",
    rank: 25,
  },
  {
    qualifierId: "optimist-europeans-2026-girls",
    name: "Emma Tomkins",
    nationality: "AUS",
    rank: 43,
  },
  {
    qualifierId: "optimist-europeans-2026-girls",
    name: "Sijia Deng",
    nationality: "AUS",
    rank: 48,
  },
  {
    qualifierId: "optimist-europeans-2026-girls",
    name: "Anya Zahedi",
    nationality: "SGP",
    rank: 66,
  },
  {
    qualifierId: "optimist-europeans-2026-girls",
    name: "Thawaree Raksapun",
    nationality: "THA",
    rank: 78,
  },
  {
    qualifierId: "optimist-europeans-2026-girls",
    name: "Claire Bao",
    nationality: "NZL",
    rank: 79,
  },
  {
    qualifierId: "optimist-europeans-2026-girls",
    name: "Nicole Wong Jing Chen",
    nationality: "SGP",
    rank: 83,
  },
  {
    qualifierId: "optimist-europeans-2026-girls",
    name: "PUNTHITA WEROTJANAKUL",
    nationality: "THA",
    rank: 98,
  },
  {
    qualifierId: "optimist-europeans-2026-girls",
    name: "Scarlett Tao",
    nationality: "HKG",
    rank: 109,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Tara Maliah",
    nationality: "HKG",
    rank: 3,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Kevin Ho Jun Yi",
    nationality: "SGP",
    rank: 4,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Rohan Maliah",
    nationality: "HKG",
    rank: 5,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Lucas Cao",
    nationality: "SGP",
    rank: 6,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Alix Nguyen-Minh",
    nationality: "HKG",
    rank: 8,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Decimus Chan",
    nationality: "HKG",
    rank: 9,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Margaux Nguyen-Minh",
    nationality: "HKG",
    rank: 10,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Youjia Xu",
    nationality: "CHN",
    rank: 11,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Lyric Li Yuxuan",
    nationality: "SGP",
    rank: 12,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Chantal HENRIKSSON",
    nationality: "HKG",
    rank: 13,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Alyssa Wong",
    nationality: "SGP",
    rank: 14,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Ethan Lee",
    nationality: "SGP",
    rank: 15,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Ashlyn Tham Yan Lin",
    nationality: "SGP",
    rank: 16,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Elijah Ong",
    nationality: "SGP",
    rank: 18,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Anya Zahedi",
    nationality: "SGP",
    rank: 19,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Zhi Tong Wai",
    nationality: "SGP",
    rank: 20,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Lucien Cohen-Addad",
    nationality: "HKG",
    rank: 21,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Scarlett Tao",
    nationality: "HKG",
    rank: 22,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Kian Anderson",
    nationality: "HKG",
    rank: 24,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Xinran Liu",
    nationality: "HKG",
    rank: 28,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Shiteng Huang",
    nationality: "CHN",
    rank: 30,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Muyu Lu",
    nationality: "MAC",
    rank: 31,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Liu Qi Heng",
    nationality: "HKG",
    rank: 32,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Chi In Jasper Tang",
    nationality: "MAC",
    rank: 62,
  },
  {
    qualifierId: "hong-kong-race-week-2026-optimist-main",
    name: "Yunxi Jin",
    nationality: "MAC",
    rank: 65,
  },
  // Youth Thailand National Sailing Championship 2026 (Grade 40, N=58)
  {
    qualifierId: "youth-thailand-national-sailing-championship-2026-optimist",
    name: "Rachata Sadtrakulwattana",
    nationality: "THA",
    rank: 1,
  },
  {
    qualifierId: "youth-thailand-national-sailing-championship-2026-optimist",
    name: "Sorawit Naksuk",
    nationality: "THA",
    rank: 2,
  },
  {
    qualifierId: "youth-thailand-national-sailing-championship-2026-optimist",
    name: "Pariyaporn Chantarawong",
    nationality: "THA",
    rank: 4,
  },
  {
    qualifierId: "youth-thailand-national-sailing-championship-2026-optimist",
    name: "Suthinan Nakpasom",
    nationality: "THA",
    rank: 5,
  },
  {
    qualifierId: "youth-thailand-national-sailing-championship-2026-optimist",
    name: "Surapha Muangngam",
    nationality: "THA",
    rank: 6,
  },
  {
    qualifierId: "youth-thailand-national-sailing-championship-2026-optimist",
    name: "Itthichai Tiathongchai",
    nationality: "THA",
    rank: 9,
  },
  {
    qualifierId: "youth-thailand-national-sailing-championship-2026-optimist",
    name: "Thawaree Raksapun",
    nationality: "THA",
    rank: 11,
  },
  {
    qualifierId: "youth-thailand-national-sailing-championship-2026-optimist",
    name: "Pakornkiat Chaiya-o-cha",
    nationality: "THA",
    rank: 17,
  },
  // 2026 Musto Australian Optimist Championship (Grade 40, N=45)
  {
    qualifierId: "2026-musto-australian-optimist-championship-optimist-gold",
    name: "Walter Heeley",
    nationality: "AUS",
    rank: 1,
  },
  {
    qualifierId: "2026-musto-australian-optimist-championship-optimist-gold",
    name: "Nicholas Cooper",
    nationality: "AUS",
    rank: 2,
  },
  {
    qualifierId: "2026-musto-australian-optimist-championship-optimist-gold",
    name: "Toby Phillips",
    nationality: "AUS",
    rank: 4,
  },
  {
    qualifierId: "2026-musto-australian-optimist-championship-optimist-gold",
    name: "Balthazar Roche",
    nationality: "AUS",
    rank: 5,
  },
  {
    qualifierId: "2026-musto-australian-optimist-championship-optimist-gold",
    name: "Charlie Purt",
    nationality: "AUS",
    rank: 6,
  },
  {
    qualifierId: "2026-musto-australian-optimist-championship-optimist-gold",
    name: "Sebastian Tucker",
    nationality: "AUS",
    rank: 7,
  },
  {
    qualifierId: "2026-musto-australian-optimist-championship-optimist-gold",
    name: "Luca De Giosa",
    nationality: "AUS",
    rank: 8,
  },
  {
    qualifierId: "2026-musto-australian-optimist-championship-optimist-gold",
    name: "Sijia Deng",
    nationality: "AUS",
    rank: 12,
  },
  {
    qualifierId: "2026-musto-australian-optimist-championship-optimist-gold",
    name: "Emma Tomkins",
    nationality: "AUS",
    rank: 13,
  },
  {
    qualifierId: "2026-musto-australian-optimist-championship-optimist-gold",
    name: "William Harris",
    nationality: "AUS",
    rank: 18,
  },
  {
    qualifierId: "2026-musto-australian-optimist-championship-optimist-gold",
    name: "Zachary Tait",
    nationality: "AUS",
    rank: 23,
  },
  {
    qualifierId: "2026-musto-australian-optimist-championship-optimist-gold",
    name: "Kirra Howell",
    nationality: "AUS",
    rank: 24,
  },
  {
    qualifierId: "2026-musto-australian-optimist-championship-optimist-gold",
    name: "Emerald Jacobsen",
    nationality: "AUS",
    rank: 30,
  },
  // 2026 Toyota New Zealand Optimist National Championship (Grade 40, N=43)
  {
    qualifierId: "2026-toyota-new-zealand-optimist-national-championship-optimist-gold",
    name: "Ally Burfoot",
    nationality: "NZL",
    rank: 4,
  },
  {
    qualifierId: "2026-toyota-new-zealand-optimist-national-championship-optimist-gold",
    name: "William Handley",
    nationality: "NZL",
    rank: 5,
  },
  {
    qualifierId: "2026-toyota-new-zealand-optimist-national-championship-optimist-gold",
    name: "Jeffrey Chenglin Du",
    nationality: "NZL",
    rank: 6,
  },
  {
    qualifierId: "2026-toyota-new-zealand-optimist-national-championship-optimist-gold",
    name: "Tom Hall",
    nationality: "NZL",
    rank: 7,
  },
  {
    qualifierId: "2026-toyota-new-zealand-optimist-national-championship-optimist-gold",
    name: "Noah Petersen",
    nationality: "NZL",
    rank: 10,
  },
  {
    qualifierId: "2026-toyota-new-zealand-optimist-national-championship-optimist-gold",
    name: "Aurora Edhouse",
    nationality: "NZL",
    rank: 11,
  },
  {
    qualifierId: "2026-toyota-new-zealand-optimist-national-championship-optimist-gold",
    name: "Zac Loader",
    nationality: "NZL",
    rank: 16,
  },
  {
    qualifierId: "2026-toyota-new-zealand-optimist-national-championship-optimist-gold",
    name: "Zephyr Lane",
    nationality: "NZL",
    rank: 18,
  },
  {
    qualifierId: "2026-toyota-new-zealand-optimist-national-championship-optimist-gold",
    name: "Harry Strang",
    nationality: "NZL",
    rank: 21,
  },
  {
    qualifierId: "2026-toyota-new-zealand-optimist-national-championship-optimist-gold",
    name: "Holly Robson",
    nationality: "NZL",
    rank: 31,
  },
  {
    qualifierId: "2026-toyota-new-zealand-optimist-national-championship-optimist-gold",
    name: "Claire Bao",
    nationality: "NZL",
    rank: 38,
  },
] as const satisfies readonly AsianOptimistIndexQualifierResultInput[];

export type AsianOptimistIndexQualifierScore = {
  qualifier: AsianOptimistIndexScoredQualifier;
  rank: number;
  points: number;
  counted: boolean;
  dropReason?: string;
  /** Backwards compatibility field matching raw points */
  rawScore: number;
  /** Backwards compatibility field matching raw points */
  cappedScore: number;
  /** Backwards compatibility field matching counted points contribution */
  pointsContribution: number;
};

export type AsianOptimistIndexProvisionalEntry = AsianOptimistIndexEntry & {
  provisionalRank: number;
  /** The score is rounded to 2 decimal places for public display; rank uses exact points. */
  provisionalScore: number;
  championshipScore: number;
  championshipPoints: number;
  qualifierPoints: number;
  eligibleStarts: number;
  countedResultsCount: number;
  hostCountryCount: number;
  /** Every verified qualifying finish, shown as a rank in the public table. */
  qualifierResults: AsianOptimistIndexQualifierScore[];
  /** The subset of qualifierResults that contributes to the current score. */
  scoredQualifiers: AsianOptimistIndexQualifierScore[];
};

function identityKey(name: string, nationality: string): string {
  return `${nationality.toUpperCase()}:${name.toLowerCase().replace(/[^a-z0-9]/g, "")}`;
}

function roundScore(value: number): number {
  return Math.round(value * 100) / 100;
}

/**
 * Normalised finish percentage helper preserved for backwards compatibility.
 */
export function normalisedFleetScore(rank: number, fleetSize: number): number {
  if (!Number.isInteger(rank) || !Number.isInteger(fleetSize) || fleetSize < 2) {
    throw new Error("A scored result needs a valid rank and a fleet of at least two sailors.");
  }
  if (rank < 1 || rank > fleetSize) {
    throw new Error("A scored result rank must be inside the final fleet.");
  }

  return (100 * (fleetSize - rank)) / (fleetSize - 1);
}

type CandidateScoredResult = {
  id: string;
  name: string;
  shortName: string;
  grade: AsianIndexGrade;
  starters: number;
  rank: number;
  points: number;
  hostMna: string;
  hostCountry: string;
  year: number;
  isWorlds: boolean;
  qualifierScore?: AsianOptimistIndexQualifierScore;
};

/**
 * Check whether a subset of results satisfies the 6 V1 (Beta) selection limits:
 *   1. <= 5 results overall.
 *   2. <= 2 Grade 150 results.
 *   3. <= 1 World Championship result.
 *   4. <= 4 Grade 150 and Grade 75 results combined.
 *   5. At most 1 Grade 75 result per host MNA.
 *   6. At most 1 Grade 40 result per host MNA per calendar year.
 */
function isValidSubset(subset: CandidateScoredResult[]): boolean {
  if (subset.length > 5) return false;

  const g150 = subset.filter((r) => r.grade === 150).length;
  if (g150 > 2) return false;

  const worlds = subset.filter((r) => r.isWorlds).length;
  if (worlds > 1) return false;

  const upper = subset.filter((r) => r.grade === 150 || r.grade === 75).length;
  if (upper > 4) return false;

  const g75Hosts = new Set<string>();
  for (const r of subset) {
    if (r.grade === 75) {
      if (g75Hosts.has(r.hostMna)) return false;
      g75Hosts.add(r.hostMna);
    }
  }

  const g40HostYears = new Set<string>();
  for (const r of subset) {
    if (r.grade === 40) {
      const key = `${r.hostMna}:${r.year}`;
      if (g40HostYears.has(key)) return false;
      g40HostYears.add(key);
    }
  }

  return true;
}

/**
 * Finds the subset of candidate results that maximizes total points while
 * strictly honoring the 6 selection rules.
 */
function selectOptimalResults(results: CandidateScoredResult[]): CandidateScoredResult[] {
  let bestSubset: CandidateScoredResult[] = [];
  let bestSum = -1;

  function backtrack(idx: number, current: CandidateScoredResult[]) {
    if (isValidSubset(current)) {
      const sum = current.reduce((s, r) => s + r.points, 0);
      if (sum > bestSum) {
        bestSum = sum;
        bestSubset = [...current];
      }
    } else {
      return;
    }

    for (let i = idx; i < results.length; i++) {
      current.push(results[i]);
      backtrack(i + 1, current);
      current.pop();
    }
  }

  backtrack(0, []);
  return bestSubset;
}

/**
 * Calculate the fixed-cohort V1 (Beta) standings.
 *
 * Scored using the official V1 (Beta) points formula:
 *   Points = E * (N - P + 1) / N
 * Optimal combination of up to 5 best results subject to event-grade and host-country caps.
 */
export function createAsianOptimistIndexProvisionalEntries(
  baseline: AsianOptimistIndexEntry[] = createAsianOptimistIndexBaseline(),
  qualifierInputs: readonly AsianOptimistIndexQualifierResultInput[] =
    ASIAN_OPTIMIST_INDEX_PROVISIONAL_QUALIFIER_RESULTS
): AsianOptimistIndexProvisionalEntry[] {
  const qualifiersBySailor = new Map<string, AsianOptimistIndexQualifierScore[]>();

  for (const input of qualifierInputs) {
    const qualifier = ASIAN_OPTIMIST_INDEX_SCORED_QUALIFIERS[input.qualifierId];
    const points = asianIndexPoints(qualifier.grade, qualifier.fleetSize, input.rank);
    const score: AsianOptimistIndexQualifierScore = {
      qualifier,
      rank: input.rank,
      points,
      counted: false,
      rawScore: points,
      cappedScore: points,
      pointsContribution: 0,
    };
    const key = identityKey(input.name, input.nationality);
    qualifiersBySailor.set(key, [...(qualifiersBySailor.get(key) ?? []), score]);
  }

  const scored = baseline.map((entry) => {
    const anchorPoints = entry.overallPlace != null
      ? asianIndexPoints(
          150,
          ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize,
          entry.overallPlace
        )
      : 0;

    const anchorCandidate: CandidateScoredResult | null = entry.overallPlace != null
      ? {
          id: "2025-iod-asian-oceanian",
          name: entry.name,
          shortName: "2025 Asians",
          grade: 150,
          starters: ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize,
          rank: entry.overallPlace,
          points: anchorPoints,
          hostMna: "OMA",
          hostCountry: "Oman",
          year: 2025,
          isWorlds: false,
        }
      : null;

    const sailorKey = identityKey(entry.name, entry.nationality);
    const sailorQualifiers = qualifiersBySailor.get(sailorKey) ?? [];

    const qualifierCandidates: CandidateScoredResult[] = sailorQualifiers.map((q) => ({
      id: q.qualifier.id,
      name: entry.name,
      shortName: q.qualifier.shortName,
      grade: q.qualifier.grade,
      starters: q.qualifier.fleetSize,
      rank: q.rank,
      points: q.points,
      hostMna: q.qualifier.hostMna,
      hostCountry: q.qualifier.hostCountry,
      year: q.qualifier.year,
      isWorlds: q.qualifier.isWorlds,
      qualifierScore: q,
    }));

    const allCandidates = [
      ...(anchorCandidate ? [anchorCandidate] : []),
      ...qualifierCandidates,
    ];
    const optimalSubset = selectOptimalResults(allCandidates);
    const optimalIds = new Set(optimalSubset.map((r) => r.id));

    // Mark counted status on qualifier results
    const markedQualifiers: AsianOptimistIndexQualifierScore[] = sailorQualifiers.map((q) => {
      const isCounted = optimalIds.has(q.qualifier.id);
      return {
        ...q,
        counted: isCounted,
        pointsContribution: isCounted ? q.points : 0,
        dropReason: isCounted
          ? undefined
          : `Dropped by V1 (Beta) selection limits (e.g. host cap or optimal combination limit)`,
      };
    });

    const championshipCandidates = optimalSubset.filter((r) => r.grade === 150);
    const championshipPoints = championshipCandidates.reduce((sum, r) => sum + r.points, 0);

    const scoredQualifiers = markedQualifiers.filter((q) => q.counted);
    const qualifierPoints = optimalSubset
      .filter((r) => r.grade !== 150)
      .reduce((sum, r) => sum + r.points, 0);

    const preciseScore = optimalSubset.reduce((sum, r) => sum + r.points, 0);

    // Distinct host countries across scored results
    const hostCountryCount = new Set(optimalSubset.map((r) => r.hostCountry)).size;

    return {
      ...entry,
      provisionalRank: 0,
      provisionalScore: roundScore(preciseScore),
      championshipScore: roundScore(championshipPoints),
      championshipPoints: roundScore(championshipPoints),
      qualifierPoints: roundScore(qualifierPoints),
      eligibleStarts: allCandidates.length,
      countedResultsCount: optimalSubset.length,
      hostCountryCount,
      qualifierResults: [...markedQualifiers].sort(
        (a, b) =>
          a.qualifier.id.localeCompare(b.qualifier.id) ||
          a.rank - b.rank
      ),
      scoredQualifiers,
      preciseScore,
    };
  });

  scored.sort(
    (a, b) =>
      b.preciseScore - a.preciseScore ||
      b.championshipPoints - a.championshipPoints ||
      (a.overallPlace ?? 999) - (b.overallPlace ?? 999) ||
      a.name.localeCompare(b.name)
  );

  return scored.map((entry, index) => {
    const { preciseScore, ...publicEntry } = entry;
    void preciseScore;
    return { ...publicEntry, provisionalRank: index + 1 };
  });
}
