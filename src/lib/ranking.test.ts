import { describe, expect, it } from "vitest";
import {
  MIN_RACES_FOR_RANKING,
  regattaCountsForRanking,
  bestThreeOf,
  calculateRankings,
  optimistSheetStatsByRegattaId,
  optimistRegisteredNoShowScore,
  optimistUnregisteredScore,
  compareRankedSailors,
  getPercentileBadge,
  natSquadFieldForPeriod,
  periodBounds,
  stripProjectedNextSquadStatus,
  previousPeriod,
  rankingRegattasInPeriod,
  reRankWithExcluded,
  regattaMatchesSeriesClass,
  resolveSailorFleet,
  squadStatusForPeriod,
  type RankedSailor,
  type RegattaRecord,
  type RegattaResultRecord,
  type SailorRecord,
} from "./ranking";

describe("getPercentileBadge", () => {
  it("uses 20% bands", () => {
    expect(getPercentileBadge(1, 100).label).toBe("Top 20%");
    expect(getPercentileBadge(20, 100).label).toBe("Top 20%");
    expect(getPercentileBadge(21, 100).label).toBe("Top 40%");
    expect(getPercentileBadge(50, 100).label).toBe("Top 60%");
    expect(getPercentileBadge(80, 100).label).toBe("Top 80%");
    expect(getPercentileBadge(81, 100).label).toBe("Bottom 20%");
  });
});

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

describe("boat class isolation", () => {
  it("matches Optimist vs ILCA 4 separately", () => {
    expect(
      regattaMatchesSeriesClass({ boatClass: "Optimist" }, "Optimist")
    ).toBe(true);
    expect(regattaMatchesSeriesClass({ boatClass: null }, "Optimist")).toBe(
      true
    );
    expect(
      regattaMatchesSeriesClass({ boatClass: "ILCA 4" }, "Optimist")
    ).toBe(false);
    expect(
      regattaMatchesSeriesClass({ boatClass: "ILCA 4" }, "ILCA 4")
    ).toBe(true);
  });

  it("rankingRegattasInPeriod excludes other boat classes", () => {
    const period = { year: 2026, half: "Jan-Jun" as const };
    const regs: RegattaRecord[] = [
      {
        id: "opt",
        name: "Opt Gold",
        slug: "opt",
        date: "2026-03-01",
        totalFleetSize: 50,
        division: "Gold",
        boatClass: "Optimist",
        countsForRanking: true,
      },
      {
        id: "ilca",
        name: "ILCA Open",
        slug: "ilca",
        date: "2026-03-15",
        totalFleetSize: 30,
        division: "Open",
        boatClass: "ILCA 4",
        countsForRanking: true,
      },
      {
        id: "ilca-gold-mislabel",
        name: "ILCA mislabel",
        slug: "ilca2",
        date: "2026-04-01",
        totalFleetSize: 30,
        division: "Gold",
        boatClass: "ILCA 4",
        countsForRanking: true,
      },
    ];
    const gold = rankingRegattasInPeriod("Gold", period, regs, "Optimist");
    expect(gold.map((r) => r.id)).toEqual(["opt"]);
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
    expect(natSquadFieldForPeriod({ year: 2027, half: "Jan-Jun" })).toBe(
      "natSquadStatusJan27"
    );
    expect(natSquadFieldForPeriod({ year: 2024, half: "Jul-Dec" })).toBeNull();
  });

  it("squadStatusForPeriod prefers period field then nationalSquadStatus", () => {
    const sailor = {
      natSquadStatusJul26: "Nat A",
      natSquadStatusJan27: "Nat B",
      nationalSquadStatus: "DS",
    } as SailorRecord;
    expect(
      squadStatusForPeriod(sailor, { year: 2026, half: "Jul-Dec" })
    ).toBe("Nat A");
    expect(
      squadStatusForPeriod(sailor, { year: 2027, half: "Jan-Jun" }, {
        fallbackNational: false,
      })
    ).toBe("Nat B");
    expect(
      squadStatusForPeriod(
        { nationalSquadStatus: "Nat B" } as SailorRecord,
        { year: 2024, half: "Jan-Jun" }
      )
    ).toBe("Nat B");
  });

  it("stripProjectedNextSquadStatus clears next-half projection only", () => {
    const ranked = [
      { id: "a", nextPeriodSquadStatus: "Nat A", periodSquadStatus: "Nat B" },
      { id: "b", periodSquadStatus: "DS" },
    ] as RankedSailor[];
    const out = stripProjectedNextSquadStatus(ranked);
    expect(out[0].nextPeriodSquadStatus).toBeNull();
    expect(out[0].periodSquadStatus).toBe("Nat B");
    expect(out[1]).toBe(ranked[1]);
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

  it("Series with no entry dates is not ranked", () => {
    expect(
      resolveSailorFleet(
        base({
          currentFleet: "Series",
          silverEntryDate: null,
          goldEntryDate: null,
        }),
        jan26
      )
    ).toBeNull();
  });

  it("SGP optimist with history is auto-ranked Silver without stamp", () => {
    const r = resolveSailorFleet(
      base({
        currentFleet: null,
        nationality: "SGP",
        silverEntryDate: null,
        goldEntryDate: null,
      }),
      jan26,
      { hasOptimistHistoryByPeriodEnd: true }
    );
    expect(r).toEqual({ active: true, fleet: "Silver" });
  });

  it("SGP Guest is never auto-ranked", () => {
    expect(
      resolveSailorFleet(
        base({
          currentFleet: "Guest",
          nationality: "SGP",
        }),
        jan26,
        { hasOptimistHistoryByPeriodEnd: true }
      )
    ).toBeNull();
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

  it("drop on half boundary excludes that half and later", () => {
    // Product: drop is 1 Jan / 1 Jul only — e.g. 2026-07-01 leaves Jan–Jun intact
    expect(
      resolveSailorFleet(
        base({
          goldEntryDate: "2022-01-01",
          dropDate: "2026-07-01",
        }),
        jan26
      )
    ).toEqual({ active: true, fleet: "Gold" });
    expect(
      resolveSailorFleet(
        base({
          goldEntryDate: "2022-01-01",
          dropDate: "2026-07-01",
        }),
        jul26
      )
    ).toBeNull();
  });

  it("drop on 1 Jan of half excludes that half", () => {
    expect(
      resolveSailorFleet(
        base({
          goldEntryDate: "2022-01-01",
          dropDate: "2026-01-01",
        }),
        jan26
      )
    ).toBeNull();
  });

  it("gold entry 1 Jan of half → Gold whole half", () => {
    const r = resolveSailorFleet(
      base({
        silverEntryDate: "2025-01-01",
        goldEntryDate: "2026-01-01",
      }),
      jan26
    );
    expect(r).toEqual({ active: true, fleet: "Gold" });
  });

  it("silver/gold entry in future half → excluded", () => {
    const r1 = resolveSailorFleet(
      base({
        silverEntryDate: "2026-07-01",
        goldEntryDate: null,
      }),
      jan26
    );
    expect(r1).toBeNull();

    const r2 = resolveSailorFleet(
      base({
        silverEntryDate: null,
        goldEntryDate: "2026-07-01",
      }),
      jan26
    );
    expect(r2).toBeNull();
  });
});

describe("calculateRankings Silver previous/current half activity", () => {
  const period = { year: 2026, half: "Jul-Dec" as const };
  const sailor = (
    id: string,
    over: Partial<SailorRecord> = {}
  ): SailorRecord =>
    ({
      id,
      name: id,
      handle: id,
      sailNumber: "SGP 1",
      club: "C",
      nationality: "SGP",
      currentFleet: "Series",
      silverEntryDate: "2024-01-01",
      goldEntryDate: null,
      dropDate: null,
      ...over,
    }) as SailorRecord;

  const regatta = (
    id: string,
    date: string,
    division: string = "Silver"
  ): RegattaRecord => ({
    id,
    name: id,
    slug: id,
    date,
    totalFleetSize: 50,
    division,
    boatClass: "Optimist",
    countsForRanking: true,
  });

  it("drops Silver sailors who missed the previous half and have no current starts", () => {
    // Jul–Dec 2026 board: need a start in Jan–Jun 2026 or Jul–Dec 2026
    const regattas = [
      regatta("old-2025", "2025-09-01"), // prior year — not enough alone
      regatta("prev", "2026-03-01"), // previous half
      regatta("cur", "2026-07-04"), // current half
    ];
    const racedPrev = sailor("raced-prev");
    const racedCur = sailor("raced-cur");
    const missedBoth = sailor("missed"); // only 2025
    const results = [
      { sailorId: "raced-prev", regattaId: "prev", rank: 10, isDns: false },
      { sailorId: "raced-cur", regattaId: "cur", rank: 12, isDns: false },
      { sailorId: "missed", regattaId: "old-2025", rank: 20, isDns: false },
    ];
    const ranked = calculateRankings(
      period,
      [racedPrev, racedCur, missedBoth],
      regattas,
      results
    );
    expect(ranked.map((s) => s.id).sort()).toEqual(
      ["raced-cur", "raced-prev"].sort()
    );
  });

  it("keeps Gold sailors even with no starts in the window", () => {
    const regattas = [
      regatta("g1", "2026-07-04", "Gold"),
      regatta("g2", "2026-07-18", "Gold"),
      regatta("g3", "2026-08-01", "Gold"),
    ];
    const goldInactive = sailor("gold-idle", {
      goldEntryDate: "2025-01-01",
      silverEntryDate: "2024-01-01",
    });
    const ranked = calculateRankings(
      period,
      [goldInactive],
      regattas,
      [] // no results → all DNS pads, but Gold is never filtered
    );
    expect(ranked.map((s) => s.id)).toEqual(["gold-idle"]);
    expect(ranked[0].fleet).toBe("Gold");
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

describe("Optimist DNS Group 1 / Group 2 scoring", () => {
  const period = { year: 2026, half: "Jan-Jun" as const };
  const goldSailor = (id: string): SailorRecord =>
    ({
      id,
      name: id,
      handle: id,
      sailNumber: "SGP 1",
      club: "C",
      currentFleet: "Series",
      goldEntryDate: "2025-01-01",
      silverEntryDate: "2024-01-01",
      dropDate: null,
      nationality: "SGP",
    }) as SailorRecord;

  it("Group1 = starters+1; Group2 = max(sheet place)+1 (not registered+1)", () => {
    const regattas: RegattaRecord[] = [
      {
        id: "ex",
        name: "Example",
        slug: "ex",
        date: "2026-03-01",
        totalFleetSize: 90,
        division: "Gold",
        boatClass: "Optimist",
        countsForRanking: true,
      },
    ];
    const results: RegattaResultRecord[] = [];
    for (let i = 1; i <= 78; i++) {
      results.push({ sailorId: `f${i}`, regattaId: "ex", rank: i });
    }
    // Two registered no-shows (on sheet with DNS). Worst sheet place = 81.
    results.push({ sailorId: "dns-a", regattaId: "ex", rank: 81, isDns: true });
    results.push({ sailorId: "dns-b", regattaId: "ex", rank: 81, isDns: true });

    const dnsA = goldSailor("dns-a");
    const dnsB = goldSailor("dns-b");
    const neverReg = goldSailor("never");
    const finisher = goldSailor("f1");

    const ranked = calculateRankings(
      period,
      [dnsA, dnsB, neverReg, finisher],
      regattas,
      results
    );
    expect(ranked.find((s) => s.id === "f1")!.regattaScores[0]?.score).toBe(1);
    // Group 1: starters (78) + 1 = 79 (sheet DNS place ignored for national score)
    expect(ranked.find((s) => s.id === "dns-a")!.regattaScores[0]?.score).toBe(
      79
    );
    expect(ranked.find((s) => s.id === "dns-b")!.regattaScores[0]?.score).toBe(
      79
    );
    expect(ranked.find((s) => s.id === "dns-a")!.regattaScores[0]?.isDNS).toBe(
      true
    );
    // Group 2: max sheet place (81) + 1 = 82 — NOT registered+1 (81)
    expect(ranked.find((s) => s.id === "never")!.regattaScores[0]?.score).toBe(
      82
    );
    expect(ranked.find((s) => s.id === "never")!.regattaScores[0]?.isDNS).toBe(
      true
    );
  });

  it("empty sheet: no Group 2 invented for absentees", () => {
    const regattas: RegattaRecord[] = [
      {
        id: "empty",
        name: "Not uploaded",
        slug: "empty",
        date: "2026-04-01",
        totalFleetSize: 50,
        division: "Gold",
        boatClass: "Optimist",
        countsForRanking: true,
      },
    ];
    const sailor = goldSailor("g1");
    const ranked = calculateRankings(period, [sailor], regattas, []);
    expect(ranked).toHaveLength(1);
    expect(ranked[0].regattaScores).toHaveLength(0);
  });

  it("overseas commitment keeps stored rank (overrides DNS formula)", () => {
    const regattas: RegattaRecord[] = [
      {
        id: "r1",
        name: "R1",
        slug: "r1",
        date: "2026-03-01",
        totalFleetSize: 50,
        division: "Gold",
        boatClass: "Optimist",
        countsForRanking: true,
      },
    ];
    const ovs = goldSailor("ovs");
    const results = [
      { sailorId: "f1", regattaId: "r1", rank: 1 },
      {
        sailorId: "ovs",
        regattaId: "r1",
        rank: 3,
        isDns: true,
        isOverseasCommitment: true,
      },
    ];
    const ranked = calculateRankings(period, [ovs], regattas, results);
    expect(ranked.find((s) => s.id === "ovs")!.regattaScores[0]?.score).toBe(3);
    expect(
      ranked.find((s) => s.id === "ovs")!.regattaScores[0]?.isOverseasCommitment
    ).toBe(true);
    expect(ranked.find((s) => s.id === "ovs")!.regattaScores[0]?.isDNS).toBe(
      false
    );
  });

  it("sheet stats + score helpers", () => {
    expect(optimistRegisteredNoShowScore(78)).toBe(79);
    // Group 2 uses max sheet place + 1
    expect(optimistUnregisteredScore(81)).toBe(82);
    expect(optimistUnregisteredScore(null)).toBeNull();
    expect(optimistUnregisteredScore(0)).toBeNull();
    const m = optimistSheetStatsByRegattaId([
      { sailorId: "a", regattaId: "r1", rank: 1 },
      { sailorId: "b", regattaId: "r1", rank: 2 },
      { sailorId: "c", regattaId: "r1", rank: 3, isDns: true },
      {
        sailorId: "d",
        regattaId: "r1",
        rank: 4,
        isDns: true,
        isOverseasCommitment: true,
      },
    ]);
    // started excludes DNS and overseas; maxRank includes all places
    expect(m.get("r1")).toEqual({ registered: 4, started: 2, maxRank: 4 });
  });
});

describe("regattaCountsForRanking", () => {
  it("defines MIN_RACES_FOR_RANKING as 3", () => {
    expect(MIN_RACES_FOR_RANKING).toBe(3);
  });

  it("returns false when countsForRanking is explicitly false", () => {
    expect(regattaCountsForRanking({ countsForRanking: false })).toBe(false);
    expect(regattaCountsForRanking({ countsForRanking: false, raceCount: 6 })).toBe(false);
  });

  it("returns false when completed races < 3 (abandoned / shortened event)", () => {
    expect(regattaCountsForRanking({ countsForRanking: true, raceCount: 0 })).toBe(false);
    expect(regattaCountsForRanking({ countsForRanking: true, raceCount: 1 })).toBe(false);
    expect(regattaCountsForRanking({ countsForRanking: true, raceCount: 2 })).toBe(false);
    expect(regattaCountsForRanking({ countsForRanking: null, raceCount: 2 })).toBe(false);
  });

  it("returns true when completed races >= 3", () => {
    expect(regattaCountsForRanking({ countsForRanking: true, raceCount: 3 })).toBe(true);
    expect(regattaCountsForRanking({ countsForRanking: true, raceCount: 4 })).toBe(true);
    expect(regattaCountsForRanking({ countsForRanking: true, raceCount: 12 })).toBe(true);
  });

  it("returns true when raceCount is null/undefined and countsForRanking is true or unflagged", () => {
    expect(regattaCountsForRanking({ countsForRanking: true })).toBe(true);
    expect(regattaCountsForRanking({})).toBe(true);
  });

  it("excludes regattas with fewer than 3 races from rankingRegattasInPeriod", () => {
    const period = { year: 2026, half: "Jan-Jun" as const };
    const regattas: RegattaRecord[] = [
      {
        id: "r1",
        name: "Full Regatta",
        slug: "full-regatta",
        date: "2026-03-01",
        totalFleetSize: 40,
        boatClass: "Optimist",
        division: "Gold",
        raceCount: 4,
        countsForRanking: true,
      },
      {
        id: "r2",
        name: "Shortened Regatta (2 races)",
        slug: "shortened-regatta",
        date: "2026-04-01",
        totalFleetSize: 40,
        boatClass: "Optimist",
        division: "Gold",
        raceCount: 2,
        countsForRanking: true,
      },
      {
        id: "r3",
        name: "Pesta Sukan (3 races)",
        slug: "pesta-sukan",
        date: "2026-05-01",
        totalFleetSize: 40,
        boatClass: "Optimist",
        division: "Gold",
        raceCount: 3,
        countsForRanking: true,
      },
    ];

    const active = rankingRegattasInPeriod("Gold", period, regattas);
    expect(active.map((r) => r.slug)).toEqual(["full-regatta", "pesta-sukan"]);
    expect(active.some((r) => r.slug === "shortened-regatta")).toBe(false);
  });
});

