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
});
