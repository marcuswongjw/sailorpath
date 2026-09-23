/**
 * Cincapura Regatta 2026 - Official Race-by-Race Results Data
 *
 * Source: Official Sailwave scoring sheets, Singapore Sailing Federation.
 * Event: Cincapura Regatta 2026
 * Venue: National Sailing Centre, Singapore
 * Dates: Results final as of 20–21 July 2026
 *
 * - Optimist Gold Fleet Class: 86 entries, 3 races sailed, 0 discards.
 * - Optimist Silver Fleet Class: 55 entries, 4 races sailed, 1 discard.
 */

export interface CincapuraRaceScore {
  raceNumber: number;
  score: number;
  rawValue: string;
  scoringCode?: string | null;
  discarded?: boolean;
}

export interface CincapuraCompetitorResult {
  rank: number;
  sailorName: string;
  sailNumber: string;
  ageCategory?: string | null;
  novice?: boolean;
  gender: "M" | "F";
  schoolName?: string | null;
  club: string;
  totalScore: number;
  nettScore: number;
  isDns?: boolean;
  races: CincapuraRaceScore[];
}

export const CINCAPURA_2026_GOLD_RESULTS: CincapuraCompetitorResult[] = [
  {
    "rank": 1,
    "sailorName": "Kyle Jeremy Zhi Jun Soh",
    "sailNumber": "3183",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "SAF Yacht Club",
    "totalScore": 21,
    "nettScore": 21,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 14,
        "rawValue": "14",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 4,
        "rawValue": "4",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 3,
        "rawValue": "3",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 2,
    "sailorName": "Alyssa Li Lin Wong",
    "sailNumber": "150",
    "ageCategory": null,
    "gender": "F",
    "schoolName": "RAFFLES GIRLS' SCHOOL (SECONDARY)",
    "club": "SAF Yacht Club",
    "totalScore": 26,
    "nettScore": 26,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 4,
        "rawValue": "4",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 1,
        "rawValue": "1",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 21,
        "rawValue": "21",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 3,
    "sailorName": "Wangsun Chen",
    "sailNumber": "20",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "YUMIN PRIMARY SCHOOL",
    "club": "Constant Wind SeaSports",
    "totalScore": 26,
    "nettScore": 26,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 11,
        "rawValue": "11",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 13,
        "rawValue": "13",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 2,
        "rawValue": "2",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 4,
    "sailorName": "Tan Qi",
    "sailNumber": "3026",
    "ageCategory": "11-12 yo",
    "gender": "F",
    "schoolName": "TAO NAN SCHOOL",
    "club": "Constant Wind SeaSports",
    "totalScore": 28,
    "nettScore": 28,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 15,
        "rawValue": "15",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 9,
        "rawValue": "9",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 4,
        "rawValue": "4",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 5,
    "sailorName": "Rui Ling Teo",
    "sailNumber": "3820",
    "ageCategory": "11-12 yo",
    "gender": "F",
    "schoolName": "CHIJ (KATONG) PRIMARY",
    "club": "SAF Yacht Club",
    "totalScore": 29,
    "nettScore": 29,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 7,
        "rawValue": "7",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 21,
        "rawValue": "21",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 1,
        "rawValue": "1",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 6,
    "sailorName": "Timothy Kai Zhe Ng",
    "sailNumber": "2023",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "TAO NAN SCHOOL",
    "club": "Constant Wind SeaSports",
    "totalScore": 31,
    "nettScore": 31,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 9,
        "rawValue": "9",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 17,
        "rawValue": "17",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 5,
        "rawValue": "5",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 7,
    "sailorName": "Kevin Jun Yi Ho",
    "sailNumber": "171",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "RAFFLES INSTITUTION",
    "club": "SAF Yacht Club",
    "totalScore": 36,
    "nettScore": 36,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 16,
        "rawValue": "16",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 6,
        "rawValue": "6",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 14,
        "rawValue": "14",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 8,
    "sailorName": "Lavene Rui Xuan Lim",
    "sailNumber": "3553",
    "ageCategory": "11-12 yo",
    "gender": "F",
    "schoolName": "PASIR RIS PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 38,
    "nettScore": 38,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 6,
        "rawValue": "6",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 22,
        "rawValue": "22",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 10,
        "rawValue": "10",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 9,
    "sailorName": "Jedd Zhi Hao Lam",
    "sailNumber": "2000",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "RAFFLES INSTITUTION",
    "club": "Constant Wind SeaSports",
    "totalScore": 39,
    "nettScore": 39,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 19,
        "rawValue": "19",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 5,
        "rawValue": "5",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 15,
        "rawValue": "15",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 10,
    "sailorName": "Dan Guan You Toh",
    "sailNumber": "3811",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "MARIS STELLA HIGH SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 42,
    "nettScore": 42,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 3,
        "rawValue": "3",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 27,
        "rawValue": "27",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 12,
        "rawValue": "12",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 11,
    "sailorName": "Nathaniel Kaiden Ng",
    "sailNumber": "3344",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (INDEPENDENT)",
    "club": "PAssion Wave",
    "totalScore": 43,
    "nettScore": 43,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 17,
        "rawValue": "17",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 2,
        "rawValue": "2",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 24,
        "rawValue": "24",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 12,
    "sailorName": "Elliot Goh",
    "sailNumber": "3103",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (INDEPENDENT)",
    "club": "SAF Yacht Club",
    "totalScore": 43,
    "nettScore": 43,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 24,
        "rawValue": "24",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 3,
        "rawValue": "3",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 16,
        "rawValue": "16",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 13,
    "sailorName": "Jairus Xin Jie Teo",
    "sailNumber": "4073",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "ST. ANDREW'S SECONDARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 44,
    "nettScore": 44,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 5,
        "rawValue": "5",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 20,
        "rawValue": "20",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 19,
        "rawValue": "19",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 14,
    "sailorName": "Mikaela Hui Ting Wong",
    "sailNumber": "3029",
    "ageCategory": "11-12 yo",
    "gender": "F",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 46,
    "nettScore": 46,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 10,
        "rawValue": "10",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 18,
        "rawValue": "18",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 18,
        "rawValue": "18",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 15,
    "sailorName": "Aaron Zhiyi Chiang",
    "sailNumber": "3128",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "TAO NAN SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 59,
    "nettScore": 59,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 1,
        "rawValue": "1",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 32,
        "rawValue": "32",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 26,
        "rawValue": "26",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 16,
    "sailorName": "Katelynn Kai En Lee",
    "sailNumber": "3383",
    "ageCategory": "11-12 yo",
    "gender": "F",
    "schoolName": "ST. ANTHONY'S CANOSSIAN PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 62,
    "nettScore": 62,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 2,
        "rawValue": "2",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 24,
        "rawValue": "24",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 36,
        "rawValue": "36",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 17,
    "sailorName": "Aidan Armand Anuar",
    "sailNumber": "3143",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "TANJONG KATONG PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 62,
    "nettScore": 62,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 46,
        "rawValue": "46",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 10,
        "rawValue": "10",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 6,
        "rawValue": "6",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 18,
    "sailorName": "Jaye Xi En Low",
    "sailNumber": "3279",
    "ageCategory": null,
    "gender": "F",
    "schoolName": "DUNMAN HIGH SCHOOL",
    "club": "PAssion Wave",
    "totalScore": 66,
    "nettScore": 66,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 20,
        "rawValue": "20",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 26,
        "rawValue": "26",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 20,
        "rawValue": "20",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 19,
    "sailorName": "Jeremiah Rui Feng Ong",
    "sailNumber": "3373",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 70,
    "nettScore": 70,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 38,
        "rawValue": "38",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 15,
        "rawValue": "15",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 17,
        "rawValue": "17",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 20,
    "sailorName": "Edrei En Xu Ong",
    "sailNumber": "3957",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 73,
    "nettScore": 73,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 36,
        "rawValue": "36",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 29,
        "rawValue": "29",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 8,
        "rawValue": "8",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 21,
    "sailorName": "Ethan Zhi Ren Low",
    "sailNumber": "78",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 75,
    "nettScore": 75,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 25,
        "rawValue": "25",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 16,
        "rawValue": "16",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 34,
        "rawValue": "34",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 22,
    "sailorName": "Rachel Qian Hui Lim",
    "sailNumber": "3197",
    "ageCategory": "11-12 yo",
    "gender": "F",
    "schoolName": "HAIG GIRLS' SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 76,
    "nettScore": 76,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 8,
        "rawValue": "8",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 30,
        "rawValue": "30",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 38,
        "rawValue": "38",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 23,
    "sailorName": "Xuan Ya Tong",
    "sailNumber": "107",
    "ageCategory": null,
    "gender": "F",
    "schoolName": null,
    "club": "Constant Wind SeaSports",
    "totalScore": 76,
    "nettScore": 76,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 33,
        "rawValue": "33",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 12,
        "rawValue": "12",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 31,
        "rawValue": "31",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 24,
    "sailorName": "Siti Ra'idah Binte Mohd Airudin",
    "sailNumber": "1141",
    "ageCategory": null,
    "gender": "F",
    "schoolName": "ORCHID PARK SECONDARY SCHOOL",
    "club": "PAssion Wave",
    "totalScore": 77,
    "nettScore": 77,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 35,
        "rawValue": "35",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 7,
        "rawValue": "7",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 35,
        "rawValue": "35",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 25,
    "sailorName": "Padmaeja Rajakanth",
    "sailNumber": "2022",
    "ageCategory": "11-12 yo",
    "gender": "F",
    "schoolName": "RAFFLES GIRLS' PRIMARY SCHOOL",
    "club": "Constant Wind SeaSports",
    "totalScore": 79,
    "nettScore": 79,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 37,
        "rawValue": "37",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 19,
        "rawValue": "19",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 23,
        "rawValue": "23",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 26,
    "sailorName": "Joseph Kia Guan Tan",
    "sailNumber": "3688",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "ST. JOSEPH'S INSTITUTION",
    "club": "SAF Yacht Club",
    "totalScore": 80,
    "nettScore": 80,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 12,
        "rawValue": "12",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 39,
        "rawValue": "39",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 29,
        "rawValue": "29",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 27,
    "sailorName": "Olivia Ting Jia Cheong",
    "sailNumber": "3002",
    "ageCategory": null,
    "gender": "F",
    "schoolName": "RAFFLES GIRLS' SCHOOL (SECONDARY)",
    "club": "SAF Yacht Club",
    "totalScore": 85,
    "nettScore": 85,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 29,
        "rawValue": "29",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 14,
        "rawValue": "14",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 42,
        "rawValue": "42",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 28,
    "sailorName": "Abby Yan Ying Chen",
    "sailNumber": "4729",
    "ageCategory": "9-10 yo",
    "gender": "F",
    "schoolName": "CHIJ ST. NICHOLAS GIRLS' SCHOOL",
    "club": "PAssion Wave",
    "totalScore": 87,
    "nettScore": 87,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 43,
        "rawValue": "43",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 33,
        "rawValue": "33",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 11,
        "rawValue": "11",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 29,
    "sailorName": "William Poon",
    "sailNumber": "21",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "SINGAPORE AMERICAN SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 90,
    "nettScore": 90,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 28,
        "rawValue": "28",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 8,
        "rawValue": "8",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 54,
        "rawValue": "54",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 30,
    "sailorName": "Joshua Zhi Kai Tan",
    "sailNumber": "3036",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "SAF Yacht Club",
    "totalScore": 92,
    "nettScore": 92,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 18,
        "rawValue": "18",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 47,
        "rawValue": "47",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 27,
        "rawValue": "27",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 31,
    "sailorName": "Chen-Yi Kai",
    "sailNumber": "757",
    "ageCategory": "9-10 yo",
    "gender": "M",
    "schoolName": "FAIRFIELD METHODIST SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 98,
    "nettScore": 98,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 13,
        "rawValue": "13",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 63,
        "rawValue": "63",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 22,
        "rawValue": "22",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 32,
    "sailorName": "Hayley Kai En Tan",
    "sailNumber": "700",
    "ageCategory": "9-10 yo",
    "gender": "F",
    "schoolName": "KONG HWA SCHOOL",
    "club": "Changi Sailing Club",
    "totalScore": 99,
    "nettScore": 99,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 22,
        "rawValue": "22",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 34,
        "rawValue": "34",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 43,
        "rawValue": "43",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 33,
    "sailorName": "Lucas Jun Sheng Seow",
    "sailNumber": "2047",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "TAO NAN SCHOOL",
    "club": "Constant Wind SeaSports",
    "totalScore": 108,
    "nettScore": 108,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 41,
        "rawValue": "41",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 28,
        "rawValue": "28",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 39,
        "rawValue": "39",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 34,
    "sailorName": "Quintan Rupert Low",
    "sailNumber": "4681",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "SAF Yacht Club",
    "totalScore": 112,
    "nettScore": 112,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 23,
        "rawValue": "23",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 38,
        "rawValue": "38",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 51,
        "rawValue": "51",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 35,
    "sailorName": "Yvette Yi Min Chow",
    "sailNumber": "3151",
    "ageCategory": "11-12 yo",
    "gender": "F",
    "schoolName": "PEI HWA PRESBYTERIAN PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 112,
    "nettScore": 112,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 48,
        "rawValue": "48",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 23,
        "rawValue": "23",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 41,
        "rawValue": "41",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 36,
    "sailorName": "Xavier Yang Zheng Puah",
    "sailNumber": "2037",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ST. JOSEPH'S INSTITUTION JUNIOR",
    "club": "Constant Wind SeaSports",
    "totalScore": 114,
    "nettScore": 114,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 42,
        "rawValue": "42",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 44,
        "rawValue": "44",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 28,
        "rawValue": "28",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 37,
    "sailorName": "Rahul Rajakanth",
    "sailNumber": "2006",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (INDEPENDENT)",
    "club": "Constant Wind SeaSports",
    "totalScore": 120,
    "nettScore": 120,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 26,
        "rawValue": "26",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 87,
        "rawValue": "87 BFD",
        "scoringCode": "BFD",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 7,
        "rawValue": "7",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 38,
    "sailorName": "Kaelyn Dayna Zhi Yi Soh",
    "sailNumber": "3113",
    "ageCategory": null,
    "gender": "F",
    "schoolName": "RAFFLES GIRLS' SCHOOL (SECONDARY)",
    "club": "SAF Yacht Club",
    "totalScore": 123,
    "nettScore": 123,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 27,
        "rawValue": "27",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 87,
        "rawValue": "87 BFD",
        "scoringCode": "BFD",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 9,
        "rawValue": "9",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 39,
    "sailorName": "Kirsten En Ting Tan",
    "sailNumber": "3663",
    "ageCategory": "9-10 yo",
    "gender": "F",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 123,
    "nettScore": 123,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DSQ",
        "scoringCode": "DSQ",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 11,
        "rawValue": "11",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 25,
        "rawValue": "25",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 40,
    "sailorName": "Ashleigh Li Ying Teh",
    "sailNumber": "788",
    "ageCategory": "9-10 yo",
    "gender": "F",
    "schoolName": "TAO NAN SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 125,
    "nettScore": 125,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 32,
        "rawValue": "32",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 36,
        "rawValue": "36",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 57,
        "rawValue": "57",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 41,
    "sailorName": "Christopher Soh",
    "sailNumber": "3168",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "TAO NAN SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 126,
    "nettScore": 126,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 51,
        "rawValue": "51",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 42,
        "rawValue": "42",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 33,
        "rawValue": "33",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 42,
    "sailorName": "Euan Hao Xuan Poh",
    "sailNumber": "2030",
    "ageCategory": "9-10 yo",
    "gender": "M",
    "schoolName": "TAO NAN SCHOOL",
    "club": "Constant Wind SeaSports",
    "totalScore": 129,
    "nettScore": 129,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 40,
        "rawValue": "40",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 41,
        "rawValue": "41",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 48,
        "rawValue": "48",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 43,
    "sailorName": "Ashlyn Tham",
    "sailNumber": "100",
    "ageCategory": null,
    "gender": "F",
    "schoolName": "ST. HILDA'S SECONDARY SCHOOL",
    "club": "PAssion Wave",
    "totalScore": 130,
    "nettScore": 130,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 30,
        "rawValue": "30",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 87,
        "rawValue": "87 BFD",
        "scoringCode": "BFD",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 13,
        "rawValue": "13",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 44,
    "sailorName": "Dylan Yue Teng Goh",
    "sailNumber": "3800",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "VICTORIA SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 133,
    "nettScore": 133,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 45,
        "rawValue": "45",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 35,
        "rawValue": "35",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 53,
        "rawValue": "53",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 45,
    "sailorName": "Meera Srihari",
    "sailNumber": "3889",
    "ageCategory": "9-10 yo",
    "gender": "F",
    "schoolName": "RAFFLES GIRLS' PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 136,
    "nettScore": 136,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 53,
        "rawValue": "53",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 43,
        "rawValue": "43",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 40,
        "rawValue": "40",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 46,
    "sailorName": "Luke Yi Jie Loh",
    "sailNumber": "3322",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "TAO NAN SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 137,
    "nettScore": 137,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 47,
        "rawValue": "47",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 40,
        "rawValue": "40",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 50,
        "rawValue": "50",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 47,
    "sailorName": "Isabelle Xinyi Zhang",
    "sailNumber": "2035",
    "ageCategory": "9-10 yo",
    "gender": "F",
    "schoolName": "METHODIST GIRLS' SCHOOL",
    "club": "Constant Wind SeaSports",
    "totalScore": 142,
    "nettScore": 142,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 21,
        "rawValue": "21",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 50,
        "rawValue": "50",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 71,
        "rawValue": "71",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 48,
    "sailorName": "Boren Wang",
    "sailNumber": "2039",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ALEXANDRA PRIMARY SCHOOL",
    "club": "PAssion Wave",
    "totalScore": 143,
    "nettScore": 143,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 49,
        "rawValue": "49",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 57,
        "rawValue": "57",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 37,
        "rawValue": "37",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 49,
    "sailorName": "Yen Yu Kai",
    "sailNumber": "758",
    "ageCategory": null,
    "gender": "F",
    "schoolName": "RAFFLES GIRLS' SCHOOL (SECONDARY)",
    "club": "Changi Sailing Club",
    "totalScore": 147,
    "nettScore": 147,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 50,
        "rawValue": "50",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 48,
        "rawValue": "48",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 49,
        "rawValue": "49",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 50,
    "sailorName": "Herng Yee Tan",
    "sailNumber": "3000",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (INDEPENDENT)",
    "club": "SAF Yacht Club",
    "totalScore": 152,
    "nettScore": 152,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 39,
        "rawValue": "39",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 83,
        "rawValue": "83 DNF",
        "scoringCode": "DNF",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 30,
        "rawValue": "30",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 51,
    "sailorName": "Damien Huang",
    "sailNumber": "3300",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "RAFFLES INSTITUTION",
    "club": "SAF Yacht Club",
    "totalScore": 153,
    "nettScore": 153,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 34,
        "rawValue": "34",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 87,
        "rawValue": "87 BFD",
        "scoringCode": "BFD",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 32,
        "rawValue": "32",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 52,
    "sailorName": "Joel Zhuo Le Khoo",
    "sailNumber": "4730",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "NANYANG PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 161,
    "nettScore": 161,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 31,
        "rawValue": "31",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 71,
        "rawValue": "71",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 59,
        "rawValue": "59",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 53,
    "sailorName": "Auwin Zhao Hong Leow",
    "sailNumber": "3405",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (PRIMARY)",
    "club": "SAF Yacht Club",
    "totalScore": 162,
    "nettScore": 162,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 64,
        "rawValue": "64",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 54,
        "rawValue": "54",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 44,
        "rawValue": "44",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 54,
    "sailorName": "Nigel Jiang Long Ng",
    "sailNumber": "3363",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ENDEAVOUR PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 163,
    "nettScore": 163,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 52,
        "rawValue": "52",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 45,
        "rawValue": "45",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 66,
        "rawValue": "66",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 55,
    "sailorName": "Tyler Koo",
    "sailNumber": "996",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "Republic of Singapore Yacht Club",
    "totalScore": 164,
    "nettScore": 164,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 59,
        "rawValue": "59",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 60,
        "rawValue": "60",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 45,
        "rawValue": "45",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 56,
    "sailorName": "Matthias Kai Lun Lee",
    "sailNumber": "3385",
    "ageCategory": "9-10 yo",
    "gender": "M",
    "schoolName": "MARIS STELLA HIGH SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 170,
    "nettScore": 170,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 60,
        "rawValue": "60",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 31,
        "rawValue": "31",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 79,
        "rawValue": "79",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 57,
    "sailorName": "Hanyue Ouyang",
    "sailNumber": "5003",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "NANYANG PRIMARY SCHOOL",
    "club": "ONE°15 Marina Club",
    "totalScore": 172,
    "nettScore": 172,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 55,
        "rawValue": "55",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 65,
        "rawValue": "65",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 52,
        "rawValue": "52",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 58,
    "sailorName": "Joash Jit Yin Kok",
    "sailNumber": "3057",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (INDEPENDENT)",
    "club": "PAssion Wave",
    "totalScore": 174,
    "nettScore": 174,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 57,
        "rawValue": "57",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 52,
        "rawValue": "52",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 65,
        "rawValue": "65",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 59,
    "sailorName": "Iver Lee Zhe Xi",
    "sailNumber": "3309",
    "ageCategory": "9-10 yo",
    "gender": "M",
    "schoolName": "ENDEAVOUR PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 179,
    "nettScore": 179,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 56,
        "rawValue": "56",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 61,
        "rawValue": "61",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 62,
        "rawValue": "62",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 60,
    "sailorName": "Kenji Huan Zhe Tan",
    "sailNumber": "3999",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "MAYFLOWER SECONDARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 183,
    "nettScore": 183,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 70,
        "rawValue": "70",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 66,
        "rawValue": "66",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 47,
        "rawValue": "47",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 61,
    "sailorName": "George Kai Whittington",
    "sailNumber": "799",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ST STEPHEN SCHOOL",
    "club": "Changi Sailing Club",
    "totalScore": 184,
    "nettScore": 184,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNS",
        "scoringCode": "DNS",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 51,
        "rawValue": "51",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 46,
        "rawValue": "46",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 62,
    "sailorName": "Hagen Goh",
    "sailNumber": "3600",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "DOVER COURT INTERNATIONAL SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 185,
    "nettScore": 185,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 62,
        "rawValue": "62",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 56,
        "rawValue": "56",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 67,
        "rawValue": "67",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 63,
    "sailorName": "Jude Nathan Wong",
    "sailNumber": "3495",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "SAF Yacht Club",
    "totalScore": 186,
    "nettScore": 186,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 44,
        "rawValue": "44",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 87,
        "rawValue": "87 BFD",
        "scoringCode": "BFD",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 55,
        "rawValue": "55",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 64,
    "sailorName": "Estelle Rui En Yeo",
    "sailNumber": "773",
    "ageCategory": "11-12 yo",
    "gender": "F",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "Changi Sailing Club",
    "totalScore": 186,
    "nettScore": 186,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 65,
        "rawValue": "65",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 46,
        "rawValue": "46",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 75,
        "rawValue": "75",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 65,
    "sailorName": "Arun John Behl",
    "sailNumber": "88",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "BUKIT MERAH SECONDARY SCHOOL",
    "club": "Changi Sailing Club",
    "totalScore": 188,
    "nettScore": 188,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNS",
        "scoringCode": "DNS",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 37,
        "rawValue": "37",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 64,
        "rawValue": "64",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 66,
    "sailorName": "Yasin Yusuf Yusfianshah",
    "sailNumber": "3575",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 188,
    "nettScore": 188,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 66,
        "rawValue": "66",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 59,
        "rawValue": "59",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 63,
        "rawValue": "63",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 67,
    "sailorName": "Su Yuan",
    "sailNumber": "3043",
    "ageCategory": null,
    "gender": "F",
    "schoolName": "CHIJ (KATONG) PRIMARY",
    "club": "SAF Yacht Club",
    "totalScore": 189,
    "nettScore": 189,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 69,
        "rawValue": "69",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 64,
        "rawValue": "64",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 56,
        "rawValue": "56",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 68,
    "sailorName": "Ivor Lee Zhuo Xi",
    "sailNumber": "3306",
    "ageCategory": "9-10 yo",
    "gender": "M",
    "schoolName": "ENDEAVOUR PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 190,
    "nettScore": 190,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNS",
        "scoringCode": "DNS",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 25,
        "rawValue": "25",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 78,
        "rawValue": "78",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 69,
    "sailorName": "Ryan Yong Jie Choo",
    "sailNumber": "789",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "Changi Sailing Club",
    "totalScore": 198,
    "nettScore": 198,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNS",
        "scoringCode": "DNS",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 53,
        "rawValue": "53",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 58,
        "rawValue": "58",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 70,
    "sailorName": "Breyven Zhi Long Chan",
    "sailNumber": "3338",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "ENDEAVOUR PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 198,
    "nettScore": 198,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 61,
        "rawValue": "61",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 67,
        "rawValue": "67",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 70,
        "rawValue": "70",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 71,
    "sailorName": "Charlene Heng Ning Yong",
    "sailNumber": "SGP766",
    "ageCategory": "11-12 yo",
    "gender": "F",
    "schoolName": "PASIR RIS PRIMARY SCHOOL",
    "club": "Changi Sailing Club",
    "totalScore": 201,
    "nettScore": 201,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 54,
        "rawValue": "54",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 87,
        "rawValue": "87 BFD",
        "scoringCode": "BFD",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 60,
        "rawValue": "60",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 72,
    "sailorName": "Yuk Pin Lim",
    "sailNumber": "3880",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "ST. JOSEPH'S INSTITUTION",
    "club": "SAF Yacht Club",
    "totalScore": 203,
    "nettScore": 203,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNS",
        "scoringCode": "DNS",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 55,
        "rawValue": "55",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 61,
        "rawValue": "61",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 73,
    "sailorName": "Weihan Mao",
    "sailNumber": "3619",
    "ageCategory": "11-12 yo",
    "gender": "F",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 204,
    "nettScore": 204,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNS",
        "scoringCode": "DNS",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 49,
        "rawValue": "49",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 68,
        "rawValue": "68",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 74,
    "sailorName": "Evan En Kai Ong",
    "sailNumber": "3955",
    "ageCategory": "9-10 yo",
    "gender": "M",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 207,
    "nettScore": 207,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 67,
        "rawValue": "67",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 68,
        "rawValue": "68",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 72,
        "rawValue": "72",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 75,
    "sailorName": "Shen Jie Teo",
    "sailNumber": "3870",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "RAFFLES INSTITUTION",
    "club": "SAF Yacht Club",
    "totalScore": 211,
    "nettScore": 211,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 63,
        "rawValue": "63",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 74,
        "rawValue": "74",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 74,
        "rawValue": "74",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 76,
    "sailorName": "Kai Jie Teo",
    "sailNumber": "3550",
    "ageCategory": "9-10 yo",
    "gender": "M",
    "schoolName": "TANJONG KATONG PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 213,
    "nettScore": 213,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 58,
        "rawValue": "58",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 73,
        "rawValue": "73",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 82,
        "rawValue": "82",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 77,
    "sailorName": "Sage Yeh",
    "sailNumber": "796",
    "ageCategory": "11-12 yo",
    "gender": "F",
    "schoolName": "PUNGGOL COVE PRIMARY SCHOOL",
    "club": "Changi Sailing Club",
    "totalScore": 222,
    "nettScore": 222,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNS",
        "scoringCode": "DNS",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 58,
        "rawValue": "58",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 77,
        "rawValue": "77",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 78,
    "sailorName": "Clara Siew Ning Ng",
    "sailNumber": "3739",
    "ageCategory": "11-12 yo",
    "gender": "F",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 222,
    "nettScore": 222,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNS",
        "scoringCode": "DNS",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 62,
        "rawValue": "62",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 73,
        "rawValue": "73",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 79,
    "sailorName": "Zachary Zhi En Low",
    "sailNumber": "3369",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "ST. JOSEPH'S INSTITUTION",
    "club": "SAF Yacht Club",
    "totalScore": 226,
    "nettScore": 226,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNS",
        "scoringCode": "DNS",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 70,
        "rawValue": "70",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 69,
        "rawValue": "69",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 80,
    "sailorName": "Gloria Yen Rui Kwok",
    "sailNumber": "2004",
    "ageCategory": "11-12 yo",
    "gender": "F",
    "schoolName": "CHIJ (KATONG) PRIMARY",
    "club": "Constant Wind SeaSports",
    "totalScore": 232,
    "nettScore": 232,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 68,
        "rawValue": "68",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 83,
        "rawValue": "83 DNF",
        "scoringCode": "DNF",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 81,
        "rawValue": "81",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 81,
    "sailorName": "Zachary Hoo",
    "sailNumber": "2051",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "RED SWASTIKA SCHOOL",
    "club": "Constant Wind SeaSports",
    "totalScore": 235,
    "nettScore": 235,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNS",
        "scoringCode": "DNS",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 72,
        "rawValue": "72",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 76,
        "rawValue": "76",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 82,
    "sailorName": "Yan Cheng Loh",
    "sailNumber": "3717",
    "ageCategory": "9-10 yo",
    "gender": "M",
    "schoolName": "NAN CHIAU PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 236,
    "nettScore": 236,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNS",
        "scoringCode": "DNS",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 69,
        "rawValue": "69",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 80,
        "rawValue": "80",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 83,
    "sailorName": "Luke Tin Fong",
    "sailNumber": "2019",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "TAO NAN SCHOOL",
    "club": "Constant Wind SeaSports",
    "totalScore": 261,
    "nettScore": 261,
    "isDns": true,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNC",
        "scoringCode": "DNC",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 87,
        "rawValue": "87 DNC",
        "scoringCode": "DNC",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 87,
        "rawValue": "87 DNC",
        "scoringCode": "DNC",
        "discarded": false
      }
    ]
  },
  {
    "rank": 83,
    "sailorName": "Matthew Qin Hao Chiam",
    "sailNumber": "3606",
    "ageCategory": "11-12 yo",
    "gender": "M",
    "schoolName": "AI TONG SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 261,
    "nettScore": 261,
    "isDns": true,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNC",
        "scoringCode": "DNC",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 87,
        "rawValue": "87 DNC",
        "scoringCode": "DNC",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 87,
        "rawValue": "87 DNC",
        "scoringCode": "DNC",
        "discarded": false
      }
    ]
  },
  {
    "rank": 83,
    "sailorName": "Ethan Jing Zhou Tan",
    "sailNumber": "3772",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "VICTORIA SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 261,
    "nettScore": 261,
    "isDns": true,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNC",
        "scoringCode": "DNC",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 87,
        "rawValue": "87 DNC",
        "scoringCode": "DNC",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 87,
        "rawValue": "87 DNC",
        "scoringCode": "DNC",
        "discarded": false
      }
    ]
  },
  {
    "rank": 83,
    "sailorName": "Ethan Lee",
    "sailNumber": "83",
    "ageCategory": null,
    "gender": "M",
    "schoolName": "VICTORIA SCHOOL",
    "club": "PAssion Wave",
    "totalScore": 261,
    "nettScore": 261,
    "isDns": true,
    "races": [
      {
        "raceNumber": 1,
        "score": 87,
        "rawValue": "87 DNC",
        "scoringCode": "DNC",
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 87,
        "rawValue": "87 DNC",
        "scoringCode": "DNC",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 87,
        "rawValue": "87 DNC",
        "scoringCode": "DNC",
        "discarded": false
      }
    ]
  }
];

export const CINCAPURA_2026_SILVER_RESULTS: CincapuraCompetitorResult[] = [
  {
    "rank": 1,
    "sailorName": "Adele Ziyi Chiang",
    "sailNumber": "3120",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "F",
    "schoolName": "TAO NAN SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 23,
    "nettScore": 11,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 3,
        "rawValue": "3",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 6,
        "rawValue": "6",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 2,
        "rawValue": "2",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 12,
        "rawValue": "(12)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 2,
    "sailorName": "Bryan Thian Tsek Lee",
    "sailNumber": "3508",
    "ageCategory": null,
    "novice": false,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "SAF Yacht Club",
    "totalScore": 35,
    "nettScore": 13,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 4,
        "rawValue": "4",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 5,
        "rawValue": "5",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 22,
        "rawValue": "(22)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 4,
        "rawValue": "4",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 3,
    "sailorName": "Ryan Feiran Zheng",
    "sailNumber": "2045",
    "ageCategory": null,
    "novice": false,
    "gender": "M",
    "schoolName": "ST. STEPHEN'S SCHOOL",
    "club": "Constant Wind SeaSport",
    "totalScore": 38,
    "nettScore": 18,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 6,
        "rawValue": "6",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 1,
        "rawValue": "1",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 20,
        "rawValue": "(20)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 11,
        "rawValue": "11",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 4,
    "sailorName": "Kiyansh Kanishk Singh",
    "sailNumber": "2046",
    "ageCategory": null,
    "novice": false,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "Constant Wind SeaSport",
    "totalScore": 41,
    "nettScore": 18,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 7,
        "rawValue": "7",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 10,
        "rawValue": "10",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 23,
        "rawValue": "(23)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 1,
        "rawValue": "1",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 5,
    "sailorName": "Yong Le Wai",
    "sailNumber": "3488",
    "ageCategory": null,
    "novice": false,
    "gender": "M",
    "schoolName": "FIRST TOA PAYOH PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 48,
    "nettScore": 20,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 12,
        "rawValue": "12",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 2,
        "rawValue": "2",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 28,
        "rawValue": "(28)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 6,
        "rawValue": "6",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 6,
    "sailorName": "Muhammad Rehan Bin Mohamed Salim",
    "sailNumber": "2059",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "WHITE SANDS PRIMARY SCHOOL",
    "club": "Constant Wind SeaSport",
    "totalScore": 42,
    "nettScore": 21,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 21,
        "rawValue": "(21)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 2,
        "score": 8,
        "rawValue": "8",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 3,
        "rawValue": "3",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 10,
        "rawValue": "10",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 7,
    "sailorName": "Axel Lin",
    "sailNumber": "720",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "NANYANG PRIMARY SCHOOL",
    "club": "Changi Sailing Club",
    "totalScore": 37,
    "nettScore": 24,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 13,
        "rawValue": "(13)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 2,
        "score": 9,
        "rawValue": "9",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 6,
        "rawValue": "6",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 9,
        "rawValue": "9",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 8,
    "sailorName": "Henry Shayan Mittelhauser",
    "sailNumber": "2052",
    "ageCategory": null,
    "novice": false,
    "gender": "M",
    "schoolName": "TANJONG KATONG PRIMARY SCHOOL",
    "club": "Constant Wind SeaSport",
    "totalScore": 80,
    "nettScore": 25,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 18,
        "rawValue": "18",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 4,
        "rawValue": "4",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 55,
        "rawValue": "(55 UFD)",
        "scoringCode": "UFD",
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 3,
        "rawValue": "3",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 9,
    "sailorName": "Moyan Han",
    "sailNumber": "2042",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "NAN HUA PRIMARY SCHOOL",
    "club": "Constant Wind SeaSport",
    "totalScore": 38,
    "nettScore": 26,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 11,
        "rawValue": "11",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 7,
        "rawValue": "7",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 12,
        "rawValue": "(12)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 8,
        "rawValue": "8",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 10,
    "sailorName": "Damien Seah",
    "sailNumber": "3825",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 46,
    "nettScore": 29,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 10,
        "rawValue": "10",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 3,
        "rawValue": "3",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 16,
        "rawValue": "16",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 17,
        "rawValue": "(17)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 11,
    "sailorName": "Jade Tan",
    "sailNumber": "3425",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "F",
    "schoolName": "AI TONG SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 47,
    "nettScore": 30,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 17,
        "rawValue": "(17)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 2,
        "score": 17,
        "rawValue": "17",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 8,
        "rawValue": "8",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 5,
        "rawValue": "5",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 12,
    "sailorName": "Hongren Wang",
    "sailNumber": "2039",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "ALEXANDRA PRIMARY SCHOOL",
    "club": "PAssion Wave",
    "totalScore": 57,
    "nettScore": 31,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 1,
        "rawValue": "1",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 15,
        "rawValue": "15",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 15,
        "rawValue": "15",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 26,
        "rawValue": "(26)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 13,
    "sailorName": "Isaac Tan",
    "sailNumber": "2055",
    "ageCategory": null,
    "novice": false,
    "gender": "M",
    "schoolName": "ANGLICAN HIGH SCHOOL",
    "club": "Constant Wind SeaSport",
    "totalScore": 66,
    "nettScore": 33,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 2,
        "rawValue": "2",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 24,
        "rawValue": "24",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 33,
        "rawValue": "(33)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 7,
        "rawValue": "7",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 14,
    "sailorName": "Skyler Kang",
    "sailNumber": "2041",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "Constant Wind SeaSport",
    "totalScore": 54,
    "nettScore": 35,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 8,
        "rawValue": "8",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 13,
        "rawValue": "13",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 19,
        "rawValue": "(19)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 14,
        "rawValue": "14",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 15,
    "sailorName": "Thaddaeus Renz",
    "sailNumber": "2058",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "Constant Wind SeaSport",
    "totalScore": 92,
    "nettScore": 37,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 24,
        "rawValue": "24",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 11,
        "rawValue": "11",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 55,
        "rawValue": "(55 UFD)",
        "scoringCode": "UFD",
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 2,
        "rawValue": "2",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 16,
    "sailorName": "Sven Xin Chen Lim",
    "sailNumber": "3893",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "TAO NAN SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 58,
    "nettScore": 38,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 5,
        "rawValue": "5",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 20,
        "rawValue": "(20)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 3,
        "score": 13,
        "rawValue": "13",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 20,
        "rawValue": "20",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 17,
    "sailorName": "Ian Siak Yiak Goh",
    "sailNumber": "3818",
    "ageCategory": null,
    "novice": false,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "SAF Yacht Club",
    "totalScore": 79,
    "nettScore": 46,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 29,
        "rawValue": "29",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 33,
        "rawValue": "(33)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 3,
        "score": 4,
        "rawValue": "4",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 13,
        "rawValue": "13",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 18,
    "sailorName": "Neel Paul Behl",
    "sailNumber": "734",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "ZHANGDE PRIMARY SCHOOL",
    "club": "Changi Sailing Club",
    "totalScore": 81,
    "nettScore": 47,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 15,
        "rawValue": "15",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 27,
        "rawValue": "27",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 5,
        "rawValue": "5",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 34,
        "rawValue": "(34)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 19,
    "sailorName": "Jiaqian Wu",
    "sailNumber": "3424",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 89,
    "nettScore": 49,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 25,
        "rawValue": "25",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 23,
        "rawValue": "23",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 1,
        "rawValue": "1",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 40,
        "rawValue": "(40)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 20,
    "sailorName": "Jae Guan Yu Toh",
    "sailNumber": "3311",
    "ageCategory": "8&U",
    "novice": false,
    "gender": "M",
    "schoolName": "MARIS STELLA HIGH SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 92,
    "nettScore": 53,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 9,
        "rawValue": "9",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 39,
        "rawValue": "(39)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 3,
        "score": 9,
        "rawValue": "9",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 35,
        "rawValue": "35",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 21,
    "sailorName": "Enzo Kengsin Teo",
    "sailNumber": "2044",
    "ageCategory": null,
    "novice": false,
    "gender": "M",
    "schoolName": "ST. STEPHEN'S SCHOOL",
    "club": "Constant Wind SeaSport",
    "totalScore": 81,
    "nettScore": 55,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 16,
        "rawValue": "16",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 16,
        "rawValue": "16",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 26,
        "rawValue": "(26)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 23,
        "rawValue": "23",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 22,
    "sailorName": "Ilysha Wong",
    "sailNumber": "2053",
    "ageCategory": null,
    "novice": false,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "Constant Wind SeaSport",
    "totalScore": 87,
    "nettScore": 59,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 28,
        "rawValue": "(28)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 2,
        "score": 14,
        "rawValue": "14",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 27,
        "rawValue": "27",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 18,
        "rawValue": "18",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 23,
    "sailorName": "Luca Kexing Yang",
    "sailNumber": "707",
    "ageCategory": null,
    "novice": false,
    "gender": "M",
    "schoolName": "UNITED WORLD COLLEGE (SEA)",
    "club": "Changi Sailing Club",
    "totalScore": 92,
    "nettScore": 59,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 33,
        "rawValue": "(33)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 2,
        "score": 26,
        "rawValue": "26",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 17,
        "rawValue": "17",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 16,
        "rawValue": "16",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 24,
    "sailorName": "Ian Shao Feng Teng",
    "sailNumber": "718",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "TAO NAN SCHOOL",
    "club": "Changi Sailing Club",
    "totalScore": 101,
    "nettScore": 60,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 32,
        "rawValue": "32",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 21,
        "rawValue": "21",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 7,
        "rawValue": "7",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 41,
        "rawValue": "(41)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 25,
    "sailorName": "Jerome Puah Yang Yi",
    "sailNumber": "2037",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "ST. JOSEPH'S INSTITUTION JUNIOR",
    "club": "PAssion Wave",
    "totalScore": 115,
    "nettScore": 60,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 27,
        "rawValue": "27",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 18,
        "rawValue": "18",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 55,
        "rawValue": "(55 UFD)",
        "scoringCode": "UFD",
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 15,
        "rawValue": "15",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 26,
    "sailorName": "Nadia Zahedi",
    "sailNumber": "4724",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "F",
    "schoolName": "TAO NAN SCHOOL",
    "club": "PAssion Wave",
    "totalScore": 99,
    "nettScore": 62,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 19,
        "rawValue": "19",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 22,
        "rawValue": "22",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 37,
        "rawValue": "(37)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 21,
        "rawValue": "21",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 27,
    "sailorName": "Seraphina Kang",
    "sailNumber": "2040",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "F",
    "schoolName": "CHIJ OUR LADY QUEEN OF PEACE",
    "club": "Constant Wind SeaSport",
    "totalScore": 99,
    "nettScore": 63,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 26,
        "rawValue": "26",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 12,
        "rawValue": "12",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 36,
        "rawValue": "(36)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 25,
        "rawValue": "25",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 28,
    "sailorName": "Isaias Cheow",
    "sailNumber": "3307",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (PRIMARY)",
    "club": "SAF Yacht Club",
    "totalScore": 99,
    "nettScore": 63,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 14,
        "rawValue": "14",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 36,
        "rawValue": "(36)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 3,
        "score": 21,
        "rawValue": "21",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 28,
        "rawValue": "28",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 29,
    "sailorName": "Jiayi Du",
    "sailNumber": "3141",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "ST. GABRIEL'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 96,
    "nettScore": 66,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 22,
        "rawValue": "22",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 19,
        "rawValue": "19",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 25,
        "rawValue": "25",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 30,
        "rawValue": "(30)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 30,
    "sailorName": "Sumire Sayawaki-Kogut",
    "sailNumber": "710",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "F",
    "schoolName": "UNITED WORLD COLLEGE (SEA)",
    "club": "Changi Sailing Club",
    "totalScore": 112,
    "nettScore": 73,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 20,
        "rawValue": "20",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 35,
        "rawValue": "35",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 18,
        "rawValue": "18",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 39,
        "rawValue": "(39)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 31,
    "sailorName": "Llewellyn Ding Zhe Tay",
    "sailNumber": "3013",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "TAO NAN SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 103,
    "nettScore": 74,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 23,
        "rawValue": "23",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 29,
        "rawValue": "(29)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 3,
        "score": 29,
        "rawValue": "29",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 22,
        "rawValue": "22",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 32,
    "sailorName": "Allison Li Xin Teh",
    "sailNumber": "787",
    "ageCategory": "8&U",
    "novice": true,
    "gender": "F",
    "schoolName": "TAO NAN SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 117,
    "nettScore": 80,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 36,
        "rawValue": "36",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 34,
        "rawValue": "34",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 10,
        "rawValue": "10",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 37,
        "rawValue": "(37)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 33,
    "sailorName": "Christopher Tan",
    "sailNumber": "2057",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "Constant Wind SeaSport",
    "totalScore": 125,
    "nettScore": 82,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 40,
        "rawValue": "40",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 31,
        "rawValue": "31",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 11,
        "rawValue": "11",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 43,
        "rawValue": "(43)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 34,
    "sailorName": "Nurul 'Afiya Binte Mohamed Shahrom",
    "sailNumber": "703",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "F",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "Changi Sailing Club",
    "totalScore": 128,
    "nettScore": 83,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 31,
        "rawValue": "31",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 45,
        "rawValue": "(45 TLE)",
        "scoringCode": "TLE",
        "discarded": true
      },
      {
        "raceNumber": 3,
        "score": 14,
        "rawValue": "14",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 38,
        "rawValue": "38",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 35,
    "sailorName": "Ezra Yi Yang Mak",
    "sailNumber": "3535",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "ST. ANDREW'S JUNIOR SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 149,
    "nettScore": 94,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 43,
        "rawValue": "43",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 32,
        "rawValue": "32",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 55,
        "rawValue": "(55 UFD)",
        "scoringCode": "UFD",
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 19,
        "rawValue": "19",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 36,
    "sailorName": "Ethan Guo",
    "sailNumber": "2066",
    "ageCategory": "9 to 10 y.o.",
    "novice": true,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "Constant Wind SeaSport",
    "totalScore": 146,
    "nettScore": 95,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 35,
        "rawValue": "35",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 25,
        "rawValue": "25",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 35,
        "rawValue": "35",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 51,
        "rawValue": "(51)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 37,
    "sailorName": "Jacob Jit Yeung Kok",
    "sailNumber": "3087",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "SAF Yacht Club",
    "totalScore": 136,
    "nettScore": 95,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 34,
        "rawValue": "34",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 41,
        "rawValue": "(41)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 3,
        "score": 32,
        "rawValue": "32",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 29,
        "rawValue": "29",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 38,
    "sailorName": "Andrea Kwan",
    "sailNumber": "3745",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "F",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 142,
    "nettScore": 99,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 42,
        "rawValue": "42",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 43,
        "rawValue": "(43)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 3,
        "score": 30,
        "rawValue": "30",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 27,
        "rawValue": "27",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 39,
    "sailorName": "Yu an Li",
    "sailNumber": "2056",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "F",
    "schoolName": "TAO NAN SCHOOL",
    "club": "Constant Wind SeaSport",
    "totalScore": 152,
    "nettScore": 106,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 37,
        "rawValue": "37",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 38,
        "rawValue": "38",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 31,
        "rawValue": "31",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 46,
        "rawValue": "(46)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 40,
    "sailorName": "Ryan Jonathan Zhi Jie Soh",
    "sailNumber": "3110",
    "ageCategory": "8&U",
    "novice": false,
    "gender": "M",
    "schoolName": "ANGLO-CHINESE SCHOOL (JUNIOR)",
    "club": "SAF Yacht Club",
    "totalScore": 164,
    "nettScore": 108,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 44,
        "rawValue": "44",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 40,
        "rawValue": "40",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 24,
        "rawValue": "24",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 56,
        "rawValue": "(56 DSQ)",
        "scoringCode": "DSQ",
        "discarded": true
      }
    ]
  },
  {
    "rank": 41,
    "sailorName": "Yixia Sun",
    "sailNumber": "2061",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "FENGSHAN PRIMARY SCHOOL",
    "club": "Constant Wind SeaSport",
    "totalScore": 164,
    "nettScore": 111,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 41,
        "rawValue": "41",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 28,
        "rawValue": "28",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 42,
        "rawValue": "42",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 53,
        "rawValue": "(53)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 42,
    "sailorName": "Dylan Yao Rui Teo",
    "sailNumber": "3107",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 161,
    "nettScore": 111,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 50,
        "rawValue": "(50)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 2,
        "score": 45,
        "rawValue": "45 TLE",
        "scoringCode": "TLE",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 34,
        "rawValue": "34",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 32,
        "rawValue": "32",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 43,
    "sailorName": "Tobias Ng",
    "sailNumber": "3469",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "RULANG PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 160,
    "nettScore": 114,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 46,
        "rawValue": "(46)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 2,
        "score": 45,
        "rawValue": "45 TLE",
        "scoringCode": "TLE",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 38,
        "rawValue": "38",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 31,
        "rawValue": "31",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 44,
    "sailorName": "Hillary Kai Hui Tan",
    "sailNumber": "777",
    "ageCategory": "8&U",
    "novice": false,
    "gender": "F",
    "schoolName": "KONG HWA SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 162,
    "nettScore": 115,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 30,
        "rawValue": "30",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 45,
        "rawValue": "45 TLE",
        "scoringCode": "TLE",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 40,
        "rawValue": "40",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 47,
        "rawValue": "(47)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 45,
    "sailorName": "Oliver Rui Heng Cheong",
    "sailNumber": "3515",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "ST. STEPHEN'S SCHOOL",
    "club": "Republic of Singapore Yacht Club",
    "totalScore": 171,
    "nettScore": 116,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 55,
        "rawValue": "(55 TLE)",
        "scoringCode": "TLE",
        "discarded": true
      },
      {
        "raceNumber": 2,
        "score": 45,
        "rawValue": "45 TLE",
        "scoringCode": "TLE",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 47,
        "rawValue": "47 TLE",
        "scoringCode": "TLE",
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 24,
        "rawValue": "24",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 46,
    "sailorName": "Adam Leow",
    "sailNumber": "2063",
    "ageCategory": "8&U",
    "novice": false,
    "gender": "M",
    "schoolName": "TAO NAN SCHOOL",
    "club": "Constant Wind SeaSport",
    "totalScore": 164,
    "nettScore": 117,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 47,
        "rawValue": "(47)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 2,
        "score": 45,
        "rawValue": "45 TLE",
        "scoringCode": "TLE",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 39,
        "rawValue": "39",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 33,
        "rawValue": "33",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 47,
    "sailorName": "Evan Yu",
    "sailNumber": "2061",
    "ageCategory": "9 to 10 y.o.",
    "novice": true,
    "gender": "M",
    "schoolName": "ALEXANDRA PRIMARY SCHOOL",
    "club": "Constant Wind SeaSport",
    "totalScore": 175,
    "nettScore": 123,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 48,
        "rawValue": "48",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 30,
        "rawValue": "30",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 45,
        "rawValue": "45",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 52,
        "rawValue": "(52)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 48,
    "sailorName": "Laurence Jun Zhe Foo",
    "sailNumber": "3713",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "PEI CHUN PUBLIC SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 179,
    "nettScore": 124,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 38,
        "rawValue": "38",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 37,
        "rawValue": "37",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 55,
        "rawValue": "(55 UFD)",
        "scoringCode": "UFD",
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 49,
        "rawValue": "49",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 49,
    "sailorName": "Zachary Chew",
    "sailNumber": "3666",
    "ageCategory": "8&U",
    "novice": true,
    "gender": "M",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 178,
    "nettScore": 127,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 51,
        "rawValue": "(51)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 2,
        "score": 42,
        "rawValue": "42",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 41,
        "rawValue": "41",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 44,
        "rawValue": "44",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 50,
    "sailorName": "Emil Lam",
    "sailNumber": "2049",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "TAO NAN SCHOOL",
    "club": "Constant Wind SeaSport",
    "totalScore": 177,
    "nettScore": 128,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 49,
        "rawValue": "(49)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 2,
        "score": 45,
        "rawValue": "45 TLE",
        "scoringCode": "TLE",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 47,
        "rawValue": "47 TLE",
        "scoringCode": "TLE",
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 36,
        "rawValue": "36",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 51,
    "sailorName": "Xiang Yu Du",
    "sailNumber": "3761",
    "ageCategory": "8&U",
    "novice": false,
    "gender": "M",
    "schoolName": "ST. GABRIEL'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 176,
    "nettScore": 129,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 39,
        "rawValue": "39",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 45,
        "rawValue": "45 TLE",
        "scoringCode": "TLE",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 47,
        "rawValue": "(47 TLE)",
        "scoringCode": "TLE",
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 45,
        "rawValue": "45",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 52,
    "sailorName": "Efrem Mak",
    "sailNumber": "3222",
    "ageCategory": "8&U",
    "novice": false,
    "gender": "M",
    "schoolName": "ST. ANDREW'S JUNIOR SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 184,
    "nettScore": 131,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 53,
        "rawValue": "(53)",
        "scoringCode": null,
        "discarded": true
      },
      {
        "raceNumber": 2,
        "score": 45,
        "rawValue": "45 TLE",
        "scoringCode": "TLE",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 44,
        "rawValue": "44",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 42,
        "rawValue": "42",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 53,
    "sailorName": "Sakura Jia Xin Hia",
    "sailNumber": "310",
    "ageCategory": "9 to 10 y.o.",
    "novice": true,
    "gender": "F",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "Changi Sailing Club",
    "totalScore": 187,
    "nettScore": 133,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 45,
        "rawValue": "45",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 45,
        "rawValue": "45 TLE",
        "scoringCode": "TLE",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 43,
        "rawValue": "43",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 54,
        "rawValue": "(54)",
        "scoringCode": null,
        "discarded": true
      }
    ]
  },
  {
    "rank": 54,
    "sailorName": "Youxun Wu",
    "sailNumber": "3070",
    "ageCategory": "8&U",
    "novice": false,
    "gender": "M",
    "schoolName": "ST. HILDA'S PRIMARY SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 200,
    "nettScore": 145,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 52,
        "rawValue": "52",
        "scoringCode": null,
        "discarded": false
      },
      {
        "raceNumber": 2,
        "score": 45,
        "rawValue": "45 TLE",
        "scoringCode": "TLE",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 55,
        "rawValue": "(55 UFD)",
        "scoringCode": "UFD",
        "discarded": true
      },
      {
        "raceNumber": 4,
        "score": 48,
        "rawValue": "48",
        "scoringCode": null,
        "discarded": false
      }
    ]
  },
  {
    "rank": 55,
    "sailorName": "Isaac Qin Ran Chiam",
    "sailNumber": "3606",
    "ageCategory": "9 to 10 y.o.",
    "novice": false,
    "gender": "M",
    "schoolName": "AI TONG SCHOOL",
    "club": "SAF Yacht Club",
    "totalScore": 218,
    "nettScore": 162,
    "isDns": false,
    "races": [
      {
        "raceNumber": 1,
        "score": 56,
        "rawValue": "(56 DNC)",
        "scoringCode": "DNC",
        "discarded": true
      },
      {
        "raceNumber": 2,
        "score": 56,
        "rawValue": "56 DNC",
        "scoringCode": "DNC",
        "discarded": false
      },
      {
        "raceNumber": 3,
        "score": 56,
        "rawValue": "56 DNC",
        "scoringCode": "DNC",
        "discarded": false
      },
      {
        "raceNumber": 4,
        "score": 50,
        "rawValue": "50",
        "scoringCode": null,
        "discarded": false
      }
    ]
  }
];
