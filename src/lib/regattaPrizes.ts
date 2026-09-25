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
  nationality?: string;
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

/** Stable key for matching a prize name to a published result name. */
export function prizeNameKey(name: string): string {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, " ")
    .trim();
}

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
// 0. SINGAPORE NATIONAL SAILING CHAMPIONSHIPS (SNSC) 2025
// ============================================================================

export const SNSC_2025_PRIZE_SCHEDULE: RegattaPrizeSchedule = {
  regattaSlug: "singapore-national-sailing-championships-2025",
  regattaName: "Singapore National Sailing Championships (SNSC) 2025",
  year: 2025,
  datesText: "6–9 September 2025",
  venue: "National Sailing Centre, Singapore (1500 East Coast Parkway, Singapore 468963)",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/11799/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/11799/event",
  websiteUrl: "https://www.sailing.org.sg/events/298131",
  registrationUrl: "https://www.sailing.org.sg/events/298131",
  entryFees: {
    singleHanded: 136,
    doubleHanded: 272,
    earlyBirdDeadline: "3 August 2025, 2359h",
    finalDeadline: "24 August 2025, 2359h",
    lateFee: 68,
  },
  scheduleSummary:
    "6–9 September 2025 at National Sailing Centre. Optimist Gold / ILCA (4, 6, 7) / 29er: 12 races scheduled (max 4/day). Optimist Silver: 10 races scheduled (max 3/day). Scoring: 10+ races = 2 discards.",
  scoringRules:
    "At least 3 races to constitute a series. 5 to 9 races: 1 discard. 10 or more races: 2 discards (RRS Appendix A).",
  fleets: [
    {
      fleetName: "Optimist Gold Fleet",
      boatClass: "Optimist",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (National Champion)",
              sailorName: "Pailin Jaroenpon",
              gender: "F",
              nationality: "THA",
              sailNumber: "1253",
              club: "YRAT",
              schoolName: "PLU TQ LUNG",
              notes: "1st overall (39 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Sean Kok Wei Kum",
              gender: "M",
              nationality: "SGP",
              sailNumber: "142",
              club: "SAFYC",
              schoolName: "ANGLO-CHINESE SCHOOL (PRIMARY)",
              notes: "2nd overall (50 pts nett), 1st Singapore boy",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Lucas Zhihong Cao",
              gender: "M",
              nationality: "SGP",
              sailNumber: "149",
              club: "SAFYC",
              schoolName: "RAFFLES INSTITUTION",
              notes: "3rd overall (53 pts nett)",
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
              sailorName: "Pailin Jaroenpon",
              gender: "F",
              nationality: "THA",
              sailNumber: "1253",
              club: "YRAT",
              schoolName: "PLU TQ LUNG",
              notes: "1st overall and 1st female",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Anya Alessia Zahedi",
              gender: "F",
              nationality: "SGP",
              sailNumber: "159",
              club: "SAFYC",
              schoolName: "METHODIST GIRLS' SCHOOL (PRIMARY)",
              notes: "5th overall (66 pts nett), 1st Singapore girl",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Desiree Yuet Chi Lee",
              gender: "F",
              nationality: "SGP",
              sailNumber: "14",
              club: "SAFYC",
              schoolName: "NANYANG PRIMARY SCHOOL",
              notes: "7th overall (73 pts nett)",
            },
          ],
        },
        {
          categoryName: "12 & Under",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (12 & Under)",
              sailorName: "Anya Alessia Zahedi",
              gender: "F",
              nationality: "SGP",
              sailNumber: "159",
              club: "SAFYC",
              schoolName: "METHODIST GIRLS' SCHOOL (PRIMARY)",
              notes: "5th overall (66 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd (12 & Under)",
              sailorName: "Cheuk Hymn Decimus Chan",
              gender: "M",
              nationality: "HKG",
              sailNumber: "192",
              club: "RHKYC",
              schoolName: "DIOCESAN BOYS' SCHOOL PRIMARY DIVISION",
              notes: "8th overall (76 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd (12 & Under)",
              sailorName: "Alyssa Li Lin Wong",
              gender: "F",
              nationality: "SGP",
              sailNumber: "150",
              club: "SAFYC",
              schoolName: "TAO NAN SCHOOL",
              notes: "14th overall (115 pts nett)",
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
              prizeTitle: "1st (Silver Fleet Champion)",
              sailorName: "Katelynn Kai En Lee",
              gender: "F",
              nationality: "SGP",
              sailNumber: "3383",
              club: "SAFYC",
              schoolName: "ST. ANTHONY'S CANOSSIAN PRIMARY SCHOOL",
              notes: "1st overall (21 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Weihan Mao",
              gender: "F",
              nationality: "SGP",
              sailNumber: "3619",
              club: "SAFYC",
              schoolName: "ST. HILDA'S PRIMARY SCHOOL",
              notes: "2nd overall (26 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Mikaela Hui Ting Wong",
              gender: "F",
              nationality: "SGP",
              sailNumber: "3029",
              club: "SAFYC",
              schoolName: "ST. HILDA'S PRIMARY SCHOOL",
              notes: "3rd overall (29 pts nett)",
            },
            {
              rank: 4,
              prizeTitle: "4th",
              sailorName: "Joshua Zhi Kai Tan",
              gender: "M",
              nationality: "SGP",
              sailNumber: "3036",
              club: "SAFYC",
              schoolName: "ANGLO-CHINESE SCHOOL (JUNIOR)",
              notes: "4th overall (29 pts nett)",
            },
            {
              rank: 5,
              prizeTitle: "5th",
              sailorName: "Boren Wang",
              gender: "M",
              nationality: "SGP",
              sailNumber: "2039",
              club: "PA",
              schoolName: "ALEXANDRA PRIMARY SCHOOL",
              notes: "5th overall (39 pts nett)",
            },
            {
              rank: 6,
              prizeTitle: "6th",
              sailorName: "Abby Yan Ying Chen",
              gender: "F",
              nationality: "SGP",
              sailNumber: "4729",
              club: "PA",
              schoolName: "CHIJ St. Nicholas Girls' School",
              notes: "6th overall (44 pts nett)",
            },
            {
              rank: 7,
              prizeTitle: "7th",
              sailorName: "William Poon",
              gender: "M",
              nationality: "INA",
              sailNumber: "3005",
              club: "SAFYC",
              schoolName: "Singapore American School",
              notes: "7th overall (57 pts nett)",
            },
            {
              rank: 8,
              prizeTitle: "8th",
              sailorName: "Ashleigh Li Ying Teh",
              gender: "F",
              nationality: "SGP",
              sailNumber: "788",
              club: "SAFYC",
              schoolName: "TAO NAN SCHOOL",
              notes: "8th overall (73 pts nett)",
            },
            {
              rank: 9,
              prizeTitle: "9th",
              sailorName: "Tan Qi",
              gender: "F",
              nationality: "SGP",
              sailNumber: "3026",
              club: "CWSS",
              schoolName: "TAO NAN SCHOOL",
              notes: "9th overall (74 pts nett)",
            },
            {
              rank: 10,
              prizeTitle: "10th",
              sailorName: "Matthias Kai Lun Lee",
              gender: "M",
              nationality: "SGP",
              sailNumber: "3385",
              club: "SAFYC",
              schoolName: "Maris Stella High School",
              notes: "10th overall (79 pts nett)",
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
              sailorName: "Katelynn Kai En Lee",
              gender: "F",
              nationality: "SGP",
              sailNumber: "3383",
              club: "SAFYC",
              notes: "1st overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Weihan Mao",
              gender: "F",
              nationality: "SGP",
              sailNumber: "3619",
              club: "SAFYC",
              notes: "2nd overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Mikaela Hui Ting Wong",
              gender: "F",
              nationality: "SGP",
              sailNumber: "3029",
              club: "SAFYC",
              notes: "3rd overall",
            },
          ],
        },
        {
          categoryName: "Age 9–10",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (Age 9–10)",
              sailorName: "Mikaela Hui Ting Wong",
              gender: "F",
              nationality: "SGP",
              sailNumber: "3029",
              club: "SAFYC",
              notes: "3rd overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd (Age 9–10)",
              sailorName: "Abby Yan Ying Chen",
              gender: "F",
              nationality: "SGP",
              sailNumber: "4729",
              club: "PA",
              notes: "6th overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd (Age 9–10)",
              sailorName: "William Poon",
              gender: "M",
              nationality: "INA",
              sailNumber: "3005",
              club: "SAFYC",
              notes: "7th overall",
            },
          ],
        },
        {
          categoryName: "8 & Under",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (8 & Under)",
              sailorName: "Matthias Kai Lun Lee",
              gender: "M",
              nationality: "SGP",
              sailNumber: "3385",
              club: "SAFYC",
              notes: "10th overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd (8 & Under)",
              sailorName: "Yan Cheng Loh",
              gender: "M",
              nationality: "SGP",
              sailNumber: "3717",
              club: "SAFYC",
              notes: "18th overall (123 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd (8 & Under)",
              sailorName: "Evan En Kai Ong",
              gender: "M",
              nationality: "SGP",
              sailNumber: "3955",
              club: "SAFYC",
              notes: "20th overall (140 pts nett)",
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
            {
              rank: 1,
              prizeTitle: "1st (National Champion)",
              sailorName: "Ian Goh",
              gender: "M",
              nationality: "SGP",
              sailNumber: "222713",
              club: "CWSS",
              schoolName: "RAFFLES INSTITUTION",
              notes: "1st overall (37 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Nigel Xu Yuan Tan",
              gender: "M",
              nationality: "SGP",
              sailNumber: "225176",
              club: "CWSS",
              schoolName: "ST. JOSEPH'S INSTITUTION",
              notes: "2nd overall (39 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Nia Zahedi",
              gender: "F",
              nationality: "SGP",
              sailNumber: "224245",
              club: "PA",
              schoolName: "RAFFLES GIRLS' SCHOOL",
              notes: "3rd overall (43 pts nett), 1st female",
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
              sailorName: "Nia Zahedi",
              gender: "F",
              nationality: "SGP",
              sailNumber: "224245",
              club: "PA",
              notes: "3rd overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Prin Subying",
              gender: "F",
              nationality: "THA",
              sailNumber: "222687",
              club: "YRAT",
              notes: "4th overall (46 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Pinchanok Klaysomboon",
              gender: "F",
              nationality: "THA",
              sailNumber: "217386",
              club: "YRAT",
              notes: "11th overall (112 pts nett)",
            },
          ],
        },
        {
          categoryName: "13 & Under",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (13 & Under)",
              sailorName: "Isaiah Chor Hong Yap",
              gender: "M",
              nationality: "SGP",
              sailNumber: "227463",
              club: "CWSS",
              schoolName: "ANGLO-CHINESE SCHOOL (INDEPENDENT)",
              notes: "23rd overall (227 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd (13 & Under)",
              sailorName: "Kate Zi Ning Yeh",
              gender: "F",
              nationality: "SGP",
              sailNumber: "222437",
              club: "CSC",
              schoolName: "PAYA LEBAR METHODIST GIRLS' SCHOOL",
              notes: "24th overall (227 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd (13 & Under)",
              sailorName: "Cory Zhi Hang Loh",
              gender: "M",
              nationality: "SGP",
              sailNumber: "226899",
              club: "CWSS",
              schoolName: "ANGLO-CHINESE SCHOOL (BARKER ROAD)",
              notes: "27th overall (244 pts nett)",
            },
          ],
        },
        {
          categoryName: "Novice",
          prizesAwarded: "1st",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Novice",
              sailorName: "Alaric Shenthil Naidu",
              gender: "M",
              nationality: "SGP",
              sailNumber: "170299",
              club: "SAFYC",
              schoolName: "ANGLO-CHINESE SCHOOL (BARKER ROAD)",
              notes: "54th overall (474 pts nett)",
            },
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
            {
              rank: 1,
              prizeTitle: "1st (National Champion)",
              sailorName: "Kenan Kee Zen Tan",
              gender: "M",
              nationality: "SGP",
              sailNumber: "1",
              club: "RVYC",
              schoolName: "ST. JOSEPH'S INSTITUTION",
              notes: "1st overall (15 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Jania Ang",
              gender: "F",
              nationality: "SGP",
              sailNumber: "222727",
              club: "PA",
              notes: "2nd overall (28 pts nett), 1st female",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Noppassorn Khunboonjan",
              gender: "F",
              nationality: "THA",
              sailNumber: "217427",
              club: "YRAT",
              notes: "3rd overall (38 pts nett), 2nd female",
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
              sailorName: "Jania Ang",
              gender: "F",
              nationality: "SGP",
              sailNumber: "222727",
              club: "PA",
              notes: "2nd overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Noppassorn Khunboonjan",
              gender: "F",
              nationality: "THA",
              sailNumber: "217427",
              club: "YRAT",
              notes: "3rd overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Keira Carlyle",
              gender: "F",
              nationality: "SGP",
              sailNumber: "225225",
              club: "SAFYC",
              notes: "4th overall (40 pts nett)",
            },
          ],
        },
        {
          categoryName: "15 & Under",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (15 & Under)",
              sailorName: "Gordon Alexander Allan",
              gender: "M",
              nationality: "SGP",
              sailNumber: "221058",
              club: "RVYC",
              schoolName: "UNITED WORLD COLLEGE OF SOUTH EAST ASIA",
              notes: "8th overall (77 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd (15 & Under)",
              sailorName: "Elizabeth Victoria Say",
              gender: "F",
              nationality: "SGP",
              sailNumber: "214873",
              club: "RVYC",
              schoolName: "METHODIST GIRLS' SCHOOL",
              notes: "15th overall (133 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd (15 & Under)",
              sailorName: "Darren Lai",
              gender: "M",
              nationality: "SGP",
              sailNumber: "222256",
              club: "RVYC",
              schoolName: "VICTORIA SCHOOL",
              notes: "16th overall (135 pts nett)",
            },
          ],
        },
        {
          categoryName: "Master",
          prizesAwarded: "1st",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Master",
              sailorName: "Justiin Ang",
              gender: "M",
              nationality: "SGP",
              sailNumber: "158031",
              club: "CWSS",
              notes: "13th overall (122 pts nett)",
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
              sailorName: "Trevor Ng",
              gender: "M",
              nationality: "SGP",
              sailNumber: "45",
              schoolName: "VICTORIA SCHOOL",
              club: "CWSS",
              notes: "1st overall (18 pts nett, 4 race wins)",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Axl Tan",
              gender: "M",
              nationality: "SGP",
              sailNumber: "82",
              schoolName: "ANGLO-CHINESE SCHOOL (BARKER ROAD)",
              club: "CWSS",
              notes: "2nd overall (18 pts nett, 3 race wins)",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Sai Patil",
              gender: "M",
              nationality: "IND",
              sailNumber: "27",
              club: "YAI",
              notes: "3rd overall (20 pts nett)",
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
              sailorName: "Priyanshi Patil",
              gender: "F",
              nationality: "IND",
              sailNumber: "1",
              club: "YAI",
              notes: "6th overall (61 pts nett). Top SGP Female: Ansley Inessa Suganda-Chin (12th)",
            },
          ],
        },
        {
          categoryName: "15 years and under (6.8m² sail and below)",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (15&U)",
              sailorName: "Udaiveer Singh Johal",
              gender: "M",
              nationality: "IND",
              sailNumber: "01",
              club: "YAI",
              notes: "4th overall (41 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd (15&U)",
              sailorName: "Mohit Mhatre",
              gender: "M",
              nationality: "IND",
              sailNumber: "16",
              club: "YAI",
              notes: "5th overall (46 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd (15&U)",
              sailorName: "Priyanshi Patil",
              gender: "F",
              nationality: "IND",
              sailNumber: "1",
              club: "YAI",
              notes: "6th overall (61 pts nett). Top SGP 15&U: Addy Armand Anuar (11th)",
            },
          ],
        },
        {
          categoryName: "17 years and under (7.8m² sail only)",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (17&U)",
              sailorName: "Trevor Ng",
              gender: "M",
              nationality: "SGP",
              sailNumber: "45",
              schoolName: "VICTORIA SCHOOL",
              club: "CWSS",
              notes: "1st overall (18 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd (17&U)",
              sailorName: "Axl Tan",
              gender: "M",
              nationality: "SGP",
              sailNumber: "82",
              schoolName: "ANGLO-CHINESE SCHOOL (BARKER ROAD)",
              club: "CWSS",
              notes: "2nd overall (18 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd (17&U)",
              sailorName: "Sai Patil",
              gender: "M",
              nationality: "IND",
              sailNumber: "27",
              club: "YAI",
              notes: "3rd overall (20 pts nett)",
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
              sailorName: "Malo Pichoir",
              gender: "M",
              nationality: "SGP",
              sailNumber: "123",
              schoolName: "TANGLIN TRUST SCHOOL",
              club: "ASSC",
              notes: "1st overall (21 pts nett, 4 race wins). Awarded per NoR 20.2 (<6 entries)",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Ker Wan Chew",
              gender: "M",
              nationality: "SGP",
              sailNumber: "14",
              club: "PA",
              notes: "2nd overall (26 pts nett, 6 race wins)",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Mason Qifeng Lau",
              gender: "M",
              nationality: "SGP",
              sailNumber: "13",
              schoolName: "TAO NAN SCHOOL",
              club: "CWSS",
              notes: "3rd overall (26 pts nett, 2 race wins)",
            },
          ],
        },
        {
          categoryName: "18 years and under",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (18&U)",
              sailorName: "Malo Pichoir",
              gender: "M",
              nationality: "SGP",
              sailNumber: "123",
              schoolName: "TANGLIN TRUST SCHOOL",
              club: "ASSC",
              notes: "1st overall (21 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd (18&U)",
              sailorName: "Mason Qifeng Lau",
              gender: "M",
              nationality: "SGP",
              sailNumber: "13",
              schoolName: "TAO NAN SCHOOL",
              club: "CWSS",
              notes: "3rd overall (26 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd (18&U)",
              sailorName: "Ange Chew",
              gender: "M",
              nationality: "SGP",
              sailNumber: "123",
              club: "ASSC",
              notes: "4th overall (37 pts nett)",
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
              sailorName: "Victoria Natasha Chew",
              gender: "F",
              nationality: "SGP",
              sailNumber: "12",
              schoolName: "METHODIST GIRLS' SCHOOL (SECONDARY)",
              club: "ASSC",
              notes: "5th overall (56 pts nett)",
            },
          ],
        },
      ],
    },
    {
      fleetName: "iQFOiL",
      boatClass: "iQFOiL",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (National Champion)",
              sailorName: "Jonas Knick",
              gender: "M",
              nationality: "SGP",
              sailNumber: "39",
              schoolName: "SCHOOL OF SCIENCE AND TECHNOLOGY",
              club: "CWSS",
              notes: "1st overall (16 pts nett, 4 race wins)",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Angyal Chew",
              gender: "F",
              nationality: "SGP",
              sailNumber: "711",
              club: "CSC",
              notes: "2nd overall (16 pts nett, 4 race wins)",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Vinay Vishwanath Kulabkar",
              gender: "M",
              nationality: "IND",
              sailNumber: "10",
              club: "YAI",
              notes: "3rd overall (34 pts nett)",
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
              sailorName: "Angyal Chew",
              gender: "F",
              nationality: "SGP",
              sailNumber: "711",
              club: "CSC",
              notes: "2nd overall (16 pts nett)",
            },
          ],
        },
        {
          categoryName: "18 years and under",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (18&U)",
              sailorName: "Jonas Knick",
              gender: "M",
              nationality: "SGP",
              sailNumber: "39",
              schoolName: "SCHOOL OF SCIENCE AND TECHNOLOGY",
              club: "CWSS",
              notes: "1st overall (16 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd (18&U)",
              sailorName: "Angyal Chew",
              gender: "F",
              nationality: "SGP",
              sailNumber: "711",
              club: "CSC",
              notes: "2nd overall (16 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd (18&U)",
              sailorName: "Vinay Vishwanath Kulabkar",
              gender: "M",
              nationality: "IND",
              sailNumber: "10",
              club: "YAI",
              notes: "3rd overall (34 pts nett)",
            },
          ],
        },
      ],
    },
  ],
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
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Alyssa Wong Li Lin", notes: "Published results. Nett 28." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Ashlyn Tham Yan Lin", notes: "Published results. Nett 37." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Rahul Rajakanth", notes: "Published results. Nett 40." },
            { rank: 4, prizeTitle: "4th", sailorName: "Nathaniel Kaiden Ng" },
            { rank: 5, prizeTitle: "5th", sailorName: "Kevin Ho Jun Yi" },
            { rank: 6, prizeTitle: "6th", sailorName: "Elijah Ong" },
            { rank: 7, prizeTitle: "7th", sailorName: "Anya Alessia Zahedi" },
            { rank: 8, prizeTitle: "8th", sailorName: "Rohan Maliah" },
            { rank: 9, prizeTitle: "9th", sailorName: "Jedd Lam Zhi Hao" },
            { rank: 10, prizeTitle: "10th", sailorName: "Darian Huang" },
          ],
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
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Muhammad Rehan Bin Mohamed Salim", notes: "Published results. Nett 21." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Moyan Han", notes: "Published results. Nett 23." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Bryan Thian Tsek Lee", notes: "Published results. Nett 25." },
            { rank: 4, prizeTitle: "4th", sailorName: "Jiaqian Wu" },
            { rank: 5, prizeTitle: "5th", sailorName: "Ryan Feiran Zheng" },
            { rank: 6, prizeTitle: "6th", sailorName: "Skyler Kang" },
            { rank: 7, prizeTitle: "7th", sailorName: "Henry Shayan Mittelhauser" },
            { rank: 8, prizeTitle: "8th", sailorName: "Jiayi Du" },
            { rank: 9, prizeTitle: "9th", sailorName: "Chiang Ziyi Adele" },
            { rank: 10, prizeTitle: "10th", sailorName: "Kiyansh Kanishk Singh" },
          ],
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
    {
      fleetName: "ILCA 6",
      boatClass: "ILCA 6",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (National Champion)",
              sailorName: "Kenan Kee Zen Tan",
              sailNumber: "221060",
              gender: "M",
              club: "Royal Varuna Yacht Club",
              notes: "Nett score: 15.0",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Keira Carlyle",
              sailNumber: "225225",
              gender: "F",
              club: "SAF Yacht Club",
              notes: "Nett score: 23.0",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Sarah Rui-En Yong",
              sailNumber: "221689",
              gender: "F",
              schoolName: "Nanyang Polytechnic",
              club: "Royal Varuna Yacht Club",
              notes: "Nett score: 29.0",
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
              sailorName: "Keira Carlyle",
              sailNumber: "225225",
              gender: "F",
              club: "SAF Yacht Club",
              notes: "2nd overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Sarah Rui-En Yong",
              sailNumber: "221689",
              gender: "F",
              schoolName: "Nanyang Polytechnic",
              club: "Royal Varuna Yacht Club",
              notes: "3rd overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Nia Zahedi",
              sailNumber: "224245",
              gender: "F",
              schoolName: "Raffles Institution",
              club: "PAssion Wave",
              notes: "5th overall",
            },
          ],
        },
        {
          categoryName: "Novice",
          prizesAwarded: "1st",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Novice",
              sailorName: "Misa Lim Laurie",
              sailNumber: "223202",
              gender: "F",
              schoolName: "Singapore American School",
              club: "Changi Sailing Club",
              notes: "6th overall",
            },
          ],
        },
        {
          categoryName: "15 & Under",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st 15&U",
              sailorName: "Misa Lim Laurie",
              sailNumber: "223202",
              gender: "F",
              schoolName: "Singapore American School",
              club: "Changi Sailing Club",
              notes: "6th overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd 15&U",
              sailorName: "Kai Lun Wong",
              sailNumber: "227462",
              gender: "M",
              schoolName: "Bowen Secondary School",
              club: "PAssion Wave",
              notes: "11th overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd 15&U",
              sailorName: "Darren Lai",
              sailNumber: "222257",
              gender: "M",
              schoolName: "St. Joseph's Institution",
              club: "Royal Varuna Yacht Club",
              notes: "13th overall",
            },
          ],
        },
      ],
    },
  ],
};

// ============================================================================
// PESTA SUKAN REGATTA 2025
// ============================================================================

export const PESTA_SUKAN_2025_PRIZE_SCHEDULE: RegattaPrizeSchedule = {
  regattaSlug: "pesta-sukan-2025",
  regattaName: "Pesta Sukan Regatta 2025",
  year: 2025,
  datesText: "2–3 August 2025",
  venue: "National Sailing Centre, Singapore (1500 East Coast Parkway, Singapore 468963)",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl:
    "https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025",
  officialNoticeBoardUrl:
    "https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025",
  websiteUrl: "https://www.sailing.org.sg/events/293985",
  registrationUrl: "https://www.sailing.org.sg/events/293985",
  entryFees: {
    singleHanded: 68,
    doubleHanded: 135,
    earlyBirdDeadline: "13 July 2025, 2359h",
    finalDeadline: "20 July 2025",
    lateFee: 34,
  },
  scheduleSummary:
    "2–3 August 2025 at National Sailing Centre. Official final results as of 4 August 2025. 3 races completed across all fleets (0 discards).",
  scoringRules:
    "1 race to constitute a series. Fewer than 4 races: all races count (0 discards per NoR 12.2a). Category awards per NoR Section 20.",
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
              prizeTitle: "1st (Champion)",
              sailorName: "Nigel Xu Yuan Tan",
              sailNumber: "225176",
              gender: "M",
              schoolName: "St. Joseph's Institution",
              club: "CWSS",
              notes: "1st overall (6 pts nett, 2 race wins)",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Nicholette Wee Wen Lee",
              sailNumber: "224620",
              gender: "F",
              schoolName: "Tanjong Katong Girls' School",
              club: "RVYC",
              notes: "2nd overall (9 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Nia Zahedi",
              sailNumber: "224245",
              gender: "F",
              schoolName: "Raffles Girls' School (Secondary)",
              club: "RM",
              notes: "3rd overall (11 pts nett)",
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
              sailorName: "Nicholette Wee Wen Lee",
              sailNumber: "224620",
              gender: "F",
              schoolName: "Tanjong Katong Girls' School",
              club: "RVYC",
              notes: "2nd overall (9 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Nia Zahedi",
              sailNumber: "224245",
              gender: "F",
              schoolName: "Raffles Girls' School (Secondary)",
              club: "RM",
              notes: "3rd overall (11 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Jemima Chang",
              sailNumber: "214636",
              gender: "F",
              schoolName: "Dunman High School",
              club: "PA",
              notes: "8th overall (35 pts nett)",
            },
          ],
        },
        {
          categoryName: "Novice",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Novice",
              sailorName: "Nigel Xu Yuan Tan",
              sailNumber: "225176",
              gender: "M",
              schoolName: "St. Joseph's Institution",
              club: "CWSS",
              notes: "1st overall (6 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd Novice",
              sailorName: "Kayden Yi Kai Tan",
              sailNumber: "197424",
              gender: "M",
              schoolName: "St. Andrew's Secondary School",
              club: "SAFYC",
              notes: "7th overall (26 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd Novice",
              sailorName: "Joash Jing En Tan",
              sailNumber: "209051",
              gender: "M",
              schoolName: "Victoria School",
              club: "ONE°15",
              notes: "10th overall (44 pts nett)",
            },
          ],
        },
        {
          categoryName: "13 & Under",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (13&U)",
              sailorName: "Isaiah Chor Hong Yap",
              sailNumber: "227463",
              gender: "M",
              schoolName: "Xinmin Secondary School",
              club: "CSC",
              notes: "15th overall (51 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd (13&U)",
              sailorName: "Caleb Zhixuan Cao",
              sailNumber: "225207",
              gender: "M",
              schoolName: "St. Hilda's Primary School",
              club: "SAFYC",
              notes: "17th overall (58 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd (13&U)",
              sailorName: "Cory Zhi Hang Loh",
              sailNumber: "226899",
              gender: "M",
              schoolName: "Admiralty Primary School",
              club: "SAFYC",
              notes: "18th overall (63 pts nett)",
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
              sailorName: "Nigel Xu Yuan Tan",
              sailNumber: "225176",
              gender: "M",
              schoolName: "St. Joseph's Institution",
              club: "CWSS",
              notes: "1st overall",
            },
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
            {
              rank: 1,
              prizeTitle: "1st (Champion)",
              sailorName: "Keira Carlyle",
              sailNumber: "225225",
              gender: "F",
              schoolName: "Nanyang Polytechnic",
              club: "SAFYC",
              notes: "1st overall (9 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Isaac Goh",
              sailNumber: "219158",
              gender: "M",
              schoolName: "Raffles Institution (Junior College)",
              club: "CSC",
              notes: "2nd overall (11 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Kenan Kee Zen Tan",
              sailNumber: "1",
              gender: "M",
              schoolName: "St. Joseph's Institution",
              club: "RVYC",
              notes: "3rd overall (13 pts nett)",
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
              sailorName: "Keira Carlyle",
              sailNumber: "225225",
              gender: "F",
              schoolName: "Nanyang Polytechnic",
              club: "SAFYC",
              notes: "1st overall (9 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Danielle Lai",
              sailNumber: "222257",
              gender: "F",
              schoolName: "Tanjong Katong Girls' School",
              club: "RVYC",
              notes: "6th overall (21 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Sarah Rui-En Yong",
              sailNumber: "18",
              gender: "F",
              schoolName: "Nanyang Polytechnic",
              club: "RVYC",
              notes: "7th overall (24 pts nett)",
            },
          ],
        },
        {
          categoryName: "15 & Under",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (15&U)",
              sailorName: "Jonathan Jian Yi Ho",
              sailNumber: "214848",
              gender: "M",
              schoolName: "Anglo-Chinese School (Independent)",
              club: "PA",
              notes: "15th overall (42 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd (15&U)",
              sailorName: "Elizabeth Victoria Say",
              sailNumber: "214873",
              gender: "F",
              schoolName: "Dunman High School",
              club: "RVYC",
              notes: "17th overall (49 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd (15&U)",
              sailorName: "John Gabriel Lim",
              sailNumber: "206799",
              gender: "M",
              schoolName: "St. Joseph's Institution",
              club: "CSC",
              notes: "20th overall (58 pts nett)",
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
              sailorName: "Kenan Kee Zen Tan",
              sailNumber: "1",
              gender: "M",
              schoolName: "St. Joseph's Institution",
              club: "RVYC",
              notes: "3rd overall",
            },
          ],
        },
        {
          categoryName: "Junior College",
          prizesAwarded: "1st",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Junior College",
              sailorName: "Isaac Goh",
              sailNumber: "219158",
              gender: "M",
              schoolName: "Raffles Institution (Junior College)",
              club: "CSC",
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
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (Champion)",
              sailorName: "Lucas Zhihong Cao",
              sailNumber: "149",
              gender: "M",
              schoolName: "Raffles Institution (Secondary)",
              club: "SAFYC",
              notes: "1st overall (10 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Sean Kok Wei Kum",
              sailNumber: "142",
              gender: "M",
              schoolName: "Anglo-Chinese School (Independent)",
              club: "SAFYC",
              notes: "2nd overall (10 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Anya Alessia Zahedi",
              sailNumber: "159",
              gender: "F",
              schoolName: "Tao Nan School",
              club: "PA",
              notes: "3rd overall (19 pts nett)",
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
              sailorName: "Anya Alessia Zahedi",
              sailNumber: "159",
              gender: "F",
              schoolName: "Tao Nan School",
              club: "PA",
              notes: "3rd overall (19 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Lyric Yuxuan Li",
              sailNumber: "728",
              gender: "F",
              schoolName: "Raffles Girls' School (Secondary)",
              club: "CSC",
              notes: "4th overall (20 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Mikaela Rae Ng",
              sailNumber: "151",
              gender: "F",
              schoolName: "Raffles Girls' School (Secondary)",
              club: "PA",
              notes: "5th overall (27 pts nett)",
            },
          ],
        },
        {
          categoryName: "12 & Under",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (12&U)",
              sailorName: "Anya Alessia Zahedi",
              sailNumber: "159",
              gender: "F",
              schoolName: "Tao Nan School",
              club: "PA",
              notes: "3rd overall (19 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd (12&U)",
              sailorName: "Ethan Zhi Ren Low",
              sailNumber: "3855",
              gender: "M",
              schoolName: "St. Hilda's Primary School",
              club: "SAFYC",
              notes: "14th overall (57 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd (12&U)",
              sailorName: "Alyssa Li Lin Wong",
              sailNumber: "150",
              gender: "F",
              schoolName: "Haig Girls' School",
              club: "SAFYC",
              notes: "17th overall (69 pts nett)",
            },
          ],
        },
        {
          categoryName: "Novice",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Novice",
              sailorName: "Yvette Yi Min Chow",
              sailNumber: "3151",
              gender: "F",
              schoolName: "Pei Hwa Presbyterian Primary School",
              club: "SAFYC",
              notes: "55th overall (194 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd Novice",
              sailorName: "Quintan Rupert Low",
              sailNumber: "4681",
              gender: "M",
              schoolName: "Anglo-Chinese School (Junior)",
              club: "SAFYC",
              notes: "58th overall (197 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd Novice",
              sailorName: "Matthew Qin Hao Chiam",
              sailNumber: "3606",
              gender: "M",
              schoolName: "Ai Tong School",
              club: "SAFYC",
              notes: "60th overall (198 pts nett)",
            },
          ],
        },
        {
          categoryName: "Primary School",
          prizesAwarded: "1st",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Primary School",
              sailorName: "Anya Alessia Zahedi",
              sailNumber: "159",
              gender: "F",
              schoolName: "Tao Nan School",
              club: "PA",
              notes: "3rd overall",
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
              sailorName: "Lucas Zhihong Cao",
              sailNumber: "149",
              gender: "M",
              schoolName: "Raffles Institution (Secondary)",
              club: "SAFYC",
              notes: "1st overall",
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
              prizeTitle: "1st (Champion)",
              sailorName: "Mikaela Hui Ting Wong",
              sailNumber: "3029",
              gender: "F",
              schoolName: "St. Hilda's Primary School",
              club: "SAFYC",
              notes: "1st overall (12 pts nett, 1 race win)",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Nigel Jiang Long Ng",
              sailNumber: "3363",
              gender: "M",
              schoolName: "Endeavour Primary School",
              club: "SAFYC",
              notes: "2nd overall (17 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Joshua Zhi Kai Tan",
              sailNumber: "3036",
              gender: "M",
              schoolName: "Anglo-Chinese School (Junior)",
              club: "SAFYC",
              notes: "3rd overall (19 pts nett)",
            },
            {
              rank: 4,
              prizeTitle: "4th",
              sailorName: "William Poon",
              sailNumber: "3005",
              gender: "M",
              schoolName: "Singapore American School",
              club: "SAFYC",
              notes: "4th overall (19 pts nett)",
            },
            {
              rank: 5,
              prizeTitle: "5th",
              sailorName: "Weihan Mao",
              sailNumber: "3619",
              gender: "F",
              schoolName: "St. Hilda's Primary School",
              club: "SAFYC",
              notes: "5th overall (20 pts nett)",
            },
            {
              rank: 6,
              prizeTitle: "6th",
              sailorName: "Abby Yan Ying Chen",
              sailNumber: "4729",
              gender: "F",
              schoolName: "CHIJ St. Nicholas Girls' School",
              club: "PA",
              notes: "6th overall (23 pts nett)",
            },
            {
              rank: 7,
              prizeTitle: "7th",
              sailorName: "Katelynn Kai En Lee",
              sailNumber: "3383",
              gender: "F",
              schoolName: "St. Anthony's Canossian Primary School",
              club: "SAFYC",
              notes: "7th overall (23 pts nett)",
            },
            {
              rank: 8,
              prizeTitle: "8th",
              sailorName: "Boren Wang",
              sailNumber: "2039",
              gender: "M",
              schoolName: "Alexandra Primary School",
              club: "PA",
              notes: "8th overall (24 pts nett, 1 race win)",
            },
            {
              rank: 9,
              prizeTitle: "9th",
              sailorName: "Lucas Jun Sheng Seow",
              sailNumber: "2047",
              gender: "M",
              schoolName: "Tao Nan School",
              club: "CWSS",
              notes: "9th overall (28 pts nett)",
            },
            {
              rank: 10,
              prizeTitle: "10th",
              sailorName: "Auwin Zhao Hong Leow",
              sailNumber: "3405",
              gender: "M",
              schoolName: "Anglo-Chinese School (Primary)",
              club: "SAFYC",
              notes: "10th overall (30 pts nett)",
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
              sailorName: "Mikaela Hui Ting Wong",
              sailNumber: "3029",
              gender: "F",
              schoolName: "St. Hilda's Primary School",
              club: "SAFYC",
              notes: "1st overall (12 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Weihan Mao",
              sailNumber: "3619",
              gender: "F",
              schoolName: "St. Hilda's Primary School",
              club: "SAFYC",
              notes: "5th overall (20 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Abby Yan Ying Chen",
              sailNumber: "4729",
              gender: "F",
              schoolName: "CHIJ St. Nicholas Girls' School",
              club: "PA",
              notes: "6th overall (23 pts nett)",
            },
          ],
        },
        {
          categoryName: "10 & Under",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (10&U)",
              sailorName: "Mikaela Hui Ting Wong",
              sailNumber: "3029",
              gender: "F",
              schoolName: "St. Hilda's Primary School",
              club: "SAFYC",
              notes: "1st overall (12 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd (10&U)",
              sailorName: "Nigel Jiang Long Ng",
              sailNumber: "3363",
              gender: "M",
              schoolName: "Endeavour Primary School",
              club: "SAFYC",
              notes: "2nd overall (17 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd (10&U)",
              sailorName: "William Poon",
              sailNumber: "3005",
              gender: "M",
              schoolName: "Singapore American School",
              club: "SAFYC",
              notes: "4th overall (19 pts nett)",
            },
          ],
        },
        {
          categoryName: "8 & Under",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st (8&U)",
              sailorName: "Matthias Kai Lun Lee",
              sailNumber: "3385",
              gender: "M",
              schoolName: "Maris Stella High School",
              club: "SAFYC",
              notes: "18th overall (47 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd (8&U)",
              sailorName: "Evan En Kai Ong",
              sailNumber: "3955",
              gender: "M",
              schoolName: "St. Hilda's Primary School",
              club: "SAFYC",
              notes: "25th overall (63 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd (8&U)",
              sailorName: "Skyler Kang",
              sailNumber: "2041",
              gender: "M",
              schoolName: "Anglo-Chinese School (Junior)",
              club: "CWSS",
              notes: "43rd overall (95 pts nett)",
            },
          ],
        },
        {
          categoryName: "Novice",
          prizesAwarded: "1st to 10th",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Novice",
              sailorName: "William Poon",
              sailNumber: "3005",
              gender: "M",
              schoolName: "Singapore American School",
              club: "SAFYC",
              notes: "4th overall (19 pts nett)",
            },
            {
              rank: 2,
              prizeTitle: "2nd Novice",
              sailorName: "Katelynn Kai En Lee",
              sailNumber: "3383",
              gender: "F",
              schoolName: "St. Anthony's Canossian Primary School",
              club: "SAFYC",
              notes: "7th overall (23 pts nett)",
            },
            {
              rank: 3,
              prizeTitle: "3rd Novice",
              sailorName: "Boren Wang",
              sailNumber: "2039",
              gender: "M",
              schoolName: "Alexandra Primary School",
              club: "PA",
              notes: "8th overall (24 pts nett)",
            },
            {
              rank: 4,
              prizeTitle: "4th Novice",
              sailorName: "Lucas Jun Sheng Seow",
              sailNumber: "2047",
              gender: "M",
              schoolName: "Tao Nan School",
              club: "CWSS",
              notes: "9th overall (28 pts nett)",
            },
            {
              rank: 5,
              prizeTitle: "5th Novice",
              sailorName: "Tan Qi",
              sailNumber: "3026",
              gender: "F",
              schoolName: "Tao Nan School",
              club: "CWSS",
              notes: "11th overall (34 pts nett)",
            },
            {
              rank: 6,
              prizeTitle: "6th Novice",
              sailorName: "Ryan Yong Jie Choo",
              sailNumber: "789",
              gender: "M",
              schoolName: "Anglo-Chinese School (Junior)",
              club: "CSC",
              notes: "16th overall (46 pts nett)",
            },
            {
              rank: 7,
              prizeTitle: "7th Novice",
              sailorName: "Yasin Yusuf Yusfianshah",
              sailNumber: "3575",
              gender: "M",
              schoolName: "St. Hilda's Primary School",
              club: "SAFYC",
              notes: "17th overall (47 pts nett)",
            },
            {
              rank: 8,
              prizeTitle: "8th Novice",
              sailorName: "Matthias Kai Lun Lee",
              sailNumber: "3385",
              gender: "M",
              schoolName: "Maris Stella High School",
              club: "SAFYC",
              notes: "18th overall (47 pts nett)",
            },
            {
              rank: 9,
              prizeTitle: "9th Novice",
              sailorName: "Ashleigh Li Ying Teh",
              sailNumber: "788",
              gender: "F",
              schoolName: "Tao Nan School",
              club: "SAFYC",
              notes: "20th overall (49 pts nett)",
            },
            {
              rank: 10,
              prizeTitle: "10th Novice",
              sailorName: "Tyler Koo",
              sailNumber: "996",
              gender: "M",
              schoolName: "Anglo-Chinese School (Junior)",
              club: "RSYC",
              notes: "22nd overall (51 pts nett)",
            },
          ],
        },
        {
          categoryName: "Primary School",
          prizesAwarded: "1st",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Primary School",
              sailorName: "Mikaela Hui Ting Wong",
              sailNumber: "3029",
              gender: "F",
              schoolName: "St. Hilda's Primary School",
              club: "SAFYC",
              notes: "1st overall",
            },
          ],
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
    {
      fleetName: "ILCA 6",
      boatClass: "ILCA 6",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st",
              sailorName: "Kenan Kee Zen Tan",
              sailNumber: "1",
              gender: "M",
              club: "Royal Varuna Yacht Club",
              notes: "Nett score: 7.0",
            },
            {
              rank: 2,
              prizeTitle: "2nd",
              sailorName: "Austin Jia Yu Yeo",
              sailNumber: "221062",
              gender: "M",
              schoolName: "Anglo-Chinese School (Independent)",
              club: "SAF Yacht Club",
              notes: "Nett score: 7.0",
            },
            {
              rank: 3,
              prizeTitle: "3rd",
              sailorName: "Keira Carlyle",
              sailNumber: "225225",
              gender: "F",
              club: "SAF Yacht Club",
              notes: "Nett score: 11.0",
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
              sailorName: "Keira Carlyle",
              sailNumber: "225225",
              gender: "F",
              club: "SAF Yacht Club",
              notes: "3rd overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd Female",
              sailorName: "Nia Zahedi",
              sailNumber: "224245",
              gender: "F",
              schoolName: "Raffles Institution",
              club: "PAssion Wave",
              notes: "4th overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd Female",
              sailorName: "Gabi Oh",
              sailNumber: "224717",
              gender: "F",
              schoolName: "Raffles Institution",
              club: "SAF Yacht Club",
              notes: "6th overall",
            },
          ],
        },
        {
          categoryName: "15 & Under",
          prizesAwarded: "1st to 3rd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st 15&U",
              sailorName: "Kai Lun Wong",
              sailNumber: "227462",
              gender: "M",
              schoolName: "Bowen Secondary School",
              club: "PAssion Wave",
              notes: "8th overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd 15&U",
              sailorName: "Darren Lai",
              sailNumber: "222257",
              gender: "M",
              schoolName: "St. Joseph's Institution",
              club: "Royal Varuna Yacht Club",
              notes: "12th overall",
            },
            {
              rank: 3,
              prizeTitle: "3rd 15&U",
              sailorName: "Tiffany Teo",
              sailNumber: "214813",
              gender: "F",
              schoolName: "Bedok South Secondary School",
              club: "PAssion Wave",
              notes: "17th overall",
            },
          ],
        },
        {
          categoryName: "Novice",
          prizesAwarded: "1st to 2nd",
          winners: [
            {
              rank: 1,
              prizeTitle: "1st Novice",
              sailorName: "Tiffany Teo",
              sailNumber: "214813",
              gender: "F",
              schoolName: "Bedok South Secondary School",
              club: "PAssion Wave",
              notes: "17th overall",
            },
            {
              rank: 2,
              prizeTitle: "2nd Novice",
              sailorName: "Bryan Chan",
              sailNumber: "197850",
              gender: "M",
              club: "SAF Yacht Club",
              notes: "20th overall",
            },
          ],
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

export const TEMASEK_2026_PRIZE_SCHEDULE: RegattaPrizeSchedule = {
  regattaSlug: "temasek-regatta-2026",
  regattaName: "Temasek Regatta 2026",
  year: 2026,
  datesText: "20–21 June 2026",
  venue: "National Sailing Centre, 1500 East Coast Parkway, Singapore 468963",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/13596/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/13596/event",
  websiteUrl: "https://www.sailing.org.sg/events/335514",
  registrationUrl: "https://www.sailing.org.sg/events/335514",
  entryFees: {
    singleHanded: 68,
    doubleHanded: 136,
    earlyBirdDeadline: "17 May 2026, 2359h",
    finalDeadline: "7 June 2026, 2359h",
    lateFee: 34,
  },
  scheduleSummary:
    "Amendment 2, 15 June 2026. Official final results: Optimist Gold 6 races, 1 discard, 77 entries (final 30 Jun 2026, 15:31). Optimist Silver 5 races, 1 discard, 61 entries (final 24 Jun 2026, 15:00). ILCA 4: 4 races, 1 discard, 42 entries. ILCA 6: 5 races, 1 discard, 11 entries. ILCA 7: 5 races, 1 discard, 7 entries (ILCA final 24 Jun 2026, 15:04–15:06).",
  scoringRules:
    "One race constitutes a series. Gold, ILCA, and 29er were scheduled for 6 races, maximum 4 per day. Silver: 5 races, maximum 3 per day. Four or more races completed: one discard.",
  fleets: [
    {
      fleetName: "Optimist Gold Fleet",
      boatClass: "Optimist",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 10th",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Elliot Goh", sailNumber: "3103", gender: "M", schoolName: "Anglo-Chinese School (Independent)", club: "SAF Yacht Club", notes: "Nett 15.0." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Jairus Xin Jie Teo", sailNumber: "4073", gender: "M", schoolName: "St. Andrew's Secondary School", club: "SAF Yacht Club", notes: "Nett 19.0." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Ethan Zhi Ren Low", sailNumber: "78", gender: "M", schoolName: "St. Hilda's Primary School", club: "SAF Yacht Club", notes: "11–12. Nett 22.0." },
            { rank: 4, prizeTitle: "4th", sailorName: "Edrei En Xu Ong", sailNumber: "3957", gender: "M", schoolName: "St. Hilda's Primary School", club: "SAF Yacht Club", notes: "11–12. Nett 41.0." },
            { rank: 5, prizeTitle: "5th", sailorName: "Elijah Ong", sailNumber: "140", gender: "M", schoolName: "Anglo-Chinese School (Independent)", club: "SAF Yacht Club" },
            { rank: 6, prizeTitle: "6th", sailorName: "Nathaniel Kaiden Ng", sailNumber: "3344", gender: "M", schoolName: "Anglo-Chinese School (Independent)", club: "SAF Yacht Club" },
            { rank: 7, prizeTitle: "7th", sailorName: "Anya Alessia Zahedi", sailNumber: "159", gender: "F" },
            { rank: 8, prizeTitle: "8th", sailorName: "Damien Huang", sailNumber: "3300", gender: "M" },
            { rank: 9, prizeTitle: "9th", sailorName: "Alyssa Li Lin Wong", sailNumber: "150", gender: "F" },
            { rank: 10, prizeTitle: "10th", sailorName: "Nicole Jing Chen Wong", sailNumber: "3006", gender: "F" },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Anya Alessia Zahedi", sailNumber: "159", gender: "F" },
            { rank: 2, prizeTitle: "2nd Female", sailorName: "Alyssa Li Lin Wong", sailNumber: "150", gender: "F" },
            { rank: 3, prizeTitle: "3rd Female", sailorName: "Nicole Jing Chen Wong", sailNumber: "3006", gender: "F" },
          ],
        },
        {
          categoryName: "Aged 11 - 12 years old (born between 2014 and 2015)",
          prizesAwarded: "1st to 5th",
          winners: [
            { rank: 1, prizeTitle: "1st (11–12)", sailorName: "Ethan Zhi Ren Low", sailNumber: "78" },
            { rank: 2, prizeTitle: "2nd (11–12)", sailorName: "Edrei En Xu Ong", sailNumber: "3957" },
            { rank: 3, prizeTitle: "3rd (11–12)", sailorName: "Nicole Jing Chen Wong", sailNumber: "3006" },
            { rank: 4, prizeTitle: "4th (11–12)", sailorName: "Kyle Jeremy Zhi Jun Soh", sailNumber: "3183" },
            { rank: 5, prizeTitle: "5th (11–12)", sailorName: "Darian Huang", sailNumber: "3700" },
          ],
        },
        {
          categoryName: "Aged 9 - 10 years old (born between 2016 and 2017)",
          prizesAwarded: "1st to 5th",
          winners: [
            { rank: 1, prizeTitle: "1st (9–10)", sailorName: "Kirsten En Ting Tan", sailNumber: "3663" },
            { rank: 2, prizeTitle: "2nd (9–10)", sailorName: "Hayley Kai En Tan", sailNumber: "700" },
            { rank: 3, prizeTitle: "3rd (9–10)", sailorName: "Meera Srihari", sailNumber: "3889" },
            { rank: 4, prizeTitle: "4th (9–10)", sailorName: "Ashleigh Li Ying Teh", sailNumber: "788" },
            { rank: 5, prizeTitle: "5th (9–10)", sailorName: "Matthias Kai Lun Lee", sailNumber: "3385" },
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
            { rank: 1, prizeTitle: "1st", sailorName: "Cyra Cama", sailNumber: "29", gender: "F", schoolName: "International French School", club: "ONE°15", notes: "Nett 13." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Arun John Behl", sailNumber: "88", gender: "M", schoolName: "Bukit Merah Secondary School", club: "Changi Sailing Club", notes: "Nett 19." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Yan Cheng Loh", sailNumber: "3717", gender: "M", schoolName: "Nan Chiau Primary School", club: "SAF Yacht Club", notes: "9–10. Nett 19." },
            { rank: 4, prizeTitle: "4th", sailorName: "Iver Zhe Xi Lee", sailNumber: "3309", gender: "M", schoolName: "Endeavour Primary School", club: "SAF Yacht Club", notes: "9–10. Nett 24." },
            { rank: 5, prizeTitle: "5th", sailorName: "Bryan Thian Tsek Lee", sailNumber: "3508", gender: "M", schoolName: "Anglo-Chinese School (Junior)", club: "SAF Yacht Club", notes: "Nett 25." },
            { rank: 6, prizeTitle: "6th", sailorName: "Hongren Wang", sailNumber: "2039", gender: "M", schoolName: "Alexandra Primary School", notes: "9–10." },
            { rank: 7, prizeTitle: "7th", sailorName: "Jiaqian Wu", sailNumber: "3424" },
            { rank: 8, prizeTitle: "8th", sailorName: "Skyler Kang", sailNumber: "2041" },
            { rank: 9, prizeTitle: "9th", sailorName: "Jerome Puah Yang Yi", sailNumber: "2037" },
            { rank: 10, prizeTitle: "10th", sailorName: "Moyan Han", sailNumber: "2042" },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Cyra Cama", sailNumber: "29", gender: "F" },
            { rank: 2, prizeTitle: "2nd Female", sailorName: "Clara Siew Ning Ng", sailNumber: "3739", gender: "F" },
            { rank: 3, prizeTitle: "3rd Female", sailorName: "Adele Ziyi Chiang", sailNumber: "3120", gender: "F" },
          ],
        },
        {
          categoryName: "8 years and under (born in 2018 or later)",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st (8 & under)", sailorName: "Jae Guan Yu Toh", sailNumber: "3311" },
            { rank: 2, prizeTitle: "2nd (8 & under)", sailorName: "Hillary Kai Hui Tan", sailNumber: "777" },
            { rank: 3, prizeTitle: "3rd (8 & under)", sailorName: "Adam Leow", sailNumber: "2063" },
          ],
        },
        {
          categoryName: "Novice",
          prizesAwarded: "1st to 10th",
          eligibilityNotes: "The final prize list names 1st to 4th. Places 5th to 10th are blank.",
          winners: [
            { rank: 1, prizeTitle: "1st Novice", sailorName: "Laurence Jun Zhe Foo", sailNumber: "3712" },
            { rank: 2, prizeTitle: "2nd Novice", sailorName: "Axel Lin", sailNumber: "720" },
            { rank: 3, prizeTitle: "3rd Novice", sailorName: "Adam Leow", sailNumber: "2063" },
            { rank: 4, prizeTitle: "4th Novice", sailorName: "Tobias Ng", sailNumber: "3469" },
          ],
        },
        {
          categoryName: "Aged 9 - 10 years old (born between 2016 and 2017)",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st (9–10)", sailorName: "Yan Cheng Loh", sailNumber: "3717" },
            { rank: 2, prizeTitle: "2nd (9–10)", sailorName: "Iver Zhe Xi Lee", sailNumber: "3309" },
            { rank: 3, prizeTitle: "3rd (9–10)", sailorName: "Hongren Wang", sailNumber: "2039" },
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
            { rank: 1, prizeTitle: "1st", sailorName: "Desiree Yuet Chi Lee", sailNumber: "226897", gender: "F", schoolName: "Tanjong Katong Girls' School", club: "Royal Varuna Yacht Club", notes: "Nett 5." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Teck Woon Pee", sailNumber: "228472", gender: "M", schoolName: "Anglo-Chinese School (Independent)", club: "PAssion Wave", notes: "Nett 6." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Jemima Chang", sailNumber: "214636", gender: "F", schoolName: "Dunman High School", club: "PAssion Wave", notes: "Nett 10." },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Desiree Yuet Chi Lee", sailNumber: "226897", gender: "F" },
            { rank: 2, prizeTitle: "2nd Female", sailorName: "Jemima Chang", sailNumber: "214636", gender: "F" },
            { rank: 3, prizeTitle: "3rd Female", sailorName: "Mika Tew", sailNumber: "227461", gender: "F" },
          ],
        },
        {
          categoryName: "13 years and under",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st (13 & under)", sailorName: "Charles Shing Chak Kong", sailNumber: "227676" },
            { rank: 2, prizeTitle: "2nd (13 & under)", sailorName: "Gerome Sim", sailNumber: "4" },
            { rank: 3, prizeTitle: "3rd (13 & under)", sailorName: "Joel Kai En Tan", sailNumber: "214849" },
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
            { rank: 1, prizeTitle: "1st", sailorName: "Keira Marie Carlyle", sailNumber: "225225", gender: "F", club: "SAF Yacht Club", notes: "Nett 5." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Kenan Kee Zen Tan", sailNumber: "1", gender: "M", club: "Royal Varuna Yacht Club", notes: "Nett 8." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Nia Zahedi", sailNumber: "224245", gender: "F", schoolName: "Raffles Institution", club: "PAssion Wave", notes: "Nett 11." },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Keira Marie Carlyle", sailNumber: "225225", gender: "F" },
            { rank: 2, prizeTitle: "2nd Female", sailorName: "Nia Zahedi", sailNumber: "224245", gender: "F" },
            { rank: 3, prizeTitle: "3rd Female", sailorName: "Sarah Rui-En Yong", sailNumber: "221689", gender: "F", schoolName: "Nanyang Polytechnic", club: "Royal Varuna Yacht Club" },
          ],
        },
      ],
    },
    {
      fleetName: "ILCA 7",
      boatClass: "ILCA 7",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Andrew Crombie", sailNumber: "224714", gender: "M", club: "Changi Sailing Club", notes: "Nett 6." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Yeo Ngak Hoe", sailNumber: "193939", gender: "M", club: "Constant Wind SeaSports", notes: "Nett 10." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Rohit Behl", sailNumber: "224860", gender: "M", club: "Changi Sailing Club", notes: "Nett 10." },
          ],
        },
      ],
    },
  ],
};

export const SAFYC_2026_PRIZE_SCHEDULE: RegattaPrizeSchedule = {
  regattaSlug: "22nd-safyc-regatta-2026",
  regattaName: "22nd SAFYC Regatta 2026",
  year: 2026,
  datesText: "14–15 February 2026 (ILCA) & 28–29 March 2026 (Optimist)",
  venue: "NSRCC Seasports Centre, 11 Changi Coast Walk, Singapore 499740",
  organizer: "SAF Yacht Club",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/13551/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/13551/event",
  websiteUrl: "https://www.safyc.org.sg",
  registrationUrl: "https://www.safyc.org.sg",
  entryFees: {
    singleHanded: 70.85,
    doubleHanded: 70.85,
    earlyBirdDeadline: "4 February 2026 (ILCA) / 22 March 2026 (Optimist)",
    finalDeadline: "4 February 2026 (ILCA) / 22 March 2026 (Optimist)",
    lateFee: 21.8,
  },
  scheduleSummary:
    "Weekend 1 (14–15 Feb): ILCA 4, ILCA 6, ILCA 7 (7 races scheduled, max 4/day). Weekend 2 (28–29 Mar): Optimist Gold, Optimist Silver (7 races scheduled, max 4/day). NSRCC Seasports Centre. Scoring: 1 race to constitute event; 4 or more races completed = 1 discard (RRS Appendix A).",
  scoringRules:
    "One race per class/fleet required to constitute event. Fewer than 4 races: no discard. 4 or more races: 1 discard (RRS Appendix A).",
  fleets: [
    {
      fleetName: "ILCA 4",
      boatClass: "ILCA 4",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 5th",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Ethan Han Wei Chia", sailNumber: "228368", gender: "M", club: "SAF Yacht Club", notes: "Nett 13.0." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Ian Goh", sailNumber: "222713", gender: "M", club: "Constant Wind", notes: "Nett 15.0." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Desiree Lee", sailNumber: "226897", gender: "F", club: "Others", notes: "Nett 26.0." },
            { rank: 4, prizeTitle: "4th", sailorName: "Zeph Wan", sailNumber: "226650", gender: "M", club: "Others", notes: "Nett 27.0." },
            { rank: 5, prizeTitle: "5th", sailorName: "Nicholette Lee", sailNumber: "224620", gender: "F", club: "Others", notes: "Nett 42.0." },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 5th",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Desiree Lee", sailNumber: "226897", gender: "F", club: "Others", notes: "Nett 26.0 (3rd overall)." },
            { rank: 2, prizeTitle: "2nd Female", sailorName: "Nicholette Lee", sailNumber: "224620", gender: "F", club: "Others", notes: "Nett 42.0 (5th overall)." },
            { rank: 3, prizeTitle: "3rd Female", sailorName: "Wai Zhi Tong", sailNumber: "225226", gender: "F", club: "SAF Yacht Club", notes: "Nett 47.0 (7th overall)." },
            { rank: 4, prizeTitle: "4th Female", sailorName: "Nia Zahedi", sailNumber: "224245", gender: "F", club: "Others", notes: "Nett 50.0 (8th overall)." },
            { rank: 5, prizeTitle: "5th Female", sailorName: "Mildred Wong Li Xuan", sailNumber: "223200", gender: "F", notes: "Nett 50.0 (9th overall)." },
          ],
        },
        {
          categoryName: "15 and Under",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st (15 & Under)", sailorName: "Desiree Lee", sailNumber: "226897", gender: "F", notes: "Nett 26.0 (3rd overall, YOB 2011)." },
            { rank: 2, prizeTitle: "2nd (15 & Under)", sailorName: "Zeph Wan", sailNumber: "226650", gender: "M", notes: "Nett 27.0 (4th overall, YOB 2011)." },
            { rank: 3, prizeTitle: "3rd (15 & Under)", sailorName: "Gabi Oh", sailNumber: "222743", gender: "F", club: "SAF Yacht Club", notes: "Nett 56.0 (10th overall, YOB 2011)." },
          ],
        },
        {
          categoryName: "13 and Under",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st (13 & Under)", sailorName: "Charles Kong", sailNumber: "227676", gender: "M", club: "Changi Sailing Club", notes: "Nett 84.0 (13th overall, YOB 2014)." },
            { rank: 2, prizeTitle: "2nd (13 & Under)", sailorName: "Caleb Cao Zhixuan", sailNumber: "225207", gender: "M", club: "SAF Yacht Club", notes: "Nett 172.0 (32nd overall, YOB 2014)." },
            { rank: 3, prizeTitle: "3rd (13 & Under)", sailorName: "Jonas Tan", sailNumber: "197840", gender: "M", club: "SAF Yacht Club", notes: "Nett 203.0 (41st overall, YOB 2013)." },
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
            { rank: 1, prizeTitle: "1st", sailorName: "Gordon Alexander Allan", sailNumber: "221058", gender: "M", club: "Others", notes: "Nett 12.0." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Leow You Shun Aurick", sailNumber: "67", gender: "M", club: "SAF Yacht Club", notes: "Nett 12.0." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Eitan Oh", sailNumber: "224717", gender: "M", club: "SAF Yacht Club", notes: "Nett 14.0." },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Keira Marie Carlyle", sailNumber: "225225", gender: "F", club: "SAF Yacht Club", notes: "Nett 26.0 (5th overall)." },
            { rank: 2, prizeTitle: "2nd Female", sailorName: "Sarah Yong", sailNumber: "18", gender: "F", club: "Others", notes: "Nett 41.0 (6th overall)." },
            { rank: 3, prizeTitle: "3rd Female", sailorName: "Elizabeth Victoria Say", sailNumber: "214873", gender: "F", club: "Others", notes: "Nett 59.0 (12th overall)." },
          ],
        },
      ],
    },
    {
      fleetName: "ILCA 7",
      boatClass: "ILCA 7",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Justiin Ang", sailNumber: "158031", gender: "M", club: "Constant Wind", notes: "Nett 5.0." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Balazs Vincze", sailNumber: "213095", gender: "M", club: "Changi Sailing Club", notes: "Nett 12.0." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Cameron Hunter", sailNumber: "197877", gender: "M", club: "Changi Sailing Club", notes: "Nett 20.0." },
          ],
        },
        {
          categoryName: "Masters and Above",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Master", sailorName: "Balazs Vincze", sailNumber: "213095", gender: "M", club: "Changi Sailing Club", notes: "Born 1986 or earlier." },
            { rank: 2, prizeTitle: "2nd Master", sailorName: "Cameron Hunter", sailNumber: "197877", gender: "M", club: "Changi Sailing Club", notes: "Born 1986 or earlier." },
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
          prizesAwarded: "1st to 5th",
          winners: [],
        },
        {
          categoryName: "12 and Under",
          prizesAwarded: "1st to 5th",
          winners: [],
        },
        {
          categoryName: "10 and Under",
          prizesAwarded: "1st to 5th",
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
          prizesAwarded: "1st to 5th",
          winners: [],
        },
        {
          categoryName: "10 and Under",
          prizesAwarded: "1st to 5th",
          winners: [],
        },
        {
          categoryName: "9 and Under",
          prizesAwarded: "1st to 5th",
          winners: [],
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
            { rank: 1, prizeTitle: "1st", sailorName: "Alyssa Wong Li Lin", sailNumber: "SGP 150", club: "SAF Yacht Club" },
            { rank: 2, prizeTitle: "2nd", sailorName: "Kevin Ho", sailNumber: "SGP 171", club: "SAF Yacht Club" },
            { rank: 3, prizeTitle: "3rd", sailorName: "Low Ethan Zhi Ren", sailNumber: "SGP 78", club: "SAF Yacht Club" },
            { rank: 4, prizeTitle: "4th", sailorName: "Ethan Lee", sailNumber: "SGP 83" },
            { rank: 5, prizeTitle: "5th", sailorName: "Teo Jairus", sailNumber: "SGP 4073", club: "SAF Yacht Club" },
            { rank: 6, prizeTitle: "6th", sailorName: "Anya Zahedi", sailNumber: "SGP 159" },
            { rank: 7, prizeTitle: "7th", sailorName: "Elliot Goh", sailNumber: "SGP 3103", club: "SAF Yacht Club" },
            { rank: 8, prizeTitle: "8th", sailorName: "Nathaniel Kaiden Ng", sailNumber: "SGP 3344" },
            { rank: 9, prizeTitle: "9th", sailorName: "Darian Huang", sailNumber: "SGP 3700" },
            { rank: 10, prizeTitle: "10th", sailorName: "Tong Xuan Ya", sailNumber: "KSA 107", club: "Constant Wind" },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 5th",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Alyssa Wong Li Lin", sailNumber: "SGP 150", club: "SAF Yacht Club" },
            { rank: 2, prizeTitle: "2nd", sailorName: "Anya Zahedi", sailNumber: "SGP 159" },
            { rank: 3, prizeTitle: "3rd", sailorName: "Lyric Li", sailNumber: "SGP 728", club: "SAF Yacht Club" },
            { rank: 4, prizeTitle: "4th", sailorName: "Ashlyn Tham", sailNumber: "SGP 100" },
            { rank: 5, prizeTitle: "5th", sailorName: "Low Xi En Jaye", sailNumber: "SGP 3279" },
          ],
        },
        {
          categoryName: "12 and Under",
          prizesAwarded: "1st to 5th",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Low Ethan Zhi Ren", sailNumber: "SGP 78", club: "SAF Yacht Club" },
            { rank: 2, prizeTitle: "2nd", sailorName: "Darian Huang", sailNumber: "SGP 3700" },
            { rank: 3, prizeTitle: "3rd", sailorName: "Kyle Jeremy Soh Zhi Jun", sailNumber: "SGP 3183", club: "SAF Yacht Club" },
            { rank: 4, prizeTitle: "4th", sailorName: "Joshua Tan Zhi Kai", sailNumber: "SGP 3036", club: "SAF Yacht Club" },
            { rank: 5, prizeTitle: "5th", sailorName: "Wong Jing Chen Nicole", sailNumber: "SGP 3006", club: "SAF Yacht Club" },
          ],
        },
        {
          categoryName: "10 and Under",
          prizesAwarded: "1st to 5th",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Tan En Ting Kirsten", sailNumber: "SGP 3663", club: "SAF Yacht Club" },
            { rank: 2, prizeTitle: "2nd", sailorName: "Chen Yan Ying (Abby)", sailNumber: "SGP 4729", club: "SAF Yacht Club" },
            { rank: 3, prizeTitle: "3rd", sailorName: "Meera Srihari", sailNumber: "SGP 3889", club: "SAF Yacht Club" },
            { rank: 4, prizeTitle: "4th", sailorName: "Isabelle Zhang", sailNumber: "SGP 2035", club: "Constant Wind" },
            { rank: 5, prizeTitle: "5th", sailorName: "Teh Ashleigh Li Ying", sailNumber: "SGP 788", club: "SAF Yacht Club" },
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
            { rank: 1, prizeTitle: "1st", sailorName: "Lee Thian Tsek Bryan", sailNumber: "SGP 3508", club: "SAF Yacht Club" },
            { rank: 2, prizeTitle: "2nd", sailorName: "Han Moyan", sailNumber: "SGP 2042", club: "Constant Wind" },
            { rank: 3, prizeTitle: "3rd", sailorName: "Changqi Tao", sailNumber: "CHN 5721", club: "Wuxi Schonst Sailing Club" },
            { rank: 4, prizeTitle: "4th", sailorName: "Jerome Puah Yang Yi", sailNumber: "SGP 2037" },
            { rank: 5, prizeTitle: "5th", sailorName: "Wu Jiaqian", sailNumber: "SGP 3424", club: "SAF Yacht Club" },
            { rank: 6, prizeTitle: "6th", sailorName: "Jade Tan", sailNumber: "SGP 3555", club: "SAF Yacht Club" },
            { rank: 7, prizeTitle: "7th", sailorName: "Chiang Ziyi Adele", sailNumber: "SGP 3120", club: "SAF Yacht Club" },
            { rank: 8, prizeTitle: "8th", sailorName: "Henry Mittelhauser", sailNumber: "SGP 2052", club: "Constant Wind" },
            { rank: 9, prizeTitle: "9th", sailorName: "Muhammad Rehan Bin Mohamed Salim", sailNumber: "SGP 2059", club: "Constant Wind" },
            { rank: 10, prizeTitle: "10th", sailorName: "Zheng Ryan Feiran", sailNumber: "SGP 2045", club: "Constant Wind" },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 5th",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Jade Tan", sailNumber: "SGP 3555", club: "SAF Yacht Club" },
            { rank: 2, prizeTitle: "2nd", sailorName: "Chiang Ziyi Adele", sailNumber: "SGP 3120", club: "SAF Yacht Club" },
            { rank: 3, prizeTitle: "3rd", sailorName: "Yiyi Wu", sailNumber: "CHN 5766", club: "Wuxi Schonst Sailing Club" },
            { rank: 4, prizeTitle: "4th", sailorName: "Seraphina Kang", sailNumber: "SGP 2040", club: "Constant Wind" },
            { rank: 5, prizeTitle: "5th", sailorName: "Wang Yahe", sailNumber: "SGP 3020", club: "SAF Yacht Club" },
          ],
        },
        {
          categoryName: "10 Years Old and Under (Born in the year 2016)",
          prizesAwarded: "1st to 5th",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Han Moyan", sailNumber: "SGP 2042", club: "Constant Wind" },
            { rank: 2, prizeTitle: "2nd", sailorName: "Wu Jiaqian", sailNumber: "SGP 3424", club: "SAF Yacht Club" },
            { rank: 3, prizeTitle: "3rd", sailorName: "Jade Tan", sailNumber: "SGP 3555", club: "SAF Yacht Club" },
            { rank: 4, prizeTitle: "4th", sailorName: "Muhammad Rehan Bin Mohamed Salim", sailNumber: "SGP 2059", club: "Constant Wind" },
            { rank: 5, prizeTitle: "5th", sailorName: "Yiyi Wu", sailNumber: "CHN 5766", club: "Wuxi Schonst Sailing Club" },
          ],
        },
        {
          categoryName: "9 Years Old (Born in the year 2017)",
          prizesAwarded: "1st to 5th",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Jerome Puah Yang Yi", sailNumber: "SGP 2037" },
            { rank: 2, prizeTitle: "2nd", sailorName: "Chiang Ziyi Adele", sailNumber: "SGP 3120", club: "SAF Yacht Club" },
            { rank: 3, prizeTitle: "3rd", sailorName: "Hongren Wang", sailNumber: "SGP 2039", club: "Constant Wind" },
            { rank: 4, prizeTitle: "4th", sailorName: "Skyler Kang", sailNumber: "SGP 2041", club: "Constant Wind" },
            { rank: 5, prizeTitle: "5th", sailorName: "Isaias Cheow", sailNumber: "SGP 3307", club: "SAF Yacht Club" },
          ],
        },
        {
          categoryName: "8 Years Old and Under (Born in 2018 or after)",
          prizesAwarded: "1st to 5th",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Tan Kai Hui Hillary", sailNumber: "SGP 777", club: "SAF Yacht Club" },
            { rank: 2, prizeTitle: "2nd", sailorName: "Ryan Jonathan Soh Zhi Jie", sailNumber: "SGP 3110", club: "SAF Yacht Club" },
          ],
        },
      ],
    },
  ],
};

export const SYSC_2026_PRIZE_SCHEDULE: RegattaPrizeSchedule = {
  regattaSlug: "sysc-2026",
  regattaName: "Singapore Youth Sailing Championships 2026",
  year: 2026,
  datesText: "14–17 March 2026",
  venue: "National Sailing Centre, Singapore",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/12142/event?name=Singapore%20Youth%20Sailing%20Championships%202026",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/12142/event?name=Singapore%20Youth%20Sailing%20Championships%202026",
  websiteUrl: "https://www.sailing.org.sg/events/303339",
  registrationUrl: "https://www.sailing.org.sg/events/303339",
  entryFees: {
    singleHanded: 136,
    doubleHanded: 272,
    earlyBirdDeadline: "8 February 2026, 2359h",
    finalDeadline: "1 March 2026, 2359h",
    lateFee: 68,
  },
  scheduleSummary:
    "14–17 March 2026 at NSC. 1 race constitutes series. 5–9 races: 1 discard; 10+ races: 2 discards.",
  scoringRules:
    "1 race to constitute series. 5 to 9 races: 1 discard. 10 or more races: 2 discards (RRS Appendix A). Categories with fewer than 6 entries present prizes to the 1st place only.",
  fleets: [
    {
      fleetName: "Optimist Gold Fleet",
      boatClass: "Optimist",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 10th",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Wenyu Cheng", sailNumber: "CHN 5051", gender: "F", club: "HHFLCSC" },
            { rank: 2, prizeTitle: "2nd", sailorName: "Ashlyn Tham", sailNumber: "SGP 4452", gender: "F", club: "PA", schoolName: "St. Hilda's Secondary School" },
            { rank: 3, prizeTitle: "3rd", sailorName: "Anya Alessia Zahedi", sailNumber: "SGP 159", gender: "F", club: "PA", schoolName: "Raffles Girls' School" },
            { rank: 4, prizeTitle: "4th", sailorName: "Youjia Xu", sailNumber: "CHN 5016", gender: "M", club: "CYA" },
            { rank: 5, prizeTitle: "5th", sailorName: "Sorawit Naksuk", sailNumber: "THA 1493", gender: "M", club: "YRAT" },
            { rank: 6, prizeTitle: "6th", sailorName: "Rachata Sadtrakulwatanna", sailNumber: "THA 1963", gender: "M", club: "YRAT" },
            { rank: 7, prizeTitle: "7th", sailorName: "Kevin Jun Yi Ho", sailNumber: "SGP 171", gender: "M", club: "SAF Yacht Club", schoolName: "Raffles Institution" },
            { rank: 8, prizeTitle: "8th", sailorName: "Nathaniel Kaiden Ng", sailNumber: "SGP 3344", gender: "M", club: "PA", schoolName: "Anglo-Chinese School (Independent)" },
            { rank: 9, prizeTitle: "9th", sailorName: "Alyssa Li Lin Wong", sailNumber: "SGP 150", gender: "F", club: "SAF Yacht Club", schoolName: "Raffles Girls' School" },
            { rank: 10, prizeTitle: "10th", sailorName: "Xuan Ya Tong", sailNumber: "SGP 175", gender: "F", club: "Constant Wind SeaSports" },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Wenyu Cheng", sailNumber: "CHN 5051", gender: "F", club: "HHFLCSC" },
            { rank: 2, prizeTitle: "2nd Female", sailorName: "Ashlyn Tham", sailNumber: "SGP 4452", gender: "F", club: "PA", schoolName: "St. Hilda's Secondary School" },
            { rank: 3, prizeTitle: "3rd Female", sailorName: "Anya Alessia Zahedi", sailNumber: "SGP 159", gender: "F", club: "PA", schoolName: "Raffles Girls' School" },
          ],
        },
        {
          categoryName: "11–12 years",
          prizesAwarded: "1st to 3rd",
          eligibilityNotes: "Born 2014–2015",
          winners: [
            { rank: 1, prizeTitle: "1st (11–12yo)", sailorName: "Ethan Zhi Ren Low", sailNumber: "SGP 78", gender: "M", club: "SAF Yacht Club", schoolName: "Tao Nan School" },
            { rank: 2, prizeTitle: "2nd (11–12yo)", sailorName: "Zhichen Jiang", sailNumber: "CHN 8101", gender: "M", club: "HHFLCSC" },
            { rank: 3, prizeTitle: "3rd (11–12yo)", sailorName: "Rachel Qian Hui Lim", sailNumber: "SGP 3197", gender: "F", club: "SAF Yacht Club", schoolName: "Nanyang Primary School" },
          ],
        },
        {
          categoryName: "9–10 years",
          prizesAwarded: "1st to 3rd",
          eligibilityNotes: "Born 2016–2017",
          winners: [
            { rank: 1, prizeTitle: "1st (9–10yo)", sailorName: "Kirsten En Ting Tan", sailNumber: "SGP 3663", gender: "F", club: "SAF Yacht Club", schoolName: "St. Hilda's Primary School" },
            { rank: 2, prizeTitle: "2nd (9–10yo)", sailorName: "Meera Srihari", sailNumber: "SGP 3889", gender: "F", club: "SAF Yacht Club", schoolName: "CHIJ (Katong) Primary" },
            { rank: 3, prizeTitle: "3rd (9–10yo)", sailorName: "Abby Yan Ying Chen", sailNumber: "SGP 4729", gender: "F", club: "SAF Yacht Club", schoolName: "CHIJ (Katong) Primary" },
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
            { rank: 1, prizeTitle: "1st", sailorName: "Yasin Yusuf Yusfianshah", sailNumber: "SGP 3575", gender: "M", club: "SAF Yacht Club", schoolName: "St. Hilda's Primary School" },
            { rank: 2, prizeTitle: "2nd", sailorName: "Su Yuan", sailNumber: "CHN 3043", gender: "F", club: "SAF Yacht Club", schoolName: "CHIJ (Katong) Primary" },
            { rank: 3, prizeTitle: "3rd", sailorName: "Shen Jie Teo", sailNumber: "SGP 3870", gender: "M", club: "SAF Yacht Club", schoolName: "Raffles Institution" },
            { rank: 4, prizeTitle: "4th", sailorName: "Cyra Cama", sailNumber: "SGP 29", gender: "F", club: "ONE°15", schoolName: "International French School (Singapore)" },
            { rank: 5, prizeTitle: "5th", sailorName: "Clara Siew Ning Ng", sailNumber: "SGP 3739", gender: "F", club: "SAF Yacht Club", schoolName: "St. Hilda's Primary School" },
            { rank: 6, prizeTitle: "6th", sailorName: "Ivor Zhuo Xi Lee", sailNumber: "SGP 3306", gender: "M", club: "SAF Yacht Club", schoolName: "Endeavour Primary School" },
            { rank: 7, prizeTitle: "7th", sailorName: "Evan En Kai Ong", sailNumber: "SGP 3955", gender: "M", club: "SAF Yacht Club", schoolName: "St. Hilda's Primary School" },
            { rank: 8, prizeTitle: "8th", sailorName: "Kai Jie Teo", sailNumber: "SGP 3550", gender: "M", club: "SAF Yacht Club", schoolName: "Tanjong Katong Primary School" },
            { rank: 9, prizeTitle: "9th", sailorName: "Hayden Zi Xuan Soh", sailNumber: "SGP 3838", gender: "M", club: "SAF Yacht Club", schoolName: "White Sands Primary School" },
            { rank: 10, prizeTitle: "10th", sailorName: "Yan Cheng Loh", sailNumber: "SGP 3717", gender: "M", club: "SAF Yacht Club", schoolName: "Nan Chiau Primary School" },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Su Yuan", sailNumber: "CHN 3043", gender: "F", club: "SAF Yacht Club", schoolName: "CHIJ (Katong) Primary" },
            { rank: 2, prizeTitle: "2nd Female", sailorName: "Cyra Cama", sailNumber: "SGP 29", gender: "F", club: "ONE°15", schoolName: "International French School (Singapore)" },
            { rank: 3, prizeTitle: "3rd Female", sailorName: "Clara Siew Ning Ng", sailNumber: "SGP 3739", gender: "F", club: "SAF Yacht Club", schoolName: "St. Hilda's Primary School" },
          ],
        },
        {
          categoryName: "9–10 years",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st (9–10yo)", sailorName: "Ivor Zhuo Xi Lee", sailNumber: "SGP 3306", gender: "M", club: "SAF Yacht Club", schoolName: "Endeavour Primary School" },
            { rank: 2, prizeTitle: "2nd (9–10yo)", sailorName: "Evan En Kai Ong", sailNumber: "SGP 3955", gender: "M", club: "SAF Yacht Club", schoolName: "St. Hilda's Primary School" },
            { rank: 3, prizeTitle: "3rd (9–10yo)", sailorName: "Kai Jie Teo", sailNumber: "SGP 3550", gender: "M", club: "SAF Yacht Club", schoolName: "Tanjong Katong Primary School" },
          ],
        },
        {
          categoryName: "8 & Under",
          prizesAwarded: "1st",
          winners: [
            { rank: 1, prizeTitle: "1st (8&U)", sailorName: "Jae Guan Yu Toh", sailNumber: "SGP 3311", gender: "M", club: "SAF Yacht Club", schoolName: "Maris Stella High School" },
          ],
        },
        {
          categoryName: "Novice",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Novice", sailorName: "Joshua Hon", sailNumber: "MAS 1", gender: "M", club: "SYC", schoolName: "Victoria School" },
            { rank: 2, prizeTitle: "2nd Novice", sailorName: "Neel Paul Behl", sailNumber: "USA 4494", gender: "M", club: "CSC", schoolName: "Zhangde Primary School" },
            { rank: 3, prizeTitle: "3rd Novice", sailorName: "Jonathan Zi Kang Tan", sailNumber: "SGP 2", gender: "M", club: "PAssion Wave", schoolName: "Queenstown Primary School" },
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
            { rank: 1, prizeTitle: "1st", sailorName: "Austin Jia Yu Yeo", sailNumber: "SGP 221062", gender: "M", club: "SAF Yacht Club" },
            { rank: 2, prizeTitle: "2nd", sailorName: "Aurick You Shun Leow", sailNumber: "SGP 214737", gender: "M", club: "SAF Yacht Club" },
            { rank: 3, prizeTitle: "3rd", sailorName: "Eitan Oh", sailNumber: "SGP 224717", gender: "M", club: "SAF Yacht Club" },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st",
          eligibilityNotes: "Top Female per NoR prize schedule (fewer than 6 female entries: 1st presented)",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Sarah Rui-En Yong", sailNumber: "SGP 18", gender: "F", club: "Royal Varuna Yacht Club" },
          ],
        },
        {
          categoryName: "15 years and under",
          prizesAwarded: "1st",
          eligibilityNotes: "Born in 2011 or later",
          winners: [
            { rank: 1, prizeTitle: "1st (15 & under)", sailorName: "Darren Lai", sailNumber: "SGP 222257", gender: "M", club: "Royal Varuna Yacht Club" },
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
            { rank: 1, prizeTitle: "1st", sailorName: "Cheryl Yong / Febe Wong", sailNumber: "2466", gender: "F", schoolName: "CHIJ St. Theresa's Convent", notes: "Nett 10.0." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Cheryl Ho / Gemma Chen", sailNumber: "2869", gender: "F", schoolName: "Raffles Girls' School", notes: "Nett 19.0." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Sean Kum / Nigel Tan", sailNumber: "2472", gender: "M", schoolName: "ACS(I) & SJI", notes: "Nett 40.0." },
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
            { rank: 1, prizeTitle: "1st", sailorName: "Avi Tan", sailNumber: "64", gender: "M", schoolName: "Anglo-Chinese School (Barker Road)", notes: "Nett 13.0." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Trevor Ng", sailNumber: "45", gender: "M", schoolName: "Victoria School", notes: "Nett 16.0." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Addy Armand Anuar", sailNumber: "143", gender: "M", schoolName: "Bedok Green Secondary School", notes: "Nett 19.0." },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Eunice Yi Ning Tan", sailNumber: "679", gender: "F", schoolName: "Dunman High School", notes: "Rank 4 overall. Nett 41.0." },
          ],
        },
      ],
    },
    {
      fleetName: "iQFOiL",
      boatClass: "iQFOiL",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 2nd",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Angyal Chew", sailNumber: "711", gender: "F", notes: "Nett 6.0." },
            { rank: 2, prizeTitle: "2nd", sailorName: "John Tze Xiang Wong", sailNumber: "2", gender: "M", schoolName: "Singapore Sports School", notes: "Nett 8.0." },
          ],
        },
      ],
    },
  ],
};

export const PULAU_UJONG_2026_PRIZE_SCHEDULE: RegattaPrizeSchedule = {
  regattaSlug: "pulau-ujong-regatta-2026",
  regattaName: "Pulau Ujong Regatta 2026",
  year: 2026,
  datesText: "21–22 February 2026",
  venue: "National Sailing Centre, Singapore",
  organizer: "Singapore Sailing Federation",
  noticeOfRaceUrl: "https://www.racingrulesofsailing.org/documents/13180/event",
  officialNoticeBoardUrl: "https://www.racingrulesofsailing.org/documents/13180/event",
  websiteUrl: "https://www.sailing.org.sg",
  registrationUrl: "https://www.sailing.org.sg",
  entryFees: {
    singleHanded: 68,
    doubleHanded: 136,
    earlyBirdDeadline: "1 February 2026, 2359h",
    finalDeadline: "15 February 2026, 2359h",
    lateFee: 34,
  },
  scheduleSummary:
    "21–22 February 2026 at NSC. Scoring: 4 or more races completed = 1 discard.",
  scoringRules:
    "1 race to constitute series. 4 or more races: 1 discard (RRS Appendix A). Categories with fewer than 6 entries present prizes to the 1st place only.",
  fleets: [
    {
      fleetName: "ILCA 6",
      boatClass: "ILCA 6",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "Kenan Kee Zen Tan", sailNumber: "1", gender: "M", club: "Royal Varuna Yacht Club", notes: "Nett 5.0." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Gordon Alexander Allan", sailNumber: "221058", gender: "M", club: "Royal Varuna Yacht Club", notes: "Nett 17.0." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Eitan Oh", sailNumber: "224717", gender: "M", club: "SAF Yacht Club", notes: "Nett 17.0." },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Sarah Rui-En Yong", sailNumber: "221689", gender: "F", club: "Royal Varuna Yacht Club", notes: "Rank 5 overall. Nett 30.0." },
            { rank: 2, prizeTitle: "2nd Female", sailorName: "Keira Carlyle", sailNumber: "25", gender: "F", club: "SAF Yacht Club", notes: "Rank 6 overall. Nett 31.0." },
            { rank: 3, prizeTitle: "3rd Female", sailorName: "Cleo En Rui Seah", sailNumber: "224379", gender: "F", club: "SAF Yacht Club", notes: "Rank 15 overall. Nett 64.0." },
          ],
        },
        {
          categoryName: "15 years and under",
          prizesAwarded: "1st",
          eligibilityNotes: "Born in 2011 or later",
          winners: [
            { rank: 1, prizeTitle: "1st (15 & under)", sailorName: "Darren Lai", sailNumber: "222257", gender: "M", club: "Royal Varuna Yacht Club", notes: "Rank 10 overall. Nett 38.0." },
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
            { rank: 1, prizeTitle: "1st", sailorName: "Sean Kum / Nigel Tan", sailNumber: "2472", gender: "M", notes: "Nett 8.0." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Cheryl Yong / Febe Wong", sailNumber: "2466", gender: "F", notes: "Nett 12.0." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Cheryl Ho / Gemma Chen", sailNumber: "2869", gender: "F", notes: "Nett 23.0." },
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
            { rank: 1, prizeTitle: "1st", sailorName: "Addy Armand Anuar", sailNumber: "143", gender: "M", notes: "Nett 6.0." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Shan Qi", sailNumber: "26", gender: "F", notes: "Nett 17.0." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Eunice Yi Ning Tan", sailNumber: "679", gender: "F", notes: "Nett 17.0." },
          ],
        },
      ],
    },
    {
      fleetName: "iQFOiL",
      boatClass: "iQFOiL",
      categories: [
        {
          categoryName: "Open",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st", sailorName: "John Tze Xiang Wong", sailNumber: "2", gender: "M", notes: "Nett 3.0." },
            { rank: 2, prizeTitle: "2nd", sailorName: "Jonas Knick", sailNumber: "39", gender: "M", notes: "Nett 6.0." },
            { rank: 3, prizeTitle: "3rd", sailorName: "Angyal Chew", sailNumber: "711", gender: "F", notes: "Nett 8.0." },
          ],
        },
      ],
    },
  ],
};

export const CSC_ILCA_29ER_2026_PRIZE_SCHEDULE: RegattaPrizeSchedule = {
  regattaSlug: "6th-csc-ilca-29er-open-2026",
  regattaName: "6th CSC ILCA & 29er Open 2026",
  year: 2026,
  datesText: "28 February & 1 March 2026",
  venue: "Changi Sailing Club, Singapore",
  organizer: "Changi Sailing Club",
  noticeOfRaceUrl: "https://www.csc.org.sg",
  officialNoticeBoardUrl: "https://www.csc.org.sg",
  websiteUrl: "https://www.csc.org.sg",
  registrationUrl: "https://www.csc.org.sg/csc-ilca-29er-championships-entry-form/",
  entryFees: {
    singleHanded: 98.1,
    doubleHanded: 196.2,
    earlyBirdDeadline: "23 January 2026, 2359h",
    finalDeadline: "15 February 2026, 1700h",
    lateFee: 21.8,
  },
  scheduleSummary:
    "28 February & 1 March 2026 at Changi Sailing Club. 7 races scheduled (max 5/day). Scoring: 5 or more races completed = 1 discard.",
  scoringRules:
    "At least 2 races to constitute a series. Fewer than 5 races: total score. 5 or more races: worst score excluded (1 discard). Section 15 Prizes: Top 3 for each category.",
  fleets: [
    {
      fleetName: "ILCA 6",
      boatClass: "ILCA 6",
      categories: [
        {
          categoryName: "Youth Mixed",
          prizesAwarded: "1st to 3rd",
          eligibilityNotes: "19 years of age and under (born 2007 or later)",
          winners: [
            { rank: 1, prizeTitle: "1st Youth Mixed", sailorName: "Ikuto Mori", sailNumber: "219178", gender: "M", notes: "Rank 1 overall. Nett 11.0." },
            { rank: 2, prizeTitle: "2nd Youth Mixed", sailorName: "Austin Yeo", sailNumber: "2", gender: "M", club: "SAF Yacht Club", notes: "Rank 2 overall. Nett 14.0." },
            { rank: 3, prizeTitle: "3rd Youth Mixed", sailorName: "Eitan Oh", sailNumber: "224717", gender: "M", club: "SAF Yacht Club", notes: "Rank 3 overall. Nett 15.0." },
          ],
        },
        {
          categoryName: "Open Mixed",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Open Mixed", sailorName: "Ikuto Mori", sailNumber: "219178", gender: "M", notes: "Rank 1 overall. Nett 11.0." },
            { rank: 2, prizeTitle: "2nd Open Mixed", sailorName: "Austin Yeo", sailNumber: "2", gender: "M", club: "SAF Yacht Club", notes: "Rank 2 overall. Nett 14.0." },
            { rank: 3, prizeTitle: "3rd Open Mixed", sailorName: "Eitan Oh", sailNumber: "224717", gender: "M", club: "SAF Yacht Club", notes: "Rank 3 overall. Nett 15.0." },
          ],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [
            { rank: 1, prizeTitle: "1st Female", sailorName: "Maia Lim Laurie", sailNumber: "223201", gender: "F", club: "Changi Sailing Club", notes: "Rank 5 overall. Nett 22.0." },
            { rank: 2, prizeTitle: "2nd Female", sailorName: "Sarah Yong", sailNumber: "221689", gender: "F", club: "Royal Varuna Yacht Club", notes: "Rank 6 overall. Nett 24.0." },
            { rank: 3, prizeTitle: "3rd Female", sailorName: "Cleo Seah En Rui", sailNumber: "224379", gender: "F", club: "SAF Yacht Club", notes: "Rank 11 overall. Nett 51.0." },
          ],
        },
      ],
    },
    {
      fleetName: "29er",
      boatClass: "29er",
      categories: [
        {
          categoryName: "Youth Mixed",
          prizesAwarded: "1st to 3rd",
          eligibilityNotes: "17 years of age and under (born 2009 or later)",
          winners: [
            { rank: 1, prizeTitle: "1st Youth Mixed", sailorName: "Cheryl Yong Heng Xi", sailNumber: "2466", gender: "F", club: "Changi Sailing Club", notes: "Rank 1 overall. Nett 9.0." },
            { rank: 2, prizeTitle: "2nd Youth Mixed", sailorName: "Sean Kum", sailNumber: "2472", gender: "M", club: "SAF Yacht Club", notes: "Rank 2 overall. Nett 10.0." },
            { rank: 3, prizeTitle: "3rd Youth Mixed", sailorName: "Cheryl Ho", sailNumber: "2869", gender: "F", club: "SAF Yacht Club", notes: "Rank 3 overall. Nett 14.0." },
          ],
        },
      ],
    },
    {
      fleetName: "ILCA 4",
      boatClass: "ILCA 4",
      categories: [
        {
          categoryName: "Youth Mixed",
          prizesAwarded: "1st to 3rd",
          eligibilityNotes: "17 years of age and under (born 2009 or later)",
          winners: [],
        },
        {
          categoryName: "Open Mixed",
          prizesAwarded: "1st to 3rd",
          winners: [],
        },
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [],
        },
        {
          categoryName: "13 Years and Under",
          prizesAwarded: "1st to 3rd",
          eligibilityNotes: "Born in 2013 and later",
          winners: [],
        },
      ],
    },
    {
      fleetName: "ILCA 7",
      boatClass: "ILCA 7",
      categories: [
        {
          categoryName: "Open Mixed",
          prizesAwarded: "1st to 3rd",
          winners: [],
        },
      ],
    },
  ],
};

export const ALL_REGATTA_PRIZE_SCHEDULES: RegattaPrizeSchedule[] = [
  CSC_ILCA_29ER_2026_PRIZE_SCHEDULE,
  PULAU_UJONG_2026_PRIZE_SCHEDULE,
  SYSC_2026_PRIZE_SCHEDULE,
  TEMASEK_2026_PRIZE_SCHEDULE,
  SAFYC_2026_PRIZE_SCHEDULE,
  SAFYC_OPTIMIST_2026_PRIZE_SCHEDULE,
  CINCAPURA_2026_PRIZE_SCHEDULE,
  PESTA_SUKAN_2026_PRIZE_SCHEDULE,
  PESTA_SUKAN_2025_PRIZE_SCHEDULE,
  SNSC_2026_PRIZE_SCHEDULE,
  SNSC_2025_PRIZE_SCHEDULE,
];

export function getRegattaPrizeSchedule(slug: string): RegattaPrizeSchedule | null {
  const s = String(slug || "").toLowerCase();
  if (
    s.includes("6th-csc-ilca-29er-open-2026") ||
    s.includes("csc-ilca-29er-championships-2026") ||
    s.includes("csc-2026-ilca-6") ||
    s.includes("csc-2026-29er") ||
    (s.includes("csc") && (s.includes("ilca") || s.includes("29er") || s.includes("open")) && s.includes("2026") && !s.includes("youth-championship"))
  ) {
    return CSC_ILCA_29ER_2026_PRIZE_SCHEDULE;
  }
  if (
    s.includes("singapore-national-sailing-championships-2025") ||
    s.includes("snsc-2025") ||
    s === "snsc-2025" ||
    (s.includes("snsc") && s.includes("sep-25"))
  ) {
    return SNSC_2025_PRIZE_SCHEDULE;
  }
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
    s.includes("pesta-sukan-2025") ||
    s.includes("pesta-sukan-regatta-2025") ||
    s === "pesta-sukan-2025" ||
    (s.includes("pesta-sukan") && (s.includes("aug-25") || s.includes("2025")))
  ) {
    return PESTA_SUKAN_2025_PRIZE_SCHEDULE;
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
  if (
    s.includes("22nd-safyc-regatta-2026") ||
    s.includes("22nd-safyc") ||
    (s.includes("safyc") && s.includes("2026") && !s.includes("championship") && !s.includes("jul"))
  ) {
    return SAFYC_2026_PRIZE_SCHEDULE;
  }
  if (s.includes("temasek-regatta") || (s.includes("temasek") && s.includes("2026"))) {
    return TEMASEK_2026_PRIZE_SCHEDULE;
  }
  if (
    s.includes("sysc-2026") ||
    s.includes("singapore-youth-sailing-championships-2026") ||
    s === "sysc-2026" ||
    (s.includes("sysc") && (s.includes("mar-26") || s.includes("2026")))
  ) {
    return SYSC_2026_PRIZE_SCHEDULE;
  }
  if (
    s.includes("pulau-ujong-regatta-2026") ||
    s.includes("pulau-ujong-2026") ||
    s === "pulau-ujong-2026" ||
    (s.includes("pulau-ujong") && (s.includes("feb-26") || s.includes("2026")))
  ) {
    return PULAU_UJONG_2026_PRIZE_SCHEDULE;
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

function fleetsForSlug(
  slug: string,
  fleetName?: string
): { schedule: RegattaPrizeSchedule; fleets: RegattaPrizeFleet[] } | null {
  const s = String(slug || "").toLowerCase();
  const schedule = getRegattaPrizeSchedule(s);
  if (!schedule) return null;
  const resolved = fleetName !== undefined ? fleetName : inferPrizeFleetName(s);
  if (resolved === null) return null;
  const fleets = schedule.fleets.filter((f) => {
    if (!resolved) return true;
    if (f.fleetName === resolved) return true;
    const fleet = f.fleetName.toLowerCase();
    const want = resolved.toLowerCase();
    return fleet.startsWith("techno") && want.startsWith("techno");
  });
  return { schedule, fleets };
}

/**
 * Prize categories for a results slug, including categories that have no
 * names yet. Those can be calculated from the published results.
 */
export function getPrizeFleetDefinitions(
  slug: string,
  fleetName?: string
): { schedule: RegattaPrizeSchedule; fleets: RegattaPrizeFleet[] } | null {
  const found = fleetsForSlug(slug, fleetName);
  if (!found || found.fleets.length === 0) return null;
  return found;
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
  const found = fleetsForSlug(slug, fleetName);
  if (!found) return null;
  const fleets = found.fleets
    .map((f) => ({
      ...f,
      categories: f.categories.filter((c) => c.winners.length > 0),
    }))
    .filter((f) => f.categories.length > 0);

  if (fleets.length === 0) return null;
  return { schedule: found.schedule, fleets };
}
