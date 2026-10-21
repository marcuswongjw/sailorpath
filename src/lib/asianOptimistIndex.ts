import {
  ASIAN_OPTIMIST_INDEX_PROFILE_MANIFEST,
  type AsianOptimistIndexProfileManifestEntry,
} from "@/lib/asianOptimistIndexProfileManifest";
import {
  ASIAN_OPTIMIST_INDEX_DUPLICATE_REVIEWS,
  type AsianOptimistIndexDuplicateReview,
} from "@/lib/asianOptimistIndexDuplicateReviews";

/**
 * First-release source data for the SailorPath Asian and Oceania Optimist Index.
 *
 * Transcribed from the official 2025 IODA Asian & Oceanian Championship
 * final overall-result PDF, after page-image reconciliation. Entries cover
 * Asian and Oceanian national authorities represented in the final results.
 */

export type AsianOptimistIndexGender = "M" | "W";

export type AsianOptimistIndexSourceEntry = {
  overallPlace: number | null;
  sailNumber: string;
  /** Name exactly as displayed in the official final result, normalized to Given Surname order. */
  name: string;
  /** Original result-sheet name for source reconciliation. */
  sourceName: string;
  nationality: string;
  country: string;
  gender: AsianOptimistIndexGender;
  totalPoints: number | null;
  netPoints: number | null;
};

export type AsianOptimistIndexEntry = AsianOptimistIndexSourceEntry & {
  /** Stable 2025 cohort identity key used for profile and review linkage. */
  identityKey: string;
  /** Rank inside the Asian and Oceania baseline. */
  baselineRank: number;
  /** SailorPath profile name when it is more complete than the source sheet. */
  displayName: string;
  /** Present only when a matching SailorPath profile explicitly permits it. */
  birthYear: number | null;
  /** Existing SailorPath public profile, if a high-confidence match exists. */
  profileHref: string | null;
  /** Conservative profile-data review flag; it never changes results or rank. */
  profileReview: AsianOptimistIndexDuplicateReview | null;
};

export const ASIAN_OPTIMIST_INDEX_SOURCE_URL =
  "https://2025asianoceanians.optiworld.org/en/default/races/race-resultsall";

export const ASIAN_OPTIMIST_INDEX_SOURCE_PDF_URL =
  "https://scoring.sailti.com/public/download/overall-datetime-pdf/9799/1/20251031173911";

export const ASIAN_OPTIMIST_INDEX_EVENT = {
  name: "2025 Optimist Asian & Oceanian Championship",
  venue: "Mussanah, Oman",
  dates: "25 October–1 November 2025",
  totalFleetSize: 170,
  raceCount: 7,
  entries: 136,
  countries: 19,
} as const;

export const ASIAN_OPTIMIST_INDEX_SOURCE_ENTRIES =
[
  {
    "overallPlace": 1,
    "sailNumber": "THA 1493",
    "sourceName": "NAKSUK, Sorawit",
    "name": "Sorawit Naksuk",
    "nationality": "THA",
    "country": "Thailand",
    "gender": "M",
    "totalPoints": 23,
    "netPoints": 13
  },
  {
    "overallPlace": 2,
    "sailNumber": "SGP 121",
    "sourceName": "CHIA, Ethan",
    "name": "Ethan Chia",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "M",
    "totalPoints": 28,
    "netPoints": 17
  },
  {
    "overallPlace": 4,
    "sailNumber": "SGP 159",
    "sourceName": "ZAHEDI, Anya",
    "name": "Anya Zahedi",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "W",
    "totalPoints": 45,
    "netPoints": 20
  },
  {
    "overallPlace": 5,
    "sailNumber": "UAE 70",
    "sourceName": "HERVE, Jean Luc",
    "name": "Jean Luc Herve",
    "nationality": "UAE",
    "country": "United Arab Emirates",
    "gender": "M",
    "totalPoints": 79,
    "netPoints": 21
  },
  {
    "overallPlace": 6,
    "sailNumber": "CHN 5001",
    "sourceName": "LI, Yuxuan",
    "name": "Yuxuan Li",
    "nationality": "CHN",
    "country": "China",
    "gender": "W",
    "totalPoints": 68,
    "netPoints": 29
  },
  {
    "overallPlace": 8,
    "sailNumber": "UAE 42",
    "sourceName": "ALROMAITHI, Khalifa",
    "name": "Khalifa Alromaithi",
    "nationality": "UAE",
    "country": "United Arab Emirates",
    "gender": "M",
    "totalPoints": 73,
    "netPoints": 41
  },
  {
    "overallPlace": 9,
    "sailNumber": "IND 1632",
    "sourceName": "LAKSHMINARAYANAN, Shreya",
    "name": "Shreya Lakshminarayanan",
    "nationality": "IND",
    "country": "India",
    "gender": "W",
    "totalPoints": 96,
    "netPoints": 44
  },
  {
    "overallPlace": 11,
    "sailNumber": "HKG 183",
    "sourceName": "NGUYEN-MINH, Margaux",
    "name": "Margaux Nguyen-Minh",
    "nationality": "HKG",
    "country": "Hong Kong",
    "gender": "W",
    "totalPoints": 68,
    "netPoints": 46
  },
  {
    "overallPlace": 13,
    "sailNumber": "SGP 165",
    "sourceName": "LEE, Desiree",
    "name": "Desiree Lee",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "W",
    "totalPoints": 105,
    "netPoints": 49
  },
  {
    "overallPlace": 14,
    "sailNumber": "HKG 185",
    "sourceName": "NGUYEN-MINH, Alix",
    "name": "Alix Nguyen-Minh",
    "nationality": "HKG",
    "country": "Hong Kong",
    "gender": "W",
    "totalPoints": 68,
    "netPoints": 53
  },
  {
    "overallPlace": 15,
    "sailNumber": "JPN 3356",
    "sourceName": "MURANAKA, Riko",
    "name": "Riko Muranaka",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "W",
    "totalPoints": 82,
    "netPoints": 59
  },
  {
    "overallPlace": 16,
    "sailNumber": "THA 1945",
    "sourceName": "EIN, Adison",
    "name": "Adison Ein",
    "nationality": "THA",
    "country": "Thailand",
    "gender": "M",
    "totalPoints": 81,
    "netPoints": 60
  },
  {
    "overallPlace": 17,
    "sailNumber": "THA 1963",
    "sourceName": "SADTRAKULWATTANA, Rachata",
    "name": "Rachata Sadtrakulwattana",
    "nationality": "THA",
    "country": "Thailand",
    "gender": "M",
    "totalPoints": 116,
    "netPoints": 62
  },
  {
    "overallPlace": 18,
    "sailNumber": "HKG 173",
    "sourceName": "MALIAH, Rohan",
    "name": "Rohan Maliah",
    "nationality": "HKG",
    "country": "Hong Kong",
    "gender": "M",
    "totalPoints": 89,
    "netPoints": 62
  },
  {
    "overallPlace": 19,
    "sailNumber": "SGP 151",
    "sourceName": "NG, Mikaela",
    "name": "Mikaela Ng",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "W",
    "totalPoints": 112,
    "netPoints": 67
  },
  {
    "overallPlace": 20,
    "sailNumber": "SGP 142",
    "sourceName": "KUM, Sean",
    "name": "Sean Kum",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "M",
    "totalPoints": 106,
    "netPoints": 68
  },
  {
    "overallPlace": 21,
    "sailNumber": "SGP 150",
    "sourceName": "WONG, Alyssa",
    "name": "Alyssa Wong",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "W",
    "totalPoints": 108,
    "netPoints": 69
  },
  {
    "overallPlace": 22,
    "sailNumber": "MAS 111",
    "sourceName": "AZWAN, Muaz",
    "name": "Muaz Azwan",
    "nationality": "MAS",
    "country": "Malaysia",
    "gender": "M",
    "totalPoints": 94,
    "netPoints": 74
  },
  {
    "overallPlace": 23,
    "sailNumber": "CHN 5031",
    "sourceName": "ZHANG, Bocheng",
    "name": "Bocheng Zhang",
    "nationality": "CHN",
    "country": "China",
    "gender": "M",
    "totalPoints": 105,
    "netPoints": 75
  },
  {
    "overallPlace": 24,
    "sailNumber": "MAS 115",
    "sourceName": "SYAHRIZAN, Yaasin",
    "name": "Yaasin Syahrizan",
    "nationality": "MAS",
    "country": "Malaysia",
    "gender": "M",
    "totalPoints": 97,
    "netPoints": 76
  },
  {
    "overallPlace": 25,
    "sailNumber": "HKG 190",
    "sourceName": "MALIAH, Tara",
    "name": "Tara Maliah",
    "nationality": "HKG",
    "country": "Hong Kong",
    "gender": "W",
    "totalPoints": 130,
    "netPoints": 79
  },
  {
    "overallPlace": 26,
    "sailNumber": "SGP 149",
    "sourceName": "CAO, Lucas",
    "name": "Lucas Cao",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "M",
    "totalPoints": 103,
    "netPoints": 79
  },
  {
    "overallPlace": 28,
    "sailNumber": "CHN 5021",
    "sourceName": "HUANG, Shiteng",
    "name": "Shiteng Huang",
    "nationality": "CHN",
    "country": "China",
    "gender": "M",
    "totalPoints": 112,
    "netPoints": 84
  },
  {
    "overallPlace": 29,
    "sailNumber": "KSA 107",
    "sourceName": "TONG, Xuan Ya",
    "name": "Xuan Ya Tong",
    "nationality": "KSA",
    "country": "Saudi Arabia",
    "gender": "W",
    "totalPoints": 134,
    "netPoints": 88
  },
  {
    "overallPlace": 30,
    "sailNumber": "AUS 1932",
    "sourceName": "HARRIS, William",
    "name": "William Harris",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "M",
    "totalPoints": 139,
    "netPoints": 88
  },
  {
    "overallPlace": 31,
    "sailNumber": "SGP 78",
    "sourceName": "LOW, Ethan",
    "name": "Ethan Low",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "M",
    "totalPoints": 141,
    "netPoints": 89
  },
  {
    "overallPlace": 32,
    "sailNumber": "CHN 5016",
    "sourceName": "XU, Youjia",
    "name": "Youjia Xu",
    "nationality": "CHN",
    "country": "China",
    "gender": "M",
    "totalPoints": 139,
    "netPoints": 90
  },
  {
    "overallPlace": 34,
    "sailNumber": "THA 1253",
    "sourceName": "JAREONPON , Pailin",
    "name": "Pailin Jareonpon ",
    "nationality": "THA",
    "country": "Thailand",
    "gender": "W",
    "totalPoints": 150,
    "netPoints": 93
  },
  {
    "overallPlace": 37,
    "sailNumber": "SGP 122",
    "sourceName": "WAN, Zeph",
    "name": "Zeph Wan",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "M",
    "totalPoints": 126,
    "netPoints": 97
  },
  {
    "overallPlace": 39,
    "sailNumber": "CHN 5018",
    "sourceName": "NI, Yijia",
    "name": "Yijia Ni",
    "nationality": "CHN",
    "country": "China",
    "gender": "W",
    "totalPoints": 142,
    "netPoints": 98
  },
  {
    "overallPlace": 40,
    "sailNumber": "AUS 1931",
    "sourceName": "ROCHE, Balthazar",
    "name": "Balthazar Roche",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "M",
    "totalPoints": 160,
    "netPoints": 102
  },
  {
    "overallPlace": 41,
    "sailNumber": "SGP 164",
    "sourceName": "PEE, Teckwoon",
    "name": "Teckwoon Pee",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "M",
    "totalPoints": 161,
    "netPoints": 103
  },
  {
    "overallPlace": 42,
    "sailNumber": "OMA 313",
    "sourceName": "AL QASMI, Mohammed",
    "name": "Mohammed Al Qasmi",
    "nationality": "OMA",
    "country": "Oman",
    "gender": "M",
    "totalPoints": 150,
    "netPoints": 105
  },
  {
    "overallPlace": 43,
    "sailNumber": "OMA 314",
    "sourceName": "AL SARIHI, Khalid",
    "name": "Khalid Al Sarihi",
    "nationality": "OMA",
    "country": "Oman",
    "gender": "M",
    "totalPoints": 144,
    "netPoints": 112
  },
  {
    "overallPlace": 45,
    "sailNumber": "MYA 113",
    "sourceName": "CHIT PO, Sitt May",
    "name": "Sitt May Chit Po",
    "nationality": "MYA",
    "country": "Myanmar",
    "gender": "W",
    "totalPoints": 165,
    "netPoints": 116
  },
  {
    "overallPlace": 46,
    "sailNumber": "MYA 117",
    "sourceName": "MAUNG, Aung Sitt",
    "name": "Aung Sitt Maung",
    "nationality": "MYA",
    "country": "Myanmar",
    "gender": "M",
    "totalPoints": 176,
    "netPoints": 118
  },
  {
    "overallPlace": 47,
    "sailNumber": "SGP 157",
    "sourceName": "WAI, Zhi Tong",
    "name": "Zhi Tong Wai",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "W",
    "totalPoints": 170,
    "netPoints": 122
  },
  {
    "overallPlace": 48,
    "sailNumber": "OMA 321",
    "sourceName": "AL MESHAIKHI, Khamis",
    "name": "Khamis Al Meshaikhi",
    "nationality": "OMA",
    "country": "Oman",
    "gender": "M",
    "totalPoints": 180,
    "netPoints": 122
  },
  {
    "overallPlace": 49,
    "sailNumber": "JPN 3462",
    "sourceName": "KAWAKAMI, Nagisa",
    "name": "Nagisa Kawakami",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "W",
    "totalPoints": 171,
    "netPoints": 129
  },
  {
    "overallPlace": 50,
    "sailNumber": "JPN 3378",
    "sourceName": "KAHARA, Kento",
    "name": "Kento Kahara",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "M",
    "totalPoints": 185,
    "netPoints": 132
  },
  {
    "overallPlace": 51,
    "sailNumber": "JPN 3351",
    "sourceName": "MATSUNAGA, Kotaro",
    "name": "Kotaro Matsunaga",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "M",
    "totalPoints": 185,
    "netPoints": 137
  },
  {
    "overallPlace": 52,
    "sailNumber": "CHN 5051",
    "sourceName": "CHENG, Wenyu",
    "name": "Wenyu Cheng",
    "nationality": "CHN",
    "country": "China",
    "gender": "W",
    "totalPoints": 197,
    "netPoints": 139
  },
  {
    "overallPlace": 54,
    "sailNumber": "THA 1987",
    "sourceName": "NAKPASOM, Suthinan",
    "name": "Suthinan Nakpasom",
    "nationality": "THA",
    "country": "Thailand",
    "gender": "M",
    "totalPoints": 202,
    "netPoints": 144
  },
  {
    "overallPlace": 55,
    "sailNumber": "JPN 3411",
    "sourceName": "HIRASAWA, Kaito",
    "name": "Kaito Hirasawa",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "M",
    "totalPoints": 201,
    "netPoints": 148
  },
  {
    "overallPlace": 56,
    "sailNumber": "HKG 187",
    "sourceName": "LIU, Xinran",
    "name": "Xinran Liu",
    "nationality": "HKG",
    "country": "Hong Kong",
    "gender": "W",
    "totalPoints": 207,
    "netPoints": 149
  },
  {
    "overallPlace": 58,
    "sailNumber": "UAE 30",
    "sourceName": "PAJAK, Kornelia",
    "name": "Kornelia Pajak",
    "nationality": "UAE",
    "country": "United Arab Emirates",
    "gender": "W",
    "totalPoints": 112,
    "netPoints": 76
  },
  {
    "overallPlace": 61,
    "sailNumber": "JPN 3440",
    "sourceName": "KAMIJO, Masahiro",
    "name": "Masahiro Kamijo",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "M",
    "totalPoints": 127,
    "netPoints": 93
  },
  {
    "overallPlace": 62,
    "sailNumber": "NZL 4675",
    "sourceName": "DU, Jeffrey Chenglin",
    "name": "Jeffrey Chenglin Du",
    "nationality": "NZL",
    "country": "New Zealand",
    "gender": "M",
    "totalPoints": 123,
    "netPoints": 99
  },
  {
    "overallPlace": 66,
    "sailNumber": "HKG 162",
    "sourceName": "ANDERSON, Kian",
    "name": "Kian Anderson",
    "nationality": "HKG",
    "country": "Hong Kong",
    "gender": "M",
    "totalPoints": 173,
    "netPoints": 115
  },
  {
    "overallPlace": 67,
    "sailNumber": "QAT 41",
    "sourceName": "KAZIMIERCZYK, Eryk",
    "name": "Eryk Kazimierczyk",
    "nationality": "QAT",
    "country": "Qatar",
    "gender": "M",
    "totalPoints": 153,
    "netPoints": 119
  },
  {
    "overallPlace": 68,
    "sailNumber": "MAC 20",
    "sourceName": "CHEN, Wang Sun",
    "name": "Wang Sun Chen",
    "nationality": "MAC",
    "country": "Macau",
    "gender": "M",
    "totalPoints": 178,
    "netPoints": 120
  },
  {
    "overallPlace": 70,
    "sailNumber": "NZL 4561",
    "sourceName": "LANE, Zephyr",
    "name": "Zephyr Lane",
    "nationality": "NZL",
    "country": "New Zealand",
    "gender": "M",
    "totalPoints": 162,
    "netPoints": 122
  },
  {
    "overallPlace": 71,
    "sailNumber": "CHN 5008",
    "sourceName": "ZHANG, Guanghao",
    "name": "Guanghao Zhang",
    "nationality": "CHN",
    "country": "China",
    "gender": "M",
    "totalPoints": 157,
    "netPoints": 126
  },
  {
    "overallPlace": 72,
    "sailNumber": "MAS 119",
    "sourceName": "AFENDY, Khairulilzani",
    "name": "Khairulilzani Afendy",
    "nationality": "MAS",
    "country": "Malaysia",
    "gender": "M",
    "totalPoints": 162,
    "netPoints": 132
  },
  {
    "overallPlace": 73,
    "sailNumber": "UAE 40",
    "sourceName": "ALHOSANI, Zayed",
    "name": "Zayed Alhosani",
    "nationality": "UAE",
    "country": "United Arab Emirates",
    "gender": "M",
    "totalPoints": 173,
    "netPoints": 134
  },
  {
    "overallPlace": 74,
    "sailNumber": "KUW 56",
    "sourceName": "ALMASOUD, Hamad",
    "name": "Hamad Almasoud",
    "nationality": "KUW",
    "country": "Kuwait",
    "gender": "M",
    "totalPoints": 193,
    "netPoints": 135
  },
  {
    "overallPlace": 75,
    "sailNumber": "IND 1644",
    "sourceName": "BENNEOLLU, Ravi Kumar",
    "name": "Ravi Kumar Benneollu",
    "nationality": "IND",
    "country": "India",
    "gender": "M",
    "totalPoints": 180,
    "netPoints": 141
  },
  {
    "overallPlace": 76,
    "sailNumber": "NZL 4819",
    "sourceName": "STRANG, Harry",
    "name": "Harry Strang",
    "nationality": "NZL",
    "country": "New Zealand",
    "gender": "M",
    "totalPoints": 189,
    "netPoints": 142
  },
  {
    "overallPlace": 79,
    "sailNumber": "SRI 397",
    "sourceName": "WICKRAMATILLAKE , Haren",
    "name": "Haren Wickramatillake ",
    "nationality": "SRI",
    "country": "Sri Lanka",
    "gender": "M",
    "totalPoints": 208,
    "netPoints": 152
  },
  {
    "overallPlace": 81,
    "sailNumber": "IND 1639",
    "sourceName": "RAMAKRISHNAN, Krishna",
    "name": "Krishna Ramakrishnan",
    "nationality": "IND",
    "country": "India",
    "gender": "M",
    "totalPoints": 189,
    "netPoints": 153
  },
  {
    "overallPlace": 82,
    "sailNumber": "MAS 112",
    "sourceName": "LUKMAN, Lydia",
    "name": "Lydia Lukman",
    "nationality": "MAS",
    "country": "Malaysia",
    "gender": "W",
    "totalPoints": 209,
    "netPoints": 154
  },
  {
    "overallPlace": 84,
    "sailNumber": "AUS 1743",
    "sourceName": "TAIT, Zachary",
    "name": "Zachary Tait",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "M",
    "totalPoints": 191,
    "netPoints": 158
  },
  {
    "overallPlace": 85,
    "sailNumber": "CHN 5006",
    "sourceName": "SHI, Lin",
    "name": "Lin Shi",
    "nationality": "CHN",
    "country": "China",
    "gender": "M",
    "totalPoints": 217,
    "netPoints": 159
  },
  {
    "overallPlace": 86,
    "sailNumber": "UAE 3",
    "sourceName": "ALMHEIRI, Hamad",
    "name": "Hamad Almheiri",
    "nationality": "UAE",
    "country": "United Arab Emirates",
    "gender": "M",
    "totalPoints": 209,
    "netPoints": 163
  },
  {
    "overallPlace": 88,
    "sailNumber": "AZE 50",
    "sourceName": "MUSTAFAYEV, Furkan",
    "name": "Furkan Mustafayev",
    "nationality": "AZE",
    "country": "Azerbaijan",
    "gender": "M",
    "totalPoints": 222,
    "netPoints": 164
  },
  {
    "overallPlace": 90,
    "sailNumber": "OMA 311",
    "sourceName": "AL FOORI, Al Khaili",
    "name": "Al Khaili Al Foori",
    "nationality": "OMA",
    "country": "Oman",
    "gender": "M",
    "totalPoints": 217,
    "netPoints": 169
  },
  {
    "overallPlace": 91,
    "sailNumber": "MAS 114",
    "sourceName": "AZRANIA, Mia",
    "name": "Mia Azrania",
    "nationality": "MAS",
    "country": "Malaysia",
    "gender": "W",
    "totalPoints": 220,
    "netPoints": 172
  },
  {
    "overallPlace": 93,
    "sailNumber": "KSA 99",
    "sourceName": "AL-SHAMMARI, Ahmed",
    "name": "Ahmed Al-Shammari",
    "nationality": "KSA",
    "country": "Saudi Arabia",
    "gender": "M",
    "totalPoints": 218,
    "netPoints": 176
  },
  {
    "overallPlace": 97,
    "sailNumber": "AZE 27",
    "sourceName": "BASIRLI, Kamal",
    "name": "Kamal Basirli",
    "nationality": "AZE",
    "country": "Azerbaijan",
    "gender": "M",
    "totalPoints": 238,
    "netPoints": 180
  },
  {
    "overallPlace": 98,
    "sailNumber": "AUS 1845",
    "sourceName": "JACOBSEN, Hiro",
    "name": "Hiro Jacobsen",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "M",
    "totalPoints": 234,
    "netPoints": 186
  },
  {
    "overallPlace": 99,
    "sailNumber": "IND 1633",
    "sourceName": "BONGUR, Banny",
    "name": "Banny Bongur",
    "nationality": "IND",
    "country": "India",
    "gender": "M",
    "totalPoints": 245,
    "netPoints": 187
  },
  {
    "overallPlace": 100,
    "sailNumber": "MAS 110",
    "sourceName": "ISMAIL, Zahir",
    "name": "Zahir Ismail",
    "nationality": "MAS",
    "country": "Malaysia",
    "gender": "M",
    "totalPoints": 251,
    "netPoints": 193
  },
  {
    "overallPlace": 101,
    "sailNumber": "OMA 322",
    "sourceName": "AL MUSHAIFRI, Hadeel",
    "name": "Hadeel Al Mushaifri",
    "nationality": "OMA",
    "country": "Oman",
    "gender": "W",
    "totalPoints": 251,
    "netPoints": 193
  },
  {
    "overallPlace": 102,
    "sailNumber": "NZL 4530",
    "sourceName": "ROBSON, Holly",
    "name": "Holly Robson",
    "nationality": "NZL",
    "country": "New Zealand",
    "gender": "W",
    "totalPoints": 244,
    "netPoints": 194
  },
  {
    "overallPlace": 103,
    "sailNumber": "JPN 3375",
    "sourceName": "KUBOTA, Natsumi",
    "name": "Natsumi Kubota",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "W",
    "totalPoints": 245,
    "netPoints": 196
  },
  {
    "overallPlace": 105,
    "sailNumber": "HKG 170",
    "sourceName": "TAO, Scarlett",
    "name": "Scarlett Tao",
    "nationality": "HKG",
    "country": "Hong Kong",
    "gender": "W",
    "totalPoints": 263,
    "netPoints": 205
  },
  {
    "overallPlace": 107,
    "sailNumber": "UAE 50",
    "sourceName": "PAJAK, Konstancja",
    "name": "Konstancja Pajak",
    "nationality": "UAE",
    "country": "United Arab Emirates",
    "gender": "W",
    "totalPoints": 258,
    "netPoints": 207
  },
  {
    "overallPlace": 109,
    "sailNumber": "THA 1988",
    "sourceName": "POONPAT, Pattarakorn",
    "name": "Pattarakorn Poonpat",
    "nationality": "THA",
    "country": "Thailand",
    "gender": "M",
    "totalPoints": 266,
    "netPoints": 208
  },
  {
    "overallPlace": 110,
    "sailNumber": "HKG 180",
    "sourceName": "HWANG, Keira Caitlin",
    "name": "Keira Caitlin Hwang",
    "nationality": "HKG",
    "country": "Hong Kong",
    "gender": "W",
    "totalPoints": 260,
    "netPoints": 208
  },
  {
    "overallPlace": 111,
    "sailNumber": "HKG 174",
    "sourceName": "COHEN-ADDAD, Lucien",
    "name": "Lucien Cohen-Addad",
    "nationality": "HKG",
    "country": "Hong Kong",
    "gender": "M",
    "totalPoints": 273,
    "netPoints": 216
  },
  {
    "overallPlace": 112,
    "sailNumber": "AUS 1720",
    "sourceName": "DENG, Sijia",
    "name": "Sijia Deng",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "W",
    "totalPoints": 278,
    "netPoints": 220
  },
  {
    "overallPlace": 113,
    "sailNumber": "MYA 383",
    "sourceName": "ZAW, Gon Yee",
    "name": "Gon Yee Zaw",
    "nationality": "MYA",
    "country": "Myanmar",
    "gender": "W",
    "totalPoints": 278,
    "netPoints": 223
  },
  {
    "overallPlace": 114,
    "sailNumber": "KUW 51",
    "sourceName": "BOHAMAD, Zakareya",
    "name": "Zakareya Bohamad",
    "nationality": "KUW",
    "country": "Kuwait",
    "gender": "M",
    "totalPoints": 290,
    "netPoints": 234
  },
  {
    "overallPlace": 115,
    "sailNumber": "JPN 3443",
    "sourceName": "HIGUCHI, Soki",
    "name": "Soki Higuchi",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "M",
    "totalPoints": 198,
    "netPoints": 140
  },
  {
    "overallPlace": 116,
    "sailNumber": "JPN 3389",
    "sourceName": "NAKAMURA, Kaito",
    "name": "Kaito Nakamura",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "M",
    "totalPoints": 213,
    "netPoints": 155
  },
  {
    "overallPlace": 117,
    "sailNumber": "OMA 323",
    "sourceName": "AL HASANI, Tarteel",
    "name": "Tarteel Al Hasani",
    "nationality": "OMA",
    "country": "Oman",
    "gender": "W",
    "totalPoints": 215,
    "netPoints": 157
  },
  {
    "overallPlace": 118,
    "sailNumber": "MAC 21",
    "sourceName": "LU, Muyu",
    "name": "Muyu Lu",
    "nationality": "MAC",
    "country": "Macau",
    "gender": "M",
    "totalPoints": 201,
    "netPoints": 159
  },
  {
    "overallPlace": 119,
    "sailNumber": "UAE 38",
    "sourceName": "ALMHEIRI, Theyab",
    "name": "Theyab Almheiri",
    "nationality": "UAE",
    "country": "United Arab Emirates",
    "gender": "M",
    "totalPoints": 228,
    "netPoints": 170
  },
  {
    "overallPlace": 120,
    "sailNumber": "MAC 23",
    "sourceName": "JIN, Yunxi",
    "name": "Yunxi Jin",
    "nationality": "MAC",
    "country": "Macau",
    "gender": "W",
    "totalPoints": 218,
    "netPoints": 172
  },
  {
    "overallPlace": 121,
    "sailNumber": "CHN 5012",
    "sourceName": "DONG, Yuntian",
    "name": "Yuntian Dong",
    "nationality": "CHN",
    "country": "China",
    "gender": "M",
    "totalPoints": 234,
    "netPoints": 176
  },
  {
    "overallPlace": 123,
    "sailNumber": "MYA 289",
    "sourceName": "AUNG, Naing Linn",
    "name": "Naing Linn Aung",
    "nationality": "MYA",
    "country": "Myanmar",
    "gender": "M",
    "totalPoints": 239,
    "netPoints": 181
  },
  {
    "overallPlace": 124,
    "sailNumber": "MYA 346",
    "sourceName": "MYAT, Aung Kaung",
    "name": "Aung Kaung Myat",
    "nationality": "MYA",
    "country": "Myanmar",
    "gender": "M",
    "totalPoints": 229,
    "netPoints": 183
  },
  {
    "overallPlace": 126,
    "sailNumber": "AZE 52",
    "sourceName": "HASANLI, Yagmur",
    "name": "Yagmur Hasanli",
    "nationality": "AZE",
    "country": "Azerbaijan",
    "gender": "W",
    "totalPoints": 243,
    "netPoints": 189
  },
  {
    "overallPlace": 127,
    "sailNumber": "IND 1770",
    "sourceName": "ROY, Shringhari",
    "name": "Shringhari Roy",
    "nationality": "IND",
    "country": "India",
    "gender": "W",
    "totalPoints": 249,
    "netPoints": 191
  },
  {
    "overallPlace": 128,
    "sailNumber": "JPN 3431",
    "sourceName": "MATSUOKA, Tadanao",
    "name": "Tadanao Matsuoka",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "M",
    "totalPoints": 247,
    "netPoints": 197
  },
  {
    "overallPlace": 129,
    "sailNumber": "OMA 305",
    "sourceName": "AL BALUSHI, Mohammed",
    "name": "Mohammed Al Balushi",
    "nationality": "OMA",
    "country": "Oman",
    "gender": "M",
    "totalPoints": 243,
    "netPoints": 198
  },
  {
    "overallPlace": 130,
    "sailNumber": "OMA 320",
    "sourceName": "AL NOFLI, Hood",
    "name": "Hood Al Nofli",
    "nationality": "OMA",
    "country": "Oman",
    "gender": "M",
    "totalPoints": 252,
    "netPoints": 200
  },
  {
    "overallPlace": 131,
    "sailNumber": "QAT 47",
    "sourceName": "SHAMS, Tameem",
    "name": "Tameem Shams",
    "nationality": "QAT",
    "country": "Qatar",
    "gender": "M",
    "totalPoints": 240,
    "netPoints": 200
  },
  {
    "overallPlace": 132,
    "sailNumber": "KUW 52",
    "sourceName": "ALMANSOUR, Abdulaziz",
    "name": "Abdulaziz Almansour",
    "nationality": "KUW",
    "country": "Kuwait",
    "gender": "M",
    "totalPoints": 262,
    "netPoints": 205
  },
  {
    "overallPlace": 133,
    "sailNumber": "AZE 49",
    "sourceName": "MAMMADZADA, Mikayil",
    "name": "Mikayil Mammadzada",
    "nationality": "AZE",
    "country": "Azerbaijan",
    "gender": "M",
    "totalPoints": 264,
    "netPoints": 206
  },
  {
    "overallPlace": 134,
    "sailNumber": "HKG 192",
    "sourceName": "CHAN, Decimus",
    "name": "Decimus Chan",
    "nationality": "HKG",
    "country": "Hong Kong",
    "gender": "M",
    "totalPoints": 264,
    "netPoints": 207
  },
  {
    "overallPlace": 135,
    "sailNumber": "IND 1642",
    "sourceName": "TELUGU, Karthik",
    "name": "Karthik Telugu",
    "nationality": "IND",
    "country": "India",
    "gender": "M",
    "totalPoints": 255,
    "netPoints": 207
  },
  {
    "overallPlace": 136,
    "sailNumber": "KOR 590",
    "sourceName": "JEON, Hyunwoo",
    "name": "Hyunwoo Jeon",
    "nationality": "KOR",
    "country": "South Korea",
    "gender": "M",
    "totalPoints": 265,
    "netPoints": 207
  },
  {
    "overallPlace": 137,
    "sailNumber": "AUS 1846",
    "sourceName": "JACOBSEN, Emerald",
    "name": "Emerald Jacobsen",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "W",
    "totalPoints": 255,
    "netPoints": 208
  },
  {
    "overallPlace": 139,
    "sailNumber": "IND 1681",
    "sourceName": "TANDON, Siddhi",
    "name": "Siddhi Tandon",
    "nationality": "IND",
    "country": "India",
    "gender": "W",
    "totalPoints": 265,
    "netPoints": 212
  },
  {
    "overallPlace": 140,
    "sailNumber": "KSA 101",
    "sourceName": "ALHWAIL, Mohammed",
    "name": "Mohammed Alhwail",
    "nationality": "KSA",
    "country": "Saudi Arabia",
    "gender": "M",
    "totalPoints": 268,
    "netPoints": 213
  },
  {
    "overallPlace": 141,
    "sailNumber": "IND 1712",
    "sourceName": "TATTARI, Chandralekha",
    "name": "Chandralekha Tattari",
    "nationality": "IND",
    "country": "India",
    "gender": "W",
    "totalPoints": 269,
    "netPoints": 217
  },
  {
    "overallPlace": 142,
    "sailNumber": "OMA 310",
    "sourceName": "AL HUSSAINI, Habib",
    "name": "Habib Al Hussaini",
    "nationality": "OMA",
    "country": "Oman",
    "gender": "M",
    "totalPoints": 280,
    "netPoints": 222
  },
  {
    "overallPlace": 143,
    "sailNumber": "AUS 1879",
    "sourceName": "STEEL, Ruben",
    "name": "Ruben Steel",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "M",
    "totalPoints": 273,
    "netPoints": 224
  },
  {
    "overallPlace": 144,
    "sailNumber": "AZE 51",
    "sourceName": "HASANOVA, Kamilla",
    "name": "Kamilla Hasanova",
    "nationality": "AZE",
    "country": "Azerbaijan",
    "gender": "W",
    "totalPoints": 290,
    "netPoints": 234
  },
  {
    "overallPlace": 145,
    "sailNumber": "MYA 193",
    "sourceName": "THAW, Khant Zin",
    "name": "Khant Zin Thaw",
    "nationality": "MYA",
    "country": "Myanmar",
    "gender": "M",
    "totalPoints": 287,
    "netPoints": 234
  },
  {
    "overallPlace": 146,
    "sailNumber": "AUS 1820",
    "sourceName": "WILKINSON, Ethan",
    "name": "Ethan Wilkinson",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "M",
    "totalPoints": 289,
    "netPoints": 236
  },
  {
    "overallPlace": 147,
    "sailNumber": "MAC 22",
    "sourceName": "TANG, Chi In Jasper",
    "name": "Chi In Jasper Tang",
    "nationality": "MAC",
    "country": "Macau",
    "gender": "M",
    "totalPoints": 288,
    "netPoints": 236
  },
  {
    "overallPlace": 148,
    "sailNumber": "QAT 42",
    "sourceName": "AL MAHMOUD, Abdulaziz",
    "name": "Abdulaziz Al Mahmoud",
    "nationality": "QAT",
    "country": "Qatar",
    "gender": "M",
    "totalPoints": 301,
    "netPoints": 243
  },
  {
    "overallPlace": 149,
    "sailNumber": "SRI 201",
    "sourceName": "PERERA, Dhiren Aven",
    "name": "Dhiren Aven Perera",
    "nationality": "SRI",
    "country": "Sri Lanka",
    "gender": "M",
    "totalPoints": 298,
    "netPoints": 246
  },
  {
    "overallPlace": 150,
    "sailNumber": "IND 1411",
    "sourceName": "NIRUDU, Badrinath",
    "name": "Badrinath Nirudu",
    "nationality": "IND",
    "country": "India",
    "gender": "M",
    "totalPoints": 300,
    "netPoints": 247
  },
  {
    "overallPlace": 151,
    "sailNumber": "SRI 250",
    "sourceName": "ANEEQ, Luqmaan",
    "name": "Luqmaan Aneeq",
    "nationality": "SRI",
    "country": "Sri Lanka",
    "gender": "M",
    "totalPoints": 302,
    "netPoints": 247
  },
  {
    "overallPlace": 152,
    "sailNumber": "AUS 1882",
    "sourceName": "HOWELL, Kirra",
    "name": "Kirra Howell",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "W",
    "totalPoints": 301,
    "netPoints": 248
  },
  {
    "overallPlace": 153,
    "sailNumber": "KOR 523",
    "sourceName": "CHOI, Unho",
    "name": "Unho Choi",
    "nationality": "KOR",
    "country": "South Korea",
    "gender": "M",
    "totalPoints": 308,
    "netPoints": 252
  },
  {
    "overallPlace": 154,
    "sailNumber": "SRI 224",
    "sourceName": "PERERA, Binal",
    "name": "Binal Perera",
    "nationality": "SRI",
    "country": "Sri Lanka",
    "gender": "M",
    "totalPoints": 307,
    "netPoints": 252
  },
  {
    "overallPlace": 155,
    "sailNumber": "SRI 202",
    "sourceName": "KARUNARATNE, Mckaella",
    "name": "Mckaella Karunaratne",
    "nationality": "SRI",
    "country": "Sri Lanka",
    "gender": "W",
    "totalPoints": 305,
    "netPoints": 255
  },
  {
    "overallPlace": 156,
    "sailNumber": "KOR 480",
    "sourceName": "KIM, Hyeonsol",
    "name": "Hyeonsol Kim",
    "nationality": "KOR",
    "country": "South Korea",
    "gender": "M",
    "totalPoints": 308,
    "netPoints": 256
  },
  {
    "overallPlace": 157,
    "sailNumber": "KOR 584",
    "sourceName": "PARK, Daol",
    "name": "Daol Park",
    "nationality": "KOR",
    "country": "South Korea",
    "gender": "W",
    "totalPoints": 314,
    "netPoints": 260
  },
  {
    "overallPlace": 158,
    "sailNumber": "IND 1716",
    "sourceName": "SK, Rameeza Bh",
    "name": "Rameeza Bh Sk",
    "nationality": "IND",
    "country": "India",
    "gender": "W",
    "totalPoints": 321,
    "netPoints": 271
  },
  {
    "overallPlace": 159,
    "sailNumber": "KOR 589",
    "sourceName": "AN, Siyeon",
    "name": "Siyeon An",
    "nationality": "KOR",
    "country": "South Korea",
    "gender": "W",
    "totalPoints": 331,
    "netPoints": 274
  },
  {
    "overallPlace": 160,
    "sailNumber": "SRI 208",
    "sourceName": "UBAYASIRI, Akaine",
    "name": "Akaine Ubayasiri",
    "nationality": "SRI",
    "country": "Sri Lanka",
    "gender": "M",
    "totalPoints": 330,
    "netPoints": 277
  },
  {
    "overallPlace": 161,
    "sailNumber": "SRI 207",
    "sourceName": "FERNANDO, Shem",
    "name": "Shem Fernando",
    "nationality": "SRI",
    "country": "Sri Lanka",
    "gender": "M",
    "totalPoints": 336,
    "netPoints": 278
  },
  {
    "overallPlace": 162,
    "sailNumber": "AUS 1781",
    "sourceName": "TOMKINS, Emma",
    "name": "Emma Tomkins",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "W",
    "totalPoints": 338,
    "netPoints": 280
  },
  {
    "overallPlace": 163,
    "sailNumber": "OMA 306",
    "sourceName": "AL RUZAIQI, Layan",
    "name": "Layan Al Ruzaiqi",
    "nationality": "OMA",
    "country": "Oman",
    "gender": "W",
    "totalPoints": 343,
    "netPoints": 287
  },
  {
    "overallPlace": 164,
    "sailNumber": "KOR 580",
    "sourceName": "CHANG, Minkwan",
    "name": "Minkwan Chang",
    "nationality": "KOR",
    "country": "South Korea",
    "gender": "M",
    "totalPoints": 348,
    "netPoints": 294
  },
  {
    "overallPlace": 165,
    "sailNumber": "QAT 43",
    "sourceName": "AL YAFEI, Khalifa",
    "name": "Khalifa Al Yafei",
    "nationality": "QAT",
    "country": "Qatar",
    "gender": "M",
    "totalPoints": 353,
    "netPoints": 295
  },
  {
    "overallPlace": 166,
    "sailNumber": "SRI 206",
    "sourceName": "HAZARI, Laila",
    "name": "Laila Hazari",
    "nationality": "SRI",
    "country": "Sri Lanka",
    "gender": "W",
    "totalPoints": 356,
    "netPoints": 298
  },
  {
    "overallPlace": 167,
    "sailNumber": "KOR 562",
    "sourceName": "KIM, Jihoo",
    "name": "Jihoo Kim",
    "nationality": "KOR",
    "country": "South Korea",
    "gender": "W",
    "totalPoints": 358,
    "netPoints": 302
  },
  {
    "overallPlace": 168,
    "sailNumber": "KSA 105",
    "sourceName": "ALFORAIH, Abdulaziz",
    "name": "Abdulaziz Alforaih",
    "nationality": "KSA",
    "country": "Saudi Arabia",
    "gender": "M",
    "totalPoints": 363,
    "netPoints": 305
  },
  {
    "overallPlace": 169,
    "sailNumber": "KOR 586",
    "sourceName": "AN, Seoyi",
    "name": "Seoyi An",
    "nationality": "KOR",
    "country": "South Korea",
    "gender": "W",
    "totalPoints": 369,
    "netPoints": 312
  },
  {
    "overallPlace": 170,
    "sailNumber": "SRI 203",
    "sourceName": "RAJAPAKSA, Ruwaneka",
    "name": "Ruwaneka Rajapaksa",
    "nationality": "SRI",
    "country": "Sri Lanka",
    "gender": "M",
    "totalPoints": 378,
    "netPoints": 320
  },
  {
    "overallPlace": null,
    "sailNumber": "AUS 1575",
    "sourceName": "Walter Heeley",
    "name": "Walter Heeley",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "SGP 171",
    "sourceName": "Kevin Ho Jun Yi",
    "name": "Kevin Ho Jun Yi",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "SGP 100",
    "sourceName": "Ashlyn Tham Yan Lin",
    "name": "Ashlyn Tham Yan Lin",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "W",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "SGP 83",
    "sourceName": "Ethan Lee",
    "name": "Ethan Lee",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "NZL 4818",
    "sourceName": "William Handley",
    "name": "William Handley",
    "nationality": "NZL",
    "country": "New Zealand",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "AUS 1635",
    "sourceName": "Nicholas Cooper",
    "name": "Nicholas Cooper",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "THA 1223",
    "sourceName": "Pariyaporn Chantarawong",
    "name": "Pariyaporn Chantarawong",
    "nationality": "THA",
    "country": "Thailand",
    "gender": "W",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "AUS 1906",
    "sourceName": "Toby Phillips",
    "name": "Toby Phillips",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "NZL 4592",
    "sourceName": "Noah Petersen",
    "name": "Noah Petersen",
    "nationality": "NZL",
    "country": "New Zealand",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "SGP 154",
    "sourceName": "Lyric Li Yuxuan",
    "name": "Lyric Li Yuxuan",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "W",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "JPN 3394",
    "sourceName": "Jo YAMADA",
    "name": "Jo YAMADA",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "HKG 163",
    "sourceName": "Chantal HENRIKSSON",
    "name": "Chantal HENRIKSSON",
    "nationality": "HKG",
    "country": "Hong Kong",
    "gender": "W",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "JPN 3356",
    "sourceName": "Nana Muranaka",
    "name": "Nana Muranaka",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "W",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "THA 1941",
    "sourceName": "Surapha Muangngam",
    "name": "Surapha Muangngam",
    "nationality": "THA",
    "country": "Thailand",
    "gender": "W",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "NZL 4684",
    "sourceName": "Tom Hall",
    "name": "Tom Hall",
    "nationality": "NZL",
    "country": "New Zealand",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "AUS 1203",
    "sourceName": "Charlie Purt",
    "name": "Charlie Purt",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "NZL 4825",
    "sourceName": "Ally Burfoot",
    "name": "Ally Burfoot",
    "nationality": "NZL",
    "country": "New Zealand",
    "gender": "W",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "IND 1820",
    "sourceName": "Antony ALDRIN",
    "name": "Antony ALDRIN",
    "nationality": "IND",
    "country": "India",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "INA 21",
    "sourceName": "William Poon",
    "name": "William Poon",
    "nationality": "INA",
    "country": "Indonesia",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "PHI 8",
    "sourceName": "Gianna MAYOR",
    "name": "Gianna MAYOR",
    "nationality": "PHI",
    "country": "Philippines",
    "gender": "W",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "OMA 303",
    "sourceName": "Mohammed Nabil AL-BALUSHI",
    "name": "Mohammed Nabil AL-BALUSHI",
    "nationality": "OMA",
    "country": "Oman",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "OMA 302",
    "sourceName": "Mohammed AL-QARTOUBI",
    "name": "Mohammed AL-QARTOUBI",
    "nationality": "OMA",
    "country": "Oman",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "KUW 56",
    "sourceName": "Saleh ALMETHEN",
    "name": "Saleh ALMETHEN",
    "nationality": "KUW",
    "country": "Kuwait",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "NZL 4800",
    "sourceName": "Zac Loader",
    "name": "Zac Loader",
    "nationality": "NZL",
    "country": "New Zealand",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "AUS 1920",
    "sourceName": "Luca De Giosa",
    "name": "Luca De Giosa",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "JPN 3337",
    "sourceName": "Haruya Hirano",
    "name": "Haruya Hirano",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "JPN 3253",
    "sourceName": "Genta Naoi",
    "name": "Genta Naoi",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "AUS 1771",
    "sourceName": "Sebastian Tucker",
    "name": "Sebastian Tucker",
    "nationality": "AUS",
    "country": "Australia",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "THA 1643",
    "sourceName": "Pakornkiat Chaiya-o-cha",
    "name": "Pakornkiat Chaiya-o-cha",
    "nationality": "THA",
    "country": "Thailand",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "THA 1322",
    "sourceName": "Itthichai Tiathongchai",
    "name": "Itthichai Tiathongchai",
    "nationality": "THA",
    "country": "Thailand",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "SGP 140",
    "sourceName": "Elijah Ong",
    "name": "Elijah Ong",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "JPN 3355",
    "sourceName": "Hansu Tsunomori",
    "name": "Hansu Tsunomori",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "HKG 186",
    "sourceName": "Liu Qi Heng",
    "name": "Liu Qi Heng",
    "nationality": "HKG",
    "country": "Hong Kong",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "SGP 131",
    "sourceName": "Darian Huang",
    "name": "Darian Huang",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "M",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "NZL 4792",
    "sourceName": "Aurora Edhouse",
    "name": "Aurora Edhouse",
    "nationality": "NZL",
    "country": "New Zealand",
    "gender": "W",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "JPN 3423",
    "sourceName": "Nao Toda",
    "name": "Nao Toda",
    "nationality": "JPN",
    "country": "Japan",
    "gender": "W",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "THA 1459",
    "sourceName": "Thawaree Raksapun",
    "name": "Thawaree Raksapun",
    "nationality": "THA",
    "country": "Thailand",
    "gender": "W",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "NZL 4811",
    "sourceName": "Claire Bao",
    "name": "Claire Bao",
    "nationality": "NZL",
    "country": "New Zealand",
    "gender": "W",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "SGP 143",
    "sourceName": "Nicole Wong Jing Chen",
    "name": "Nicole Wong Jing Chen",
    "nationality": "SGP",
    "country": "Singapore",
    "gender": "W",
    "totalPoints": null,
    "netPoints": null
  },
  {
    "overallPlace": null,
    "sailNumber": "THA 1888",
    "sourceName": "PUNTHITA WEROTJANAKUL",
    "name": "PUNTHITA WEROTJANAKUL",
    "nationality": "THA",
    "country": "Thailand",
    "gender": "W",
    "totalPoints": null,
    "netPoints": null
  }
] as const satisfies readonly AsianOptimistIndexSourceEntry[];

export function asianOptimistIndexIdentityKey(name: string, nationality: string): string {
  return `${nationality.toUpperCase()}:${name.toLowerCase().replace(/[^a-z0-9]/g, "")}`;
}

/**
 * Age-eligibility for the Optimist class in a given calendar year.
 * Under IODA Class Rule 4.3.1 and the Asian & Oceania Optimist Index specification,
 * a sailor remains eligible through 31 December of the calendar year in which they turn 15.
 * Sailors turning 16 or older (i.e. birthYear <= rankingYear - 16) are overaged (>15 years old).
 */
export function isOptimistAgeEligible(
  birthYear: number | null | undefined,
  rankingYear: number = 2026
): boolean {
  if (birthYear == null) return true;
  return rankingYear - birthYear <= 15;
}

export type AsianOptimistIndexBaselineOptions = {
  /** When true, includes overaged/aged-out competitors for founding reconciliation. Default: false. */
  includeOveraged?: boolean;
  rankingYear?: number;
};

export function createAsianOptimistIndexBaseline(
  options: AsianOptimistIndexBaselineOptions = {}
): AsianOptimistIndexEntry[] {
  const { includeOveraged = false, rankingYear = 2026 } = options;
  let currentRank = 0;

  return ASIAN_OPTIMIST_INDEX_SOURCE_ENTRIES.flatMap((sourceEntry, index) => {
    // Confirmed by the user on 19 October 2026: Yuxuan Li and Lyric Li
    // Yuxuan are one SGP sailor. Keep the original source rows above for
    // reconciliation, but combine the championship and qualifier identity.
    if (sourceEntry.name === "Lyric Li Yuxuan" && sourceEntry.nationality === "SGP") {
      return [];
    }
    const entry: AsianOptimistIndexSourceEntry =
      sourceEntry.name === "Yuxuan Li" && sourceEntry.nationality === "CHN"
        ? { ...sourceEntry, name: "Lyric Li Yuxuan", nationality: "SGP",
            country: "Singapore", sailNumber: "SGP 154" }
        : sourceEntry;
    const identityKey = asianOptimistIndexIdentityKey(entry.name, entry.nationality);
    const profile: AsianOptimistIndexProfileManifestEntry | undefined =
      ASIAN_OPTIMIST_INDEX_PROFILE_MANIFEST[
      identityKey as keyof typeof ASIAN_OPTIMIST_INDEX_PROFILE_MANIFEST
      ];
    const profileReview: AsianOptimistIndexDuplicateReview | undefined =
      ASIAN_OPTIMIST_INDEX_DUPLICATE_REVIEWS[
        identityKey as keyof typeof ASIAN_OPTIMIST_INDEX_DUPLICATE_REVIEWS
      ];

    const birthYear = profile?.birthYear ?? null;

    if (!includeOveraged && !isOptimistAgeEligible(birthYear, rankingYear)) {
      return [];
    }

    currentRank++;

    return [{
      ...entry,
      identityKey,
      baselineRank: includeOveraged ? index + 1 : currentRank,
      displayName: profile?.displayName ?? entry.name,
      birthYear,
      // Every source-cohort identity has an existing SailorPath profile or a
      // deterministic import handle. Keeping this manifest static prevents
      // the public Index page from blocking on a DB lookup.
      profileHref: profile ? `/${profile.handle}` : null,
      profileReview: profileReview ?? null,
    }];
  });
}
