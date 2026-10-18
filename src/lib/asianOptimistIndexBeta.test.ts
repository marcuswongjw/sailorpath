import { describe, expect, it } from "vitest";
import {
  ASIAN_INDEX_GRADE_75_CRITERIA,
  ASIAN_INDEX_MNA_REGIONS,
  ASIAN_INDEX_PROPOSED_REGISTER,
  asianIndexPoints,
} from "./asianOptimistIndexBeta";

describe("Asian Optimist Index (Beta) scoring", () => {
  it("gives the winner the full grade and last place E/N", () => {
    expect(asianIndexPoints(150, 100, 1)).toBe(150);
    expect(asianIndexPoints(75, 100, 100)).toBeCloseTo(0.75, 10);
    expect(asianIndexPoints(40, 50, 50)).toBeCloseTo(0.8, 10);
  });

  it("averages tied places", () => {
    expect(asianIndexPoints(75, 40, 10.5)).toBeCloseTo((75 * 30.5) / 40, 10);
  });

  it("rejects impossible places", () => {
    expect(() => asianIndexPoints(75, 40, 0)).toThrow();
    expect(() => asianIndexPoints(75, 40, 41)).toThrow();
    expect(() => asianIndexPoints(75, 0, 1)).toThrow();
  });

  it("reproduces the published worked examples", () => {
    const example1 = [
      asianIndexPoints(150, 284, 40),
      asianIndexPoints(150, 170, 25),
      asianIndexPoints(75, 50, 5),
      asianIndexPoints(75, 65, 12),
      asianIndexPoints(40, 106, 3),
    ];
    expect(example1.reduce((a, b) => a + b, 0).toFixed(2)).toBe("428.78");
    expect(asianIndexPoints(75, 59, 8).toFixed(2)).toBe("66.10");
    expect(asianIndexPoints(40, 83, 6).toFixed(2)).toBe("37.59");
    expect(asianIndexPoints(40, 70, 20).toFixed(2)).toBe("29.14");

    const example2 = [
      asianIndexPoints(75, 59, 4),
      asianIndexPoints(75, 65, 9),
      asianIndexPoints(75, 106, 15),
      asianIndexPoints(75, 77, 30),
      asianIndexPoints(40, 83, 2),
    ];
    expect(example2.reduce((a, b) => a + b, 0).toFixed(2)).toBe("288.32");
    expect(asianIndexPoints(75, 45, 20).toFixed(2)).toBe("43.33");
    expect(asianIndexPoints(40, 70, 10).toFixed(2)).toBe("34.86");
  });

  it("reproduces the grade comparison table for a 100-starter fleet", () => {
    const rows: [number, string, string, string][] = [
      [1, "150.00", "75.00", "40.00"],
      [10, "136.50", "68.25", "36.40"],
      [25, "114.00", "57.00", "30.40"],
      [50, "76.50", "38.25", "20.40"],
      [75, "39.00", "19.50", "10.40"],
      [100, "1.50", "0.75", "0.40"],
    ];
    for (const [place, g150, g75, g40] of rows) {
      expect(asianIndexPoints(150, 100, place).toFixed(2)).toBe(g150);
      expect(asianIndexPoints(75, 100, place).toFixed(2)).toBe(g75);
      expect(asianIndexPoints(40, 100, place).toFixed(2)).toBe(g40);
    }
  });
});

describe("Asian Optimist Index (Beta) reference data", () => {
  it("lists 35 unique eligible MNA codes", () => {
    const codes = ASIAN_INDEX_MNA_REGIONS.flatMap((region) => region.codes);
    expect(codes).toHaveLength(35);
    expect(new Set(codes).size).toBe(35);
  });

  it("never marks a Grade 75 entry as meeting criteria below the published thresholds", () => {
    for (const entry of ASIAN_INDEX_PROPOSED_REGISTER.filter(
      (item) => item.grade === 75 && item.check === "meets"
    )) {
      expect(entry.starters ?? 0).toBeGreaterThanOrEqual(ASIAN_INDEX_GRADE_75_CRITERIA.registeredSailors);
      expect(entry.verifiedMnas ?? 0).toBeGreaterThanOrEqual(ASIAN_INDEX_GRADE_75_CRITERIA.verifiedMnas);
    }
  });

  it("has unique register ids", () => {
    const ids = ASIAN_INDEX_PROPOSED_REGISTER.map((entry) => entry.id);
    expect(new Set(ids).size).toBe(ids.length);
  });
});
