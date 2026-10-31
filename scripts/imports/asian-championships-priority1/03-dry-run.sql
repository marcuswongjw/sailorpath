-- Migration: Import Batch C — 2024 ILCA Asian Open Championship (Haikou, China)
-- 5 Championship Sheets: ILCA 4 Youth Boys U18, ILCA 4 Youth Girls U18, ILCA 6 Men, ILCA 6 Women, ILCA 7 Men
-- Source: Official Results Book PDF (25 pages, SHA-256: 4286a79171d047d3b4b18c6f2972a7e98a01beb94829edae5da88f9cd1be92ba)
-- Verification: Rendered screenshots, 100% of 249 competitor rows verified, 2,490 race scores reconciled with 0 errors.
-- Policy: Overseas continental regatta — counts_for_ranking is false for all sheets and ranking_credit is false for all participants.

begin;
set local lock_timeout = '10s';

do $import$
declare
  b jsonb := '{
  "batch": "2024-ilca-asian-championship-import-2026-10-29",
  "event": {
    "id": "e1a02024-a510-48e0-8003-000000002024",
    "slug": "2024-ilca-asian-open-championship",
    "name": "2024 ILCA Asian Open Championship",
    "startDate": "2024-12-14",
    "endDate": "2024-12-20",
    "venue": "Haikou, Hainan, China",
    "organizer": "Asian Sailing Federation (ASAF) / ILCA Asia / Chinese Yachting Association (CYA)",
    "norUrl": "https://sailwave.com/"
  },
  "sheets": [
    {
      "config": {
        "id": "b1a02024-a510-48e0-8003-000000000001",
        "slug": "2024-ilca-asian-open-championship-ilca4-boys",
        "name": "2024 ILCA Asian Open Championship (ILCA 4 Youth Boys U18)",
        "boatClass": "ILCA 4",
        "division": "Youth Boys U18",
        "gender": "M",
        "raceCount": 10,
        "discardCount": 1,
        "entryType": "individual",
        "date": "2024-12-14",
        "endDate": "2024-12-20"
      },
      "results": [
        {
          "rank": 1,
          "sourceName": "Wu HongWei",
          "name": "Wu HongWei",
          "sailOrBoardNumber": "217163",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 29,
          "nettScore": 21,
          "races": [
            {
              "raceNumber": 1,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 2,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 3,
              "score": 8,
              "code": null,
              "discarded": true,
              "raw": "(8)"
            },
            {
              "raceNumber": 4,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 5,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 6,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 7,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 8,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 9,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 10,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            }
          ],
          "sailorId": "b0dd8104-74ab-5437-9ab5-5dd70bdc7a11",
          "resultId": "f4621cf0-4a74-50bf-a242-38241ad0da5d",
          "participantId": "0283cece-4b60-5e0b-b4ac-2c7176fb0a1a",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Wu HongWei",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 217163, Nat: CHN."
        },
        {
          "rank": 2,
          "sourceName": "Tiago Cheng De Villemor Salgado",
          "name": "Tiago Cheng De Villemor Salgado",
          "sailOrBoardNumber": "222437",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 35,
          "nettScore": 25,
          "races": [
            {
              "raceNumber": 1,
              "score": 10,
              "code": null,
              "discarded": true,
              "raw": "(10)"
            },
            {
              "raceNumber": 2,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 3,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 4,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 5,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 6,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 7,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 8,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 9,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 10,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            }
          ],
          "sailorId": "ad785bc0-da18-41e2-aa35-f8d90af36153",
          "resultId": "66f04bb9-cbe0-5942-9d04-0f90780f4c5c",
          "participantId": "d24b0fa9-bef5-516f-a6a2-d5d897a3c6f9",
          "isNewProfile": false,
          "identityBasis": "Corroborated international championship athlete identity",
          "sourceNationality": "HKG",
          "officialName": "Tiago Cheng De Villemor Salgado",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 222437, Nat: HKG."
        },
        {
          "rank": 3,
          "sourceName": "Li Junda",
          "name": "Li Junda",
          "sailOrBoardNumber": "220337",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 46,
          "nettScore": 34,
          "races": [
            {
              "raceNumber": 1,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 2,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 3,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 4,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 5,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 6,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 7,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 8,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 9,
              "score": 12,
              "code": null,
              "discarded": true,
              "raw": "(12)"
            },
            {
              "raceNumber": 10,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            }
          ],
          "sailorId": "748f90c5-4811-5dfe-8d23-657eeaf91af8",
          "resultId": "44683fa5-1ac0-5687-bfa7-1c6146537cfb",
          "participantId": "74a5baba-d7a6-55bb-8f23-1d7776763d72",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Li Junda",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 220337, Nat: CHN."
        },
        {
          "rank": 4,
          "sourceName": "Ton Rattana",
          "name": "Ton Rattana",
          "sailOrBoardNumber": "222180",
          "nationality": "THA",
          "gender": "M",
          "grossScore": 66,
          "nettScore": 42,
          "races": [
            {
              "raceNumber": 1,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 2,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 3,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 4,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 5,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 6,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 7,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 8,
              "score": 24,
              "code": null,
              "discarded": true,
              "raw": "(24)"
            },
            {
              "raceNumber": 9,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 10,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            }
          ],
          "sailorId": "717ef058-5716-5951-a848-0723f95e8f28",
          "resultId": "767b5068-d0ad-5615-bb66-dd3562fddc9f",
          "participantId": "2edc40e0-407d-5f9a-aa41-c0f579bf01ae",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (THA) match in database",
          "sourceNationality": "THA",
          "officialName": "Ton Rattana",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 222180, Nat: THA."
        },
        {
          "rank": 5,
          "sourceName": "Yigeng Chen",
          "name": "Yigeng Chen",
          "sailOrBoardNumber": "200777",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 84,
          "nettScore": 43,
          "races": [
            {
              "raceNumber": 1,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 2,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 3,
              "score": 41,
              "code": "UFD",
              "discarded": true,
              "raw": "(41 UFD)"
            },
            {
              "raceNumber": 4,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 5,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 6,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 7,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 8,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 9,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 10,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            }
          ],
          "sailorId": "60031ee2-d461-5570-b96b-fa97fb80bc52",
          "resultId": "d46582a0-1782-5db2-93f4-158a71f465da",
          "participantId": "3341af53-9358-5413-8fb3-7a7c9f1614f7",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yigeng Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 200777, Nat: CHN."
        },
        {
          "rank": 6,
          "sourceName": "Pan Bo Wen",
          "name": "Pan Bo Wen",
          "sailOrBoardNumber": "211941",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 61,
          "nettScore": 44,
          "races": [
            {
              "raceNumber": 1,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 2,
              "score": 17,
              "code": null,
              "discarded": true,
              "raw": "(17)"
            },
            {
              "raceNumber": 3,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 4,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 5,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 6,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 7,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 8,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 9,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 10,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            }
          ],
          "sailorId": "660ca0bb-1d40-5077-9dac-ceb48cc11001",
          "resultId": "dbef6dfd-a911-5796-b45e-0be4e14adc78",
          "participantId": "f02a50ec-74ff-540c-8cd6-26f766cd674e",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Pan Bo Wen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 211941, Nat: CHN."
        },
        {
          "rank": 7,
          "sourceName": "Aurick You Shun Leow",
          "name": "Aurick You Shun Leow",
          "sailOrBoardNumber": "214737",
          "nationality": "SGP",
          "gender": "M",
          "grossScore": 83,
          "nettScore": 62,
          "races": [
            {
              "raceNumber": 1,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 2,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 3,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 4,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 5,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 6,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 7,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 8,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 9,
              "score": 21,
              "code": null,
              "discarded": true,
              "raw": "(21)"
            },
            {
              "raceNumber": 10,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            }
          ],
          "sailorId": "85614793-d030-483c-9ce8-57f7edcc4add",
          "resultId": "6d81bdbd-1486-536a-adf9-947b1d1630b8",
          "participantId": "46404076-ef86-5149-bced-7379e6f38d9d",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Aurick You Shun Leow",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 214737, Nat: SGP."
        },
        {
          "rank": 8,
          "sourceName": "Austin Jia Yu Yeo",
          "name": "Austin Jia Yu Yeo",
          "sailOrBoardNumber": "221062",
          "nationality": "SGP",
          "gender": "M",
          "grossScore": 98,
          "nettScore": 63,
          "races": [
            {
              "raceNumber": 1,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 2,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 3,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 4,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 5,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 6,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 7,
              "score": 35,
              "code": null,
              "discarded": true,
              "raw": "(35)"
            },
            {
              "raceNumber": 8,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 9,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 10,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            }
          ],
          "sailorId": "d7ce117b-5c64-40ea-86bd-79a7a73bb833",
          "resultId": "22a1e377-f850-519b-ba0c-359391cea8a0",
          "participantId": "a089265c-cd83-51e1-8689-4c0c660c7921",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Austin Jia Yu Yeo",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 221062, Nat: SGP."
        },
        {
          "rank": 9,
          "sourceName": "Jiahao Zhuang",
          "name": "Jiahao Zhuang",
          "sailOrBoardNumber": "218683",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 91,
          "nettScore": 67,
          "races": [
            {
              "raceNumber": 1,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 2,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 3,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 4,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 5,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 6,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 7,
              "score": 24,
              "code": null,
              "discarded": true,
              "raw": "(24)"
            },
            {
              "raceNumber": 8,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 9,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 10,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            }
          ],
          "sailorId": "96708f94-34d4-5d8c-b8be-85203b783841",
          "resultId": "92d8d4d7-5db2-55a0-956a-f4fc1d88125b",
          "participantId": "add2a90e-56e4-5f87-9469-61a30145ae0a",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Jiahao Zhuang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 218683, Nat: CHN."
        },
        {
          "rank": 10,
          "sourceName": "Haolun Xia",
          "name": "Haolun Xia",
          "sailOrBoardNumber": "223749",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 129,
          "nettScore": 98,
          "races": [
            {
              "raceNumber": 1,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 2,
              "score": 31,
              "code": null,
              "discarded": true,
              "raw": "(31)"
            },
            {
              "raceNumber": 3,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 4,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 5,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 6,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 7,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 8,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 9,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 10,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            }
          ],
          "sailorId": "b2429c70-bcf7-507f-b9cb-801df8738915",
          "resultId": "249eafb5-eaa2-5cc1-95ee-e134d1db2bc6",
          "participantId": "8dc79d22-07e6-5418-817a-4d92738ad6ba",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Haolun Xia",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 223749, Nat: CHN."
        },
        {
          "rank": 11,
          "sourceName": "Saiya Lu",
          "name": "Saiya Lu",
          "sailOrBoardNumber": "225093",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 146,
          "nettScore": 105,
          "races": [
            {
              "raceNumber": 1,
              "score": 41,
              "code": "DSQ",
              "discarded": true,
              "raw": "(41 DSQ)"
            },
            {
              "raceNumber": 2,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 3,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 4,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 5,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 6,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 7,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 8,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 9,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 10,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            }
          ],
          "sailorId": "cb704cef-5d6a-5ab1-8c50-53efdc57a5ba",
          "resultId": "aadc5cfd-3a52-5741-b10d-8275fc50f11a",
          "participantId": "f45b3281-dcb8-5e8f-9dc1-b0528081062c",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Saiya Lu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 225093, Nat: CHN."
        },
        {
          "rank": 12,
          "sourceName": "Eitan Oh",
          "name": "Eitan Oh",
          "sailOrBoardNumber": "222743",
          "nationality": "SGP",
          "gender": "M",
          "grossScore": 140,
          "nettScore": 111,
          "races": [
            {
              "raceNumber": 1,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 2,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 3,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 4,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 5,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 6,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 7,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 8,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 9,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 10,
              "score": 29,
              "code": null,
              "discarded": true,
              "raw": "(29)"
            }
          ],
          "sailorId": "922e1135-5c83-45cc-81cd-69c7b5a5ee65",
          "resultId": "2a825b0b-8389-55fd-971a-babbf724614b",
          "participantId": "1e2cf584-a7e1-554c-9c24-30ff25358213",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Eitan Oh",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 222743, Nat: SGP."
        },
        {
          "rank": 13,
          "sourceName": "Juncheng Zhou",
          "name": "Juncheng Zhou",
          "sailOrBoardNumber": "211100",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 146,
          "nettScore": 111,
          "races": [
            {
              "raceNumber": 1,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 2,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 3,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 4,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 5,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 6,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 7,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 8,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 9,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 10,
              "score": 35,
              "code": null,
              "discarded": true,
              "raw": "(35)"
            }
          ],
          "sailorId": "f591f4b2-9114-580f-b2dd-367b067094f7",
          "resultId": "7b7271a7-a97a-53a0-991c-d59cc82a4c77",
          "participantId": "efb2cd45-1458-5d0f-9eb6-03035cf369dd",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Juncheng Zhou",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 211100, Nat: CHN."
        },
        {
          "rank": 14,
          "sourceName": "Zifan Feng",
          "name": "Zifan Feng",
          "sailOrBoardNumber": "219447",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 141,
          "nettScore": 112,
          "races": [
            {
              "raceNumber": 1,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 2,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 3,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 4,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 5,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 6,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 7,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 8,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 9,
              "score": 29,
              "code": null,
              "discarded": true,
              "raw": "(29)"
            },
            {
              "raceNumber": 10,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            }
          ],
          "sailorId": "738ea9d2-24d6-58a4-b283-7519c083f4c1",
          "resultId": "03020a01-84d8-59a0-ba0e-9b9475daae35",
          "participantId": "539ed3ac-7df7-5823-98ee-d136c717bd40",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Zifan Feng",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 219447, Nat: CHN."
        },
        {
          "rank": 15,
          "sourceName": "Ian Goh",
          "name": "Ian Goh",
          "sailOrBoardNumber": "222713",
          "nationality": "SGP",
          "gender": "M",
          "grossScore": 146,
          "nettScore": 115,
          "races": [
            {
              "raceNumber": 1,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 2,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 3,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 4,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 5,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 6,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 7,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 8,
              "score": 31,
              "code": null,
              "discarded": true,
              "raw": "(31)"
            },
            {
              "raceNumber": 9,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 10,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            }
          ],
          "sailorId": "d52d284f-c0d7-4a72-b86d-45c57b963c6c",
          "resultId": "d5534d85-d358-5366-b542-78e5642873a1",
          "participantId": "98b9cb42-d8ec-59f0-b126-bf3ee873575c",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Ian Goh",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 222713, Nat: SGP."
        },
        {
          "rank": 16,
          "sourceName": "Fengziyi Fu",
          "name": "Fengziyi Fu",
          "sailOrBoardNumber": "223595",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 141,
          "nettScore": 119,
          "races": [
            {
              "raceNumber": 1,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 2,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 3,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 4,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 5,
              "score": 22,
              "code": null,
              "discarded": true,
              "raw": "(22)"
            },
            {
              "raceNumber": 6,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 7,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 8,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 9,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 10,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            }
          ],
          "sailorId": "34fe033f-bb33-58e5-aedb-a78fc1809851",
          "resultId": "c7b7cdd1-ef95-50f8-9a22-2ae762f2e34a",
          "participantId": "29035bbe-429d-552b-8cb6-621d0f23848f",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Fengziyi Fu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 223595, Nat: CHN."
        },
        {
          "rank": 17,
          "sourceName": "Wasawat Puengpradit",
          "name": "Wasawat Puengpradit",
          "sailOrBoardNumber": "219465",
          "nationality": "THA",
          "gender": "M",
          "grossScore": 151,
          "nettScore": 120,
          "races": [
            {
              "raceNumber": 1,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 2,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 3,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 4,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 5,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 6,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 7,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 8,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 9,
              "score": 31,
              "code": null,
              "discarded": true,
              "raw": "(31)"
            },
            {
              "raceNumber": 10,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            }
          ],
          "sailorId": "2c1b6cea-2f95-5e1c-8895-2599a064f4fa",
          "resultId": "8bfaae38-7b7b-562e-849d-e1889868f3fe",
          "participantId": "cfb5dedd-3369-58d1-b81c-c42408cea0a3",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (THA) match in database",
          "sourceNationality": "THA",
          "officialName": "Wasawat Puengpradit",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 219465, Nat: THA."
        },
        {
          "rank": 18,
          "sourceName": "Junhe Wang",
          "name": "Junhe Wang",
          "sailOrBoardNumber": "202759",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 150,
          "nettScore": 123,
          "races": [
            {
              "raceNumber": 1,
              "score": 27,
              "code": null,
              "discarded": true,
              "raw": "(27)"
            },
            {
              "raceNumber": 2,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 3,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 4,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 5,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 6,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 7,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 8,
              "score": 20,
              "code": "SCP30%",
              "discarded": false,
              "raw": "20 SCP30%"
            },
            {
              "raceNumber": 9,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 10,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            }
          ],
          "sailorId": "dd154de0-0ba0-5fd2-b92c-369de28b858d",
          "resultId": "aaef9519-3431-5c25-9fb1-8e20dd7fecc7",
          "participantId": "5d186261-d55a-5528-8673-3c0eb63c7e4a",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Junhe Wang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 202759, Nat: CHN."
        },
        {
          "rank": 19,
          "sourceName": "Wentai Yang",
          "name": "Wentai Yang",
          "sailOrBoardNumber": "220211",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 154,
          "nettScore": 125,
          "races": [
            {
              "raceNumber": 1,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 2,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 3,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 4,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 5,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 6,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 7,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 8,
              "score": 29,
              "code": null,
              "discarded": true,
              "raw": "(29)"
            },
            {
              "raceNumber": 9,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 10,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            }
          ],
          "sailorId": "783eafcb-6263-569c-b52c-ad504b85af62",
          "resultId": "1d693f33-a818-54a9-a463-d69c07559567",
          "participantId": "fbe3397a-4178-5b69-9528-e506bd8a37e8",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Wentai Yang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 220211, Nat: CHN."
        },
        {
          "rank": 20,
          "sourceName": "Lijian Zhong",
          "name": "Lijian Zhong",
          "sailOrBoardNumber": "214676",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 168,
          "nettScore": 127,
          "races": [
            {
              "raceNumber": 1,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 2,
              "score": 41,
              "code": "DSQ",
              "discarded": true,
              "raw": "(41 DSQ)"
            },
            {
              "raceNumber": 3,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 4,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 5,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 6,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 7,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 8,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 9,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 10,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            }
          ],
          "sailorId": "94e28ba6-4b15-5aae-a801-777e30efd6a8",
          "resultId": "73b412f7-7d39-5f21-89b9-02c932b620a3",
          "participantId": "cbf9dda3-794f-56b0-a8b7-e75a51de8fea",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (CHN) match in database",
          "sourceNationality": "CHN",
          "officialName": "Lijian Zhong",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 214676, Nat: CHN."
        },
        {
          "rank": 21,
          "sourceName": "Teng Hsi Yeh",
          "name": "Teng Hsi Yeh",
          "sailOrBoardNumber": "225163",
          "nationality": "TPE",
          "gender": "M",
          "grossScore": 160,
          "nettScore": 128,
          "races": [
            {
              "raceNumber": 1,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 2,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 3,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 4,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 5,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 6,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 7,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 8,
              "score": 32,
              "code": null,
              "discarded": true,
              "raw": "(32)"
            },
            {
              "raceNumber": 9,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 10,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            }
          ],
          "sailorId": "3a8088c8-5adb-5a4f-9dda-bf34404d55e7",
          "resultId": "307cda0a-9dfd-52fb-8f61-77e16ad99d1c",
          "participantId": "d7eeb59e-814f-55f7-9fc0-bd64ab6c4ea1",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (TPE) match in database",
          "sourceNationality": "TPE",
          "officialName": "Teng Hsi Yeh",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 225163, Nat: TPE."
        },
        {
          "rank": 22,
          "sourceName": "Iqbal Nazham Musmuliadi",
          "name": "Iqbal Nazham Musmuliadi",
          "sailOrBoardNumber": "209875",
          "nationality": "MAS",
          "gender": "M",
          "grossScore": 172,
          "nettScore": 131,
          "races": [
            {
              "raceNumber": 1,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 2,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 3,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 4,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 5,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 6,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 7,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 8,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 9,
              "score": 41,
              "code": "BFD",
              "discarded": true,
              "raw": "(41 BFD)"
            },
            {
              "raceNumber": 10,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            }
          ],
          "sailorId": "503a5d45-9f13-5b69-9ec2-14f2b04c4a6c",
          "resultId": "43e07256-53a3-5979-81cb-6c127420da4a",
          "participantId": "b560a816-4e11-5951-baa3-6fe82b22b63e",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "MAS",
          "officialName": "Iqbal Nazham Musmuliadi",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 209875, Nat: MAS."
        },
        {
          "rank": 23,
          "sourceName": "Che Liu",
          "name": "Che Liu",
          "sailOrBoardNumber": "216831",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 167,
          "nettScore": 133,
          "races": [
            {
              "raceNumber": 1,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 2,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 3,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 4,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 5,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 6,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 7,
              "score": 34,
              "code": null,
              "discarded": true,
              "raw": "(34)"
            },
            {
              "raceNumber": 8,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 9,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 10,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            }
          ],
          "sailorId": "b7214229-e97e-4c39-b342-cc4e99ff0623",
          "resultId": "8d24b8ad-f9d7-54d2-babb-e44ff92e44cf",
          "participantId": "13fbc5a4-d218-577e-be7c-d9904a071bff",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (CHN) match in database",
          "sourceNationality": "CHN",
          "officialName": "Che Liu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 216831, Nat: CHN."
        },
        {
          "rank": 24,
          "sourceName": "Darwin Hsu",
          "name": "Darwin Hsu",
          "sailOrBoardNumber": "220051",
          "nationality": "THA",
          "gender": "M",
          "grossScore": 175,
          "nettScore": 134,
          "races": [
            {
              "raceNumber": 1,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 2,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 3,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 4,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 5,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 6,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 7,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 8,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 9,
              "score": 41,
              "code": "DNC",
              "discarded": true,
              "raw": "(41 DNC)"
            },
            {
              "raceNumber": 10,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            }
          ],
          "sailorId": "eb4f93a7-324f-5bef-a6d2-38cfa887eb0d",
          "resultId": "52d5a17e-bb95-555b-ac5c-9c006ef7a106",
          "participantId": "9c78cb06-fe22-526a-bb98-d3273e153a2b",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "THA",
          "officialName": "Darwin Hsu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 220051, Nat: THA."
        },
        {
          "rank": 25,
          "sourceName": "Yaozhuang Chen",
          "name": "Yaozhuang Chen",
          "sailOrBoardNumber": "219990",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 175,
          "nettScore": 138,
          "races": [
            {
              "raceNumber": 1,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 2,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 3,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 4,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 5,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 6,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 7,
              "score": 37,
              "code": null,
              "discarded": true,
              "raw": "(37)"
            },
            {
              "raceNumber": 8,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 9,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 10,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            }
          ],
          "sailorId": "870db169-c3dd-5ccf-b16a-6fdd6204e099",
          "resultId": "8eb8df0d-d84e-576d-b375-a8802d613b92",
          "participantId": "d97bf4bd-7cd8-5e5a-8d10-6a250a42bac9",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yaozhuang Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 219990, Nat: CHN."
        },
        {
          "rank": 26,
          "sourceName": "Jiahan Chen",
          "name": "Jiahan Chen",
          "sailOrBoardNumber": "210910",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 176,
          "nettScore": 141,
          "races": [
            {
              "raceNumber": 1,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 2,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 3,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 4,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 5,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 6,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 7,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 8,
              "score": 35,
              "code": null,
              "discarded": true,
              "raw": "(35)"
            },
            {
              "raceNumber": 9,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 10,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            }
          ],
          "sailorId": "51d18c99-93e2-5bce-b886-c45036a30286",
          "resultId": "792225cf-e655-564f-bb24-3603a3ea7958",
          "participantId": "b74a631a-fe29-5a0d-9d15-e455d8633163",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Jiahan Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 210910, Nat: CHN."
        },
        {
          "rank": 27,
          "sourceName": "Xinhua Peng",
          "name": "Xinhua Peng",
          "sailOrBoardNumber": "221019",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 178,
          "nettScore": 142,
          "races": [
            {
              "raceNumber": 1,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 2,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 3,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 4,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 5,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 6,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 7,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 8,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 9,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 10,
              "score": 36,
              "code": null,
              "discarded": true,
              "raw": "(36)"
            }
          ],
          "sailorId": "ede3696b-488f-5d47-b9ba-98c053018804",
          "resultId": "1516d6fd-6db9-58b1-b5df-7f39766daf99",
          "participantId": "95db9715-0d55-50d1-b815-f9cdaae93d30",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Xinhua Peng",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 221019, Nat: CHN."
        },
        {
          "rank": 28,
          "sourceName": "Duan Gao",
          "name": "Duan Gao",
          "sailOrBoardNumber": "200811",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 192,
          "nettScore": 156,
          "races": [
            {
              "raceNumber": 1,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 2,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 3,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 4,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 5,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 6,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 7,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 8,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 9,
              "score": 36,
              "code": null,
              "discarded": true,
              "raw": "(36)"
            },
            {
              "raceNumber": 10,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            }
          ],
          "sailorId": "c9816906-d276-547a-bef3-d0961b38e7df",
          "resultId": "3fb9609c-ca16-58d3-b0e7-e42a74f1aa83",
          "participantId": "58f2dccb-f744-5def-bb81-0f4307f14054",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Duan Gao",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 200811, Nat: CHN."
        },
        {
          "rank": 29,
          "sourceName": "Zidong Yang",
          "name": "Zidong Yang",
          "sailOrBoardNumber": "220529",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 194,
          "nettScore": 157,
          "races": [
            {
              "raceNumber": 1,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 2,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 3,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 4,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 5,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 6,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 7,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 8,
              "score": 37,
              "code": null,
              "discarded": true,
              "raw": "(37)"
            },
            {
              "raceNumber": 9,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 10,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            }
          ],
          "sailorId": "4153958b-e800-5ac9-b07f-880665c136af",
          "resultId": "e0e68827-4add-56fe-9d5a-c61776187437",
          "participantId": "b7b791b8-0e68-558a-a78d-1609d997da77",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Zidong Yang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 220529, Nat: CHN."
        },
        {
          "rank": 30,
          "sourceName": "Luo Enzo",
          "name": "Luo Enzo",
          "sailOrBoardNumber": "210703",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 196,
          "nettScore": 166,
          "races": [
            {
              "raceNumber": 1,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 2,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 3,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 4,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 5,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 6,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 7,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 8,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 9,
              "score": 30,
              "code": null,
              "discarded": true,
              "raw": "(30)"
            },
            {
              "raceNumber": 10,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            }
          ],
          "sailorId": "58b608ad-1fc2-51df-85b7-11c47ee41a39",
          "resultId": "b3923c73-d16c-5390-b37a-e659d8e9742d",
          "participantId": "60b65901-515d-55b8-bfce-33a2afb56356",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Luo Enzo",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 210703, Nat: CHN."
        },
        {
          "rank": 31,
          "sourceName": "Jason Lin",
          "name": "Jason Lin",
          "sailOrBoardNumber": "210325",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 195,
          "nettScore": 169,
          "races": [
            {
              "raceNumber": 1,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 2,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 3,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 4,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 5,
              "score": 26,
              "code": null,
              "discarded": true,
              "raw": "(26)"
            },
            {
              "raceNumber": 6,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 7,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 8,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 9,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 10,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            }
          ],
          "sailorId": "79dc7d49-7373-44e4-9d0d-b3be10d33eca",
          "resultId": "10a8bb38-25fb-57bf-92f4-2a294b954cee",
          "participantId": "fc09867d-dabf-520d-897b-0404d55474ac",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (CHN) match in database",
          "sourceNationality": "CHN",
          "officialName": "Jason Lin",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 210325, Nat: CHN."
        },
        {
          "rank": 32,
          "sourceName": "Cyrus Yung",
          "name": "Cyrus Yung",
          "sailOrBoardNumber": "215277",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 213,
          "nettScore": 174,
          "races": [
            {
              "raceNumber": 1,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 2,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 3,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 4,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 5,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 6,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 7,
              "score": 39,
              "code": null,
              "discarded": true,
              "raw": "(39)"
            },
            {
              "raceNumber": 8,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 9,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 10,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            }
          ],
          "sailorId": "7e5f2a12-3deb-5004-b89f-bc0e35c98a4e",
          "resultId": "2f652bc2-4696-5d09-a3b7-d56c2be0bbe1",
          "participantId": "e6a1bc4a-7c0c-581d-a2dd-6cfaa443f9d4",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (HKG) match in database",
          "sourceNationality": "HKG",
          "officialName": "Cyrus Yung",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 215277, Nat: HKG."
        },
        {
          "rank": 33,
          "sourceName": "Yu Kai Chen",
          "name": "Yu Kai Chen",
          "sailOrBoardNumber": "222236",
          "nationality": "TPE",
          "gender": "M",
          "grossScore": 210,
          "nettScore": 174,
          "races": [
            {
              "raceNumber": 1,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 2,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 3,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 4,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 5,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 6,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 7,
              "score": 36,
              "code": null,
              "discarded": true,
              "raw": "(36)"
            },
            {
              "raceNumber": 8,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 9,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 10,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            }
          ],
          "sailorId": "8aff94fe-6f49-59c7-a489-4b7ee8dbedf5",
          "resultId": "bf30ec24-d61a-5ffa-8197-4b03486e90db",
          "participantId": "fbe70465-ad97-5cf2-90f0-7b280cbee7a9",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "TPE",
          "officialName": "Yu Kai Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 222236, Nat: TPE."
        },
        {
          "rank": 34,
          "sourceName": "Dapeng Ming",
          "name": "Dapeng Ming",
          "sailOrBoardNumber": "217806",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 225,
          "nettScore": 184,
          "races": [
            {
              "raceNumber": 1,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 2,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 3,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 4,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 5,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 6,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 7,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 8,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 9,
              "score": 41,
              "code": "DNC",
              "discarded": true,
              "raw": "(41 DNC)"
            },
            {
              "raceNumber": 10,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            }
          ],
          "sailorId": "ff2b9f52-ba58-5fe2-a0f2-d4169564171f",
          "resultId": "9cf45cf3-9a40-5e7b-9426-13dd7070cb35",
          "participantId": "92bf99f4-6896-5a64-97c4-3f5746adec86",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Dapeng Ming",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 217806, Nat: CHN."
        },
        {
          "rank": 35,
          "sourceName": "Zihan Sun",
          "name": "Zihan Sun",
          "sailOrBoardNumber": "202868",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 222,
          "nettScore": 188,
          "races": [
            {
              "raceNumber": 1,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 2,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 3,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 4,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 5,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 6,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 7,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 8,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 9,
              "score": 34,
              "code": null,
              "discarded": true,
              "raw": "(34)"
            },
            {
              "raceNumber": 10,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            }
          ],
          "sailorId": "bb977df0-36a5-580b-8efb-f2faefa1cb2a",
          "resultId": "440ae312-3470-5c15-80ea-dd7ba494550a",
          "participantId": "419f7e58-cfb2-5d37-99b4-ca85792011f5",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Zihan Sun",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 202868, Nat: CHN."
        },
        {
          "rank": 36,
          "sourceName": "Junxi Ding",
          "name": "Junxi Ding",
          "sailOrBoardNumber": "202848",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 230,
          "nettScore": 193,
          "races": [
            {
              "raceNumber": 1,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 2,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 3,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 4,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 5,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 6,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 7,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 8,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 9,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 10,
              "score": 37,
              "code": null,
              "discarded": true,
              "raw": "(37)"
            }
          ],
          "sailorId": "88f2c39e-13a5-5729-8c4a-485791836852",
          "resultId": "23859f04-63ad-50c4-ac06-2d58ee58afb0",
          "participantId": "8b222df1-a9bc-56cb-87b0-cb1b4ae93d93",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Junxi Ding",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 202848, Nat: CHN."
        },
        {
          "rank": 37,
          "sourceName": "Weikai Zachary Wong",
          "name": "Weikai Zachary Wong",
          "sailOrBoardNumber": "221061",
          "nationality": "SGP",
          "gender": "M",
          "grossScore": 244,
          "nettScore": 205,
          "races": [
            {
              "raceNumber": 1,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 2,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 3,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 4,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 5,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 6,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 7,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 8,
              "score": 39,
              "code": null,
              "discarded": true,
              "raw": "(39)"
            },
            {
              "raceNumber": 9,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 10,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            }
          ],
          "sailorId": "0c7674d6-5926-5108-9bcf-91ebc6272923",
          "resultId": "d958d9de-1ea1-5b96-a225-00b1bc86f959",
          "participantId": "b8a6d632-50ec-5a20-88d8-fe77938d3539",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "SGP",
          "officialName": "Weikai Zachary Wong",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 221061, Nat: SGP."
        },
        {
          "rank": 38,
          "sourceName": "Jonathan Zeppezauer",
          "name": "Jonathan Zeppezauer",
          "sailOrBoardNumber": "215308",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 247,
          "nettScore": 209,
          "races": [
            {
              "raceNumber": 1,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 2,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 3,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 4,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 5,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 6,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 7,
              "score": 38,
              "code": null,
              "discarded": true,
              "raw": "(38)"
            },
            {
              "raceNumber": 8,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 9,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 10,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            }
          ],
          "sailorId": "7dd8713c-ea7c-59ec-8131-1c3f4b4eb652",
          "resultId": "22314df7-ed93-56d6-8e44-7e4f745bb212",
          "participantId": "27ebc591-90b9-5dc9-a9a6-d2eb30fd788f",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "HKG",
          "officialName": "Jonathan Zeppezauer",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 215308, Nat: HKG."
        },
        {
          "rank": 39,
          "sourceName": "Cheng Zhang",
          "name": "Cheng Zhang",
          "sailOrBoardNumber": "220533",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 267,
          "nettScore": 226,
          "races": [
            {
              "raceNumber": 1,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 2,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 3,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 4,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 5,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 6,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 7,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 8,
              "score": 41,
              "code": "RET",
              "discarded": true,
              "raw": "(41 RET)"
            },
            {
              "raceNumber": 9,
              "score": 41,
              "code": "BFD",
              "discarded": false,
              "raw": "41 BFD"
            },
            {
              "raceNumber": 10,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            }
          ],
          "sailorId": "bc7f0507-db8c-5f57-afa5-2e9884b85466",
          "resultId": "22a0b127-ad4d-5062-b476-1596be59e8ba",
          "participantId": "968b0fb3-a71b-5307-977a-e1b4c19a5c07",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Cheng Zhang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 220533, Nat: CHN."
        },
        {
          "rank": 40,
          "sourceName": "Yiming Wu",
          "name": "Yiming Wu",
          "sailOrBoardNumber": "214250",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 132,
          "nettScore": 101,
          "races": [
            {
              "raceNumber": 1,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 2,
              "score": 31,
              "code": null,
              "discarded": true,
              "raw": "(31)"
            },
            {
              "raceNumber": 3,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 4,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 5,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 6,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 7,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 8,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 9,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 10,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            }
          ],
          "sailorId": "d579b3bc-b99b-51e6-b930-5529a5bc5cb6",
          "resultId": "2a0caa14-6e45-5c2c-8caf-96ff19f01bcc",
          "participantId": "430edf4b-bc02-56bf-bc2d-713a6653186e",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yiming Wu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 214250, Nat: CHN."
        },
        {
          "rank": 41,
          "sourceName": "Mohamed Khalid Alowaiss",
          "name": "Mohamed Khalid Alowaiss",
          "sailOrBoardNumber": "201504",
          "nationality": "UAE",
          "gender": "M",
          "grossScore": 146,
          "nettScore": 105,
          "races": [
            {
              "raceNumber": 1,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 2,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 3,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 4,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 5,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 6,
              "score": 41,
              "code": "DSQ",
              "discarded": true,
              "raw": "(41 DSQ)"
            },
            {
              "raceNumber": 7,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 8,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 9,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 10,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            }
          ],
          "sailorId": "68eaffa2-2f9a-5be5-941d-18f7a2bf6ede",
          "resultId": "0b12ebac-0818-534f-a94c-ab1a489f12ff",
          "participantId": "0e4c4d0d-7518-5686-8ee1-d8f20e3d0b81",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "UAE",
          "officialName": "Mohamed Khalid Alowaiss",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 201504, Nat: UAE."
        },
        {
          "rank": 42,
          "sourceName": "Muhammad Adam Aierell",
          "name": "Muhammad Adam Aierell",
          "sailOrBoardNumber": "209892",
          "nationality": "MAS",
          "gender": "M",
          "grossScore": 148,
          "nettScore": 107,
          "races": [
            {
              "raceNumber": 1,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 2,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 3,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 4,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 5,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 6,
              "score": 41,
              "code": "DSQ",
              "discarded": true,
              "raw": "(41 DSQ)"
            },
            {
              "raceNumber": 7,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 8,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 9,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 10,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            }
          ],
          "sailorId": "8dff2c8d-28cc-5950-b5a3-b1c13770883d",
          "resultId": "6fa72c47-b27b-5eaa-9f16-25668fc8063d",
          "participantId": "5f8d8a98-c1b4-5562-b028-04d7533c2ea7",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "MAS",
          "officialName": "Muhammad Adam Aierell",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 209892, Nat: MAS."
        },
        {
          "rank": 43,
          "sourceName": "Shaohui Zhang",
          "name": "Shaohui Zhang",
          "sailOrBoardNumber": "223610",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 164,
          "nettScore": 135,
          "races": [
            {
              "raceNumber": 1,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 2,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 3,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 4,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 5,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 6,
              "score": 29,
              "code": null,
              "discarded": true,
              "raw": "(29)"
            },
            {
              "raceNumber": 7,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 8,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 9,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 10,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            }
          ],
          "sailorId": "ba8931d0-550c-51d0-8910-091f8a3615d4",
          "resultId": "7d20d166-878b-5f13-99f2-a436d5feea4b",
          "participantId": "27eccfdf-f530-5869-a174-27899e33cf1d",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Shaohui Zhang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 223610, Nat: CHN."
        },
        {
          "rank": 44,
          "sourceName": "Avelino Paulo Shin",
          "name": "Avelino Paulo Shin",
          "sailOrBoardNumber": "209902",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 185,
          "nettScore": 144,
          "races": [
            {
              "raceNumber": 1,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 2,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 3,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 4,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 5,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 6,
              "score": 41,
              "code": "RET",
              "discarded": true,
              "raw": "(41 RET)"
            },
            {
              "raceNumber": 7,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 8,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 9,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 10,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            }
          ],
          "sailorId": "0effc04c-0d67-5357-98c5-9025c9717a39",
          "resultId": "e1d2ad5a-6219-59ad-8d3e-618fbcbe468c",
          "participantId": "5ae44dcc-4bda-5b09-a92f-eff09ad4b3c4",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "HKG",
          "officialName": "Avelino Paulo Shin",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 209902, Nat: HKG."
        },
        {
          "rank": 45,
          "sourceName": "Chiying Ng",
          "name": "Chiying Ng",
          "sailOrBoardNumber": "218836",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 188,
          "nettScore": 147,
          "races": [
            {
              "raceNumber": 1,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 2,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 3,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 4,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 5,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 6,
              "score": 41,
              "code": "UFD",
              "discarded": true,
              "raw": "(41 UFD)"
            },
            {
              "raceNumber": 7,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 8,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 9,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 10,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            }
          ],
          "sailorId": "80e86b2d-0731-5ad8-a303-fb7fc53ae46e",
          "resultId": "15ba9417-4d1e-52fd-8457-5eee75777a62",
          "participantId": "274148cb-5a54-5140-a070-441b2386df2a",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "HKG",
          "officialName": "Chiying Ng",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 218836, Nat: HKG."
        },
        {
          "rank": 46,
          "sourceName": "Ji Wang",
          "name": "Ji Wang",
          "sailOrBoardNumber": "202822",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 182,
          "nettScore": 154,
          "races": [
            {
              "raceNumber": 1,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 2,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 3,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 4,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 5,
              "score": 28,
              "code": null,
              "discarded": true,
              "raw": "(28)"
            },
            {
              "raceNumber": 6,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 7,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 8,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 9,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 10,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            }
          ],
          "sailorId": "7be19c4b-130a-593f-848e-40888dd7024f",
          "resultId": "eac69bac-5c13-57fe-8378-2f0cada3a23d",
          "participantId": "52195e63-ceec-58f0-9dff-6746cc3a0fde",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Ji Wang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 202822, Nat: CHN."
        },
        {
          "rank": 47,
          "sourceName": "He Lv",
          "name": "He Lv",
          "sailOrBoardNumber": "202864",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 198,
          "nettScore": 157,
          "races": [
            {
              "raceNumber": 1,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 2,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 3,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 4,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 5,
              "score": 41,
              "code": "DSQ",
              "discarded": true,
              "raw": "(41 DSQ)"
            },
            {
              "raceNumber": 6,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 7,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 8,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 9,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 10,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            }
          ],
          "sailorId": "9dc548f8-eaa5-51b2-b7c0-d283adf7c776",
          "resultId": "fa163b5c-a11c-554a-a8be-ad66ff834c3e",
          "participantId": "f3ccbc74-bc74-54b4-b8fc-fb44728df204",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "He Lv",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 202864, Nat: CHN."
        },
        {
          "rank": 48,
          "sourceName": "Zhenwang Wang",
          "name": "Zhenwang Wang",
          "sailOrBoardNumber": "218689",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 201,
          "nettScore": 160,
          "races": [
            {
              "raceNumber": 1,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 2,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 3,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 4,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 5,
              "score": 41,
              "code": "DSQ",
              "discarded": true,
              "raw": "(41 DSQ)"
            },
            {
              "raceNumber": 6,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 7,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 8,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 9,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 10,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            }
          ],
          "sailorId": "c7479625-ae9b-55ab-aee0-6c4663fb9740",
          "resultId": "229f7a9b-1671-57ea-a5cd-35a2ee1f29b5",
          "participantId": "c8a89d73-5a5b-590e-bec2-10a73c4451c9",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Zhenwang Wang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 218689, Nat: CHN."
        },
        {
          "rank": 49,
          "sourceName": "Zihao Zhi",
          "name": "Zihao Zhi",
          "sailOrBoardNumber": "205972",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 193,
          "nettScore": 162,
          "races": [
            {
              "raceNumber": 1,
              "score": 31,
              "code": null,
              "discarded": true,
              "raw": "(31)"
            },
            {
              "raceNumber": 2,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 3,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 4,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 5,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 6,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 7,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 8,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 9,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 10,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            }
          ],
          "sailorId": "bce9e13d-67b0-58e3-89d3-fcd5648feba8",
          "resultId": "fa3f08f9-99cd-57aa-bdc7-f0509ebbf424",
          "participantId": "193aefe5-7532-5925-a1e4-77bf52f1c823",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Zihao Zhi",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 205972, Nat: CHN."
        },
        {
          "rank": 50,
          "sourceName": "He Qu",
          "name": "He Qu",
          "sailOrBoardNumber": "205979",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 202,
          "nettScore": 168,
          "races": [
            {
              "raceNumber": 1,
              "score": 34,
              "code": null,
              "discarded": true,
              "raw": "(34)"
            },
            {
              "raceNumber": 2,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 3,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 4,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 5,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 6,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 7,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 8,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 9,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 10,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            }
          ],
          "sailorId": "7abfdde4-90ff-55c8-81a1-76c6f2eea4e0",
          "resultId": "4a62e35c-5822-5699-a431-70e0f5afd0f1",
          "participantId": "2a201eba-528d-533c-88b1-133b3105f88a",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "He Qu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 205979, Nat: CHN."
        },
        {
          "rank": 51,
          "sourceName": "Yiqing Li",
          "name": "Yiqing Li",
          "sailOrBoardNumber": "223811",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 211,
          "nettScore": 179,
          "races": [
            {
              "raceNumber": 1,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 2,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 3,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 4,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 5,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 6,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 7,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 8,
              "score": 32,
              "code": null,
              "discarded": true,
              "raw": "(32)"
            },
            {
              "raceNumber": 9,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 10,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            }
          ],
          "sailorId": "6ffe5f44-12c9-53c7-9edf-46fa7329911e",
          "resultId": "471401c8-2b6b-5173-881b-698f46a0c54f",
          "participantId": "31eeae8d-3ecd-58fb-833f-425b8c8a88e6",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yiqing Li",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 223811, Nat: CHN."
        },
        {
          "rank": 52,
          "sourceName": "Fengkai Liu",
          "name": "Fengkai Liu",
          "sailOrBoardNumber": "225954",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 212,
          "nettScore": 179,
          "races": [
            {
              "raceNumber": 1,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 2,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 3,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 4,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 5,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 6,
              "score": 33,
              "code": null,
              "discarded": true,
              "raw": "(33)"
            },
            {
              "raceNumber": 7,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 8,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 9,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 10,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            }
          ],
          "sailorId": "ccdde706-66e7-57d3-beda-0d94331fde72",
          "resultId": "094d16c7-d9f3-5cd8-8561-dad4e54852d9",
          "participantId": "05d8ca6c-6267-5e26-b098-73efcbede7dc",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Fengkai Liu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 225954, Nat: CHN."
        },
        {
          "rank": 53,
          "sourceName": "Yinghao Fu",
          "name": "Yinghao Fu",
          "sailOrBoardNumber": "219993",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 223,
          "nettScore": 182,
          "races": [
            {
              "raceNumber": 1,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 2,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 3,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 4,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 5,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 6,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 7,
              "score": 41,
              "code": "DNC",
              "discarded": true,
              "raw": "(41 DNC)"
            },
            {
              "raceNumber": 8,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            },
            {
              "raceNumber": 9,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 10,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            }
          ],
          "sailorId": "54143e61-2416-577f-bafc-51a89334270f",
          "resultId": "7283a7c3-ab3f-5186-b4b8-841256855db5",
          "participantId": "b230c84b-4bd9-5671-b8ea-809708ba12a4",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yinghao Fu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 219993, Nat: CHN."
        },
        {
          "rank": 54,
          "sourceName": "Caleb Rui-Kai Peck",
          "name": "Caleb Rui-Kai Peck",
          "sailOrBoardNumber": "225221",
          "nationality": "SGP",
          "gender": "M",
          "grossScore": 221,
          "nettScore": 186,
          "races": [
            {
              "raceNumber": 1,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 2,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 3,
              "score": 35,
              "code": null,
              "discarded": true,
              "raw": "(35)"
            },
            {
              "raceNumber": 4,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 5,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 6,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 7,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 8,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 9,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 10,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            }
          ],
          "sailorId": "8d225382-7ff4-575a-a731-9eba600f4664",
          "resultId": "d6941b48-e3e8-56ec-91e8-9b4126816384",
          "participantId": "683a3183-f376-577f-a492-8310854d3613",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "SGP",
          "officialName": "Caleb Rui-Kai Peck",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 225221, Nat: SGP."
        },
        {
          "rank": 55,
          "sourceName": "Jinhang Yu",
          "name": "Jinhang Yu",
          "sailOrBoardNumber": "202942",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 231,
          "nettScore": 190,
          "races": [
            {
              "raceNumber": 1,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 2,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 3,
              "score": 41,
              "code": "UFD",
              "discarded": true,
              "raw": "(41 UFD)"
            },
            {
              "raceNumber": 4,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 5,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 6,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 7,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 8,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 9,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 10,
              "score": 41,
              "code": "UFD",
              "discarded": false,
              "raw": "41 UFD"
            }
          ],
          "sailorId": "3bdb185e-6937-5641-86f5-3d735c4e85c2",
          "resultId": "a53b51e1-c881-5bf3-86ef-9013348f22a5",
          "participantId": "cabf2040-b3a0-5088-88cc-d59f54ce6fcd",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Jinhang Yu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 202942, Nat: CHN."
        },
        {
          "rank": 56,
          "sourceName": "Saif Al Marzooqi",
          "name": "Saif Al Marzooqi",
          "sailOrBoardNumber": "207904",
          "nationality": "UAE",
          "gender": "M",
          "grossScore": 233,
          "nettScore": 192,
          "races": [
            {
              "raceNumber": 1,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 2,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 3,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 4,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 5,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 6,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 7,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 8,
              "score": 22,
              "code": "SCP30%",
              "discarded": false,
              "raw": "22 SCP30%"
            },
            {
              "raceNumber": 9,
              "score": 41,
              "code": "UFD",
              "discarded": true,
              "raw": "(41 UFD)"
            },
            {
              "raceNumber": 10,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            }
          ],
          "sailorId": "0a630751-f261-5069-a38a-cdfb831bbb1f",
          "resultId": "179cef38-6e22-5b1c-a152-213a85666ea6",
          "participantId": "c08d1c69-47c0-5a5e-9183-87c0d17cb05e",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "UAE",
          "officialName": "Saif Al Marzooqi",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 207904, Nat: UAE."
        },
        {
          "rank": 57,
          "sourceName": "Boxuan Yu",
          "name": "Boxuan Yu",
          "sailOrBoardNumber": "223620",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 244,
          "nettScore": 209,
          "races": [
            {
              "raceNumber": 1,
              "score": 35,
              "code": null,
              "discarded": true,
              "raw": "(35)"
            },
            {
              "raceNumber": 2,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 3,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 4,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 5,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 6,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 7,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 8,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 9,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 10,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            }
          ],
          "sailorId": "3590c7e0-16bf-4193-973e-2d94d3a9e37d",
          "resultId": "1d4fa3dc-7793-5ea1-9381-19e0775e8548",
          "participantId": "448545a6-0f5f-5afd-a173-16583d2399b6",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (CHN) match in database",
          "sourceNationality": "CHN",
          "officialName": "Boxuan Yu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 223620, Nat: CHN."
        },
        {
          "rank": 58,
          "sourceName": "Xiaolin Zhang",
          "name": "Xiaolin Zhang",
          "sailOrBoardNumber": "221027",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 244,
          "nettScore": 209,
          "races": [
            {
              "raceNumber": 1,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 2,
              "score": 35,
              "code": null,
              "discarded": true,
              "raw": "(35)"
            },
            {
              "raceNumber": 3,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 4,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 5,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 6,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 7,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 8,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 9,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 10,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            }
          ],
          "sailorId": "17e285a4-3c1e-56cd-81bb-15dd7f6ab70f",
          "resultId": "9ce01447-6535-5bd5-bd05-2bb9d32a4138",
          "participantId": "dae483cc-4871-5624-b99d-8b8782ba00d1",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Xiaolin Zhang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 221027, Nat: CHN."
        },
        {
          "rank": 59,
          "sourceName": "Nan Jiang",
          "name": "Nan Jiang",
          "sailOrBoardNumber": "223789",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 251,
          "nettScore": 216,
          "races": [
            {
              "raceNumber": 1,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 2,
              "score": 35,
              "code": null,
              "discarded": true,
              "raw": "(35)"
            },
            {
              "raceNumber": 3,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 4,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 5,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 6,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 7,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 8,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 9,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 10,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            }
          ],
          "sailorId": "1a175dba-1f34-5ff1-998e-13b0553bf23f",
          "resultId": "058615c6-3cc5-5eeb-ad74-14d063c8f933",
          "participantId": "39df975b-8aa5-5279-b3e1-432ab27073e5",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Nan Jiang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 223789, Nat: CHN."
        },
        {
          "rank": 60,
          "sourceName": "Jhen-Syun You",
          "name": "Jhen-Syun You",
          "sailOrBoardNumber": "173563",
          "nationality": "TPE",
          "gender": "M",
          "grossScore": 256,
          "nettScore": 223,
          "races": [
            {
              "raceNumber": 1,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 2,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 3,
              "score": 33,
              "code": null,
              "discarded": true,
              "raw": "(33)"
            },
            {
              "raceNumber": 4,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 5,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 6,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 7,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 8,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 9,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 10,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            }
          ],
          "sailorId": "d0231a7c-9606-5aa8-8025-fa1500017fcd",
          "resultId": "23658beb-c8ab-5349-a9aa-7c4372e8bf0a",
          "participantId": "6eb5ee36-e94c-50ce-9a65-b4ee605473af",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "TPE",
          "officialName": "Jhen-Syun You",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 173563, Nat: TPE."
        },
        {
          "rank": 61,
          "sourceName": "Jorge Wong",
          "name": "Jorge Wong",
          "sailOrBoardNumber": "215482",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 277,
          "nettScore": 236,
          "races": [
            {
              "raceNumber": 1,
              "score": 41,
              "code": "DNC",
              "discarded": true,
              "raw": "(41 DNC)"
            },
            {
              "raceNumber": 2,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            },
            {
              "raceNumber": 3,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 4,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 5,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 6,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 7,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 8,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 9,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            },
            {
              "raceNumber": 10,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            }
          ],
          "sailorId": "38110f5a-aea4-45eb-90f8-3909e0445794",
          "resultId": "b87d1301-c9d9-53ac-9ac1-437ab5a96778",
          "participantId": "ccd4ea1b-b500-5dda-96c6-167c31dd0953",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (HKG) match in database",
          "sourceNationality": "HKG",
          "officialName": "Jorge Wong",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 215482, Nat: HKG."
        },
        {
          "rank": 62,
          "sourceName": "Kaman Ho",
          "name": "Kaman Ho",
          "sailOrBoardNumber": "224681",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 283,
          "nettScore": 246,
          "races": [
            {
              "raceNumber": 1,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 2,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 3,
              "score": 37,
              "code": null,
              "discarded": true,
              "raw": "(37)"
            },
            {
              "raceNumber": 4,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 5,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 6,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 7,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 8,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 9,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 10,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            }
          ],
          "sailorId": "583fd9f9-4933-5687-a364-44867c36035a",
          "resultId": "73d6b7f6-ee86-52ec-afc4-34f96d09187c",
          "participantId": "19903eae-8d5b-55ae-a733-bde99a0c3208",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Kaman Ho",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 224681, Nat: CHN."
        },
        {
          "rank": 63,
          "sourceName": "Guoxin Qin",
          "name": "Guoxin Qin",
          "sailOrBoardNumber": "225497",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 294,
          "nettScore": 253,
          "races": [
            {
              "raceNumber": 1,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 2,
              "score": 41,
              "code": "DNF",
              "discarded": true,
              "raw": "(41 DNF)"
            },
            {
              "raceNumber": 3,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 4,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 5,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 6,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 7,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 8,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 9,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 10,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            }
          ],
          "sailorId": "20029686-86c4-5038-b617-0a3c3cd48950",
          "resultId": "ab1a6769-66c0-55ec-8c9c-5bc67946a151",
          "participantId": "1b4d30d7-82aa-53d9-828e-28113e8b36b7",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Guoxin Qin",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 225497, Nat: CHN."
        },
        {
          "rank": 64,
          "sourceName": "Yuxiang Tao",
          "name": "Yuxiang Tao",
          "sailOrBoardNumber": "223812",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 297,
          "nettScore": 256,
          "races": [
            {
              "raceNumber": 1,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 2,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 3,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 4,
              "score": 41,
              "code": "DNF",
              "discarded": true,
              "raw": "(41 DNF)"
            },
            {
              "raceNumber": 5,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 6,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 7,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 8,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 9,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 10,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            }
          ],
          "sailorId": "f1ba1b44-0e92-5bff-b041-b6584719fc28",
          "resultId": "e9d3b67c-7123-57af-9860-7399eed5033d",
          "participantId": "edc7dd24-66f4-57e0-afb0-303061f3a126",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yuxiang Tao",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 223812, Nat: CHN."
        },
        {
          "rank": 65,
          "sourceName": "Jishuo Zhang",
          "name": "Jishuo Zhang",
          "sailOrBoardNumber": "225101",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 310,
          "nettScore": 269,
          "races": [
            {
              "raceNumber": 1,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 2,
              "score": 41,
              "code": "DNF",
              "discarded": true,
              "raw": "(41 DNF)"
            },
            {
              "raceNumber": 3,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 4,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 5,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 6,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 7,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 8,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 9,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 10,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            }
          ],
          "sailorId": "43219fd4-b508-5eb7-873a-7c615ce7e38e",
          "resultId": "819d77da-3f26-576a-b6ef-7a579f72c22b",
          "participantId": "bdfb90a3-f551-5564-9f0d-930bb3637159",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Jishuo Zhang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 225101, Nat: CHN."
        },
        {
          "rank": 66,
          "sourceName": "HaoWei Zhuang",
          "name": "HaoWei Zhuang",
          "sailOrBoardNumber": "219986",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 308,
          "nettScore": 270,
          "races": [
            {
              "raceNumber": 1,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 2,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 3,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 4,
              "score": 38,
              "code": null,
              "discarded": true,
              "raw": "(38)"
            },
            {
              "raceNumber": 5,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 6,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 7,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 8,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 9,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 10,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            }
          ],
          "sailorId": "9f669bbf-2799-5cc5-9fc2-a26dc4813862",
          "resultId": "93ee409c-bc74-598e-9fde-dc2b4776420b",
          "participantId": "a29caabc-a2a0-5f41-88cc-182c59eaf3d9",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "HaoWei Zhuang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 219986, Nat: CHN."
        },
        {
          "rank": 67,
          "sourceName": "ZhiYuan Xu",
          "name": "ZhiYuan Xu",
          "sailOrBoardNumber": "223810",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 314,
          "nettScore": 278,
          "races": [
            {
              "raceNumber": 1,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 2,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 3,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 4,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 5,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 6,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 7,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 8,
              "score": 36,
              "code": null,
              "discarded": true,
              "raw": "(36)"
            },
            {
              "raceNumber": 9,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 10,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            }
          ],
          "sailorId": "9d0b9c9d-9abc-593a-bda0-2c1f2194ec2e",
          "resultId": "e7f584c5-0962-5bd5-9b42-1ea42ad2dce8",
          "participantId": "185d5fdb-c359-5bd2-8b9f-f7cb0933e13a",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "ZhiYuan Xu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 223810, Nat: CHN."
        },
        {
          "rank": 68,
          "sourceName": "Min Zhang",
          "name": "Min Zhang",
          "sailOrBoardNumber": "205009",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 316,
          "nettScore": 280,
          "races": [
            {
              "raceNumber": 1,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 2,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 3,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 4,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 5,
              "score": 36,
              "code": null,
              "discarded": true,
              "raw": "(36)"
            },
            {
              "raceNumber": 6,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 7,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 8,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 9,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 10,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            }
          ],
          "sailorId": "0a157383-ee45-5e8c-aa06-ec12fbf2ad2c",
          "resultId": "e070aa66-47cd-59cd-8b8a-b4823c7cfc91",
          "participantId": "aa4f4bd7-caa9-5879-b4c0-5606fc072bdc",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Min Zhang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 205009, Nat: CHN."
        },
        {
          "rank": 69,
          "sourceName": "HongJun Wang",
          "name": "HongJun Wang",
          "sailOrBoardNumber": "205026",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 321,
          "nettScore": 283,
          "races": [
            {
              "raceNumber": 1,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 2,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 3,
              "score": 38,
              "code": null,
              "discarded": true,
              "raw": "(38)"
            },
            {
              "raceNumber": 4,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 5,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 6,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 7,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 8,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 9,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 10,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            }
          ],
          "sailorId": "511db3ec-2851-50b0-bba8-da974a79936f",
          "resultId": "b16d1dfe-5986-568e-aeaa-d35afec7a4cb",
          "participantId": "157ff590-be4f-5371-978a-89fe1d0521c9",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "HongJun Wang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 205026, Nat: CHN."
        },
        {
          "rank": 70,
          "sourceName": "Tianle Wang",
          "name": "Tianle Wang",
          "sailOrBoardNumber": "223796",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 325,
          "nettScore": 284,
          "races": [
            {
              "raceNumber": 1,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 2,
              "score": 41,
              "code": "DNF",
              "discarded": true,
              "raw": "(41 DNF)"
            },
            {
              "raceNumber": 3,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 4,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 5,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 6,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 7,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 8,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 9,
              "score": 41,
              "code": "UFD",
              "discarded": false,
              "raw": "41 UFD"
            },
            {
              "raceNumber": 10,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            }
          ],
          "sailorId": "50f1720d-1f44-5ce2-a5f7-5507e56fb87f",
          "resultId": "8e522bb4-e1fa-5069-961f-917f95624a96",
          "participantId": "2258e6ff-05ee-5170-8aab-ccfdfec6d4f0",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Tianle Wang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 223796, Nat: CHN."
        },
        {
          "rank": 71,
          "sourceName": "Marcus Li",
          "name": "Marcus Li",
          "sailOrBoardNumber": "213343",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 335,
          "nettScore": 294,
          "races": [
            {
              "raceNumber": 1,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 2,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 3,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 4,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 5,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 6,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 7,
              "score": 41,
              "code": "DNC",
              "discarded": true,
              "raw": "(41 DNC)"
            },
            {
              "raceNumber": 8,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            },
            {
              "raceNumber": 9,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            },
            {
              "raceNumber": 10,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            }
          ],
          "sailorId": "35ddaae9-11d3-457f-ba18-2c96e6df5aac",
          "resultId": "f94c5f70-4f44-5cad-a8ca-ed022e25d2bf",
          "participantId": "22a9ef08-ffeb-5f1b-b36a-8990c606f8ec",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (HKG) match in database",
          "sourceNationality": "HKG",
          "officialName": "Marcus Li",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 213343, Nat: HKG."
        },
        {
          "rank": 72,
          "sourceName": "Jerry Mei",
          "name": "Jerry Mei",
          "sailOrBoardNumber": "219311",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 338,
          "nettScore": 297,
          "races": [
            {
              "raceNumber": 1,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 2,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 3,
              "score": 41,
              "code": "DNC",
              "discarded": true,
              "raw": "(41 DNC)"
            },
            {
              "raceNumber": 4,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            },
            {
              "raceNumber": 5,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 6,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 7,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 8,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 9,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 10,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            }
          ],
          "sailorId": "10525e79-4f3a-5981-b868-6149c53653d9",
          "resultId": "4196bbba-4da7-5f50-a163-5a48c9065267",
          "participantId": "97bf43fa-c5c2-577c-af1d-ab87f6a0e938",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Jerry Mei",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 219311, Nat: CHN."
        },
        {
          "rank": 73,
          "sourceName": "Zongchen Wei",
          "name": "Zongchen Wei",
          "sailOrBoardNumber": "223797",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 343,
          "nettScore": 302,
          "races": [
            {
              "raceNumber": 1,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 2,
              "score": 41,
              "code": "DNF",
              "discarded": true,
              "raw": "(41 DNF)"
            },
            {
              "raceNumber": 3,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 4,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 5,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 6,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 7,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 8,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 9,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 10,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            }
          ],
          "sailorId": "0daa3f08-a322-5498-ace7-9fb3088e97c3",
          "resultId": "0d8ad62c-656a-5da9-a375-887b6fd6397a",
          "participantId": "f97e6bd2-4b23-59cb-a8cb-5b983914501c",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Zongchen Wei",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 223797, Nat: CHN."
        },
        {
          "rank": 74,
          "sourceName": "Xunhao Zheng",
          "name": "Xunhao Zheng",
          "sailOrBoardNumber": "223798",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 349,
          "nettScore": 308,
          "races": [
            {
              "raceNumber": 1,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 2,
              "score": 41,
              "code": "DNF",
              "discarded": true,
              "raw": "(41 DNF)"
            },
            {
              "raceNumber": 3,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 4,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 5,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 6,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 7,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 8,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 9,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 10,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            }
          ],
          "sailorId": "56ea1e8c-631b-568f-b6eb-8096cf9ec9e4",
          "resultId": "9358772d-294d-50f6-a284-f4211f1e0786",
          "participantId": "e7d71a7e-81b9-5680-bbea-8af6016fcd0b",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Xunhao Zheng",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 223798, Nat: CHN."
        },
        {
          "rank": 75,
          "sourceName": "Leyan Huang",
          "name": "Leyan Huang",
          "sailOrBoardNumber": "222962",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 358,
          "nettScore": 317,
          "races": [
            {
              "raceNumber": 1,
              "score": 41,
              "code": "DNF",
              "discarded": true,
              "raw": "(41 DNF)"
            },
            {
              "raceNumber": 2,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 3,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 4,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 5,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 6,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 7,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 8,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 9,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            },
            {
              "raceNumber": 10,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            }
          ],
          "sailorId": "4f0601e7-97b8-56e2-8f35-16b373dac4eb",
          "resultId": "ce8e91d0-b062-50ed-ae55-edfd3147a2d9",
          "participantId": "d0881561-da19-560f-96a6-991a1299ad48",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Leyan Huang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 222962, Nat: CHN."
        },
        {
          "rank": 76,
          "sourceName": "Jiale Geng",
          "name": "Jiale Geng",
          "sailOrBoardNumber": "200318",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 367,
          "nettScore": 326,
          "races": [
            {
              "raceNumber": 1,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 2,
              "score": 41,
              "code": "DNF",
              "discarded": true,
              "raw": "(41 DNF)"
            },
            {
              "raceNumber": 3,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 4,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 5,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 6,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 7,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 8,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 9,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 10,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            }
          ],
          "sailorId": "94da7557-e28f-5096-b25f-e36836f38c09",
          "resultId": "267658e6-fbac-579c-a766-36614b1507da",
          "participantId": "49ba17ff-36f2-59fa-b500-dd20a7a55d02",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Jiale Geng",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 200318, Nat: CHN."
        },
        {
          "rank": 77,
          "sourceName": "Jinsong Zhang",
          "name": "Jinsong Zhang",
          "sailOrBoardNumber": "223600",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 373,
          "nettScore": 332,
          "races": [
            {
              "raceNumber": 1,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 2,
              "score": 41,
              "code": "DNF",
              "discarded": true,
              "raw": "(41 DNF)"
            },
            {
              "raceNumber": 3,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 4,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 5,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 6,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 7,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            },
            {
              "raceNumber": 8,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            },
            {
              "raceNumber": 9,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            },
            {
              "raceNumber": 10,
              "score": 41,
              "code": "DNC",
              "discarded": false,
              "raw": "41 DNC"
            }
          ],
          "sailorId": "c7e11466-03d9-4c45-a8b2-81e080c543f9",
          "resultId": "94e8b70a-8fac-54cb-91e1-5e19b558daab",
          "participantId": "49816f96-461b-5040-ad14-8daf83ae7ba8",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (CHN) match in database",
          "sourceNationality": "CHN",
          "officialName": "Jinsong Zhang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Boys U18. Sail No: 223600, Nat: CHN."
        }
      ]
    },
    {
      "config": {
        "id": "b1a02024-a510-48e0-8003-000000000002",
        "slug": "2024-ilca-asian-open-championship-ilca4-girls",
        "name": "2024 ILCA Asian Open Championship (ILCA 4 Youth Girls U18)",
        "boatClass": "ILCA 4",
        "division": "Youth Girls U18",
        "gender": "W",
        "raceCount": 10,
        "discardCount": 1,
        "entryType": "individual",
        "date": "2024-12-14",
        "endDate": "2024-12-20"
      },
      "results": [
        {
          "rank": 1,
          "sourceName": "Meifang Zhao",
          "name": "Meifang Zhao",
          "sailOrBoardNumber": "221557",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 34,
          "nettScore": 23,
          "races": [
            {
              "raceNumber": 1,
              "score": 11,
              "code": null,
              "discarded": true,
              "raw": "(11)"
            },
            {
              "raceNumber": 2,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 3,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 4,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 5,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 6,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 7,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 8,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 9,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 10,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            }
          ],
          "sailorId": "d4a73837-9aea-512a-a508-6463f255d349",
          "resultId": "7014db32-9231-52de-8f27-71e84409ed40",
          "participantId": "51eb7bb3-eb80-5c3b-b210-596f681502de",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Meifang Zhao",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 221557, Nat: CHN."
        },
        {
          "rank": 2,
          "sourceName": "Meixiu Zhao",
          "name": "Meixiu Zhao",
          "sailOrBoardNumber": "223790",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 47,
          "nettScore": 27,
          "races": [
            {
              "raceNumber": 1,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 2,
              "score": 20,
              "code": null,
              "discarded": true,
              "raw": "(20)"
            },
            {
              "raceNumber": 3,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 4,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 5,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 6,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 7,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 8,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 9,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 10,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            }
          ],
          "sailorId": "7dac82e6-2cc0-5681-8b9a-75a9deba9edb",
          "resultId": "0f9f1a97-5ec5-5a58-aae7-280646f42daa",
          "participantId": "f78239af-09a9-521a-8433-bd625468d197",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Meixiu Zhao",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 223790, Nat: CHN."
        },
        {
          "rank": 3,
          "sourceName": "Prin Subying",
          "name": "Prin Subying",
          "sailOrBoardNumber": "222687",
          "nationality": "THA",
          "gender": "W",
          "grossScore": 43,
          "nettScore": 31,
          "races": [
            {
              "raceNumber": 1,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 2,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 3,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 4,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 5,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 6,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 7,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 8,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 9,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 10,
              "score": 12,
              "code": null,
              "discarded": true,
              "raw": "(12)"
            }
          ],
          "sailorId": "74484e56-ea11-59e5-b72b-fff0cac309fc",
          "resultId": "0352aafe-d577-503f-86d9-fe63b266d4da",
          "participantId": "21f8a9b4-aeab-5376-b9c9-d708b02a668b",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "THA",
          "officialName": "Prin Subying",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 222687, Nat: THA."
        },
        {
          "rank": 4,
          "sourceName": "Guoguo Yan",
          "name": "Guoguo Yan",
          "sailOrBoardNumber": "211947",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 72,
          "nettScore": 55,
          "races": [
            {
              "raceNumber": 1,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 2,
              "score": 17,
              "code": null,
              "discarded": true,
              "raw": "(17)"
            },
            {
              "raceNumber": 3,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 4,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 5,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 6,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 7,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 8,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 9,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 10,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            }
          ],
          "sailorId": "f7c5c2e7-a371-584d-8b60-ae56f00fbace",
          "resultId": "ec58cb6e-6122-5dce-bfe9-569654a7e6fc",
          "participantId": "e3962bd3-8098-5a23-8e23-026c671667fd",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Guoguo Yan",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 211947, Nat: CHN."
        },
        {
          "rank": 5,
          "sourceName": "Zixi Huang",
          "name": "Zixi Huang",
          "sailOrBoardNumber": "221400",
          "nationality": "HKG",
          "gender": "W",
          "grossScore": 85,
          "nettScore": 64,
          "races": [
            {
              "raceNumber": 1,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 2,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 3,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 4,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 5,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 6,
              "score": 21,
              "code": null,
              "discarded": true,
              "raw": "(21)"
            },
            {
              "raceNumber": 7,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 8,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 9,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 10,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            }
          ],
          "sailorId": "e3ea45d8-9cd9-4bd0-98dc-58aa3e8aaeb9",
          "resultId": "578b6573-9aa4-547f-90d2-dbe674fdd12c",
          "participantId": "2fd392aa-0a18-51b3-97af-f10487653b54",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (HKG) match in database",
          "sourceNationality": "HKG",
          "officialName": "Zixi Huang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 221400, Nat: HKG."
        },
        {
          "rank": 6,
          "sourceName": "Linhan Zhang",
          "name": "Linhan Zhang",
          "sailOrBoardNumber": "212275",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 100,
          "nettScore": 78,
          "races": [
            {
              "raceNumber": 1,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 2,
              "score": 22,
              "code": null,
              "discarded": true,
              "raw": "(22)"
            },
            {
              "raceNumber": 3,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 4,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 5,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 6,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 7,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 8,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 9,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 10,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            }
          ],
          "sailorId": "9e8db81c-630b-5879-bcfe-2c1ea4030c25",
          "resultId": "c300d2b1-e172-50f9-a2f5-bd454a83b684",
          "participantId": "833eaf6c-6ba3-5dbe-bd75-ede0bf30a3bb",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Linhan Zhang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 212275, Nat: CHN."
        },
        {
          "rank": 7,
          "sourceName": "Yaxuan Luo",
          "name": "Yaxuan Luo",
          "sailOrBoardNumber": "220526",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 133,
          "nettScore": 80,
          "races": [
            {
              "raceNumber": 1,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 2,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 3,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 4,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 5,
              "score": 53,
              "code": "BFD",
              "discarded": true,
              "raw": "(53 BFD)"
            },
            {
              "raceNumber": 6,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 7,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 8,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 9,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 10,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            }
          ],
          "sailorId": "2386b36f-2ea0-54f6-9d2f-244c22cacda4",
          "resultId": "a165005a-180a-5fc9-b7fa-b47672fdc214",
          "participantId": "b0c1492c-c2db-512a-8fa6-618b282299a8",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yaxuan Luo",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 220526, Nat: CHN."
        },
        {
          "rank": 8,
          "sourceName": "Fan Liu",
          "name": "Fan Liu",
          "sailOrBoardNumber": "214448",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 122,
          "nettScore": 100,
          "races": [
            {
              "raceNumber": 1,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 2,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 3,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 4,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 5,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 6,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 7,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 8,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 9,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 10,
              "score": 22,
              "code": null,
              "discarded": true,
              "raw": "(22)"
            }
          ],
          "sailorId": "50e6a7c0-6c46-5c80-92ca-424450e3dfb1",
          "resultId": "0517275a-38c3-5c61-8c5f-008d3fa776d3",
          "participantId": "070d2ed3-e977-555e-a60a-7a507bd06a02",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Fan Liu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 214448, Nat: CHN."
        },
        {
          "rank": 9,
          "sourceName": "Huiting Xu",
          "name": "Huiting Xu",
          "sailOrBoardNumber": "212117",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 140,
          "nettScore": 101,
          "races": [
            {
              "raceNumber": 1,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 2,
              "score": 39,
              "code": null,
              "discarded": true,
              "raw": "(39)"
            },
            {
              "raceNumber": 3,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 4,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 5,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 6,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 7,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 8,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 9,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 10,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            }
          ],
          "sailorId": "e0a973ec-5c34-5cde-bfe9-73a88263e902",
          "resultId": "a3a26836-2229-5363-818c-a8253a72373b",
          "participantId": "9f9ebd87-c04b-5623-82e6-32364f56200d",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Huiting Xu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 212117, Nat: CHN."
        },
        {
          "rank": 10,
          "sourceName": "Danielle Lai",
          "name": "Danielle Lai",
          "sailOrBoardNumber": "222257",
          "nationality": "SGP",
          "gender": "W",
          "grossScore": 134,
          "nettScore": 109,
          "races": [
            {
              "raceNumber": 1,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 2,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 3,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 4,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 5,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 6,
              "score": 25,
              "code": null,
              "discarded": true,
              "raw": "(25)"
            },
            {
              "raceNumber": 7,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 8,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 9,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 10,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            }
          ],
          "sailorId": "a95b6b0a-6c38-40b6-a0bc-2dcaa9bcb9e2",
          "resultId": "57b3c688-dbca-5adc-a499-b870a0c748f8",
          "participantId": "2d822a96-3d27-5344-a648-1fc48f055289",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Danielle Lai",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 222257, Nat: SGP."
        },
        {
          "rank": 11,
          "sourceName": "Gabi Oh",
          "name": "Gabi Oh",
          "sailOrBoardNumber": "224717",
          "nationality": "SGP",
          "gender": "W",
          "grossScore": 165,
          "nettScore": 112,
          "races": [
            {
              "raceNumber": 1,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 2,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 3,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 4,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 5,
              "score": 53,
              "code": "DSQ",
              "discarded": true,
              "raw": "(53 DSQ)"
            },
            {
              "raceNumber": 6,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 7,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 8,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 9,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 10,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            }
          ],
          "sailorId": "ee4ffc51-2ad1-46fd-85d1-0d100676840f",
          "resultId": "ebfbc094-1c49-5cdd-8915-8793b8399f2f",
          "participantId": "a10926a1-a729-5aec-b928-172c5b78132b",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Gabi Oh",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 224717, Nat: SGP."
        },
        {
          "rank": 12,
          "sourceName": "Yijia Su",
          "name": "Yijia Su",
          "sailOrBoardNumber": "219936",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 151,
          "nettScore": 118,
          "races": [
            {
              "raceNumber": 1,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 2,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 3,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 4,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 5,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 6,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 7,
              "score": 33,
              "code": null,
              "discarded": true,
              "raw": "(33)"
            },
            {
              "raceNumber": 8,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 9,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 10,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            }
          ],
          "sailorId": "0a36ac43-cca1-5864-8081-62ed058052b7",
          "resultId": "a3d5fdd4-c263-5cbe-a5d1-d79409bdd986",
          "participantId": "5e9312f3-8596-586f-8aaf-fe95f6e7f186",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yijia Su",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 219936, Nat: CHN."
        },
        {
          "rank": 13,
          "sourceName": "Sarah Yong",
          "name": "Sarah Yong",
          "sailOrBoardNumber": "221689",
          "nationality": "SGP",
          "gender": "W",
          "grossScore": 181,
          "nettScore": 128,
          "races": [
            {
              "raceNumber": 1,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 2,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 3,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 4,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 5,
              "score": 53,
              "code": "BFD",
              "discarded": true,
              "raw": "(53 BFD)"
            },
            {
              "raceNumber": 6,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 7,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 8,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 9,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 10,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            }
          ],
          "sailorId": "82ab4ba4-a693-4e7d-a9c5-6531752cea6e",
          "resultId": "7a1c011e-613c-52bb-89c3-b017241b6411",
          "participantId": "06d022ed-764c-520d-8093-0c190da795f8",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Sarah Yong",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 221689, Nat: SGP."
        },
        {
          "rank": 14,
          "sourceName": "Yujiao Cao",
          "name": "Yujiao Cao",
          "sailOrBoardNumber": "156072",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 154,
          "nettScore": 129,
          "races": [
            {
              "raceNumber": 1,
              "score": 25,
              "code": null,
              "discarded": true,
              "raw": "(25)"
            },
            {
              "raceNumber": 2,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 3,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 4,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 5,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 6,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 7,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 8,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 9,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 10,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            }
          ],
          "sailorId": "16282942-59b2-5a34-b49f-be513445eebe",
          "resultId": "1f11bc65-648f-55d9-be0c-777825d256e5",
          "participantId": "1f6992d5-7992-5b98-89b4-6750dbdadf43",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yujiao Cao",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 156072, Nat: CHN."
        },
        {
          "rank": 15,
          "sourceName": "Nur Zafrina Syuhada Mohd Zailan",
          "name": "Nur Zafrina Syuhada Mohd Zailan",
          "sailOrBoardNumber": "206032",
          "nationality": "MAS",
          "gender": "W",
          "grossScore": 158,
          "nettScore": 133,
          "races": [
            {
              "raceNumber": 1,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 2,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 3,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 4,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 5,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 6,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 7,
              "score": 25,
              "code": null,
              "discarded": true,
              "raw": "(25)"
            },
            {
              "raceNumber": 8,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 9,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 10,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            }
          ],
          "sailorId": "f35d2c05-8876-5246-98b2-974a85a25e06",
          "resultId": "d7391745-cc66-5b6b-8e49-c43d761b71ed",
          "participantId": "d0e77743-0493-5b6c-9ac1-e43ee8b234d6",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "MAS",
          "officialName": "Nur Zafrina Syuhada Mohd Zailan",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 206032, Nat: MAS."
        },
        {
          "rank": 16,
          "sourceName": "Ruoxian Wu",
          "name": "Ruoxian Wu",
          "sailOrBoardNumber": "221026",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 173,
          "nettScore": 146,
          "races": [
            {
              "raceNumber": 1,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 2,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 3,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 4,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 5,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 6,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 7,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 8,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 9,
              "score": 27,
              "code": null,
              "discarded": true,
              "raw": "(27)"
            },
            {
              "raceNumber": 10,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            }
          ],
          "sailorId": "e686d1dd-9808-56ce-b22a-088ec1ae401f",
          "resultId": "d5d9be76-d835-5f30-bc13-ff94d2eff315",
          "participantId": "97929c70-218b-55c8-8be3-b5a83052c1e5",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Ruoxian Wu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 221026, Nat: CHN."
        },
        {
          "rank": 17,
          "sourceName": "Jemima Chang",
          "name": "Jemima Chang",
          "sailOrBoardNumber": "214636",
          "nationality": "SGP",
          "gender": "W",
          "grossScore": 179,
          "nettScore": 148,
          "races": [
            {
              "raceNumber": 1,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 2,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 3,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 4,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 5,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 6,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 7,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 8,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 9,
              "score": 31,
              "code": null,
              "discarded": true,
              "raw": "(31)"
            },
            {
              "raceNumber": 10,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            }
          ],
          "sailorId": "1ba65410-fa86-472d-ad75-bc510bffd07b",
          "resultId": "753da2b9-4be6-501c-aae3-aea106185431",
          "participantId": "a79f392e-9df2-5b25-9719-42c81d9d7104",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Jemima Chang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 214636, Nat: SGP."
        },
        {
          "rank": 18,
          "sourceName": "Qinyi Li",
          "name": "Qinyi Li",
          "sailOrBoardNumber": "223159",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 183,
          "nettScore": 148,
          "races": [
            {
              "raceNumber": 1,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 2,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 3,
              "score": 35,
              "code": null,
              "discarded": true,
              "raw": "(35)"
            },
            {
              "raceNumber": 4,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 5,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 6,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 7,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 8,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 9,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 10,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            }
          ],
          "sailorId": "c8b3175b-1b32-50de-8dc1-e72517d42c0e",
          "resultId": "7ac1eeb1-53de-5161-8ee0-cbae7a74f725",
          "participantId": "f93d3627-e44b-5a4b-9bc0-c7d28c09264c",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Qinyi Li",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 223159, Nat: CHN."
        },
        {
          "rank": 19,
          "sourceName": "Yongyi Chen",
          "name": "Yongyi Chen",
          "sailOrBoardNumber": "218671",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 222,
          "nettScore": 169,
          "races": [
            {
              "raceNumber": 1,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 2,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 3,
              "score": 53,
              "code": "DSQ",
              "discarded": true,
              "raw": "(53 DSQ)"
            },
            {
              "raceNumber": 4,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 5,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 6,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 7,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 8,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 9,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 10,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            }
          ],
          "sailorId": "9f8ac816-e8cf-5f65-b065-75cc967b6842",
          "resultId": "06298cff-10b1-5038-b353-4db4b82d2bd3",
          "participantId": "e91980ab-0855-5a71-9b6e-4975aa6f9e3e",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yongyi Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 218671, Nat: CHN."
        },
        {
          "rank": 20,
          "sourceName": "Howan Luo",
          "name": "Howan Luo",
          "sailOrBoardNumber": "210425",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 225,
          "nettScore": 183,
          "races": [
            {
              "raceNumber": 1,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 2,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 3,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 4,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 5,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 6,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 7,
              "score": 42,
              "code": null,
              "discarded": true,
              "raw": "(42)"
            },
            {
              "raceNumber": 8,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 9,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 10,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            }
          ],
          "sailorId": "0d4bf218-dbe4-5785-9f8f-0a5efe900408",
          "resultId": "6293d3fc-ca37-55b3-8784-2e47615a611f",
          "participantId": "165901fe-fb3a-5573-9109-8812ff37248c",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (CHN) match in database",
          "sourceNationality": "CHN",
          "officialName": "Howan Luo",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 210425, Nat: CHN."
        },
        {
          "rank": 21,
          "sourceName": "Luo Yi",
          "name": "Luo Yi",
          "sailOrBoardNumber": "220343",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 242,
          "nettScore": 189,
          "races": [
            {
              "raceNumber": 1,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 2,
              "score": 53,
              "code": "UFD",
              "discarded": true,
              "raw": "(53 UFD)"
            },
            {
              "raceNumber": 3,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 4,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 5,
              "score": 53,
              "code": "BFD",
              "discarded": false,
              "raw": "53 BFD"
            },
            {
              "raceNumber": 6,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 7,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 8,
              "score": 53,
              "code": "UFD",
              "discarded": false,
              "raw": "53 UFD"
            },
            {
              "raceNumber": 9,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 10,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            }
          ],
          "sailorId": "4199028f-a4dc-5a9b-9b33-e7e208ab9191",
          "resultId": "152897ce-3338-5338-8fcd-ac10628445bf",
          "participantId": "a765eb49-39a2-5a2e-aa79-f2902c4a1260",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Luo Yi",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 220343, Nat: CHN."
        },
        {
          "rank": 22,
          "sourceName": "Nicholette Lee",
          "name": "Nicholette Lee",
          "sailOrBoardNumber": "197833",
          "nationality": "SGP",
          "gender": "W",
          "grossScore": 225,
          "nettScore": 190,
          "races": [
            {
              "raceNumber": 1,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 2,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 3,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 4,
              "score": 35,
              "code": null,
              "discarded": true,
              "raw": "(35)"
            },
            {
              "raceNumber": 5,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 6,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 7,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 8,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 9,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 10,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            }
          ],
          "sailorId": "37d98dd9-3749-45ce-8195-c1b9cce74f60",
          "resultId": "7b1cb544-6b6a-5952-8341-78dd51c29aea",
          "participantId": "cc71c960-33af-5295-af77-bc0980218e06",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Nicholette Lee",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 197833, Nat: SGP."
        },
        {
          "rank": 23,
          "sourceName": "Li Huang",
          "name": "Li Huang",
          "sailOrBoardNumber": "219989",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 255,
          "nettScore": 202,
          "races": [
            {
              "raceNumber": 1,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 2,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 3,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 4,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 5,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 6,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 7,
              "score": 53,
              "code": "BFD",
              "discarded": true,
              "raw": "(53 BFD)"
            },
            {
              "raceNumber": 8,
              "score": 53,
              "code": "UFD",
              "discarded": false,
              "raw": "53 UFD"
            },
            {
              "raceNumber": 9,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 10,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            }
          ],
          "sailorId": "d1b87ec8-57e4-5173-9da2-9cc80de2bb8c",
          "resultId": "a2e82ce7-24d2-5b51-85d6-2d356898cb27",
          "participantId": "1cf6749e-474a-5614-88fc-23b343ac2193",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Li Huang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 219989, Nat: CHN."
        },
        {
          "rank": 24,
          "sourceName": "Nur Hafizanah Zailan",
          "name": "Nur Hafizanah Zailan",
          "sailOrBoardNumber": "209891",
          "nationality": "MAS",
          "gender": "W",
          "grossScore": 270,
          "nettScore": 217,
          "races": [
            {
              "raceNumber": 1,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 2,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 3,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 4,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 5,
              "score": 53,
              "code": "BFD",
              "discarded": true,
              "raw": "(53 BFD)"
            },
            {
              "raceNumber": 6,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 7,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 8,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 9,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 10,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            }
          ],
          "sailorId": "335322d5-f04d-59a2-8403-03e5c5ea19a5",
          "resultId": "6bf6eb0b-873e-52f3-a099-ca517d4ed1c8",
          "participantId": "17e46ba8-badb-54cd-80ee-d4740f6820e3",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "MAS",
          "officialName": "Nur Hafizanah Zailan",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 209891, Nat: MAS."
        },
        {
          "rank": 25,
          "sourceName": "Jui-Hsuan Chen",
          "name": "Jui-Hsuan Chen",
          "sailOrBoardNumber": "210476",
          "nationality": "TPE",
          "gender": "W",
          "grossScore": 264,
          "nettScore": 221,
          "races": [
            {
              "raceNumber": 1,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 2,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 3,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 4,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 5,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 6,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 7,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 8,
              "score": 43,
              "code": null,
              "discarded": true,
              "raw": "(43)"
            },
            {
              "raceNumber": 9,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 10,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            }
          ],
          "sailorId": "ca255c9c-bebe-5992-8f15-1debf2701811",
          "resultId": "44ca58a5-f9aa-5d44-ad4d-e7d4f16cba1b",
          "participantId": "a8b2895c-2da1-57bd-956d-bfb3df6b3086",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "TPE",
          "officialName": "Jui-Hsuan Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 210476, Nat: TPE."
        },
        {
          "rank": 26,
          "sourceName": "Wenxing Cheng",
          "name": "Wenxing Cheng",
          "sailOrBoardNumber": "217807",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 269,
          "nettScore": 223,
          "races": [
            {
              "raceNumber": 1,
              "score": 45,
              "code": null,
              "discarded": false,
              "raw": "45"
            },
            {
              "raceNumber": 2,
              "score": 46,
              "code": null,
              "discarded": true,
              "raw": "(46)"
            },
            {
              "raceNumber": 3,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 4,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 5,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 6,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 7,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 8,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 9,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 10,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            }
          ],
          "sailorId": "a748849b-bfa8-5666-8471-7e3286774b63",
          "resultId": "80ad2086-635f-5035-8f41-cfed120961c4",
          "participantId": "55c9a311-ad62-5dc1-a295-09d78c67ca2f",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Wenxing Cheng",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 217807, Nat: CHN."
        },
        {
          "rank": 27,
          "sourceName": "Ela Murat",
          "name": "Ela Murat",
          "sailOrBoardNumber": "205828",
          "nationality": "HKG",
          "gender": "W",
          "grossScore": 281,
          "nettScore": 228,
          "races": [
            {
              "raceNumber": 1,
              "score": 48,
              "code": null,
              "discarded": false,
              "raw": "48"
            },
            {
              "raceNumber": 2,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 3,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 4,
              "score": 53,
              "code": "DSQ",
              "discarded": true,
              "raw": "(53 DSQ)"
            },
            {
              "raceNumber": 5,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 6,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 7,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 8,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 9,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 10,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            }
          ],
          "sailorId": "ad6fa7a4-fafc-4dc8-8bd7-92fcb8e39a0d",
          "resultId": "b7213093-7ee6-558b-b983-065b07b7f0f0",
          "participantId": "31f25632-6c1f-5803-a65e-8ba77067c59c",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (HKG) match in database",
          "sourceNationality": "HKG",
          "officialName": "Ela Murat",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 205828, Nat: HKG."
        },
        {
          "rank": 28,
          "sourceName": "Maanya Reddy",
          "name": "Maanya Reddy",
          "sailOrBoardNumber": "209907",
          "nationality": "IND",
          "gender": "W",
          "grossScore": 281,
          "nettScore": 228,
          "races": [
            {
              "raceNumber": 1,
              "score": 46,
              "code": null,
              "discarded": false,
              "raw": "46"
            },
            {
              "raceNumber": 2,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 3,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 4,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 5,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 6,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 7,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 8,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 9,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 10,
              "score": 53,
              "code": "DSQ",
              "discarded": true,
              "raw": "(53 DSQ)"
            }
          ],
          "sailorId": "a7b69130-87f2-59ad-a0bb-c8f5bcd3f4c8",
          "resultId": "7d657fda-1c6b-5fe9-b537-8f92cea071ce",
          "participantId": "8b91f39c-209e-55a1-9462-9f5a631ee5f7",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "IND",
          "officialName": "Maanya Reddy",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 209907, Nat: IND."
        },
        {
          "rank": 29,
          "sourceName": "Marwa Alhammadi",
          "name": "Marwa Alhammadi",
          "sailOrBoardNumber": "207914",
          "nationality": "UAE",
          "gender": "W",
          "grossScore": 277,
          "nettScore": 235,
          "races": [
            {
              "raceNumber": 1,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 2,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 3,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 4,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 5,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 6,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 7,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 8,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 9,
              "score": 42,
              "code": null,
              "discarded": true,
              "raw": "(42)"
            },
            {
              "raceNumber": 10,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            }
          ],
          "sailorId": "157c0b9e-a4af-4e48-9429-1570688c6333",
          "resultId": "c007ed92-913c-5cba-ba04-2d004e220793",
          "participantId": "9e16c27e-ef00-59a9-9e93-5a278ed10430",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (UAE) match in database",
          "sourceNationality": "UAE",
          "officialName": "Marwa Alhammadi",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 207914, Nat: UAE."
        },
        {
          "rank": 30,
          "sourceName": "Yinping Huang",
          "name": "Yinping Huang",
          "sailOrBoardNumber": "220312",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 288,
          "nettScore": 240,
          "races": [
            {
              "raceNumber": 1,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 2,
              "score": 48,
              "code": null,
              "discarded": true,
              "raw": "(48)"
            },
            {
              "raceNumber": 3,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 4,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 5,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 6,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 7,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 8,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 9,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 10,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            }
          ],
          "sailorId": "fa5c9979-8c33-5788-bd9f-2587309397ad",
          "resultId": "fdba8813-4be7-5d76-af02-d8123f23e4a0",
          "participantId": "0179c56b-de4b-5804-b95b-ac9ab1073b6b",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yinping Huang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 220312, Nat: CHN."
        },
        {
          "rank": 31,
          "sourceName": "Ivy So",
          "name": "Ivy So",
          "sailOrBoardNumber": "209310",
          "nationality": "HKG",
          "gender": "W",
          "grossScore": 288,
          "nettScore": 246,
          "races": [
            {
              "raceNumber": 1,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 2,
              "score": 42,
              "code": null,
              "discarded": true,
              "raw": "(42)"
            },
            {
              "raceNumber": 3,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 4,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 5,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 6,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 7,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 8,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 9,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 10,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            }
          ],
          "sailorId": "34454af4-f43d-45d4-aea1-01ff9c354cb9",
          "resultId": "3b236cdd-3ff8-549d-9d34-102aa704a534",
          "participantId": "8acb3059-da1b-574b-8682-eda4341cbf5d",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (HKG) match in database",
          "sourceNationality": "HKG",
          "officialName": "Ivy So",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 209310, Nat: HKG."
        },
        {
          "rank": 32,
          "sourceName": "Yunru Zhang",
          "name": "Yunru Zhang",
          "sailOrBoardNumber": "221904",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 306,
          "nettScore": 263,
          "races": [
            {
              "raceNumber": 1,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 2,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 3,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 4,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 5,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 6,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 7,
              "score": 43,
              "code": null,
              "discarded": true,
              "raw": "(43)"
            },
            {
              "raceNumber": 8,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 9,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 10,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            }
          ],
          "sailorId": "831e3e52-4c88-53b8-ac69-7a0ab3d96476",
          "resultId": "44ff3083-f78e-5178-8651-8cbcf2939098",
          "participantId": "59f447af-e5c6-5a66-8519-c53bc5ab56c5",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yunru Zhang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 221904, Nat: CHN."
        },
        {
          "rank": 33,
          "sourceName": "Shirley Ma",
          "name": "Shirley Ma",
          "sailOrBoardNumber": "146692",
          "nationality": "JPN",
          "gender": "W",
          "grossScore": 315,
          "nettScore": 270,
          "races": [
            {
              "raceNumber": 1,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 2,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 3,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 4,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 5,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 6,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 7,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 8,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 9,
              "score": 45,
              "code": null,
              "discarded": true,
              "raw": "(45)"
            },
            {
              "raceNumber": 10,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            }
          ],
          "sailorId": "9a6ab4fb-5243-5a4b-9875-7c28210963f2",
          "resultId": "c3aa7c0c-7a11-5bf3-be09-25ea30b43d1f",
          "participantId": "c32cd935-2efa-553d-a4fb-5f9cd3389a63",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "JPN",
          "officialName": "Shirley Ma",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 146692, Nat: JPN."
        },
        {
          "rank": 34,
          "sourceName": "Chengjin Yi",
          "name": "Chengjin Yi",
          "sailOrBoardNumber": "210368",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 328,
          "nettScore": 288,
          "races": [
            {
              "raceNumber": 1,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 2,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 3,
              "score": 40,
              "code": null,
              "discarded": true,
              "raw": "(40)"
            },
            {
              "raceNumber": 4,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 5,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 6,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 7,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 8,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 9,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 10,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            }
          ],
          "sailorId": "564035e5-db60-598e-9f1e-66ff281b6a55",
          "resultId": "0d33c76a-73a6-5fa1-a06e-bad39dcfc1fa",
          "participantId": "3d916133-5014-5494-abd0-a080934eb500",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Chengjin Yi",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 210368, Nat: CHN."
        },
        {
          "rank": 35,
          "sourceName": "Zhenghan Wang",
          "name": "Zhenghan Wang",
          "sailOrBoardNumber": "221551",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 353,
          "nettScore": 300,
          "races": [
            {
              "raceNumber": 1,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 2,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            },
            {
              "raceNumber": 3,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 4,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 5,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 6,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 7,
              "score": 46,
              "code": null,
              "discarded": false,
              "raw": "46"
            },
            {
              "raceNumber": 8,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 9,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 10,
              "score": 53,
              "code": "UFD",
              "discarded": true,
              "raw": "(53 UFD)"
            }
          ],
          "sailorId": "912d07b2-7e5a-51a2-80e4-be52393a3bcd",
          "resultId": "7e3553fa-cfc2-521b-a32f-be94ff8a51d4",
          "participantId": "1155b56a-c606-5ac2-9f61-60d677c37de1",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Zhenghan Wang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 221551, Nat: CHN."
        },
        {
          "rank": 36,
          "sourceName": "Peixuan Sun",
          "name": "Peixuan Sun",
          "sailOrBoardNumber": "222292",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 346,
          "nettScore": 305,
          "races": [
            {
              "raceNumber": 1,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 2,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 3,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 4,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 5,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 6,
              "score": 41,
              "code": null,
              "discarded": true,
              "raw": "(41)"
            },
            {
              "raceNumber": 7,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 8,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 9,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 10,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            }
          ],
          "sailorId": "cc8ae5de-5c68-5cff-98da-fb7e571162c8",
          "resultId": "f22e1ba8-ad61-59fc-90f9-697318750041",
          "participantId": "bcc6733c-e2cd-51c1-9672-4756193c7397",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Peixuan Sun",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 222292, Nat: CHN."
        },
        {
          "rank": 37,
          "sourceName": "Li Xuan Milderd Wong",
          "name": "Li Xuan Milderd Wong",
          "sailOrBoardNumber": "223200",
          "nationality": "SGP",
          "gender": "W",
          "grossScore": 358,
          "nettScore": 317,
          "races": [
            {
              "raceNumber": 1,
              "score": 41,
              "code": null,
              "discarded": true,
              "raw": "(41)"
            },
            {
              "raceNumber": 2,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 3,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 4,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 5,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 6,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 7,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 8,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 9,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 10,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            }
          ],
          "sailorId": "32aef090-8053-5bb6-8100-0b44a692a2b0",
          "resultId": "eadc4834-a908-592f-8a53-307cf6b62308",
          "participantId": "44c68c7c-bcc0-5b46-9907-f5eae5946d71",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "SGP",
          "officialName": "Li Xuan Milderd Wong",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 223200, Nat: SGP."
        },
        {
          "rank": 38,
          "sourceName": "Yufei Chen",
          "name": "Yufei Chen",
          "sailOrBoardNumber": "210816",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 371,
          "nettScore": 318,
          "races": [
            {
              "raceNumber": 1,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 2,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 3,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 4,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 5,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 6,
              "score": 53,
              "code": "DNF",
              "discarded": true,
              "raw": "(53 DNF)"
            },
            {
              "raceNumber": 7,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 8,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 9,
              "score": 53,
              "code": "DNC",
              "discarded": false,
              "raw": "53 DNC"
            },
            {
              "raceNumber": 10,
              "score": 53,
              "code": "DNC",
              "discarded": false,
              "raw": "53 DNC"
            }
          ],
          "sailorId": "bd3f9394-9eb2-47c0-8c60-2b5cc89359fd",
          "resultId": "6f20b8b8-9926-5454-be1c-7bcb13f41b7f",
          "participantId": "6e30751a-465a-5887-89ca-3f5c1e02416d",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (CHN) match in database",
          "sourceNationality": "CHN",
          "officialName": "Yufei Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 210816, Nat: CHN."
        },
        {
          "rank": 39,
          "sourceName": "Guo Yuan",
          "name": "Guo Yuan",
          "sailOrBoardNumber": "219181",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 371,
          "nettScore": 318,
          "races": [
            {
              "raceNumber": 1,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 2,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 3,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 4,
              "score": 53,
              "code": "RET",
              "discarded": true,
              "raw": "(53 RET)"
            },
            {
              "raceNumber": 5,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 6,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 7,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 8,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 9,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 10,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            }
          ],
          "sailorId": "612c9d98-1eb6-58ca-b38b-dd5e265b32b3",
          "resultId": "3954e1eb-5bda-5d34-af2e-55f270e1b321",
          "participantId": "50f452d8-0e3a-5375-bbd7-a0a37ffbfd11",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Guo Yuan",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 219181, Nat: CHN."
        },
        {
          "rank": 40,
          "sourceName": "Zihan Tang",
          "name": "Zihan Tang",
          "sailOrBoardNumber": "205955",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 373,
          "nettScore": 325,
          "races": [
            {
              "raceNumber": 1,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 2,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 3,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 4,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 5,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 6,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 7,
              "score": 48,
              "code": null,
              "discarded": true,
              "raw": "(48)"
            },
            {
              "raceNumber": 8,
              "score": 45,
              "code": null,
              "discarded": false,
              "raw": "45"
            },
            {
              "raceNumber": 9,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 10,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            }
          ],
          "sailorId": "27ae7a69-b946-5f11-8e82-d9ae359687e6",
          "resultId": "d469a3f6-9281-52be-9c5a-46c93950485a",
          "participantId": "85431fbc-99ec-5ca4-a4e0-8eb6bff80fbe",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Zihan Tang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 205955, Nat: CHN."
        },
        {
          "rank": 41,
          "sourceName": "Ruihan Chen",
          "name": "Ruihan Chen",
          "sailOrBoardNumber": "214453",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 372,
          "nettScore": 325,
          "races": [
            {
              "raceNumber": 1,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 2,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 3,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            },
            {
              "raceNumber": 4,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 5,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 6,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 7,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 8,
              "score": 47,
              "code": null,
              "discarded": true,
              "raw": "(47)"
            },
            {
              "raceNumber": 9,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 10,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            }
          ],
          "sailorId": "5cd84010-dcdf-5676-b97b-6b5958db5f3c",
          "resultId": "1ef49ec9-cc9f-5287-b341-43ca2cc55827",
          "participantId": "73320dfc-e704-5a58-995d-fe7aca628257",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Ruihan Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 214453, Nat: CHN."
        },
        {
          "rank": 42,
          "sourceName": "Alyazya Alhammadi",
          "name": "Alyazya Alhammadi",
          "sailOrBoardNumber": "207891",
          "nationality": "UAE",
          "gender": "W",
          "grossScore": 371,
          "nettScore": 326,
          "races": [
            {
              "raceNumber": 1,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 2,
              "score": 45,
              "code": null,
              "discarded": true,
              "raw": "(45)"
            },
            {
              "raceNumber": 3,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 4,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 5,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 6,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            },
            {
              "raceNumber": 7,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 8,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 9,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 10,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            }
          ],
          "sailorId": "5f14d7c9-dc29-5dcc-af50-065637d5730d",
          "resultId": "d3393546-5914-5ffd-a6d1-a2a269f2bf6d",
          "participantId": "bd9bae18-69e4-50b1-8b1c-6a2f8f508da0",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "UAE",
          "officialName": "Alyazya Alhammadi",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 207891, Nat: UAE."
        },
        {
          "rank": 43,
          "sourceName": "Huixia Fu",
          "name": "Huixia Fu",
          "sailOrBoardNumber": "220323",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 398,
          "nettScore": 345,
          "races": [
            {
              "raceNumber": 1,
              "score": 53,
              "code": "DNF",
              "discarded": true,
              "raw": "(53 DNF)"
            },
            {
              "raceNumber": 2,
              "score": 53,
              "code": "UFD",
              "discarded": false,
              "raw": "53 UFD"
            },
            {
              "raceNumber": 3,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 4,
              "score": 46,
              "code": null,
              "discarded": false,
              "raw": "46"
            },
            {
              "raceNumber": 5,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 6,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 7,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 8,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 9,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 10,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            }
          ],
          "sailorId": "6dd80388-c0cd-507a-926b-06f08260adf3",
          "resultId": "75d314bb-6777-56c6-920d-6f6a3ededf06",
          "participantId": "f9a33324-2fb3-5233-a503-3d9e754acb4c",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Huixia Fu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 220323, Nat: CHN."
        },
        {
          "rank": 44,
          "sourceName": "Xiaoyou Pan",
          "name": "Xiaoyou Pan",
          "sailOrBoardNumber": "223615",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 413,
          "nettScore": 360,
          "races": [
            {
              "raceNumber": 1,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 2,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 3,
              "score": 48,
              "code": null,
              "discarded": false,
              "raw": "48"
            },
            {
              "raceNumber": 4,
              "score": 49,
              "code": null,
              "discarded": false,
              "raw": "49"
            },
            {
              "raceNumber": 5,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 6,
              "score": 47,
              "code": null,
              "discarded": false,
              "raw": "47"
            },
            {
              "raceNumber": 7,
              "score": 49,
              "code": null,
              "discarded": false,
              "raw": "49"
            },
            {
              "raceNumber": 8,
              "score": 53,
              "code": "RET",
              "discarded": true,
              "raw": "(53 RET)"
            },
            {
              "raceNumber": 9,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            },
            {
              "raceNumber": 10,
              "score": 47,
              "code": null,
              "discarded": false,
              "raw": "47"
            }
          ],
          "sailorId": "92d3a445-ad48-5c1f-b990-1d574359bb47",
          "resultId": "e9e3f5eb-154a-5448-b1a0-9194b25bb1b9",
          "participantId": "bc552620-aeba-5e42-953c-5c2e2a8d54d4",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Xiaoyou Pan",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 223615, Nat: CHN."
        },
        {
          "rank": 45,
          "sourceName": "Yujia Wang",
          "name": "Yujia Wang",
          "sailOrBoardNumber": "205966",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 416,
          "nettScore": 363,
          "races": [
            {
              "raceNumber": 1,
              "score": 53,
              "code": "NSC",
              "discarded": true,
              "raw": "(53 NSC)"
            },
            {
              "raceNumber": 2,
              "score": 53,
              "code": "DNC",
              "discarded": false,
              "raw": "53 DNC"
            },
            {
              "raceNumber": 3,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 4,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 5,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 6,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 7,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 8,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 9,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 10,
              "score": 45,
              "code": null,
              "discarded": false,
              "raw": "45"
            }
          ],
          "sailorId": "e3023b48-b403-5d59-96fd-243fe9fd9c1d",
          "resultId": "7a46cea2-671c-56ad-9616-8d27d8c5d6fe",
          "participantId": "1178a329-7288-5bc1-9ee5-eb829e02fb6c",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yujia Wang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 205966, Nat: CHN."
        },
        {
          "rank": 46,
          "sourceName": "Zihan Li",
          "name": "Zihan Li",
          "sailOrBoardNumber": "220227",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 414,
          "nettScore": 367,
          "races": [
            {
              "raceNumber": 1,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 2,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 3,
              "score": 45,
              "code": null,
              "discarded": false,
              "raw": "45"
            },
            {
              "raceNumber": 4,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 5,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            },
            {
              "raceNumber": 6,
              "score": 45,
              "code": null,
              "discarded": false,
              "raw": "45"
            },
            {
              "raceNumber": 7,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 8,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 9,
              "score": 47,
              "code": null,
              "discarded": true,
              "raw": "(47)"
            },
            {
              "raceNumber": 10,
              "score": 46,
              "code": null,
              "discarded": false,
              "raw": "46"
            }
          ],
          "sailorId": "b40bb781-84db-5e73-986a-d9e4dff68faf",
          "resultId": "9c89ced5-3550-5992-864e-6286563e8c98",
          "participantId": "f00fd947-b1dd-5108-9cd4-6b6caf09f75a",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Zihan Li",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 220227, Nat: CHN."
        },
        {
          "rank": 47,
          "sourceName": "Lyora Wallier",
          "name": "Lyora Wallier",
          "sailOrBoardNumber": "213316",
          "nationality": "HKG",
          "gender": "W",
          "grossScore": 436,
          "nettScore": 383,
          "races": [
            {
              "raceNumber": 1,
              "score": 53,
              "code": "NSC",
              "discarded": true,
              "raw": "(53 NSC)"
            },
            {
              "raceNumber": 2,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 3,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 4,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 5,
              "score": 45,
              "code": null,
              "discarded": false,
              "raw": "45"
            },
            {
              "raceNumber": 6,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 7,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 8,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 9,
              "score": 53,
              "code": "DNC",
              "discarded": false,
              "raw": "53 DNC"
            },
            {
              "raceNumber": 10,
              "score": 53,
              "code": "DNC",
              "discarded": false,
              "raw": "53 DNC"
            }
          ],
          "sailorId": "97b0d98e-9e2e-5917-b36e-798ef1440452",
          "resultId": "beadf6cb-257f-5d89-98aa-32fae57513b9",
          "participantId": "180212cc-e903-5d62-8390-9f1ba894c064",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "HKG",
          "officialName": "Lyora Wallier",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 213316, Nat: HKG."
        },
        {
          "rank": 48,
          "sourceName": "Yangzi Tang",
          "name": "Yangzi Tang",
          "sailOrBoardNumber": "218838",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 441,
          "nettScore": 388,
          "races": [
            {
              "raceNumber": 1,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 2,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 3,
              "score": 53,
              "code": "DNC",
              "discarded": true,
              "raw": "(53 DNC)"
            },
            {
              "raceNumber": 4,
              "score": 53,
              "code": "DNC",
              "discarded": false,
              "raw": "53 DNC"
            },
            {
              "raceNumber": 5,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 6,
              "score": 49,
              "code": null,
              "discarded": false,
              "raw": "49"
            },
            {
              "raceNumber": 7,
              "score": 47,
              "code": null,
              "discarded": false,
              "raw": "47"
            },
            {
              "raceNumber": 8,
              "score": 46,
              "code": null,
              "discarded": false,
              "raw": "46"
            },
            {
              "raceNumber": 9,
              "score": 48,
              "code": null,
              "discarded": false,
              "raw": "48"
            },
            {
              "raceNumber": 10,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            }
          ],
          "sailorId": "67c37232-0076-5dd1-a815-408b375a6318",
          "resultId": "c1d2ba50-5a08-5357-8b02-e42fa2b8ccce",
          "participantId": "f7ee214c-aac3-5ee7-bf17-6d7c60fba75a",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yangzi Tang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 218838, Nat: CHN."
        },
        {
          "rank": 49,
          "sourceName": "Linger Zhou",
          "name": "Linger Zhou",
          "sailOrBoardNumber": "221023",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 443,
          "nettScore": 390,
          "races": [
            {
              "raceNumber": 1,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            },
            {
              "raceNumber": 2,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 3,
              "score": 46,
              "code": null,
              "discarded": false,
              "raw": "46"
            },
            {
              "raceNumber": 4,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            },
            {
              "raceNumber": 5,
              "score": 53,
              "code": "RET",
              "discarded": true,
              "raw": "(53 RET)"
            },
            {
              "raceNumber": 6,
              "score": 53,
              "code": "DNC",
              "discarded": false,
              "raw": "53 DNC"
            },
            {
              "raceNumber": 7,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 8,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 9,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 10,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            }
          ],
          "sailorId": "aa564db6-5ef3-5666-a821-425146fc692e",
          "resultId": "5f6a243a-c670-51ce-b37d-b50d35ee4824",
          "participantId": "dc515de6-7932-5248-8256-a4972aae183d",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Linger Zhou",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 221023, Nat: CHN."
        },
        {
          "rank": 50,
          "sourceName": "Qinyu Shi",
          "name": "Qinyu Shi",
          "sailOrBoardNumber": "225006",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 449,
          "nettScore": 396,
          "races": [
            {
              "raceNumber": 1,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 2,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 3,
              "score": 50,
              "code": null,
              "discarded": false,
              "raw": "50"
            },
            {
              "raceNumber": 4,
              "score": 47,
              "code": null,
              "discarded": false,
              "raw": "47"
            },
            {
              "raceNumber": 5,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 6,
              "score": 48,
              "code": null,
              "discarded": false,
              "raw": "48"
            },
            {
              "raceNumber": 7,
              "score": 50,
              "code": null,
              "discarded": false,
              "raw": "50"
            },
            {
              "raceNumber": 8,
              "score": 53,
              "code": "RET",
              "discarded": true,
              "raw": "(53 RET)"
            },
            {
              "raceNumber": 9,
              "score": 50,
              "code": null,
              "discarded": false,
              "raw": "50"
            },
            {
              "raceNumber": 10,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            }
          ],
          "sailorId": "990d6b38-c385-53d8-afab-db4951744c8b",
          "resultId": "7f05ae07-1011-5e2a-a430-57115a3ed6e4",
          "participantId": "d134d28c-e66f-5154-a922-c9508aed20b4",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Qinyu Shi",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 225006, Nat: CHN."
        },
        {
          "rank": 51,
          "sourceName": "Wanzhi Elva Li",
          "name": "Wanzhi Elva Li",
          "sailOrBoardNumber": "220895",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 447,
          "nettScore": 400,
          "races": [
            {
              "raceNumber": 1,
              "score": 47,
              "code": null,
              "discarded": true,
              "raw": "(47)"
            },
            {
              "raceNumber": 2,
              "score": 47,
              "code": null,
              "discarded": false,
              "raw": "47"
            },
            {
              "raceNumber": 3,
              "score": 47,
              "code": null,
              "discarded": false,
              "raw": "47"
            },
            {
              "raceNumber": 4,
              "score": 45,
              "code": null,
              "discarded": false,
              "raw": "45"
            },
            {
              "raceNumber": 5,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 6,
              "score": 46,
              "code": null,
              "discarded": false,
              "raw": "46"
            },
            {
              "raceNumber": 7,
              "score": 45,
              "code": null,
              "discarded": false,
              "raw": "45"
            },
            {
              "raceNumber": 8,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 9,
              "score": 46,
              "code": null,
              "discarded": false,
              "raw": "46"
            },
            {
              "raceNumber": 10,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            }
          ],
          "sailorId": "440013f1-4689-54d6-b2cd-3509a58c1899",
          "resultId": "5b4a5af5-8b15-515f-80a2-096b754a4675",
          "participantId": "3a53993e-b9ed-5651-9247-6195568316ac",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Wanzhi Elva Li",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 220895, Nat: CHN."
        },
        {
          "rank": 52,
          "sourceName": "Xin Cai",
          "name": "Xin Cai",
          "sailOrBoardNumber": "225953",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 512,
          "nettScore": 459,
          "races": [
            {
              "raceNumber": 1,
              "score": 53,
              "code": "DNF",
              "discarded": true,
              "raw": "(53 DNF)"
            },
            {
              "raceNumber": 2,
              "score": 53,
              "code": "NSC",
              "discarded": false,
              "raw": "53 NSC"
            },
            {
              "raceNumber": 3,
              "score": 49,
              "code": null,
              "discarded": false,
              "raw": "49"
            },
            {
              "raceNumber": 4,
              "score": 48,
              "code": null,
              "discarded": false,
              "raw": "48"
            },
            {
              "raceNumber": 5,
              "score": 53,
              "code": "RET",
              "discarded": false,
              "raw": "53 RET"
            },
            {
              "raceNumber": 6,
              "score": 53,
              "code": "DNC",
              "discarded": false,
              "raw": "53 DNC"
            },
            {
              "raceNumber": 7,
              "score": 53,
              "code": "RET",
              "discarded": false,
              "raw": "53 RET"
            },
            {
              "raceNumber": 8,
              "score": 53,
              "code": "DNC",
              "discarded": false,
              "raw": "53 DNC"
            },
            {
              "raceNumber": 9,
              "score": 49,
              "code": null,
              "discarded": false,
              "raw": "49"
            },
            {
              "raceNumber": 10,
              "score": 48,
              "code": null,
              "discarded": false,
              "raw": "48"
            }
          ],
          "sailorId": "42aaac0f-69c3-5ad6-8a4b-f7979a533f29",
          "resultId": "c2f068b1-dd9f-579f-bf13-ef667f5ff566",
          "participantId": "b46d4f38-4d5c-548c-b5ad-4ca300af823e",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Xin Cai",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 4, Division: Youth Girls U18. Sail No: 225953, Nat: CHN."
        }
      ]
    },
    {
      "config": {
        "id": "b1a02024-a510-48e0-8003-000000000003",
        "slug": "2024-ilca-asian-open-championship-ilca6-men",
        "name": "2024 ILCA Asian Open Championship (ILCA 6 Men)",
        "boatClass": "ILCA 6",
        "division": "Men",
        "gender": "M",
        "raceCount": 10,
        "discardCount": 1,
        "entryType": "individual",
        "date": "2024-12-14",
        "endDate": "2024-12-20"
      },
      "results": [
        {
          "rank": 1,
          "sourceName": "Weijie Zheng",
          "name": "Weijie Zheng",
          "sailOrBoardNumber": "218527",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 24,
          "nettScore": 15,
          "races": [
            {
              "raceNumber": 1,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 2,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 3,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 4,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 5,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 6,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 7,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 8,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 9,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 10,
              "score": 9,
              "code": null,
              "discarded": true,
              "raw": "(9)"
            }
          ],
          "sailorId": "f560f344-f301-5698-bdf2-efa8a44a7238",
          "resultId": "33241193-e5ff-56d2-9826-61bae9471774",
          "participantId": "590337f0-ff38-512b-98b7-9b32f0c16a58",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Weijie Zheng",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 218527, Nat: CHN."
        },
        {
          "rank": 2,
          "sourceName": "Jiahua Liu",
          "name": "Jiahua Liu",
          "sailOrBoardNumber": "211512",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 46,
          "nettScore": 33,
          "races": [
            {
              "raceNumber": 1,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 2,
              "score": 13,
              "code": null,
              "discarded": true,
              "raw": "(13)"
            },
            {
              "raceNumber": 3,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 4,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 5,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 6,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 7,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 8,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 9,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 10,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            }
          ],
          "sailorId": "23401c6b-c3bd-5f81-9cf7-1e944f8c5468",
          "resultId": "990045d4-4711-500a-96bb-52852376764d",
          "participantId": "720e82a3-9567-5db6-a94d-7a7dd7462ab9",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Jiahua Liu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 211512, Nat: CHN."
        },
        {
          "rank": 3,
          "sourceName": "Qing Long Li",
          "name": "Qing Long Li",
          "sailOrBoardNumber": "220428",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 57,
          "nettScore": 39,
          "races": [
            {
              "raceNumber": 1,
              "score": 18,
              "code": null,
              "discarded": true,
              "raw": "(18)"
            },
            {
              "raceNumber": 2,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 3,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 4,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 5,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 6,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 7,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 8,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 9,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 10,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            }
          ],
          "sailorId": "a80cdab4-770a-5926-aa56-e56ac7a1a5c1",
          "resultId": "ae0622d1-59a3-5af3-b71e-e421adf72db6",
          "participantId": "e2b6cfdd-abf1-5e0a-8559-151dad106f09",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Qing Long Li",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 220428, Nat: CHN."
        },
        {
          "rank": 4,
          "sourceName": "Yebin Guo",
          "name": "Yebin Guo",
          "sailOrBoardNumber": "211516",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 51,
          "nettScore": 43,
          "races": [
            {
              "raceNumber": 1,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 2,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 3,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 4,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 5,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 6,
              "score": 8,
              "code": null,
              "discarded": true,
              "raw": "(8)"
            },
            {
              "raceNumber": 7,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 8,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 9,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 10,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            }
          ],
          "sailorId": "ece31428-b9e2-5ba4-b5d6-79e4f7b84dd7",
          "resultId": "e53babe2-b611-5f05-9784-6b7839f10b61",
          "participantId": "0e254fb0-b3d9-5a97-855d-1be1694c9da2",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yebin Guo",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 211516, Nat: CHN."
        },
        {
          "rank": 5,
          "sourceName": "Isaac Goh",
          "name": "Isaac Goh",
          "sailOrBoardNumber": "219158",
          "nationality": "SGP",
          "gender": "M",
          "grossScore": 54,
          "nettScore": 45,
          "races": [
            {
              "raceNumber": 1,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 2,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 3,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 4,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 5,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 6,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 7,
              "score": 9,
              "code": null,
              "discarded": true,
              "raw": "(9)"
            },
            {
              "raceNumber": 8,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 9,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 10,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            }
          ],
          "sailorId": "93fc1c81-1ec7-4600-b9a1-bc613d11449c",
          "resultId": "e80b80b8-e0f4-5f3b-b9df-b87c930e0b5f",
          "participantId": "c8c097a9-e6c5-56fe-92d9-f000b6afba79",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Isaac Goh",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 219158, Nat: SGP."
        },
        {
          "rank": 6,
          "sourceName": "Weka Bhanubandh",
          "name": "Weka Bhanubandh",
          "sailOrBoardNumber": "222277",
          "nationality": "THA",
          "gender": "M",
          "grossScore": 67,
          "nettScore": 57,
          "races": [
            {
              "raceNumber": 1,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 2,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 3,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 4,
              "score": 10,
              "code": null,
              "discarded": true,
              "raw": "(10)"
            },
            {
              "raceNumber": 5,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 6,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 7,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 8,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 9,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 10,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            }
          ],
          "sailorId": "ecf12b3f-820d-4827-ba12-4bff8f22c012",
          "resultId": "f0100657-69c9-5f12-b9bc-cdde4f32bebf",
          "participantId": "ab1fd77d-f931-552c-8376-cbb3cb6a8058",
          "isNewProfile": false,
          "identityBasis": "Corroborated international championship athlete identity",
          "sourceNationality": "THA",
          "officialName": "Weka Bhanubandh",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 222277, Nat: THA."
        },
        {
          "rank": 7,
          "sourceName": "Khalid Adil",
          "name": "Khalid Adil",
          "sailOrBoardNumber": "180000",
          "nationality": "UAE",
          "gender": "M",
          "grossScore": 81,
          "nettScore": 69,
          "races": [
            {
              "raceNumber": 1,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 2,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 3,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 4,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 5,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 6,
              "score": 12,
              "code": null,
              "discarded": true,
              "raw": "(12)"
            },
            {
              "raceNumber": 7,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 8,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 9,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 10,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            }
          ],
          "sailorId": "345609dc-15c1-5937-9de0-c6f0ec61db0e",
          "resultId": "12dc53ce-9096-56da-95e8-27683188b5fb",
          "participantId": "8d50da4b-6413-5a55-9ca5-5395c42050bf",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "UAE",
          "officialName": "Khalid Adil",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 180000, Nat: UAE."
        },
        {
          "rank": 8,
          "sourceName": "Lucas Collin",
          "name": "Lucas Collin",
          "sailOrBoardNumber": "222252",
          "nationality": "THA",
          "gender": "M",
          "grossScore": 82,
          "nettScore": 71,
          "races": [
            {
              "raceNumber": 1,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 2,
              "score": 11,
              "code": null,
              "discarded": true,
              "raw": "(11)"
            },
            {
              "raceNumber": 3,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 4,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 5,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 6,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 7,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 8,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 9,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 10,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            }
          ],
          "sailorId": "a0c43406-eac5-5b58-9e94-684f1644e454",
          "resultId": "fa6825ee-5879-5654-b05e-0ecc9f60271e",
          "participantId": "4fb478c8-aeaf-558c-af39-d1a45d8d82bc",
          "isNewProfile": false,
          "identityBasis": "Corroborated international championship athlete identity",
          "sourceNationality": "THA",
          "officialName": "Lucas Collin",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 222252, Nat: THA."
        },
        {
          "rank": 9,
          "sourceName": "Kenan Kee Zen Tan",
          "name": "Kenan Kee Zen Tan",
          "sailOrBoardNumber": "221060",
          "nationality": "SGP",
          "gender": "M",
          "grossScore": 114,
          "nettScore": 97,
          "races": [
            {
              "raceNumber": 1,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 2,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 3,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 4,
              "score": 17,
              "code": null,
              "discarded": true,
              "raw": "(17)"
            },
            {
              "raceNumber": 5,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 6,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 7,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 8,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 9,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 10,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            }
          ],
          "sailorId": "7baafbd0-cddb-4217-9727-a692f6902b79",
          "resultId": "90ec5d66-8082-5e24-a20f-f88b4d35af3b",
          "participantId": "60fc1c6e-cc84-557d-985d-546ef676930e",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Kenan Kee Zen Tan",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 221060, Nat: SGP."
        },
        {
          "rank": 10,
          "sourceName": "Daniel Chan",
          "name": "Daniel Chan",
          "sailOrBoardNumber": "223750",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 134,
          "nettScore": 101,
          "races": [
            {
              "raceNumber": 1,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 2,
              "score": 33,
              "code": "DSQ",
              "discarded": true,
              "raw": "(33 DSQ)"
            },
            {
              "raceNumber": 3,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 4,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 5,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 6,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 7,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 8,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 9,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 10,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            }
          ],
          "sailorId": "9fb849be-bfc1-5c19-b827-f95a2c775fc4",
          "resultId": "2694f3c6-c959-56fe-a102-1e3dd42efc63",
          "participantId": "8903e156-02f5-5af2-b91a-a294b99c6f5f",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "HKG",
          "officialName": "Daniel Chan",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 223750, Nat: HKG."
        },
        {
          "rank": 11,
          "sourceName": "Yukun Chen",
          "name": "Yukun Chen",
          "sailOrBoardNumber": "200800",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 146,
          "nettScore": 124,
          "races": [
            {
              "raceNumber": 1,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 2,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 3,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 4,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 5,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 6,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 7,
              "score": 22,
              "code": null,
              "discarded": true,
              "raw": "(22)"
            },
            {
              "raceNumber": 8,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 9,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 10,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            }
          ],
          "sailorId": "7ad0d090-eb1c-5d17-a999-67f811ab3def",
          "resultId": "a8fe200e-093a-5110-a6aa-d95387095134",
          "participantId": "9429e904-2918-581e-9841-20f633990178",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yukun Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 200800, Nat: CHN."
        },
        {
          "rank": 12,
          "sourceName": "Waixiang Yang",
          "name": "Waixiang Yang",
          "sailOrBoardNumber": "221511",
          "nationality": "TPE",
          "gender": "M",
          "grossScore": 150,
          "nettScore": 128,
          "races": [
            {
              "raceNumber": 1,
              "score": 22,
              "code": null,
              "discarded": true,
              "raw": "(22)"
            },
            {
              "raceNumber": 2,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 3,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 4,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 5,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 6,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 7,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 8,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 9,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 10,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            }
          ],
          "sailorId": "30fc62cd-a394-5f7f-93fa-ace8448becb6",
          "resultId": "994d6cb7-222b-5ef6-9e5d-21ebe671f882",
          "participantId": "9925ff58-6bbe-5aa0-9cd8-4b5b95ca0320",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "TPE",
          "officialName": "Waixiang Yang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 221511, Nat: TPE."
        },
        {
          "rank": 13,
          "sourceName": "Seb Willem Van Ommeren",
          "name": "Seb Willem Van Ommeren",
          "sailOrBoardNumber": "209319",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 169,
          "nettScore": 146,
          "races": [
            {
              "raceNumber": 1,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 2,
              "score": 23,
              "code": null,
              "discarded": true,
              "raw": "(23)"
            },
            {
              "raceNumber": 3,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 4,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 5,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 6,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 7,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 8,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 9,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 10,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            }
          ],
          "sailorId": "cd7162ae-a396-557c-ae56-2be3ccaac7c3",
          "resultId": "ceaa740c-6db0-57bc-8399-134592b4e744",
          "participantId": "04f22ac7-4469-532d-b451-3929af70fb79",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "HKG",
          "officialName": "Seb Willem Van Ommeren",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 209319, Nat: HKG."
        },
        {
          "rank": 14,
          "sourceName": "Yutong Cai",
          "name": "Yutong Cai",
          "sailOrBoardNumber": "221545",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 190,
          "nettScore": 157,
          "races": [
            {
              "raceNumber": 1,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 2,
              "score": 33,
              "code": "DNF",
              "discarded": true,
              "raw": "(33 DNF)"
            },
            {
              "raceNumber": 3,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 4,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 5,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 6,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 7,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 8,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 9,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 10,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            }
          ],
          "sailorId": "7b2c8ce4-104a-5776-a9cd-728b6bb13061",
          "resultId": "d0284c65-50d2-58e3-8f3f-4b9ac31fede6",
          "participantId": "bbca0bc0-eb6d-5f4e-9f6b-8087ee8af728",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yutong Cai",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 221545, Nat: CHN."
        },
        {
          "rank": 15,
          "sourceName": "Xiuren Yu",
          "name": "Xiuren Yu",
          "sailOrBoardNumber": "223613",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 188,
          "nettScore": 164,
          "races": [
            {
              "raceNumber": 1,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 2,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 3,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 4,
              "score": 24,
              "code": null,
              "discarded": true,
              "raw": "(24)"
            },
            {
              "raceNumber": 5,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 6,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 7,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 8,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 9,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 10,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            }
          ],
          "sailorId": "a06803b2-2aba-5631-bf0d-9048b4b7aef3",
          "resultId": "1572fed2-db06-56d9-8780-1f8cb4ccf0a4",
          "participantId": "a33f75e4-9cc1-5234-9429-69dc11da3a4a",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Xiuren Yu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 223613, Nat: CHN."
        },
        {
          "rank": 16,
          "sourceName": "Ruan Alexeyenko",
          "name": "Ruan Alexeyenko",
          "sailOrBoardNumber": "210313",
          "nationality": "KAZ",
          "gender": "M",
          "grossScore": 194,
          "nettScore": 165,
          "races": [
            {
              "raceNumber": 1,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 2,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 3,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 4,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 5,
              "score": 29,
              "code": null,
              "discarded": true,
              "raw": "(29)"
            },
            {
              "raceNumber": 6,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 7,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 8,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 9,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 10,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            }
          ],
          "sailorId": "2c520c3e-1da2-59af-8b00-1fd595079073",
          "resultId": "138e8ffe-7c7d-5561-aa96-79c3408c2192",
          "participantId": "da297e6c-0b2f-5c11-8072-2e48dddeda04",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "KAZ",
          "officialName": "Ruan Alexeyenko",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 210313, Nat: KAZ."
        },
        {
          "rank": 17,
          "sourceName": "Hsuanchen Chien",
          "name": "Hsuanchen Chien",
          "sailOrBoardNumber": "221514",
          "nationality": "TPE",
          "gender": "M",
          "grossScore": 204,
          "nettScore": 171,
          "races": [
            {
              "raceNumber": 1,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 2,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 3,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 4,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 5,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 6,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 7,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 8,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 9,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 10,
              "score": 33,
              "code": "RET",
              "discarded": true,
              "raw": "(33 RET)"
            }
          ],
          "sailorId": "f4cc8bb9-c008-574e-aa09-b07c58607a12",
          "resultId": "0b8a2063-28c2-557b-a006-509fd6b59331",
          "participantId": "bf884e22-e86f-5e31-8ca2-601a69dd9c7c",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "TPE",
          "officialName": "Hsuanchen Chien",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 221514, Nat: TPE."
        },
        {
          "rank": 18,
          "sourceName": "Samuel Rui Qian Tan- Hardy",
          "name": "Samuel Rui Qian Tan- Hardy",
          "sailOrBoardNumber": "221934",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 214,
          "nettScore": 181,
          "races": [
            {
              "raceNumber": 1,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 2,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 3,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 4,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 5,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 6,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 7,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 8,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 9,
              "score": 33,
              "code": "RET",
              "discarded": true,
              "raw": "(33 RET)"
            },
            {
              "raceNumber": 10,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            }
          ],
          "sailorId": "c960af09-f1a0-5c20-8001-a548ef9d0d43",
          "resultId": "68721d69-064f-5142-8572-693f8aaeb895",
          "participantId": "61c351ac-d6c0-52dd-9913-d07b7a4697be",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "HKG",
          "officialName": "Samuel Rui Qian Tan- Hardy",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 221934, Nat: HKG."
        },
        {
          "rank": 19,
          "sourceName": "Xavier Wilde",
          "name": "Xavier Wilde",
          "sailOrBoardNumber": "213211",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 216,
          "nettScore": 189,
          "races": [
            {
              "raceNumber": 1,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 2,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 3,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 4,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 5,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 6,
              "score": 27,
              "code": null,
              "discarded": true,
              "raw": "(27)"
            },
            {
              "raceNumber": 7,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 8,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 9,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 10,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            }
          ],
          "sailorId": "3a1abf10-28a8-55a8-95be-53f5a8d13ed9",
          "resultId": "625b5ae2-b305-5b17-9fbc-6199be0264e0",
          "participantId": "eefdf550-4fc4-5622-904e-fd20d68500c6",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "HKG",
          "officialName": "Xavier Wilde",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 213211, Nat: HKG."
        },
        {
          "rank": 20,
          "sourceName": "Ruoyu Su",
          "name": "Ruoyu Su",
          "sailOrBoardNumber": "214664",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 228,
          "nettScore": 198,
          "races": [
            {
              "raceNumber": 1,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 2,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 3,
              "score": 30,
              "code": "SP1",
              "discarded": true,
              "raw": "(30 SP1)"
            },
            {
              "raceNumber": 4,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 5,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 6,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 7,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 8,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 9,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 10,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            }
          ],
          "sailorId": "a989031e-5d1b-546f-994b-7dd84b80bfb3",
          "resultId": "f3886f6a-05c0-564b-a5b4-1eb569d0059f",
          "participantId": "2edfa78f-96a1-5c9a-aa35-98182424b44c",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Ruoyu Su",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 214664, Nat: CHN."
        },
        {
          "rank": 21,
          "sourceName": "Ethan Yi Xuan Lim",
          "name": "Ethan Yi Xuan Lim",
          "sailOrBoardNumber": "214860",
          "nationality": "SGP",
          "gender": "M",
          "grossScore": 226,
          "nettScore": 200,
          "races": [
            {
              "raceNumber": 1,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 2,
              "score": 26,
              "code": null,
              "discarded": true,
              "raw": "(26)"
            },
            {
              "raceNumber": 3,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 4,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 5,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 6,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 7,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 8,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 9,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 10,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            }
          ],
          "sailorId": "28084792-a8b9-4ef8-b621-55231cb559a1",
          "resultId": "276b9d61-b99e-5504-b12a-db4ec448eee6",
          "participantId": "dd3c2803-0819-590c-a770-ecf3d210ed0c",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Ethan Yi Xuan Lim",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 214860, Nat: SGP."
        },
        {
          "rank": 22,
          "sourceName": "Saoud Almasoud",
          "name": "Saoud Almasoud",
          "sailOrBoardNumber": "189641",
          "nationality": "KUW",
          "gender": "M",
          "grossScore": 238,
          "nettScore": 205,
          "races": [
            {
              "raceNumber": 1,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 2,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 3,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 4,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 5,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 6,
              "score": 33,
              "code": "DNF",
              "discarded": true,
              "raw": "(33 DNF)"
            },
            {
              "raceNumber": 7,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 8,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 9,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 10,
              "score": 33,
              "code": "BFD",
              "discarded": false,
              "raw": "33 BFD"
            }
          ],
          "sailorId": "9f928c67-6acf-5b88-beb3-749076ac1185",
          "resultId": "7bbfddbf-abbb-5cdd-a476-ec0dd59ba164",
          "participantId": "d2bdb20d-7763-5706-a5d3-af2b9bdc13e8",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "KUW",
          "officialName": "Saoud Almasoud",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 189641, Nat: KUW."
        },
        {
          "rank": 23,
          "sourceName": "Ruoque Su",
          "name": "Ruoque Su",
          "sailOrBoardNumber": "214379",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 240,
          "nettScore": 207,
          "races": [
            {
              "raceNumber": 1,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 2,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 3,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 4,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 5,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 6,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 7,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 8,
              "score": 33,
              "code": "RET",
              "discarded": true,
              "raw": "(33 RET)"
            },
            {
              "raceNumber": 9,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 10,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            }
          ],
          "sailorId": "56af1cd1-f3d9-5298-956c-274f294de03e",
          "resultId": "59d1ce93-7412-5453-a170-4aac4a16330c",
          "participantId": "fc9c38cd-a8da-5c5c-9c5c-451ace241add",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Ruoque Su",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 214379, Nat: CHN."
        },
        {
          "rank": 24,
          "sourceName": "Xiaotian Ma",
          "name": "Xiaotian Ma",
          "sailOrBoardNumber": "214500",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 252,
          "nettScore": 219,
          "races": [
            {
              "raceNumber": 1,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 2,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 3,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 4,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 5,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 6,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 7,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 8,
              "score": 33,
              "code": "RET",
              "discarded": true,
              "raw": "(33 RET)"
            },
            {
              "raceNumber": 9,
              "score": 33,
              "code": "DNC",
              "discarded": false,
              "raw": "33 DNC"
            },
            {
              "raceNumber": 10,
              "score": 33,
              "code": "DNC",
              "discarded": false,
              "raw": "33 DNC"
            }
          ],
          "sailorId": "cd5654dc-e845-5964-a9d1-139382209d7f",
          "resultId": "df59022f-f4de-55e0-b67c-7aa3902dd8d2",
          "participantId": "fb1ecdc9-0ae2-587e-a0fb-a0cda09f5079",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Xiaotian Ma",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 214500, Nat: CHN."
        },
        {
          "rank": 25,
          "sourceName": "Zhuang Zhicheng",
          "name": "Zhuang Zhicheng",
          "sailOrBoardNumber": "214663",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 257,
          "nettScore": 224,
          "races": [
            {
              "raceNumber": 1,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 2,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 3,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 4,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 5,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 6,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 7,
              "score": 33,
              "code": "DNC",
              "discarded": true,
              "raw": "(33 DNC)"
            },
            {
              "raceNumber": 8,
              "score": 33,
              "code": "DNC",
              "discarded": false,
              "raw": "33 DNC"
            },
            {
              "raceNumber": 9,
              "score": 33,
              "code": "DNC",
              "discarded": false,
              "raw": "33 DNC"
            },
            {
              "raceNumber": 10,
              "score": 33,
              "code": "DNC",
              "discarded": false,
              "raw": "33 DNC"
            }
          ],
          "sailorId": "1f51e262-b9b0-5b37-9056-8f9e4b7068bb",
          "resultId": "6f5be657-a910-5600-930b-d6b53ec5a867",
          "participantId": "d427f8f7-7ec9-5b0a-ba5a-0f6ad6401668",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Zhuang Zhicheng",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 214663, Nat: CHN."
        },
        {
          "rank": 26,
          "sourceName": "Guan Xin Qiu",
          "name": "Guan Xin Qiu",
          "sailOrBoardNumber": "214380",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 257,
          "nettScore": 224,
          "races": [
            {
              "raceNumber": 1,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 2,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 3,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 4,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 5,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 6,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 7,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 8,
              "score": 33,
              "code": "RET",
              "discarded": true,
              "raw": "(33 RET)"
            },
            {
              "raceNumber": 9,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 10,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            }
          ],
          "sailorId": "6ae09413-305b-56f5-9801-e5cd3ab93c1d",
          "resultId": "ce5f00e7-34ed-5764-b128-7c72b467d910",
          "participantId": "f09c2941-edcc-5384-8b06-93569794e120",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Guan Xin Qiu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 214380, Nat: CHN."
        },
        {
          "rank": 27,
          "sourceName": "Chengen Lee",
          "name": "Chengen Lee",
          "sailOrBoardNumber": "218497",
          "nationality": "TPE",
          "gender": "M",
          "grossScore": 258,
          "nettScore": 228,
          "races": [
            {
              "raceNumber": 1,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 2,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 3,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 4,
              "score": 30,
              "code": null,
              "discarded": true,
              "raw": "(30)"
            },
            {
              "raceNumber": 5,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 6,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 7,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 8,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 9,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 10,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            }
          ],
          "sailorId": "b156b578-8c94-566b-80eb-210c4436d033",
          "resultId": "f58e714b-af0c-54c6-9989-e9864c466ee2",
          "participantId": "92c22ab8-0455-5c0a-bc46-5a31305b3e11",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "TPE",
          "officialName": "Chengen Lee",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 218497, Nat: TPE."
        },
        {
          "rank": 28,
          "sourceName": "Clive Seah",
          "name": "Clive Seah",
          "sailOrBoardNumber": "214240",
          "nationality": "SGP",
          "gender": "M",
          "grossScore": 261,
          "nettScore": 233,
          "races": [
            {
              "raceNumber": 1,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 2,
              "score": 28,
              "code": null,
              "discarded": true,
              "raw": "(28)"
            },
            {
              "raceNumber": 3,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 4,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 5,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 6,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 7,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 8,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 9,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 10,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            }
          ],
          "sailorId": "9feccee3-556f-494a-bb80-593be88884cc",
          "resultId": "5fd7d7e0-cf5e-5787-b147-b15ab34f6e6d",
          "participantId": "cba6138c-0475-59eb-9a90-1da3490d7feb",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Clive Seah",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 214240, Nat: SGP."
        },
        {
          "rank": 29,
          "sourceName": "Minqi Zhu",
          "name": "Minqi Zhu",
          "sailOrBoardNumber": "225098",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 297,
          "nettScore": 264,
          "races": [
            {
              "raceNumber": 1,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 2,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 3,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 4,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 5,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 6,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 7,
              "score": 33,
              "code": "RET",
              "discarded": true,
              "raw": "(33 RET)"
            },
            {
              "raceNumber": 8,
              "score": 33,
              "code": "DNC",
              "discarded": false,
              "raw": "33 DNC"
            },
            {
              "raceNumber": 9,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 10,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            }
          ],
          "sailorId": "45720fde-ed0e-5f9d-bf37-8d064283a182",
          "resultId": "851941c6-c504-55db-834b-8ec3e802404d",
          "participantId": "945500dc-1581-565b-b5e1-ee8120decf0c",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Minqi Zhu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 225098, Nat: CHN."
        },
        {
          "rank": 30,
          "sourceName": "Yuxiao Deng",
          "name": "Yuxiao Deng",
          "sailOrBoardNumber": "225467",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 309,
          "nettScore": 276,
          "races": [
            {
              "raceNumber": 1,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 2,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 3,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 4,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 5,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 6,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 7,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 8,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 9,
              "score": 33,
              "code": "BFD",
              "discarded": true,
              "raw": "(33 BFD)"
            },
            {
              "raceNumber": 10,
              "score": 33,
              "code": "BFD",
              "discarded": false,
              "raw": "33 BFD"
            }
          ],
          "sailorId": "23ae179a-311b-5dc8-86d6-bf0d0869b788",
          "resultId": "9176de41-aebc-5a84-b8d3-0fdb6a5cb8fd",
          "participantId": "3bc5a7b0-3876-5f31-b2e1-e8d51c0ec150",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yuxiao Deng",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Men. Sail No: 225467, Nat: CHN."
        }
      ]
    },
    {
      "config": {
        "id": "b1a02024-a510-48e0-8003-000000000004",
        "slug": "2024-ilca-asian-open-championship-ilca6-women",
        "name": "2024 ILCA Asian Open Championship (ILCA 6 Women)",
        "boatClass": "ILCA 6",
        "division": "Women",
        "gender": "W",
        "raceCount": 10,
        "discardCount": 1,
        "entryType": "individual",
        "date": "2024-12-14",
        "endDate": "2024-12-20"
      },
      "results": [
        {
          "rank": 1,
          "sourceName": "Zitong Shang",
          "name": "Zitong Shang",
          "sailOrBoardNumber": "225091",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 61,
          "nettScore": 46,
          "races": [
            {
              "raceNumber": 1,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 2,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 3,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 4,
              "score": 3,
              "code": "SP1",
              "discarded": false,
              "raw": "3 SP1"
            },
            {
              "raceNumber": 5,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 6,
              "score": 15,
              "code": null,
              "discarded": true,
              "raw": "(15)"
            },
            {
              "raceNumber": 7,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 8,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 9,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 10,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            }
          ],
          "sailorId": "8434d456-0359-541e-b994-6104370f5a96",
          "resultId": "d29e33d6-7a3d-5de4-a3d8-29077d2e7893",
          "participantId": "d9f1d30b-048b-5748-a02a-08c542da584e",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Zitong Shang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 225091, Nat: CHN."
        },
        {
          "rank": 2,
          "sourceName": "Stephanie Norton",
          "name": "Stephanie Norton",
          "sailOrBoardNumber": "191713",
          "nationality": "HKG",
          "gender": "W",
          "grossScore": 71,
          "nettScore": 57,
          "races": [
            {
              "raceNumber": 1,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 2,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 3,
              "score": 14,
              "code": null,
              "discarded": true,
              "raw": "(14)"
            },
            {
              "raceNumber": 4,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 5,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 6,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 7,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 8,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 9,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 10,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            }
          ],
          "sailorId": "98bf4b68-3283-5b87-bbbe-d11c1977eafc",
          "resultId": "57d1b052-6660-5427-9bcf-bffe3dc7fa24",
          "participantId": "07af68e2-717f-5259-9f47-4ca518694948",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "HKG",
          "officialName": "Stephanie Norton",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 191713, Nat: HKG."
        },
        {
          "rank": 3,
          "sourceName": "DongShuang Zhang",
          "name": "DongShuang Zhang",
          "sailOrBoardNumber": "225096",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 77,
          "nettScore": 59,
          "races": [
            {
              "raceNumber": 1,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 2,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 3,
              "score": 18,
              "code": null,
              "discarded": true,
              "raw": "(18)"
            },
            {
              "raceNumber": 4,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 5,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 6,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 7,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 8,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 9,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 10,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            }
          ],
          "sailorId": "5c303689-5519-5f35-80d7-81475fe236cd",
          "resultId": "ace54ff6-a722-53e3-93f4-3363586b26d9",
          "participantId": "0d36f305-69fe-5264-a47d-78927a6130af",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "DongShuang Zhang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 225096, Nat: CHN."
        },
        {
          "rank": 4,
          "sourceName": "Min Gu",
          "name": "Min Gu",
          "sailOrBoardNumber": "225106",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 79,
          "nettScore": 61,
          "races": [
            {
              "raceNumber": 1,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 2,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 3,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 4,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 5,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 6,
              "score": 18,
              "code": null,
              "discarded": true,
              "raw": "(18)"
            },
            {
              "raceNumber": 7,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 8,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 9,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 10,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            }
          ],
          "sailorId": "e92f805f-ad59-504a-9c60-df77a89c2ebe",
          "resultId": "97ae5361-c431-5277-8667-acfbffcf01f0",
          "participantId": "74637733-10cc-5d34-b4d7-550fd93c13a4",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Min Gu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 225106, Nat: CHN."
        },
        {
          "rank": 5,
          "sourceName": "Nancy Highfield",
          "name": "Nancy Highfield",
          "sailOrBoardNumber": "211717",
          "nationality": "HKG",
          "gender": "W",
          "grossScore": 83,
          "nettScore": 69,
          "races": [
            {
              "raceNumber": 1,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 2,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 3,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 4,
              "score": 14,
              "code": null,
              "discarded": true,
              "raw": "(14)"
            },
            {
              "raceNumber": 5,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 6,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 7,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 8,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 9,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 10,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            }
          ],
          "sailorId": "aecf4b79-5e1b-5545-8eb5-96d9f67f7944",
          "resultId": "af2112de-f20e-5d9d-ba09-97221facb2e5",
          "participantId": "098beb67-ea6c-5402-9ed1-62d800c57850",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "HKG",
          "officialName": "Nancy Highfield",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 211717, Nat: HKG."
        },
        {
          "rank": 6,
          "sourceName": "Yi Xin Li",
          "name": "Yi Xin Li",
          "sailOrBoardNumber": "225095",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 90,
          "nettScore": 73,
          "races": [
            {
              "raceNumber": 1,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 2,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 3,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 4,
              "score": 17,
              "code": null,
              "discarded": true,
              "raw": "(17)"
            },
            {
              "raceNumber": 5,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 6,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 7,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 8,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 9,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 10,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            }
          ],
          "sailorId": "ec034268-7521-52cc-a753-283947345904",
          "resultId": "8444b221-38c9-5ff8-8324-dead870f0401",
          "participantId": "bab97869-54c3-5ed3-9f8f-15923703f921",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yi Xin Li",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 225095, Nat: CHN."
        },
        {
          "rank": 7,
          "sourceName": "Junqi Gao",
          "name": "Junqi Gao",
          "sailOrBoardNumber": "217775",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 92,
          "nettScore": 74,
          "races": [
            {
              "raceNumber": 1,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 2,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 3,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 4,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 5,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 6,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 7,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 8,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 9,
              "score": 18,
              "code": null,
              "discarded": true,
              "raw": "(18)"
            },
            {
              "raceNumber": 10,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            }
          ],
          "sailorId": "4b50b47b-1492-57dd-9f30-f445a2d1dc00",
          "resultId": "fa6d993c-a7c5-5eaf-bef9-e95ac455b1fa",
          "participantId": "ffc4ba94-9ee7-5d82-8ae0-63c3f7dc4ccd",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Junqi Gao",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 217775, Nat: CHN."
        },
        {
          "rank": 8,
          "sourceName": "Nethra Kumanan",
          "name": "Nethra Kumanan",
          "sailOrBoardNumber": "222138",
          "nationality": "IND",
          "gender": "W",
          "grossScore": 93,
          "nettScore": 77,
          "races": [
            {
              "raceNumber": 1,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 2,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 3,
              "score": 16,
              "code": null,
              "discarded": true,
              "raw": "(16)"
            },
            {
              "raceNumber": 4,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 5,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 6,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 7,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 8,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 9,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 10,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            }
          ],
          "sailorId": "fd29d27b-51f0-47b5-b350-47174654ba5e",
          "resultId": "7b4534ab-82f0-510e-9799-7598198002b4",
          "participantId": "4c80abc9-6321-54c2-b5a5-1f2ecb627c92",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (IND) match in database",
          "sourceNationality": "IND",
          "officialName": "Nethra Kumanan",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 222138, Nat: IND."
        },
        {
          "rank": 9,
          "sourceName": "Li Hui",
          "name": "Li Hui",
          "sailOrBoardNumber": "224672",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 132,
          "nettScore": 87,
          "races": [
            {
              "raceNumber": 1,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 2,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 3,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 4,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 5,
              "score": 45,
              "code": "BFD",
              "discarded": true,
              "raw": "(45 BFD)"
            },
            {
              "raceNumber": 6,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 7,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 8,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 9,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 10,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            }
          ],
          "sailorId": "f7c83ca4-b62f-5d5c-9764-12fcf7e7e891",
          "resultId": "8d38444c-3b85-59da-bf42-1518e0c2c7c4",
          "participantId": "de782291-ee7c-5201-a6ba-8f767177204e",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Li Hui",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 224672, Nat: CHN."
        },
        {
          "rank": 10,
          "sourceName": "Jiaming Chen",
          "name": "Jiaming Chen",
          "sailOrBoardNumber": "223741",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 147,
          "nettScore": 102,
          "races": [
            {
              "raceNumber": 1,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 2,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 3,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 4,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 5,
              "score": 45,
              "code": "BFD",
              "discarded": true,
              "raw": "(45 BFD)"
            },
            {
              "raceNumber": 6,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 7,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 8,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 9,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 10,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            }
          ],
          "sailorId": "28920e09-1f15-5b12-b489-ea9ff5017207",
          "resultId": "8a5ab08d-ff5d-5ab5-914c-0f8fdb3e8981",
          "participantId": "884cc34b-ba98-5e9f-96de-e5ec1f9b355a",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Jiaming Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 223741, Nat: CHN."
        },
        {
          "rank": 11,
          "sourceName": "Jania Ang",
          "name": "Jania Ang",
          "sailOrBoardNumber": "222727",
          "nationality": "SGP",
          "gender": "W",
          "grossScore": 155,
          "nettScore": 110,
          "races": [
            {
              "raceNumber": 1,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 2,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 3,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 4,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 5,
              "score": 45,
              "code": "BFD",
              "discarded": true,
              "raw": "(45 BFD)"
            },
            {
              "raceNumber": 6,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 7,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 8,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 9,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 10,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            }
          ],
          "sailorId": "ddfe8d27-5c27-4cc6-b7b3-5c5d89564914",
          "resultId": "539c0004-2b55-54ab-acc7-623f48b29c26",
          "participantId": "41fdf110-bbc9-570e-925d-7169e2662c1c",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Jania Ang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 222727, Nat: SGP."
        },
        {
          "rank": 12,
          "sourceName": "Yuetao Zhuo",
          "name": "Yuetao Zhuo",
          "sailOrBoardNumber": "221589",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 150,
          "nettScore": 110,
          "races": [
            {
              "raceNumber": 1,
              "score": 40,
              "code": null,
              "discarded": true,
              "raw": "(40)"
            },
            {
              "raceNumber": 2,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 3,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 4,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 5,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 6,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 7,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 8,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 9,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 10,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            }
          ],
          "sailorId": "45e12acd-f5c9-55a7-8bb7-8a3eec298c11",
          "resultId": "327da8e6-15cd-550d-8213-5eb083c7f9ab",
          "participantId": "54b3c5c4-ae48-59bb-84f5-bd34fd0808f3",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yuetao Zhuo",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 221589, Nat: CHN."
        },
        {
          "rank": 13,
          "sourceName": "Jiajia Tang",
          "name": "Jiajia Tang",
          "sailOrBoardNumber": "217761",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 150,
          "nettScore": 112,
          "races": [
            {
              "raceNumber": 1,
              "score": 38,
              "code": null,
              "discarded": true,
              "raw": "(38)"
            },
            {
              "raceNumber": 2,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 3,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 4,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 5,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 6,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 7,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 8,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 9,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 10,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            }
          ],
          "sailorId": "b3a29923-9d56-5e07-82f0-b0708d6f1419",
          "resultId": "45daf3f9-eae1-5e94-a04c-f8d52ffdbf7d",
          "participantId": "e7b5f6ce-664a-5c64-9acf-d3b632302686",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Jiajia Tang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 217761, Nat: CHN."
        },
        {
          "rank": 14,
          "sourceName": "Mengjiao Chang",
          "name": "Mengjiao Chang",
          "sailOrBoardNumber": "217677",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 157,
          "nettScore": 116,
          "races": [
            {
              "raceNumber": 1,
              "score": 41,
              "code": null,
              "discarded": true,
              "raw": "(41)"
            },
            {
              "raceNumber": 2,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 3,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 4,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 5,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 6,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 7,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 8,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 9,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 10,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            }
          ],
          "sailorId": "bf1b2f0e-9b29-5b11-b716-50b701456bfc",
          "resultId": "525d23b3-42c3-5bac-8e63-c09770e0eaf1",
          "participantId": "1c4c363e-f536-5d06-a588-9938ca4f0cf5",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Mengjiao Chang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 217677, Nat: CHN."
        },
        {
          "rank": 15,
          "sourceName": "Fanqi Wang",
          "name": "Fanqi Wang",
          "sailOrBoardNumber": "211518",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 177,
          "nettScore": 132,
          "races": [
            {
              "raceNumber": 1,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 2,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 3,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 4,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 5,
              "score": 45,
              "code": "BFD",
              "discarded": true,
              "raw": "(45 BFD)"
            },
            {
              "raceNumber": 6,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 7,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 8,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 9,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 10,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            }
          ],
          "sailorId": "375916b9-f25c-56f8-87ce-620693f6b41e",
          "resultId": "008a2f15-47f8-537e-8e8d-e0649de549db",
          "participantId": "ea775879-4312-573d-b2e5-bb5b512d4e86",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Fanqi Wang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 211518, Nat: CHN."
        },
        {
          "rank": 16,
          "sourceName": "Tong Zhu",
          "name": "Tong Zhu",
          "sailOrBoardNumber": "221033",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 176,
          "nettScore": 139,
          "races": [
            {
              "raceNumber": 1,
              "score": 37,
              "code": null,
              "discarded": true,
              "raw": "(37)"
            },
            {
              "raceNumber": 2,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 3,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 4,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 5,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 6,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 7,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 8,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 9,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 10,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            }
          ],
          "sailorId": "1290d3ca-f615-519d-b2f0-172e4d27d8fc",
          "resultId": "df4bb562-0f19-514f-ba56-cf870e90a846",
          "participantId": "0318a0bd-e9c9-5bb0-ad77-e7a305e94eba",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Tong Zhu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 221033, Nat: CHN."
        },
        {
          "rank": 17,
          "sourceName": "Fang Yu Fu",
          "name": "Fang Yu Fu",
          "sailOrBoardNumber": "225233",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 189,
          "nettScore": 155,
          "races": [
            {
              "raceNumber": 1,
              "score": 34,
              "code": null,
              "discarded": true,
              "raw": "(34)"
            },
            {
              "raceNumber": 2,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 3,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 4,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 5,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 6,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 7,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 8,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 9,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 10,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            }
          ],
          "sailorId": "2a3d638a-3eef-5eff-88c0-a9d7dbdb6d28",
          "resultId": "0c17c604-cfb6-5e75-bb0b-8902794d3dc1",
          "participantId": "0b4d52f5-d8c5-5575-8424-68c8a833ae05",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Fang Yu Fu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 225233, Nat: CHN."
        },
        {
          "rank": 18,
          "sourceName": "Baoling Yu",
          "name": "Baoling Yu",
          "sailOrBoardNumber": "222977",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 179,
          "nettScore": 157,
          "races": [
            {
              "raceNumber": 1,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 2,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 3,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 4,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 5,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 6,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 7,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 8,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 9,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 10,
              "score": 22,
              "code": null,
              "discarded": true,
              "raw": "(22)"
            }
          ],
          "sailorId": "c07bdc06-a80a-5b16-a022-2774ae6069f0",
          "resultId": "42d20e9b-8702-53e9-b426-502337ea0168",
          "participantId": "db44a06e-9b4b-54f9-ad9e-0b47165d5575",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Baoling Yu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 222977, Nat: CHN."
        },
        {
          "rank": 19,
          "sourceName": "Lifei Huang",
          "name": "Lifei Huang",
          "sailOrBoardNumber": "217669",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 201,
          "nettScore": 173,
          "races": [
            {
              "raceNumber": 1,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 2,
              "score": 28,
              "code": null,
              "discarded": true,
              "raw": "(28)"
            },
            {
              "raceNumber": 3,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 4,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 5,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 6,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 7,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 8,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 9,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 10,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            }
          ],
          "sailorId": "1f0585b7-e3ab-53e1-856d-de9b55828f52",
          "resultId": "3a3cdc5f-d577-56f4-8bd8-3f7ca1370abf",
          "participantId": "154514c5-c558-5fa3-a3e4-47d5e0e37080",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Lifei Huang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 217669, Nat: CHN."
        },
        {
          "rank": 20,
          "sourceName": "Nur Alia Amera Mohamad Latif",
          "name": "Nur Alia Amera Mohamad Latif",
          "sailOrBoardNumber": "209878",
          "nationality": "MAS",
          "gender": "W",
          "grossScore": 207,
          "nettScore": 179,
          "races": [
            {
              "raceNumber": 1,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 2,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 3,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 4,
              "score": 28,
              "code": null,
              "discarded": true,
              "raw": "(28)"
            },
            {
              "raceNumber": 5,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 6,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 7,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 8,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 9,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 10,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            }
          ],
          "sailorId": "6b3c0556-5b5f-5a76-9b90-b5510232f4bc",
          "resultId": "b19480d0-3f1e-5f21-bb3e-257d4a5df027",
          "participantId": "5f07db9e-ddd6-5e89-a6a9-2e995dbf68c3",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "MAS",
          "officialName": "Nur Alia Amera Mohamad Latif",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 209878, Nat: MAS."
        },
        {
          "rank": 21,
          "sourceName": "Jimeng Chen",
          "name": "Jimeng Chen",
          "sailOrBoardNumber": "212131",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 223,
          "nettScore": 187,
          "races": [
            {
              "raceNumber": 1,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 2,
              "score": 36,
              "code": null,
              "discarded": true,
              "raw": "(36)"
            },
            {
              "raceNumber": 3,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 4,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 5,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 6,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 7,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 8,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 9,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 10,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            }
          ],
          "sailorId": "02749d3a-ea20-5171-a857-0d819f991798",
          "resultId": "34ef7106-b228-57da-be5f-6fcd2e44cab7",
          "participantId": "fdc87088-846d-56db-bbe6-4c4c2eda1593",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Jimeng Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 212131, Nat: CHN."
        },
        {
          "rank": 22,
          "sourceName": "Yuchen Zhu",
          "name": "Yuchen Zhu",
          "sailOrBoardNumber": "217256",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 228,
          "nettScore": 189,
          "races": [
            {
              "raceNumber": 1,
              "score": 39,
              "code": null,
              "discarded": true,
              "raw": "(39)"
            },
            {
              "raceNumber": 2,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 3,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 4,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 5,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 6,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 7,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 8,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 9,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 10,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            }
          ],
          "sailorId": "a0801a18-74f2-54ae-bc72-4a0b032cb468",
          "resultId": "ecbe0be1-12f5-5eb9-a4a2-d16817503a4f",
          "participantId": "b0afa62f-9097-52d5-94e0-d162068a8f28",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yuchen Zhu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 217256, Nat: CHN."
        },
        {
          "rank": 23,
          "sourceName": "Marion Grace Montgomery",
          "name": "Marion Grace Montgomery",
          "sailOrBoardNumber": "222660",
          "nationality": "THA",
          "gender": "W",
          "grossScore": 240,
          "nettScore": 206,
          "races": [
            {
              "raceNumber": 1,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 2,
              "score": 34,
              "code": null,
              "discarded": true,
              "raw": "(34)"
            },
            {
              "raceNumber": 3,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 4,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 5,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 6,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 7,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 8,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 9,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 10,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            }
          ],
          "sailorId": "0f33df5e-ca62-502f-a771-b44846d6ac6a",
          "resultId": "0dde0aba-38e5-5028-be09-ff5fcb317329",
          "participantId": "9eb019f2-3b0f-55ea-9766-894dc84ac65a",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (THA) match in database",
          "sourceNationality": "THA",
          "officialName": "Marion Grace Montgomery",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 222660, Nat: THA."
        },
        {
          "rank": 24,
          "sourceName": "Noppassorn Khunboonjan",
          "name": "Noppassorn Khunboonjan",
          "sailOrBoardNumber": "220240",
          "nationality": "THA",
          "gender": "W",
          "grossScore": 239,
          "nettScore": 209,
          "races": [
            {
              "raceNumber": 1,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 2,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 3,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 4,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 5,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 6,
              "score": 30,
              "code": null,
              "discarded": true,
              "raw": "(30)"
            },
            {
              "raceNumber": 7,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 8,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 9,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 10,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            }
          ],
          "sailorId": "d29da64f-723a-45e0-a4d6-57eb7a1b1e82",
          "resultId": "d49fac25-4084-5da5-b6bf-57b6d2842032",
          "participantId": "67784f0f-4856-5736-b5b2-2a3a2bdfd04f",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (THA) match in database",
          "sourceNationality": "THA",
          "officialName": "Noppassorn Khunboonjan",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 220240, Nat: THA."
        },
        {
          "rank": 25,
          "sourceName": "Ye Xin Yang",
          "name": "Ye Xin Yang",
          "sailOrBoardNumber": "225229",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 243,
          "nettScore": 216,
          "races": [
            {
              "raceNumber": 1,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 2,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 3,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 4,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 5,
              "score": 27,
              "code": null,
              "discarded": true,
              "raw": "(27)"
            },
            {
              "raceNumber": 6,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 7,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 8,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 9,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 10,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            }
          ],
          "sailorId": "56fe38fa-7759-59a5-9432-ff0a4b518898",
          "resultId": "37b25f2e-6a5d-5e89-bc66-c59cd83b16ab",
          "participantId": "69d86a48-990a-5fb4-a78e-4ba5ec52f82d",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Ye Xin Yang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 225229, Nat: CHN."
        },
        {
          "rank": 26,
          "sourceName": "Nana Funazawa",
          "name": "Nana Funazawa",
          "sailOrBoardNumber": "217111",
          "nationality": "JPN",
          "gender": "W",
          "grossScore": 247,
          "nettScore": 217,
          "races": [
            {
              "raceNumber": 1,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 2,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 3,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 4,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 5,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 6,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 7,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 8,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 9,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 10,
              "score": 30,
              "code": null,
              "discarded": true,
              "raw": "(30)"
            }
          ],
          "sailorId": "5ec2f363-6683-5607-8bd8-b2984890b6c2",
          "resultId": "7d884faa-b875-59b0-a67c-117ffb6c9077",
          "participantId": "9c917be2-f913-5756-b619-7f2283d653e0",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "JPN",
          "officialName": "Nana Funazawa",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 217111, Nat: JPN."
        },
        {
          "rank": 27,
          "sourceName": "Hehsi\uff08lucy\uff09 Huang",
          "name": "Hehsi\uff08lucy\uff09 Huang",
          "sailOrBoardNumber": "211718",
          "nationality": "TPE",
          "gender": "W",
          "grossScore": 265,
          "nettScore": 221,
          "races": [
            {
              "raceNumber": 1,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 2,
              "score": 44,
              "code": null,
              "discarded": true,
              "raw": "(44)"
            },
            {
              "raceNumber": 3,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 4,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 5,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 6,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 7,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 8,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 9,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 10,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            }
          ],
          "sailorId": "d47a1360-502a-5e67-bb6f-a258032b716b",
          "resultId": "8aaba4c7-4ca9-5eb6-b70e-b62347cbb857",
          "participantId": "0f9e5074-ec14-5916-a3ae-5e3c06a36af0",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "TPE",
          "officialName": "Hehsi\uff08lucy\uff09 Huang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 211718, Nat: TPE."
        },
        {
          "rank": 28,
          "sourceName": "Mengyao Yu",
          "name": "Mengyao Yu",
          "sailOrBoardNumber": "222964",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 269,
          "nettScore": 224,
          "races": [
            {
              "raceNumber": 1,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 2,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 3,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 4,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 5,
              "score": 45,
              "code": "BFD",
              "discarded": true,
              "raw": "(45 BFD)"
            },
            {
              "raceNumber": 6,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 7,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 8,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 9,
              "score": 45,
              "code": "BFD",
              "discarded": false,
              "raw": "45 BFD"
            },
            {
              "raceNumber": 10,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            }
          ],
          "sailorId": "fff0cbea-df5b-53f7-9d2b-a5c715ff066f",
          "resultId": "b2b14c9b-e980-5951-bab8-1f11504e08b0",
          "participantId": "deaee3d1-8c6c-5340-899a-ddad2794cd4f",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Mengyao Yu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 222964, Nat: CHN."
        },
        {
          "rank": 29,
          "sourceName": "Xinran Chen",
          "name": "Xinran Chen",
          "sailOrBoardNumber": "223276",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 292,
          "nettScore": 257,
          "races": [
            {
              "raceNumber": 1,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 2,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 3,
              "score": 35,
              "code": null,
              "discarded": true,
              "raw": "(35)"
            },
            {
              "raceNumber": 4,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 5,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 6,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 7,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 8,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 9,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 10,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            }
          ],
          "sailorId": "7d370151-6d36-55ac-8e0c-f239e2e28080",
          "resultId": "0562cadd-9f49-5652-b44b-2f9b2e624522",
          "participantId": "828ec1db-5500-595b-8c2b-9b9c48676770",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Xinran Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 223276, Nat: CHN."
        },
        {
          "rank": 30,
          "sourceName": "Ameena Shah",
          "name": "Ameena Shah",
          "sailOrBoardNumber": "180982",
          "nationality": "KUW",
          "gender": "W",
          "grossScore": 305,
          "nettScore": 260,
          "races": [
            {
              "raceNumber": 1,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 2,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 3,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 4,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 5,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 6,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 7,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 8,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 9,
              "score": 45,
              "code": "BFD",
              "discarded": true,
              "raw": "(45 BFD)"
            },
            {
              "raceNumber": 10,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            }
          ],
          "sailorId": "c8aa8931-e608-5dd1-bb56-7babc54470c1",
          "resultId": "83753eb1-ba0d-548a-b65e-0a85984af78e",
          "participantId": "c664c446-4cfd-57d6-a6d8-299effb3a705",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "KUW",
          "officialName": "Ameena Shah",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 180982, Nat: KUW."
        },
        {
          "rank": 31,
          "sourceName": "Ziyan Huang",
          "name": "Ziyan Huang",
          "sailOrBoardNumber": "221401",
          "nationality": "HKG",
          "gender": "W",
          "grossScore": 304,
          "nettScore": 267,
          "races": [
            {
              "raceNumber": 1,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 2,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 3,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 4,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 5,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 6,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 7,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 8,
              "score": 37,
              "code": null,
              "discarded": true,
              "raw": "(37)"
            },
            {
              "raceNumber": 9,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 10,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            }
          ],
          "sailorId": "c19dae59-5f06-52f8-bd66-e13efdd35e6d",
          "resultId": "7f20bc6c-f572-5fd5-8260-e5336c8f251e",
          "participantId": "a97ffebb-1048-5310-aa93-6660f0151bfa",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "HKG",
          "officialName": "Ziyan Huang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 221401, Nat: HKG."
        },
        {
          "rank": 32,
          "sourceName": "Abigail Koh",
          "name": "Abigail Koh",
          "sailOrBoardNumber": "214237",
          "nationality": "SGP",
          "gender": "W",
          "grossScore": 341,
          "nettScore": 298,
          "races": [
            {
              "raceNumber": 1,
              "score": 43,
              "code": null,
              "discarded": true,
              "raw": "(43)"
            },
            {
              "raceNumber": 2,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 3,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 4,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 5,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 6,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 7,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 8,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 9,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 10,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            }
          ],
          "sailorId": "63d082ef-363c-4b69-929a-25341b195a08",
          "resultId": "d81627fa-7f40-5448-99a9-9a5bca8416cb",
          "participantId": "c20a13ba-6710-5aae-9627-9701a040edcf",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Abigail Koh",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 214237, Nat: SGP."
        },
        {
          "rank": 33,
          "sourceName": "Keira Marie Carlyle",
          "name": "Keira Marie Carlyle",
          "sailOrBoardNumber": "212216",
          "nationality": "SGP",
          "gender": "W",
          "grossScore": 341,
          "nettScore": 300,
          "races": [
            {
              "raceNumber": 1,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 2,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 3,
              "score": 41,
              "code": null,
              "discarded": true,
              "raw": "(41)"
            },
            {
              "raceNumber": 4,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 5,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 6,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 7,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 8,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 9,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 10,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            }
          ],
          "sailorId": "be779040-d45c-4052-b458-9c9e88803505",
          "resultId": "3fc75038-e801-544e-ae51-ffbc7429dca7",
          "participantId": "228f451d-4afc-5999-bdd6-26bb31455cae",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Keira Marie Carlyle",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 212216, Nat: SGP."
        },
        {
          "rank": 34,
          "sourceName": "Yana Belozerova",
          "name": "Yana Belozerova",
          "sailOrBoardNumber": "210017",
          "nationality": "KAZ",
          "gender": "W",
          "grossScore": 343,
          "nettScore": 300,
          "races": [
            {
              "raceNumber": 1,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 2,
              "score": 43,
              "code": null,
              "discarded": true,
              "raw": "(43)"
            },
            {
              "raceNumber": 3,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 4,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 5,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 6,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 7,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 8,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 9,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 10,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            }
          ],
          "sailorId": "1a72ee9d-a796-5216-ae2a-45749663cbb3",
          "resultId": "3ba4c46d-d646-58c4-ad8d-fcdef811f818",
          "participantId": "48706e32-14db-57b8-8ede-541a1126ac25",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "KAZ",
          "officialName": "Yana Belozerova",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 210017, Nat: KAZ."
        },
        {
          "rank": 35,
          "sourceName": "Jiaqi Liu",
          "name": "Jiaqi Liu",
          "sailOrBoardNumber": "217674",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 345,
          "nettScore": 302,
          "races": [
            {
              "raceNumber": 1,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 2,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 3,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 4,
              "score": 43,
              "code": null,
              "discarded": true,
              "raw": "(43)"
            },
            {
              "raceNumber": 5,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 6,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 7,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 8,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 9,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 10,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            }
          ],
          "sailorId": "cc50d043-c2e0-520f-b4e6-dc65ce55e28b",
          "resultId": "3f74e72a-40ef-5cff-b1c4-ee91b32bbd20",
          "participantId": "6a966774-e271-5dc2-b57d-34e373b57e6e",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Jiaqi Liu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 217674, Nat: CHN."
        },
        {
          "rank": 36,
          "sourceName": "Yulin Tang",
          "name": "Yulin Tang",
          "sailOrBoardNumber": "215143",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 345,
          "nettScore": 306,
          "races": [
            {
              "raceNumber": 1,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 2,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 3,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 4,
              "score": 39,
              "code": null,
              "discarded": true,
              "raw": "(39)"
            },
            {
              "raceNumber": 5,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 6,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 7,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 8,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 9,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 10,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            }
          ],
          "sailorId": "233d7ada-4c57-52aa-8467-d6a4d0a15e07",
          "resultId": "c2c96e6f-dee0-5b39-a562-d0babf70f407",
          "participantId": "035e566b-bca1-5fc0-ae17-821a624f27ff",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yulin Tang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 215143, Nat: CHN."
        },
        {
          "rank": 37,
          "sourceName": "Nur Adlina Nasreen Mohd Nasri",
          "name": "Nur Adlina Nasreen Mohd Nasri",
          "sailOrBoardNumber": "209879",
          "nationality": "MAS",
          "gender": "W",
          "grossScore": 348,
          "nettScore": 308,
          "races": [
            {
              "raceNumber": 1,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 2,
              "score": 40,
              "code": null,
              "discarded": true,
              "raw": "(40)"
            },
            {
              "raceNumber": 3,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 4,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 5,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 6,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 7,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 8,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 9,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 10,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            }
          ],
          "sailorId": "1178dc0b-fa79-5969-b777-198a46b3aace",
          "resultId": "40d06863-0931-595e-a19c-f54ca0e70917",
          "participantId": "498d9917-a18f-5d44-87b3-367f13255433",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "MAS",
          "officialName": "Nur Adlina Nasreen Mohd Nasri",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 209879, Nat: MAS."
        },
        {
          "rank": 38,
          "sourceName": "Yuting Elisha Lim",
          "name": "Yuting Elisha Lim",
          "sailOrBoardNumber": "214808",
          "nationality": "SGP",
          "gender": "W",
          "grossScore": 353,
          "nettScore": 313,
          "races": [
            {
              "raceNumber": 1,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 2,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 3,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 4,
              "score": 40,
              "code": null,
              "discarded": true,
              "raw": "(40)"
            },
            {
              "raceNumber": 5,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 6,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 7,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 8,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 9,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 10,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            }
          ],
          "sailorId": "4e032d23-bc37-5247-901a-edf9616eb106",
          "resultId": "5d49b52a-14b9-5eab-8da4-4740d33a6d3e",
          "participantId": "037c44d9-063d-56d5-8c64-7f8f10efec76",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "SGP",
          "officialName": "Yuting Elisha Lim",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 214808, Nat: SGP."
        },
        {
          "rank": 39,
          "sourceName": "Charlotte Lee",
          "name": "Charlotte Lee",
          "sailOrBoardNumber": "214235",
          "nationality": "SGP",
          "gender": "W",
          "grossScore": 362,
          "nettScore": 320,
          "races": [
            {
              "raceNumber": 1,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 2,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 3,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 4,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 5,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 6,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 7,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 8,
              "score": 42,
              "code": null,
              "discarded": true,
              "raw": "(42)"
            },
            {
              "raceNumber": 9,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 10,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            }
          ],
          "sailorId": "aa04fecc-d984-4a81-8119-532dbbfea7fa",
          "resultId": "0f43a7d0-3715-5986-8cd9-9cb3b3f4204c",
          "participantId": "4b485eb4-1508-5acb-9b02-bd0c428dfa18",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Charlotte Lee",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 214235, Nat: SGP."
        },
        {
          "rank": 40,
          "sourceName": "Dhuha Al Besher",
          "name": "Dhuha Al Besher",
          "sailOrBoardNumber": "207889",
          "nationality": "UAE",
          "gender": "W",
          "grossScore": 364,
          "nettScore": 323,
          "races": [
            {
              "raceNumber": 1,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 2,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 3,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 4,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 5,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 6,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 7,
              "score": 41,
              "code": null,
              "discarded": true,
              "raw": "(41)"
            },
            {
              "raceNumber": 8,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 9,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 10,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            }
          ],
          "sailorId": "1fba40b3-c518-56d2-8a67-b193b8e9a583",
          "resultId": "169bbfdb-a807-5689-b8b3-e63f03d6b05a",
          "participantId": "922b0624-c257-521a-b9c4-9ba59b22a8d7",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "UAE",
          "officialName": "Dhuha Al Besher",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 207889, Nat: UAE."
        },
        {
          "rank": 41,
          "sourceName": "Sarah Hui Yan Seow",
          "name": "Sarah Hui Yan Seow",
          "sailOrBoardNumber": "219162",
          "nationality": "SGP",
          "gender": "W",
          "grossScore": 395,
          "nettScore": 350,
          "races": [
            {
              "raceNumber": 1,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 2,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 3,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            },
            {
              "raceNumber": 4,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 5,
              "score": 45,
              "code": "BFD",
              "discarded": true,
              "raw": "(45 BFD)"
            },
            {
              "raceNumber": 6,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 7,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 8,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            },
            {
              "raceNumber": 9,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 10,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            }
          ],
          "sailorId": "b68d3a38-afee-5160-9331-2d28fe3082b1",
          "resultId": "08303921-16f9-5c16-8389-4fa88ea95c96",
          "participantId": "2cf9020d-f9df-527e-8b7a-b86e66d29597",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "SGP",
          "officialName": "Sarah Hui Yan Seow",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 219162, Nat: SGP."
        },
        {
          "rank": 42,
          "sourceName": "Jing Lin",
          "name": "Jing Lin",
          "sailOrBoardNumber": "200503",
          "nationality": "CHN",
          "gender": "W",
          "grossScore": 398,
          "nettScore": 353,
          "races": [
            {
              "raceNumber": 1,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 2,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 3,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 4,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 5,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 6,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            },
            {
              "raceNumber": 7,
              "score": 45,
              "code": "RET",
              "discarded": true,
              "raw": "(45 RET)"
            },
            {
              "raceNumber": 8,
              "score": 45,
              "code": "DNC",
              "discarded": false,
              "raw": "45 DNC"
            },
            {
              "raceNumber": 9,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 10,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            }
          ],
          "sailorId": "17830c6e-f3f0-54cf-b304-a683ae9c5c94",
          "resultId": "f9fd5e5d-18a1-5895-abb8-8af51fa967a5",
          "participantId": "a16ea719-7a8e-56fd-9f3d-e9b323dadd36",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Jing Lin",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 200503, Nat: CHN."
        },
        {
          "rank": 43,
          "sourceName": "Yi San Huang",
          "name": "Yi San Huang",
          "sailOrBoardNumber": "221513",
          "nationality": "TPE",
          "gender": "W",
          "grossScore": 422,
          "nettScore": 377,
          "races": [
            {
              "raceNumber": 1,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 2,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 3,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 4,
              "score": 45,
              "code": "RET",
              "discarded": true,
              "raw": "(45 RET)"
            },
            {
              "raceNumber": 5,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 6,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 7,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            },
            {
              "raceNumber": 8,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 9,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 10,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            }
          ],
          "sailorId": "2bb09661-11b7-5714-a6b2-a495ed6f517f",
          "resultId": "034715b6-c822-54c0-a3fb-b4ac712c20fe",
          "participantId": "38fc715a-c99b-5c36-9cd1-9ae1b2c389b2",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "TPE",
          "officialName": "Yi San Huang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 6, Division: Women. Sail No: 221513, Nat: TPE."
        }
      ]
    },
    {
      "config": {
        "id": "b1a02024-a510-48e0-8003-000000000005",
        "slug": "2024-ilca-asian-open-championship-ilca7-men",
        "name": "2024 ILCA Asian Open Championship (ILCA 7 Men)",
        "boatClass": "ILCA 7",
        "division": "Men",
        "gender": "M",
        "raceCount": 10,
        "discardCount": 1,
        "entryType": "individual",
        "date": "2024-12-14",
        "endDate": "2024-12-20"
      },
      "results": [
        {
          "rank": 1,
          "sourceName": "Khairulnizam Mohd Afendy Abdullah",
          "name": "Khairulnizam Mohd Afendy Abdullah",
          "sailOrBoardNumber": "214989",
          "nationality": "MAS",
          "gender": "M",
          "grossScore": 76,
          "nettScore": 28,
          "races": [
            {
              "raceNumber": 1,
              "score": 48,
              "code": "UFD",
              "discarded": true,
              "raw": "(48 UFD)"
            },
            {
              "raceNumber": 2,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 3,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 4,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 5,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 6,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 7,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 8,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 9,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 10,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            }
          ],
          "sailorId": "335750be-e08c-56c5-84fb-70fbe14cfb77",
          "resultId": "abd35b2a-de97-58f6-851f-0c705818d464",
          "participantId": "aabe8e65-facd-5631-8996-b9a7626eda7f",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "MAS",
          "officialName": "Khairulnizam Mohd Afendy Abdullah",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 214989, Nat: MAS."
        },
        {
          "rank": 2,
          "sourceName": "Nicholas Halliday",
          "name": "Nicholas Halliday",
          "sailOrBoardNumber": "171979",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 38,
          "nettScore": 30,
          "races": [
            {
              "raceNumber": 1,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 2,
              "score": 8,
              "code": null,
              "discarded": true,
              "raw": "(8)"
            },
            {
              "raceNumber": 3,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 4,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 5,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 6,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 7,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 8,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 9,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 10,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            }
          ],
          "sailorId": "06bd4877-4d96-44b0-9f66-c14f0061fe59",
          "resultId": "6968b943-88bb-5d21-9c61-2ea5af5c8152",
          "participantId": "0845ac3f-99e4-5bdb-928f-db2722b66284",
          "isNewProfile": false,
          "identityBasis": "Corroborated international championship athlete identity",
          "sourceNationality": "HKG",
          "officialName": "Nicholas Halliday",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 171979, Nat: HKG."
        },
        {
          "rank": 3,
          "sourceName": "Vishnu Saravanan",
          "name": "Vishnu Saravanan",
          "sailOrBoardNumber": "218191",
          "nationality": "IND",
          "gender": "M",
          "grossScore": 52,
          "nettScore": 36,
          "races": [
            {
              "raceNumber": 1,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 2,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 3,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 4,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 5,
              "score": 16,
              "code": null,
              "discarded": true,
              "raw": "(16)"
            },
            {
              "raceNumber": 6,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 7,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 8,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 9,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 10,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            }
          ],
          "sailorId": "1b2c502f-5e5a-58e8-83f3-12817b1126f0",
          "resultId": "3ae045d0-e075-5731-ac85-82fbdbe45bda",
          "participantId": "532ce233-2e6d-5f2b-aee7-f194a7b6b91b",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "IND",
          "officialName": "Vishnu Saravanan",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 218191, Nat: IND."
        },
        {
          "rank": 4,
          "sourceName": "Arthit Mikhail Romanyk",
          "name": "Arthit Mikhail Romanyk",
          "sailOrBoardNumber": "213137",
          "nationality": "THA",
          "gender": "M",
          "grossScore": 57,
          "nettScore": 43,
          "races": [
            {
              "raceNumber": 1,
              "score": 14,
              "code": null,
              "discarded": true,
              "raw": "(14)"
            },
            {
              "raceNumber": 2,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 3,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 4,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 5,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 6,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 7,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 8,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 9,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 10,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            }
          ],
          "sailorId": "f724016b-a2d6-5d4b-82a0-5ad506ba3bfb",
          "resultId": "b642a014-5138-5495-be6f-3a59b5f3a6ae",
          "participantId": "94ffdff5-d0c4-563b-8e82-206a351fcdce",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "THA",
          "officialName": "Arthit Mikhail Romanyk",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 213137, Nat: THA."
        },
        {
          "rank": 5,
          "sourceName": "Junsuo Luo",
          "name": "Junsuo Luo",
          "sailOrBoardNumber": "211215",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 71,
          "nettScore": 57,
          "races": [
            {
              "raceNumber": 1,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 2,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 3,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 4,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 5,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 6,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 7,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 8,
              "score": 14,
              "code": null,
              "discarded": true,
              "raw": "(14)"
            },
            {
              "raceNumber": 9,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 10,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            }
          ],
          "sailorId": "10f3de1f-2d2c-57be-accf-af2ff0939ae6",
          "resultId": "f2dacc46-02bc-5695-a2e0-62280f4e3629",
          "participantId": "71af4cc4-6c0e-53e2-ab0a-1fc40458a90f",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Junsuo Luo",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 211215, Nat: CHN."
        },
        {
          "rank": 6,
          "sourceName": "Yinsheng Cui",
          "name": "Yinsheng Cui",
          "sailOrBoardNumber": "222932",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 81,
          "nettScore": 63,
          "races": [
            {
              "raceNumber": 1,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 2,
              "score": 18,
              "code": null,
              "discarded": true,
              "raw": "(18)"
            },
            {
              "raceNumber": 3,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 4,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 5,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 6,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 7,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 8,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 9,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 10,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            }
          ],
          "sailorId": "714435d8-312f-577a-b678-088623ed34d6",
          "resultId": "525758f1-2327-5d80-b2ad-0a454c93495f",
          "participantId": "f3f5f578-e6b1-5897-ad68-74c4c192e31d",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yinsheng Cui",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 222932, Nat: CHN."
        },
        {
          "rank": 7,
          "sourceName": "Zili Wang",
          "name": "Zili Wang",
          "sailOrBoardNumber": "222922",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 102,
          "nettScore": 76,
          "races": [
            {
              "raceNumber": 1,
              "score": 26,
              "code": null,
              "discarded": true,
              "raw": "(26)"
            },
            {
              "raceNumber": 2,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 3,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 4,
              "score": 1,
              "code": null,
              "discarded": false,
              "raw": "1"
            },
            {
              "raceNumber": 5,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 6,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 7,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 8,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 9,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 10,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            }
          ],
          "sailorId": "6ed0bf3b-982d-52f6-ac9e-56792c81fe6a",
          "resultId": "a5552b35-6c44-50dd-8d32-d4340951f8a5",
          "participantId": "88bdb91a-c4bf-597d-868a-0f98a75669ae",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Zili Wang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 222922, Nat: CHN."
        },
        {
          "rank": 8,
          "sourceName": "Yuanshuai Tang",
          "name": "Yuanshuai Tang",
          "sailOrBoardNumber": "211177",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 116,
          "nettScore": 96,
          "races": [
            {
              "raceNumber": 1,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 2,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 3,
              "score": 20,
              "code": null,
              "discarded": true,
              "raw": "(20)"
            },
            {
              "raceNumber": 4,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 5,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 6,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 7,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 8,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 9,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 10,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            }
          ],
          "sailorId": "03fe14f0-5ced-502b-98b0-a351c62258e5",
          "resultId": "1257c7b0-a1cc-5d45-b851-976e31e9f47f",
          "participantId": "0ab515ba-282b-5dee-b4e1-c6a142ffbb63",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yuanshuai Tang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 211177, Nat: CHN."
        },
        {
          "rank": 9,
          "sourceName": "Kaixing Ju",
          "name": "Kaixing Ju",
          "sailOrBoardNumber": "221036",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 128,
          "nettScore": 100,
          "races": [
            {
              "raceNumber": 1,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 2,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 3,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 4,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 5,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 6,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 7,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 8,
              "score": 28,
              "code": null,
              "discarded": true,
              "raw": "(28)"
            },
            {
              "raceNumber": 9,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 10,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            }
          ],
          "sailorId": "19d84d38-56d5-53b6-9f54-e69599e8a2d1",
          "resultId": "09d2274f-3535-573a-92ef-49da973c478d",
          "participantId": "84aa1ccd-9015-5d4f-a4df-bf066461ed7f",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Kaixing Ju",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 221036, Nat: CHN."
        },
        {
          "rank": 10,
          "sourceName": "Rong Chen",
          "name": "Rong Chen",
          "sailOrBoardNumber": "211526",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 142,
          "nettScore": 101,
          "races": [
            {
              "raceNumber": 1,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 2,
              "score": 41,
              "code": null,
              "discarded": true,
              "raw": "(41)"
            },
            {
              "raceNumber": 3,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 4,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 5,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 6,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 7,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 8,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 9,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 10,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            }
          ],
          "sailorId": "6d9f3f93-0702-5961-bef2-45099f5f74a0",
          "resultId": "5653a742-8afd-5677-a9a3-42e4e8df23c2",
          "participantId": "061d27f8-7821-57e9-adbd-b3b86a441e02",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Rong Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 211526, Nat: CHN."
        },
        {
          "rank": 11,
          "sourceName": "Shengxin Fan",
          "name": "Shengxin Fan",
          "sailOrBoardNumber": "215257",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 138,
          "nettScore": 102,
          "races": [
            {
              "raceNumber": 1,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 2,
              "score": 36,
              "code": null,
              "discarded": true,
              "raw": "(36)"
            },
            {
              "raceNumber": 3,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 4,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 5,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 6,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 7,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 8,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 9,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 10,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            }
          ],
          "sailorId": "59438234-857e-53f3-8e9e-349204931a73",
          "resultId": "a53651b4-39d1-5cfb-93af-3d5343cc45fc",
          "participantId": "a55524a4-ff01-50e5-90d9-cbd0b7726017",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Shengxin Fan",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 215257, Nat: CHN."
        },
        {
          "rank": 12,
          "sourceName": "Bo Jeong",
          "name": "Bo Jeong",
          "sailOrBoardNumber": "223204",
          "nationality": "KOR",
          "gender": "M",
          "grossScore": 133,
          "nettScore": 103,
          "races": [
            {
              "raceNumber": 1,
              "score": 30,
              "code": null,
              "discarded": true,
              "raw": "(30)"
            },
            {
              "raceNumber": 2,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 3,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 4,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 5,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 6,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 7,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 8,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 9,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 10,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            }
          ],
          "sailorId": "5526abbf-1430-56af-bc56-281233e66d8e",
          "resultId": "3e0656b3-d847-5177-ad30-cd14196821b7",
          "participantId": "e8060675-2560-531b-8b61-031d5fa75452",
          "isNewProfile": false,
          "identityBasis": "Exact name and nationality (KOR) match in database",
          "sourceNationality": "KOR",
          "officialName": "Bo Jeong",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 223204, Nat: KOR."
        },
        {
          "rank": 13,
          "sourceName": "Wenlong Han",
          "name": "Wenlong Han",
          "sailOrBoardNumber": "211127",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 134,
          "nettScore": 109,
          "races": [
            {
              "raceNumber": 1,
              "score": 2,
              "code": null,
              "discarded": false,
              "raw": "2"
            },
            {
              "raceNumber": 2,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 3,
              "score": 25,
              "code": null,
              "discarded": true,
              "raw": "(25)"
            },
            {
              "raceNumber": 4,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 5,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 6,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 7,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 8,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 9,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 10,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            }
          ],
          "sailorId": "13e580f5-d394-581b-a73b-4de70d4a988e",
          "resultId": "acb96dc6-78d1-553a-b04e-e0ad1dedc9c6",
          "participantId": "37c65757-dba9-510d-be79-1827d0adbddf",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Wenlong Han",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 211127, Nat: CHN."
        },
        {
          "rank": 14,
          "sourceName": "Guikun Lin",
          "name": "Guikun Lin",
          "sailOrBoardNumber": "217671",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 160,
          "nettScore": 112,
          "races": [
            {
              "raceNumber": 1,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 2,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 3,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 4,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 5,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 6,
              "score": 48,
              "code": "UFD",
              "discarded": true,
              "raw": "(48 UFD)"
            },
            {
              "raceNumber": 7,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 8,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 9,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 10,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            }
          ],
          "sailorId": "8a2b5894-7d26-53b3-bbfc-a6310d8945f2",
          "resultId": "13397efe-15a2-5e71-8d86-c41f306f9ab9",
          "participantId": "cbd67838-1167-539d-9c68-75cf55baaaab",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Guikun Lin",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 217671, Nat: CHN."
        },
        {
          "rank": 15,
          "sourceName": "Zeen Huang",
          "name": "Zeen Huang",
          "sailOrBoardNumber": "211517",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 139,
          "nettScore": 115,
          "races": [
            {
              "raceNumber": 1,
              "score": 6,
              "code": null,
              "discarded": false,
              "raw": "6"
            },
            {
              "raceNumber": 2,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 3,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 4,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 5,
              "score": 24,
              "code": null,
              "discarded": true,
              "raw": "(24)"
            },
            {
              "raceNumber": 6,
              "score": 8,
              "code": null,
              "discarded": false,
              "raw": "8"
            },
            {
              "raceNumber": 7,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 8,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 9,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 10,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            }
          ],
          "sailorId": "9bb223e1-a98f-570a-9beb-fbbb3e794e45",
          "resultId": "3031ec68-58a1-5ba1-8493-d750e8b45328",
          "participantId": "e25b91a9-b8b1-5ef6-8d32-e62e42bd4fb9",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Zeen Huang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 211517, Nat: CHN."
        },
        {
          "rank": 16,
          "sourceName": "Zhihao Gu",
          "name": "Zhihao Gu",
          "sailOrBoardNumber": "218678",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 166,
          "nettScore": 137,
          "races": [
            {
              "raceNumber": 1,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 2,
              "score": 29,
              "code": null,
              "discarded": true,
              "raw": "(29)"
            },
            {
              "raceNumber": 3,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 4,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 5,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 6,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 7,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 8,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 9,
              "score": 10,
              "code": null,
              "discarded": false,
              "raw": "10"
            },
            {
              "raceNumber": 10,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            }
          ],
          "sailorId": "206be18b-6b97-5f65-a0f6-8cde177e997c",
          "resultId": "4c58ae84-14b4-5faa-a3d9-1290a988022a",
          "participantId": "90a89453-767d-5601-90a4-b2d5056b5b32",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Zhihao Gu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 218678, Nat: CHN."
        },
        {
          "rank": 17,
          "sourceName": "Jindong Kong",
          "name": "Jindong Kong",
          "sailOrBoardNumber": "221035",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 166,
          "nettScore": 141,
          "races": [
            {
              "raceNumber": 1,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 2,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 3,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 4,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 5,
              "score": 5,
              "code": null,
              "discarded": false,
              "raw": "5"
            },
            {
              "raceNumber": 6,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 7,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 8,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 9,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 10,
              "score": 25,
              "code": null,
              "discarded": true,
              "raw": "(25)"
            }
          ],
          "sailorId": "d2c623ee-eeca-55e7-bb37-3a0f54b601bf",
          "resultId": "6f9d5aaf-47b7-5553-a9d9-e419316f3801",
          "participantId": "20292311-1c70-5238-a641-593a0e3d1abe",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Jindong Kong",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 221035, Nat: CHN."
        },
        {
          "rank": 18,
          "sourceName": "Yang Yang",
          "name": "Yang Yang",
          "sailOrBoardNumber": "222747",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 193,
          "nettScore": 163,
          "races": [
            {
              "raceNumber": 1,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 2,
              "score": 4,
              "code": null,
              "discarded": false,
              "raw": "4"
            },
            {
              "raceNumber": 3,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 4,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 5,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 6,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 7,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 8,
              "score": 30,
              "code": null,
              "discarded": true,
              "raw": "(30)"
            },
            {
              "raceNumber": 9,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 10,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            }
          ],
          "sailorId": "135e78b0-bf1c-5289-bde8-9e28aeff52b9",
          "resultId": "993e31d0-71c1-5007-bed2-94dc143b64ef",
          "participantId": "0677378f-ec23-5486-883f-50a53c61a81d",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yang Yang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 222747, Nat: CHN."
        },
        {
          "rank": 19,
          "sourceName": "Yukun Zhao",
          "name": "Yukun Zhao",
          "sailOrBoardNumber": "210127",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 191,
          "nettScore": 165,
          "races": [
            {
              "raceNumber": 1,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 2,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 3,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 4,
              "score": 26,
              "code": null,
              "discarded": true,
              "raw": "(26)"
            },
            {
              "raceNumber": 5,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 6,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 7,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 8,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 9,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 10,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            }
          ],
          "sailorId": "e4dbf95a-8b82-5500-b709-346f51a21d81",
          "resultId": "466b0e5b-03eb-5849-ba7a-dbb474037869",
          "participantId": "984067d2-e24f-5b38-b13b-17366dee2a7d",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yukun Zhao",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 210127, Nat: CHN."
        },
        {
          "rank": 20,
          "sourceName": "Haotian Li",
          "name": "Haotian Li",
          "sailOrBoardNumber": "211371",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 197,
          "nettScore": 170,
          "races": [
            {
              "raceNumber": 1,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 2,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 3,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 4,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 5,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 6,
              "score": 27,
              "code": null,
              "discarded": true,
              "raw": "(27)"
            },
            {
              "raceNumber": 7,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 8,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 9,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 10,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            }
          ],
          "sailorId": "be8460e4-3337-536d-a1c0-b0a2c5ecb08d",
          "resultId": "148cd462-b225-5d99-969d-27beba543e46",
          "participantId": "93baa999-6c51-52d7-9039-bc4bd8423c65",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Haotian Li",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 211371, Nat: CHN."
        },
        {
          "rank": 21,
          "sourceName": "Jun Long Wang",
          "name": "Jun Long Wang",
          "sailOrBoardNumber": "217672",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 220,
          "nettScore": 172,
          "races": [
            {
              "raceNumber": 1,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 2,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 3,
              "score": 19,
              "code": "SCP30%",
              "discarded": false,
              "raw": "19 SCP30%"
            },
            {
              "raceNumber": 4,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 5,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            },
            {
              "raceNumber": 6,
              "score": 48,
              "code": "UFD",
              "discarded": true,
              "raw": "(48 UFD)"
            },
            {
              "raceNumber": 7,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 8,
              "score": 3,
              "code": null,
              "discarded": false,
              "raw": "3"
            },
            {
              "raceNumber": 9,
              "score": 48,
              "code": "UFD",
              "discarded": false,
              "raw": "48 UFD"
            },
            {
              "raceNumber": 10,
              "score": 9,
              "code": null,
              "discarded": false,
              "raw": "9"
            }
          ],
          "sailorId": "b43e59c6-4298-5493-8760-8d006e4454f1",
          "resultId": "6846b414-23f2-5d6c-80cb-a85374ccd99c",
          "participantId": "9234ac84-1412-56c8-8a9e-1d68d6d58c93",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Jun Long Wang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 217672, Nat: CHN."
        },
        {
          "rank": 22,
          "sourceName": "Wei Da Yu",
          "name": "Wei Da Yu",
          "sailOrBoardNumber": "223723",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 222,
          "nettScore": 174,
          "races": [
            {
              "raceNumber": 1,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 2,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 3,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 4,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 5,
              "score": 11,
              "code": null,
              "discarded": false,
              "raw": "11"
            },
            {
              "raceNumber": 6,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 7,
              "score": 48,
              "code": "BFD",
              "discarded": true,
              "raw": "(48 BFD)"
            },
            {
              "raceNumber": 8,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 9,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 10,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            }
          ],
          "sailorId": "4b500994-9ac9-54d8-9d2d-104d06224b42",
          "resultId": "95666799-d59e-5e28-895a-dfb8bfff830a",
          "participantId": "c4fd9666-5be9-5867-85ac-028294060fb6",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Wei Da Yu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 223723, Nat: CHN."
        },
        {
          "rank": 23,
          "sourceName": "Peter Jessop",
          "name": "Peter Jessop",
          "sailOrBoardNumber": "215313",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 218,
          "nettScore": 186,
          "races": [
            {
              "raceNumber": 1,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 2,
              "score": 7,
              "code": null,
              "discarded": false,
              "raw": "7"
            },
            {
              "raceNumber": 3,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 4,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 5,
              "score": 32,
              "code": null,
              "discarded": true,
              "raw": "(32)"
            },
            {
              "raceNumber": 6,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 7,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 8,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 9,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 10,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            }
          ],
          "sailorId": "3df2c6a7-b3fa-5b9d-80a8-20e66638c2f5",
          "resultId": "3eee4a18-e6f2-520e-9297-328ef34ab288",
          "participantId": "04f5bc04-4e8a-57a9-95c1-a3bba9b90db2",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "HKG",
          "officialName": "Peter Jessop",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 215313, Nat: HKG."
        },
        {
          "rank": 24,
          "sourceName": "Muhammad Faizal Ahmad Asri",
          "name": "Muhammad Faizal Ahmad Asri",
          "sailOrBoardNumber": "209889",
          "nationality": "MAS",
          "gender": "M",
          "grossScore": 236,
          "nettScore": 188,
          "races": [
            {
              "raceNumber": 1,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 2,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            },
            {
              "raceNumber": 3,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 4,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 5,
              "score": 13,
              "code": null,
              "discarded": false,
              "raw": "13"
            },
            {
              "raceNumber": 6,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 7,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 8,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 9,
              "score": 48,
              "code": "UFD",
              "discarded": true,
              "raw": "(48 UFD)"
            },
            {
              "raceNumber": 10,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            }
          ],
          "sailorId": "4afd9393-8797-5468-9141-adffeee998d9",
          "resultId": "bcc53d8e-8f5d-5b88-9091-5a279dcf1a7b",
          "participantId": "dd78ea40-88de-5c67-8492-5949d889f1dc",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "MAS",
          "officialName": "Muhammad Faizal Ahmad Asri",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 209889, Nat: MAS."
        },
        {
          "rank": 25,
          "sourceName": "Yang Huang",
          "name": "Yang Huang",
          "sailOrBoardNumber": "209964",
          "nationality": "TPE",
          "gender": "M",
          "grossScore": 244,
          "nettScore": 196,
          "races": [
            {
              "raceNumber": 1,
              "score": 48,
              "code": "UFD",
              "discarded": true,
              "raw": "(48 UFD)"
            },
            {
              "raceNumber": 2,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 3,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 4,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 5,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 6,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 7,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 8,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 9,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 10,
              "score": 14,
              "code": null,
              "discarded": false,
              "raw": "14"
            }
          ],
          "sailorId": "6a1927b4-9af9-5ca1-aa3a-512511e88263",
          "resultId": "3bbb7658-3ea1-5230-8dce-96536e93e0bb",
          "participantId": "bb388f12-64e2-5924-97e6-59260a2619b4",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "TPE",
          "officialName": "Yang Huang",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 209964, Nat: TPE."
        },
        {
          "rank": 26,
          "sourceName": "Tsai-Chien Wu",
          "name": "Tsai-Chien Wu",
          "sailOrBoardNumber": "214123",
          "nationality": "TPE",
          "gender": "M",
          "grossScore": 256,
          "nettScore": 208,
          "races": [
            {
              "raceNumber": 1,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 2,
              "score": 16,
              "code": null,
              "discarded": false,
              "raw": "16"
            },
            {
              "raceNumber": 3,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 4,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 5,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 6,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 7,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 8,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 9,
              "score": 48,
              "code": "UFD",
              "discarded": true,
              "raw": "(48 UFD)"
            },
            {
              "raceNumber": 10,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            }
          ],
          "sailorId": "363e5317-2c81-5af0-b407-6717ac0b3bda",
          "resultId": "c8930dfb-6c34-5893-beaf-f597e01119bb",
          "participantId": "5e80ddfa-11d6-5d33-bdfc-cf6385497560",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "TPE",
          "officialName": "Tsai-Chien Wu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 214123, Nat: TPE."
        },
        {
          "rank": 27,
          "sourceName": "Yihong Xu",
          "name": "Yihong Xu",
          "sailOrBoardNumber": "217668",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 238,
          "nettScore": 208,
          "races": [
            {
              "raceNumber": 1,
              "score": 19,
              "code": null,
              "discarded": false,
              "raw": "19"
            },
            {
              "raceNumber": 2,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 3,
              "score": 21,
              "code": null,
              "discarded": false,
              "raw": "21"
            },
            {
              "raceNumber": 4,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 5,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 6,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 7,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 8,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            },
            {
              "raceNumber": 9,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 10,
              "score": 30,
              "code": null,
              "discarded": true,
              "raw": "(30)"
            }
          ],
          "sailorId": "6abcf385-0642-56a7-8dc5-e310566104d9",
          "resultId": "816a14a1-63ea-5fed-877d-ed0742452d2b",
          "participantId": "da756209-e5bc-54ff-9714-742ae995e9d4",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yihong Xu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 217668, Nat: CHN."
        },
        {
          "rank": 28,
          "sourceName": "Siyou Sung",
          "name": "Siyou Sung",
          "sailOrBoardNumber": "221012",
          "nationality": "KOR",
          "gender": "M",
          "grossScore": 278,
          "nettScore": 230,
          "races": [
            {
              "raceNumber": 1,
              "score": 17,
              "code": null,
              "discarded": false,
              "raw": "17"
            },
            {
              "raceNumber": 2,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 3,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 4,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 5,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 6,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 7,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 8,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 9,
              "score": 48,
              "code": "DNS",
              "discarded": true,
              "raw": "(48 DNS)"
            },
            {
              "raceNumber": 10,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            }
          ],
          "sailorId": "7c3fec16-1a4b-596e-aebf-ed02c0beb585",
          "resultId": "74670853-c8b1-5697-813e-3871f08bc984",
          "participantId": "0a852755-dc02-538f-8640-e5d522b1ae67",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "KOR",
          "officialName": "Siyou Sung",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 221012, Nat: KOR."
        },
        {
          "rank": 29,
          "sourceName": "Wai Chak Tsui",
          "name": "Wai Chak Tsui",
          "sailOrBoardNumber": "209950",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 269,
          "nettScore": 233,
          "races": [
            {
              "raceNumber": 1,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 2,
              "score": 12,
              "code": null,
              "discarded": false,
              "raw": "12"
            },
            {
              "raceNumber": 3,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 4,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 5,
              "score": 36,
              "code": null,
              "discarded": true,
              "raw": "(36)"
            },
            {
              "raceNumber": 6,
              "score": 18,
              "code": null,
              "discarded": false,
              "raw": "18"
            },
            {
              "raceNumber": 7,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 8,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 9,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 10,
              "score": 22,
              "code": null,
              "discarded": false,
              "raw": "22"
            }
          ],
          "sailorId": "1783433c-eb9b-5854-b99f-399a81970859",
          "resultId": "289f3a83-9de2-5885-8e7c-75f13ff331d7",
          "participantId": "22d96a62-dadf-5d78-8a40-c2c6d8c5952c",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "HKG",
          "officialName": "Wai Chak Tsui",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 209950, Nat: HKG."
        },
        {
          "rank": 30,
          "sourceName": "Lei Fan Lin",
          "name": "Lei Fan Lin",
          "sailOrBoardNumber": "217755",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 303,
          "nettScore": 255,
          "races": [
            {
              "raceNumber": 1,
              "score": 15,
              "code": null,
              "discarded": false,
              "raw": "15"
            },
            {
              "raceNumber": 2,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 3,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 4,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 5,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 6,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 7,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 8,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 9,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 10,
              "score": 48,
              "code": "BFD",
              "discarded": true,
              "raw": "(48 BFD)"
            }
          ],
          "sailorId": "4ad7a9aa-7980-5c67-a5f1-ca965d722a4b",
          "resultId": "48ef9dc7-b417-5762-abb8-a8cc316561e1",
          "participantId": "9a9ccfd6-16ea-50ea-ba8b-963a208b3aa6",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Lei Fan Lin",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 217755, Nat: CHN."
        },
        {
          "rank": 31,
          "sourceName": "Patrick Ziteng Feng",
          "name": "Patrick Ziteng Feng",
          "sailOrBoardNumber": "209948",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 300,
          "nettScore": 263,
          "races": [
            {
              "raceNumber": 1,
              "score": 20,
              "code": null,
              "discarded": false,
              "raw": "20"
            },
            {
              "raceNumber": 2,
              "score": 37,
              "code": null,
              "discarded": true,
              "raw": "(37)"
            },
            {
              "raceNumber": 3,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 4,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 5,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 6,
              "score": 26,
              "code": null,
              "discarded": false,
              "raw": "26"
            },
            {
              "raceNumber": 7,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 8,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 9,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 10,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            }
          ],
          "sailorId": "9528945c-c924-5f8c-8420-9911df50923f",
          "resultId": "cdf5487c-89d1-5546-b218-60619b7ab869",
          "participantId": "4301be0a-65c3-5e72-9b96-5e1282742504",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Patrick Ziteng Feng",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 209948, Nat: CHN."
        },
        {
          "rank": 32,
          "sourceName": "NuoSen Yao",
          "name": "NuoSen Yao",
          "sailOrBoardNumber": "217670",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 312,
          "nettScore": 264,
          "races": [
            {
              "raceNumber": 1,
              "score": 48,
              "code": "UFD",
              "discarded": true,
              "raw": "(48 UFD)"
            },
            {
              "raceNumber": 2,
              "score": 25,
              "code": null,
              "discarded": false,
              "raw": "25"
            },
            {
              "raceNumber": 3,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 4,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 5,
              "score": 30,
              "code": null,
              "discarded": false,
              "raw": "30"
            },
            {
              "raceNumber": 6,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 7,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 8,
              "score": 23,
              "code": null,
              "discarded": false,
              "raw": "23"
            },
            {
              "raceNumber": 9,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 10,
              "score": 48,
              "code": "BFD",
              "discarded": false,
              "raw": "48 BFD"
            }
          ],
          "sailorId": "3c727d01-02a3-5719-8b30-4f7d6ca8c767",
          "resultId": "49857066-516f-5c7b-8e38-18fb9c2c5558",
          "participantId": "4f2ebcca-c297-5cef-94e8-66063ae79b95",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "NuoSen Yao",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 217670, Nat: CHN."
        },
        {
          "rank": 33,
          "sourceName": "Jarrod Toh",
          "name": "Jarrod Toh",
          "sailOrBoardNumber": "214748",
          "nationality": "SGP",
          "gender": "M",
          "grossScore": 303,
          "nettScore": 269,
          "races": [
            {
              "raceNumber": 1,
              "score": 24,
              "code": null,
              "discarded": false,
              "raw": "24"
            },
            {
              "raceNumber": 2,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 3,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 4,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 5,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 6,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 7,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 8,
              "score": 34,
              "code": null,
              "discarded": true,
              "raw": "(34)"
            },
            {
              "raceNumber": 9,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 10,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            }
          ],
          "sailorId": "34e36e78-abc0-4ba7-9739-3fe5b465be89",
          "resultId": "ec39892b-c8dd-560c-a307-475b2142fd6f",
          "participantId": "bffc4f17-70f4-5f63-8f11-62395d8c66c6",
          "isNewProfile": false,
          "identityBasis": "Corroborated Singapore youth squad athlete identity",
          "sourceNationality": "SGP",
          "officialName": "Jarrod Toh",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 214748, Nat: SGP."
        },
        {
          "rank": 34,
          "sourceName": "Junjie Qiu",
          "name": "Junjie Qiu",
          "sailOrBoardNumber": "221544",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 353,
          "nettScore": 305,
          "races": [
            {
              "raceNumber": 1,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 2,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 3,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 4,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 5,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 6,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 7,
              "score": 48,
              "code": "BFD",
              "discarded": true,
              "raw": "(48 BFD)"
            },
            {
              "raceNumber": 8,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 9,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 10,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            }
          ],
          "sailorId": "34b7c1ef-c8bc-5a54-abf7-368cb63474e2",
          "resultId": "93325c6b-629b-5e28-aae3-8a7e8ad019d8",
          "participantId": "209ad5ac-6256-57c6-8c8e-a8f7fd834db2",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Junjie Qiu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 221544, Nat: CHN."
        },
        {
          "rank": 35,
          "sourceName": "Hongxiang Chen",
          "name": "Hongxiang Chen",
          "sailOrBoardNumber": "221546",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 347,
          "nettScore": 307,
          "races": [
            {
              "raceNumber": 1,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 2,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 3,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 4,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 5,
              "score": 40,
              "code": null,
              "discarded": true,
              "raw": "(40)"
            },
            {
              "raceNumber": 6,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 7,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 8,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 9,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 10,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            }
          ],
          "sailorId": "55d48d99-79a3-531d-a623-062f911c1238",
          "resultId": "1b4aba0d-1b42-5a7f-9e3b-a03aa10799c3",
          "participantId": "2a5cc3b0-3785-5c8d-af88-73090811456c",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Hongxiang Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 221546, Nat: CHN."
        },
        {
          "rank": 36,
          "sourceName": "Guanguo Xie",
          "name": "Guanguo Xie",
          "sailOrBoardNumber": "221547",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 355,
          "nettScore": 310,
          "races": [
            {
              "raceNumber": 1,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 2,
              "score": 45,
              "code": null,
              "discarded": true,
              "raw": "(45)"
            },
            {
              "raceNumber": 3,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 4,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 5,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 6,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 7,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 8,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 9,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 10,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            }
          ],
          "sailorId": "74649a91-150b-563f-af61-e9ad39199bfa",
          "resultId": "85726540-fcb0-5097-bb81-833070abc63e",
          "participantId": "56d9323a-083b-5781-87b2-851466c62abf",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Guanguo Xie",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 221547, Nat: CHN."
        },
        {
          "rank": 37,
          "sourceName": "Muhammad Asnawi Iqbal Adam",
          "name": "Muhammad Asnawi Iqbal Adam",
          "sailOrBoardNumber": "209888",
          "nationality": "MAS",
          "gender": "M",
          "grossScore": 362,
          "nettScore": 320,
          "races": [
            {
              "raceNumber": 1,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 2,
              "score": 42,
              "code": null,
              "discarded": true,
              "raw": "(42)"
            },
            {
              "raceNumber": 3,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 4,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 5,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 6,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 7,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 8,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 9,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 10,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            }
          ],
          "sailorId": "1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7",
          "resultId": "ec650c30-d9c1-5d09-ad56-7d28c2a8cd26",
          "participantId": "60fcf9bd-c4f4-535d-b8ba-c19aae08b758",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "MAS",
          "officialName": "Muhammad Asnawi Iqbal Adam",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 209888, Nat: MAS."
        },
        {
          "rank": 38,
          "sourceName": "Anton Gaas",
          "name": "Anton Gaas",
          "sailOrBoardNumber": "210890",
          "nationality": "KAZ",
          "gender": "M",
          "grossScore": 365,
          "nettScore": 323,
          "races": [
            {
              "raceNumber": 1,
              "score": 31,
              "code": null,
              "discarded": false,
              "raw": "31"
            },
            {
              "raceNumber": 2,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 3,
              "score": 42,
              "code": null,
              "discarded": true,
              "raw": "(42)"
            },
            {
              "raceNumber": 4,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 5,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 6,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 7,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 8,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 9,
              "score": 34,
              "code": null,
              "discarded": false,
              "raw": "34"
            },
            {
              "raceNumber": 10,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            }
          ],
          "sailorId": "335626a6-e74b-5cdf-94f1-74eed0680be4",
          "resultId": "cbd8887a-7250-54d8-a99d-d3f6cac33683",
          "participantId": "621c1add-ba77-59fd-bc98-19278f26ccf5",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "KAZ",
          "officialName": "Anton Gaas",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 210890, Nat: KAZ."
        },
        {
          "rank": 39,
          "sourceName": "Lok Hin Luk",
          "name": "Lok Hin Luk",
          "sailOrBoardNumber": "211713",
          "nationality": "HKG",
          "gender": "M",
          "grossScore": 367,
          "nettScore": 324,
          "races": [
            {
              "raceNumber": 1,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 2,
              "score": 43,
              "code": null,
              "discarded": true,
              "raw": "(43)"
            },
            {
              "raceNumber": 3,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 4,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 5,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 6,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 7,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 8,
              "score": 32,
              "code": null,
              "discarded": false,
              "raw": "32"
            },
            {
              "raceNumber": 9,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 10,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            }
          ],
          "sailorId": "d93fa781-901e-5532-bbc2-c38a9f653fb0",
          "resultId": "d26f5248-c21c-5730-bf97-9e74934fcc5c",
          "participantId": "f4d86017-973d-5cbd-92b7-adf93072595f",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "HKG",
          "officialName": "Lok Hin Luk",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 211713, Nat: HKG."
        },
        {
          "rank": 40,
          "sourceName": "Yuan-Chun Lin",
          "name": "Yuan-Chun Lin",
          "sailOrBoardNumber": "225799",
          "nationality": "TPE",
          "gender": "M",
          "grossScore": 386,
          "nettScore": 343,
          "races": [
            {
              "raceNumber": 1,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 2,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 3,
              "score": 43,
              "code": null,
              "discarded": true,
              "raw": "(43)"
            },
            {
              "raceNumber": 4,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 5,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 6,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 7,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 8,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 9,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 10,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            }
          ],
          "sailorId": "1061c4af-d39b-52d8-93e5-0290b773acf9",
          "resultId": "2d7189d1-945a-5516-b925-3bf824b451c8",
          "participantId": "6f71c8dc-c3d2-51ff-90e6-f09a0a7900e8",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "TPE",
          "officialName": "Yuan-Chun Lin",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 225799, Nat: TPE."
        },
        {
          "rank": 41,
          "sourceName": "Chan Nhov",
          "name": "Chan Nhov",
          "sailOrBoardNumber": "211727",
          "nationality": "CAM",
          "gender": "M",
          "grossScore": 387,
          "nettScore": 344,
          "races": [
            {
              "raceNumber": 1,
              "score": 29,
              "code": null,
              "discarded": false,
              "raw": "29"
            },
            {
              "raceNumber": 2,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 3,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 4,
              "score": 43,
              "code": null,
              "discarded": true,
              "raw": "(43)"
            },
            {
              "raceNumber": 5,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 6,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 7,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 8,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            },
            {
              "raceNumber": 9,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 10,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            }
          ],
          "sailorId": "bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde",
          "resultId": "513a8a3f-6337-54a3-a84d-121a709526af",
          "participantId": "ea3d53c1-f017-59fa-9ded-2013dc6b3d51",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CAM",
          "officialName": "Chan Nhov",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 211727, Nat: CAM."
        },
        {
          "rank": 42,
          "sourceName": "Nan Chen",
          "name": "Nan Chen",
          "sailOrBoardNumber": "211985",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 400,
          "nettScore": 356,
          "races": [
            {
              "raceNumber": 1,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 2,
              "score": 33,
              "code": null,
              "discarded": false,
              "raw": "33"
            },
            {
              "raceNumber": 3,
              "score": 44,
              "code": null,
              "discarded": true,
              "raw": "(44)"
            },
            {
              "raceNumber": 4,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 5,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 6,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 7,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 8,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 9,
              "score": 38,
              "code": null,
              "discarded": false,
              "raw": "38"
            },
            {
              "raceNumber": 10,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            }
          ],
          "sailorId": "9d364cd0-cc84-585c-bb0b-768f10d5af1d",
          "resultId": "c1b76000-a441-5cd6-ab10-23b6d4ede4f2",
          "participantId": "1186da6f-8345-588d-855e-ae1869f35dce",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Nan Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 211985, Nat: CHN."
        },
        {
          "rank": 43,
          "sourceName": "Yu-Shin Chen",
          "name": "Yu-Shin Chen",
          "sailOrBoardNumber": "213037",
          "nationality": "TPE",
          "gender": "M",
          "grossScore": 414,
          "nettScore": 366,
          "races": [
            {
              "raceNumber": 1,
              "score": 28,
              "code": null,
              "discarded": false,
              "raw": "28"
            },
            {
              "raceNumber": 2,
              "score": 27,
              "code": null,
              "discarded": false,
              "raw": "27"
            },
            {
              "raceNumber": 3,
              "score": 35,
              "code": null,
              "discarded": false,
              "raw": "35"
            },
            {
              "raceNumber": 4,
              "score": 36,
              "code": null,
              "discarded": false,
              "raw": "36"
            },
            {
              "raceNumber": 5,
              "score": 48,
              "code": "DNC",
              "discarded": true,
              "raw": "(48 DNC)"
            },
            {
              "raceNumber": 6,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            },
            {
              "raceNumber": 7,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            },
            {
              "raceNumber": 8,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            },
            {
              "raceNumber": 9,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            },
            {
              "raceNumber": 10,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            }
          ],
          "sailorId": "8f9be7b7-29e4-55d2-8e5c-36dde21d09a0",
          "resultId": "4938e4af-99bf-5e18-ae20-d83f73b5c606",
          "participantId": "13d8c4d4-5bd1-559e-a9c2-d87ecf36ae07",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "TPE",
          "officialName": "Yu-Shin Chen",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 213037, Nat: TPE."
        },
        {
          "rank": 44,
          "sourceName": "Salem Qaly",
          "name": "Salem Qaly",
          "sailOrBoardNumber": "189512",
          "nationality": "KUW",
          "gender": "M",
          "grossScore": 414,
          "nettScore": 366,
          "races": [
            {
              "raceNumber": 1,
              "score": 41,
              "code": null,
              "discarded": false,
              "raw": "41"
            },
            {
              "raceNumber": 2,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 3,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 4,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 5,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            },
            {
              "raceNumber": 6,
              "score": 48,
              "code": "UFD",
              "discarded": true,
              "raw": "(48 UFD)"
            },
            {
              "raceNumber": 7,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 8,
              "score": 37,
              "code": null,
              "discarded": false,
              "raw": "37"
            },
            {
              "raceNumber": 9,
              "score": 48,
              "code": "UFD",
              "discarded": false,
              "raw": "48 UFD"
            },
            {
              "raceNumber": 10,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            }
          ],
          "sailorId": "b2b111b7-7e55-50ee-b1c4-18745684567d",
          "resultId": "d7156787-089b-554c-8b9c-8e745413f97f",
          "participantId": "f604aa85-400a-510d-8b8c-1a407f2e6dfe",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "KUW",
          "officialName": "Salem Qaly",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 189512, Nat: KUW."
        },
        {
          "rank": 45,
          "sourceName": "Yerkebulan Sardarbekov",
          "name": "Yerkebulan Sardarbekov",
          "sailOrBoardNumber": "220122",
          "nationality": "KAZ",
          "gender": "M",
          "grossScore": 436,
          "nettScore": 388,
          "races": [
            {
              "raceNumber": 1,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 2,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 3,
              "score": 46,
              "code": null,
              "discarded": false,
              "raw": "46"
            },
            {
              "raceNumber": 4,
              "score": 45,
              "code": null,
              "discarded": false,
              "raw": "45"
            },
            {
              "raceNumber": 5,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 6,
              "score": 48,
              "code": "SCP30%",
              "discarded": true,
              "raw": "(48 SCP30%)"
            },
            {
              "raceNumber": 7,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            },
            {
              "raceNumber": 8,
              "score": 44,
              "code": null,
              "discarded": false,
              "raw": "44"
            },
            {
              "raceNumber": 9,
              "score": 39,
              "code": null,
              "discarded": false,
              "raw": "39"
            },
            {
              "raceNumber": 10,
              "score": 42,
              "code": null,
              "discarded": false,
              "raw": "42"
            }
          ],
          "sailorId": "49e37e87-02fe-5b3a-b081-77312424e6ab",
          "resultId": "63a7d1e7-50ee-58cf-af63-e3779a72ad39",
          "participantId": "9e96b442-6815-5cf0-abbe-98bcd3afb592",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "KAZ",
          "officialName": "Yerkebulan Sardarbekov",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 220122, Nat: KAZ."
        },
        {
          "rank": 46,
          "sourceName": "Otegen Shyngys",
          "name": "Otegen Shyngys",
          "sailOrBoardNumber": "216733",
          "nationality": "KAZ",
          "gender": "M",
          "grossScore": 452,
          "nettScore": 404,
          "races": [
            {
              "raceNumber": 1,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            },
            {
              "raceNumber": 2,
              "score": 46,
              "code": null,
              "discarded": false,
              "raw": "46"
            },
            {
              "raceNumber": 3,
              "score": 45,
              "code": null,
              "discarded": false,
              "raw": "45"
            },
            {
              "raceNumber": 4,
              "score": 46,
              "code": null,
              "discarded": false,
              "raw": "46"
            },
            {
              "raceNumber": 5,
              "score": 45,
              "code": null,
              "discarded": false,
              "raw": "45"
            },
            {
              "raceNumber": 6,
              "score": 48,
              "code": "SCP30%",
              "discarded": true,
              "raw": "(48 SCP30%)"
            },
            {
              "raceNumber": 7,
              "score": 48,
              "code": "DNF",
              "discarded": false,
              "raw": "48 DNF"
            },
            {
              "raceNumber": 8,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            },
            {
              "raceNumber": 9,
              "score": 40,
              "code": null,
              "discarded": false,
              "raw": "40"
            },
            {
              "raceNumber": 10,
              "score": 43,
              "code": null,
              "discarded": false,
              "raw": "43"
            }
          ],
          "sailorId": "5e91e718-63f1-5fc6-8e86-3b1df4857321",
          "resultId": "4e968bd2-9f9c-5c6e-a7b0-030fc023f588",
          "participantId": "e0590609-b2a2-5fbd-8737-ff634d0f4089",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "KAZ",
          "officialName": "Otegen Shyngys",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 216733, Nat: KAZ."
        },
        {
          "rank": 47,
          "sourceName": "Yulong Qiu",
          "name": "Yulong Qiu",
          "sailOrBoardNumber": "211313",
          "nationality": "CHN",
          "gender": "M",
          "grossScore": 480,
          "nettScore": 432,
          "races": [
            {
              "raceNumber": 1,
              "score": 48,
              "code": "DNC",
              "discarded": true,
              "raw": "(48 DNC)"
            },
            {
              "raceNumber": 2,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            },
            {
              "raceNumber": 3,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            },
            {
              "raceNumber": 4,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            },
            {
              "raceNumber": 5,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            },
            {
              "raceNumber": 6,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            },
            {
              "raceNumber": 7,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            },
            {
              "raceNumber": 8,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            },
            {
              "raceNumber": 9,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            },
            {
              "raceNumber": 10,
              "score": 48,
              "code": "DNC",
              "discarded": false,
              "raw": "48 DNC"
            }
          ],
          "sailorId": "9aa34924-ef5b-5a1a-9adf-496464259c09",
          "resultId": "01d62a5d-2427-563e-be77-37a8bf28ce95",
          "participantId": "9c3acd48-997b-5845-a319-0b8ec27e291c",
          "isNewProfile": true,
          "identityBasis": "New international sailor profile created from official ILCA Asian Championship results book",
          "sourceNationality": "CHN",
          "officialName": "Yulong Qiu",
          "evidenceNotes": "Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: ILCA 7, Division: Men. Sail No: 211313, Nat: CHN."
        }
      ]
    }
  ],
  "newProfiles": [
    {
      "id": "b0dd8104-74ab-5437-9ab5-5dd70bdc7a11",
      "name": "Wu HongWei",
      "handle": "wu-hongwei-ilca24-chn",
      "sail_number": "217163",
      "sail_number_ilca4": "217163",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "748f90c5-4811-5dfe-8d23-657eeaf91af8",
      "name": "Li Junda",
      "handle": "li-junda-ilca24-chn",
      "sail_number": "220337",
      "sail_number_ilca4": "220337",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "60031ee2-d461-5570-b96b-fa97fb80bc52",
      "name": "Yigeng Chen",
      "handle": "yigeng-chen-ilca24-chn",
      "sail_number": "200777",
      "sail_number_ilca4": "200777",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "660ca0bb-1d40-5077-9dac-ceb48cc11001",
      "name": "Pan Bo Wen",
      "handle": "pan-bo-wen-ilca24-chn",
      "sail_number": "211941",
      "sail_number_ilca4": "211941",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "96708f94-34d4-5d8c-b8be-85203b783841",
      "name": "Jiahao Zhuang",
      "handle": "jiahao-zhuang-ilca24-chn",
      "sail_number": "218683",
      "sail_number_ilca4": "218683",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "b2429c70-bcf7-507f-b9cb-801df8738915",
      "name": "Haolun Xia",
      "handle": "haolun-xia-ilca24-chn",
      "sail_number": "223749",
      "sail_number_ilca4": "223749",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "cb704cef-5d6a-5ab1-8c50-53efdc57a5ba",
      "name": "Saiya Lu",
      "handle": "saiya-lu-ilca24-chn",
      "sail_number": "225093",
      "sail_number_ilca4": "225093",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "f591f4b2-9114-580f-b2dd-367b067094f7",
      "name": "Juncheng Zhou",
      "handle": "juncheng-zhou-ilca24-chn",
      "sail_number": "211100",
      "sail_number_ilca4": "211100",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "738ea9d2-24d6-58a4-b283-7519c083f4c1",
      "name": "Zifan Feng",
      "handle": "zifan-feng-ilca24-chn",
      "sail_number": "219447",
      "sail_number_ilca4": "219447",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "34fe033f-bb33-58e5-aedb-a78fc1809851",
      "name": "Fengziyi Fu",
      "handle": "fengziyi-fu-ilca24-chn",
      "sail_number": "223595",
      "sail_number_ilca4": "223595",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "dd154de0-0ba0-5fd2-b92c-369de28b858d",
      "name": "Junhe Wang",
      "handle": "junhe-wang-ilca24-chn",
      "sail_number": "202759",
      "sail_number_ilca4": "202759",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "783eafcb-6263-569c-b52c-ad504b85af62",
      "name": "Wentai Yang",
      "handle": "wentai-yang-ilca24-chn",
      "sail_number": "220211",
      "sail_number_ilca4": "220211",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "503a5d45-9f13-5b69-9ec2-14f2b04c4a6c",
      "name": "Iqbal Nazham Musmuliadi",
      "handle": "iqbal-nazham-musmuliadi-ilca24-mas",
      "sail_number": "209875",
      "sail_number_ilca4": "209875",
      "gender": "M",
      "nationality": "MAS",
      "club": "N/A",
      "school": null
    },
    {
      "id": "eb4f93a7-324f-5bef-a6d2-38cfa887eb0d",
      "name": "Darwin Hsu",
      "handle": "darwin-hsu-ilca24-tha",
      "sail_number": "220051",
      "sail_number_ilca4": "220051",
      "gender": "M",
      "nationality": "THA",
      "club": "N/A",
      "school": null
    },
    {
      "id": "870db169-c3dd-5ccf-b16a-6fdd6204e099",
      "name": "Yaozhuang Chen",
      "handle": "yaozhuang-chen-ilca24-chn",
      "sail_number": "219990",
      "sail_number_ilca4": "219990",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "51d18c99-93e2-5bce-b886-c45036a30286",
      "name": "Jiahan Chen",
      "handle": "jiahan-chen-ilca24-chn",
      "sail_number": "210910",
      "sail_number_ilca4": "210910",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "ede3696b-488f-5d47-b9ba-98c053018804",
      "name": "Xinhua Peng",
      "handle": "xinhua-peng-ilca24-chn",
      "sail_number": "221019",
      "sail_number_ilca4": "221019",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "c9816906-d276-547a-bef3-d0961b38e7df",
      "name": "Duan Gao",
      "handle": "duan-gao-ilca24-chn",
      "sail_number": "200811",
      "sail_number_ilca4": "200811",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "4153958b-e800-5ac9-b07f-880665c136af",
      "name": "Zidong Yang",
      "handle": "zidong-yang-ilca24-chn",
      "sail_number": "220529",
      "sail_number_ilca4": "220529",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "58b608ad-1fc2-51df-85b7-11c47ee41a39",
      "name": "Luo Enzo",
      "handle": "luo-enzo-ilca24-chn",
      "sail_number": "210703",
      "sail_number_ilca4": "210703",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "8aff94fe-6f49-59c7-a489-4b7ee8dbedf5",
      "name": "Yu Kai Chen",
      "handle": "yu-kai-chen-ilca24-tpe",
      "sail_number": "222236",
      "sail_number_ilca4": "222236",
      "gender": "M",
      "nationality": "TPE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "ff2b9f52-ba58-5fe2-a0f2-d4169564171f",
      "name": "Dapeng Ming",
      "handle": "dapeng-ming-ilca24-chn",
      "sail_number": "217806",
      "sail_number_ilca4": "217806",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "bb977df0-36a5-580b-8efb-f2faefa1cb2a",
      "name": "Zihan Sun",
      "handle": "zihan-sun-ilca24-chn",
      "sail_number": "202868",
      "sail_number_ilca4": "202868",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "88f2c39e-13a5-5729-8c4a-485791836852",
      "name": "Junxi Ding",
      "handle": "junxi-ding-ilca24-chn",
      "sail_number": "202848",
      "sail_number_ilca4": "202848",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "0c7674d6-5926-5108-9bcf-91ebc6272923",
      "name": "Weikai Zachary Wong",
      "handle": "weikai-zachary-wong-ilca24-sgp",
      "sail_number": "221061",
      "sail_number_ilca4": "221061",
      "gender": "M",
      "nationality": "SGP",
      "club": "N/A",
      "school": null
    },
    {
      "id": "7dd8713c-ea7c-59ec-8131-1c3f4b4eb652",
      "name": "Jonathan Zeppezauer",
      "handle": "jonathan-zeppezauer-ilca24-hkg",
      "sail_number": "215308",
      "sail_number_ilca4": "215308",
      "gender": "M",
      "nationality": "HKG",
      "club": "N/A",
      "school": null
    },
    {
      "id": "bc7f0507-db8c-5f57-afa5-2e9884b85466",
      "name": "Cheng Zhang",
      "handle": "cheng-zhang-ilca24-chn",
      "sail_number": "220533",
      "sail_number_ilca4": "220533",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "d579b3bc-b99b-51e6-b930-5529a5bc5cb6",
      "name": "Yiming Wu",
      "handle": "yiming-wu-ilca24-chn",
      "sail_number": "214250",
      "sail_number_ilca4": "214250",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "68eaffa2-2f9a-5be5-941d-18f7a2bf6ede",
      "name": "Mohamed Khalid Alowaiss",
      "handle": "mohamed-khalid-alowaiss-ilca24-uae",
      "sail_number": "201504",
      "sail_number_ilca4": "201504",
      "gender": "M",
      "nationality": "UAE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "8dff2c8d-28cc-5950-b5a3-b1c13770883d",
      "name": "Muhammad Adam Aierell",
      "handle": "muhammad-adam-aierell-ilca24-mas",
      "sail_number": "209892",
      "sail_number_ilca4": "209892",
      "gender": "M",
      "nationality": "MAS",
      "club": "N/A",
      "school": null
    },
    {
      "id": "ba8931d0-550c-51d0-8910-091f8a3615d4",
      "name": "Shaohui Zhang",
      "handle": "shaohui-zhang-ilca24-chn",
      "sail_number": "223610",
      "sail_number_ilca4": "223610",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "0effc04c-0d67-5357-98c5-9025c9717a39",
      "name": "Avelino Paulo Shin",
      "handle": "avelino-paulo-shin-ilca24-hkg",
      "sail_number": "209902",
      "sail_number_ilca4": "209902",
      "gender": "M",
      "nationality": "HKG",
      "club": "N/A",
      "school": null
    },
    {
      "id": "80e86b2d-0731-5ad8-a303-fb7fc53ae46e",
      "name": "Chiying Ng",
      "handle": "chiying-ng-ilca24-hkg",
      "sail_number": "218836",
      "sail_number_ilca4": "218836",
      "gender": "M",
      "nationality": "HKG",
      "club": "N/A",
      "school": null
    },
    {
      "id": "7be19c4b-130a-593f-848e-40888dd7024f",
      "name": "Ji Wang",
      "handle": "ji-wang-ilca24-chn",
      "sail_number": "202822",
      "sail_number_ilca4": "202822",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "9dc548f8-eaa5-51b2-b7c0-d283adf7c776",
      "name": "He Lv",
      "handle": "he-lv-ilca24-chn",
      "sail_number": "202864",
      "sail_number_ilca4": "202864",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "c7479625-ae9b-55ab-aee0-6c4663fb9740",
      "name": "Zhenwang Wang",
      "handle": "zhenwang-wang-ilca24-chn",
      "sail_number": "218689",
      "sail_number_ilca4": "218689",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "bce9e13d-67b0-58e3-89d3-fcd5648feba8",
      "name": "Zihao Zhi",
      "handle": "zihao-zhi-ilca24-chn",
      "sail_number": "205972",
      "sail_number_ilca4": "205972",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "7abfdde4-90ff-55c8-81a1-76c6f2eea4e0",
      "name": "He Qu",
      "handle": "he-qu-ilca24-chn",
      "sail_number": "205979",
      "sail_number_ilca4": "205979",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "6ffe5f44-12c9-53c7-9edf-46fa7329911e",
      "name": "Yiqing Li",
      "handle": "yiqing-li-ilca24-chn",
      "sail_number": "223811",
      "sail_number_ilca4": "223811",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "ccdde706-66e7-57d3-beda-0d94331fde72",
      "name": "Fengkai Liu",
      "handle": "fengkai-liu-ilca24-chn",
      "sail_number": "225954",
      "sail_number_ilca4": "225954",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "54143e61-2416-577f-bafc-51a89334270f",
      "name": "Yinghao Fu",
      "handle": "yinghao-fu-ilca24-chn",
      "sail_number": "219993",
      "sail_number_ilca4": "219993",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "8d225382-7ff4-575a-a731-9eba600f4664",
      "name": "Caleb Rui-Kai Peck",
      "handle": "caleb-rui-kai-peck-ilca24-sgp",
      "sail_number": "225221",
      "sail_number_ilca4": "225221",
      "gender": "M",
      "nationality": "SGP",
      "club": "N/A",
      "school": null
    },
    {
      "id": "3bdb185e-6937-5641-86f5-3d735c4e85c2",
      "name": "Jinhang Yu",
      "handle": "jinhang-yu-ilca24-chn",
      "sail_number": "202942",
      "sail_number_ilca4": "202942",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "0a630751-f261-5069-a38a-cdfb831bbb1f",
      "name": "Saif Al Marzooqi",
      "handle": "saif-al-marzooqi-ilca24-uae",
      "sail_number": "207904",
      "sail_number_ilca4": "207904",
      "gender": "M",
      "nationality": "UAE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "17e285a4-3c1e-56cd-81bb-15dd7f6ab70f",
      "name": "Xiaolin Zhang",
      "handle": "xiaolin-zhang-ilca24-chn",
      "sail_number": "221027",
      "sail_number_ilca4": "221027",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "1a175dba-1f34-5ff1-998e-13b0553bf23f",
      "name": "Nan Jiang",
      "handle": "nan-jiang-ilca24-chn",
      "sail_number": "223789",
      "sail_number_ilca4": "223789",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "d0231a7c-9606-5aa8-8025-fa1500017fcd",
      "name": "Jhen-Syun You",
      "handle": "jhen-syun-you-ilca24-tpe",
      "sail_number": "173563",
      "sail_number_ilca4": "173563",
      "gender": "M",
      "nationality": "TPE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "583fd9f9-4933-5687-a364-44867c36035a",
      "name": "Kaman Ho",
      "handle": "kaman-ho-ilca24-chn",
      "sail_number": "224681",
      "sail_number_ilca4": "224681",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "20029686-86c4-5038-b617-0a3c3cd48950",
      "name": "Guoxin Qin",
      "handle": "guoxin-qin-ilca24-chn",
      "sail_number": "225497",
      "sail_number_ilca4": "225497",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "f1ba1b44-0e92-5bff-b041-b6584719fc28",
      "name": "Yuxiang Tao",
      "handle": "yuxiang-tao-ilca24-chn",
      "sail_number": "223812",
      "sail_number_ilca4": "223812",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "43219fd4-b508-5eb7-873a-7c615ce7e38e",
      "name": "Jishuo Zhang",
      "handle": "jishuo-zhang-ilca24-chn",
      "sail_number": "225101",
      "sail_number_ilca4": "225101",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "9f669bbf-2799-5cc5-9fc2-a26dc4813862",
      "name": "HaoWei Zhuang",
      "handle": "haowei-zhuang-ilca24-chn",
      "sail_number": "219986",
      "sail_number_ilca4": "219986",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "9d0b9c9d-9abc-593a-bda0-2c1f2194ec2e",
      "name": "ZhiYuan Xu",
      "handle": "zhiyuan-xu-ilca24-chn",
      "sail_number": "223810",
      "sail_number_ilca4": "223810",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "0a157383-ee45-5e8c-aa06-ec12fbf2ad2c",
      "name": "Min Zhang",
      "handle": "min-zhang-ilca24-chn",
      "sail_number": "205009",
      "sail_number_ilca4": "205009",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "511db3ec-2851-50b0-bba8-da974a79936f",
      "name": "HongJun Wang",
      "handle": "hongjun-wang-ilca24-chn",
      "sail_number": "205026",
      "sail_number_ilca4": "205026",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "50f1720d-1f44-5ce2-a5f7-5507e56fb87f",
      "name": "Tianle Wang",
      "handle": "tianle-wang-ilca24-chn",
      "sail_number": "223796",
      "sail_number_ilca4": "223796",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "10525e79-4f3a-5981-b868-6149c53653d9",
      "name": "Jerry Mei",
      "handle": "jerry-mei-ilca24-chn",
      "sail_number": "219311",
      "sail_number_ilca4": "219311",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "0daa3f08-a322-5498-ace7-9fb3088e97c3",
      "name": "Zongchen Wei",
      "handle": "zongchen-wei-ilca24-chn",
      "sail_number": "223797",
      "sail_number_ilca4": "223797",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "56ea1e8c-631b-568f-b6eb-8096cf9ec9e4",
      "name": "Xunhao Zheng",
      "handle": "xunhao-zheng-ilca24-chn",
      "sail_number": "223798",
      "sail_number_ilca4": "223798",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "4f0601e7-97b8-56e2-8f35-16b373dac4eb",
      "name": "Leyan Huang",
      "handle": "leyan-huang-ilca24-chn",
      "sail_number": "222962",
      "sail_number_ilca4": "222962",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "94da7557-e28f-5096-b25f-e36836f38c09",
      "name": "Jiale Geng",
      "handle": "jiale-geng-ilca24-chn",
      "sail_number": "200318",
      "sail_number_ilca4": "200318",
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "d4a73837-9aea-512a-a508-6463f255d349",
      "name": "Meifang Zhao",
      "handle": "meifang-zhao-ilca24-chn",
      "sail_number": "221557",
      "sail_number_ilca4": "221557",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "7dac82e6-2cc0-5681-8b9a-75a9deba9edb",
      "name": "Meixiu Zhao",
      "handle": "meixiu-zhao-ilca24-chn",
      "sail_number": "223790",
      "sail_number_ilca4": "223790",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "74484e56-ea11-59e5-b72b-fff0cac309fc",
      "name": "Prin Subying",
      "handle": "prin-subying-ilca24-tha",
      "sail_number": "222687",
      "sail_number_ilca4": "222687",
      "gender": "W",
      "nationality": "THA",
      "club": "N/A",
      "school": null
    },
    {
      "id": "f7c5c2e7-a371-584d-8b60-ae56f00fbace",
      "name": "Guoguo Yan",
      "handle": "guoguo-yan-ilca24-chn",
      "sail_number": "211947",
      "sail_number_ilca4": "211947",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "9e8db81c-630b-5879-bcfe-2c1ea4030c25",
      "name": "Linhan Zhang",
      "handle": "linhan-zhang-ilca24-chn",
      "sail_number": "212275",
      "sail_number_ilca4": "212275",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "2386b36f-2ea0-54f6-9d2f-244c22cacda4",
      "name": "Yaxuan Luo",
      "handle": "yaxuan-luo-ilca24-chn",
      "sail_number": "220526",
      "sail_number_ilca4": "220526",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "50e6a7c0-6c46-5c80-92ca-424450e3dfb1",
      "name": "Fan Liu",
      "handle": "fan-liu-ilca24-chn",
      "sail_number": "214448",
      "sail_number_ilca4": "214448",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "e0a973ec-5c34-5cde-bfe9-73a88263e902",
      "name": "Huiting Xu",
      "handle": "huiting-xu-ilca24-chn",
      "sail_number": "212117",
      "sail_number_ilca4": "212117",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "0a36ac43-cca1-5864-8081-62ed058052b7",
      "name": "Yijia Su",
      "handle": "yijia-su-ilca24-chn",
      "sail_number": "219936",
      "sail_number_ilca4": "219936",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "16282942-59b2-5a34-b49f-be513445eebe",
      "name": "Yujiao Cao",
      "handle": "yujiao-cao-ilca24-chn",
      "sail_number": "156072",
      "sail_number_ilca4": "156072",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "f35d2c05-8876-5246-98b2-974a85a25e06",
      "name": "Nur Zafrina Syuhada Mohd Zailan",
      "handle": "nur-zafrina-syuhada-mohd-zailan-ilca24-mas",
      "sail_number": "206032",
      "sail_number_ilca4": "206032",
      "gender": "W",
      "nationality": "MAS",
      "club": "N/A",
      "school": null
    },
    {
      "id": "e686d1dd-9808-56ce-b22a-088ec1ae401f",
      "name": "Ruoxian Wu",
      "handle": "ruoxian-wu-ilca24-chn",
      "sail_number": "221026",
      "sail_number_ilca4": "221026",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "c8b3175b-1b32-50de-8dc1-e72517d42c0e",
      "name": "Qinyi Li",
      "handle": "qinyi-li-ilca24-chn",
      "sail_number": "223159",
      "sail_number_ilca4": "223159",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "9f8ac816-e8cf-5f65-b065-75cc967b6842",
      "name": "Yongyi Chen",
      "handle": "yongyi-chen-ilca24-chn",
      "sail_number": "218671",
      "sail_number_ilca4": "218671",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "4199028f-a4dc-5a9b-9b33-e7e208ab9191",
      "name": "Luo Yi",
      "handle": "luo-yi-ilca24-chn",
      "sail_number": "220343",
      "sail_number_ilca4": "220343",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "d1b87ec8-57e4-5173-9da2-9cc80de2bb8c",
      "name": "Li Huang",
      "handle": "li-huang-ilca24-chn",
      "sail_number": "219989",
      "sail_number_ilca4": "219989",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "335322d5-f04d-59a2-8403-03e5c5ea19a5",
      "name": "Nur Hafizanah Zailan",
      "handle": "nur-hafizanah-zailan-ilca24-mas",
      "sail_number": "209891",
      "sail_number_ilca4": "209891",
      "gender": "W",
      "nationality": "MAS",
      "club": "N/A",
      "school": null
    },
    {
      "id": "ca255c9c-bebe-5992-8f15-1debf2701811",
      "name": "Jui-Hsuan Chen",
      "handle": "jui-hsuan-chen-ilca24-tpe",
      "sail_number": "210476",
      "sail_number_ilca4": "210476",
      "gender": "W",
      "nationality": "TPE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "a748849b-bfa8-5666-8471-7e3286774b63",
      "name": "Wenxing Cheng",
      "handle": "wenxing-cheng-ilca24-chn",
      "sail_number": "217807",
      "sail_number_ilca4": "217807",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "a7b69130-87f2-59ad-a0bb-c8f5bcd3f4c8",
      "name": "Maanya Reddy",
      "handle": "maanya-reddy-ilca24-ind",
      "sail_number": "209907",
      "sail_number_ilca4": "209907",
      "gender": "W",
      "nationality": "IND",
      "club": "N/A",
      "school": null
    },
    {
      "id": "fa5c9979-8c33-5788-bd9f-2587309397ad",
      "name": "Yinping Huang",
      "handle": "yinping-huang-ilca24-chn",
      "sail_number": "220312",
      "sail_number_ilca4": "220312",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "831e3e52-4c88-53b8-ac69-7a0ab3d96476",
      "name": "Yunru Zhang",
      "handle": "yunru-zhang-ilca24-chn",
      "sail_number": "221904",
      "sail_number_ilca4": "221904",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "9a6ab4fb-5243-5a4b-9875-7c28210963f2",
      "name": "Shirley Ma",
      "handle": "shirley-ma-ilca24-jpn",
      "sail_number": "146692",
      "sail_number_ilca4": "146692",
      "gender": "W",
      "nationality": "JPN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "564035e5-db60-598e-9f1e-66ff281b6a55",
      "name": "Chengjin Yi",
      "handle": "chengjin-yi-ilca24-chn",
      "sail_number": "210368",
      "sail_number_ilca4": "210368",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "912d07b2-7e5a-51a2-80e4-be52393a3bcd",
      "name": "Zhenghan Wang",
      "handle": "zhenghan-wang-ilca24-chn",
      "sail_number": "221551",
      "sail_number_ilca4": "221551",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "cc8ae5de-5c68-5cff-98da-fb7e571162c8",
      "name": "Peixuan Sun",
      "handle": "peixuan-sun-ilca24-chn",
      "sail_number": "222292",
      "sail_number_ilca4": "222292",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "32aef090-8053-5bb6-8100-0b44a692a2b0",
      "name": "Li Xuan Milderd Wong",
      "handle": "li-xuan-milderd-wong-ilca24-sgp",
      "sail_number": "223200",
      "sail_number_ilca4": "223200",
      "gender": "W",
      "nationality": "SGP",
      "club": "N/A",
      "school": null
    },
    {
      "id": "612c9d98-1eb6-58ca-b38b-dd5e265b32b3",
      "name": "Guo Yuan",
      "handle": "guo-yuan-ilca24-chn",
      "sail_number": "219181",
      "sail_number_ilca4": "219181",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "27ae7a69-b946-5f11-8e82-d9ae359687e6",
      "name": "Zihan Tang",
      "handle": "zihan-tang-ilca24-chn",
      "sail_number": "205955",
      "sail_number_ilca4": "205955",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "5cd84010-dcdf-5676-b97b-6b5958db5f3c",
      "name": "Ruihan Chen",
      "handle": "ruihan-chen-ilca24-chn",
      "sail_number": "214453",
      "sail_number_ilca4": "214453",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "5f14d7c9-dc29-5dcc-af50-065637d5730d",
      "name": "Alyazya Alhammadi",
      "handle": "alyazya-alhammadi-ilca24-uae",
      "sail_number": "207891",
      "sail_number_ilca4": "207891",
      "gender": "W",
      "nationality": "UAE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "6dd80388-c0cd-507a-926b-06f08260adf3",
      "name": "Huixia Fu",
      "handle": "huixia-fu-ilca24-chn",
      "sail_number": "220323",
      "sail_number_ilca4": "220323",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "92d3a445-ad48-5c1f-b990-1d574359bb47",
      "name": "Xiaoyou Pan",
      "handle": "xiaoyou-pan-ilca24-chn",
      "sail_number": "223615",
      "sail_number_ilca4": "223615",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "e3023b48-b403-5d59-96fd-243fe9fd9c1d",
      "name": "Yujia Wang",
      "handle": "yujia-wang-ilca24-chn",
      "sail_number": "205966",
      "sail_number_ilca4": "205966",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "b40bb781-84db-5e73-986a-d9e4dff68faf",
      "name": "Zihan Li",
      "handle": "zihan-li-ilca24-chn",
      "sail_number": "220227",
      "sail_number_ilca4": "220227",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "97b0d98e-9e2e-5917-b36e-798ef1440452",
      "name": "Lyora Wallier",
      "handle": "lyora-wallier-ilca24-hkg",
      "sail_number": "213316",
      "sail_number_ilca4": "213316",
      "gender": "W",
      "nationality": "HKG",
      "club": "N/A",
      "school": null
    },
    {
      "id": "67c37232-0076-5dd1-a815-408b375a6318",
      "name": "Yangzi Tang",
      "handle": "yangzi-tang-ilca24-chn",
      "sail_number": "218838",
      "sail_number_ilca4": "218838",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "aa564db6-5ef3-5666-a821-425146fc692e",
      "name": "Linger Zhou",
      "handle": "linger-zhou-ilca24-chn",
      "sail_number": "221023",
      "sail_number_ilca4": "221023",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "990d6b38-c385-53d8-afab-db4951744c8b",
      "name": "Qinyu Shi",
      "handle": "qinyu-shi-ilca24-chn",
      "sail_number": "225006",
      "sail_number_ilca4": "225006",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "440013f1-4689-54d6-b2cd-3509a58c1899",
      "name": "Wanzhi Elva Li",
      "handle": "wanzhi-elva-li-ilca24-chn",
      "sail_number": "220895",
      "sail_number_ilca4": "220895",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "42aaac0f-69c3-5ad6-8a4b-f7979a533f29",
      "name": "Xin Cai",
      "handle": "xin-cai-ilca24-chn",
      "sail_number": "225953",
      "sail_number_ilca4": "225953",
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "f560f344-f301-5698-bdf2-efa8a44a7238",
      "name": "Weijie Zheng",
      "handle": "weijie-zheng-ilca24-chn",
      "sail_number": "218527",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "23401c6b-c3bd-5f81-9cf7-1e944f8c5468",
      "name": "Jiahua Liu",
      "handle": "jiahua-liu-ilca24-chn",
      "sail_number": "211512",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "a80cdab4-770a-5926-aa56-e56ac7a1a5c1",
      "name": "Qing Long Li",
      "handle": "qing-long-li-ilca24-chn",
      "sail_number": "220428",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "ece31428-b9e2-5ba4-b5d6-79e4f7b84dd7",
      "name": "Yebin Guo",
      "handle": "yebin-guo-ilca24-chn",
      "sail_number": "211516",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "345609dc-15c1-5937-9de0-c6f0ec61db0e",
      "name": "Khalid Adil",
      "handle": "khalid-adil-ilca24-uae",
      "sail_number": "180000",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "UAE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "9fb849be-bfc1-5c19-b827-f95a2c775fc4",
      "name": "Daniel Chan",
      "handle": "daniel-chan-ilca24-hkg",
      "sail_number": "223750",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "HKG",
      "club": "N/A",
      "school": null
    },
    {
      "id": "7ad0d090-eb1c-5d17-a999-67f811ab3def",
      "name": "Yukun Chen",
      "handle": "yukun-chen-ilca24-chn",
      "sail_number": "200800",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "30fc62cd-a394-5f7f-93fa-ace8448becb6",
      "name": "Waixiang Yang",
      "handle": "waixiang-yang-ilca24-tpe",
      "sail_number": "221511",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "TPE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "cd7162ae-a396-557c-ae56-2be3ccaac7c3",
      "name": "Seb Willem Van Ommeren",
      "handle": "seb-willem-van-ommeren-ilca24-hkg",
      "sail_number": "209319",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "HKG",
      "club": "N/A",
      "school": null
    },
    {
      "id": "7b2c8ce4-104a-5776-a9cd-728b6bb13061",
      "name": "Yutong Cai",
      "handle": "yutong-cai-ilca24-chn",
      "sail_number": "221545",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "a06803b2-2aba-5631-bf0d-9048b4b7aef3",
      "name": "Xiuren Yu",
      "handle": "xiuren-yu-ilca24-chn",
      "sail_number": "223613",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "2c520c3e-1da2-59af-8b00-1fd595079073",
      "name": "Ruan Alexeyenko",
      "handle": "ruan-alexeyenko-ilca24-kaz",
      "sail_number": "210313",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "KAZ",
      "club": "N/A",
      "school": null
    },
    {
      "id": "f4cc8bb9-c008-574e-aa09-b07c58607a12",
      "name": "Hsuanchen Chien",
      "handle": "hsuanchen-chien-ilca24-tpe",
      "sail_number": "221514",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "TPE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "c960af09-f1a0-5c20-8001-a548ef9d0d43",
      "name": "Samuel Rui Qian Tan- Hardy",
      "handle": "samuel-rui-qian-tan-hardy-ilca24-hkg",
      "sail_number": "221934",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "HKG",
      "club": "N/A",
      "school": null
    },
    {
      "id": "3a1abf10-28a8-55a8-95be-53f5a8d13ed9",
      "name": "Xavier Wilde",
      "handle": "xavier-wilde-ilca24-hkg",
      "sail_number": "213211",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "HKG",
      "club": "N/A",
      "school": null
    },
    {
      "id": "a989031e-5d1b-546f-994b-7dd84b80bfb3",
      "name": "Ruoyu Su",
      "handle": "ruoyu-su-ilca24-chn",
      "sail_number": "214664",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "9f928c67-6acf-5b88-beb3-749076ac1185",
      "name": "Saoud Almasoud",
      "handle": "saoud-almasoud-ilca24-kuw",
      "sail_number": "189641",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "KUW",
      "club": "N/A",
      "school": null
    },
    {
      "id": "56af1cd1-f3d9-5298-956c-274f294de03e",
      "name": "Ruoque Su",
      "handle": "ruoque-su-ilca24-chn",
      "sail_number": "214379",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "cd5654dc-e845-5964-a9d1-139382209d7f",
      "name": "Xiaotian Ma",
      "handle": "xiaotian-ma-ilca24-chn",
      "sail_number": "214500",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "1f51e262-b9b0-5b37-9056-8f9e4b7068bb",
      "name": "Zhuang Zhicheng",
      "handle": "zhuang-zhicheng-ilca24-chn",
      "sail_number": "214663",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "6ae09413-305b-56f5-9801-e5cd3ab93c1d",
      "name": "Guan Xin Qiu",
      "handle": "guan-xin-qiu-ilca24-chn",
      "sail_number": "214380",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "b156b578-8c94-566b-80eb-210c4436d033",
      "name": "Chengen Lee",
      "handle": "chengen-lee-ilca24-tpe",
      "sail_number": "218497",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "TPE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "45720fde-ed0e-5f9d-bf37-8d064283a182",
      "name": "Minqi Zhu",
      "handle": "minqi-zhu-ilca24-chn",
      "sail_number": "225098",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "23ae179a-311b-5dc8-86d6-bf0d0869b788",
      "name": "Yuxiao Deng",
      "handle": "yuxiao-deng-ilca24-chn",
      "sail_number": "225467",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "8434d456-0359-541e-b994-6104370f5a96",
      "name": "Zitong Shang",
      "handle": "zitong-shang-ilca24-chn",
      "sail_number": "225091",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "98bf4b68-3283-5b87-bbbe-d11c1977eafc",
      "name": "Stephanie Norton",
      "handle": "stephanie-norton-ilca24-hkg",
      "sail_number": "191713",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "HKG",
      "club": "N/A",
      "school": null
    },
    {
      "id": "5c303689-5519-5f35-80d7-81475fe236cd",
      "name": "DongShuang Zhang",
      "handle": "dongshuang-zhang-ilca24-chn",
      "sail_number": "225096",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "e92f805f-ad59-504a-9c60-df77a89c2ebe",
      "name": "Min Gu",
      "handle": "min-gu-ilca24-chn",
      "sail_number": "225106",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "aecf4b79-5e1b-5545-8eb5-96d9f67f7944",
      "name": "Nancy Highfield",
      "handle": "nancy-highfield-ilca24-hkg",
      "sail_number": "211717",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "HKG",
      "club": "N/A",
      "school": null
    },
    {
      "id": "ec034268-7521-52cc-a753-283947345904",
      "name": "Yi Xin Li",
      "handle": "yi-xin-li-ilca24-chn",
      "sail_number": "225095",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "4b50b47b-1492-57dd-9f30-f445a2d1dc00",
      "name": "Junqi Gao",
      "handle": "junqi-gao-ilca24-chn",
      "sail_number": "217775",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "f7c83ca4-b62f-5d5c-9764-12fcf7e7e891",
      "name": "Li Hui",
      "handle": "li-hui-ilca24-chn",
      "sail_number": "224672",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "28920e09-1f15-5b12-b489-ea9ff5017207",
      "name": "Jiaming Chen",
      "handle": "jiaming-chen-ilca24-chn",
      "sail_number": "223741",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "45e12acd-f5c9-55a7-8bb7-8a3eec298c11",
      "name": "Yuetao Zhuo",
      "handle": "yuetao-zhuo-ilca24-chn",
      "sail_number": "221589",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "b3a29923-9d56-5e07-82f0-b0708d6f1419",
      "name": "Jiajia Tang",
      "handle": "jiajia-tang-ilca24-chn",
      "sail_number": "217761",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "bf1b2f0e-9b29-5b11-b716-50b701456bfc",
      "name": "Mengjiao Chang",
      "handle": "mengjiao-chang-ilca24-chn",
      "sail_number": "217677",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "375916b9-f25c-56f8-87ce-620693f6b41e",
      "name": "Fanqi Wang",
      "handle": "fanqi-wang-ilca24-chn",
      "sail_number": "211518",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "1290d3ca-f615-519d-b2f0-172e4d27d8fc",
      "name": "Tong Zhu",
      "handle": "tong-zhu-ilca24-chn",
      "sail_number": "221033",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "2a3d638a-3eef-5eff-88c0-a9d7dbdb6d28",
      "name": "Fang Yu Fu",
      "handle": "fang-yu-fu-ilca24-chn",
      "sail_number": "225233",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "c07bdc06-a80a-5b16-a022-2774ae6069f0",
      "name": "Baoling Yu",
      "handle": "baoling-yu-ilca24-chn",
      "sail_number": "222977",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "1f0585b7-e3ab-53e1-856d-de9b55828f52",
      "name": "Lifei Huang",
      "handle": "lifei-huang-ilca24-chn",
      "sail_number": "217669",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "6b3c0556-5b5f-5a76-9b90-b5510232f4bc",
      "name": "Nur Alia Amera Mohamad Latif",
      "handle": "nur-alia-amera-mohamad-latif-ilca24-mas",
      "sail_number": "209878",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "MAS",
      "club": "N/A",
      "school": null
    },
    {
      "id": "02749d3a-ea20-5171-a857-0d819f991798",
      "name": "Jimeng Chen",
      "handle": "jimeng-chen-ilca24-chn",
      "sail_number": "212131",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "a0801a18-74f2-54ae-bc72-4a0b032cb468",
      "name": "Yuchen Zhu",
      "handle": "yuchen-zhu-ilca24-chn",
      "sail_number": "217256",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "56fe38fa-7759-59a5-9432-ff0a4b518898",
      "name": "Ye Xin Yang",
      "handle": "ye-xin-yang-ilca24-chn",
      "sail_number": "225229",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "5ec2f363-6683-5607-8bd8-b2984890b6c2",
      "name": "Nana Funazawa",
      "handle": "nana-funazawa-ilca24-jpn",
      "sail_number": "217111",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "JPN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "d47a1360-502a-5e67-bb6f-a258032b716b",
      "name": "Hehsi\uff08lucy\uff09 Huang",
      "handle": "hehsi-lucy-huang-ilca24-tpe",
      "sail_number": "211718",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "TPE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "fff0cbea-df5b-53f7-9d2b-a5c715ff066f",
      "name": "Mengyao Yu",
      "handle": "mengyao-yu-ilca24-chn",
      "sail_number": "222964",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "7d370151-6d36-55ac-8e0c-f239e2e28080",
      "name": "Xinran Chen",
      "handle": "xinran-chen-ilca24-chn",
      "sail_number": "223276",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "c8aa8931-e608-5dd1-bb56-7babc54470c1",
      "name": "Ameena Shah",
      "handle": "ameena-shah-ilca24-kuw",
      "sail_number": "180982",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "KUW",
      "club": "N/A",
      "school": null
    },
    {
      "id": "c19dae59-5f06-52f8-bd66-e13efdd35e6d",
      "name": "Ziyan Huang",
      "handle": "ziyan-huang-ilca24-hkg",
      "sail_number": "221401",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "HKG",
      "club": "N/A",
      "school": null
    },
    {
      "id": "1a72ee9d-a796-5216-ae2a-45749663cbb3",
      "name": "Yana Belozerova",
      "handle": "yana-belozerova-ilca24-kaz",
      "sail_number": "210017",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "KAZ",
      "club": "N/A",
      "school": null
    },
    {
      "id": "cc50d043-c2e0-520f-b4e6-dc65ce55e28b",
      "name": "Jiaqi Liu",
      "handle": "jiaqi-liu-ilca24-chn",
      "sail_number": "217674",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "233d7ada-4c57-52aa-8467-d6a4d0a15e07",
      "name": "Yulin Tang",
      "handle": "yulin-tang-ilca24-chn",
      "sail_number": "215143",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "1178dc0b-fa79-5969-b777-198a46b3aace",
      "name": "Nur Adlina Nasreen Mohd Nasri",
      "handle": "nur-adlina-nasreen-mohd-nasri-ilca24-mas",
      "sail_number": "209879",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "MAS",
      "club": "N/A",
      "school": null
    },
    {
      "id": "4e032d23-bc37-5247-901a-edf9616eb106",
      "name": "Yuting Elisha Lim",
      "handle": "yuting-elisha-lim-ilca24-sgp",
      "sail_number": "214808",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "SGP",
      "club": "N/A",
      "school": null
    },
    {
      "id": "1fba40b3-c518-56d2-8a67-b193b8e9a583",
      "name": "Dhuha Al Besher",
      "handle": "dhuha-al-besher-ilca24-uae",
      "sail_number": "207889",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "UAE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "b68d3a38-afee-5160-9331-2d28fe3082b1",
      "name": "Sarah Hui Yan Seow",
      "handle": "sarah-hui-yan-seow-ilca24-sgp",
      "sail_number": "219162",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "SGP",
      "club": "N/A",
      "school": null
    },
    {
      "id": "17830c6e-f3f0-54cf-b304-a683ae9c5c94",
      "name": "Jing Lin",
      "handle": "jing-lin-ilca24-chn",
      "sail_number": "200503",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "2bb09661-11b7-5714-a6b2-a495ed6f517f",
      "name": "Yi San Huang",
      "handle": "yi-san-huang-ilca24-tpe",
      "sail_number": "221513",
      "sail_number_ilca4": null,
      "gender": "W",
      "nationality": "TPE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "335750be-e08c-56c5-84fb-70fbe14cfb77",
      "name": "Khairulnizam Mohd Afendy Abdullah",
      "handle": "khairulnizam-mohd-afendy-abdullah-ilca24-mas",
      "sail_number": "214989",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "MAS",
      "club": "N/A",
      "school": null
    },
    {
      "id": "1b2c502f-5e5a-58e8-83f3-12817b1126f0",
      "name": "Vishnu Saravanan",
      "handle": "vishnu-saravanan-ilca24-ind",
      "sail_number": "218191",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "IND",
      "club": "N/A",
      "school": null
    },
    {
      "id": "f724016b-a2d6-5d4b-82a0-5ad506ba3bfb",
      "name": "Arthit Mikhail Romanyk",
      "handle": "arthit-mikhail-romanyk-ilca24-tha",
      "sail_number": "213137",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "THA",
      "club": "N/A",
      "school": null
    },
    {
      "id": "10f3de1f-2d2c-57be-accf-af2ff0939ae6",
      "name": "Junsuo Luo",
      "handle": "junsuo-luo-ilca24-chn",
      "sail_number": "211215",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "714435d8-312f-577a-b678-088623ed34d6",
      "name": "Yinsheng Cui",
      "handle": "yinsheng-cui-ilca24-chn",
      "sail_number": "222932",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "6ed0bf3b-982d-52f6-ac9e-56792c81fe6a",
      "name": "Zili Wang",
      "handle": "zili-wang-ilca24-chn",
      "sail_number": "222922",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "03fe14f0-5ced-502b-98b0-a351c62258e5",
      "name": "Yuanshuai Tang",
      "handle": "yuanshuai-tang-ilca24-chn",
      "sail_number": "211177",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "19d84d38-56d5-53b6-9f54-e69599e8a2d1",
      "name": "Kaixing Ju",
      "handle": "kaixing-ju-ilca24-chn",
      "sail_number": "221036",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "6d9f3f93-0702-5961-bef2-45099f5f74a0",
      "name": "Rong Chen",
      "handle": "rong-chen-ilca24-chn",
      "sail_number": "211526",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "59438234-857e-53f3-8e9e-349204931a73",
      "name": "Shengxin Fan",
      "handle": "shengxin-fan-ilca24-chn",
      "sail_number": "215257",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "13e580f5-d394-581b-a73b-4de70d4a988e",
      "name": "Wenlong Han",
      "handle": "wenlong-han-ilca24-chn",
      "sail_number": "211127",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "8a2b5894-7d26-53b3-bbfc-a6310d8945f2",
      "name": "Guikun Lin",
      "handle": "guikun-lin-ilca24-chn",
      "sail_number": "217671",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "9bb223e1-a98f-570a-9beb-fbbb3e794e45",
      "name": "Zeen Huang",
      "handle": "zeen-huang-ilca24-chn",
      "sail_number": "211517",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "206be18b-6b97-5f65-a0f6-8cde177e997c",
      "name": "Zhihao Gu",
      "handle": "zhihao-gu-ilca24-chn",
      "sail_number": "218678",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "d2c623ee-eeca-55e7-bb37-3a0f54b601bf",
      "name": "Jindong Kong",
      "handle": "jindong-kong-ilca24-chn",
      "sail_number": "221035",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "135e78b0-bf1c-5289-bde8-9e28aeff52b9",
      "name": "Yang Yang",
      "handle": "yang-yang-ilca24-chn",
      "sail_number": "222747",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "e4dbf95a-8b82-5500-b709-346f51a21d81",
      "name": "Yukun Zhao",
      "handle": "yukun-zhao-ilca24-chn",
      "sail_number": "210127",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "be8460e4-3337-536d-a1c0-b0a2c5ecb08d",
      "name": "Haotian Li",
      "handle": "haotian-li-ilca24-chn",
      "sail_number": "211371",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "b43e59c6-4298-5493-8760-8d006e4454f1",
      "name": "Jun Long Wang",
      "handle": "jun-long-wang-ilca24-chn",
      "sail_number": "217672",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "4b500994-9ac9-54d8-9d2d-104d06224b42",
      "name": "Wei Da Yu",
      "handle": "wei-da-yu-ilca24-chn",
      "sail_number": "223723",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "3df2c6a7-b3fa-5b9d-80a8-20e66638c2f5",
      "name": "Peter Jessop",
      "handle": "peter-jessop-ilca24-hkg",
      "sail_number": "215313",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "HKG",
      "club": "N/A",
      "school": null
    },
    {
      "id": "4afd9393-8797-5468-9141-adffeee998d9",
      "name": "Muhammad Faizal Ahmad Asri",
      "handle": "muhammad-faizal-ahmad-asri-ilca24-mas",
      "sail_number": "209889",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "MAS",
      "club": "N/A",
      "school": null
    },
    {
      "id": "6a1927b4-9af9-5ca1-aa3a-512511e88263",
      "name": "Yang Huang",
      "handle": "yang-huang-ilca24-tpe",
      "sail_number": "209964",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "TPE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "363e5317-2c81-5af0-b407-6717ac0b3bda",
      "name": "Tsai-Chien Wu",
      "handle": "tsai-chien-wu-ilca24-tpe",
      "sail_number": "214123",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "TPE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "6abcf385-0642-56a7-8dc5-e310566104d9",
      "name": "Yihong Xu",
      "handle": "yihong-xu-ilca24-chn",
      "sail_number": "217668",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "7c3fec16-1a4b-596e-aebf-ed02c0beb585",
      "name": "Siyou Sung",
      "handle": "siyou-sung-ilca24-kor",
      "sail_number": "221012",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "KOR",
      "club": "N/A",
      "school": null
    },
    {
      "id": "1783433c-eb9b-5854-b99f-399a81970859",
      "name": "Wai Chak Tsui",
      "handle": "wai-chak-tsui-ilca24-hkg",
      "sail_number": "209950",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "HKG",
      "club": "N/A",
      "school": null
    },
    {
      "id": "4ad7a9aa-7980-5c67-a5f1-ca965d722a4b",
      "name": "Lei Fan Lin",
      "handle": "lei-fan-lin-ilca24-chn",
      "sail_number": "217755",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "9528945c-c924-5f8c-8420-9911df50923f",
      "name": "Patrick Ziteng Feng",
      "handle": "patrick-ziteng-feng-ilca24-chn",
      "sail_number": "209948",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "3c727d01-02a3-5719-8b30-4f7d6ca8c767",
      "name": "NuoSen Yao",
      "handle": "nuosen-yao-ilca24-chn",
      "sail_number": "217670",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "34b7c1ef-c8bc-5a54-abf7-368cb63474e2",
      "name": "Junjie Qiu",
      "handle": "junjie-qiu-ilca24-chn",
      "sail_number": "221544",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "55d48d99-79a3-531d-a623-062f911c1238",
      "name": "Hongxiang Chen",
      "handle": "hongxiang-chen-ilca24-chn",
      "sail_number": "221546",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "74649a91-150b-563f-af61-e9ad39199bfa",
      "name": "Guanguo Xie",
      "handle": "guanguo-xie-ilca24-chn",
      "sail_number": "221547",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7",
      "name": "Muhammad Asnawi Iqbal Adam",
      "handle": "muhammad-asnawi-iqbal-adam-ilca24-mas",
      "sail_number": "209888",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "MAS",
      "club": "N/A",
      "school": null
    },
    {
      "id": "335626a6-e74b-5cdf-94f1-74eed0680be4",
      "name": "Anton Gaas",
      "handle": "anton-gaas-ilca24-kaz",
      "sail_number": "210890",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "KAZ",
      "club": "N/A",
      "school": null
    },
    {
      "id": "d93fa781-901e-5532-bbc2-c38a9f653fb0",
      "name": "Lok Hin Luk",
      "handle": "lok-hin-luk-ilca24-hkg",
      "sail_number": "211713",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "HKG",
      "club": "N/A",
      "school": null
    },
    {
      "id": "1061c4af-d39b-52d8-93e5-0290b773acf9",
      "name": "Yuan-Chun Lin",
      "handle": "yuan-chun-lin-ilca24-tpe",
      "sail_number": "225799",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "TPE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde",
      "name": "Chan Nhov",
      "handle": "chan-nhov-ilca24-cam",
      "sail_number": "211727",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CAM",
      "club": "N/A",
      "school": null
    },
    {
      "id": "9d364cd0-cc84-585c-bb0b-768f10d5af1d",
      "name": "Nan Chen",
      "handle": "nan-chen-ilca24-chn",
      "sail_number": "211985",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    },
    {
      "id": "8f9be7b7-29e4-55d2-8e5c-36dde21d09a0",
      "name": "Yu-Shin Chen",
      "handle": "yu-shin-chen-ilca24-tpe",
      "sail_number": "213037",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "TPE",
      "club": "N/A",
      "school": null
    },
    {
      "id": "b2b111b7-7e55-50ee-b1c4-18745684567d",
      "name": "Salem Qaly",
      "handle": "salem-qaly-ilca24-kuw",
      "sail_number": "189512",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "KUW",
      "club": "N/A",
      "school": null
    },
    {
      "id": "49e37e87-02fe-5b3a-b081-77312424e6ab",
      "name": "Yerkebulan Sardarbekov",
      "handle": "yerkebulan-sardarbekov-ilca24-kaz",
      "sail_number": "220122",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "KAZ",
      "club": "N/A",
      "school": null
    },
    {
      "id": "5e91e718-63f1-5fc6-8e86-3b1df4857321",
      "name": "Otegen Shyngys",
      "handle": "otegen-shyngys-ilca24-kaz",
      "sail_number": "216733",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "KAZ",
      "club": "N/A",
      "school": null
    },
    {
      "id": "9aa34924-ef5b-5a1a-9adf-496464259c09",
      "name": "Yulong Qiu",
      "handle": "yulong-qiu-ilca24-chn",
      "sail_number": "211313",
      "sail_number_ilca4": null,
      "gender": "M",
      "nationality": "CHN",
      "club": "N/A",
      "school": null
    }
  ]
}'::jsonb;
  p jsonb;
  s jsonb;
  r jsonb;
  race jsonb;
begin
  -- 1. Insert new sailor profiles
  for p in select value from jsonb_array_elements(b->'newProfiles') loop
    if not exists (select 1 from sailors where id = (p->>'id')::uuid) then
      insert into sailors(id, name, handle, sail_number, sail_number_ilca4, gender, nationality, club, school)
      values (
        (p->>'id')::uuid,
        p->>'name',
        p->>'handle',
        p->>'sail_number',
        p->>'sail_number_ilca4',
        p->>'gender',
        p->>'nationality',
        p->>'club',
        p->>'school'
      );
    end if;
  end loop;

  -- 2. Insert Parent Event
  if not exists (select 1 from regatta_events where id = (b#>>'{event,id}')::uuid) then
    insert into regatta_events(id, name, slug, start_date, end_date, venue, organizer, classes, nor_url, counts_for_ranking)
    values (
      (b#>>'{event,id}')::uuid,
      b#>>'{event,name}',
      b#>>'{event,slug}',
      (b#>>'{event,startDate}')::date,
      (b#>>'{event,endDate}')::date,
      b#>>'{event,venue}',
      b#>>'{event,organizer}',
      '["ILCA 4", "ILCA 6", "ILCA 7"]'::jsonb,
      b#>>'{event,norUrl}',
      false
    );
  end if;

  -- 3. Insert each Sheet and Results
  for s in select value from jsonb_array_elements(b->'sheets') loop
    if not exists (select 1 from regattas where id = (s#>>'{config,id}')::uuid) then
      insert into regattas(id, name, slug, event_id, date, end_date, total_fleet_size, division, race_count, geography, boat_class, entry_type, min_participants, max_participants, counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name, reviewed_at)
      values (
        (s#>>'{config,id}')::uuid,
        s#>>'{config,name}',
        s#>>'{config,slug}',
        (b#>>'{event,id}')::uuid,
        (s#>>'{config,date}')::date,
        (s#>>'{config,endDate}')::date,
        jsonb_array_length(s->'results'),
        s#>>'{config,division}',
        (s#>>'{config,raceCount}')::int,
        'CHN',
        s#>>'{config,boatClass}',
        s#>>'{config,entryType}',
        1,
        1,
        false,
        b#>>'{event,venue}',
        b#>>'{event,organizer}',
        'published',
        'https://sailwave.com/',
        'Official Results Book: 2024 ILCA Asian Open Championship',
        now()
      );
    end if;

    for r in select value from jsonb_array_elements(s->'results') loop
      insert into regatta_results(id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes, verification_status, verified_at)
      values (
        (r->>'resultId')::uuid,
        (r->>'sailorId')::uuid,
        (s#>>'{config,id}')::uuid,
        r->>'name',
        r->>'sailOrBoardNumber',
        s#>>'{config,entryType}',
        (r->>'rank')::int,
        (r->>'grossScore')::real,
        (r->>'nettScore')::real,
        r->>'gender',
        r->>'nationality',
        false,
        false,
        'https://sailwave.com/',
        'https://sailwave.com/',
        'Official Results Book: 2024 ILCA Asian Open Championship',
        'pdf',
        r->>'evidenceNotes',
        'verified',
        now()
      )
      on conflict (id) do nothing;

      -- Participant insertion (solo)
      insert into regatta_result_participants(id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
      values (
        (r->>'participantId')::uuid,
        (r->>'resultId')::uuid,
        (r->>'sailorId')::uuid,
        r->>'name',
        1,
        'solo',
        'matched',
        false
      )
      on conflict (id) do nothing;

      -- Race results insertion
      insert into regatta_race_results(regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
      select
        (r->>'resultId')::uuid,
        (x->>'raceNumber')::int,
        (x->>'score')::real,
        x->>'code',
        (x->>'discarded')::boolean,
        x->>'raw'
      from jsonb_array_elements(r->'races') x;
    end loop;

    insert into admin_change_log(action, entity_type, entity_id, entity_label, summary, details, source)
    values (
      'results.import_ilca_asian_championship_2024',
      'regatta',
      (s#>>'{config,id}')::uuid,
      s#>>'{config,name}',
      'Imported official 2024 ILCA Asian Open Championship sheet with reconciled scores and participant links.',
      jsonb_build_object(
        'sheetId', s#>>'{config,id}',
        'name', s#>>'{config,name}',
        'entryCount', jsonb_array_length(s->'results'),
        'raceCount', s#>>'{config,raceCount}'
      ),
      b->>'batch'
    );
  end loop;

  -- 4. Post-flight Integrity Assertions
  if (select count(*) from regatta_results where regatta_id in (select (value#>>'{config,id}')::uuid from jsonb_array_elements(b->'sheets'))) <> 249 then
    raise exception 'Entry count mismatch: expected 249';
  end if;

  if (select count(*) from regatta_race_results where regatta_result_id in (select id from regatta_results where regatta_id in (select (value#>>'{config,id}')::uuid from jsonb_array_elements(b->'sheets')))) <> 2490 then
    raise exception 'Race result count mismatch: expected 2490';
  end if;

  -- Reconcile score math across all 5 sheets
  if exists (
    select 1 from regatta_race_results rr
    join regatta_results r on r.id = rr.regatta_result_id
    where r.regatta_id in (select (value#>>'{config,id}')::uuid from jsonb_array_elements(b->'sheets'))
    group by rr.regatta_result_id, r.total_score, r.nett_score
    having abs(sum(rr.score) - r.total_score) > 0.01
       or abs(sum(rr.score) filter (where not rr.discarded) - r.nett_score) > 0.01
  ) then
    raise exception 'Score reconciliation failed in 2024 ILCA Asian Championship race results';
  end if;

end
$import$;

rollback;
