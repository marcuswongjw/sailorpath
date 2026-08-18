import { describe, expect, it } from "vitest";
import {
  countOptimistRankingStartsInPeriod,
  findSilverInactivityDrops,
} from "./silverSeriesDrop";
import type { RegattaRecord, RegattaResultRecord, SailorRecord } from "./ranking";

describe("findSilverInactivityDrops", () => {
  const regattas: RegattaRecord[] = [
    {
      id: "s1",
      name: "Silver 1",
      slug: "s1",
      date: "2026-02-01",
      totalFleetSize: 50,
      division: "Silver",
      boatClass: "Optimist",
      countsForRanking: true,
    },
    {
      id: "s2",
      name: "Silver 2",
      slug: "s2",
      date: "2026-04-01",
      totalFleetSize: 50,
      division: "Silver",
      boatClass: "Optimist",
      countsForRanking: true,
    },
  ];

  const base = (over: Partial<SailorRecord> = {}): SailorRecord =>
    ({
      id: "a",
      name: "Ada",
      handle: "ada",
      sailNumber: "SGP 1",
      club: "X",
      nationality: "SGP",
      currentFleet: "Series",
      silverEntryDate: "2024-01-01",
      goldEntryDate: null,
      dropDate: null,
      ...over,
    }) as SailorRecord;

  it("flags silver sailor with zero ranking starts in a completed half", () => {
    // Entry in 2025 so the first completed empty half is Jan–Jun 2026
    const drops = findSilverInactivityDrops(
      [base({ silverEntryDate: "2026-01-01" })],
      regattas,
      [],
      "2026-08-01"
    );
    expect(drops).toHaveLength(1);
    expect(drops[0]?.sailorId).toBe("a");
    expect(drops[0]?.failedPeriod).toEqual({ year: 2026, half: "Jan-Jun" });
    expect(drops[0]?.dropDate).toBe("2026-07-01");
  });

  it("does not drop when sailor started at least once in the half", () => {
    const results: RegattaResultRecord[] = [
      { sailorId: "a", regattaId: "s1", rank: 20, isDns: false },
    ];
    const drops = findSilverInactivityDrops(
      [base()],
      regattas,
      results,
      "2026-08-01"
    ).filter(
      (d) =>
        d.sailorId === "a" &&
        d.failedPeriod.year === 2026 &&
        d.failedPeriod.half === "Jan-Jun"
    );
    expect(drops).toHaveLength(0);
  });

  it("DNS-only does not count as taking part", () => {
    const results: RegattaResultRecord[] = [
      { sailorId: "a", regattaId: "s1", rank: 51, isDns: true },
    ];
    expect(
      countOptimistRankingStartsInPeriod(
        "a",
        { year: 2026, half: "Jan-Jun" },
        regattas,
        results
      )
    ).toBe(0);
  });

  it("skips gold sailors for silver inactivity (gold rule owns them)", () => {
    const drops = findSilverInactivityDrops(
      [
        base({
          id: "g",
          name: "Goldie",
          goldEntryDate: "2025-01-01",
        }),
      ],
      regattas,
      [],
      "2026-08-01"
    ).filter((d) => d.sailorId === "g");
    expect(drops).toHaveLength(0);
  });

  it("does not overwrite an earlier existing drop date", () => {
    const drops = findSilverInactivityDrops(
      [base({ dropDate: "2025-07-01" })],
      regattas,
      [],
      "2026-08-01"
    ).filter((d) => d.sailorId === "a");
    expect(drops).toHaveLength(0);
  });
});
