import { describe, expect, it } from "vitest";
import { missingDnsPairs, rankingRegattasForFleet } from "./fillDns";
import type { Period, RegattaRecord, SailorRecord } from "./ranking";

const period: Period = { year: 2026, half: "Jan-Jun" };

const seriesGold = (id: string): SailorRecord =>
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
  }) as SailorRecord;

describe("fillDns / ranking regattas", () => {
  it("excludes countsForRanking=false from period pool", () => {
    const regattas: RegattaRecord[] = [
      {
        id: "r1",
        name: "CSC Gold",
        slug: "csc",
        date: "2026-01-15",
        totalFleetSize: 40,
        division: "Gold",
        countsForRanking: true,
      },
      {
        id: "personal",
        name: "Personal overseas",
        slug: "personal",
        date: "2026-02-01",
        totalFleetSize: 20,
        division: "Gold",
        countsForRanking: false,
      },
      {
        id: "r2",
        name: "Temasek",
        slug: "temasek",
        date: "2026-03-01",
        totalFleetSize: 50,
        division: "Gold",
        countsForRanking: true,
      },
    ];
    const events = rankingRegattasForFleet("Gold", period, regattas);
    expect(events.map((e) => e.id)).toEqual(["r1", "r2"]);
  });

  it("missingDnsPairs skips non-ranking regattas", () => {
    const sailors = [seriesGold("s1")];
    const regattas: RegattaRecord[] = [
      {
        id: "rank",
        name: "Ranked",
        slug: "rank",
        date: "2026-01-10",
        totalFleetSize: 30,
        division: "Gold",
        countsForRanking: true,
      },
      {
        id: "log",
        name: "Logbook",
        slug: "log",
        date: "2026-01-20",
        totalFleetSize: 10,
        division: "Gold",
        countsForRanking: false,
      },
    ];
    const pairs = missingDnsPairs({
      fleet: "Gold",
      period,
      sailors,
      regattas,
      existingKeys: new Set(),
    });
    expect(pairs).toHaveLength(1);
    expect(pairs[0].regattaId).toBe("rank");
    expect(pairs[0].dnsPoints).toBe(31);
  });

  it("undefined countsForRanking still counts (legacy)", () => {
    const regattas: RegattaRecord[] = [
      {
        id: "legacy",
        name: "Legacy",
        slug: "legacy",
        date: "2026-04-01",
        totalFleetSize: 40,
        division: "Gold",
        // countsForRanking omitted
      },
    ];
    expect(rankingRegattasForFleet("Gold", period, regattas)).toHaveLength(1);
  });
});
