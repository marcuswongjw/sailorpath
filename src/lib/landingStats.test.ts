import { describe, expect, it } from "vitest";
import { formatAthleteCount, formatRegattaCount } from "./landingStats";

describe("landing totals", () => {
  it("rounds the live sailor count down to the nearest ten", () => {
    expect(formatAthleteCount(832)).toBe("830+");
    expect(formatAthleteCount(150)).toBe("150+");
  });

  it("keeps the published fallback when the count is missing", () => {
    expect(formatAthleteCount(0)).toBe("830+");
    expect(formatRegattaCount(Number.NaN)).toBe("130");
  });

  it("prints the regatta total as a whole number", () => {
    expect(formatRegattaCount(130)).toBe("130");
  });
});
