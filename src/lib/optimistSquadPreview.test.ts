import { describe, expect, it } from "vitest";
import {
  rankingPeriodForJanuaryIntake,
  selectOptimistNatSquadPreview,
} from "./optimistSquadPreview";
import type { RankedSailor } from "./ranking";

function fakeRanked(n: number): RankedSailor[] {
  return Array.from({ length: n }, (_, i) => ({
    id: `s${i + 1}`,
    name: `Sailor ${i + 1}`,
    handle: `h${i + 1}`,
    sailNumber: `SGP ${i + 1}`,
    club: "CSC",
    goldEntryDate: "2024-01-01",
    silverEntryDate: null,
    dropDate: null,
    fleet: "Gold" as const,
    regattaScores: [],
    bestThreeScores: [1, 2, 3],
    overallScore: i + 1,
    gender: i % 2 === 0 ? "M" : "F",
    nationality: "SGP",
    periodSquadStatus: null,
  }));
}

describe("rankingPeriodForJanuaryIntake", () => {
  it("uses previous Jul–Dec half", () => {
    expect(rankingPeriodForJanuaryIntake(2027)).toEqual({
      year: 2026,
      half: "Jul-Dec",
      label: expect.stringContaining("2026"),
    });
  });
});

describe("selectOptimistNatSquadPreview", () => {
  it("assigns Nat A 1–15 and Nat B 16–30", () => {
    const picks = selectOptimistNatSquadPreview(fakeRanked(40));
    expect(picks.filter((p) => p.tier === "Nat A")).toHaveLength(15);
    expect(picks.filter((p) => p.tier === "Nat B")).toHaveLength(15);
    expect(picks[0]?.tier).toBe("Nat A");
    expect(picks[0]?.rankingPosition).toBe(1);
    expect(picks[15]?.tier).toBe("Nat B");
    expect(picks[29]?.rankingPosition).toBe(30);
  });
});
