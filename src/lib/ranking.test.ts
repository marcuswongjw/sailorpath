import { describe, expect, it } from "vitest";
import {
  bestThreeOf,
  compareRankedSailors,
  natSquadFieldForPeriod,
  periodBounds,
  previousPeriod,
  reRankWithExcluded,
  resolveSailorFleet,
  squadStatusForPeriod,
  type RankedSailor,
  type SailorRecord,
} from "./ranking";

describe("bestThreeOf", () => {
  it("sums the three lowest scores", () => {
    const r = bestThreeOf([12, 3, 8, 1, 20]);
    expect(r.bestThreeScores).toEqual([1, 3, 8]);
    expect(r.overallScore).toBe(12);
  });

  it("pads with 9999 when fewer than 3 scores", () => {
    const r = bestThreeOf([5, 2]);
    expect(r.bestThreeScores).toEqual([2, 5, 9999]);
    expect(r.overallScore).toBe(10006);
  });

  it("ignores non-finite values", () => {
    const r = bestThreeOf([4, NaN, 1, Infinity as unknown as number]);
    expect(r.bestThreeScores[0]).toBe(1);
    expect(r.bestThreeScores[1]).toBe(4);
  });
});

describe("compareRankedSailors", () => {
  const slot = (score: number, id = "r") => ({
    regattaId: id,
    regattaName: id,
    score,
    isDNS: false,
  });

  it("prefers lower overallScore", () => {
    const a = { overallScore: 10, name: "B", regattaScores: [slot(1), slot(2), slot(7)] };
    const b = { overallScore: 12, name: "A", regattaScores: [slot(2), slot(2), slot(8)] };
    expect(compareRankedSailors(a, b)).toBeLessThan(0);
  });

  it("breaks Best3 ties by sorted regatta ranks", () => {
    // Both Best3 = 9: A has 1,3,5 vs B has 2,2,5
    const a = {
      overallScore: 9,
      name: "Zed",
      regattaScores: [slot(1), slot(3), slot(5), slot(7), slot(18)],
    };
    const b = {
      overallScore: 9,
      name: "Amy",
      regattaScores: [slot(2), slot(2), slot(5), slot(6), slot(9)],
    };
    expect(compareRankedSailors(a, b)).toBeLessThan(0);
  });

  it("falls back to name when ranks fully tie", () => {
    const a = {
      overallScore: 6,
      name: "Bob",
      regattaScores: [slot(1), slot(2), slot(3)],
    };
    const b = {
      overallScore: 6,
      name: "Ann",
      regattaScores: [slot(1), slot(2), slot(3)],
    };
    expect(compareRankedSailors(a, b)).toBeGreaterThan(0);
  });
});

describe("period helpers", () => {
  it("periodBounds for both halves", () => {
    expect(periodBounds({ year: 2026, half: "Jan-Jun" })).toEqual({
      start: "2026-01-01",
      end: "2026-06-30",
    });
    expect(periodBounds({ year: 2026, half: "Jul-Dec" })).toEqual({
      start: "2026-07-01",
      end: "2026-12-31",
    });
  });

  it("previousPeriod wraps across years", () => {
    expect(previousPeriod({ year: 2026, half: "Jul-Dec" })).toEqual({
      year: 2026,
      half: "Jan-Jun",
    });
    expect(previousPeriod({ year: 2026, half: "Jan-Jun" })).toEqual({
      year: 2025,
      half: "Jul-Dec",
    });
  });

  it("natSquadFieldForPeriod maps known halves", () => {
    expect(natSquadFieldForPeriod({ year: 2026, half: "Jul-Dec" })).toBe(
      "natSquadStatusJul26"
    );
    expect(natSquadFieldForPeriod({ year: 2025, half: "Jan-Jun" })).toBe(
      "natSquadStatusJan25"
    );
    expect(natSquadFieldForPeriod({ year: 2024, half: "Jul-Dec" })).toBeNull();
  });

  it("squadStatusForPeriod prefers period field then nationalSquadStatus", () => {
    const sailor = {
      natSquadStatusJul26: "Nat A",
      nationalSquadStatus: "DS",
    } as SailorRecord;
    expect(
      squadStatusForPeriod(sailor, { year: 2026, half: "Jul-Dec" })
    ).toBe("Nat A");
    expect(
      squadStatusForPeriod(
        { nationalSquadStatus: "Nat B" } as SailorRecord,
        { year: 2024, half: "Jan-Jun" }
      )
    ).toBe("Nat B");
  });
});

describe("resolveSailorFleet", () => {
  const jan26 = { year: 2026, half: "Jan-Jun" as const };
  const jul26 = { year: 2026, half: "Jul-Dec" as const };
  const base = (over: Partial<SailorRecord> = {}): SailorRecord =>
    ({
      id: "1",
      name: "Test",
      handle: "test",
      sailNumber: "SGP 1",
      club: "C",
      goldEntryDate: null,
      silverEntryDate: null,
      dropDate: null,
      currentFleet: "Series",
      ...over,
    }) as SailorRecord;

  it("excludes guests", () => {
    expect(
      resolveSailorFleet(base({ currentFleet: "Guest" }), jan26)
    ).toBeNull();
  });

  it("Series without gold entry is Silver", () => {
    const r = resolveSailorFleet(
      base({ silverEntryDate: "2025-01-01", goldEntryDate: null }),
      jan26
    );
    expect(r).toEqual({ active: true, fleet: "Silver" });
  });

  it("Gold from gold entry date until drop", () => {
    const r = resolveSailorFleet(
      base({
        silverEntryDate: "2024-01-01",
        goldEntryDate: "2025-06-30",
      }),
      jan26
    );
    expect(r).toEqual({ active: true, fleet: "Gold" });
  });

  it("gold entry after period end → Silver while still In SG Fleet", () => {
    const r = resolveSailorFleet(
      base({
        currentFleet: "Series",
        silverEntryDate: "2025-01-01",
        goldEntryDate: "2026-07-01",
      }),
      jan26
    );
    expect(r).toEqual({ active: true, fleet: "Silver" });
  });

  it("does not use currentFleet Gold/Silver override", () => {
    // Legacy Gold tag without gold entry → still Series membership, Silver ranking
    const r = resolveSailorFleet(
      base({
        currentFleet: "Gold",
        silverEntryDate: "2025-01-01",
        goldEntryDate: null,
      }),
      jan26
    );
    expect(r).toEqual({ active: true, fleet: "Silver" });
  });

  it("drop during half excludes from that half", () => {
    expect(
      resolveSailorFleet(
        base({
          goldEntryDate: "2022-01-01",
          dropDate: "2026-06-30",
        }),
        jan26
      )
    ).toBeNull();
    // After drop, still out of next half if drop before start
    expect(
      resolveSailorFleet(
        base({
          goldEntryDate: "2022-01-01",
          dropDate: "2026-06-30",
        }),
        jul26
      )
    ).toBeNull();
  });
});

describe("reRankWithExcluded", () => {
  const base = (name: string, scores: number[]): RankedSailor => ({
    id: name,
    name,
    handle: name,
    sailNumber: "SGP 1",
    club: "C",
    goldEntryDate: "2024-01-01",
    silverEntryDate: "2023-01-01",
    dropDate: null,
    fleet: "Gold",
    regattaScores: scores.map((score, i) => ({
      regattaId: `r${i}`,
      regattaName: `R${i}`,
      score,
      isDNS: false,
    })),
    bestThreeScores: bestThreeOf(scores).bestThreeScores,
    overallScore: bestThreeOf(scores).overallScore,
  });

  it("recomputes overall when a regatta is excluded", () => {
    const ranked = [
      base("Alice", [1, 2, 10, 10, 10]),
      base("Bob", [3, 3, 3, 3, 3]),
    ];
    // Alice Best3 = 1+2+10=13; Bob = 9. Exclude r2 (score 10 for Alice) leaves Alice 1+2+10 still if only one 10 removed...
    // regattaIds r0=1, r1=2, r2=10, r3=10, r4=10. Exclude r2,r3,r4 → Alice 1+2+9999
    const next = reRankWithExcluded(
      ranked,
      new Set(["r2", "r3", "r4"])
    );
    const alice = next.find((s) => s.name === "Alice")!;
    expect(alice.overallScore).toBe(1 + 2 + 9999);
    // Full regattaScores still present for display
    expect(alice.regattaScores).toHaveLength(5);
  });
});
