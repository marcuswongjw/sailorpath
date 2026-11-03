import type { RegattaPrizeSchedule } from "./regattaPrizes";

/** NoR 13.1, page 3. Placings reviewed against the 1 November official results.
 * Optimist final-fleet ranks are not comparable by net points: Gold precedes Silver.
 * Explicit winners keep combined age/sex categories out of generic per-sheet inference.
 */
export const EASTERN_SEABOARD_2026_PRIZES: RegattaPrizeSchedule = {
  "regattaSlug": "eastern-seaboard-regatta-2026",
  "regattaName": "18th Eastern Seaboard Regatta 2026",
  "year": 2026,
  "datesText": "28 October–1 November 2026",
  "venue": "Royal Varuna Yacht Club, Pattaya, Thailand",
  "organizer": "Royal Varuna Yacht Club",
  "noticeOfRaceUrl": "https://www.racingrulesofsailing.org/documents/198658",
  "officialNoticeBoardUrl": "https://www.racingrulesofsailing.org/documents/15166/event",
  "websiteUrl": "https://www.varuna.org/",
  "registrationUrl": "",
  "entryFees": {
    "singleHanded": 0,
    "doubleHanded": 0,
    "earlyBirdDeadline": "",
    "finalDeadline": "",
    "lateFee": 0
  },
  "scheduleSummary": "Registration 28 October; racing 29 October–1 November 2026.",
  "scoringRules": "Appendix A; eight completed races. ILCA: one discard. Optimist: five qualifying and three final races with two discards.",
  "sourceUrl": "https://www.racingrulesofsailing.org/documents/198658",
  "sourceKind": "notice-of-race",
  "sourceDescription": "NoR 13.1 prize categories. Placings derived from the organiser’s published results, which are marked provisional. Optimist awards span Gold and Silver, with Gold placed before Silver.",
  "recordedPodiumPolicy": "official-categories-only",
  "fleets": [
    {
      "fleetName": "Optimist",
      "boatClass": "Optimist",
      "classWide": true,
      "categories": [
        {
          "categoryName": "Overall",
          "prizesAwarded": "1st to 10th",
          "sourceUrl": "https://www.racingrulesofsailing.org/documents/198658",
          "sourceKind": "notice-of-race",
          "eligibilityNotes": "Across Gold and Silver; Gold fleet precedes Silver.",
          "winners": [
            {
              "rank": 1,
              "prizeTitle": "1st Overall",
              "sailorName": "Rachata Sadtrakulwatanna",
              "sailorHandle": "rachata-sadtrakulwatanna-823ho68",
              "sailNumber": "THA1963",
              "gender": "M",
              "nationality": "THA",
              "birthYear": 2011,
              "notes": "Gold fleet rank 1; 13 points nett. Official source name: RACHATA SADTRAKULWATTANA."
            },
            {
              "rank": 2,
              "prizeTitle": "2nd Overall",
              "sailorName": "Ashlyn Tham Yan Lin",
              "sailorHandle": "tham-yan-lin-ashlyn",
              "sailNumber": "100",
              "gender": "F",
              "nationality": "SGP",
              "birthYear": 2012,
              "notes": "Gold fleet rank 2; 16 points nett. Official source name: ASHLYN THAM."
            },
            {
              "rank": 3,
              "prizeTitle": "3rd Overall",
              "sailorName": "Suthinan Nakpasom",
              "sailorHandle": "suthinan-nakpasom-n1ztaan",
              "sailNumber": "THA1523",
              "gender": "M",
              "nationality": "THA",
              "birthYear": 2012,
              "notes": "Gold fleet rank 3; 19 points nett. Official source name: SUTHINAN NAKPASOM."
            },
            {
              "rank": 4,
              "prizeTitle": "4th Overall",
              "sailorName": "Sorawit Naksuk",
              "sailorHandle": "sorawit-naksuk-812d4t4",
              "sailNumber": "THA1493",
              "gender": "M",
              "nationality": "THA",
              "notes": "Gold fleet rank 4; 21 points nett. Official source name: SORAWIT NAKSUK. Source birth year 2014 conflicts with existing 2012; age was not used for this overall award."
            },
            {
              "rank": 5,
              "prizeTitle": "5th Overall",
              "sailorName": "Thun Pyae Zan",
              "sailorHandle": "thun-pyae-zan-mya372",
              "sailNumber": "MYA 1",
              "gender": "M",
              "nationality": "MYA",
              "birthYear": 2011,
              "notes": "Gold fleet rank 5; 28 points nett. Official source name: THUN PYAE ZAN."
            },
            {
              "rank": 6,
              "prizeTitle": "6th Overall",
              "sailorName": "Anantachai Tiathongchai",
              "sailorHandle": "anantachai-tiathongchai-onaqh0t",
              "sailNumber": "THA1494",
              "gender": "M",
              "nationality": "THA",
              "birthYear": 2015,
              "notes": "Gold fleet rank 6; 37 points nett. Official source name: ANANTACHAI TIATHONGCHAI."
            },
            {
              "rank": 7,
              "prizeTitle": "7th Overall",
              "sailorName": "Sitt May Chit Po",
              "sailorHandle": "asian-mya-sitt-may-c-de19ca",
              "sailNumber": "MYA 2",
              "gender": "F",
              "nationality": "MYA",
              "birthYear": 2013,
              "notes": "Gold fleet rank 7; 38 points nett. Official source name: SITT MAY CHIT PO."
            },
            {
              "rank": 8,
              "prizeTitle": "8th Overall",
              "sailorName": "Thawaree Raksapun",
              "sailorHandle": "thawaree-raksapun-sd0d5wz",
              "sailNumber": "THA 1459",
              "gender": "F",
              "nationality": "THA",
              "birthYear": 2013,
              "notes": "Gold fleet rank 8; 39 points nett. Official source name: THAWAREE RAKSAPUN."
            },
            {
              "rank": 9,
              "prizeTitle": "9th Overall",
              "sailorName": "Chananchai Tiathongchai",
              "sailorHandle": "chananchai-tiathongchai-e3x85l3",
              "sailNumber": "THA1991",
              "gender": "M",
              "nationality": "THA",
              "birthYear": 2015,
              "notes": "Gold fleet rank 9; 40 points nett. Official source name: CHANANCHAI TIATHONGCHAI."
            },
            {
              "rank": 10,
              "prizeTitle": "10th Overall",
              "sailorName": "Amy Luo",
              "sailorHandle": "amy-luo-fkjubc8",
              "sailNumber": "194",
              "gender": "F",
              "nationality": "HKG",
              "birthYear": 2013,
              "notes": "Gold fleet rank 10; 40 points nett. Official source name: AMY LUO."
            }
          ]
        },
        {
          "categoryName": "Female",
          "prizesAwarded": "1st to 3rd",
          "sourceUrl": "https://www.racingrulesofsailing.org/documents/198658",
          "sourceKind": "notice-of-race",
          "eligibilityNotes": "Across Gold and Silver; Gold fleet precedes Silver.",
          "winners": [
            {
              "rank": 1,
              "prizeTitle": "1st Female",
              "sailorName": "Ashlyn Tham Yan Lin",
              "sailorHandle": "tham-yan-lin-ashlyn",
              "sailNumber": "100",
              "gender": "F",
              "nationality": "SGP",
              "birthYear": 2012,
              "notes": "Gold fleet rank 2; 16 points nett. Official source name: ASHLYN THAM."
            },
            {
              "rank": 2,
              "prizeTitle": "2nd Female",
              "sailorName": "Sitt May Chit Po",
              "sailorHandle": "asian-mya-sitt-may-c-de19ca",
              "sailNumber": "MYA 2",
              "gender": "F",
              "nationality": "MYA",
              "birthYear": 2013,
              "notes": "Gold fleet rank 7; 38 points nett. Official source name: SITT MAY CHIT PO."
            },
            {
              "rank": 3,
              "prizeTitle": "3rd Female",
              "sailorName": "Thawaree Raksapun",
              "sailorHandle": "thawaree-raksapun-sd0d5wz",
              "sailNumber": "THA 1459",
              "gender": "F",
              "nationality": "THA",
              "birthYear": 2013,
              "notes": "Gold fleet rank 8; 39 points nett. Official source name: THAWAREE RAKSAPUN."
            }
          ]
        },
        {
          "categoryName": "U12 Male (born 2015 or later)",
          "prizesAwarded": "1st to 3rd",
          "sourceUrl": "https://www.racingrulesofsailing.org/documents/198658",
          "sourceKind": "notice-of-race",
          "eligibilityNotes": "Across Gold and Silver; Gold fleet precedes Silver.",
          "winners": [
            {
              "rank": 1,
              "prizeTitle": "1st U12 Male",
              "sailorName": "Anantachai Tiathongchai",
              "sailorHandle": "anantachai-tiathongchai-onaqh0t",
              "sailNumber": "THA1494",
              "gender": "M",
              "nationality": "THA",
              "birthYear": 2015,
              "notes": "Gold fleet rank 6; 37 points nett. Official source name: ANANTACHAI TIATHONGCHAI."
            },
            {
              "rank": 2,
              "prizeTitle": "2nd U12 Male",
              "sailorName": "Chananchai Tiathongchai",
              "sailorHandle": "chananchai-tiathongchai-e3x85l3",
              "sailNumber": "THA1991",
              "gender": "M",
              "nationality": "THA",
              "birthYear": 2015,
              "notes": "Gold fleet rank 9; 40 points nett. Official source name: CHANANCHAI TIATHONGCHAI."
            },
            {
              "rank": 3,
              "prizeTitle": "3rd U12 Male",
              "sailorName": "Harry Cooper",
              "sailorHandle": "harry-cooper-anz26-b8cbcc",
              "sailNumber": "1904",
              "gender": "M",
              "nationality": "AUS",
              "birthYear": 2015,
              "notes": "Gold fleet rank 18; 73 points nett. Official source name: HARRY COOPER."
            }
          ]
        },
        {
          "categoryName": "U12 Female (born 2015 or later)",
          "prizesAwarded": "1st to 3rd",
          "sourceUrl": "https://www.racingrulesofsailing.org/documents/198658",
          "sourceKind": "notice-of-race",
          "eligibilityNotes": "Across Gold and Silver; Gold fleet precedes Silver.",
          "winners": [
            {
              "rank": 1,
              "prizeTitle": "1st U12 Female",
              "sailorName": "Theerakan Klaysomboon",
              "sailorHandle": "theerakan-klaysomboon-fy1ms14",
              "sailNumber": "THA1935",
              "gender": "F",
              "nationality": "THA",
              "birthYear": 2015,
              "notes": "Gold fleet rank 35; 124 points nett. Official source name: THEERAKAN KLAYSOMBOON."
            },
            {
              "rank": 2,
              "prizeTitle": "2nd U12 Female",
              "sailorName": "Arunee Raksapun",
              "sailorHandle": "arunee-raksapun-u24jkub",
              "sailNumber": "THA 945",
              "gender": "F",
              "nationality": "THA",
              "birthYear": 2015,
              "notes": "Gold fleet rank 42; 145 points nett. Official source name: ARUNEE RAKSAPUN."
            },
            {
              "rank": 3,
              "prizeTitle": "3rd U12 Female",
              "sailorName": "Mikaela Hui Ting Wong",
              "sailorHandle": "mikaelawong",
              "sailNumber": "3029",
              "gender": "F",
              "nationality": "SGP",
              "birthYear": 2015,
              "notes": "Gold fleet rank 44; 152 points nett. Official source name: MIKAELA WONG HUI TING."
            }
          ]
        },
        {
          "categoryName": "U10 (born 2017 or later)",
          "prizesAwarded": "1st to 3rd",
          "sourceUrl": "https://www.racingrulesofsailing.org/documents/198658",
          "sourceKind": "notice-of-race",
          "eligibilityNotes": "Across Gold and Silver; Gold fleet precedes Silver.",
          "winners": [
            {
              "rank": 1,
              "prizeTitle": "1st U10",
              "sailorName": "Matthias Kai Lun Lee",
              "sailorHandle": "matthias-kai-lun-lee",
              "sailNumber": "3385",
              "gender": "M",
              "nationality": "SGP",
              "birthYear": 2017,
              "notes": "Gold fleet rank 56; 189 points nett. Official source name: LEE KAI LUN, MATTHIAS."
            },
            {
              "rank": 2,
              "prizeTitle": "2nd U10",
              "sailorName": "Min Myat Ponnya",
              "sailorHandle": "min-myat-ponnya-mya396",
              "sailNumber": "MYA 315",
              "gender": "M",
              "nationality": "MYA",
              "birthYear": 2017,
              "notes": "Gold fleet rank 64; 231 points nett. Official source name: MIN MYAT PONNYA."
            },
            {
              "rank": 3,
              "prizeTitle": "3rd U10",
              "sailorName": "Skyler Kang",
              "sailorHandle": "skyler-kang",
              "sailNumber": "SGP2041",
              "gender": "M",
              "nationality": "SGP",
              "birthYear": 2017,
              "notes": "Silver fleet rank 18; 186 points nett. Official source name: SKYLER KANG."
            }
          ]
        }
      ]
    },
    {
      "fleetName": "ILCA 4",
      "boatClass": "ILCA 4",
      "categories": [
        {
          "categoryName": "Male",
          "prizesAwarded": "1st to 3rd",
          "sourceUrl": "https://www.racingrulesofsailing.org/documents/198658",
          "sourceKind": "notice-of-race",
          "winners": [
            {
              "rank": 1,
              "prizeTitle": "1st Male",
              "sailorName": "Hussaluk Srinakorn",
              "sailorHandle": "hussaluk-srinakorn-2pumyyp",
              "sailNumber": "225982",
              "gender": "M",
              "nationality": "THA",
              "birthYear": 2009,
              "notes": "Class rank 1; 26 points nett. Official source name: HUSSALUK SRINAKORN."
            },
            {
              "rank": 2,
              "prizeTitle": "2nd Male",
              "sailorName": "Pee Teck Woon",
              "sailorHandle": "pee-teck-woon",
              "sailNumber": "228472",
              "gender": "M",
              "nationality": "SGP",
              "birthYear": 2011,
              "notes": "Class rank 3; 30 points nett. Official source name: PEE TECK WOON."
            },
            {
              "rank": 3,
              "prizeTitle": "3rd Male",
              "sailorName": "Ethan Lee",
              "sailorHandle": "ethan-lee",
              "sailNumber": "SGP21424",
              "gender": "M",
              "nationality": "SGP",
              "birthYear": 2011,
              "notes": "Class rank 4; 50 points nett. Official source name: ETHAN LEE."
            }
          ]
        },
        {
          "categoryName": "Female",
          "prizesAwarded": "1st to 3rd",
          "sourceUrl": "https://www.racingrulesofsailing.org/documents/198658",
          "sourceKind": "notice-of-race",
          "winners": [
            {
              "rank": 1,
              "prizeTitle": "1st Female",
              "sailorName": "Pinchanok Klaysomboon",
              "sailorHandle": "pinchanok-klaysomboon-ofynlxk",
              "sailNumber": "225985",
              "gender": "F",
              "nationality": "THA",
              "birthYear": 2010,
              "notes": "Class rank 2; 28 points nett. Official source name: PINCHANOK KLAYSOMBOON."
            },
            {
              "rank": 2,
              "prizeTitle": "2nd Female",
              "sailorName": "Jolin Zheng",
              "sailorHandle": "jolin-zheng-mdmobwq",
              "sailNumber": "209319",
              "gender": "F",
              "nationality": "HKG",
              "birthYear": 2011,
              "notes": "Class rank 12; 93 points nett. Official source name: JOLIN ZHENG."
            },
            {
              "rank": 3,
              "prizeTitle": "3rd Female",
              "sailorName": "Thanaporn Phokaew",
              "sailorHandle": "thanaporn-phokaew-2zbw4z0",
              "sailNumber": "THA 225426",
              "gender": "F",
              "nationality": "THA",
              "birthYear": 2011,
              "notes": "Class rank 13; 100 points nett. Official source name: THANAPORN PHOKAEW."
            }
          ]
        },
        {
          "categoryName": "U15 (born 2011 or later)",
          "prizesAwarded": "1st to 3rd",
          "sourceUrl": "https://www.racingrulesofsailing.org/documents/198658",
          "sourceKind": "notice-of-race",
          "eligibilityNotes": "Born in 2011 or later, as specified by NoR 13.1.",
          "winners": [
            {
              "rank": 1,
              "prizeTitle": "1st U15",
              "sailorName": "Pee Teck Woon",
              "sailorHandle": "pee-teck-woon",
              "sailNumber": "228472",
              "gender": "M",
              "nationality": "SGP",
              "birthYear": 2011,
              "notes": "Class rank 3; 30 points nett. Official source name: PEE TECK WOON."
            },
            {
              "rank": 2,
              "prizeTitle": "2nd U15",
              "sailorName": "Ethan Lee",
              "sailorHandle": "ethan-lee",
              "sailNumber": "SGP21424",
              "gender": "M",
              "nationality": "SGP",
              "birthYear": 2011,
              "notes": "Class rank 4; 50 points nett. Official source name: ETHAN LEE."
            },
            {
              "rank": 3,
              "prizeTitle": "3rd U15",
              "sailorName": "Lucas Cao Zhihong",
              "sailorHandle": "lucas-cao-zhihong",
              "sailNumber": "149",
              "gender": "M",
              "nationality": "SGP",
              "birthYear": 2011,
              "notes": "Class rank 8; 74 points nett. Official source name: LUCAS CAO."
            }
          ]
        }
      ]
    },
    {
      "fleetName": "ILCA 6",
      "boatClass": "ILCA 6",
      "categories": [
        {
          "categoryName": "Male",
          "prizesAwarded": "1st to 3rd",
          "sourceUrl": "https://www.racingrulesofsailing.org/documents/198658",
          "sourceKind": "notice-of-race",
          "winners": [
            {
              "rank": 1,
              "prizeTitle": "1st Male",
              "sailorName": "Ahmad Tsauban Bin Ramli",
              "sailorHandle": "ahmad-tsauban-bin-ramli-esr26-mas",
              "sailNumber": "215058",
              "gender": "M",
              "nationality": "MAS",
              "birthYear": 2009,
              "notes": "Class rank 3; 20 points nett. Official source name: AHMAD TSAUBAN BIN RAMLI."
            },
            {
              "rank": 2,
              "prizeTitle": "2nd Male",
              "sailorName": "Caleb Peck Rui Kai",
              "sailorHandle": "caleb-peck-rui-kai-053ej52",
              "sailNumber": "225221",
              "gender": "M",
              "nationality": "SGP",
              "birthYear": 2010,
              "notes": "Class rank 4; 32 points nett. Official source name: CALEB PECK."
            },
            {
              "rank": 3,
              "prizeTitle": "3rd Male",
              "sailorName": "Teng-Hsi Yeh",
              "sailorHandle": "teng-hsi-yeh-sr26-3a8088",
              "sailNumber": "225163",
              "gender": "M",
              "nationality": "TPE",
              "birthYear": 2010,
              "notes": "Class rank 5; 37 points nett. Official source name: YEH TENG HSI."
            }
          ]
        },
        {
          "categoryName": "Female",
          "prizesAwarded": "1st to 3rd",
          "sourceUrl": "https://www.racingrulesofsailing.org/documents/198658",
          "sourceKind": "notice-of-race",
          "winners": [
            {
              "rank": 1,
              "prizeTitle": "1st Female",
              "sailorName": "Nur Zafrina Syuhada Binti Mohd Zailan",
              "sailorHandle": "nur-zafrina-syuhada-binti-mohd-zailan-sysc25",
              "sailNumber": "209877",
              "gender": "F",
              "nationality": "MAS",
              "birthYear": 2008,
              "notes": "Class rank 1; 13 points nett. Official source name: NUR ZAFRINA SYUHADA BINTI MOHD ZAILAN."
            },
            {
              "rank": 2,
              "prizeTitle": "2nd Female",
              "sailorName": "Gabi Oh",
              "sailorHandle": "gabi-oh-fv3x3cs",
              "sailNumber": "224717",
              "gender": "F",
              "nationality": "SGP",
              "birthYear": 2009,
              "notes": "Class rank 2; 15 points nett. Official source name: GABI OH."
            },
            {
              "rank": 3,
              "prizeTitle": "3rd Female",
              "sailorName": "Nichawan Nithithongsakul",
              "sailorHandle": "nichawan-nithithongsakul-sr26-846c6c",
              "sailNumber": "THA210290",
              "gender": "F",
              "nationality": "THA",
              "birthYear": 2008,
              "notes": "Class rank 7; 42 points nett. Official source name: NICHAWAN NITHITHONGSAKUL."
            }
          ]
        }
      ]
    }
  ]
};

export const EASTERN_SEABOARD_2026_PRIZE_SLUGS = new Set([
  "eastern-seaboard-regatta-2026",
  "eastern-seaboard-regatta-2026-optimist-gold",
  "eastern-seaboard-regatta-2026-optimist-silver",
  "eastern-seaboard-regatta-2026-ilca4",
  "eastern-seaboard-regatta-2026-ilca6",
]);
