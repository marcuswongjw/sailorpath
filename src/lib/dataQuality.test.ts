import { describe, expect, it } from "vitest";
import { findGoldBeforeEntryIssues } from "./dataQuality";

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
