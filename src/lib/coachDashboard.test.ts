import { describe, expect, it } from "vitest";
import { selectedScoreIndexes, silverProgressionSignal } from "@/lib/coachDashboard";

describe("selectedScoreIndexes", () => {
  it("highlights exactly three occurrences when Best 3 contains duplicate scores", () => {
    expect([...selectedScoreIndexes([2, 2, 4, 8, 9], [2, 2, 4])]).toEqual([0, 1, 2]);
  });
});

describe("silverProgressionSignal", () => {
  it("labels a top-15-percent sailor as a strong but unofficial progression signal", () => {
    const signal = silverProgressionSignal(10, 100);
    expect(signal.label).toContain("Strong Gold progression");
    expect(signal.detail).toContain("not official");
  });
});
