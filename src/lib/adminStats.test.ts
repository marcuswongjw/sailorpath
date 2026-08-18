import { describe, expect, it } from "vitest";
import { formatRosterClaimedPct } from "./adminStats";

describe("formatRosterClaimedPct", () => {
  it("returns null when series denominator is zero", () => {
    expect(formatRosterClaimedPct(5, 0)).toBeNull();
  });

  it("rounds to one decimal percent", () => {
    expect(formatRosterClaimedPct(1, 3)).toBe(33.3);
    expect(formatRosterClaimedPct(50, 100)).toBe(50);
  });
});
