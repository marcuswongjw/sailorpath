import { describe, expect, it } from "vitest";
import { bestThreeSelectedIndexes } from "./bestThreeSelection";

describe("bestThreeSelectedIndexes", () => {
  it("selects the three lowest Optimist scores", () => {
    expect([...bestThreeSelectedIndexes([8, 2, 5, 1, 9])]).toEqual([3, 1, 2]);
  });

  it("selects the three highest ILCA points", () => {
    expect([
      ...bestThreeSelectedIndexes([8, 2, 5, 10, 9], {
        higherIsBetter: true,
      }),
    ]).toEqual([3, 4, 0]);
  });

  it("ignores excluded and non-finite scores", () => {
    expect([
      ...bestThreeSelectedIndexes([1, 2, Number.NaN, 3, 4], {
        excludedIndexes: new Set([0]),
      }),
    ]).toEqual([1, 3, 4]);
  });

  it("uses event order to mark exactly three equal scores", () => {
    expect([...bestThreeSelectedIndexes([4, 4, 4, 4, 4])]).toEqual([0, 1, 2]);
  });
});
