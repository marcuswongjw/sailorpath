import { describe, expect, it } from "vitest";
import {
  buildProfileAnalytics,
  buildResultTags,
  fleetLabelForResult,
} from "./profileAnalytics";

function monthsAgo(m: number): string {
  const d = new Date();
  d.setMonth(d.getMonth() - m);
  return d.toISOString().slice(0, 10);
}

const sampleResults = [
  {
    id: "1",
    regattaId: "r1",
    regattaName: "NR3 2026",
    regattaDate: "2026-06-01",
    rank: 12,
    nettScore: 58,
    division: "Gold",
    geography: "SG",
    fleetSize: 100,
  },
  {
    id: "2",
    regattaId: "r2",
    regattaName: "SSF Cup 2025",
    regattaDate: "2025-12-01",
    rank: 8,
    nettScore: 42,
    division: "Silver",
    geography: "SG",
    fleetSize: 84,
  },
  {
    id: "3",
    regattaId: "r3",
    regattaName: "Overseas Cup",
    regattaDate: "2026-04-01",
    rank: 5,
    nettScore: 30,
    division: "Gold",
    geography: "ESP",
    isOverseasCommitment: true,
    fleetSize: 90,
  },
  {
    id: "4",
    regattaId: "r4",
    regattaName: "Novice",
    regattaDate: "2024-11-01",
    rank: 28,
    division: "Silver",
    geography: "SG",
    countsForRanking: false,
  },
];

describe("buildProfileAnalytics", () => {
  it("new gold (<12 mo) includes silver in trend and results", () => {
    const a = buildProfileAnalytics(
      { goldEntryDate: monthsAgo(4) },
      sampleResults
    );
    expect(a.mode).toBe("new_gold");
    expect(a.regattaCount).toBe(4);
    expect(a.bestSilverFinish).toBe(8);
    expect(a.bestGoldFinish).toBe(5);
    expect(a.displayResults.length).toBeLessThanOrEqual(8);
    // silver present in list
    expect(
      a.displayResults.some((r) => fleetLabelForResult(r, a.goldEntryDate) === "Silver")
    ).toBe(true);
    expect(a.trend.some((t) => t.fleet === "Silver")).toBe(true);
  });

  it("established gold (≥12 mo) excludes silver from trend/results", () => {
    const a = buildProfileAnalytics(
      { goldEntryDate: monthsAgo(18) },
      sampleResults
    );
    expect(a.mode).toBe("established_gold");
    expect(a.regattaCount).toBe(4); // still total
    expect(a.displayResults.every((r) => fleetLabelForResult(r, a.goldEntryDate) === "Gold")).toBe(
      true
    );
    expect(a.trend.every((t) => t.fleet === "Gold")).toBe(true);
    expect(a.top10Count).toBeGreaterThanOrEqual(1);
    // Sample has 5th & 12th — top 10 but no podium → hide medal tally
    expect(a.medals.show).toBe(false);
  });

  it("shows medal tally only with podium (1st–3rd)", () => {
    const a = buildProfileAnalytics(
      { goldEntryDate: monthsAgo(18) },
      [
        ...sampleResults,
        {
          id: "5",
          regattaId: "r5",
          regattaName: "Win",
          regattaDate: "2026-05-01",
          rank: 1,
          division: "Gold",
          geography: "SG",
        },
      ]
    );
    expect(a.medals.gold).toBe(1);
    expect(a.medals.show).toBe(true);
  });

  it("counts top 10 and avg finish on gold pool for established", () => {
    const a = buildProfileAnalytics(
      { goldEntryDate: monthsAgo(24) },
      sampleResults
    );
    // gold ranks: 12, 5 → top10 = 1 (the 5th), avg = 8.5
    expect(a.top10Count).toBe(1);
    expect(a.avgFinishLabel).toBe("8.5");
  });
});

describe("buildResultTags", () => {
  it("tags top 10, gold, overseas, non-ranking", () => {
    const tags = buildResultTags(
      {
        rank: 5,
        division: "Gold",
        geography: "ESP",
        isOverseasCommitment: true,
        countsForRanking: false,
      },
      "2025-01-01"
    );
    const labels = tags.map((t) => t.label);
    expect(labels).toContain("Top 10");
    expect(labels).toContain("Gold fleet");
    expect(labels).toContain("Overseas");
    expect(labels).toContain("Non-ranking");
  });
});
