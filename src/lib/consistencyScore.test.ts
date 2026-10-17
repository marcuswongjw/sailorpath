import { describe, expect, it } from "vitest";
import {
  CONSISTENCY_MIN_FLEET,
  CONSISTENCY_MIN_RACES,
  CONSISTENCY_MIN_REGATTAS,
  computeConsistencyScore,
  consistencyClassForProfileTab,
  consistencyScoreFromPositions,
  fleetFinishPosition,
  populationStdDev,
  scoringCodesFromRace,
  type ConsistencyResultInput,
} from "./consistencyScore";

const PERIOD = { year: 2026, half: "Jul-Dec" as const };

function race(
  score: number,
  extra: {
    scoringCode?: string | null;
    discarded?: boolean;
    rawValue?: string;
  } = {}
) {
  return {
    score,
    scoringCode: extra.scoringCode ?? null,
    discarded: extra.discarded ?? false,
    rawValue: extra.rawValue ?? String(score),
  };
}

function result(
  partial: Partial<ConsistencyResultInput> & Pick<ConsistencyResultInput, "regattaDate">
): ConsistencyResultInput {
  return {
    boatClass: "Optimist",
    fleetSize: 40,
    totalFleetSize: 40,
    rank: 8,
    isDns: false,
    regattaId: partial.regattaDate,
    ...partial,
  };
}

describe("fleetFinishPosition", () => {
  it("scales first and last to the ends of the fleet", () => {
    expect(fleetFinishPosition({ place: 1, fleetSize: 40 })).toEqual({
      ok: true,
      position: 0,
      kind: "place",
    });
    expect(fleetFinishPosition({ place: 40, fleetSize: 40 })).toEqual({
      ok: true,
      position: 1,
      kind: "place",
    });
    expect(fleetFinishPosition({ place: 5, fleetSize: 21 }).ok && 
      (fleetFinishPosition({ place: 5, fleetSize: 21 }) as { position: number }).position
    ).toBeCloseTo(0.2);
  });

  it("keeps tied and fractional places", () => {
    const tied = fleetFinishPosition({ place: 3, fleetSize: 20 });
    const shared = fleetFinishPosition({ place: 3, fleetSize: 20 });
    expect(tied).toEqual(shared);
    const half = fleetFinishPosition({ place: 3.5, fleetSize: 20 });
    expect(half.ok).toBe(true);
    if (half.ok) expect(half.position).toBeCloseTo((3.5 - 1) / 19);
  });

  it("leaves out tiny fleets and a fleet of one", () => {
    expect(fleetFinishPosition({ place: 1, fleetSize: 1 }).ok).toBe(false);
    expect(fleetFinishPosition({ place: 2, fleetSize: CONSISTENCY_MIN_FLEET - 1 })).toEqual({
      ok: false,
      reason: "tiny-fleet",
    });
  });

  it("counts black flags, DNF, OCS, and TLE as the back of the fleet", () => {
    for (const code of ["BFD", "UFD", "DNF", "OCS", "DSQ", "RET", "TLE"]) {
      expect(
        fleetFinishPosition({ place: 3, fleetSize: 30, codes: [code] })
      ).toEqual({ ok: true, position: 1, kind: "back" });
    }
  });

  it("drops DNS and DNC", () => {
    expect(
      fleetFinishPosition({ place: 12, fleetSize: 30, codes: ["DNS"] })
    ).toEqual({ ok: false, reason: "absence" });
    expect(
      fleetFinishPosition({ place: 12, fleetSize: 30, codes: ["DNC"] })
    ).toEqual({ ok: false, reason: "absence" });
  });

  it("reads a letter code from the raw cell when the scoring code is empty", () => {
    expect(scoringCodesFromRace(null, "(92.0 BFD)")).toEqual(["BFD"]);
    expect(scoringCodesFromRace(null, "74 DNC")).toEqual(["DNC"]);
    expect(scoringCodesFromRace("DNF", "DNF")).toEqual(["DNF"]);
    expect(scoringCodesFromRace(null, "(29)")).toEqual([]);
    expect(scoringCodesFromRace(null, "(DNF97)")).toEqual(["DNF"]);
  });
});

describe("consistencyScoreFromPositions", () => {
  it("is 100 when every finish is the same place", () => {
    expect(populationStdDev([0.2, 0.2, 0.2, 0.2])).toBe(0);
    expect(consistencyScoreFromPositions([0.2, 0.2, 0.2, 0.2])).toBe(100);
  });

  it("is 0 when finishes split evenly between first and last", () => {
    expect(consistencyScoreFromPositions([0, 1, 0, 1, 0, 1])).toBe(0);
  });
});

describe("computeConsistencyScore", () => {
  it("scores one regatta from its races", () => {
    const scored = computeConsistencyScore(
      [
        result({
          regattaDate: "2026-07-18",
          regattaName: "Harbour Cup",
          raceResults: [2, 3, 2, 4, 3, 2].map((place) => race(place)),
        }),
      ],
      { classKey: "optimist", period: PERIOD }
    );
    expect(scored.status).toBe("ready");
    if (scored.status !== "ready") return;
    expect(scored.level).toBe("race");
    expect(scored.sampleSize).toBe(6);
    expect(scored.bandLabel).toBe("Very consistent");
    expect(scored.score).toBeGreaterThanOrEqual(80);
    expect(scored.classLabel).toBe("Optimist");
    expect(scored.periodLabel).toBe("Jul – Dec 2026");
  });

  it("includes a discarded deep race", () => {
    const steady = [4, 5, 4, 5, 4, 6].map((place) => race(place));
    const withDiscard = [
      ...steady,
      race(40, { discarded: true, rawValue: "(40)" }),
    ];
    const tight = computeConsistencyScore(
      [result({ regattaDate: "2026-08-01", raceResults: steady })],
      { classKey: "optimist", period: PERIOD }
    );
    const loose = computeConsistencyScore(
      [result({ regattaDate: "2026-08-01", raceResults: withDiscard })],
      { classKey: "optimist", period: PERIOD }
    );
    expect(tight.status).toBe("ready");
    expect(loose.status).toBe("ready");
    if (tight.status !== "ready" || loose.status !== "ready") return;
    expect(loose.sampleSize).toBe(tight.sampleSize + 1);
    expect(loose.score).toBeLessThan(tight.score);
  });

  it("does not score a sailor whose races are all DNS or DNC", () => {
    const scored = computeConsistencyScore(
      [
        result({
          regattaDate: "2026-07-20",
          isDns: true,
          rank: 41,
          raceResults: [1, 2, 3, 4, 5, 6, 7, 8].map(() =>
            race(41, { scoringCode: "DNC", rawValue: "41 DNC" })
          ),
        }),
      ],
      { classKey: "optimist", period: PERIOD }
    );
    expect(scored.status).toBe("insufficient");
    if (scored.status !== "insufficient") return;
    expect(scored.countedRaces).toBe(0);
    expect(scored.countedRegattas).toBe(0);
    expect(scored.explanation).toMatch(/Not enough/i);
  });

  it("treats a string of DNF results as consistently at the back", () => {
    const scored = computeConsistencyScore(
      [
        result({
          regattaDate: "2026-09-05",
          raceResults: Array.from({ length: CONSISTENCY_MIN_RACES }, () =>
            race(41, { scoringCode: "DNF", rawValue: "DNF" })
          ),
        }),
      ],
      { classKey: "optimist", period: PERIOD }
    );
    expect(scored.status).toBe("ready");
    if (scored.status !== "ready") return;
    expect(scored.score).toBe(100);
    expect(scored.band).toBe("very_consistent");
  });

  it("leaves tiny fleets out of the score", () => {
    const scored = computeConsistencyScore(
      [
        result({
          regattaDate: "2026-07-04",
          fleetSize: 3,
          totalFleetSize: 3,
          rank: 1,
          raceResults: [1, 2, 1, 3, 2, 1, 2, 1].map((place) => race(place)),
        }),
      ],
      { classKey: "optimist", period: PERIOD }
    );
    expect(scored.status).toBe("insufficient");
  });

  it("falls back to regatta places when race scores are thin", () => {
    const events = ["2026-07-04", "2026-08-15", "2026-09-12", "2026-10-03"];
    const scored = computeConsistencyScore(
      events.map((regattaDate, index) =>
        result({
          regattaDate,
          rank: 6 + index,
          raceResults: index === 0 ? [race(4), race(8)] : [],
        })
      ),
      { classKey: "optimist", period: PERIOD }
    );
    expect(scored.status).toBe("ready");
    if (scored.status !== "ready") return;
    expect(scored.level).toBe("regatta");
    expect(scored.sampleSize).toBe(CONSISTENCY_MIN_REGATTAS + 1);
    expect(scored.explanation).toMatch(/regatta places/i);
  });

  it("does not mix another class or an earlier ranking half", () => {
    const optimist = result({
      regattaDate: "2026-07-18",
      boatClass: "Optimist",
      raceResults: [2, 2, 2, 2, 2, 2].map((place) => race(place)),
    });
    const ilca = result({
      regattaDate: "2026-07-18",
      boatClass: "ILCA 4",
      regattaId: "ilca",
      raceResults: [1, 40, 1, 40, 1, 40].map((place) => race(place)),
    });
    const previousHalf = result({
      regattaDate: "2026-05-02",
      raceResults: [1, 40, 1, 40, 1, 40].map((place) => race(place)),
    });
    const scored = computeConsistencyScore([optimist, ilca, previousHalf], {
      classKey: "optimist",
      period: PERIOD,
    });
    expect(scored.status).toBe("ready");
    if (scored.status !== "ready") return;
    expect(scored.score).toBe(100);
    expect(scored.classKey).toBe("optimist");
    expect(scored.sampleSize).toBe(6);
  });

  it("keeps ILCA 6 off an ILCA 4 score, and uses ILCA 6 when that is the only rig", () => {
    const rows = [
      result({ boatClass: "ILCA 6", regattaDate: "2026-08-01" }),
      result({ boatClass: "ILCA 4", regattaDate: "2026-09-01" }),
    ];
    expect(consistencyClassForProfileTab("ilca4", rows)).toBe("ilca4");
    expect(
      consistencyClassForProfileTab("ilca4", [
        result({ boatClass: "ILCA 6", regattaDate: "2026-08-01" }),
      ])
    ).toBe("ilca6");
    expect(
      consistencyClassForProfileTab("optimist", [
        result({ boatClass: "Optimist", regattaDate: "2026-08-01" }),
        result({ boatClass: "ILCA 4", regattaDate: "2026-08-01" }),
      ])
    ).toBe("optimist");
  });

  it("ignores overseas-commitment rows and still counts a redress number", () => {
    const scored = computeConsistencyScore(
      [
        result({
          regattaDate: "2026-07-11",
          isOverseasCommitment: true,
          rank: 1,
          raceResults: [],
        }),
        result({
          regattaDate: "2026-08-01",
          rank: 10,
          raceResults: [
            race(8, { scoringCode: "RDG", rawValue: "8 RDG" }),
            ...[9, 8, 10, 9, 8].map((place) => race(place)),
          ],
        }),
      ],
      { classKey: "optimist", period: PERIOD }
    );
    expect(scored.status).toBe("ready");
    if (scored.status !== "ready") return;
    expect(scored.level).toBe("race");
    expect(scored.sampleSize).toBe(6);
    expect(scored.score).toBeGreaterThanOrEqual(80);
  });
});
