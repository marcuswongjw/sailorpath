import { describe, expect, it } from "vitest";
import {
  buildSailorGoldSeries,
  filterGoldSailors,
  isEligibleGoldRegatta,
} from "./goldPerformanceAnalysis";

const sailors = [
  {
    id: "a",
    name: "Alice",
    gender: "F",
    goldEntryDate: "2025-01-15",
    dob: "2012-06-01",
  },
  {
    id: "b",
    name: "Bob",
    gender: "M",
    goldEntryDate: "2024-07-01",
  },
  {
    id: "c",
    name: "Cara",
    gender: "Female",
    goldEntryDate: null,
  },
];

const regattas = [
  {
    id: "r0",
    name: "Before",
    date: "2024-12-01",
    boatClass: "Optimist",
    countsForRanking: true,
  },
  {
    id: "r1",
    name: "Post1",
    date: "2025-03-01",
    boatClass: "Optimist",
    countsForRanking: true,
    totalFleetSize: 100,
  },
  {
    id: "r2",
    name: "Post2",
    date: "2025-05-01",
    boatClass: "Optimist",
    countsForRanking: true,
  },
  {
    id: "r3",
    name: "Post3",
    date: "2025-07-01",
    boatClass: "Optimist",
    countsForRanking: true,
  },
  {
    id: "r4",
    name: "NonRank",
    date: "2025-08-01",
    boatClass: "Optimist",
    countsForRanking: false,
  },
];

const results = [
  { sailorId: "a", regattaId: "r0", rank: 50 },
  { sailorId: "a", regattaId: "r1", rank: 40 },
  { sailorId: "a", regattaId: "r2", rank: 30 },
  { sailorId: "a", regattaId: "r3", rank: 20 },
  { sailorId: "a", regattaId: "r4", rank: 5 },
];

describe("goldPerformanceAnalysis", () => {
  it("filters gold sailors by gender", () => {
    const f = filterGoldSailors(sailors, { gender: "F" });
    expect(f.map((s) => s.id)).toEqual(["a"]);
    expect(filterGoldSailors(sailors).map((s) => s.id).sort()).toEqual([
      "a",
      "b",
    ]);
  });

  it("builds post-promo series aligned by sequence", () => {
    const s = buildSailorGoldSeries(sailors[0]!, regattas, results, {
      window: 3,
    });
    expect(s).not.toBeNull();
    expect(s!.postPromo.map((p) => p.seq)).toEqual([1, 2, 3]);
    expect(s!.postPromo.map((p) => p.rank)).toEqual([40, 30, 20]);
    expect(s!.immediateAvgRank).toBe(30); // (40+30+20)/3
    expect(s!.currentAvgRank).toBe(30);
    expect(s!.bestPostRank).toBe(20);
    // non-ranking excluded
    expect(s!.eventCount).toBe(3);
  });

  it("excludes non-ranking and pre-gold events", () => {
    expect(isEligibleGoldRegatta(regattas[4]!)).toBe(false);
    expect(isEligibleGoldRegatta(regattas[1]!)).toBe(true);
  });
});
