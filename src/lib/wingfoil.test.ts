import { describe, expect, it } from "vitest";
import {
  parseWingfoilScreenshotFilename,
  computeWingfoilNett,
  recalculateScoreboard,
  normalizeSailorName,
  areSailNumbersMatching,
  buildHistoricalSailNumberMap,
  applyHistoricalSailNumbers,
  mergeWingfoilRegattaLists,
  type WingfoilRaceScore,
  type WingfoilSailorResult,
  type WingfoilRegatta,
} from "./wingfoil";

describe("parseWingfoilScreenshotFilename", () => {
  it("extracts regatta name and ISO date correctly", () => {
    const result = parseWingfoilScreenshotFilename(
      "SNSC_2026_WingFoil_2026-09-05.png"
    );
    expect(result.regattaName).toBe("SNSC 2026 WingFoil");
    expect(result.startDate).toBe("2026-09-05");
  });

  it("extracts from names with underscores and date at beginning", () => {
    const result = parseWingfoilScreenshotFilename(
      "2026-09-05_Singapore_National_Sailing_Championships.jpg"
    );
    expect(result.regattaName).toBe(
      "Singapore National Sailing Championships"
    );
    expect(result.startDate).toBe("2026-09-05");
  });

  it("extracts from Southwest Monsoon GP filename", () => {
    const result = parseWingfoilScreenshotFilename(
      "SW_Monsoon_GP_2026-07-15.png"
    );
    expect(result.regattaName).toBe("SW Monsoon GP");
    expect(result.startDate).toBe("2026-07-15");
  });

  it("handles DMY format", () => {
    const result = parseWingfoilScreenshotFilename(
      "Wingfoil_National_Regatta_05-09-2026.png"
    );
    expect(result.regattaName).toBe("Wingfoil National Regatta");
    expect(result.startDate).toBe("2026-09-05");
  });

  it("falls back gracefully for generic screenshot names", () => {
    const result = parseWingfoilScreenshotFilename(
      "Screenshot 2026-09-07 at 4.31.22 PM.png"
    );
    expect(result.regattaName).toBe("Singapore WingFoil Sprint Slalom");
    expect(result.startDate).toBe("2026-09-07");
  });
});

describe("computeWingfoilNett", () => {
  it("does not discard if fewer than 4 races completed", () => {
    const races: WingfoilRaceScore[] = [
      { score: 1 },
      { score: 2 },
      { score: 3 },
    ];
    const { grossScore, nettScore, scoredRaces } = computeWingfoilNett(races);
    expect(grossScore).toBe(6);
    expect(nettScore).toBe(6);
    expect(scoredRaces.some((r) => r.isDiscarded)).toBe(false);
  });

  it("discards the single worst score when 4 or more races completed", () => {
    const races: WingfoilRaceScore[] = [
      { score: 2 },
      { score: 1 },
      { score: 8, code: "DNF" },
      { score: 1 },
    ];
    const { grossScore, nettScore, scoredRaces } = computeWingfoilNett(races);
    expect(grossScore).toBe(12);
    expect(nettScore).toBe(4);
    expect(scoredRaces[2].isDiscarded).toBe(true);
  });
});

describe("recalculateScoreboard", () => {
  it("sorts competitors by nett score and assigns ranks", () => {
    const competitors: WingfoilSailorResult[] = [
      {
        rank: 99,
        name: "Sailor B",
        sailNumber: "18",
        gender: "F",
        ageCategory: "16&U",
        schoolName: "School B",
        club: "Club B",
        races: [
          { score: 5 },
          { score: 5 },
          { score: 5 },
          { score: 5 },
        ],
        grossScore: 0,
        nettScore: 0,
      },
      {
        rank: 99,
        name: "Sailor A",
        sailNumber: "21",
        gender: "F",
        ageCategory: "16&U",
        schoolName: "School A",
        club: "Club A",
        races: [
          { score: 1 },
          { score: 1 },
          { score: 1 },
          { score: 10 },
        ],
        grossScore: 0,
        nettScore: 0,
      },
    ];

    const updated = recalculateScoreboard(competitors);
    expect(updated[0].name).toBe("Sailor A");
    expect(updated[0].rank).toBe(1);
    expect(updated[0].nettScore).toBe(3);

    expect(updated[1].name).toBe("Sailor B");
    expect(updated[1].rank).toBe(2);
    expect(updated[1].nettScore).toBe(15);
  });
});

describe("sail number matching and resolution", () => {
  it("normalizes sailor names ignoring case, spaces, and punctuation", () => {
    expect(normalizeSailorName("Jun Hao Lo")).toBe("junhaolo");
    expect(normalizeSailorName("LO, Jun-Hao")).toBe("lojunhao");
    expect(normalizeSailorName("  Gaston  Fischer  ")).toBe("gastonfischer");
  });

  it("checks sail number matching with SGP prefixes and formatting", () => {
    expect(areSailNumbersMatching("43", "43")).toBe(true);
    expect(areSailNumbersMatching("SGP 43", "43")).toBe(true);
    expect(areSailNumbersMatching("SGP-43", "43")).toBe(true);
    expect(areSailNumbersMatching("43", "99")).toBe(false);
  });

  it("builds historical sail number map and applies to competitors with missing sail numbers", () => {
    const sampleRegattas: WingfoilRegatta[] = [
      {
        id: "regatta-1",
        name: "GP 1",
        shortName: "GP1",
        dates: "Jan 2026",
        venue: "ECP",
        organizer: "SSF",
        format: "Sprint Slalom",
        status: "Completed",
        scoringSystem: "Low point",
        rulesNotes: "",
        results: [
          {
            rank: 1,
            name: "Jun Hao Lo",
            sailNumber: "43",
            gender: "M",
            ageCategory: "Open",
            schoolName: "",
            club: "",
            races: [],
            grossScore: 0,
            nettScore: 0,
          },
        ],
      },
    ];

    const map = buildHistoricalSailNumberMap(sampleRegattas);
    expect(map.get("junhaolo")?.sailNumber).toBe("43");

    // Competitor in new regatta has missing sailNumber
    const newResults: WingfoilSailorResult[] = [
      {
        rank: 1,
        name: "Jun Hao Lo",
        sailNumber: "",
        gender: "M",
        ageCategory: "Open",
        schoolName: "",
        club: "",
        races: [],
        grossScore: 0,
        nettScore: 0,
      },
    ];

    const { results, autoAssignedCount } = applyHistoricalSailNumbers(newResults, map);
    expect(autoAssignedCount).toBe(1);
    expect(results[0].sailNumber).toBe("43");
  });
});

describe("mergeWingfoilRegattaLists", () => {
  it("preserves regattas with results over empty placeholders", () => {
    const serverEmpty: WingfoilRegatta[] = [
      {
        id: "ne-monsoon-series-gp2-2026",
        name: "GP2",
        shortName: "GP2",
        dates: "2026",
        venue: "ECP",
        organizer: "SSF",
        format: "Sprint Slalom",
        status: "Upcoming",
        scoringSystem: "Low Point",
        rulesNotes: "Notes",
        results: [],
      },
    ];

    const localWithResults: WingfoilRegatta[] = [
      {
        id: "ne-monsoon-series-gp2-2026",
        name: "GP2",
        shortName: "GP2",
        dates: "2026",
        venue: "ECP",
        organizer: "SSF",
        format: "Sprint Slalom",
        status: "Completed",
        lifecycleStatus: "published",
        scoringSystem: "9 races, 1 discard",
        rulesNotes: "Notes",
        results: [
          {
            rank: 1,
            name: "Sailor One",
            sailNumber: "10",
            gender: "M",
            ageCategory: "Open",
            schoolName: "",
            club: "Constant Wind",
            races: [{ score: 1 }],
            grossScore: 1,
            nettScore: 1,
          },
        ],
      },
    ];

    const merged = mergeWingfoilRegattaLists(serverEmpty, localWithResults);
    expect(merged).toHaveLength(1);
    expect(merged[0].results).toHaveLength(1);
    expect(merged[0].results![0].name).toBe("Sailor One");
  });
});

