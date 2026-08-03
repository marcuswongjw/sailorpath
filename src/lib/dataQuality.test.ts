import { describe, expect, it } from "vitest";
import {
  buildDataQualityReport,
  findGoldBeforeEntryIssues,
  findGoldResultsWithoutGoldEntry,
  findOverAgeOptimistIssues,
} from "./dataQuality";

describe("findGoldBeforeEntryIssues", () => {
  it("flags gold result before gold entry", () => {
    const issues = findGoldBeforeEntryIssues([
      {
        sailorId: "1",
        sailorName: "Test",
        goldEntryDate: "2026-07-01",
        regattaDate: "2026-03-01",
        regattaName: "CSC Gold",
        division: "Gold",
        countsForRanking: true,
        boatClass: "Optimist",
      },
    ]);
    expect(issues).toHaveLength(1);
    expect(issues[0].earliestGoldRegattaDate).toBe("2026-03-01");
  });

  it("ignores results on/after gold entry", () => {
    expect(
      findGoldBeforeEntryIssues([
        {
          sailorId: "1",
          sailorName: "Test",
          goldEntryDate: "2026-01-01",
          regattaDate: "2026-03-01",
          regattaName: "CSC",
          division: "Gold",
          countsForRanking: true,
        },
      ])
    ).toHaveLength(0);
  });
});

describe("findGoldResultsWithoutGoldEntry", () => {
  it("flags gold races when gold entry is missing", () => {
    const issues = findGoldResultsWithoutGoldEntry(
      [
        {
          sailorId: "1",
          sailorName: "A",
          goldEntryDate: null,
          regattaDate: "2026-02-01",
          regattaName: "NR1 Gold",
          division: "Gold",
          boatClass: "Optimist",
          countsForRanking: true,
        },
      ],
      [
        {
          id: "1",
          name: "A",
          goldEntryDate: null,
          silverEntryDate: "2025-01-01",
        },
      ]
    );
    expect(issues).toHaveLength(1);
    expect(issues[0].earliestGoldRegattaDate).toBe("2026-02-01");
  });
});

describe("findOverAgeOptimistIssues", () => {
  it("flags active series sailors past optimist age", () => {
    const issues = findOverAgeOptimistIssues(
      [
        {
          id: "1",
          name: "Older",
          dob: "2008-01-01",
          silverEntryDate: "2020-01-01",
          currentFleet: "Series",
          dropDate: null,
        },
        {
          id: "2",
          name: "Young",
          dob: "2015-01-01",
          silverEntryDate: "2024-01-01",
          currentFleet: "Series",
        },
        {
          id: "3",
          name: "Dropped",
          dob: "2007-01-01",
          goldEntryDate: "2020-01-01",
          dropDate: "2023-01-01",
          currentFleet: "Series",
        },
      ],
      "2026-08-01"
    );
    expect(issues.some((i) => i.name === "Older")).toBe(true);
    expect(issues.some((i) => i.name === "Young")).toBe(false);
    expect(issues.some((i) => i.name === "Dropped")).toBe(false);
  });
});

describe("buildDataQualityReport", () => {
  it("aggregates issue types", () => {
    const report = buildDataQualityReport(
      [
        {
          id: "1",
          name: "A",
          goldEntryDate: "2026-07-01",
          silverEntryDate: "2024-01-01",
          currentFleet: "Series",
          dob: "2008-01-01",
        },
      ],
      [
        {
          sailorId: "1",
          sailorName: "A",
          goldEntryDate: "2026-07-01",
          regattaDate: "2026-02-01",
          regattaName: "Early Gold",
          division: "Gold",
          boatClass: "Optimist",
          countsForRanking: true,
        },
      ],
      "2026-08-01"
    );
    expect(report.goldBeforeEntry.length).toBe(1);
    expect(report.overAgeOptimist.length).toBe(1);
  });
});
