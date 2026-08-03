import { describe, expect, it } from "vitest";
import {
  optimistSquadCutoff,
  selectOptimistNatSquadPreview,
  ageInIntakeYear,
} from "./optimistSquadPreview";
import type { RankedSailor } from "./ranking";

function sailor(
  id: string,
  name: string,
  gender: string,
  dob: string,
  overallScore: number
): RankedSailor {
  return {
    id,
    name,
    handle: id,
    sailNumber: "SGP 1",
    club: "CSC",
    goldEntryDate: "2024-01-01",
    silverEntryDate: null,
    dropDate: null,
    fleet: "Gold",
    regattaScores: [],
    bestThreeScores: [1, 2, 3],
    overallScore,
    gender,
    dob,
    nationality: "SGP",
    periodSquadStatus: null,
  };
}

describe("optimistSquadCutoff", () => {
  it("July intake as of 30 Jun same year", () => {
    const c = optimistSquadCutoff("july", 2026);
    expect(c.asOf).toBe("2026-06-30");
    expect(c.period).toEqual({ year: 2026, half: "Jan-Jun" });
  });

  it("January intake as of 20 Dec previous year", () => {
    const c = optimistSquadCutoff("january", 2027);
    expect(c.asOf).toBe("2026-12-20");
    expect(c.period).toEqual({ year: 2026, half: "Jul-Dec" });
  });
});

describe("ageInIntakeYear", () => {
  it("age as of 31 Dec intake year", () => {
    expect(ageInIntakeYear("2012-06-01", 2026)).toBe(14);
    expect(ageInIntakeYear("2013-01-01", 2026)).toBe(13);
  });
});

describe("selectOptimistNatSquadPreview", () => {
  it("selects top 8 M and 8 F for Nat A", () => {
    const ranked: RankedSailor[] = [];
    for (let i = 0; i < 20; i++) {
      ranked.push(
        sailor(`m${i}`, `Male ${i}`, "M", "2012-01-01", i + 1)
      );
    }
    for (let i = 0; i < 20; i++) {
      ranked.push(
        sailor(`f${i}`, `Female ${i}`, "F", "2012-01-01", 50 + i)
      );
    }
    // Interleave by overall score order for ranking positions
    ranked.sort((a, b) => a.overallScore - b.overallScore);

    const picks = selectOptimistNatSquadPreview(ranked, 2026);
    const a = picks.filter((p) => p.tier === "Nat A");
    expect(a.filter((p) => p.gender === "M")).toHaveLength(8);
    expect(a.filter((p) => p.gender === "F")).toHaveLength(8);
    expect(a).toHaveLength(16);
  });

  it("excludes A sailors from B and fills age buckets", () => {
    const ranked: RankedSailor[] = [];
    // Top 8 M age 14 (for A)
    for (let i = 0; i < 8; i++) {
      ranked.push(sailor(`am${i}`, `A Male ${i}`, "M", "2012-01-01", i));
    }
    // Top 8 F age 14 (for A)
    for (let i = 0; i < 8; i++) {
      ranked.push(sailor(`af${i}`, `A Fem ${i}`, "F", "2012-01-01", 10 + i));
    }
    // Age 13 candidates for B
    ranked.push(sailor("b13m1", "B13 M1", "M", "2013-01-01", 30));
    ranked.push(sailor("b13m2", "B13 M2", "M", "2013-01-01", 31));
    ranked.push(sailor("b13f1", "B13 F1", "F", "2013-01-01", 32));
    ranked.push(sailor("b13f2", "B13 F2", "F", "2013-01-01", 33));
    // Age 12
    for (let i = 0; i < 3; i++) {
      ranked.push(sailor(`b12m${i}`, `B12 M${i}`, "M", "2014-01-01", 40 + i));
      ranked.push(sailor(`b12f${i}`, `B12 F${i}`, "F", "2014-01-01", 50 + i));
    }
    // Age ≤11
    for (let i = 0; i < 3; i++) {
      ranked.push(sailor(`b11m${i}`, `B11 M${i}`, "M", "2015-01-01", 60 + i));
      ranked.push(sailor(`b11f${i}`, `B11 F${i}`, "F", "2015-01-01", 70 + i));
    }
    ranked.sort((a, b) => a.overallScore - b.overallScore);

    const picks = selectOptimistNatSquadPreview(ranked, 2026);
    const aIds = new Set(
      picks.filter((p) => p.tier === "Nat A").map((p) => p.sailorId)
    );
    const b = picks.filter((p) => p.tier === "Nat B");
    expect(b.every((p) => !aIds.has(p.sailorId))).toBe(true);
    expect(b.filter((p) => p.reason === "age13")).toHaveLength(4);
    expect(b.filter((p) => p.reason === "age12")).toHaveLength(6);
    expect(b.filter((p) => p.reason === "age11_or_under")).toHaveLength(6);
    expect(b).toHaveLength(16);
  });

  it("excludes sailors older than 15 in intake year", () => {
    const ranked = [
      sailor("old", "Old", "M", "2008-01-01", 1), // 18 in 2026
      sailor("ok", "Ok", "M", "2012-01-01", 2),
    ];
    const picks = selectOptimistNatSquadPreview(ranked, 2026);
    expect(picks.some((p) => p.sailorId === "old")).toBe(false);
    expect(picks.some((p) => p.sailorId === "ok")).toBe(true);
  });
});
