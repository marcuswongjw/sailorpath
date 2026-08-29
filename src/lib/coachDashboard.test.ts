import { describe, expect, it } from "vitest";
import { selectedScoreIndexes } from "@/lib/coachDashboard";

describe("selectedScoreIndexes", () => {
  it("highlights exactly three occurrences when Best 3 contains duplicate scores", () => {
    expect([...selectedScoreIndexes([2, 2, 4, 8, 9], [2, 2, 4])]).toEqual([0, 1, 2]);
  });
});
