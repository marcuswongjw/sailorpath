import { describe, expect, it } from "vitest";
import {
  buildSailorGoldSeries,
  filterGoldSailors,
  firstPostPromoPeriod,
  nextPeriod,
} from "./goldPerformanceAnalysis";

const sailors = [
  {
    id: "a",
    name: "Alice",
    gender: "F",
    goldEntryDate: "2025-01-01",
    silverEntryDate: "2024-01-01",
    currentFleet: "Series",
    dob: "2012-06-01",
    sailNumber: "SGP 1",
  },
  {
    id: "b",
    name: "Bob",
    gender: "M",
    goldEntryDate: "2025-01-01",
    silverEntryDate: "2024-01-01",
    currentFleet: "Series",
  },
  {
    id: "c",
    name: "Cara",
    gender: "Female",
    goldEntryDate: null as string | null,
    currentFleet: "Series",
  },
];

/** Three ranking gold events in H1 2025, two in H2 2025 */
const regattas = [
  {
    id: "r1",
    name: "NR1",
    date: "2025-02-01",
    division: "Gold",
    boatClass: "Optimist",
    countsForRanking: true,
    totalFleetSize: 50,
  },
  {
    id: "r2",
    name: "NR2",
    date: "2025-04-01",
    division: "Gold",
    boatClass: "Optimist",
    countsForRanking: true,
    totalFleetSize: 50,
  },
  {
    id: "r3",
    name: "NR3",
    date: "2025-06-01",
    division: "Gold",
    boatClass: "Optimist",
    countsForRanking: true,
    totalFleetSize: 50,
  },
  {
    id: "r4",
    name: "NR4",
    date: "2025-08-01",
    division: "Gold",
    boatClass: "Optimist",
    countsForRanking: true,
    totalFleetSize: 50,
  },
  {
    id: "r5",
    name: "NR5",
    date: "2025-10-01",
    division: "Gold",
    boatClass: "Optimist",
    countsForRanking: true,
    totalFleetSize: 50,
  },
  {
    id: "rn",
    name: "NonRank",
    date: "2025-05-01",
    division: "Gold",
    boatClass: "Optimist",
    countsForRanking: false,
    totalFleetSize: 20,
  },
];

const results = [
  { sailorId: "a", regattaId: "r1", rank: 10 },
  { sailorId: "a", regattaId: "r2", rank: 8 },
  { sailorId: "a", regattaId: "r3", rank: 6 },
  { sailorId: "a", regattaId: "r4", rank: 5 },
  { sailorId: "a", regattaId: "r5", rank: 4 },
  { sailorId: "a", regattaId: "rn", rank: 1 },
  { sailorId: "b", regattaId: "r1", rank: 20 },
  { sailorId: "b", regattaId: "r2", rank: 18 },
  { sailorId: "b", regattaId: "r3", rank: 15 },
];

describe("goldPerformanceAnalysis (series halves)", () => {
  it("maps gold entry to first post-promo half", () => {
    expect(firstPostPromoPeriod("2025-01-01")).toEqual({
      year: 2025,
      half: "Jan-Jun",
    });
    expect(nextPeriod({ year: 2025, half: "Jan-Jun" })).toEqual({
      year: 2025,
      half: "Jul-Dec",
    });
  });

  it("filters gold sailors by gender", () => {
    const f = filterGoldSailors(sailors, { gender: "F" });
    expect(f.map((s) => s.id)).toEqual(["a"]);
  });

  it("computes half-year best 3 of 5 and ignores non-ranking", () => {
    const s = buildSailorGoldSeries(sailors[0]!, sailors, regattas, results);
    expect(s).not.toBeNull();
    expect(s!.half1?.periodLabel).toContain("2025");
    // H1 ranks 10,8,6 → best3 = 24
    expect(s!.half1?.best3of5).toBe(24);
    // non-ranking event not counted
    expect(s!.half1?.eventsSailed).toBeGreaterThanOrEqual(3);
    // H2 ranks 5,4 + DNS pad → best3 includes 4,5,...
    expect(s!.half2?.best3of5).not.toBeNull();
    expect(s!.immediateBest3Avg).not.toBeNull();
  });
});
