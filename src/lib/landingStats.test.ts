import { describe, expect, it } from "vitest";
import { formatAthleteCount, formatRegattaCount } from "./landingStats";

describe("landing totals", () => {
  it("floors sailor counts of 100 or more down to the nearest hundred", () => {
    expect(formatAthleteCount(890)).toBe("800+");
    expect(formatAthleteCount(832)).toBe("800+");
    expect(formatAthleteCount(899)).toBe("800+");
    expect(formatAthleteCount(150)).toBe("100+");
    expect(formatAthleteCount(900)).toBe("900+");
  });

  it("floors sailor counts under 100 down to the nearest ten", () => {
    expect(formatAthleteCount(42)).toBe("40+");
  });

  it("keeps the published fallback when the count is missing", () => {
    expect(formatAthleteCount(0)).toBe("800+");
    expect(formatAthleteCount(Number.NaN)).toBe("800+");
    expect(formatRegattaCount(Number.NaN)).toBe("130");
  });

  it("prints the regatta total as a whole number", () => {
    expect(formatRegattaCount(130)).toBe("130");
  });
});
