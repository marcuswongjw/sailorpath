import type { PrizeCategory, RegattaPrizeSchedule } from "./regattaPrizes";

type WinnerRow = [name: string, handle: string, sail: string, gender: "M" | "F", overall: number, nett: number];
const organiserReport = "https://www.sail-world.com/news/291403/Optimist-Asian-and-Oceanian-Championship-overall";

function podium(categoryName: string, rows: WinnerRow[], firstPrizeTitle?: string | null, sourceUrl?: string): PrizeCategory {
  return {
    categoryName, prizesAwarded: "1st to 3rd",
    ...(sourceUrl ? { sourceUrl, sourceKind: "organiser-report" as const } : {}),
    winners: rows.map(([sailorName, sailorHandle, sailNumber, gender, overall, nett], index) => ({
      rank: index + 1, sailorName, sailorHandle, sailNumber, gender,
      prizeTitle: index === 0 && firstPrizeTitle ? firstPrizeTitle : `${index + 1}${index === 0 ? "st" : index === 1 ? "nd" : "rd"} ${categoryName}`,
      notes: `Overall position ${overall}; ${nett} points nett.`,
    })),
  };
}

/** Explicit, source-checked placings; no age, final-fleet or continental guesses from profiles. */
const additions: Record<string, PrizeCategory[]> = {
  "2026-optimist-world-championship-overall": [
    podium("Silver Fleet", [["Eren Kaan Erendemir", "eren-kaan-erendemir-worlds26-52181c", "TUR 1776", "M", 72, 134], ["Nicola Di Pilla", "nicola-di-pilla-worlds26-2aa69d", "ITA 397", "M", 73, 160], ["Jonny Jaap Seekamp", "jonny-jaap-seekamp-worlds26-d9ef32", "GER 1902", "M", 74, 172]]),
    podium("Bronze Fleet", [["Jacques Kent", "jacques-kent-worlds26-53e893", "GBR 6687", "M", 143, 177], ["Alix Nguyen-Minh", "alix-nguyen-minh", "HKG 189", "F", 144, 184], ["Walton Macpherson", "walton-macpherson-worlds26-fde51a", "USA 444", "M", 145, 212]]),
    podium("Emerald Fleet", [["Paul Miller", "paul-miller-worlds26-5e3def", "AUT 2083", "M", 214, 225], ["Lucas Christiansen Del Valle", "lucas-christiansen-del-valle-worlds26-817fdd", "PUR 70", "M", 215, 265], ["Vicente Perez", "vicente-perez-worlds26-993acd", "CHI 292", "M", 216, 282]])
  ],
  "2025-optimist-asian-oceanian-championship-overall": [
    podium("Asian", [["Sorawit Naksuk", "sorawit-naksuk-812d4t4", "THA 1493", "M", 1, 13], ["Ethan Chia Han Wei", "ethan-chia-han-wei", "SGP 121", "M", 2, 17], ["Anya Alessia Zahedi", "anya-alessia-zahedi", "SGP 159", "F", 4, 20]], "Asian Champion"),
    podium("Oceanian", [["William Harris", "william-harris-asians25", "AUS 1932", "M", 30, 88], ["Balthazar Roche", "balthazar-roche-asians25", "AUS 1931", "M", 40, 102], ["Jeffrey Chenglin Du", "jeffrey-chenglin-du-asians25", "NZL 4675", "M", 62, 99]], "Oceanian Champion"),
    podium("Silver Fleet", [["Kornelia Pajak", "asian-uae-kornelia-p-748bbf", "UAE 30", "F", 58, 76], ["Simón Katz", "sim-n-katz-asians25", "ARG 3933", "M", 59, 85], ["Roberta De Oliveira Horn", "roberta-de-oliveira-horn-asians25", "BRA 4323", "F", 60, 89]], null, organiserReport),
    podium("Bronze Fleet", [["Soki Higuchi", "asian-jpn-soki-higuc-fb3822", "JPN 3443", "M", 115, 140], ["Kaito Nakamura", "asian-jpn-kaito-naka-a602cf", "JPN 3389", "M", 116, 155], ["Tarteel Al Hasani", "asian-oma-tarteel-al-05a14c", "OMA 323", "F", 117, 157]], null, organiserReport)
  ],
  "2026-optimist-european-championship-boys": [
    podium("Overall (Boys)", [["Nikolaos Pappas", "nikolaos-pappas-euro26-996c31", "GRE 9009", "M", 1, 23], ["Giorgio Nibbi", "giorgio-nibbi-euro26-99f4cc", "ITA 321", "M", 2, 39], ["Lucas Garrido", "lucas-garrido-euro26-4298d8", "ESP 3540", "M", 3, 48]]),
    podium("European Boys", [["Nikolaos Pappas", "nikolaos-pappas-euro26-996c31", "GRE 9009", "M", 1, 23], ["Giorgio Nibbi", "giorgio-nibbi-euro26-99f4cc", "ITA 321", "M", 2, 39], ["Lucas Garrido", "lucas-garrido-euro26-4298d8", "ESP 3540", "M", 3, 48]], "European Boy Champion"),
    podium("Silver Fleet (Boys)", [["Konrad Baltazar Zsidai", "konrad-baltazar-zsidai-euro26-1e1cee", "HUN 1693", "M", 58, 109], ["Thomas Giusti", "thomas-giusti-euro26-e979a1", "MLT 193", "M", 59, 111], ["Finn Byrne", "finn-byrne-euro26-3d4c45", "GBR 6685", "M", 60, 121]]),
    podium("Bronze Fleet (Boys)", [["Valentin Vogl", "valentin-vogl-euro26-d2a4c6", "AUT 955", "M", 115, 179], ["Oliver Chin", "oliver-chin-euro26-147229", "CAN 1818", "M", 116, 184], ["Beeri Tal Kalfon", "beeri-tal-kalfon-euro26-08b31d", "ISR 985", "M", 117, 187]])
  ],
  "2026-optimist-european-championship-girls": [
    podium("Silver Fleet (Girls)", [["Hannah Jentsch", "hannah-jentsch-euro26-5ab2b2", "GER 1976", "F", 62, 152], ["Kata Nemeth", "kata-nemeth-euro26-521b06", "HUN 1651", "F", 63, 173], ["Ida Falatov", "ida-falatov-euro26-c322d2", "SLO 497", "F", 64, 174]])
  ],
  "2026-ilca-4-youth-worlds-boys": [
    podium("Overall (Boys)", [["Leo Gosling", "ilca4-worlds26-sui-leo-gosling-911f4a", "SUI 224698", "M", 1, 38], ["Stefanos Samaras", "ilca4-worlds26-gre-stefanos-samaras-1c63c5", "GRE 226859", "M", 2, 67], ["Alexander Montagu", "ilca4-worlds26-usa-alexander-montagu-239ad7", "USA 226590", "M", 3, 78]], "Boys\u2019 World Champion"),
    podium("Boys U16", [["Xuacu García Rigo", "ilca4-worlds26-esp-xuacu-garc-a-rigo-967f4c", "ESP 222146", "M", 14, 156], ["Ángel Peñalver", "ilca4-worlds26-esp-ngel-pe-alver-50c4d9", "ESP 225412", "M", 15, 157], ["Jiun Choi", "ilca4-worlds26-kor-jiun-choi-614785", "KOR 225770", "M", 17, 170]], "U16 Boys\u2019 World Champion")
  ],
  "2026-ilca-4-youth-worlds-girls": [
    podium("Girls U16", [["Eleni Triantou", "ilca4-worlds26-gre-eleni-triantou-882ae3", "GRE 208698", "F", 1, 91], ["Cassandra Jansch", "ilca4-worlds26-ger-cassandra-jansch-af4fea", "GER 225071", "F", 4, 122], ["Chloe Grayton", "ilca4-worlds26-gbr-chloe-grayton-1d0641", "GBR 227541", "F", 7, 134]], "U16 Girls\u2019 World Champion")
  ],
  "2026-ilca-asian-cup-ilca4": [
    podium("Boys U18", [["Ethan Chia Han Wei", "ethan-chia-han-wei", "228368", "M", 1, 19], ["Jiun Choi", "ilca4-worlds26-kor-jiun-choi-614785", "223205", "M", 3, 22], ["Chen Yu Kai", "chen-yu-kai-thai25-ad7a6b", "222236", "M", 4, 28]]),
    podium("Boys U16", [["Jiun Choi", "ilca4-worlds26-kor-jiun-choi-614785", "223205", "M", 3, 22], ["Lim Yuk Jun", "lim-yuk-jun", "225182", "M", 17, 80], ["Austin Lee", "austin-lee-thai25-554015", "217710", "M", 18, 81]])
  ],
};

export function extendInternationalPrizeSchedules(schedules: RegattaPrizeSchedule[]): RegattaPrizeSchedule[] {
  const girlsEurope = schedules.find((s) => s.regattaSlug === "2026-optimist-european-championship-girls")!;
  const girlsWorlds = schedules.find((s) => s.regattaSlug === "2026-ilca-4-youth-worlds-girls")!;
  const boys: RegattaPrizeSchedule[] = [
    { ...girlsEurope, regattaSlug: "2026-optimist-european-championship-boys", regattaName: "2026 Optimist European Championship (Boys)",
      sourceDescription: "NoR 17: separate open and European-member boys’ podiums, plus Silver and Bronze final-fleet prizes. Final-fleet membership checked in the organiser’s standings.",
      fleets: [{ fleetName: "Optimist Boys", boatClass: "Optimist", division: "Boys", categories: [] }] },
    { ...girlsWorlds, regattaSlug: "2026-ilca-4-youth-worlds-boys", regattaName: "2026 ILCA 4 Youth World Championships (Boys)",
      sourceDescription: "NoR 16: boys’ championship and U16 podiums. Winners corroborated by the organiser’s published online results, not a newly verified results PDF.",
      fleets: [{ fleetName: "ILCA 4 Boys", boatClass: "ILCA 4", division: "Boys", categories: [] }] },
  ];
  return [...schedules, ...boys].map((schedule) => ({
    ...schedule,
    sourceDescription: schedule.sourceDescription + (schedule.regattaSlug === "2025-optimist-asian-oceanian-championship-overall"
      ? " Includes Asian/Oceanian podiums and final-fleet prizes confirmed by Oman Sail’s closing report."
      : schedule.regattaSlug === "2026-ilca-4-youth-worlds-girls" ? " Includes the official U16 girls’ standings."
      : schedule.regattaSlug === "2026-ilca-asian-cup-ilca4" ? " Includes boys’ U18 and U16 podiums." : ""),
    fleets: schedule.fleets.map((fleet) => ({ ...fleet, categories: [
      ...fleet.categories.map((category) => schedule.regattaSlug === "2026-optimist-world-championship-overall" && category.categoryName === "Open"
        ? { ...category, firstPrizeTitle: "World Champion / Beacon Challenge Cup / Peter Barclay Trophy" }
        : schedule.regattaSlug === "2025-optimist-asian-oceanian-championship-overall" && category.categoryName === "Open"
          ? { ...category, firstPrizeTitle: "Overall and Boys’ Asian & Oceanian Champion / IODA Perpetual Trophy" } : category),
      ...(additions[schedule.regattaSlug] || []),
    ] })),
  }));
}
