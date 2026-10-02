import { describe, expect, it } from "vitest";
import { latestRankingRegattaIdForFleet } from "@/lib/queries";
import type { RegattaRecord } from "@/lib/ranking";

const event = (id: string, date: string, division: string, countsForRanking = true): RegattaRecord => ({
  id, name: id, slug: id, date, division, countsForRanking,
  totalFleetSize: 50, raceCount: 4, geography: "SG", boatClass: "Optimist",
});

describe("latestRankingRegattaIdForFleet", () => {
  it("selects the latest eligible event for the requested fleet and period", () => {
    const rows = [
      event("gold-jul", "2026-07-04", "Gold"),
      event("silver-jul", "2026-07-04", "Silver"),
      event("silver-aug-practice", "2026-08-20", "Silver", false),
      event("silver-aug", "2026-08-01", "Silver"),
    ];
    expect(latestRankingRegattaIdForFleet(rows, "Silver", { year: 2026, half: "Jul-Dec" })).toBe("silver-aug");
    expect(latestRankingRegattaIdForFleet(rows, "Gold", { year: 2026, half: "Jul-Dec" })).toBe("gold-jul");
  });

  it("treats division Both as the latest event for both fleet boards", () => {
    const rows = [
      event("gold-jul", "2026-07-04", "Gold"),
      event("silver-aug", "2026-08-01", "Silver"),
      event("both-sep", "2026-09-12", "Both"),
    ];
    const period = { year: 2026, half: "Jul-Dec" as const };
    expect(latestRankingRegattaIdForFleet(rows, "Gold", period)).toBe("both-sep");
    expect(latestRankingRegattaIdForFleet(rows, "Silver", period)).toBe("both-sep");
  });

  it("keeps a later single-fleet event ahead of an earlier Both sheet", () => {
    const rows = [
      event("both-jul", "2026-07-01", "Both"),
      event("gold-aug", "2026-08-01", "Gold"),
    ];
    const period = { year: 2026, half: "Jul-Dec" as const };
    expect(latestRankingRegattaIdForFleet(rows, "Gold", period)).toBe("gold-aug");
    expect(latestRankingRegattaIdForFleet(rows, "Silver", period)).toBe("both-jul");
  });
});
