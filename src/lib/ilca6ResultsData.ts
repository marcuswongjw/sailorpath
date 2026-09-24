/**
 * ILCA 6 Regatta Results Data for:
 * 1. Cincapura Regatta 2026 (ILCA 6) - 16 entries, 3 races, 0 discards (20–21 July 2026)
 * 2. Pesta Sukan Regatta 2026 (ILCA 6) - 21 entries, 5 races, 1 discard (1–3 August 2026)
 * 3. Singapore National Sailing Championships 2026 (ILCA 6) - 19 entries, 9 races, 1 discard (11–15 September 2026)
 *
 * Source: Official Singapore Sailing Federation Sailwave scoring sheets.
 */

import type { RegattaRecord, SailorRecord, RegattaResultRecord } from "@/lib/ranking";

export interface Ilca6RaceScore {
  raceNumber: number;
  score: number;
  rawValue: string;
  scoringCode?: string | null;
  discarded?: boolean;
}

export interface Ilca6CompetitorResult {
  rank: number;
  sailorName: string;
  sailNumber: string;
  ageCategory?: string | null;
  novice?: boolean;
  gender: "M" | "F";
  schoolName?: string | null;
  club: string;
  nationality?: string | null;
  totalScore: number;
  nettScore: number;
  isDns?: boolean;
  races: Ilca6RaceScore[];
}

export const CINCAPURA_2026_ILCA6_RESULTS: Ilca6CompetitorResult[] = [
  {
    rank: 1,
    sailorName: "Sarah Rui-En Yong",
    sailNumber: "221689",
    gender: "F",
    schoolName: "Nanyang Polytechnic",
    club: "Royal Varuna Yacht Club",
    nationality: "SGP",
    totalScore: 6,
    nettScore: 6,
    races: [
      { raceNumber: 1, score: 2, rawValue: "2" },
      { raceNumber: 2, score: 2, rawValue: "2" },
      { raceNumber: 3, score: 2, rawValue: "2" },
    ],
  },
  {
    rank: 2,
    sailorName: "Keira Carlyle",
    sailNumber: "225225",
    gender: "F",
    schoolName: "Nanyang Polytechnic",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 7,
    nettScore: 7,
    races: [
      { raceNumber: 1, score: 3, rawValue: "3" },
      { raceNumber: 2, score: 1, rawValue: "1" },
      { raceNumber: 3, score: 3, rawValue: "3" },
    ],
  },
  {
    rank: 3,
    sailorName: "Kenan Kee Zen Tan",
    sailNumber: "1",
    gender: "M",
    club: "Royal Varuna Yacht Club",
    nationality: "SGP",
    totalScore: 9,
    nettScore: 9,
    races: [
      { raceNumber: 1, score: 5, rawValue: "5" },
      { raceNumber: 2, score: 3, rawValue: "3" },
      { raceNumber: 3, score: 1, rawValue: "1" },
    ],
  },
  {
    rank: 4,
    sailorName: "Nia Zahedi",
    sailNumber: "224245",
    gender: "F",
    schoolName: "Raffles Institution",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 12,
    nettScore: 12,
    races: [
      { raceNumber: 1, score: 1, rawValue: "1" },
      { raceNumber: 2, score: 6, rawValue: "6" },
      { raceNumber: 3, score: 5, rawValue: "5" },
    ],
  },
  {
    rank: 5,
    sailorName: "Gabi Oh",
    sailNumber: "224717",
    gender: "F",
    schoolName: "Raffles Institution",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 19,
    nettScore: 19,
    races: [
      { raceNumber: 1, score: 6, rawValue: "6" },
      { raceNumber: 2, score: 7, rawValue: "7" },
      { raceNumber: 3, score: 6, rawValue: "6" },
    ],
  },
  {
    rank: 6,
    sailorName: "Kai Lun Wong",
    sailNumber: "227462",
    ageCategory: "15&U",
    gender: "M",
    schoolName: "Bowen Secondary School",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 21,
    nettScore: 21,
    races: [
      { raceNumber: 1, score: 7, rawValue: "7" },
      { raceNumber: 2, score: 5, rawValue: "5" },
      { raceNumber: 3, score: 9, rawValue: "9" },
    ],
  },
  {
    rank: 7,
    sailorName: "Jayden Teo",
    sailNumber: "228158",
    gender: "M",
    schoolName: "St. Joseph's Institution",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 23,
    nettScore: 23,
    races: [
      { raceNumber: 1, score: 9, rawValue: "9" },
      { raceNumber: 2, score: 4, rawValue: "4" },
      { raceNumber: 3, score: 10, rawValue: "10" },
    ],
  },
  {
    rank: 8,
    sailorName: "Gordon Alexander Allan",
    sailNumber: "221058",
    gender: "M",
    schoolName: "Anglo-Chinese School (Independent)",
    club: "Royal Varuna Yacht Club",
    nationality: "SGP",
    totalScore: 25,
    nettScore: 25,
    races: [
      { raceNumber: 1, score: 10, rawValue: "10" },
      { raceNumber: 2, score: 8, rawValue: "8" },
      { raceNumber: 3, score: 7, rawValue: "7" },
    ],
  },
  {
    rank: 9,
    sailorName: "Cleo En Rui Seah",
    sailNumber: "224379",
    gender: "F",
    schoolName: "Ngee Ann Polytechnic",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 26,
    nettScore: 26,
    races: [
      { raceNumber: 1, score: 4, rawValue: "4" },
      { raceNumber: 2, score: 11, rawValue: "11" },
      { raceNumber: 3, score: 11, rawValue: "11" },
    ],
  },
  {
    rank: 10,
    sailorName: "Justiin Ang",
    sailNumber: "158031",
    gender: "M",
    club: "Constant Wind SeaSports",
    nationality: "SGP",
    totalScore: 27,
    nettScore: 27,
    races: [
      { raceNumber: 1, score: 11, rawValue: "11" },
      { raceNumber: 2, score: 12, rawValue: "12" },
      { raceNumber: 3, score: 4, rawValue: "4" },
    ],
  },
  {
    rank: 11,
    sailorName: "Yuei Jit Foo",
    sailNumber: "221686",
    gender: "M",
    schoolName: "Anderson Serangoon Junior College",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 30,
    nettScore: 30,
    races: [
      { raceNumber: 1, score: 13, rawValue: "13" },
      { raceNumber: 2, score: 9, rawValue: "9" },
      { raceNumber: 3, score: 8, rawValue: "8" },
    ],
  },
  {
    rank: 12,
    sailorName: "Travis Jia Le Yeo",
    sailNumber: "222727",
    ageCategory: "15&U",
    novice: true,
    gender: "M",
    schoolName: "Raffles Institution",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 30,
    nettScore: 30,
    races: [
      { raceNumber: 1, score: 8, rawValue: "8" },
      { raceNumber: 2, score: 10, rawValue: "10" },
      { raceNumber: 3, score: 12, rawValue: "12" },
    ],
  },
  {
    rank: 13,
    sailorName: "Sarfraz Ahmad Khan",
    sailNumber: "223871",
    gender: "M",
    club: "Constant Wind SeaSports",
    nationality: "SGP",
    totalScore: 40,
    nettScore: 40,
    races: [
      { raceNumber: 1, score: 12, rawValue: "12" },
      { raceNumber: 2, score: 14, rawValue: "14" },
      { raceNumber: 3, score: 14, rawValue: "14" },
    ],
  },
  {
    rank: 14,
    sailorName: "Darren Lai",
    sailNumber: "222257",
    ageCategory: "15&U",
    gender: "M",
    schoolName: "St. Joseph's Institution",
    club: "Royal Varuna Yacht Club",
    nationality: "SGP",
    totalScore: 40,
    nettScore: 40,
    races: [
      { raceNumber: 1, score: 14, rawValue: "14" },
      { raceNumber: 2, score: 13, rawValue: "13" },
      { raceNumber: 3, score: 13, rawValue: "13" },
    ],
  },
  {
    rank: 15,
    sailorName: "Rohit Behl",
    sailNumber: "221931",
    gender: "M",
    club: "Changi Sailing Club",
    nationality: "IND",
    totalScore: 47,
    nettScore: 47,
    races: [
      { raceNumber: 1, score: 15, rawValue: "15" },
      { raceNumber: 2, score: 17, rawValue: "17 NSC", scoringCode: "NSC" },
      { raceNumber: 3, score: 15, rawValue: "15" },
    ],
  },
  {
    rank: 16,
    sailorName: "Elizabeth Victoria Say",
    sailNumber: "214873",
    gender: "F",
    schoolName: "Dunman High School",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 51,
    nettScore: 51,
    races: [
      { raceNumber: 1, score: 17, rawValue: "17 SCP", scoringCode: "SCP" },
      { raceNumber: 2, score: 17, rawValue: "17 RET", scoringCode: "RET" },
      { raceNumber: 3, score: 17, rawValue: "17 RET", scoringCode: "RET" },
    ],
  },
];

export const PESTA_SUKAN_2026_ILCA6_RESULTS: Ilca6CompetitorResult[] = [
  {
    rank: 1,
    sailorName: "Kenan Kee Zen Tan",
    sailNumber: "1",
    gender: "M",
    club: "Royal Varuna Yacht Club",
    nationality: "SGP",
    totalScore: 11,
    nettScore: 7,
    races: [
      { raceNumber: 1, score: 1, rawValue: "1" },
      { raceNumber: 2, score: 4, rawValue: "(4)", discarded: true },
      { raceNumber: 3, score: 1, rawValue: "1" },
      { raceNumber: 4, score: 1, rawValue: "1" },
      { raceNumber: 5, score: 4, rawValue: "4" },
    ],
  },
  {
    rank: 2,
    sailorName: "Austin Jia Yu Yeo",
    sailNumber: "221062",
    gender: "M",
    schoolName: "Anglo-Chinese School (Independent)",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 12,
    nettScore: 7,
    races: [
      { raceNumber: 1, score: 2, rawValue: "2" },
      { raceNumber: 2, score: 1, rawValue: "1" },
      { raceNumber: 3, score: 2, rawValue: "2" },
      { raceNumber: 4, score: 2, rawValue: "2" },
      { raceNumber: 5, score: 5, rawValue: "(5)", discarded: true },
    ],
  },
  {
    rank: 3,
    sailorName: "Keira Carlyle",
    sailNumber: "225225",
    gender: "F",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 15,
    nettScore: 11,
    races: [
      { raceNumber: 1, score: 3, rawValue: "3" },
      { raceNumber: 2, score: 2, rawValue: "2" },
      { raceNumber: 3, score: 4, rawValue: "(4)", discarded: true },
      { raceNumber: 4, score: 4, rawValue: "4" },
      { raceNumber: 5, score: 2, rawValue: "2" },
    ],
  },
  {
    rank: 4,
    sailorName: "Nia Zahedi",
    sailNumber: "224245",
    gender: "F",
    schoolName: "Raffles Institution",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 23,
    nettScore: 15,
    races: [
      { raceNumber: 1, score: 4, rawValue: "4" },
      { raceNumber: 2, score: 5, rawValue: "5" },
      { raceNumber: 3, score: 3, rawValue: "3" },
      { raceNumber: 4, score: 8, rawValue: "(8)", discarded: true },
      { raceNumber: 5, score: 3, rawValue: "3" },
    ],
  },
  {
    rank: 5,
    sailorName: "Gordon Alexander Allan",
    sailNumber: "221058",
    gender: "M",
    schoolName: "Anglo-Chinese School (Independent)",
    club: "Royal Varuna Yacht Club",
    nationality: "SGP",
    totalScore: 34,
    nettScore: 22,
    races: [
      { raceNumber: 1, score: 11, rawValue: "11" },
      { raceNumber: 2, score: 3, rawValue: "3" },
      { raceNumber: 3, score: 5, rawValue: "5" },
      { raceNumber: 4, score: 3, rawValue: "3" },
      { raceNumber: 5, score: 12, rawValue: "(12)", discarded: true },
    ],
  },
  {
    rank: 6,
    sailorName: "Gabi Oh",
    sailNumber: "224717",
    gender: "F",
    schoolName: "Raffles Institution",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 35,
    nettScore: 25,
    races: [
      { raceNumber: 1, score: 6, rawValue: "6" },
      { raceNumber: 2, score: 8, rawValue: "8" },
      { raceNumber: 3, score: 6, rawValue: "6" },
      { raceNumber: 4, score: 5, rawValue: "5" },
      { raceNumber: 5, score: 10, rawValue: "(10)", discarded: true },
    ],
  },
  {
    rank: 7,
    sailorName: "Sarah Rui-En Yong",
    sailNumber: "222743",
    gender: "F",
    schoolName: "Nanyang Polytechnic",
    club: "Royal Varuna Yacht Club",
    nationality: "SGP",
    totalScore: 32,
    nettScore: 25,
    races: [
      { raceNumber: 1, score: 5, rawValue: "5" },
      { raceNumber: 2, score: 6, rawValue: "6" },
      { raceNumber: 3, score: 7, rawValue: "(7)", discarded: true },
      { raceNumber: 4, score: 7, rawValue: "7" },
      { raceNumber: 5, score: 7, rawValue: "7" },
    ],
  },
  {
    rank: 8,
    sailorName: "Kai Lun Wong",
    sailNumber: "227462",
    ageCategory: "15&U",
    gender: "M",
    schoolName: "Bowen Secondary School",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 38,
    nettScore: 29,
    races: [
      { raceNumber: 1, score: 9, rawValue: "(9)", discarded: true },
      { raceNumber: 2, score: 9, rawValue: "9" },
      { raceNumber: 3, score: 8, rawValue: "8" },
      { raceNumber: 4, score: 6, rawValue: "6" },
      { raceNumber: 5, score: 6, rawValue: "6" },
    ],
  },
  {
    rank: 9,
    sailorName: "Charlotte Wee Shuen Lee",
    sailNumber: "214235",
    gender: "F",
    club: "Royal Varuna Yacht Club",
    nationality: "SGP",
    totalScore: 43,
    nettScore: 31,
    races: [
      { raceNumber: 1, score: 8, rawValue: "8" },
      { raceNumber: 2, score: 11, rawValue: "11" },
      { raceNumber: 3, score: 12, rawValue: "(12)", discarded: true },
      { raceNumber: 4, score: 11, rawValue: "11" },
      { raceNumber: 5, score: 1, rawValue: "1" },
    ],
  },
  {
    rank: 10,
    sailorName: "Jayden Teo",
    sailNumber: "228158",
    gender: "M",
    schoolName: "St. Joseph's Institution",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 44,
    nettScore: 34,
    races: [
      { raceNumber: 1, score: 7, rawValue: "7" },
      { raceNumber: 2, score: 10, rawValue: "(10)", discarded: true },
      { raceNumber: 3, score: 9, rawValue: "9" },
      { raceNumber: 4, score: 10, rawValue: "10" },
      { raceNumber: 5, score: 8, rawValue: "8" },
    ],
  },
  {
    rank: 11,
    sailorName: "Yuei Jit Foo",
    sailNumber: "221686",
    gender: "M",
    schoolName: "Anderson Serangoon Junior College",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 50,
    nettScore: 37,
    races: [
      { raceNumber: 1, score: 10, rawValue: "10" },
      { raceNumber: 2, score: 7, rawValue: "7" },
      { raceNumber: 3, score: 11, rawValue: "11" },
      { raceNumber: 4, score: 9, rawValue: "9" },
      { raceNumber: 5, score: 13, rawValue: "(13)", discarded: true },
    ],
  },
  {
    rank: 12,
    sailorName: "Darren Lai",
    sailNumber: "222257",
    ageCategory: "15&U",
    gender: "M",
    schoolName: "St. Joseph's Institution",
    club: "Royal Varuna Yacht Club",
    nationality: "SGP",
    totalScore: 63,
    nettScore: 47,
    races: [
      { raceNumber: 1, score: 13, rawValue: "13" },
      { raceNumber: 2, score: 12, rawValue: "12" },
      { raceNumber: 3, score: 10, rawValue: "10" },
      { raceNumber: 4, score: 12, rawValue: "12" },
      { raceNumber: 5, score: 16, rawValue: "(16)", discarded: true },
    ],
  },
  {
    rank: 13,
    sailorName: "Darius Xian Rui Low",
    sailNumber: "8",
    gender: "M",
    schoolName: "St. Joseph's Institution",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 67,
    nettScore: 52,
    races: [
      { raceNumber: 1, score: 15, rawValue: "(15)", discarded: true },
      { raceNumber: 2, score: 15, rawValue: "15" },
      { raceNumber: 3, score: 14, rawValue: "14" },
      { raceNumber: 4, score: 14, rawValue: "14" },
      { raceNumber: 5, score: 9, rawValue: "9" },
    ],
  },
  {
    rank: 14,
    sailorName: "Cleo En Rui Seah",
    sailNumber: "224379",
    gender: "F",
    schoolName: "Ngee Ann Polytechnic",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 68,
    nettScore: 52,
    races: [
      { raceNumber: 1, score: 12, rawValue: "12" },
      { raceNumber: 2, score: 14, rawValue: "14" },
      { raceNumber: 3, score: 16, rawValue: "(16)", discarded: true },
      { raceNumber: 4, score: 15, rawValue: "15" },
      { raceNumber: 5, score: 11, rawValue: "11" },
    ],
  },
  {
    rank: 15,
    sailorName: "Rohit Behl",
    sailNumber: "221931",
    gender: "M",
    club: "Changi Sailing Club",
    nationality: "IND",
    totalScore: 74,
    nettScore: 56,
    races: [
      { raceNumber: 1, score: 14, rawValue: "14" },
      { raceNumber: 2, score: 13, rawValue: "13" },
      { raceNumber: 3, score: 13, rawValue: "13" },
      { raceNumber: 4, score: 16, rawValue: "16" },
      { raceNumber: 5, score: 18, rawValue: "(18)", discarded: true },
    ],
  },
  {
    rank: 16,
    sailorName: "Elizabeth Victoria Say",
    sailNumber: "214873",
    gender: "F",
    schoolName: "Dunman High School",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 75,
    nettScore: 59,
    races: [
      { raceNumber: 1, score: 16, rawValue: "(16)", discarded: true },
      { raceNumber: 2, score: 16, rawValue: "16" },
      { raceNumber: 3, score: 15, rawValue: "15" },
      { raceNumber: 4, score: 13, rawValue: "13" },
      { raceNumber: 5, score: 15, rawValue: "15" },
    ],
  },
  {
    rank: 17,
    sailorName: "Tiffany Teo",
    sailNumber: "214813",
    ageCategory: "15&U",
    novice: true,
    gender: "F",
    schoolName: "Bedok South Secondary School",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 85,
    nettScore: 66,
    races: [
      { raceNumber: 1, score: 19, rawValue: "(19)", discarded: true },
      { raceNumber: 2, score: 17, rawValue: "17" },
      { raceNumber: 3, score: 18, rawValue: "18" },
      { raceNumber: 4, score: 17, rawValue: "17" },
      { raceNumber: 5, score: 14, rawValue: "14" },
    ],
  },
  {
    rank: 18,
    sailorName: "Travis Jia Le Yeo",
    sailNumber: "222727",
    ageCategory: "15&U",
    gender: "M",
    schoolName: "Raffles Institution",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 93,
    nettScore: 71,
    races: [
      { raceNumber: 1, score: 17, rawValue: "17" },
      { raceNumber: 2, score: 19, rawValue: "19" },
      { raceNumber: 3, score: 17, rawValue: "17" },
      { raceNumber: 4, score: 18, rawValue: "18" },
      { raceNumber: 5, score: 22, rawValue: "(22 DNC)", scoringCode: "DNC", discarded: true },
    ],
  },
  {
    rank: 19,
    sailorName: "Sarfraz Ahmad Khan",
    sailNumber: "193871",
    gender: "M",
    club: "Constant Wind SeaSports",
    nationality: "SGP",
    totalScore: 91,
    nettScore: 72,
    races: [
      { raceNumber: 1, score: 18, rawValue: "18" },
      { raceNumber: 2, score: 18, rawValue: "18" },
      { raceNumber: 3, score: 19, rawValue: "(19)", discarded: true },
      { raceNumber: 4, score: 19, rawValue: "19" },
      { raceNumber: 5, score: 17, rawValue: "17" },
    ],
  },
  {
    rank: 20,
    sailorName: "Justiin Ang",
    sailNumber: "158031",
    gender: "M",
    schoolName: "Rosyth School",
    club: "Constant Wind SeaSports",
    nationality: "SGP",
    totalScore: 110,
    nettScore: 88,
    isDns: true,
    races: [
      { raceNumber: 1, score: 22, rawValue: "(22 DNC)", scoringCode: "DNC", discarded: true },
      { raceNumber: 2, score: 22, rawValue: "22 DNC", scoringCode: "DNC" },
      { raceNumber: 3, score: 22, rawValue: "22 DNC", scoringCode: "DNC" },
      { raceNumber: 4, score: 22, rawValue: "22 DNC", scoringCode: "DNC" },
      { raceNumber: 5, score: 22, rawValue: "22 DNC", scoringCode: "DNC" },
    ],
  },
  {
    rank: 20,
    sailorName: "Bryan Chan",
    sailNumber: "197850",
    novice: true,
    gender: "M",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 110,
    nettScore: 88,
    races: [
      { raceNumber: 1, score: 22, rawValue: "(22 DNF)", scoringCode: "DNF", discarded: true },
      { raceNumber: 2, score: 22, rawValue: "22 RET", scoringCode: "RET" },
      { raceNumber: 3, score: 22, rawValue: "22 DNF", scoringCode: "DNF" },
      { raceNumber: 4, score: 22, rawValue: "22 RET", scoringCode: "RET" },
      { raceNumber: 5, score: 22, rawValue: "22 DNF", scoringCode: "DNF" },
    ],
  },
];

export const SNSC_2026_ILCA6_RESULTS: Ilca6CompetitorResult[] = [
  {
    rank: 1,
    sailorName: "Kenan Kee Zen Tan",
    sailNumber: "221060",
    gender: "M",
    club: "Royal Varuna Yacht Club",
    nationality: "SGP",
    totalScore: 23,
    nettScore: 15,
    races: [
      { raceNumber: 1, score: 1, rawValue: "1" },
      { raceNumber: 2, score: 1, rawValue: "1" },
      { raceNumber: 3, score: 2, rawValue: "2" },
      { raceNumber: 4, score: 8, rawValue: "(8)", discarded: true },
      { raceNumber: 5, score: 1, rawValue: "1" },
      { raceNumber: 6, score: 1, rawValue: "1" },
      { raceNumber: 7, score: 1, rawValue: "1" },
      { raceNumber: 8, score: 1, rawValue: "1" },
      { raceNumber: 9, score: 7, rawValue: "7" },
    ],
  },
  {
    rank: 2,
    sailorName: "Keira Carlyle",
    sailNumber: "225225",
    gender: "F",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 33,
    nettScore: 23,
    races: [
      { raceNumber: 1, score: 2, rawValue: "2" },
      { raceNumber: 2, score: 3, rawValue: "3" },
      { raceNumber: 3, score: 4, rawValue: "4" },
      { raceNumber: 4, score: 1, rawValue: "1" },
      { raceNumber: 5, score: 2, rawValue: "2" },
      { raceNumber: 6, score: 3, rawValue: "3" },
      { raceNumber: 7, score: 4, rawValue: "4" },
      { raceNumber: 8, score: 10, rawValue: "(10)", discarded: true },
      { raceNumber: 9, score: 4, rawValue: "4" },
    ],
  },
  {
    rank: 3,
    sailorName: "Sarah Rui-En Yong",
    sailNumber: "221689",
    gender: "F",
    schoolName: "Nanyang Polytechnic",
    club: "Royal Varuna Yacht Club",
    nationality: "SGP",
    totalScore: 40,
    nettScore: 29,
    races: [
      { raceNumber: 1, score: 4, rawValue: "4" },
      { raceNumber: 2, score: 9, rawValue: "9" },
      { raceNumber: 3, score: 1, rawValue: "1" },
      { raceNumber: 4, score: 3, rawValue: "3" },
      { raceNumber: 5, score: 3, rawValue: "3" },
      { raceNumber: 6, score: 2, rawValue: "2" },
      { raceNumber: 7, score: 6, rawValue: "6" },
      { raceNumber: 8, score: 11, rawValue: "(11)", discarded: true },
      { raceNumber: 9, score: 1, rawValue: "1" },
    ],
  },
  {
    rank: 4,
    sailorName: "Austin Jia Yu Yeo",
    sailNumber: "221062",
    gender: "M",
    schoolName: "Anglo-Chinese School (Independent)",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 49,
    nettScore: 37,
    races: [
      { raceNumber: 1, score: 11, rawValue: "11" },
      { raceNumber: 2, score: 2, rawValue: "2" },
      { raceNumber: 3, score: 5, rawValue: "5" },
      { raceNumber: 4, score: 6, rawValue: "6" },
      { raceNumber: 5, score: 12, rawValue: "(12)", discarded: true },
      { raceNumber: 6, score: 4, rawValue: "4" },
      { raceNumber: 7, score: 2, rawValue: "2" },
      { raceNumber: 8, score: 4, rawValue: "4" },
      { raceNumber: 9, score: 3, rawValue: "3" },
    ],
  },
  {
    rank: 5,
    sailorName: "Nia Zahedi",
    sailNumber: "224245",
    gender: "F",
    schoolName: "Raffles Institution",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 62,
    nettScore: 42,
    races: [
      { raceNumber: 1, score: 3, rawValue: "3" },
      { raceNumber: 2, score: 11, rawValue: "11" },
      { raceNumber: 3, score: 6, rawValue: "6" },
      { raceNumber: 4, score: 2, rawValue: "2" },
      { raceNumber: 5, score: 8, rawValue: "8" },
      { raceNumber: 6, score: 7, rawValue: "7" },
      { raceNumber: 7, score: 3, rawValue: "3" },
      { raceNumber: 8, score: 20, rawValue: "(20 UFD)", scoringCode: "UFD", discarded: true },
      { raceNumber: 9, score: 2, rawValue: "2" },
    ],
  },
  {
    rank: 6,
    sailorName: "Misa Lim Laurie",
    sailNumber: "223202",
    ageCategory: "15&U",
    novice: true,
    gender: "F",
    schoolName: "Singapore American School",
    club: "Changi Sailing Club",
    nationality: "USA",
    totalScore: 63,
    nettScore: 52,
    races: [
      { raceNumber: 1, score: 5, rawValue: "5" },
      { raceNumber: 2, score: 6, rawValue: "6" },
      { raceNumber: 3, score: 10, rawValue: "10" },
      { raceNumber: 4, score: 4, rawValue: "4" },
      { raceNumber: 5, score: 6, rawValue: "6" },
      { raceNumber: 6, score: 6, rawValue: "6" },
      { raceNumber: 7, score: 10, rawValue: "10" },
      { raceNumber: 8, score: 5, rawValue: "5" },
      { raceNumber: 9, score: 11, rawValue: "(11)", discarded: true },
    ],
  },
  {
    rank: 7,
    sailorName: "Gabi Oh",
    sailNumber: "224717",
    gender: "F",
    schoolName: "Raffles Institution",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 69,
    nettScore: 57,
    races: [
      { raceNumber: 1, score: 12, rawValue: "(12)", discarded: true },
      { raceNumber: 2, score: 5, rawValue: "5" },
      { raceNumber: 3, score: 7, rawValue: "7" },
      { raceNumber: 4, score: 9, rawValue: "9" },
      { raceNumber: 5, score: 4, rawValue: "4" },
      { raceNumber: 6, score: 12, rawValue: "12" },
      { raceNumber: 7, score: 8, rawValue: "8" },
      { raceNumber: 8, score: 7, rawValue: "7" },
      { raceNumber: 9, score: 5, rawValue: "5" },
    ],
  },
  {
    rank: 8,
    sailorName: "Gordon Alexander Allan",
    sailNumber: "221058",
    gender: "M",
    schoolName: "Anglo-Chinese School (Independent)",
    club: "Royal Varuna Yacht Club",
    nationality: "SGP",
    totalScore: 79,
    nettScore: 64,
    races: [
      { raceNumber: 1, score: 9, rawValue: "9" },
      { raceNumber: 2, score: 4, rawValue: "4" },
      { raceNumber: 3, score: 9, rawValue: "9" },
      { raceNumber: 4, score: 15, rawValue: "(15)", discarded: true },
      { raceNumber: 5, score: 11, rawValue: "11" },
      { raceNumber: 6, score: 11, rawValue: "11" },
      { raceNumber: 7, score: 7, rawValue: "7" },
      { raceNumber: 8, score: 3, rawValue: "3" },
      { raceNumber: 9, score: 10, rawValue: "10" },
    ],
  },
  {
    rank: 9,
    sailorName: "Jayden Teo",
    sailNumber: "228158",
    gender: "M",
    schoolName: "St. Joseph's Institution",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 85,
    nettScore: 71,
    races: [
      { raceNumber: 1, score: 10, rawValue: "10" },
      { raceNumber: 2, score: 13, rawValue: "13" },
      { raceNumber: 3, score: 11, rawValue: "11" },
      { raceNumber: 4, score: 13, rawValue: "13" },
      { raceNumber: 5, score: 5, rawValue: "5" },
      { raceNumber: 6, score: 8, rawValue: "8" },
      { raceNumber: 7, score: 5, rawValue: "5" },
      { raceNumber: 8, score: 6, rawValue: "6" },
      { raceNumber: 9, score: 14, rawValue: "(14)", discarded: true },
    ],
  },
  {
    rank: 10,
    sailorName: "Justiin Ang",
    sailNumber: "158031",
    gender: "M",
    club: "Constant Wind SeaSports",
    nationality: "SGP",
    totalScore: 91,
    nettScore: 71,
    races: [
      { raceNumber: 1, score: 20, rawValue: "(20 DNC)", scoringCode: "DNC", discarded: true },
      { raceNumber: 2, score: 20, rawValue: "20 DNC", scoringCode: "DNC" },
      { raceNumber: 3, score: 8, rawValue: "8" },
      { raceNumber: 4, score: 5, rawValue: "5" },
      { raceNumber: 5, score: 7, rawValue: "7" },
      { raceNumber: 6, score: 5, rawValue: "5" },
      { raceNumber: 7, score: 9, rawValue: "9" },
      { raceNumber: 8, score: 8, rawValue: "8 DPI", scoringCode: "DPI" },
      { raceNumber: 9, score: 9, rawValue: "9" },
    ],
  },
  {
    rank: 11,
    sailorName: "Kai Lun Wong",
    sailNumber: "227462",
    ageCategory: "15&U",
    gender: "M",
    schoolName: "Bowen Secondary School",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 84,
    nettScore: 72,
    races: [
      { raceNumber: 1, score: 7, rawValue: "7" },
      { raceNumber: 2, score: 7, rawValue: "7" },
      { raceNumber: 3, score: 12, rawValue: "(12)", discarded: true },
      { raceNumber: 4, score: 11, rawValue: "11" },
      { raceNumber: 5, score: 10, rawValue: "10" },
      { raceNumber: 6, score: 10, rawValue: "10" },
      { raceNumber: 7, score: 11, rawValue: "11" },
      { raceNumber: 8, score: 8, rawValue: "8" },
      { raceNumber: 9, score: 8, rawValue: "8" },
    ],
  },
  {
    rank: 12,
    sailorName: "Cleo En Rui Seah",
    sailNumber: "224379",
    gender: "F",
    schoolName: "Ngee Ann Polytechnic",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 88,
    nettScore: 75,
    races: [
      { raceNumber: 1, score: 6, rawValue: "6" },
      { raceNumber: 2, score: 10, rawValue: "10" },
      { raceNumber: 3, score: 13, rawValue: "(13)", discarded: true },
      { raceNumber: 4, score: 10, rawValue: "10" },
      { raceNumber: 5, score: 9, rawValue: "9" },
      { raceNumber: 6, score: 9, rawValue: "9" },
      { raceNumber: 7, score: 13, rawValue: "13" },
      { raceNumber: 8, score: 12, rawValue: "12" },
      { raceNumber: 9, score: 6, rawValue: "6" },
    ],
  },
  {
    rank: 13,
    sailorName: "Darren Lai",
    sailNumber: "222257",
    ageCategory: "15&U",
    gender: "M",
    schoolName: "St. Joseph's Institution",
    club: "Royal Varuna Yacht Club",
    nationality: "SGP",
    totalScore: 113,
    nettScore: 97,
    races: [
      { raceNumber: 1, score: 8, rawValue: "8" },
      { raceNumber: 2, score: 8, rawValue: "8" },
      { raceNumber: 3, score: 16, rawValue: "(16)", discarded: true },
      { raceNumber: 4, score: 12, rawValue: "12" },
      { raceNumber: 5, score: 14, rawValue: "14" },
      { raceNumber: 6, score: 16, rawValue: "16" },
      { raceNumber: 7, score: 15, rawValue: "15" },
      { raceNumber: 8, score: 9, rawValue: "9" },
      { raceNumber: 9, score: 15, rawValue: "15" },
    ],
  },
  {
    rank: 14,
    sailorName: "Tiffany Teo",
    sailNumber: "214813",
    ageCategory: "15&U",
    gender: "F",
    schoolName: "Bedok South Secondary School",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 129,
    nettScore: 112,
    races: [
      { raceNumber: 1, score: 13, rawValue: "13" },
      { raceNumber: 2, score: 15, rawValue: "15" },
      { raceNumber: 3, score: 15, rawValue: "15" },
      { raceNumber: 4, score: 17, rawValue: "(17)", discarded: true },
      { raceNumber: 5, score: 13, rawValue: "13" },
      { raceNumber: 6, score: 13, rawValue: "13" },
      { raceNumber: 7, score: 16, rawValue: "16" },
      { raceNumber: 8, score: 15, rawValue: "15" },
      { raceNumber: 9, score: 12, rawValue: "12" },
    ],
  },
  {
    rank: 15,
    sailorName: "Travis Jia Le Yeo",
    sailNumber: "222727",
    ageCategory: "15&U",
    gender: "M",
    schoolName: "Raffles Institution",
    club: "SAF Yacht Club",
    nationality: "SGP",
    totalScore: 130,
    nettScore: 113,
    races: [
      { raceNumber: 1, score: 15, rawValue: "15" },
      { raceNumber: 2, score: 12, rawValue: "12" },
      { raceNumber: 3, score: 17, rawValue: "(17)", discarded: true },
      { raceNumber: 4, score: 16, rawValue: "16" },
      { raceNumber: 5, score: 16, rawValue: "16" },
      { raceNumber: 6, score: 14, rawValue: "14" },
      { raceNumber: 7, score: 14, rawValue: "14" },
      { raceNumber: 8, score: 13, rawValue: "13" },
      { raceNumber: 9, score: 13, rawValue: "13" },
    ],
  },
  {
    rank: 16,
    sailorName: "Rohit Behl",
    sailNumber: "221931",
    gender: "M",
    club: "Changi Sailing Club",
    nationality: "IND",
    totalScore: 141,
    nettScore: 121,
    races: [
      { raceNumber: 1, score: 14, rawValue: "14" },
      { raceNumber: 2, score: 14, rawValue: "14" },
      { raceNumber: 3, score: 14, rawValue: "14" },
      { raceNumber: 4, score: 14, rawValue: "14" },
      { raceNumber: 5, score: 17, rawValue: "17" },
      { raceNumber: 6, score: 20, rawValue: "(20 RET)", scoringCode: "RET", discarded: true },
      { raceNumber: 7, score: 12, rawValue: "12" },
      { raceNumber: 8, score: 20, rawValue: "20 UFD", scoringCode: "UFD" },
      { raceNumber: 9, score: 16, rawValue: "16" },
    ],
  },
  {
    rank: 17,
    sailorName: "Lucien Franciscus Henricus van Riel",
    sailNumber: "207763",
    gender: "M",
    club: "Constant Wind SeaSports",
    nationality: "NED",
    totalScore: 146,
    nettScore: 128,
    races: [
      { raceNumber: 1, score: 16, rawValue: "16" },
      { raceNumber: 2, score: 16, rawValue: "16" },
      { raceNumber: 3, score: 18, rawValue: "(18)", discarded: true },
      { raceNumber: 4, score: 18, rawValue: "18" },
      { raceNumber: 5, score: 15, rawValue: "15" },
      { raceNumber: 6, score: 15, rawValue: "15" },
      { raceNumber: 7, score: 17, rawValue: "17" },
      { raceNumber: 8, score: 14, rawValue: "14" },
      { raceNumber: 9, score: 17, rawValue: "17" },
    ],
  },
  {
    rank: 18,
    sailorName: "Maia Lim Laurie",
    sailNumber: "223201",
    gender: "F",
    schoolName: "Singapore American School",
    club: "Changi Sailing Club",
    nationality: "USA",
    totalScore: 150,
    nettScore: 130,
    races: [
      { raceNumber: 1, score: 20, rawValue: "(20 DNC)", scoringCode: "DNC", discarded: true },
      { raceNumber: 2, score: 20, rawValue: "20 DNC", scoringCode: "DNC" },
      { raceNumber: 3, score: 3, rawValue: "3" },
      { raceNumber: 4, score: 7, rawValue: "7" },
      { raceNumber: 5, score: 20, rawValue: "20 RET", scoringCode: "RET" },
      { raceNumber: 6, score: 20, rawValue: "20 DNS", scoringCode: "DNS" },
      { raceNumber: 7, score: 20, rawValue: "20 DNC", scoringCode: "DNC" },
      { raceNumber: 8, score: 20, rawValue: "20 DNC", scoringCode: "DNC" },
      { raceNumber: 9, score: 20, rawValue: "20 DNC", scoringCode: "DNC" },
    ],
  },
  {
    rank: 19,
    sailorName: "Elizabeth Victoria Say",
    sailNumber: "214873",
    gender: "F",
    schoolName: "Dunman High School",
    club: "PAssion Wave",
    nationality: "SGP",
    totalScore: 180,
    nettScore: 160,
    isDns: true,
    races: [
      { raceNumber: 1, score: 20, rawValue: "(20 DNC)", scoringCode: "DNC", discarded: true },
      { raceNumber: 2, score: 20, rawValue: "20 DNC", scoringCode: "DNC" },
      { raceNumber: 3, score: 20, rawValue: "20 DNC", scoringCode: "DNC" },
      { raceNumber: 4, score: 20, rawValue: "20 DNC", scoringCode: "DNC" },
      { raceNumber: 5, score: 20, rawValue: "20 DNC", scoringCode: "DNC" },
      { raceNumber: 6, score: 20, rawValue: "20 DNC", scoringCode: "DNC" },
      { raceNumber: 7, score: 20, rawValue: "20 DNC", scoringCode: "DNC" },
      { raceNumber: 8, score: 20, rawValue: "20 DNC", scoringCode: "DNC" },
      { raceNumber: 9, score: 20, rawValue: "20 DNC", scoringCode: "DNC" },
    ],
  },
];

export const ILCA6_STATIC_REGATTAS: RegattaRecord[] = [
  {
    id: "reg-cincapura-2026-ilca-6",
    name: "Cincapura Regatta 2026 (ILCA 6)",
    slug: "cincapura-regatta-2026-ilca-6",
    date: "2026-07-20",
    endDate: "2026-07-21",
    boatClass: "ILCA 6",
    division: "Open",
    totalFleetSize: 16,
    raceCount: 3,
    geography: "SG",
    countsForRanking: true,
    venue: "National Sailing Centre, Singapore",
    organizer: "Singapore Sailing Federation",
    norUrl: "https://www.racingrulesofsailing.org/documents/14587/event",
    registrationUrl: "https://www.sailing.org.sg/events/356060",
    scheduleNotes: "Cincapura Regatta 2026 ILCA 6 fleet: 16 entries, 3 races sailed (no discards).",
  },
  {
    id: "reg-pesta-sukan-2026-ilca-6",
    name: "Pesta Sukan 2026 (ILCA 6)",
    slug: "pesta-sukan-2026-ilca-6",
    date: "2026-08-01",
    endDate: "2026-08-03",
    boatClass: "ILCA 6",
    division: "Open",
    totalFleetSize: 21,
    raceCount: 5,
    geography: "SG",
    countsForRanking: true,
    venue: "National Sailing Centre, Singapore",
    organizer: "Singapore Sailing Federation",
    norUrl: "https://www.racingrulesofsailing.org/documents/14397/event?name=pesta-sukan-2026",
    registrationUrl: "https://www.sailing.org.sg/events/351968",
    scheduleNotes: "Pesta Sukan Regatta 2026 ILCA 6 fleet: 21 entries, 5 races sailed (1 discard).",
  },
  {
    id: "reg-snsc-2026-ilca-6",
    name: "Singapore National Sailing Championships 2026 (ILCA 6)",
    slug: "snsc-ilca-6-sep-26",
    date: "2026-09-11",
    endDate: "2026-09-15",
    boatClass: "ILCA 6",
    division: "Open",
    totalFleetSize: 19,
    raceCount: 9,
    geography: "SG",
    countsForRanking: true,
    venue: "National Sailing Centre, Singapore",
    organizer: "Singapore Sailing Federation",
    norUrl: "https://www.racingrulesofsailing.org/documents/14487/event",
    registrationUrl: "https://www.sailing.org.sg/events/323705",
    scheduleNotes: "Singapore National Sailing Championships 2026 ILCA 6 fleet: 19 entries, 9 races sailed (1 discard).",
  },
];

function slugifyName(name: string): string {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
}

export interface PublicRegattaResult {
  resultId: string;
  sailorId: string;
  regattaId: string;
  rank: number;
  nettScore: number;
  totalScore: number;
  isDns: boolean;
  isOverseasCommitment: boolean;
  sailorName: string;
  sailNumber: string;
  handle: string;
  school: string | null;
  club: string | null;
  gender: string | null;
  sailorGender: string | null;
  birthYear: number | null;
  dob: string | null;
  nationality: string | null;
  sailorNationality: string | null;
  verificationStatus: "verified";
  regattaSlug: string;
  regattaName: string;
  raceResults: Array<{
    regattaResultId: string;
    raceNumber: number;
    score: number;
    scoringCode: string | null;
    discarded: boolean;
    rawValue: string;
  }>;
}

export function getStaticIlca6Results(
  regattaIdOrSlug: string
): PublicRegattaResult[] | null {
  const norm = regattaIdOrSlug.toLowerCase();
  let entries: Ilca6CompetitorResult[] | null = null;
  let regatta: RegattaRecord | null = null;

  const directMatch = ILCA6_STATIC_REGATTAS.find(
    (r) => r.id.toLowerCase() === norm || r.slug.toLowerCase() === norm
  );
  if (directMatch) {
    regatta = directMatch;
    if (directMatch.slug.includes("cincapura")) entries = CINCAPURA_2026_ILCA6_RESULTS;
    else if (directMatch.slug.includes("pesta")) entries = PESTA_SUKAN_2026_ILCA6_RESULTS;
    else if (directMatch.slug.includes("snsc")) entries = SNSC_2026_ILCA6_RESULTS;
  } else if (norm.includes("cincapura") && (norm.includes("ilca-6") || norm.includes("ilca6"))) {
    entries = CINCAPURA_2026_ILCA6_RESULTS;
    regatta = ILCA6_STATIC_REGATTAS[0];
  } else if (norm.includes("pesta") && (norm.includes("ilca-6") || norm.includes("ilca6"))) {
    entries = PESTA_SUKAN_2026_ILCA6_RESULTS;
    regatta = ILCA6_STATIC_REGATTAS[1];
  } else if (norm.includes("snsc") && (norm.includes("ilca-6") || norm.includes("ilca6"))) {
    entries = SNSC_2026_ILCA6_RESULTS;
    regatta = ILCA6_STATIC_REGATTAS[2];
  }

  if (!entries || !regatta) return null;

  return entries.map((c, i) => {
    const resultId = `${regatta!.id}-res-${i + 1}`;
    const sailorId = `sailor-ilca6-${slugifyName(c.sailorName)}`;
    return {
      resultId,
      sailorId,
      regattaId: regatta!.id,
      rank: c.rank,
      nettScore: c.nettScore,
      totalScore: c.totalScore,
      isDns: c.isDns || false,
      isOverseasCommitment: false,
      sailorName: c.sailorName,
      sailNumber: c.sailNumber,
      handle: slugifyName(c.sailorName),
      school: c.schoolName || null,
      club: c.club || null,
      gender: c.gender,
      sailorGender: c.gender,
      birthYear: null,
      dob: null,
      nationality: c.nationality || "SGP",
      sailorNationality: c.nationality || "SGP",
      verificationStatus: "verified" as const,
      regattaSlug: regatta!.slug,
      regattaName: regatta!.name,
      raceResults: c.races.map((r) => ({
        regattaResultId: resultId,
        raceNumber: r.raceNumber,
        score: r.score,
        scoringCode: r.scoringCode || null,
        discarded: r.discarded || false,
        rawValue: r.rawValue,
      })),
    };
  });
}

/**
 * Returns sailor, regatta, and result records for ILCA 6 rankings calculation
 * to supplement database rows.
 */
export function getStaticIlca6RankingsData(): {
  sailors: SailorRecord[];
  regattas: RegattaRecord[];
  results: RegattaResultRecord[];
} {
  const regattas = ILCA6_STATIC_REGATTAS;
  const sailorMap = new Map<string, SailorRecord>();
  const results: RegattaResultRecord[] = [];

  const datasets = [
    { regatta: regattas[0], list: CINCAPURA_2026_ILCA6_RESULTS },
    { regatta: regattas[1], list: PESTA_SUKAN_2026_ILCA6_RESULTS },
    { regatta: regattas[2], list: SNSC_2026_ILCA6_RESULTS },
  ];

  for (const { regatta, list } of datasets) {
    for (const c of list) {
      const id = `sailor-ilca6-${slugifyName(c.sailorName)}`;
      if (!sailorMap.has(id)) {
        sailorMap.set(id, {
          id,
          name: c.sailorName,
          handle: slugifyName(c.sailorName),
          gender: c.gender,
          nationality: c.nationality || "SGP",
          sailNumber: c.sailNumber,
          club: c.club,
          school: c.schoolName,
          ilca6NationalList: true,
          currentFleet: "Series",
          goldEntryDate: null,
          silverEntryDate: null,
          dropDate: null,
        });
      }
      results.push({
        sailorId: id,
        regattaId: regatta.id,
        rank: c.rank,
        nettScore: c.nettScore,
        totalScore: c.totalScore,
        isDns: c.isDns || false,
      });
    }
  }

  return {
    sailors: Array.from(sailorMap.values()),
    regattas,
    results,
  };
}
