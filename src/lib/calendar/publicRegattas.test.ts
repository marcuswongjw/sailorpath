import { describe, expect, it } from "vitest";
import { matchesRegattaClass, nationalRankingLabel } from "./publicRegattas";
import type { RegattaRecord } from "@/lib/ranking";
const sheet: RegattaRecord = { id: "1", slug: "test", name: "Test", date: "2026-01-01", totalFleetSize: 20, geography: "SG", boatClass: "Optimist", raceCount: 3, countsForRanking: true };
describe("public class results", () => {
  it("keeps unrelated classes out of Optimist", () => {
    for (const cls of ["WingFoil", "Techno 293", "ILCA 7", "29er"]) expect(matchesRegattaClass(cls, "optimist")).toBe(false);
    expect(matchesRegattaClass("Optimist Silver", "optimist")).toBe(true);
    expect(matchesRegattaClass("ILCA 6", "ilca")).toBe(true);
  });
  it("labels Singapore eligible classes only", () => {
    expect(nationalRankingLabel(sheet)).toBe("Counts for Singapore national ranking");
    for (const raceCount of [0, 1, 2]) expect(nationalRankingLabel({ ...sheet, raceCount })).toBe("Does not count for Singapore national ranking");
    expect(nationalRankingLabel({ ...sheet, raceCount: null })).toContain("pending");
    expect(nationalRankingLabel({ ...sheet, geography: "TH" })).toBeNull();
    expect(nationalRankingLabel({ ...sheet, boatClass: "ILCA 7" })).toBeNull();
    expect(nationalRankingLabel({ ...sheet, countsForRanking: false })).toContain("Does not count");
  });
});
