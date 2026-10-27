import { extendInternationalPrizeSchedules } from "./internationalAdditionalPrizes";
import type { PrizeWinner, RegattaPrizeSchedule } from "./regattaPrizes";

const noFees = { singleHanded: 0, doubleHanded: 0, earlyBirdDeadline: "", finalDeadline: "", lateFee: 0 };
const winner = (rank: number, sailorName: string, sailorHandle: string, sailNumber: string, prizeTitle?: string): PrizeWinner => ({
  rank, sailorName, sailorHandle, sailNumber, gender: "F",
  prizeTitle: prizeTitle || `${rank}${rank === 1 ? "st" : rank === 2 ? "nd" : "rd"} Girl`,
});
const medalist = (rank: number, sailorName: string, sailorHandle: string, sailNumber: string, gender: "M" | "F", prizeTitle?: string, notes?: string): PrizeWinner => ({
  rank, sailorName, sailorHandle, sailNumber, gender,
  prizeTitle: prizeTitle || (rank === 1 ? "Gold Medal" : rank === 2 ? "Silver Medal" : "Bronze Medal"),
  notes,
});
const base = { registrationUrl: "", entryFees: noFees, scheduleSummary: "", scoringRules: "", sourceKind: "notice-of-race" as const };

/** Event-specific awards only. Never infer continental eligibility from a sailor's profile country. */
export const INTERNATIONAL_REGATTA_PRIZE_SCHEDULES: RegattaPrizeSchedule[] = extendInternationalPrizeSchedules([
  {
    ...base,
    regattaSlug: "2026-optimist-world-championship-overall", regattaName: "2026 Optimist World Championship", year: 2026,
    datesText: "18–28 June 2026", venue: "Tangier, Morocco", organizer: "Royal Yacht Club de Tanger / IODA",
    sourceUrl: "https://optimist-it.com/admin/_static/files/regate/175621064967076/176821260493960.pdf",
    noticeOfRaceUrl: "https://optimist-it.com/admin/_static/files/regate/175621064967076/176821260493960.pdf",
    officialNoticeBoardUrl: "https://2026worlds.optiworld.org/en/default/races/race", websiteUrl: "https://2026worlds.optiworld.org/",
    sourceDescription: "NoR 17.1: overall top 20 and girls’ top three. Girls’ champion receives the Helen Mary Wilkes Trophy. Winners checked against the official final standings.",
    fleets: [{ fleetName: "Optimist", boatClass: "Optimist", categories: [
      { categoryName: "Open", prizesAwarded: "1st to 20th", winners: [] },
      { categoryName: "Girls", prizesAwarded: "1st to 3rd", winners: [
        winner(1, "Ines Mendez Larminaux", "ines-mendez-larminaux-hkrw-80c3e8", "PUR 108", "1st Girl / Helen Mary Wilkes Trophy"),
        winner(2, "Margaux Nguyen-Minh", "margaux-nguyen-minh-fcs112q", "HKG 188"),
        winner(3, "Mara Peñalver", "mara-penalver-worlds26-c20069", "ESP 3737"),
      ] },
    ] }],
  },
  {
    ...base,
    regattaSlug: "2025-optimist-asian-oceanian-championship-overall", regattaName: "2025 Optimist Asian & Oceanian Championship", year: 2025,
    datesText: "25 October–1 November 2025", venue: "Mussanah, Oman", organizer: "Oman Sail / IODA",
    sourceUrl: "https://d282wvk2qi4wzk.cloudfront.net/nStYUrDZgIRR_upload_kujycb4Vou_7u0gd8Bfi2_1758907870555",
    noticeOfRaceUrl: "https://d282wvk2qi4wzk.cloudfront.net/nStYUrDZgIRR_upload_kujycb4Vou_7u0gd8Bfi2_1758907870555",
    officialNoticeBoardUrl: "https://2025asianoceanians.optiworld.org/en/default/races/race", websiteUrl: "https://2025asianoceanians.optiworld.org/",
    sourceDescription: "NoR 17.1: open overall and girls’ top three, regardless of continent. Anya Zahedi also receives the Asian & Oceanian girls’ IODA Perpetual Trophy.",
    fleets: [{ fleetName: "Optimist", boatClass: "Optimist", categories: [
      { categoryName: "Open", prizesAwarded: "1st to 3rd", winners: [] },
      { categoryName: "Girls", prizesAwarded: "1st to 3rd", winners: [
        winner(1, "Anya Alessia Zahedi", "anya-alessia-zahedi", "SGP 159", "1st Girl / IODA Perpetual Trophy"),
        winner(2, "Lyric Li Yuxuan", "lyric-li-yuxuan", "CHN 5001"),
        winner(3, "Shreya Krishna Lakshminarayanan", "shreya-krishna-lakshminarayanan-yvqywlz", "IND 1632"),
      ] },
    ] }],
  },
  {
    ...base,
    regattaSlug: "2026-optimist-european-championship-girls", regattaName: "2026 Optimist European Championship (Girls)", year: 2026,
    datesText: "24–31 July 2026", venue: "Gdynia, Poland", organizer: "Marina Gdynia / Polish Yachting Association / IODA",
    sourceUrl: "https://2026europeans.optiworld.org/uploaded_files/Document_133556_20260210232146_en.pdf",
    noticeOfRaceUrl: "https://2026europeans.optiworld.org/uploaded_files/Document_133556_20260210232146_en.pdf",
    officialNoticeBoardUrl: "https://2026europeans.optiworld.org/en/default/races/race", websiteUrl: "https://2026europeans.optiworld.org/",
    sourceDescription: "NoR 17.1.2 and 17.1.4: separate open girls’ and European-member girls’ podiums. The open podium includes non-European members; the European title does not.",
    fleets: [{ fleetName: "Optimist Girls", boatClass: "Optimist", division: "Girls", categories: [
      { categoryName: "Overall (Girls)", prizesAwarded: "1st to 3rd", winners: [
        winner(1, "Maria De Lluc Bestard", "maria-de-lluc-bestard-euro26-dfd246", "ESP 3631"),
        winner(2, "Ada Vera Tüfekçiler", "ada-vera-tufekciler-euro26-009ce5", "TUR 1024"),
        winner(3, "Morgan Rosenthal", "morgan-rosenthal-euro26-d14b02", "USA 9550"),
      ] },
      { categoryName: "European Girls", prizesAwarded: "1st to 3rd", eligibilityNotes: "Representing a European IODA member; separate from the open girls’ podium.", winners: [
        winner(1, "Maria De Lluc Bestard", "maria-de-lluc-bestard-euro26-dfd246", "ESP 3631", "European Girl Champion"),
        winner(2, "Ada Vera Tüfekçiler", "ada-vera-tufekciler-euro26-009ce5", "TUR 1024", "2nd European Girl"),
        winner(3, "Barbara Gmurek", "barbara-gmurek-euro26-7a367c", "POL 3692", "3rd European Girl"),
      ] },
    ] }],
  },
  {
    ...base,
    regattaSlug: "2026-ilca-4-youth-worlds-girls", regattaName: "2026 ILCA 4 Youth World Championships (Girls)", year: 2026,
    datesText: "1–9 August 2026", venue: "Aarhus, Denmark", organizer: "Aarhus International Sailing Center / ILCA",
    sourceUrl: "https://2026ilca4youth.ilca-worlds.org/wp-content/uploads/sites/34/2025/09/NOR-2026-ILCA-4Y-DEN-Final.pdf",
    noticeOfRaceUrl: "https://2026ilca4youth.ilca-worlds.org/wp-content/uploads/sites/34/2025/09/NOR-2026-ILCA-4Y-DEN-Final.pdf",
    officialNoticeBoardUrl: "https://www.manage2sail.com/en-US/event/568a0112-8d8c-4177-809b-3457f679d87a", websiteUrl: "https://2026ilca4youth.ilca-worlds.org/",
    sourceDescription: "NoR 16: girls’ championship podium. Medalists corroborated by EurILCA’s final report, sourced from Aarhus International Sailing Center.",
    fleets: [{ fleetName: "ILCA 4 Girls", boatClass: "ILCA 4", division: "Girls", categories: [
      { categoryName: "Overall (Girls)", prizesAwarded: "1st to 3rd", winners: [
        winner(1, "Eleni Triantou", "ilca4-worlds26-gre-eleni-triantou-882ae3", "GRE 208698", "Girls’ World Champion"),
        winner(2, "Blanca Ferrando Babe", "ilca4-worlds26-esp-blanca-ferrando-babe-ddaed5", "ESP 228342"),
        winner(3, "Despoina Theodorakopoulou", "ilca4-worlds26-gre-despoina-theodorakopoulou-ee8bdf", "GRE 226195"),
      ] },
    ] }],
  },
  {
    ...base,
    regattaSlug: "2026-ilca-asian-cup-ilca4", regattaName: "2026 ILCA Asian Cup (Penghu)", year: 2026,
    datesText: "19–24 March 2026", venue: "Penghu, Chinese Taipei", organizer: "Chinese Taipei Sailing Association / ILCA Asia",
    noticeOfRaceUrl: "https://www.ct-sailing.org.tw/media/k2/attachments/NOR-2026-ILCA-ASIAN-CUP-PENGHU-FINAL-WEB.pdf",
    officialNoticeBoardUrl: "https://event.ilcaasia.org/ilca-asian-cup-2026-penghu/race-documents/", websiteUrl: "https://event.ilcaasia.org/ilca-asian-cup-2026-penghu/",
    sourceUrl: "https://www.racingrulesofsailing.org/documents/179678",
    sourceDescription: "SI 22: girls’ U18 and U16 top three (at least five entries in each category). Named winners extracted from CTSA’s girls’ results table; U16 is a subset of U18.",
    fleets: [{ fleetName: "ILCA 4", boatClass: "ILCA 4", categories: [
      { categoryName: "Girls U18", prizesAwarded: "1st to 3rd", winners: [
        winner(1, "Pinchanok Klaysomboon", "pinchanok-klaysomboon-ofynlxk", "THA 222687"),
        winner(2, "Songha Lee", "ilca4-kor-songha-lee-223204", "KOR 223204"),
        winner(3, "Mika Tew", "mika-tew-0741h6l", "SGP 227461"),
      ] },
      { categoryName: "Girls U16", prizesAwarded: "1st to 3rd", winners: [
        winner(1, "Songha Lee", "ilca4-kor-songha-lee-223204", "KOR 223204", "1st Girl U16"),
        winner(2, "Mika Tew", "mika-tew-0741h6l", "SGP 227461", "2nd Girl U16"),
        winner(3, "Ashlea Tham Yan Shuang", "tham-yan-shuang-ashlea", "SGP 228468", "3rd Girl U16"),
      ] },
    ] }],
  },
  {
    ...base,
    regattaSlug: "20th-asian-games-2026-ilca4",
    regattaName: "20th Asian Games 2026 (ILCA 4)",
    year: 2026,
    datesText: "26 September–3 October 2026",
    venue: "Kaiyoh Yacht Harbor, Gamagori, Japan",
    organizer: "Olympic Council of Asia / Asian Sailing Federation (ASAF)",
    noticeOfRaceUrl: "https://www.aichi-nagoya2026.org",
    officialNoticeBoardUrl: "https://www.aichi-nagoya2026.org",
    websiteUrl: "https://www.aichi-nagoya2026.org",
    sourceUrl: "https://www.aichi-nagoya2026.org",
    sourceDescription: "Official Asian Games sailing results. Standings corroborated across OCA, ASAF, and Singapore Sailing Federation releases.",
    fleets: [{
      fleetName: "ILCA 4",
      boatClass: "ILCA 4",
      categories: [
        {
          categoryName: "Boys",
          prizesAwarded: "1st to 3rd",
          winners: [
            medalist(1, "Choi Ji-un", "ilca4-worlds26-kor-jiun-choi-614785", "KOR 225770", "M", "Gold Medal (1st Boy)", "25 net pts (3 bullets)"),
            medalist(2, "Ian Goh", "ian-goh", "SGP 222713", "M", "Silver Medal (2nd Boy)", "25 net pts (2 bullets)"),
            medalist(3, "Tiago Cheng De Villemor Salgado", "tiago-cheng-de-villemor-salgado", "HKG", "M", "Bronze Medal (3rd Boy)", "27 net pts"),
          ],
        },
      ],
    }],
  },
  {
    ...base,
    regattaSlug: "20th-asian-games-2026-ilca6",
    regattaName: "20th Asian Games 2026 (ILCA 6)",
    year: 2026,
    datesText: "26 September–3 October 2026",
    venue: "Kaiyoh Yacht Harbor, Gamagori, Japan",
    organizer: "Olympic Council of Asia / Asian Sailing Federation (ASAF)",
    noticeOfRaceUrl: "https://www.aichi-nagoya2026.org",
    officialNoticeBoardUrl: "https://www.aichi-nagoya2026.org",
    websiteUrl: "https://www.aichi-nagoya2026.org",
    sourceUrl: "https://www.aichi-nagoya2026.org",
    sourceDescription: "Official Asian Games sailing results. Standings corroborated across OCA, ASAF, and Singapore Sailing Federation releases.",
    fleets: [{
      fleetName: "ILCA 6",
      boatClass: "ILCA 6",
      categories: [
        {
          categoryName: "Women",
          prizesAwarded: "1st to 3rd",
          winners: [
            medalist(1, "Sophia Montgomery", "sophia-montgomery", "THA", "F", "Gold Medal (LA28 Olympic Quota)", "5 net pts"),
            medalist(2, "Jania Ang", "jania-ang", "SGP 222727", "F", "Silver Medal", "13 net pts"),
            medalist(3, "Nethra Kumanan", "nethra-kumanan", "IND", "F", "Bronze Medal", "14 net pts"),
          ],
        },
      ],
    }],
  },
  {
    ...base,
    regattaSlug: "20th-asian-games-2026-ilca7",
    regattaName: "20th Asian Games 2026 (ILCA 7)",
    year: 2026,
    datesText: "26 September–3 October 2026",
    venue: "Kaiyoh Yacht Harbor, Gamagori, Japan",
    organizer: "Olympic Council of Asia / Asian Sailing Federation (ASAF)",
    noticeOfRaceUrl: "https://www.aichi-nagoya2026.org",
    officialNoticeBoardUrl: "https://www.aichi-nagoya2026.org",
    websiteUrl: "https://www.aichi-nagoya2026.org",
    sourceUrl: "https://www.aichi-nagoya2026.org",
    sourceDescription: "Official Asian Games sailing results. Standings corroborated across OCA, ASAF, and World Sailing releases.",
    fleets: [{
      fleetName: "ILCA 7",
      boatClass: "ILCA 7",
      categories: [
        {
          categoryName: "Men",
          prizesAwarded: "1st to 3rd",
          winners: [
            medalist(1, "Ha Jee-min", "ha-jee-min", "KOR", "M", "Gold Medal (LA28 Olympic Quota)", "9 net pts"),
            medalist(2, "Nicholas Halliday", "nicholas-halliday", "HKG", "M", "Silver Medal", "11 net pts"),
            medalist(3, "Khairulnizam Mohd Afendy", "khairulnizam-mohd-afendy", "MAS", "M", "Bronze Medal", "18 net pts"),
          ],
        },
      ],
    }],
  },
  {
    ...base,
    regattaSlug: "20th-asian-games-2026-29er",
    regattaName: "20th Asian Games 2026 (29er)",
    year: 2026,
    datesText: "26 September–3 October 2026",
    venue: "Kaiyoh Yacht Harbor, Gamagori, Japan",
    organizer: "Olympic Council of Asia / Asian Sailing Federation (ASAF)",
    noticeOfRaceUrl: "https://www.aichi-nagoya2026.org",
    officialNoticeBoardUrl: "https://www.aichi-nagoya2026.org",
    websiteUrl: "https://www.aichi-nagoya2026.org",
    sourceUrl: "https://www.aichi-nagoya2026.org",
    sourceDescription: "Official Asian Games sailing results. Standings corroborated across OCA, ASAF, and Singapore Sailing Federation releases.",
    fleets: [{
      fleetName: "29er",
      boatClass: "29er",
      categories: [
        {
          categoryName: "Men",
          prizesAwarded: "1st to 3rd",
          winners: [
            medalist(1, "Ethan Kiu / Louis Polson", "ethan-kiu-louis-polson", "HKG", "M", "Gold Medal", "20 net pts"),
            medalist(2, "Sean Kum Kok Wei / Nigel Tan Xu Yuan", "sean-kum-nigel-tan-2472", "SGP 2472", "M", "Silver Medal", "24 net pts"),
            medalist(3, "Muhammad Adam Aierell / Iqbal Nazham Musmuliadi", "adam-aierell-iqbal-nazham", "MAS", "M", "Bronze Medal", "31 net pts"),
          ],
        },
      ],
    }],
  },
  {
    ...base,
    regattaSlug: "20th-asian-games-2026-iqfoil",
    regattaName: "20th Asian Games 2026 (iQFOiL)",
    year: 2026,
    datesText: "26 September–3 October 2026",
    venue: "Kaiyoh Yacht Harbor, Gamagori, Japan",
    organizer: "Olympic Council of Asia / Asian Sailing Federation (ASAF)",
    noticeOfRaceUrl: "https://www.aichi-nagoya2026.org",
    officialNoticeBoardUrl: "https://www.aichi-nagoya2026.org",
    websiteUrl: "https://www.aichi-nagoya2026.org",
    sourceUrl: "https://www.aichi-nagoya2026.org",
    sourceDescription: "Official Asian Games sailing results. Standings corroborated across OCA, ASAF, and Singapore Sailing Federation releases.",
    fleets: [{
      fleetName: "iQFOiL",
      boatClass: "iQFOiL",
      categories: [
        {
          categoryName: "Men",
          prizesAwarded: "1st to 3rd",
          winners: [
            medalist(1, "Wong Tsz Ho", "wong-tsz-ho", "HKG", "M", "Gold Medal", "22 net pts"),
            medalist(2, "Masato Kozono", "masato-kozono", "JPN", "M", "Silver Medal", "28 net pts"),
            medalist(3, "John Wong Tze Xiang", "john-tze-xiang-wong-acb2ce", "SGP 2", "M", "Bronze Medal", "34 net pts · Historic 1st Asian Games windsurfing medal for Singapore"),
          ],
        },
      ],
    }],
  },
]);

/** Only these published editions have been checked; selection trials must never match. */
const aliases: Record<string, string> = {
  "2026-optimist-world-championship": "2026-optimist-world-championship-overall",
  "2025-optimist-asian-oceanian-championship": "2025-optimist-asian-oceanian-championship-overall",
};
export function getInternationalRegattaPrizeSchedule(slug: string) {
  return INTERNATIONAL_REGATTA_PRIZE_SCHEDULES.find((schedule) => schedule.regattaSlug === (aliases[slug] || slug)) || null;
}
