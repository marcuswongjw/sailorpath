import { describe, expect, it } from "vitest";
import {
  applyProjectedGoldParticipationDropped,
  completedPeriodsUpTo,
  findGoldParticipationDrops,
  goldParticipationOutlook,
  monthsInGoldTenure,
  rankingGoldRegattasInPeriod,
} from "./goldFleetDrop";
import type { RankedSailor } from "./ranking";
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

  it("DNS does not count toward Gold participation", () => {
    const sailors: SailorRecord[] = [
      {
        id: "s-dns",
        name: "DnsOnly",
        handle: "dnsonly",
        sailNumber: "SGP 9",
        club: "X",
        goldEntryDate: "2026-01-01",
        silverEntryDate: "2024-01-01",
        dropDate: null,
        currentFleet: "Series",
      },
    ];
    // Two Gold ranking results but both DNS → 0 real participations → drop
    const results: RegattaResultRecord[] = [
      { sailorId: "s-dns", regattaId: "g1", rank: 51, isDns: true },
      { sailorId: "s-dns", regattaId: "g2", rank: 51, isDns: true },
    ];
    const drops = findGoldParticipationDrops(
      sailors,
      regattas,
      results,
      "2026-08-01"
    ).filter(
      (d) =>
        d.sailorId === "s-dns" &&
        d.failedPeriod.year === 2026 &&
        d.failedPeriod.half === "Jan-Jun"
    );
    expect(drops.length).toBe(1);
    expect(drops[0]?.participationCount).toBe(0);
  });

  it("overseas commitment DOES count as Gold (Go Fleet) participation", () => {
    const sailors: SailorRecord[] = [
      {
        id: "s-ovs",
        name: "Overseas",
        handle: "ovs",
        sailNumber: "SGP 8",
        club: "X",
        goldEntryDate: "2026-01-01",
        silverEntryDate: "2024-01-01",
        dropDate: null,
        currentFleet: "Series",
      },
    ];
    const results: RegattaResultRecord[] = [
      {
        sailorId: "s-ovs",
        regattaId: "g1",
        rank: 2,
        isDns: true,
        isOverseasCommitment: true,
      },
      { sailorId: "s-ovs", regattaId: "g2", rank: 12 },
    ];
    // Overseas (g1) + raced (g2) = 2 → meets Gold bar; no drop for Jan-Jun 2026
    const drops = findGoldParticipationDrops(
      sailors,
      regattas,
      results,
      "2026-08-01"
    ).filter(
      (d) =>
        d.sailorId === "s-ovs" &&
        d.failedPeriod.year === 2026 &&
        d.failedPeriod.half === "Jan-Jun"
    );
    expect(drops).toHaveLength(0);
  });

  it("overseas alone can help meet the Gold bar of 2", () => {
    const sailors: SailorRecord[] = [
      {
        id: "s-ovs2",
        name: "OvsTwo",
        handle: "ovs2",
        sailNumber: "SGP 7",
        club: "X",
        goldEntryDate: "2026-01-01",
        silverEntryDate: "2024-01-01",
        dropDate: null,
        currentFleet: "Series",
      },
    ];
    const results: RegattaResultRecord[] = [
      {
        sailorId: "s-ovs2",
        regattaId: "g1",
        rank: 5,
        isOverseasCommitment: true,
      },
      {
        sailorId: "s-ovs2",
        regattaId: "g2",
        rank: 6,
        isDns: true,
        isOverseasCommitment: true,
      },
      // plain DNS does not count
      { sailorId: "s-ovs2", regattaId: "g3", rank: 50, isDns: true },
    ];
    const drops = findGoldParticipationDrops(
      sailors,
      regattas,
      results,
      "2026-08-01"
    ).filter(
      (d) =>
        d.sailorId === "s-ovs2" &&
        d.failedPeriod.year === 2026 &&
        d.failedPeriod.half === "Jan-Jun"
    );
    expect(drops).toHaveLength(0);
  });

});

describe("projected Drop while the half is still open", () => {
  const period = { year: 2026, half: "Jul-Dec" as const };
  const regattas: RegattaRecord[] = [
    {
      id: "past",
      name: "Past",
      slug: "past",
      date: "2026-08-01",
      totalFleetSize: 40,
      division: "Gold",
      boatClass: "Optimist",
      countsForRanking: true,
    },
    {
      id: "final",
      name: "Final",
      slug: "final",
      date: "2026-11-01",
      totalFleetSize: 40,
      division: "Gold",
      boatClass: "Optimist",
      countsForRanking: true,
    },
  ];

  function sailor(id: string): RankedSailor {
    return {
      id,
      name: id,
      handle: id,
      sailNumber: "1",
      club: "X",
      goldEntryDate: "2026-07-01",
      silverEntryDate: null,
      dropDate: null,
      currentFleet: "Series",
      fleet: "Gold",
      gender: "M",
      dob: "2012-06-01",
      nationality: "SGP",
      regattaScores: [],
      bestThreeScores: [10, 10, 10],
      overallScore: 30,
    };
  }

  it("tags zero starts as Drop when one ranking regatta is left", () => {
    expect(
      goldParticipationOutlook("none", period, regattas, [], "2026-09-25")
    ).toMatchObject({ soFar: 0, remaining: 1, meetsMinimum: false });
    const [row] = applyProjectedGoldParticipationDropped(
      [sailor("none")],
      period,
      regattas,
      [],
      "2026-09-25"
    );
    expect(row.nextPeriodSquadStatus).toBe("Drop");
  });

  it("does not drop a sailor who already has one start and one regatta left", () => {
    const results: RegattaResultRecord[] = [
      { sailorId: "one", regattaId: "past", rank: 10 },
    ];
    expect(
      goldParticipationOutlook("one", period, regattas, results, "2026-09-25")
    ).toMatchObject({ soFar: 1, remaining: 1, meetsMinimum: true });
    const [row] = applyProjectedGoldParticipationDropped(
      [sailor("one")],
      period,
      regattas,
      results,
      "2026-09-25"
    );
    expect(row.nextPeriodSquadStatus).not.toBe("Drop");
  });
});
