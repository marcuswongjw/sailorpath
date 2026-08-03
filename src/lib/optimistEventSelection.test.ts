import { describe, expect, it } from "vitest";
import {
  computeCombinedSelectionScores,
  matchSelectionEvents,
  selectAsianOceaniaTeam,
  selectPerthCamp,
  OPTIMIST_2026_SELECTION_EVENTS,
} from "./optimistEventSelection";
import type { RegattaRecord, RegattaResultRecord, SailorRecord } from "./ranking";

const regattas: RegattaRecord[] = [
  {
    id: "r1",
    name: "SSF Selection Trials 2026",
    slug: "ssf-trials",
    date: "2026-08-23",
    totalFleetSize: 40,
    division: "Gold",
    boatClass: "Optimist",
    countsForRanking: true,
  },
  {
    id: "r2",
    name: "Singapore National Sailing Championships",
    slug: "snsc",
    date: "2026-09-12",
    totalFleetSize: 50,
    division: "Gold",
    boatClass: "Optimist",
    countsForRanking: true,
  },
];

function sailors(): SailorRecord[] {
  const out: SailorRecord[] = [];
  for (let i = 1; i <= 12; i++) {
    out.push({
      id: `m${i}`,
      name: `Male ${i}`,
      handle: `m${i}`,
      sailNumber: "SGP 1",
      club: "X",
      goldEntryDate: "2024-01-01",
      silverEntryDate: null,
      dropDate: null,
      gender: "M",
      dob: i <= 2 ? "2013-05-01" : i <= 5 ? "2014-05-01" : "2015-05-01",
    });
  }
  for (let i = 1; i <= 8; i++) {
    out.push({
      id: `f${i}`,
      name: `Female ${i}`,
      handle: `f${i}`,
      sailNumber: "SGP 2",
      club: "X",
      goldEntryDate: "2024-01-01",
      silverEntryDate: null,
      dropDate: null,
      gender: "F",
      dob: i === 1 ? "2013-05-01" : i <= 4 ? "2014-05-01" : "2015-05-01",
    });
  }
  return out;
}

function results(): RegattaResultRecord[] {
  const out: RegattaResultRecord[] = [];
  let place = 1;
  for (const s of sailors()) {
    out.push({ sailorId: s.id, regattaId: "r1", rank: place });
    out.push({ sailorId: s.id, regattaId: "r2", rank: place });
    place++;
  }
  return out;
}

describe("matchSelectionEvents", () => {
  it("matches SSF trials and SNSC by name and date", () => {
    const m = matchSelectionEvents(regattas, OPTIMIST_2026_SELECTION_EVENTS);
    expect(m.every((x) => x.matched)).toBe(true);
    expect(m[0]?.regatta?.id).toBe("r1");
    expect(m[1]?.regatta?.id).toBe("r2");
  });
});

describe("selectAsianOceaniaTeam", () => {
  it("selects 10 with at least 3 per gender when available", () => {
    const matched = matchSelectionEvents(
      regattas,
      OPTIMIST_2026_SELECTION_EVENTS
    );
    const ranked = computeCombinedSelectionScores(
      matched,
      sailors(),
      results()
    );
    const { selected } = selectAsianOceaniaTeam(ranked);
    expect(selected.length).toBe(10);
    const m = selected.filter((s) => s.gender === "M").length;
    const f = selected.filter((s) => s.gender === "F").length;
    expect(m).toBeGreaterThanOrEqual(3);
    expect(f).toBeGreaterThanOrEqual(3);
  });
});

describe("selectPerthCamp", () => {
  it("fills birth-year gender buckets", () => {
    const matched = matchSelectionEvents(
      regattas,
      OPTIMIST_2026_SELECTION_EVENTS
    );
    const ranked = computeCombinedSelectionScores(
      matched,
      sailors(),
      results()
    );
    const { picks } = selectPerthCamp(ranked);
    expect(picks.filter((p) => p.bucket === "by2013")).toHaveLength(2);
    expect(picks.filter((p) => p.bucket === "by2014").length).toBeLessThanOrEqual(
      6
    );
    expect(picks.filter((p) => p.bucket === "by2015").length).toBeLessThanOrEqual(
      4
    );
  });
});
