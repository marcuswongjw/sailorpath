import { describe, expect, it } from "vitest";
import {
  countOptimistRankingStartsInPeriod,
  earliestOptimistRankingDate,
  findSilverInactivityDrops,
  isSilverInactivityCandidate,
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

  it("non-series idle SGP is not a drop candidate", () => {
    const idleSgp = base({
      id: "idle",
      name: "Idle SGP",
      currentFleet: null,
      silverEntryDate: null,
      goldEntryDate: null,
      nationality: "SGP",
    });
    expect(isSilverInactivityCandidate(idleSgp)).toBe(false);
    const drops = findSilverInactivityDrops(
      [idleSgp],
      regattas,
      [],
      "2026-08-01"
    );
    expect(drops).toHaveLength(0);
  });

  it("series sailor without foothold is not stamped with ancient drop dates", () => {
    // Series tag but no entry dates and no Optimist results — must not walk
    // completed halves from ~2022 and invent e.g. 2022-07-01.
    const noFoothold = base({
      id: "nof",
      name: "No Foothold",
      currentFleet: "Series",
      silverEntryDate: null,
      goldEntryDate: null,
      dropDate: null,
    });
    expect(isSilverInactivityCandidate(noFoothold)).toBe(true);
    const drops = findSilverInactivityDrops(
      [noFoothold],
      regattas,
      [],
      "2026-08-01"
    );
    expect(drops).toHaveLength(0);
  });

  it("findSilverInactivityDrops does not mutate sailor records", () => {
    const sailor = base({ silverEntryDate: "2026-01-01", dropDate: null });
    const snapshot = { ...sailor };
    findSilverInactivityDrops([sailor], regattas, [], "2026-08-01");
    expect(sailor).toEqual(snapshot);
    expect(sailor.dropDate).toBeNull();
  });

  it("series sailor with optimist history foothold (no entry stamp) can be flagged", () => {
    const seriesOnly = base({
      id: "hist",
      silverEntryDate: null,
      goldEntryDate: null,
      currentFleet: "Series",
    });
    // Raced once in 2025 H2, then idle all of 2026 H1 → drop 2026-07-01
    const histRegattas: RegattaRecord[] = [
      {
        id: "old",
        name: "Old Silver",
        slug: "old",
        date: "2025-09-01",
        totalFleetSize: 40,
        division: "Silver",
        boatClass: "Optimist",
        countsForRanking: true,
      },
      ...regattas,
    ];
    const results: RegattaResultRecord[] = [
      { sailorId: "hist", regattaId: "old", rank: 10, isDns: false },
    ];
    expect(earliestOptimistRankingDate("hist", histRegattas, results)).toBe(
      "2025-09-01"
    );
    const drops = findSilverInactivityDrops(
      [seriesOnly],
      histRegattas,
      results,
      "2026-08-01"
    );
    expect(drops).toHaveLength(1);
    expect(drops[0]?.dropDate).toBe("2026-07-01");
    expect(drops[0]?.failedPeriod).toEqual({ year: 2026, half: "Jan-Jun" });
  });
});
