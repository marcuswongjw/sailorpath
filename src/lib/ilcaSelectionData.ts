// Official Singapore ILCA 4 Selection Data & Standings
// Derived from official SSF ranking documents and selection policies

export type IlcaTrialEvent = {
  id: string;
  name: string;
  shortName: string;
  dateStr: string;
  venue: string;
  fleetSize: number;
  completed: boolean;
};

export type IlcaTrialSailor = {
  sailorId: string;
  name: string;
  gender: "M" | "F";
  birthYear: number | null;
  handle: string | null;
  nationalRank: number;
  cscPoints: number;
  syscPoints: number;
  temasekPoints: number;
  pestaPoints: number;
  pestaPlace: number | null;
  snscPoints: number;
  snscPlace: number | null;
  trialPts: number;
  finishPos: number;
  bestThreePoints: number;
  isU14: boolean;
  isU17: boolean;
  easternStatus:
    | "Qualified (Slot 1)"
    | "Qualified (Slot 2)"
    | "Qualified (Slot 3)"
    | "1st Reserve"
    | "2nd Reserve"
    | "3rd Reserve"
    | "Eligible (U14)"
    | "Ineligible (Over U14 Age)";
  easternRankGender: number | null;
  asianProvisionalStatus:
    | "Provisional Leader (Slot 1)"
    | "Provisional Leader (Slot 2)"
    | "Provisional Leader (Slot 3)"
    | "Provisional Leader (Slot 4)"
    | "Provisional Reserve"
    | "Eligible (U17)"
    | "Ineligible (Over U17 Age)";
  asianRankGender: number | null;
  njtsStatus:
    | "Top 2 Overall"
    | "Age 16 Bucket"
    | "Age ≤ 15 Bucket"
    | "Top 25 Contender"
    | "Ranked Contender";
};

export const ILCA4_SELECTION_EVENTS: IlcaTrialEvent[] = [
  {
    id: "pesta-sukan-2026",
    name: "Pesta Sukan Regatta 2026",
    shortName: "Pesta Sukan",
    dateStr: "1 – 2 August 2026",
    venue: "National Sailing Centre, Singapore",
    fleetSize: 41,
    completed: true,
  },
  {
    id: "snsc-2026",
    name: "Singapore National Sailing Championships 2026",
    shortName: "SNSC 2026",
    dateStr: "11 – 13 September 2026",
    venue: "National Sailing Centre, Singapore",
    fleetSize: 45,
    completed: true,
  },
  {
    id: "selection-trials-2026",
    name: "Asian Open Selection Trials 2026",
    shortName: "Trials Event 2",
    dateStr: "10, 11, 17, 18 October 2026",
    venue: "National Sailing Centre, Singapore",
    fleetSize: 0,
    completed: false,
  },
];

// Helper to assign statuses
const rawSailors = [
  {
    "sailorId": "ilca4-sailor-1",
    "name": "Goh, Ian",
    "gender": "M",
    "birthYear": 2009,
    "handle": "goh-siak-yiak-ian",
    "nationalRank": 1,
    "cscPoints": 49,
    "syscPoints": 70,
    "temasekPoints": 0,
    "pestaPoints": 43,
    "pestaPlace": 1,
    "snscPoints": 46,
    "snscPlace": 1,
    "trialPts": 89,
    "finishPos": 2,
    "bestThreePoints": 165,
    "isU14": false,
    "isU17": false
  },
  {
    "sailorId": "ilca4-sailor-2",
    "name": "Wong, Zachary Weikai",
    "gender": "M",
    "birthYear": 2010,
    "handle": "wong-weikai-zachary-ft0rnv9",
    "nationalRank": 2,
    "cscPoints": 47,
    "syscPoints": 66,
    "temasekPoints": 0,
    "pestaPoints": 41,
    "pestaPlace": 3,
    "snscPoints": 42,
    "snscPlace": 5,
    "trialPts": 83,
    "finishPos": 8,
    "bestThreePoints": 155,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-3",
    "name": "Tew, Mika",
    "gender": "F",
    "birthYear": 2010,
    "handle": "mika-tew-0741h6l",
    "nationalRank": 3,
    "cscPoints": 45,
    "syscPoints": 65,
    "temasekPoints": 37,
    "pestaPoints": 39,
    "pestaPlace": 5,
    "snscPoints": 39,
    "snscPlace": 8,
    "trialPts": 78,
    "finishPos": 13,
    "bestThreePoints": 149,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-4",
    "name": "Wan, Zeph",
    "gender": "M",
    "birthYear": 2011,
    "handle": "zeph-wan",
    "nationalRank": 4,
    "cscPoints": 42,
    "syscPoints": 63,
    "temasekPoints": 0,
    "pestaPoints": 40,
    "pestaPlace": 4,
    "snscPoints": 41,
    "snscPlace": 6,
    "trialPts": 81,
    "finishPos": 10,
    "bestThreePoints": 146,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-5",
    "name": "Chang, Jemima",
    "gender": "F",
    "birthYear": 2010,
    "handle": "jemima-chang-fwumhtx",
    "nationalRank": 5,
    "cscPoints": 38,
    "syscPoints": 61,
    "temasekPoints": 38,
    "pestaPoints": 35,
    "pestaPlace": 9,
    "snscPoints": 37,
    "snscPlace": 10,
    "trialPts": 72,
    "finishPos": 19,
    "bestThreePoints": 137,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-6",
    "name": "Lee, Desiree Yuet Chi",
    "gender": "F",
    "birthYear": 2011,
    "handle": "desiree-lee-yuet-chi",
    "nationalRank": 6,
    "cscPoints": 40,
    "syscPoints": 57,
    "temasekPoints": 40,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 137,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-7",
    "name": "Peck, Caleb",
    "gender": "M",
    "birthYear": 2011,
    "handle": "caleb-peck-rui-kai-053ej52",
    "nationalRank": 7,
    "cscPoints": 39,
    "syscPoints": 54,
    "temasekPoints": 30,
    "pestaPoints": 43,
    "pestaPlace": 1,
    "snscPoints": 25,
    "snscPlace": 22,
    "trialPts": 68,
    "finishPos": 23,
    "bestThreePoints": 136,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-8",
    "name": "Wai, Zhi Tong",
    "gender": "F",
    "birthYear": 2010,
    "handle": "wai-zhi-tong",
    "nationalRank": 8,
    "cscPoints": 46,
    "syscPoints": 45,
    "temasekPoints": 0,
    "pestaPoints": 30,
    "pestaPlace": 14,
    "snscPoints": 45,
    "snscPlace": 2,
    "trialPts": 75,
    "finishPos": 16,
    "bestThreePoints": 136,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-9",
    "name": "Pee, Teck Woon",
    "gender": "M",
    "birthYear": 2011,
    "handle": "pee-teck-woon",
    "nationalRank": 9,
    "cscPoints": 0,
    "syscPoints": 52,
    "temasekPoints": 39,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 44,
    "snscPlace": 3,
    "trialPts": 44,
    "finishPos": 47,
    "bestThreePoints": 135,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-10",
    "name": "Wong, Mildred Li Xuan",
    "gender": "F",
    "birthYear": 2010,
    "handle": "wong-li-xuan-mildred-fueslz1",
    "nationalRank": 10,
    "cscPoints": 36,
    "syscPoints": 58,
    "temasekPoints": 32,
    "pestaPoints": 29,
    "pestaPlace": 15,
    "snscPoints": 22,
    "snscPlace": 25,
    "trialPts": 51,
    "finishPos": 40,
    "bestThreePoints": 126,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-11",
    "name": "Lim, Yuk Jun",
    "gender": "M",
    "birthYear": 2010,
    "handle": "lim-yuk-jun",
    "nationalRank": 11,
    "cscPoints": 32,
    "syscPoints": 47,
    "temasekPoints": 36,
    "pestaPoints": 41,
    "pestaPlace": 3,
    "snscPoints": 38,
    "snscPlace": 9,
    "trialPts": 79,
    "finishPos": 12,
    "bestThreePoints": 126,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-12",
    "name": "Chia, Ethan Han Wei",
    "gender": "M",
    "birthYear": 2010,
    "handle": "ethan-chia-han-wei",
    "nationalRank": 12,
    "cscPoints": 48,
    "syscPoints": 69,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 117,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-13",
    "name": "Bai, Jayden Zi Xi",
    "gender": "M",
    "birthYear": 2011,
    "handle": "jayden-bai-fxjqcb0",
    "nationalRank": 13,
    "cscPoints": 23,
    "syscPoints": 43,
    "temasekPoints": 35,
    "pestaPoints": 38,
    "pestaPlace": 6,
    "snscPoints": 28,
    "snscPlace": 19,
    "trialPts": 66,
    "finishPos": 25,
    "bestThreePoints": 116,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-14",
    "name": "Petracco, Julien Christian",
    "gender": "M",
    "birthYear": 2012,
    "handle": "julien-christian-petracco",
    "nationalRank": 14,
    "cscPoints": 34,
    "syscPoints": 41,
    "temasekPoints": 24,
    "pestaPoints": 39,
    "pestaPlace": 5,
    "snscPoints": 32,
    "snscPlace": 15,
    "trialPts": 71,
    "finishPos": 20,
    "bestThreePoints": 114,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-15",
    "name": "Lee, Isla Zhi Xi",
    "gender": "F",
    "birthYear": 2012,
    "handle": "isla-lee-zhi-xi",
    "nationalRank": 15,
    "cscPoints": 33,
    "syscPoints": 26,
    "temasekPoints": 31,
    "pestaPoints": 35,
    "pestaPlace": 9,
    "snscPoints": 40,
    "snscPlace": 7,
    "trialPts": 75,
    "finishPos": 16,
    "bestThreePoints": 108,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-16",
    "name": "Lee, Nicholette Wee Wen",
    "gender": "F",
    "birthYear": 2010,
    "handle": "nicholette-lee-fsbart1",
    "nationalRank": 16,
    "cscPoints": 43,
    "syscPoints": 64,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 107,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-17",
    "name": "Zahedi, Nia",
    "gender": "F",
    "birthYear": 2010,
    "handle": "nia-mehry-zahedi-04ev2zf",
    "nationalRank": 17,
    "cscPoints": 44,
    "syscPoints": 62,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 106,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-18",
    "name": "Pitsilis, Amandine Zoe",
    "gender": "F",
    "birthYear": 2012,
    "handle": "amandine-zoe-pitsilis",
    "nationalRank": 18,
    "cscPoints": 20,
    "syscPoints": 37,
    "temasekPoints": 33,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 35,
    "snscPlace": 12,
    "trialPts": 35,
    "finishPos": 56,
    "bestThreePoints": 105,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-19",
    "name": "Kong, Charles Shing Chak",
    "gender": "M",
    "birthYear": 2014,
    "handle": "charles-kong-shing-chak",
    "nationalRank": 19,
    "cscPoints": 21,
    "syscPoints": 36,
    "temasekPoints": 28,
    "pestaPoints": 36,
    "pestaPlace": 8,
    "snscPoints": 33,
    "snscPlace": 14,
    "trialPts": 69,
    "finishPos": 22,
    "bestThreePoints": 105,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-20",
    "name": "Tan, Reyes Jit Eng",
    "gender": "M",
    "birthYear": 2011,
    "handle": "tan-reyes-jit-eng-fzahuzd",
    "nationalRank": 20,
    "cscPoints": 30,
    "syscPoints": 40,
    "temasekPoints": 21,
    "pestaPoints": 33,
    "pestaPlace": 11,
    "snscPoints": 27,
    "snscPlace": 20,
    "trialPts": 60,
    "finishPos": 31,
    "bestThreePoints": 103,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-21",
    "name": "Tham, Ashlea",
    "gender": "F",
    "birthYear": 2010,
    "handle": "tham-yan-shuang-ashlea",
    "nationalRank": 21,
    "cscPoints": 41,
    "syscPoints": 55,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 96,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-22",
    "name": "Yap, Isaiah Chor Hong",
    "gender": "M",
    "birthYear": 2012,
    "handle": "isaiah-yap-chor-hong",
    "nationalRank": 22,
    "cscPoints": 26,
    "syscPoints": 29,
    "temasekPoints": 34,
    "pestaPoints": 32,
    "pestaPlace": 12,
    "snscPoints": 30,
    "snscPlace": 17,
    "trialPts": 62,
    "finishPos": 29,
    "bestThreePoints": 96,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-23",
    "name": "Oh, Gabi",
    "gender": "F",
    "birthYear": 2011,
    "handle": "gabi-oh-fv3x3cs",
    "nationalRank": 23,
    "cscPoints": 35,
    "syscPoints": 59,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 94,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-24",
    "name": "Yeh, Kate Zi Ning",
    "gender": "F",
    "birthYear": 2012,
    "handle": "kate-yeh-zi-ning",
    "nationalRank": 24,
    "cscPoints": 37,
    "syscPoints": 27,
    "temasekPoints": 0,
    "pestaPoints": 28,
    "pestaPlace": 16,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 28,
    "finishPos": 63,
    "bestThreePoints": 92,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-25",
    "name": "Liao, ZhiTing",
    "gender": "M",
    "birthYear": 2012,
    "handle": "liao-zhiting-xtdrlbg",
    "nationalRank": 25,
    "cscPoints": 31,
    "syscPoints": 22,
    "temasekPoints": 23,
    "pestaPoints": 37,
    "pestaPlace": 7,
    "snscPoints": 24,
    "snscPlace": 23,
    "trialPts": 61,
    "finishPos": 30,
    "bestThreePoints": 92,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-26",
    "name": "Lim, Lucas Rui Kai",
    "gender": "M",
    "birthYear": 2012,
    "handle": "lim-rui-kai-lucas",
    "nationalRank": 26,
    "cscPoints": 11,
    "syscPoints": 0,
    "temasekPoints": 27,
    "pestaPoints": 34,
    "pestaPlace": 10,
    "snscPoints": 31,
    "snscPlace": 16,
    "trialPts": 65,
    "finishPos": 26,
    "bestThreePoints": 92,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-27",
    "name": "Kong, James",
    "gender": "M",
    "birthYear": 2011,
    "handle": "james-kong-0lvis00",
    "nationalRank": 27,
    "cscPoints": 16,
    "syscPoints": 35,
    "temasekPoints": 26,
    "pestaPoints": 30,
    "pestaPlace": 14,
    "snscPoints": 15,
    "snscPlace": 32,
    "trialPts": 45,
    "finishPos": 46,
    "bestThreePoints": 91,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-28",
    "name": "Wong, Kai Lun",
    "gender": "M",
    "birthYear": 2011,
    "handle": "regis-wong-xuan-kai-07sd94a",
    "nationalRank": 28,
    "cscPoints": 28,
    "syscPoints": 38,
    "temasekPoints": 20,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 86,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-29",
    "name": "Cao, Lucas Zhihong",
    "gender": "M",
    "birthYear": 2011,
    "handle": "lucas-cao-zhihong",
    "nationalRank": 29,
    "cscPoints": 0,
    "syscPoints": 0,
    "temasekPoints": 0,
    "pestaPoints": 42,
    "pestaPlace": 2,
    "snscPoints": 43,
    "snscPlace": 4,
    "trialPts": 85,
    "finishPos": 6,
    "bestThreePoints": 85,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-30",
    "name": "Lim, Lauren",
    "gender": "F",
    "birthYear": 2012,
    "handle": "lauren-lim-ommq6jo",
    "nationalRank": 30,
    "cscPoints": 13,
    "syscPoints": 33,
    "temasekPoints": 18,
    "pestaPoints": 31,
    "pestaPlace": 13,
    "snscPoints": 18,
    "snscPlace": 29,
    "trialPts": 49,
    "finishPos": 42,
    "bestThreePoints": 82,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-31",
    "name": "Wong, Callum Joon Thang",
    "gender": "M",
    "birthYear": 2012,
    "handle": "callum-wong-joon-thang",
    "nationalRank": 31,
    "cscPoints": 15,
    "syscPoints": 32,
    "temasekPoints": 29,
    "pestaPoints": 7,
    "pestaPlace": 37,
    "snscPoints": 19,
    "snscPlace": 28,
    "trialPts": 26,
    "finishPos": 65,
    "bestThreePoints": 80,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-32",
    "name": "Tan, Joash Jing En",
    "gender": "M",
    "birthYear": 2011,
    "handle": "joash-tan-jing-en",
    "nationalRank": 32,
    "cscPoints": 27,
    "syscPoints": 21,
    "temasekPoints": 0,
    "pestaPoints": 25,
    "pestaPlace": 19,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 25,
    "finishPos": 66,
    "bestThreePoints": 73,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-33",
    "name": "Ong, Josh Yong Jun",
    "gender": "M",
    "birthYear": 2011,
    "handle": "josh-yong-jun-ong-yqw83c1",
    "nationalRank": 33,
    "cscPoints": 2,
    "syscPoints": 34,
    "temasekPoints": 0,
    "pestaPoints": 17,
    "pestaPlace": 27,
    "snscPoints": 20,
    "snscPlace": 27,
    "trialPts": 37,
    "finishPos": 54,
    "bestThreePoints": 71,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-34",
    "name": "Sim, Gerome",
    "gender": "M",
    "birthYear": 2011,
    "handle": "gerome-sim",
    "nationalRank": 34,
    "cscPoints": 10,
    "syscPoints": 11,
    "temasekPoints": 19,
    "pestaPoints": 24,
    "pestaPlace": 20,
    "snscPoints": 26,
    "snscPlace": 21,
    "trialPts": 50,
    "finishPos": 41,
    "bestThreePoints": 69,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-35",
    "name": "Tang, Kye",
    "gender": "M",
    "birthYear": 2012,
    "handle": "kye-tang-ojcorzh",
    "nationalRank": 35,
    "cscPoints": 14,
    "syscPoints": 24,
    "temasekPoints": 16,
    "pestaPoints": 27,
    "pestaPlace": 17,
    "snscPoints": 17,
    "snscPlace": 30,
    "trialPts": 44,
    "finishPos": 47,
    "bestThreePoints": 68,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-36",
    "name": "Kwok, Jonathan Kum Loong",
    "gender": "M",
    "birthYear": 2011,
    "handle": "jonathan-kwok-kum-loong-0iin67q",
    "nationalRank": 36,
    "cscPoints": 19,
    "syscPoints": 16,
    "temasekPoints": 15,
    "pestaPoints": 26,
    "pestaPlace": 18,
    "snscPoints": 23,
    "snscPlace": 24,
    "trialPts": 49,
    "finishPos": 42,
    "bestThreePoints": 68,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-37",
    "name": "Siwal, Preet",
    "gender": "M",
    "birthYear": 2010,
    "handle": "preet-siwal-2qkw8co",
    "nationalRank": 37,
    "cscPoints": 0,
    "syscPoints": 67,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 67,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-38",
    "name": "Kong, Cecilia Sze Sen",
    "gender": "F",
    "birthYear": 2011,
    "handle": "kong-sze-sen-cecilia",
    "nationalRank": 38,
    "cscPoints": 0,
    "syscPoints": 17,
    "temasekPoints": 25,
    "pestaPoints": 23,
    "pestaPlace": 21,
    "snscPoints": 4,
    "snscPlace": 43,
    "trialPts": 27,
    "finishPos": 64,
    "bestThreePoints": 65,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-39",
    "name": "Yong, Heng Yi",
    "gender": "M",
    "birthYear": 2011,
    "handle": "yong-heng-yi",
    "nationalRank": 39,
    "cscPoints": 29,
    "syscPoints": 18,
    "temasekPoints": 17,
    "pestaPoints": 6,
    "pestaPlace": 38,
    "snscPoints": 4,
    "snscPlace": 43,
    "trialPts": 10,
    "finishPos": 81,
    "bestThreePoints": 64,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-40",
    "name": "Kiesselbach, Lukas",
    "gender": "M",
    "birthYear": 2011,
    "handle": "lukas-kiesselbach-fylbfoc",
    "nationalRank": 40,
    "cscPoints": 17,
    "syscPoints": 39,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 4,
    "snscPlace": 43,
    "trialPts": 4,
    "finishPos": 87,
    "bestThreePoints": 60,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-41",
    "name": "Lin, Shin Chen Rui",
    "gender": "M",
    "birthYear": 2013,
    "handle": null,
    "nationalRank": 41,
    "cscPoints": 0,
    "syscPoints": 0,
    "temasekPoints": 0,
    "pestaPoints": 22,
    "pestaPlace": 22,
    "snscPoints": 36,
    "snscPlace": 11,
    "trialPts": 58,
    "finishPos": 33,
    "bestThreePoints": 58,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-42",
    "name": "Cao, Caleb Zhixuan",
    "gender": "M",
    "birthYear": 2014,
    "handle": "caleb-cao-zhixuan",
    "nationalRank": 42,
    "cscPoints": 9,
    "syscPoints": 23,
    "temasekPoints": 9,
    "pestaPoints": 21,
    "pestaPlace": 23,
    "snscPoints": 13,
    "snscPlace": 34,
    "trialPts": 34,
    "finishPos": 57,
    "bestThreePoints": 57,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-43",
    "name": "Pandey, Aastha",
    "gender": "F",
    "birthYear": 2010,
    "handle": "aastha-pandey-1taq6y1",
    "nationalRank": 43,
    "cscPoints": 0,
    "syscPoints": 56,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 56,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-44",
    "name": "Yeo, Travis Jia Le",
    "gender": "M",
    "birthYear": 2012,
    "handle": "travis-yeo-0eu0e5m",
    "nationalRank": 44,
    "cscPoints": 3,
    "syscPoints": 31,
    "temasekPoints": 22,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 56,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-45",
    "name": "Ng, Nicholas Jiang En",
    "gender": "M",
    "birthYear": 2011,
    "handle": "nicholas-jiang-en-ng-g33qucq",
    "nationalRank": 45,
    "cscPoints": 24,
    "syscPoints": 30,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 54,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-46",
    "name": "Tan, Jonas Kia Jeng",
    "gender": "M",
    "birthYear": 2013,
    "handle": "jonas-tan-kia-jeng",
    "nationalRank": 46,
    "cscPoints": 22,
    "syscPoints": 14,
    "temasekPoints": 8,
    "pestaPoints": 18,
    "pestaPlace": 26,
    "snscPoints": 4,
    "snscPlace": 43,
    "trialPts": 22,
    "finishPos": 69,
    "bestThreePoints": 54,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-47",
    "name": "Verma, Mahi",
    "gender": "F",
    "birthYear": 2010,
    "handle": "mahi-verma-2v4csoh",
    "nationalRank": 47,
    "cscPoints": 0,
    "syscPoints": 53,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 53,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-48",
    "name": "Chandrawanshi, Vasu",
    "gender": "M",
    "birthYear": 2011,
    "handle": "vasu-chandrawanshi-1jm00b2",
    "nationalRank": 48,
    "cscPoints": 0,
    "syscPoints": 50,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 50,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-49",
    "name": "Rumvisai, Pacharapol",
    "gender": "M",
    "birthYear": 2010,
    "handle": "pacharapol-rumvisai-2xx8xys",
    "nationalRank": 49,
    "cscPoints": 0,
    "syscPoints": 48,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 48,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-50",
    "name": "Patle, Tulsi",
    "gender": "F",
    "birthYear": 2011,
    "handle": "tulsi-patle-2ymjsgq",
    "nationalRank": 50,
    "cscPoints": 0,
    "syscPoints": 46,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 46,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-51",
    "name": "Loh, Cory Zhi Hang",
    "gender": "M",
    "birthYear": 2012,
    "handle": "cory-loh-zhi-hang",
    "nationalRank": 51,
    "cscPoints": 18,
    "syscPoints": 28,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 46,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-52",
    "name": "Phokaew, Thanaporn",
    "gender": "F",
    "birthYear": 2011,
    "handle": "thanaporn-phokaew-2zbw4z0",
    "nationalRank": 52,
    "cscPoints": 0,
    "syscPoints": 44,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 44,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-53",
    "name": "Tan, Joel Kai En",
    "gender": "M",
    "birthYear": 2012,
    "handle": "tan-kai-en-joel",
    "nationalRank": 53,
    "cscPoints": 6,
    "syscPoints": 15,
    "temasekPoints": 13,
    "pestaPoints": 16,
    "pestaPlace": 28,
    "snscPoints": 11,
    "snscPlace": 36,
    "trialPts": 27,
    "finishPos": 64,
    "bestThreePoints": 44,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-54",
    "name": "Khoo, Joshua Zhuo Xi",
    "gender": "M",
    "birthYear": 2012,
    "handle": "joshua-khoo-zhuo-xi",
    "nationalRank": 54,
    "cscPoints": 8,
    "syscPoints": 13,
    "temasekPoints": 11,
    "pestaPoints": 19,
    "pestaPlace": 25,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 19,
    "finishPos": 72,
    "bestThreePoints": 43,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-55",
    "name": "Jaroenpon, Pailin",
    "gender": "F",
    "birthYear": 2011,
    "handle": "pailin-jaroenpon-f3tnzr6",
    "nationalRank": 55,
    "cscPoints": 0,
    "syscPoints": 42,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 42,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-56",
    "name": "Lee, Rayson Yin Yi",
    "gender": "M",
    "birthYear": 2012,
    "handle": "rayson-lee-yin-yi-oi1kvmm",
    "nationalRank": 56,
    "cscPoints": 1,
    "syscPoints": 19,
    "temasekPoints": 7,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 16,
    "snscPlace": 31,
    "trialPts": 16,
    "finishPos": 75,
    "bestThreePoints": 42,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-57",
    "name": "Li, Lyric Yuxuan",
    "gender": "F",
    "birthYear": 2012,
    "handle": null,
    "nationalRank": 57,
    "cscPoints": 0,
    "syscPoints": 0,
    "temasekPoints": 0,
    "pestaPoints": 40,
    "pestaPlace": 4,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 40,
    "finishPos": 51,
    "bestThreePoints": 40,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-58",
    "name": "Xu, Jiayan",
    "gender": "M",
    "birthYear": 2012,
    "handle": "xu-jiayan-outlig4",
    "nationalRank": 58,
    "cscPoints": 4,
    "syscPoints": 9,
    "temasekPoints": 0,
    "pestaPoints": 15,
    "pestaPlace": 29,
    "snscPoints": 14,
    "snscPlace": 33,
    "trialPts": 29,
    "finishPos": 62,
    "bestThreePoints": 38,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-59",
    "name": "Chang, Rupert",
    "gender": "M",
    "birthYear": 2011,
    "handle": "rupert-kije-chang-shanpng",
    "nationalRank": 59,
    "cscPoints": 7,
    "syscPoints": 0,
    "temasekPoints": 0,
    "pestaPoints": 20,
    "pestaPlace": 24,
    "snscPoints": 8,
    "snscPlace": 39,
    "trialPts": 28,
    "finishPos": 63,
    "bestThreePoints": 35,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-60",
    "name": "Bin Mohd Shahrom, Mohamed Mikail",
    "gender": "M",
    "birthYear": 2012,
    "handle": null,
    "nationalRank": 60,
    "cscPoints": 12,
    "syscPoints": 0,
    "temasekPoints": 2,
    "pestaPoints": 14,
    "pestaPlace": 30,
    "snscPoints": 9,
    "snscPlace": 38,
    "trialPts": 23,
    "finishPos": 68,
    "bestThreePoints": 35,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-61",
    "name": "Cheow, Mathias",
    "gender": "M",
    "birthYear": 2011,
    "handle": "mathias-cheow-og2sfe8",
    "nationalRank": 61,
    "cscPoints": 5,
    "syscPoints": 4,
    "temasekPoints": 14,
    "pestaPoints": 13,
    "pestaPlace": 31,
    "snscPoints": 5,
    "snscPlace": 42,
    "trialPts": 18,
    "finishPos": 73,
    "bestThreePoints": 32,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-62",
    "name": "Lee, Ethan",
    "gender": "M",
    "birthYear": 2012,
    "handle": null,
    "nationalRank": 62,
    "cscPoints": 0,
    "syscPoints": 0,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 29,
    "snscPlace": 18,
    "trialPts": 29,
    "finishPos": 62,
    "bestThreePoints": 29,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-63",
    "name": "Bu, Ruiqiao",
    "gender": "M",
    "birthYear": 2011,
    "handle": "ruiqiao-bu-31fo236",
    "nationalRank": 63,
    "cscPoints": 0,
    "syscPoints": 25,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 25,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-64",
    "name": "Lim Laurie, Misa",
    "gender": "F",
    "birthYear": 2011,
    "handle": "misa-lim-laurier-0gi85n6",
    "nationalRank": 64,
    "cscPoints": 25,
    "syscPoints": 0,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 25,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-65",
    "name": "Ogawa, Yunosuke",
    "gender": "M",
    "birthYear": 2011,
    "handle": "yunosuke-ogawa-g8agugu",
    "nationalRank": 65,
    "cscPoints": 0,
    "syscPoints": 0,
    "temasekPoints": 12,
    "pestaPoints": 6,
    "pestaPlace": 38,
    "snscPoints": 7,
    "snscPlace": 40,
    "trialPts": 13,
    "finishPos": 78,
    "bestThreePoints": 25,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-66",
    "name": "Naidu, Alaric Shenthil",
    "gender": "M",
    "birthYear": 2012,
    "handle": "alaric-shenthil-naidu",
    "nationalRank": 66,
    "cscPoints": 0,
    "syscPoints": 7,
    "temasekPoints": 10,
    "pestaPoints": 6,
    "pestaPlace": 38,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 6,
    "finishPos": 85,
    "bestThreePoints": 23,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-67",
    "name": "Sim, Germaine",
    "gender": "F",
    "birthYear": 2011,
    "handle": "germaine-sim",
    "nationalRank": 67,
    "cscPoints": 0,
    "syscPoints": 20,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 20,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-68",
    "name": "Tay, Jamiroquai Kai Nuo",
    "gender": "M",
    "birthYear": 2012,
    "handle": "jamiroquai-tay-kai-nuo",
    "nationalRank": 68,
    "cscPoints": 0,
    "syscPoints": 0,
    "temasekPoints": 3,
    "pestaPoints": 11,
    "pestaPlace": 33,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 11,
    "finishPos": 80,
    "bestThreePoints": 14,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-69",
    "name": "Teo, Tiffany",
    "gender": "F",
    "birthYear": 2011,
    "handle": "tiffany-teo-yuan-qi-ga16itq",
    "nationalRank": 69,
    "cscPoints": 0,
    "syscPoints": 8,
    "temasekPoints": 5,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 13,
    "isU14": false,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-70",
    "name": "Agea, Tomas",
    "gender": "M",
    "birthYear": 2012,
    "handle": "tomas-agea-dzxv2wz",
    "nationalRank": 70,
    "cscPoints": 0,
    "syscPoints": 1,
    "temasekPoints": 6,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 6,
    "snscPlace": 41,
    "trialPts": 6,
    "finishPos": 85,
    "bestThreePoints": 13,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-71",
    "name": "Chan, Aaron",
    "gender": "M",
    "birthYear": 2012,
    "handle": null,
    "nationalRank": 71,
    "cscPoints": 0,
    "syscPoints": 0,
    "temasekPoints": 0,
    "pestaPoints": 12,
    "pestaPlace": 32,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 12,
    "finishPos": 79,
    "bestThreePoints": 12,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-72",
    "name": "Goy, Ethan",
    "gender": "M",
    "birthYear": 2012,
    "handle": "ethan-goy-z0l558l",
    "nationalRank": 72,
    "cscPoints": 0,
    "syscPoints": 5,
    "temasekPoints": 0,
    "pestaPoints": 6,
    "pestaPlace": 38,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 6,
    "finishPos": 85,
    "bestThreePoints": 11,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-73",
    "name": "Liew, Jared Soon Kit",
    "gender": "M",
    "birthYear": 2013,
    "handle": null,
    "nationalRank": 73,
    "cscPoints": 0,
    "syscPoints": 0,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 10,
    "snscPlace": 37,
    "trialPts": 10,
    "finishPos": 81,
    "bestThreePoints": 10,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-74",
    "name": "Kocourek, Daniel",
    "gender": "M",
    "birthYear": 2012,
    "handle": null,
    "nationalRank": 74,
    "cscPoints": 0,
    "syscPoints": 0,
    "temasekPoints": 0,
    "pestaPoints": 10,
    "pestaPlace": 34,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 10,
    "finishPos": 81,
    "bestThreePoints": 10,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-75",
    "name": "Wu, Qiyou",
    "gender": "F",
    "birthYear": 2013,
    "handle": null,
    "nationalRank": 75,
    "cscPoints": 0,
    "syscPoints": 0,
    "temasekPoints": 0,
    "pestaPoints": 9,
    "pestaPlace": 35,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 9,
    "finishPos": 82,
    "bestThreePoints": 9,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-76",
    "name": "Zhao, Chengwei",
    "gender": "M",
    "birthYear": 2012,
    "handle": null,
    "nationalRank": 76,
    "cscPoints": 0,
    "syscPoints": 0,
    "temasekPoints": 0,
    "pestaPoints": 8,
    "pestaPlace": 36,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 8,
    "finishPos": 83,
    "bestThreePoints": 8,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-77",
    "name": "Ji, Wenxin",
    "gender": "F",
    "birthYear": 2013,
    "handle": null,
    "nationalRank": 77,
    "cscPoints": 0,
    "syscPoints": 0,
    "temasekPoints": 0,
    "pestaPoints": 6,
    "pestaPlace": 38,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 6,
    "finishPos": 85,
    "bestThreePoints": 6,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-78",
    "name": "Sudjana, Judy",
    "gender": "F",
    "birthYear": 2012,
    "handle": "judy-zhang-sudjana-0e5x7ny",
    "nationalRank": 78,
    "cscPoints": 0,
    "syscPoints": 6,
    "temasekPoints": 0,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 6,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-79",
    "name": "Wong, Febe Qi Ke",
    "gender": "F",
    "birthYear": 2012,
    "handle": null,
    "nationalRank": 79,
    "cscPoints": 0,
    "syscPoints": 0,
    "temasekPoints": 0,
    "pestaPoints": 6,
    "pestaPlace": 38,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 6,
    "finishPos": 85,
    "bestThreePoints": 6,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-80",
    "name": "Ha, Maximilian",
    "gender": "M",
    "birthYear": 2012,
    "handle": "maximilian-ha-yzwx65x",
    "nationalRank": 80,
    "cscPoints": 0,
    "syscPoints": 2,
    "temasekPoints": 4,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 6,
    "isU14": true,
    "isU17": true
  },
  {
    "sailorId": "ilca4-sailor-81",
    "name": "Li, Sheng Rui",
    "gender": "M",
    "birthYear": 2013,
    "handle": "sheng-rui-li-5obv00j",
    "nationalRank": 81,
    "cscPoints": 0,
    "syscPoints": 0,
    "temasekPoints": 1,
    "pestaPoints": 0,
    "pestaPlace": null,
    "snscPoints": 0,
    "snscPlace": null,
    "trialPts": 0,
    "finishPos": 91,
    "bestThreePoints": 1,
    "isU14": true,
    "isU17": true
  }
];

export const ILCA4_SELECTION_SAILORS: IlcaTrialSailor[] = rawSailors.map((s) => {
  let easternStatus: IlcaTrialSailor["easternStatus"] = "Ineligible (Over U14 Age)";
  const easternRankGender: number | null = null;
  let asianProvisionalStatus: IlcaTrialSailor["asianProvisionalStatus"] = "Ineligible (Over U17 Age)";
  const asianRankGender: number | null = null;
  const njtsStatus: IlcaTrialSailor["njtsStatus"] = "Ranked Contender";

  // Eastern Seaboard (U14: born >= 2012)
  if (s.isU14) {
    easternStatus = "Eligible (U14)";
  }

  // Asian Open (U17: born >= 2010)
  if (s.isU17) {
    asianProvisionalStatus = "Eligible (U17)";
  }

  return {
    ...s,
    gender: (s.gender === "F" ? "F" : "M") as "M" | "F",
    easternStatus,
    easternRankGender,
    asianProvisionalStatus,
    asianRankGender,
    njtsStatus,
  };
});

// Compute Eastern Seaboard rankings for U14 boys and girls
const u14Boys = ILCA4_SELECTION_SAILORS
  .filter((s) => s.gender === "M" && s.isU14 && s.trialPts > 0)
  .sort((a, b) => b.trialPts - a.trialPts || a.finishPos - b.finishPos);

u14Boys.forEach((s, idx) => {
  s.easternRankGender = idx + 1;
  if (idx === 0) s.easternStatus = "Qualified (Slot 1)";
  else if (idx === 1) s.easternStatus = "Qualified (Slot 2)";
  else if (idx === 2) s.easternStatus = "Qualified (Slot 3)";
  else if (idx === 3) s.easternStatus = "1st Reserve";
  else if (idx === 4) s.easternStatus = "2nd Reserve";
  else if (idx === 5) s.easternStatus = "3rd Reserve";
  else s.easternStatus = "Eligible (U14)";
});

const u14Girls = ILCA4_SELECTION_SAILORS
  .filter((s) => s.gender === "F" && s.isU14 && s.trialPts > 0)
  .sort((a, b) => b.trialPts - a.trialPts || a.finishPos - b.finishPos);

u14Girls.forEach((s, idx) => {
  s.easternRankGender = idx + 1;
  if (idx === 0) s.easternStatus = "Qualified (Slot 1)";
  else if (idx === 1) s.easternStatus = "Qualified (Slot 2)";
  else if (idx === 2) s.easternStatus = "Qualified (Slot 3)";
  else if (idx === 3) s.easternStatus = "1st Reserve";
  else if (idx === 4) s.easternStatus = "2nd Reserve";
  else if (idx === 5) s.easternStatus = "3rd Reserve";
  else s.easternStatus = "Eligible (U14)";
});

// Compute Asian Open provisional leaders (based on SNSC Event 1)
const u17Boys = ILCA4_SELECTION_SAILORS
  .filter((s) => s.gender === "M" && s.isU17 && s.snscPoints > 0)
  .sort((a, b) => b.snscPoints - a.snscPoints);

u17Boys.forEach((s, idx) => {
  s.asianRankGender = idx + 1;
  if (idx === 0) s.asianProvisionalStatus = "Provisional Leader (Slot 1)";
  else if (idx === 1) s.asianProvisionalStatus = "Provisional Leader (Slot 2)";
  else if (idx === 2) s.asianProvisionalStatus = "Provisional Leader (Slot 3)";
  else if (idx === 3) s.asianProvisionalStatus = "Provisional Leader (Slot 4)";
  else if (idx === 4) s.asianProvisionalStatus = "Provisional Reserve";
  else s.asianProvisionalStatus = "Eligible (U17)";
});

const u17Girls = ILCA4_SELECTION_SAILORS
  .filter((s) => s.gender === "F" && s.isU17 && s.snscPoints > 0)
  .sort((a, b) => b.snscPoints - a.snscPoints);

u17Girls.forEach((s, idx) => {
  s.asianRankGender = idx + 1;
  if (idx === 0) s.asianProvisionalStatus = "Provisional Leader (Slot 1)";
  else if (idx === 1) s.asianProvisionalStatus = "Provisional Leader (Slot 2)";
  else if (idx === 2) s.asianProvisionalStatus = "Provisional Leader (Slot 3)";
  else if (idx === 3) s.asianProvisionalStatus = "Provisional Leader (Slot 4)";
  else if (idx === 4) s.asianProvisionalStatus = "Provisional Reserve";
  else s.asianProvisionalStatus = "Eligible (U17)";
});

// Compute NJTS allocations (Top 25 overall)
const top25 = ILCA4_SELECTION_SAILORS.filter((s) => s.nationalRank <= 25);
let mTopOverall = 0;
let fTopOverall = 0;
let mAge16 = 0;
let fAge16 = 0;
let mAge15 = 0;
let fAge15 = 0;

top25.forEach((s) => {
  const age = s.birthYear ? 2026 - s.birthYear : null;
  if (s.gender === "M") {
    if (mTopOverall < 2) {
      s.njtsStatus = "Top 2 Overall";
      mTopOverall++;
    } else if (age === 16 && mAge16 < 2) {
      s.njtsStatus = "Age 16 Bucket";
      mAge16++;
    } else if (age !== null && age <= 15 && mAge15 < 4) {
      s.njtsStatus = "Age ≤ 15 Bucket";
      mAge15++;
    } else {
      s.njtsStatus = "Top 25 Contender";
    }
  } else if (s.gender === "F") {
    if (fTopOverall < 2) {
      s.njtsStatus = "Top 2 Overall";
      fTopOverall++;
    } else if (age === 16 && fAge16 < 2) {
      s.njtsStatus = "Age 16 Bucket";
      fAge16++;
    } else if (age !== null && age <= 15 && fAge15 < 4) {
      s.njtsStatus = "Age ≤ 15 Bucket";
      fAge15++;
    } else {
      s.njtsStatus = "Top 25 Contender";
    }
  }
});

export function getEasternQualifiedTeam() {
  const qualifiedBoys = ILCA4_SELECTION_SAILORS.filter((s) =>
    s.easternStatus.startsWith("Qualified") && s.gender === "M"
  ).sort((a, b) => (a.easternRankGender ?? 99) - (b.easternRankGender ?? 99));

  const reserveBoys = ILCA4_SELECTION_SAILORS.filter((s) =>
    s.easternStatus.includes("Reserve") && s.gender === "M"
  ).sort((a, b) => (a.easternRankGender ?? 99) - (b.easternRankGender ?? 99));

  const qualifiedGirls = ILCA4_SELECTION_SAILORS.filter((s) =>
    s.easternStatus.startsWith("Qualified") && s.gender === "F"
  ).sort((a, b) => (a.easternRankGender ?? 99) - (b.easternRankGender ?? 99));

  const reserveGirls = ILCA4_SELECTION_SAILORS.filter((s) =>
    s.easternStatus.includes("Reserve") && s.gender === "F"
  ).sort((a, b) => (a.easternRankGender ?? 99) - (b.easternRankGender ?? 99));

  return {
    qualifiedBoys,
    reserveBoys,
    qualifiedGirls,
    reserveGirls,
  };
}

export function getAsianProvisionalLeaders() {
  const leaderBoys = ILCA4_SELECTION_SAILORS.filter((s) =>
    s.asianProvisionalStatus.startsWith("Provisional Leader") && s.gender === "M"
  ).sort((a, b) => (a.asianRankGender ?? 99) - (b.asianRankGender ?? 99));

  const leaderGirls = ILCA4_SELECTION_SAILORS.filter((s) =>
    s.asianProvisionalStatus.startsWith("Provisional Leader") && s.gender === "F"
  ).sort((a, b) => (a.asianRankGender ?? 99) - (b.asianRankGender ?? 99));

  return {
    leaderBoys,
    leaderGirls,
  };
}

export function getNjtsProjectedSquad() {
  return ILCA4_SELECTION_SAILORS.filter((s) =>
    ["Top 2 Overall", "Age 16 Bucket", "Age ≤ 15 Bucket"].includes(s.njtsStatus)
  ).sort((a, b) => a.nationalRank - b.nationalRank);
}

