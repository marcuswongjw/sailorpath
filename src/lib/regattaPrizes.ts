/**
 * Official Notice of Race (NoR) Prize Categories & Verified Winners
 *
 * Covers Singapore National Sailing Championships (SNSC 2026) and Pesta Sukan 2026
 * per Section 19 of their respective official Notices of Race (NoR).
 */

export type PrizeWinner = {
  rank: number;
  prizeTitle: string; // e.g. "1st", "2nd", "3rd", "Top Secondary School"
  sailorName: string;
  sailNumber?: string;
  gender?: "M" | "F";
  birthYear?: number;
  schoolName?: string;
  club?: string;
  notes?: string;
};

export type PrizeCategory = {
  categoryName: string;
  prizesAwarded: string; // e.g. "1st to 3rd", "1st to 10th", "1st"
  eligibilityNotes?: string;
  winners: PrizeWinner[];
};

export type RegattaPrizeFleet = {
  fleetName: string;
  boatClass: string;
  categories: PrizeCategory[];
};

export type RegattaPrizeSchedule = {
  regattaSlug: string;
  regattaName: string;
  year: number;
  datesText: string;
  venue: string;
  organizer: string;
  noticeOfRaceUrl: string;
  officialNoticeBoardUrl: string;
  websiteUrl: string;
  registrationUrl: string;
  entryFees: {
    singleHanded: number;
    doubleHanded: number;
    earlyBirdDeadline: string;
    finalDeadline: string;
    lateFee: number;
  };
  scheduleSummary: string;
  scoringRules: string;
  fleets: RegattaPrizeFleet[];
};

// ============================================================================
// 1. SINGAPORE NATIONAL SAILING CHAMPIONSHIPS (SNSC) 2026
// ============================================================================

export const SNSC_2026_PRIZE_SCHEDULE: RegattaPrizeSchedule = {
  regattaSlug: "singapore-national-sailing-championships-2026",
  regattaName: "Singapore National Sailing Championships (SNSC) 2026",
  year: 2026,
  datesText: "5–7 September 2026 & 11–13 September 2026",
  venue: "National Sailing Centre, Singapore (1500 East Coast Parkway, Singapore 468963)",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/14487/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/14487/event",
  websiteUrl: "https://www.sailing.org.sg/events/354194",
  registrationUrl: "https://www.sailing.org.sg/events/323705",
  entryFees: {
    singleHanded: 117,
    doubleHanded: 234,
    earlyBirdDeadline: "17 August 2026, 2359h",
    finalDeadline: "24 August 2026, 2359h",
    lateFee: 54.5,
  },
  scheduleSummary:
    "Weekend 1 (5-7 Sep): Optimist Silver (7 races scheduled, max 3/day), Boards (Techno 293/293+, iQFOiL, WingFoil - 12 races scheduled, max 5/day). Weekend 2 (11-13 Sep): Optimist Gold, ILCA (4, 6, 7), 29er (9 races scheduled, max 4/day).",
  scoringRules:
    "1 race to constitute series. 5 to 9 races: 1 discard. 10 or more races: 2 discards (RRS Appendix A).",
  fleets: [
    {
      fleetName: "ILCA 4",
      boatClass: "ILCA 4",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (National Champion)",
              sailorName: "Goh, Ian",
              gender: "M",
              birthYear: 2009,
              schoolName: "Raffles Institution / ACS(I)",
              notes: "1st place overall in official SNSC scoring (46 pts)",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Wai, Zhi Tong",
              gender: "F",
              birthYear: 2010,
              notes: "2nd place overall (45 pts) and top female",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Pee, Teck Woon",
              gender: "M",
              birthYear: 2011,
              notes: "3rd place overall (44 pts)",
            },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Female",
              sailorName: "Wai, Zhi Tong",
              gender: "F",
              birthYear: 2010,
              notes: "2nd overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Lee, Isla Zhi Xi",
              gender: "F",
              birthYear: 2012,
              notes: "7th overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Tew, Mika",
              gender: "F",
              birthYear: 2010,
              notes: "8th overall",
            },
          ],
        },
        {
          categoryName: "13 Years & Under (born 2013 or later)",
          prizesAwarded: "1st to 3rd",
          eligibilityNotes: "Born in 2013 or later",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (13&U)",
              sailorName: "Lin, Shin Chen Rui",
              gender: "M",
              birthYear: 2013,
              notes: "11th overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd (13&U)",
              sailorName: "Kong, Charles Shing Chak",
              gender: "M",
              birthYear: 2014,
              notes: "14th overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd (13&U)",
              sailorName: "Cao, Caleb Zhixuan",
              gender: "M",
              birthYear: 2014,
              notes: "34th overall",
            },
          ],
        },
        {
          categoryName: "Secondary School",
          prizesAwarded: "1st",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Secondary School",
              sailorName: "Goh, Ian",
              gender: "M",
              birthYear: 2009,
              schoolName: "Secondary School Division",
            },
          ],
        },
      ],
    },
    {
      fleetName: "WingFoil",
      boatClass: "WingFoil",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (National Champion)",
              sailorName: "Kate En Rui Bateman",
              sailNumber: "21",
              gender: "F",
              schoolName: "CHIJ Secondary (Toa Payoh)",
              club: "Windsurfing Association of Singapore",
              notes: "Nett score: 26.0 (3 race wins)",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Victoria Natasha Chew",
              sailNumber: "18",
              gender: "F",
              schoolName: "Methodist Girls' School",
              club: "PAssion Wave",
              notes: "Nett score: 27.0 (3 race wins)",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Mason Qifeng Lau",
              sailNumber: "27",
              gender: "M",
              schoolName: "Tao Nan School",
              club: "Constant Wind SeaSports",
              notes: "Nett score: 27.0 (3 race wins)",
            },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Female",
              sailorName: "Kate En Rui Bateman",
              sailNumber: "21",
              gender: "F",
              schoolName: "CHIJ Secondary (Toa Payoh)",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Victoria Natasha Chew",
              sailNumber: "18",
              gender: "F",
              schoolName: "Methodist Girls' School",
            },
          ],
        },
        {
          categoryName: "16 Years & Under (born 2010 or later)",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (16&U)",
              sailorName: "Kate En Rui Bateman",
              sailNumber: "21",
              gender: "F",
              schoolName: "CHIJ Secondary (Toa Payoh)",
            },
            {
              rank: 2,
              prizeTitle: "2nd (16&U)",
              sailorName: "Victoria Natasha Chew",
              sailNumber: "18",
              gender: "F",
              schoolName: "Methodist Girls' School",
            },
            {
              rank: 3,
              prizeTitle: "3rd (16&U)",
              sailorName: "Mason Qifeng Lau",
              sailNumber: "27",
              gender: "M",
              schoolName: "Tao Nan School",
            },
          ],
        },
      ],
    },
    {
      fleetName: "Techno 293 / 293+",
      boatClass: "Techno 293",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (National Champion)",
              sailorName: "Axl Tan",
              sailNumber: "S24",
              gender: "M",
              schoolName: "Anglo-Chinese School (Barker Road)",
              club: "Constant Wind SeaSports",
              notes: "Nett score: 19.0 (4 race wins across 12 races)",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Shan Qi",
              sailNumber: "26",
              gender: "F",
              schoolName: "Bedok View Secondary School",
              club: "SAF Yacht Club",
              notes: "Nett score: 21.0 (3 race wins)",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Kate Teo",
              sailNumber: "4",
              gender: "F",
              schoolName: "Paya Lebar Methodist Girls' School",
              club: "Constant Wind SeaSports",
              notes: "Nett score: 31.0",
            },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Female",
              sailorName: "Shan Qi",
              sailNumber: "26",
              gender: "F",
              schoolName: "Bedok View Secondary School",
              club: "SAF Yacht Club",
              notes: "2nd overall",
            },
          ],
        },
      ],
    },
    {
      fleetName: "Optimist Gold Fleet",
      boatClass: "Optimist",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 10th",
          winners: [],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [],
        },
        {
          categoryName: "Aged 11 - 12 years old (born between 2014 and 2015)",
          prizesAwarded: "1st to 5th",
          winners: [],
        },
        {
          categoryName: "Aged 9 - 10 years old (born between 2016 and 2017)",
          prizesAwarded: "1st to 5th",
          winners: [],
        },
        {
          categoryName: "Primary School",
          prizesAwarded: "1st",
          winners: [],
        },
        {
          categoryName: "Secondary School",
          prizesAwarded: "1st",
          winners: [],
        },
      ],
    },
    {
      fleetName: "Optimist Silver Fleet",
      boatClass: "Optimist",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 10th",
          winners: [],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [],
        },
        {
          categoryName: "Aged 9 - 10 years old (born between 2016 and 2017)",
          prizesAwarded: "1st to 3rd",
          winners: [],
        },
        {
          categoryName: "8 years and under (born in 2018 or later)",
          prizesAwarded: "1st to 3rd",
          winners: [],
        },
        {
          categoryName: "Novice (first-time participants in a ranking race or regatta)",
          prizesAwarded: "1st to 10th",
          winners: [],
        },
        {
          categoryName: "Primary School",
          prizesAwarded: "1st",
          winners: [],
        },
      ],
    },
  ],
};

// ============================================================================
// 2. PESTA SUKAN 2026
// ============================================================================

export const PESTA_SUKAN_2026_PRIZE_SCHEDULE: RegattaPrizeSchedule = {
  regattaSlug: "pesta-sukan-regatta-2026-optimist",
  regattaName: "Pesta Sukan 2026",
  year: 2026,
  datesText: "25–26 July 2026 & 1–2 August 2026",
  venue: "National Sailing Centre, Singapore (1500 East Coast Parkway, Singapore 468963)",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/14397/event?name=pesta-sukan-2026",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/14397/event?name=pesta-sukan-2026",
  websiteUrl: "https://www.sailing.org.sg/events/351968",
  registrationUrl: "https://www.sailing.org.sg/events/351968",
  entryFees: {
    singleHanded: 78,
    doubleHanded: 156,
    earlyBirdDeadline: "6 July 2026, 2359h",
    finalDeadline: "13 July 2026, 2359h",
    lateFee: 54.5,
  },
  scheduleSummary:
    "Weekend 1 (25-26 Jul): Optimist Silver and boards, plus the Open Water Festival Passage Race. Weekend 2 (1-2 Aug): Optimist Gold, ILCA, and 29er. Official final results: Optimist Gold 6 races, 1 discard, 77 entries (final 3 Aug 2026, 17:07). Optimist Silver 4 races, 1 discard, 54 entries (final 28 Jul 2026, 09:57). ILCA 4 5 races, 1 discard, 43 entries (final 3 Aug 2026, 17:04).",
  scoringRules:
    "1 race to constitute series. 4 or more races: 1 discard. Passage race is standalone for Opti Gold, ILCA, 29er; scored as individual races for Silver & Boards.",
  fleets: [
    {
      fleetName: "ILCA 4",
      boatClass: "ILCA 4",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st",
              sailorName: "Caleb Peck",
              sailNumber: "225221",
              gender: "M",
              schoolName: "Raffles Institution",
              club: "PAssion Wave",
              notes: "Official final results, 3 Aug 2026. Nett 6.",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Lucas Zhihong Cao",
              sailNumber: "149",
              gender: "M",
              schoolName: "Raffles Institution",
              club: "SAF Yacht Club",
              notes: "Nett 16.",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Yuk Jun Lim",
              sailNumber: "225182",
              gender: "M",
              schoolName: "St. Joseph's Institution",
              club: "SAF Yacht Club",
              notes: "Nett 16.",
            },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Female",
              sailorName: "Lyric Yuxuan Li",
              sailNumber: "728",
              gender: "F",
              schoolName: "Raffles Girls' School",
              club: "SAF Yacht Club",
              notes: "4th overall. Nett 19.",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Isla Zhi Xi Lee",
              sailNumber: "8",
              gender: "F",
              schoolName: "Chung Cheng High School (Yishun)",
              club: "SAF Yacht Club",
              notes: "9th overall.",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Lauren Lim",
              sailNumber: "216431",
              gender: "F",
            },
          ],
        },
        {
          categoryName: "13 Years & Under (born 2013 or later)",
          prizesAwarded: "1st to 3rd",
          eligibilityNotes: "Born in 2013 or later",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (13&U)",
              sailorName: "Charles Shing Chak Kong",
              sailNumber: "227676",
              gender: "M",
              schoolName: "Anglo-Chinese School (Junior)",
              club: "Changi Sailing Club",
              notes: "8th overall.",
            },
            {
              rank: 2,
              prizeTitle: "2nd (13&U)",
              sailorName: "Gerome Sim",
              sailNumber: "4",
            },
            {
              rank: 3,
              prizeTitle: "3rd (13&U)",
              sailorName: "Shin Chen Rui Lin",
              sailNumber: "197424",
            },
          ],
        },
        {
          categoryName: "Secondary School",
          prizesAwarded: "1st",
          eligibilityNotes: "Listed in the NoR. The final Sailwave prize list did not name a winner.",
          winners: [],
        },
        {
          categoryName: "Novice (first-time participants in a ranking race or regatta)",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Novice", sailorName: "Aaron Chan", sailNumber: "221063" },
            { rank: 2, prizeTitle: "2nd Novice", sailorName: "Daniel Kocourek", sailNumber: "197845" },
            { rank: 3, prizeTitle: "3rd Novice", sailorName: "Qiyou Wu", sailNumber: "23" },
          ],
        },
      ],
    },
    {
      fleetName: "Open Water Festival Passage Race",
      boatClass: "All Classes",
      categories: [
        {
          categoryName: "Open (All Classes)",
          prizesAwarded: "1st to 3rd",
          eligibilityNotes: "Scored on low point system across mid-gate and final finish",
          winners: [],
        },
      ],
    },
    {
      fleetName: "Optimist Gold Fleet",
      boatClass: "Optimist",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 10th",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Alyssa Li Lin Wong", sailNumber: "150", gender: "F", schoolName: "Raffles Girls' School", club: "SAF Yacht Club", notes: "Nett 15." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Kevin Jun Yi Ho", sailNumber: "171", gender: "M", schoolName: "Raffles Institution", club: "SAF Yacht Club", notes: "Nett 20." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Ethan Zhi Ren Low", sailNumber: "78", gender: "M", schoolName: "St. Hilda's Primary School", club: "SAF Yacht Club", notes: "11–12. Nett 21." },
            { rank: 4, prizeTitle: "4th", sailorName: "Xuan Ya Tong", sailNumber: "107", gender: "F", club: "Constant Wind SeaSports", notes: "Nett 26." },
            { rank: 5, prizeTitle: "5th", sailorName: "Nathaniel Kaiden Ng", sailNumber: "3344", gender: "M", schoolName: "Anglo-Chinese School (Independent)", club: "PAssion Wave", notes: "Nett 29." },
            { rank: 6, prizeTitle: "6th", sailorName: "Ashlyn Tham", sailNumber: "100", gender: "F", schoolName: "St. Hilda's Secondary School", club: "PAssion Wave", notes: "Nett 34." },
            { rank: 7, prizeTitle: "7th", sailorName: "Jedd Zhi Hao Lam", sailNumber: "2000", gender: "M", schoolName: "Raffles Institution", club: "Constant Wind SeaSports", notes: "Nett 38." },
            { rank: 8, prizeTitle: "8th", sailorName: "Elliot Goh", sailNumber: "3103", gender: "M", schoolName: "Anglo-Chinese School (Independent)", club: "SAF Yacht Club", notes: "Nett 44." },
            { rank: 9, prizeTitle: "9th", sailorName: "Damien Huang", sailNumber: "3300", gender: "M", schoolName: "Raffles Institution", club: "SAF Yacht Club", notes: "Nett 48." },
            { rank: 10, prizeTitle: "10th", sailorName: "Kyle Jeremy Zhi Jun Soh", sailNumber: "3183", gender: "M", schoolName: "Anglo-Chinese School (Junior)", club: "SAF Yacht Club", notes: "11–12. Nett 60." },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Alyssa Li Lin Wong", sailNumber: "150", gender: "F" },
            { rank: 2, prizeTitle: "2nd Female", sailorName: "Xuan Ya Tong", sailNumber: "107", gender: "F" },
            { rank: 3, prizeTitle: "3rd Female", sailorName: "Ashlyn Tham", sailNumber: "100", gender: "F" },
          ],
        },
        {
          categoryName: "Aged 11 - 12 years old (born between 2014 and 2015)",
          prizesAwarded: "1st to 5th",
          winners: [
            { rank: 1, prizeTitle: "1st (11–12)", sailorName: "Ethan Zhi Ren Low", sailNumber: "78" },
            { rank: 2, prizeTitle: "2nd (11–12)", sailorName: "Kyle Jeremy Zhi Jun Soh", sailNumber: "3183" },
            { rank: 3, prizeTitle: "3rd (11–12)", sailorName: "Timothy Kai Zhe Ng", sailNumber: "2023" },
            { rank: 4, prizeTitle: "4th (11–12)", sailorName: "William Poon", sailNumber: "21" },
            { rank: 5, prizeTitle: "5th (11–12)", sailorName: "Rachel Qian Hui Lim", sailNumber: "3197" },
          ],
        },
        {
          categoryName: "Aged 9 - 10 years old (born between 2016 and 2017)",
          prizesAwarded: "1st to 5th",
          winners: [
            { rank: 1, prizeTitle: "1st (9–10)", sailorName: "Kirsten En Ting Tan", sailNumber: "3663" },
            { rank: 2, prizeTitle: "2nd (9–10)", sailorName: "Abby Yan Ying Chen", sailNumber: "4729" },
            { rank: 3, prizeTitle: "3rd (9–10)", sailorName: "Meera Srihari", sailNumber: "3889" },
            { rank: 4, prizeTitle: "4th (9–10)", sailorName: "Ashleigh Li Ying Teh", sailNumber: "788" },
            { rank: 5, prizeTitle: "5th (9–10)", sailorName: "Chen-Yi Kai", sailNumber: "757" },
          ],
        },
        {
          categoryName: "Primary School",
          prizesAwarded: "1st",
          eligibilityNotes: "Listed in the NoR. The final Sailwave prize list did not name a winner.",
          winners: [],
        },
        {
          categoryName: "Secondary School",
          prizesAwarded: "1st",
          eligibilityNotes: "Listed in the NoR. The final Sailwave prize list did not name a winner.",
          winners: [],
        },
      ],
    },
    {
      fleetName: "Optimist Silver Fleet",
      boatClass: "Optimist",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 10th",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Bryan Thian Tsek Lee", sailNumber: "3508", gender: "M", schoolName: "Anglo-Chinese School (Junior)", club: "SAF Yacht Club", notes: "Nett 4." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Muhammad Rehan Bin Mohamed Salim", sailNumber: "2059", gender: "M", schoolName: "White Sands Primary School", club: "Constant Wind SeaSports", notes: "9–10. Nett 17." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Jiaqian Wu", sailNumber: "3424", gender: "M", schoolName: "St. Hilda's Primary School", club: "SAF Yacht Club", notes: "9–10. Nett 19." },
            { rank: 4, prizeTitle: "4th", sailorName: "Jae Guan Yu Toh", sailNumber: "3311", gender: "M", schoolName: "Maris Stella High School", club: "SAF Yacht Club", notes: "8 & under. Nett 20." },
            { rank: 5, prizeTitle: "5th", sailorName: "Kiyansh Kanishk Singh", sailNumber: "2046", gender: "M", schoolName: "Anglo-Chinese School (Junior)", club: "Constant Wind SeaSports", notes: "Nett 20." },
            { rank: 6, prizeTitle: "6th", sailorName: "Neel Paul Behl", sailNumber: "SGP88", gender: "M", schoolName: "Zhangde Primary School", club: "Changi Sailing Club", notes: "9–10. Nett 27." },
            { rank: 7, prizeTitle: "7th", sailorName: "Jerome Puah Yang Yi", sailNumber: "2037", gender: "M", schoolName: "St. Joseph's Institution Junior", club: "PAssion Wave", notes: "9–10. Nett 27." },
            { rank: 8, prizeTitle: "8th", sailorName: "Moyan Han", sailNumber: "2042", gender: "M", schoolName: "Nan Hua Primary School", club: "Constant Wind SeaSports", notes: "9–10. Nett 27." },
            { rank: 9, prizeTitle: "9th", sailorName: "Thaddaeus Renz", sailNumber: "2058", gender: "M", schoolName: "Anglo-Chinese School (Junior)", club: "Constant Wind SeaSports", notes: "9–10. Nett 28." },
            { rank: 10, prizeTitle: "10th", sailorName: "Henry Shayan Mittelhauser", sailNumber: "2052", gender: "M", schoolName: "Tanjong Katong Primary School", club: "Constant Wind SeaSports", notes: "Nett 32." },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Jade Tan", sailNumber: "3425", gender: "F" },
            { rank: 2, prizeTitle: "2nd Female", sailorName: "Seraphina Kang", sailNumber: "2040", gender: "F" },
            { rank: 3, prizeTitle: "3rd Female", sailorName: "Yu an Li", sailNumber: "2056", gender: "F" },
          ],
        },
        {
          categoryName: "Aged 9 - 10 years old (born between 2016 and 2017)",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st (9–10)", sailorName: "Muhammad Rehan Bin Mohamed Salim", sailNumber: "2059" },
            { rank: 2, prizeTitle: "2nd (9–10)", sailorName: "Jiaqian Wu", sailNumber: "3424" },
            { rank: 3, prizeTitle: "3rd (9–10)", sailorName: "Neel Paul Behl", sailNumber: "SGP88" },
          ],
        },
        {
          categoryName: "8 years and under (born in 2018 or later)",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st (8 & under)", sailorName: "Jae Guan Yu Toh", sailNumber: "3311" },
            { rank: 2, prizeTitle: "2nd (8 & under)", sailorName: "Hillary Kai Hui Tan", sailNumber: "777" },
            { rank: 3, prizeTitle: "3rd (8 & under)", sailorName: "Allison Li Xin Teh", sailNumber: "787" },
          ],
        },
        {
          categoryName: "Novice (first-time participants in a ranking race or regatta)",
          prizesAwarded: "1st to 10th",
          eligibilityNotes: "The final prize list names 1st to 3rd. Places 4th to 10th are blank.",
          winners: [
            { rank: 1, prizeTitle: "1st Novice", sailorName: "Deborah Goh", sailNumber: "2067" },
            { rank: 2, prizeTitle: "2nd Novice", sailorName: "Charlotte Kanon Yap", sailNumber: "2065" },
            { rank: 3, prizeTitle: "3rd Novice", sailorName: "Isaac Chong", sailNumber: "2064" },
          ],
        },
        {
          categoryName: "Primary School",
          prizesAwarded: "1st",
          eligibilityNotes: "Listed in the NoR. The final Sailwave prize list did not name a winner.",
          winners: [],
        },
      ],
    },
  ],
};

// ============================================================================
// 3. CINCAPURA REGATTA 2026
// ============================================================================

export const CINCAPURA_2026_PRIZE_SCHEDULE: RegattaPrizeSchedule = {
  regattaSlug: "cincapura-regatta-2026",
  regattaName: "Cincapura Regatta 2026",
  year: 2026,
  datesText: "18–20 July 2026 (Results finalized 20–21 July 2026)",
  venue: "National Sailing Centre, Singapore (1500 East Coast Parkway, Singapore 468963)",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/14587/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/14587/event",
  websiteUrl: "https://www.sailing.org.sg/events/356060",
  registrationUrl: "https://www.sailing.org.sg/events/356060",
  entryFees: {
    singleHanded: 78,
    doubleHanded: 156,
    earlyBirdDeadline: "6 July 2026, 2359h",
    finalDeadline: "13 July 2026, 2359h",
    lateFee: 50,
  },
  scheduleSummary:
    "Official final results at National Sailing Centre. Optimist Gold: 3 races, no discard, 86 entries (final 20 Jul 2026, 13:18). Optimist Silver: 4 races, 1 discard, 55 entries (final 21 Jul 2026, 10:00). ILCA 4: 2 races, no discard, 42 entries (final 20 Jul 2026, 13:34). ILCA 6: 3 races, no discard, 16 entries (final 21 Jul 2026, 09:56). 29er: 2 races, no discard, 3 entries. Techno 293: 8 races, 1 discard, 7 entries (both final 21 Jul 2026, 10:13).",
  scoringRules:
    "Appendix A. Gold, ILCA 4, ILCA 6, and 29er: no discard. Silver: 1 discard. Techno 293: 1 discard.",
  fleets: [
    {
      fleetName: "Optimist Gold Fleet",
      boatClass: "Optimist",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 10th",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st",
              sailorName: "Kyle Jeremy Zhi Jun Soh",
              sailNumber: "3183",
              gender: "M",
              schoolName: "ANGLO-CHINESE SCHOOL (JUNIOR)",
              club: "SAF Yacht Club",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Alyssa Li Lin Wong",
              sailNumber: "150",
              gender: "F",
              schoolName: "RAFFLES GIRLS' SCHOOL (SECONDARY)",
              club: "SAF Yacht Club",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Wangsun Chen",
              sailNumber: "20",
              gender: "M",
              schoolName: "YUMIN PRIMARY SCHOOL",
              club: "Constant Wind SeaSports",
            },
            {
              rank: 4,
              prizeTitle: "4th",
              sailorName: "Tan Qi",
              sailNumber: "3026",
              gender: "F",
              schoolName: "TAO NAN SCHOOL",
              club: "Constant Wind SeaSports",
            },
            {
              rank: 5,
              prizeTitle: "5th",
              sailorName: "Rui Ling Teo",
              sailNumber: "3820",
              gender: "F",
              schoolName: "CHIJ (KATONG) PRIMARY",
              club: "SAF Yacht Club",
            },
            {
              rank: 6,
              prizeTitle: "6th",
              sailorName: "Timothy Kai Zhe Ng",
              sailNumber: "2023",
              gender: "M",
              schoolName: "TAO NAN SCHOOL",
              club: "Constant Wind SeaSports",
            },
            {
              rank: 7,
              prizeTitle: "7th",
              sailorName: "Kevin Jun Yi Ho",
              sailNumber: "171",
              gender: "M",
              schoolName: "RAFFLES INSTITUTION",
              club: "SAF Yacht Club",
            },
            {
              rank: 8,
              prizeTitle: "8th",
              sailorName: "Lavene Rui Xuan Lim",
              sailNumber: "3553",
              gender: "F",
              schoolName: "PASIR RIS PRIMARY SCHOOL",
              club: "SAF Yacht Club",
            },
            {
              rank: 9,
              prizeTitle: "9th",
              sailorName: "Jedd Zhi Hao Lam",
              sailNumber: "2000",
              gender: "M",
              schoolName: "RAFFLES INSTITUTION",
              club: "Constant Wind SeaSports",
            },
            {
              rank: 10,
              prizeTitle: "10th",
              sailorName: "Dan Guan You Toh",
              sailNumber: "3811",
              gender: "M",
              schoolName: "MARIS STELLA HIGH SCHOOL",
              club: "SAF Yacht Club",
            },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Female",
              sailorName: "Alyssa Li Lin Wong",
              sailNumber: "150",
              gender: "F",
              schoolName: "RAFFLES GIRLS' SCHOOL (SECONDARY)",
              club: "SAF Yacht Club",
              notes: "2nd overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Tan Qi",
              sailNumber: "3026",
              gender: "F",
              schoolName: "TAO NAN SCHOOL",
              club: "Constant Wind SeaSports",
              notes: "4th overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Rui Ling Teo",
              sailNumber: "3820",
              gender: "F",
              schoolName: "CHIJ (KATONG) PRIMARY",
              club: "SAF Yacht Club",
              notes: "5th overall",
            },
          ],
        },
        {
          categoryName: "11-12 yo",
          prizesAwarded: "1st to 5th",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (11-12 yo)",
              sailorName: "Kyle Jeremy Zhi Jun Soh",
              sailNumber: "3183",
              gender: "M",
              schoolName: "ANGLO-CHINESE SCHOOL (JUNIOR)",
              club: "SAF Yacht Club",
            },
            {
              rank: 2,
              prizeTitle: "2nd (11-12 yo)",
              sailorName: "Tan Qi",
              sailNumber: "3026",
              gender: "F",
              schoolName: "TAO NAN SCHOOL",
              club: "Constant Wind SeaSports",
            },
            {
              rank: 3,
              prizeTitle: "3rd (11-12 yo)",
              sailorName: "Rui Ling Teo",
              sailNumber: "3820",
              gender: "F",
              schoolName: "CHIJ (KATONG) PRIMARY",
              club: "SAF Yacht Club",
            },
            {
              rank: 4,
              prizeTitle: "4th (11-12 yo)",
              sailorName: "Timothy Kai Zhe Ng",
              sailNumber: "2023",
              gender: "M",
              schoolName: "TAO NAN SCHOOL",
              club: "Constant Wind SeaSports",
            },
            {
              rank: 5,
              prizeTitle: "5th (11-12 yo)",
              sailorName: "Lavene Rui Xuan Lim",
              sailNumber: "3553",
              gender: "F",
              schoolName: "PASIR RIS PRIMARY SCHOOL",
              club: "SAF Yacht Club",
            },
          ],
        },
        {
          categoryName: "9-10 yo",
          prizesAwarded: "1st to 5th",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (9-10 yo)",
              sailorName: "Abby Yan Ying Chen",
              sailNumber: "4729",
              gender: "F",
              schoolName: "CHIJ ST. NICHOLAS GIRLS' SCHOOL",
              club: "PAssion Wave",
              notes: "28th overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd (9-10 yo)",
              sailorName: "Chen-Yi Kai",
              sailNumber: "757",
              gender: "M",
              schoolName: "FAIRFIELD METHODIST SCHOOL",
              club: "SAF Yacht Club",
              notes: "31st overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd (9-10 yo)",
              sailorName: "Hayley Kai En Tan",
              sailNumber: "700",
              gender: "F",
              schoolName: "KONG HWA SCHOOL",
              club: "Changi Sailing Club",
              notes: "32nd overall",
            },
            {
              rank: 4,
              prizeTitle: "4th (9-10 yo)",
              sailorName: "Kirsten En Ting Tan",
              sailNumber: "3663",
              gender: "F",
              schoolName: "ST. HILDA'S PRIMARY SCHOOL",
              club: "SAF Yacht Club",
              notes: "39th overall",
            },
            {
              rank: 5,
              prizeTitle: "5th (9-10 yo)",
              sailorName: "Ashleigh Li Ying Teh",
              sailNumber: "788",
              gender: "F",
              schoolName: "TAO NAN SCHOOL",
              club: "SAF Yacht Club",
              notes: "40th overall",
            },
          ],
        },
      ],
    },
    {
      fleetName: "Optimist Silver Fleet",
      boatClass: "Optimist",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 10th",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st",
              sailorName: "Adele Ziyi Chiang",
              sailNumber: "3120",
              gender: "F",
              schoolName: "TAO NAN SCHOOL",
              club: "SAF Yacht Club",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Bryan Thian Tsek Lee",
              sailNumber: "3508",
              gender: "M",
              schoolName: "ANGLO-CHINESE SCHOOL (JUNIOR)",
              club: "SAF Yacht Club",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Ryan Feiran Zheng",
              sailNumber: "2045",
              gender: "M",
              schoolName: "ST. STEPHEN'S SCHOOL",
              club: "Constant Wind SeaSport",
            },
            {
              rank: 4,
              prizeTitle: "4th",
              sailorName: "Kiyansh Kanishk Singh",
              sailNumber: "2046",
              gender: "M",
              schoolName: "ANGLO-CHINESE SCHOOL (JUNIOR)",
              club: "Constant Wind SeaSport",
            },
            {
              rank: 5,
              prizeTitle: "5th",
              sailorName: "Yong Le Wai",
              sailNumber: "3488",
              gender: "M",
              schoolName: "FIRST TOA PAYOH PRIMARY SCHOOL",
              club: "SAF Yacht Club",
            },
            {
              rank: 6,
              prizeTitle: "6th",
              sailorName: "Muhammad Rehan Bin Mohamed Salim",
              sailNumber: "2059",
              gender: "M",
              schoolName: "WHITE SANDS PRIMARY SCHOOL",
              club: "Constant Wind SeaSport",
            },
            {
              rank: 7,
              prizeTitle: "7th",
              sailorName: "Axel Lin",
              sailNumber: "720",
              gender: "M",
              schoolName: "NANYANG PRIMARY SCHOOL",
              club: "Changi Sailing Club",
            },
            {
              rank: 8,
              prizeTitle: "8th",
              sailorName: "Henry Shayan Mittelhauser",
              sailNumber: "2052",
              gender: "M",
              schoolName: "TANJONG KATONG PRIMARY SCHOOL",
              club: "Constant Wind SeaSport",
            },
            {
              rank: 9,
              prizeTitle: "9th",
              sailorName: "Moyan Han",
              sailNumber: "2042",
              gender: "M",
              schoolName: "NAN HUA PRIMARY SCHOOL",
              club: "Constant Wind SeaSport",
            },
            {
              rank: 10,
              prizeTitle: "10th",
              sailorName: "Damien Seah",
              sailNumber: "3825",
              gender: "M",
              schoolName: "ST. HILDA'S PRIMARY SCHOOL",
              club: "SAF Yacht Club",
            },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Female",
              sailorName: "Adele Ziyi Chiang",
              sailNumber: "3120",
              gender: "F",
              schoolName: "TAO NAN SCHOOL",
              club: "SAF Yacht Club",
              notes: "1st overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Jade Tan",
              sailNumber: "3425",
              gender: "F",
              schoolName: "AI TONG SCHOOL",
              club: "SAF Yacht Club",
              notes: "11th overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Nadia Zahedi",
              sailNumber: "4724",
              gender: "F",
              schoolName: "TAO NAN SCHOOL",
              club: "PAssion Wave",
              notes: "26th overall",
            },
          ],
        },
        {
          categoryName: "8&U",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (8&U)",
              sailorName: "Jae Guan Yu Toh",
              sailNumber: "3311",
              gender: "M",
              schoolName: "MARIS STELLA HIGH SCHOOL",
              club: "SAF Yacht Club",
              notes: "20th overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd (8&U)",
              sailorName: "Allison Li Xin Teh",
              sailNumber: "787",
              gender: "F",
              schoolName: "TAO NAN SCHOOL",
              club: "SAF Yacht Club",
              notes: "32nd overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd (8&U)",
              sailorName: "Ryan Jonathan Zhi Jie Soh",
              sailNumber: "3110",
              gender: "M",
              schoolName: "ANGLO-CHINESE SCHOOL (JUNIOR)",
              club: "SAF Yacht Club",
              notes: "40th overall",
            },
          ],
        },
        {
          categoryName: "Novice",
          prizesAwarded: "1st to 5th",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Novice",
              sailorName: "Allison Li Xin Teh",
              sailNumber: "787",
              gender: "F",
              schoolName: "TAO NAN SCHOOL",
              club: "SAF Yacht Club",
              notes: "32nd overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd Novice",
              sailorName: "Ethan Guo",
              sailNumber: "2066",
              gender: "M",
              schoolName: "ANGLO-CHINESE SCHOOL (JUNIOR)",
              club: "Constant Wind SeaSport",
              notes: "36th overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd Novice",
              sailorName: "Evan Yu",
              sailNumber: "2061",
              gender: "M",
              schoolName: "ALEXANDRA PRIMARY SCHOOL",
              club: "Constant Wind SeaSport",
              notes: "47th overall",
            },
            {
              rank: 4,
              prizeTitle: "4th Novice",
              sailorName: "Zachary Chew",
              sailNumber: "3666",
              gender: "M",
              schoolName: "ST. HILDA'S PRIMARY SCHOOL",
              club: "SAF Yacht Club",
              notes: "49th overall",
            },
            {
              rank: 5,
              prizeTitle: "5th Novice",
              sailorName: "Sakura Jia Xin Hia",
              sailNumber: "310",
              gender: "F",
              schoolName: "ST. HILDA'S PRIMARY SCHOOL",
              club: "Changi Sailing Club",
              notes: "53rd overall",
            },
          ],
        },
        {
          categoryName: "9-10 yo",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (9-10 yo)",
              sailorName: "Adele Ziyi Chiang",
              sailNumber: "3120",
              gender: "F",
              schoolName: "TAO NAN SCHOOL",
              club: "SAF Yacht Club",
              notes: "1st overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd (9-10 yo)",
              sailorName: "Muhammad Rehan Bin Mohamed Salim",
              sailNumber: "2059",
              gender: "M",
              schoolName: "WHITE SANDS PRIMARY SCHOOL",
              club: "Constant Wind SeaSport",
              notes: "6th overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd (9-10 yo)",
              sailorName: "Axel Lin",
              sailNumber: "720",
              gender: "M",
              schoolName: "NANYANG PRIMARY SCHOOL",
              club: "Changi Sailing Club",
              notes: "7th overall",
            },
          ],
        },
      ],
    },
    {
      fleetName: "ILCA 4",
      boatClass: "ILCA 4",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Mika Tew", sailNumber: "227461", gender: "F", schoolName: "Raffles Girls' School (Secondary)", club: "PAssion Wave", notes: "Nett 7." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Lucas Zhihong Cao", sailNumber: "93", gender: "M", schoolName: "Raffles Institution", club: "SAF Yacht Club", notes: "Nett 10." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Zhi Tong Wai", sailNumber: "225226", gender: "F", schoolName: "CHIJ Secondary (Toa Payoh)", club: "SAF Yacht Club", notes: "Nett 10." },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Mika Tew", sailNumber: "227461", gender: "F" },
            { rank: 2, prizeTitle: "2nd Female", sailorName: "Zhi Tong Wai", sailNumber: "225226", gender: "F" },
            { rank: 3, prizeTitle: "3rd Female", sailorName: "Lyric Yuxuan Li", sailNumber: "21476", gender: "F" },
          ],
        },
        {
          categoryName: "Novice",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Novice", sailorName: "Lyric Yuxuan Li", sailNumber: "21476" },
            { rank: 2, prizeTitle: "2nd Novice", sailorName: "Shin Chen Rui Lin", sailNumber: "197424" },
            { rank: 3, prizeTitle: "3rd Novice", sailorName: "Aiden Kang Jun Wong", sailNumber: "18" },
          ],
        },
        {
          categoryName: "13 years and under",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st (13 & under)", sailorName: "Shin Chen Rui Lin", sailNumber: "197424" },
            { rank: 2, prizeTitle: "2nd (13 & under)", sailorName: "Charles Shing Chak Kong", sailNumber: "227676" },
            { rank: 3, prizeTitle: "3rd (13 & under)", sailorName: "Rayson Yin Yi Lee", sailNumber: "217060" },
          ],
        },
      ],
    },
    {
      fleetName: "ILCA 6",
      boatClass: "ILCA 6",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Sarah Rui-En Yong", sailNumber: "221689", gender: "F", schoolName: "Nanyang Polytechnic", club: "Royal Varuna Yacht Club", notes: "Nett 6." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Keira Carlyle", sailNumber: "225225", gender: "F", schoolName: "Nanyang Polytechnic", club: "SAF Yacht Club", notes: "Nett 7." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Kenan Kee Zen Tan", sailNumber: "1", gender: "M", club: "Royal Varuna Yacht Club", notes: "Nett 9." },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Sarah Rui-En Yong", sailNumber: "221689", gender: "F" },
            { rank: 2, prizeTitle: "2nd Female", sailorName: "Keira Carlyle", sailNumber: "225225", gender: "F" },
            { rank: 3, prizeTitle: "3rd Female", sailorName: "Nia Zahedi", sailNumber: "224245", gender: "F" },
          ],
        },
        {
          categoryName: "15 years and under",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st (15 & under)", sailorName: "Kai Lun Wong", sailNumber: "227462" },
            { rank: 2, prizeTitle: "2nd (15 & under)", sailorName: "Travis Jia Le Yeo", sailNumber: "222727" },
            { rank: 3, prizeTitle: "3rd (15 & under)", sailorName: "Darren Lai", sailNumber: "222257" },
          ],
        },
        {
          categoryName: "Novice",
          prizesAwarded: "1st to 3rd",
          eligibilityNotes: "The final prize list names 1st only. 2nd and 3rd are blank.",
          winners: [
            { rank: 1, prizeTitle: "1st Novice", sailorName: "Travis Jia Le Yeo", sailNumber: "222727" },
          ],
        },
      ],
    },
    {
      fleetName: "29er",
      boatClass: "29er",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Cheryl Ho / Gemma Chen", sailNumber: "2869", gender: "F", schoolName: "Raffles Girls' School", notes: "Nett 2." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Cheryl Yong / Seth Low", sailNumber: "2466", club: "Changi Sailing Club", notes: "Mixed crew. Nett 4." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Sean Kum / Nigel Tan", sailNumber: "2742", gender: "M", notes: "DNC both races. Nett 8." },
          ],
        },
      ],
    },
    {
      fleetName: "Techno 293",
      boatClass: "Techno 293",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Addy Armand Anuar", sailNumber: "143", gender: "M", schoolName: "Bedok Green Secondary School", club: "Constant Wind SeaSports", notes: "Nett 14." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Axl Tan", sailNumber: "64", gender: "M", schoolName: "Anglo-Chinese School (Barker Road)", club: "Constant Wind SeaSports", notes: "Nett 20." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Trevor Ng", sailNumber: "45", gender: "M", schoolName: "Victoria School", club: "Constant Wind SeaSports", notes: "Nett 23." },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Kate Teo", sailNumber: "235", gender: "F", schoolName: "Paya Lebar Methodist Girls' School", club: "Constant Wind SeaSports", notes: "4th overall. Nett 24." },
          ],
        },
      ],
    },
  ],
};

export const SAFYC_OPTIMIST_2026_PRIZE_SCHEDULE: RegattaPrizeSchedule = {
  regattaSlug: "2nd-safyc-optimist-championships-2026",
  regattaName: "2nd SAFYC Optimist Championships 2026",
  year: 2026,
  datesText: "4–5 July 2026",
  venue: "NSRCC Seasports Centre, 11 Changi Coast Walk, Singapore 499740",
  organizer: "SAF Yacht Club",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/14691/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/14691/event",
  websiteUrl: "https://www.safyc.org.sg",
  registrationUrl: "https://www.safyc.org.sg",
  entryFees: {
    singleHanded: 70.85,
    doubleHanded: 70.85,
    earlyBirdDeadline: "25 June 2026",
    finalDeadline: "25 June 2026",
    lateFee: 21.8,
  },
  scheduleSummary:
    "Optimist Gold and Silver. First warning 1100h on 4 and 5 July. Prize presentation 1800h on 5 July at NSRCC Seasports Centre. Official results final 6 July 2026. Gold: 7 races, 1 discard, 91 entries. Silver: 5 races, 1 discard, 58 entries.",
  scoringRules:
    "One race constitutes the event. Fewer than 4 races: no discard. Four or more races: one discard.",
  fleets: [
    {
      fleetName: "Optimist Gold Fleet",
      boatClass: "Optimist",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 10th",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Alyssa Wong Li Lin", sailNumber: "150", club: "SAF Yacht Club", notes: "Nett 18.8." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Kevin Ho", sailNumber: "171", club: "SAF Yacht Club", notes: "Nett 23.3." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Low Ethan Zhi Ren", sailNumber: "78", club: "SAF Yacht Club", notes: "Nett 28.0." },
            { rank: 4, prizeTitle: "4th", sailorName: "Ethan Lee", sailNumber: "83", notes: "Nett 45.0." },
            { rank: 5, prizeTitle: "5th", sailorName: "Teo Jairus", sailNumber: "4073", club: "SAF Yacht Club", notes: "Nett 46.0." },
            { rank: 6, prizeTitle: "6th", sailorName: "Anya Zahedi", sailNumber: "159", notes: "Nett 50.0." },
            { rank: 7, prizeTitle: "7th", sailorName: "Elliot Goh", sailNumber: "3103", club: "SAF Yacht Club", notes: "Nett 56.0." },
            { rank: 8, prizeTitle: "8th", sailorName: "Nathaniel Kaiden Ng", sailNumber: "3344", notes: "Nett 58.2." },
            { rank: 9, prizeTitle: "9th", sailorName: "Darian Huang", sailNumber: "3700", notes: "Nett 64.0." },
            { rank: 10, prizeTitle: "10th", sailorName: "Tong Xuan Ya", sailNumber: "107", club: "Constant Wind", notes: "Nett 71.0." },
          ],
        },
      ],
    },
    {
      fleetName: "Optimist Silver Fleet",
      boatClass: "Optimist",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 10th",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Lee Thian Tsek Bryan", sailNumber: "3508", club: "SAF Yacht Club", notes: "Nett 11.0." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Han Moyan", sailNumber: "2042", club: "Constant Wind", notes: "Nett 14.5." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Changqi Tao", sailNumber: "5721", club: "Wuxi Schonst Sailing Club", notes: "Nett 17.5." },
            { rank: 4, prizeTitle: "4th", sailorName: "Jerome Puah Yang Yi", sailNumber: "2037", notes: "Nett 19.0." },
            { rank: 5, prizeTitle: "5th", sailorName: "Wu Jiaqian", sailNumber: "3424", club: "SAF Yacht Club", notes: "Nett 27.0." },
            { rank: 6, prizeTitle: "6th", sailorName: "Jade Tan", sailNumber: "3555", club: "SAF Yacht Club", notes: "Nett 30.0." },
            { rank: 7, prizeTitle: "7th", sailorName: "Chiang Ziyi Adele", sailNumber: "3120", club: "SAF Yacht Club", notes: "Nett 31.3." },
            { rank: 8, prizeTitle: "8th", sailorName: "Henry Mittelhauser", sailNumber: "2052", club: "Constant Wind", notes: "Nett 35.0." },
            { rank: 9, prizeTitle: "9th", sailorName: "Muhammad Rehan Bin Mohamed Salim", sailNumber: "2059", club: "Constant Wind", notes: "Nett 39.0." },
            { rank: 10, prizeTitle: "10th", sailorName: "Zheng Ryan Feiran", sailNumber: "2045", club: "Constant Wind", notes: "Nett 43.0." },
          ],
        },
      ],
    },
  ],
};

/**
 * Retrieves the official prize schedule (categories and verified winners) for a given regatta slug.
 */
export function getRegattaPrizeSchedule(slug: string): RegattaPrizeSchedule | null {
  const s = String(slug || "").toLowerCase();
  if (
    s.includes("singapore-national-sailing-championships-2026") ||
    s.includes("snsc-2026") ||
    s === "snsc-2026" ||
    (s.includes("snsc") && s.includes("sep-26"))
  ) {
    return SNSC_2026_PRIZE_SCHEDULE;
  }
  if (
    s.includes("pesta-sukan-2026") ||
    s.includes("pesta-sukan-regatta-2026") ||
    s === "pesta-sukan-2026" ||
    (s.includes("pesta-sukan") && s.includes("aug-26"))
  ) {
    return PESTA_SUKAN_2026_PRIZE_SCHEDULE;
  }
  if (
    s.includes("cincapura-regatta-2026") ||
    s.includes("cincapura-2026") ||
    s === "cincapura-2026" ||
    (s.includes("cincapura") && s.includes("jul-26"))
  ) {
    return CINCAPURA_2026_PRIZE_SCHEDULE;
  }
  if (
    s.includes("2nd-safyc-optimist") ||
    s.includes("safyc-optimist-championship")
  ) {
    return SAFYC_OPTIMIST_2026_PRIZE_SCHEDULE;
  }
  return null;
}

export type RegattaPrizeWinnersView = {
  schedule: RegattaPrizeSchedule;
  /** Fleets with at least one winner-bearing category (empty categories stripped). */
  fleets: RegattaPrizeFleet[];
};

/**
 * Fleet name implied by a results-page slug.
 * `undefined` means an event-level slug: show every fleet that has winners.
 * `null` means a class this schedule does not publish, such as ILCA 7.
 */
export function inferPrizeFleetName(slug: string): string | undefined | null {
  const s = String(slug || "").toLowerCase();
  if (/ilca-?4/.test(s)) return "ILCA 4";
  if (/ilca-?6/.test(s)) return "ILCA 6";
  if (/ilca-?7/.test(s)) return "ILCA 7";
  if (s.includes("ilca")) return null;
  if (s.includes("wingfoil") || s.includes("wing-foil")) return "WingFoil";
  if (s.includes("techno")) return "Techno 293";
  if (s.includes("29er")) return "29er";
  if (s.includes("gold")) return "Optimist Gold Fleet";
  if (s.includes("silver")) return "Optimist Silver Fleet";
  return undefined;
}

/**
 * Prize fleets for a results slug, with empty categories removed.
 * Pass `fleetName` to force one fleet (used by the event hub for board classes).
 * Returns null when there is nothing to display.
 */
export function getPrizeWinnersForRegatta(
  slug: string,
  fleetName?: string
): RegattaPrizeWinnersView | null {
  const s = String(slug || "").toLowerCase();
  const schedule = getRegattaPrizeSchedule(s);
  if (!schedule) return null;

  const resolved =
    fleetName !== undefined ? fleetName : inferPrizeFleetName(s);
  if (resolved === null) return null;

  const fleets = schedule.fleets
    .filter((f) => {
      if (!resolved) return true;
      if (f.fleetName === resolved) return true;
      const fleet = f.fleetName.toLowerCase();
      const want = resolved.toLowerCase();
      return fleet.startsWith("techno") && want.startsWith("techno");
    })
    .map((f) => ({
      ...f,
      categories: f.categories.filter((c) => c.winners.length > 0),
    }))
    .filter((f) => f.categories.length > 0);

  if (fleets.length === 0) return null;
  return { schedule, fleets };
}
