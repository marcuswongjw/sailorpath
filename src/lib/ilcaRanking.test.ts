import { describe, expect, it } from "vitest";
import {
  ageInIntakeYear,
  bestThreeHighPoints,
  computeIlcaRankings,
  highRankingPoints,
  ilcaSquadCutoff,
  selectIlca4NationalSquad,
} from "./ilcaRanking";

describe("highRankingPoints", () => {
  it("awards N for 1st in fleet of N", () => {
    expect(highRankingPoints(1, 30)).toBe(30);
    expect(highRankingPoints(2, 30)).toBe(29);
    expect(highRankingPoints(30, 30)).toBe(1);
  });

  it("DNS scores 0", () => {
    expect(highRankingPoints(1, 30, { isDns: true })).toBe(0);
  });
});

describe("bestThreeHighPoints", () => {
  it("sums three highest", () => {
    const r = bestThreeHighPoints([10, 30, 5, 28, 20]);
    expect(r.bestThree).toEqual([30, 28, 20]);
    expect(r.total).toBe(78);
  });
});

describe("ilcaSquadCutoff", () => {
  it("July intake as of 30 Jun same year", () => {
    expect(ilcaSquadCutoff("july", 2026)).toEqual({
      asOf: "2026-06-30",
      intakeYear: 2026,
      label: expect.stringContaining("July 2026"),
    });
  });

  it("January intake as of 20 Dec previous year", () => {
    expect(ilcaSquadCutoff("january", 2027).asOf).toBe("2026-12-20");
    expect(ilcaSquadCutoff("january", 2027).intakeYear).toBe(2027);
  });
});

describe("ageInIntakeYear", () => {
  it("uses age as of 31 Dec intake year", () => {
    // Born mid-2010 → 16 at end of 2026
    expect(ageInIntakeYear("2010-06-15", 2026)).toBe(16);
  });
});

describe("computeIlcaRankings + squad", () => {
  const regattas = [
    {
      id: "r1",
      name: "A",
      date: "2026-03-01",
      totalFleetSize: 10,
      boatClass: "ILCA 4",
      countsForRanking: true,
    },
    {
      id: "r2",
      name: "B",
      date: "2026-04-01",
      totalFleetSize: 10,
      boatClass: "ILCA 4",
      countsForRanking: true,
    },
    {
      id: "r3",
      name: "C",
      date: "2026-05-01",
      totalFleetSize: 10,
      boatClass: "ILCA 4",
      countsForRanking: true,
    },
  ];

  const sailors = [
    {
      id: "m1",
      name: "Male1",
      gender: "M",
      dob: "2012-01-01", // 14 in 2026
    },
    {
      id: "f1",
      name: "Female1",
      gender: "F",
      dob: "2012-01-01",
    },
    {
      id: "m2",
      name: "Male2",
      gender: "M",
      dob: "2010-01-01", // 16 in 2026
    },
  ];

  const results = [
    { sailorId: "m1", regattaId: "r1", rank: 1 },
    { sailorId: "m1", regattaId: "r2", rank: 1 },
    { sailorId: "m1", regattaId: "r3", rank: 1 },
    { sailorId: "f1", regattaId: "r1", rank: 2 },
    { sailorId: "f1", regattaId: "r2", rank: 2 },
    { sailorId: "f1", regattaId: "r3", rank: 2 },
    { sailorId: "m2", regattaId: "r1", rank: 3 },
    { sailorId: "m2", regattaId: "r2", rank: 3 },
    { sailorId: "m2", regattaId: "r3", rank: 3 },
  ];

  it("ranks by high points best 3 of 5", () => {
    const ranked = computeIlcaRankings(
      "ILCA 4",
      "2026-06-30",
      sailors,
      regattas,
      results,
      { intakeYear: 2026 }
    );
    expect(ranked[0]?.sailorId).toBe("m1");
    // 1st in fleet of 10 → 10 pts × 3 = 30
    expect(ranked[0]?.totalPoints).toBe(30);
    expect(ranked[1]?.totalPoints).toBe(27); // 9×3
  });

  it("selects squad with gender and age buckets", () => {
    const ranked = computeIlcaRankings(
      "ILCA 4",
      "2026-06-30",
      sailors,
      regattas,
      results,
      { intakeYear: 2026 }
    );
    const squad = selectIlca4NationalSquad(ranked);
    expect(squad.some((s) => s.sailorId === "m1")).toBe(true);
    expect(squad.some((s) => s.sailorId === "f1")).toBe(true);
    expect(squad.length).toBeLessThanOrEqual(16);
  });
});
