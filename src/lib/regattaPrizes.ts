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
    "Weekend 1 (25-26 Jul): Optimist Silver (5 races scheduled, max 3/day), Boards (Techno/iQFOiL/WingFoil - 7 races scheduled, max 5/day), & Open Water Festival Passage Race (25 Jul 1300h). Weekend 2 (1-2 Aug): Optimist Gold, ILCA (4, 6, 7), 29er (6 races scheduled, max 4/day).",
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
              prizeTitle: "T-1st",
              sailorName: "Goh, Ian",
              gender: "M",
              birthYear: 2009,
              schoolName: "Raffles Institution / ACS(I)",
              notes: "T-1st in Pesta Sukan scoring (43 pts)",
            },
            {
              rank: 1,
              prizeTitle: "T-1st",
              sailorName: "Peck, Caleb",
              gender: "M",
              birthYear: 2011,
              notes: "T-1st in Pesta Sukan scoring",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Cao, Lucas Zhihong",
              gender: "M",
              birthYear: 2011,
              notes: "2nd overall",
            },
            {
              rank: 3,
              prizeTitle: "T-3rd",
              sailorName: "Wong, Zachary Weikai",
              gender: "M",
              birthYear: 2010,
              notes: "T-3rd overall",
            },
            {
              rank: 3,
              prizeTitle: "T-3rd",
              sailorName: "Lim, Yuk Jun",
              gender: "M",
              birthYear: 2010,
              notes: "T-3rd overall",
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
              sailorName: "Li, Lyric Yuxuan",
              gender: "F",
              birthYear: 2012,
              notes: "4th overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Tew, Mika",
              gender: "F",
              birthYear: 2010,
              notes: "5th overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Chang, Jemima",
              gender: "F",
              birthYear: 2010,
              notes: "9th overall",
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
              sailorName: "Kong, Charles Shing Chak",
              gender: "M",
              birthYear: 2014,
              notes: "8th overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd (13&U)",
              sailorName: "Lin, Shin Chen Rui",
              gender: "M",
              birthYear: 2013,
              notes: "22nd overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd (13&U)",
              sailorName: "Cao, Caleb Zhixuan",
              gender: "M",
              birthYear: 2014,
              notes: "23rd overall",
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
