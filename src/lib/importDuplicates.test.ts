import { describe, expect, it } from "vitest";
import { findWithinFileDuplicates } from "./importDuplicates";

describe("import sheet duplicate detection", () => {
  it("reports similar names and sorts the strongest match first", () => {
    const matches = findWithinFileDuplicates(
      ["Alice Example", "Alicia Example", "Alice Examples"],
      0
    );

    expect(matches).toHaveLength(3);
    expect(matches[0].similarity).toBeGreaterThanOrEqual(matches[1].similarity);
    expect(matches[1].similarity).toBeGreaterThanOrEqual(matches[2].similarity);
    expect(matches.every((match) => match.kind === "within-file")).toBe(true);
  });

  it("does not flag identical names, and caps the number of pairs", () => {
    expect(findWithinFileDuplicates(["Alice Example", "Alice Example"])).toEqual([]);
    expect(
      findWithinFileDuplicates(["Alice Example", "Alicia Example", "Alice Examples"], 0, 1)
    ).toHaveLength(1);
  });

  it("only considers the first 120 rows", () => {
    expect(
      findWithinFileDuplicates([...Array(120).fill("Alice Example"), "Alicia Example"])
    ).toEqual([]);
  });
});
