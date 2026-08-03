import { describe, expect, it } from "vitest";
import {
  completedPeriodsUpTo,
  findGoldParticipationDrops,
  monthsInGoldTenure,
  rankingGoldRegattasInPeriod,
} from "./goldFleetDrop";
import type { RegattaRecord, RegattaResultRecord, SailorRecord } from "./ranking";

describe("completedPeriodsUpTo", () => {
  it("includes finished halves only", () => {
    const p = completedPeriodsUpTo("2026-08-03");
    expect(p.some((x) => x.year === 2026 && x.half === "Jan-Jun")).toBe(true);
    expect(p.some((x) => x.year === 2026 && x.half === "Jul-Dec")).toBe(false);
  });
});

describe("monthsInGoldTenure", () => {
  it("stops at drop date", () => {
    expect(monthsInGoldTenure("2025-01-01", "2026-07-01", "2026-12-01")).toBe(
      18
    );
  });
  it("uses asOf when still active", () => {
    expect(monthsInGoldTenure("2025-07-01", null, "2026-07-01")).toBe(12);
  });
});

describe("findGoldParticipationDrops", () => {
  const regattas: RegattaRecord[] = [
    {
      id: "g1",
      name: "G1",
      slug: "g1",
      date: "2026-02-01",
      totalFleetSize: 50,
      division: "Gold",
      boatClass: "Optimist",
      countsForRanking: true,
    },
    {
      id: "g2",
      name: "G2",
      slug: "g2",
      date: "2026-04-01",
      totalFleetSize: 50,
      division: "Gold",
      boatClass: "Optimist",
      countsForRanking: true,
    },
    {
      id: "g3",
      name: "G3",
      slug: "g3",
      date: "2026-05-01",
      totalFleetSize: 50,
      division: "Gold",
      boatClass: "Optimist",
      countsForRanking: true,
    },
  ];

  it("flags gold sailor with 0 ranking events in a completed half", () => {
    const sailors: SailorRecord[] = [
      {
        id: "s1",
        name: "Sparse",
        handle: "sparse",
        sailNumber: "SGP 1",
        club: "X",
        goldEntryDate: "2025-07-01",
        silverEntryDate: "2024-01-01",
        dropDate: null,
        currentFleet: "Series",
      },
    ];
    const results: RegattaResultRecord[] = [];
    const drops = findGoldParticipationDrops(
      sailors,
      regattas,
      results,
      "2026-08-01"
    );
    expect(drops.length).toBeGreaterThanOrEqual(1);
    expect(drops[0]?.sailorId).toBe("s1");
    expect(drops[0]?.dropDate).toMatch(/-01$|-07-01$/);
  });

  it("does not drop when sailor has 2+ ranking gold results in half", () => {
    const sailors: SailorRecord[] = [
      {
        id: "s2",
        name: "Active",
        handle: "active",
        sailNumber: "SGP 2",
        club: "X",
        goldEntryDate: "2025-07-01",
        silverEntryDate: "2024-01-01",
        dropDate: null,
        currentFleet: "Series",
      },
    ];
    const results: RegattaResultRecord[] = [
      { sailorId: "s2", regattaId: "g1", rank: 10 },
      { sailorId: "s2", regattaId: "g2", rank: 12 },
    ];
    // Only check 2026 Jan-Jun — should not drop for that half
    const drops = findGoldParticipationDrops(
      sailors,
      regattas,
      results,
      "2026-08-01"
    ).filter(
      (d) =>
        d.sailorId === "s2" &&
        d.failedPeriod.year === 2026 &&
        d.failedPeriod.half === "Jan-Jun"
    );
    expect(drops).toHaveLength(0);
  });

  it("lists ranking gold events in period", () => {
    const ev = rankingGoldRegattasInPeriod(
      { year: 2026, half: "Jan-Jun" },
      regattas
    );
    expect(ev).toHaveLength(3);
  });
});
