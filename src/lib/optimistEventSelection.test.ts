import { describe, expect, it } from "vitest";
import {
  computeCombinedSelectionScores,
  combinedRaceDiscardCount,
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
    const raceResults = [1, 2].map((raceNumber) => ({
      raceNumber,
      score: place,
      scoringCode: null,
      discarded: false,
      rawValue: String(place),
    }));
    out.push({ sailorId: s.id, regattaId: "r1", rank: place, raceResults });
    out.push({ sailorId: s.id, regattaId: "r2", rank: place, raceResults });
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

describe("combined race-score policy", () => {
  it.each([
    [0, 0],
    [6, 0],
    [7, 1],
    [14, 1],
    [15, 2],
    [21, 2],
    [22, 3],
    [28, 3],
    [29, 4],
  ])("uses %i races to award %i discards", (raceCount, expected) => {
    expect(combinedRaceDiscardCount(raceCount)).toBe(expected);
  });

  it("matches the worked example, including per-race absence penalties and A8", () => {
    const exampleRegattas: RegattaRecord[] = [
      { ...regattas[0], totalFleetSize: 12, raceCount: 6 },
      { ...regattas[1], totalFleetSize: 8, raceCount: 3 },
    ];
    const exampleSailors = ["A", "B", "C"].map((name) => ({
      id: name,
      name,
      handle: name.toLowerCase(),
      sailNumber: name,
      club: "Club",
      goldEntryDate: "2024-01-01",
      silverEntryDate: null,
      dropDate: null,
    }));
    const raceRow = (sailorId: string, regattaId: string, scores: number[]): RegattaResultRecord => ({
      sailorId,
      regattaId,
      rank: 1,
      raceResults: scores.map((score, index) => ({
        raceNumber: index + 1,
        score,
        scoringCode: null,
        discarded: false,
        rawValue: String(score),
      })),
    });
    const exampleResults = [
      raceRow("A", "r1", [4, 5, 3, 6, 7, 2]),
      raceRow("A", "r2", [2, 4, 3]),
      raceRow("B", "r1", [1, 2, 1, 4, 5, 13]),
      raceRow("B", "r2", [1, 1, 2]),
      raceRow("C", "r1", [2, 1, 2, 1, 4, 1]),
      // C did not participate in event 2: 8 + 1 for each of its 3 races.
    ];
    const matched = matchSelectionEvents(exampleRegattas, OPTIMIST_2026_SELECTION_EVENTS);
    const ranked = computeCombinedSelectionScores(matched, exampleSailors, exampleResults);
    expect(ranked.map((row) => [row.name, row.combinedScore])).toEqual([
      ["B", 17],
      ["C", 29],
      ["A", 29],
    ]);
  });

  it("does not substitute aggregate event ranks when race detail is absent", () => {
    const matched = matchSelectionEvents(regattas, OPTIMIST_2026_SELECTION_EVENTS);
    expect(
      computeCombinedSelectionScores(matched, sailors(), [
        { sailorId: "m1", regattaId: "r1", rank: 1 },
      ])
    ).toEqual([]);
  });

  it("keeps DNE in the net score and discards the next-highest race", () => {
    const selectionRegatta: RegattaRecord = {
      ...regattas[0],
      raceCount: 8,
      totalFleetSize: 51,
    };
    const tanQi: SailorRecord = {
      id: "tan-qi",
      name: "Tan Qi",
      handle: "tan-qi",
      sailNumber: "SGP 1",
      club: "Club",
      goldEntryDate: "2024-01-01",
      silverEntryDate: null,
      dropDate: null,
    };
    const scores = [37, 21, 26, 27, 10, 52, 47, 36];
    const result: RegattaResultRecord = {
      sailorId: tanQi.id,
      regattaId: selectionRegatta.id,
      rank: 33,
      nettScore: 209,
      totalScore: 256,
      raceResults: scores.map((score, index) => ({
        raceNumber: index + 1,
        score,
        scoringCode: index === 5 ? "DNE" : null,
        discarded: index === 6,
        rawValue: index === 5 ? "52.0 DNE" : String(score),
      })),
    };
    const matched = matchSelectionEvents(
      [selectionRegatta],
      [OPTIMIST_2026_SELECTION_EVENTS[0]]
    );
    const [row] = computeCombinedSelectionScores(matched, [tanQi], [result]);

    expect(row.grossScore).toBe(256);
    expect(row.combinedScore).toBe(209);
    expect(row.raceScores[5]).toMatchObject({
      score: 52,
      nonDiscardable: true,
      discarded: false,
    });
    expect(row.raceScores[6]).toMatchObject({ score: 47, discarded: true });
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
