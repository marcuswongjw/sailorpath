import { describe, expect, it } from "vitest";
import {
  buildImportMessage,
  cleanImportRows,
  findWithinFileDuplicates,
  isNetworkFetchError,
} from "./importRegatta";

describe("cleanImportRows", () => {
  it("drops empty names and normalizes fields", () => {
    const rows = cleanImportRows([
      { name: "  Alice  ", rank: 1, nett: 10.5, club: "CSC" },
      { name: "   ", rank: 2, nett: null },
      {
        name: "Bob",
        rank: null,
        nett: null,
        birthYear: 2012,
        nationality: "SGP",
      },
    ]);
    expect(rows).toHaveLength(2);
    expect(rows[0].name).toBe("Alice");
    expect(rows[0].rank).toBe(1);
    expect(rows[0].nett).toBe(10.5);
    expect(rows[1].dobIsYearOnly).toBe(true);
  });
});

describe("findWithinFileDuplicates", () => {
  it("flags similar names and respects maxPairs", () => {
    const dups = findWithinFileDuplicates(
      ["Bryan Lee", "Lee Bryan", "Completely Different", "Bryan Lee"],
      { minSimilarity: 0.6, maxPairs: 5 }
    );
    expect(dups.length).toBeGreaterThan(0);
    expect(dups[0].kind).toBe("within-file");
    expect(dups.every((d) => d.similarity >= 0.6)).toBe(true);
  });
});

describe("buildImportMessage", () => {
  it("reports success summary", () => {
    const msg = buildImportMessage({
      regattaName: "Nationals",
      matched: 40,
      inputRows: 42,
      created: 2,
      updatedProfiles: 5,
      silverUpdated: 1,
      rowErrors: 0,
      unmatchedCount: 0,
      duplicateCount: 3,
      needsNettMigration: false,
    });
    expect(msg).toContain("Nationals");
    expect(msg).toContain("40/42");
    expect(msg).toContain("3 possible duplicate");
  });

  it("reports total failure with nett hint", () => {
    const msg = buildImportMessage({
      regattaName: "X",
      matched: 0,
      inputRows: 10,
      created: 0,
      updatedProfiles: 0,
      silverUpdated: 0,
      rowErrors: 10,
      unmatchedCount: 0,
      duplicateCount: 0,
      needsNettMigration: true,
    });
    expect(msg).toMatch(/failed for all rows/i);
    expect(msg).toMatch(/INTEGER|migration/i);
  });
});

describe("isNetworkFetchError", () => {
  it("detects Failed to fetch", () => {
    expect(isNetworkFetchError("Failed to fetch")).toBe(true);
    expect(isNetworkFetchError("Import failed")).toBe(false);
  });
});
