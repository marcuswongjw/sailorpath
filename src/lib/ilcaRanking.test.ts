import { describe, expect, it } from "vitest";
import type { IlcaRankedSailor } from "./ilcaRanking";
import {
  ageInIntakeYear,
  bestThreeHighPoints,
  computeIlcaRankings,
  highRankingPoints,
  ilcaRegattaCountsForRanking,
  ilcaRankingRegattas,
  ilcaSquadCutoff,
  defaultIlcaIntake,
  selectIlca4NationalSquad,
  reRankIlcaWithExcluded,
  squadReasonLabel,
  ILCA_MIN_RACES_FOR_RANKING,
} from "./ilcaRanking";

describe("highRankingPoints", () => {
  it("awards N for 1st in fleet of N", () => {
    expect(highRankingPoints(1, 30)).toBe(30);
    expect(highRankingPoints(2, 30)).toBe(29);
    expect(highRankingPoints(30, 30)).toBe(1);
  });

  it("DNS scores 0", () => {
    expect(highRankingPoints(1, 30, { isDns: true })).toBe(0);
  });
});

describe("bestThreeHighPoints", () => {
  it("sums three highest", () => {
    const r = bestThreeHighPoints([10, 30, 5, 28, 20]);
    expect(r.bestThree).toEqual([30, 28, 20]);
    expect(r.total).toBe(78);
  });
});

describe("defaultIlcaIntake", () => {
  it("selects July intake of current year during Jan-Jun", () => {
    const march = new Date("2026-03-15T00:00:00Z");
    expect(defaultIlcaIntake(march)).toEqual({ kind: "july", year: 2026 });
    expect(ilcaSquadCutoff("july", 2026).asOf).toBe("2026-06-30");
  });

  it("selects January intake of next year during Jul-Dec", () => {
    const september = new Date("2026-09-19T00:00:00Z");
    expect(defaultIlcaIntake(september)).toEqual({ kind: "january", year: 2027 });
    const cutoff = ilcaSquadCutoff("january", 2027);
    expect(cutoff.asOf).toBe("2026-12-31");

    // Regatta held in September 2026 is included in the ranking window
    const regattas = [
      {
        id: "snsc-ilca4",
        name: "SNSC ILCA 4 (Sep 26)",
        date: "2026-09-15",
        totalFleetSize: 46,
        boatClass: "ILCA 4",
        countsForRanking: true,
        raceCount: 6,
      },
    ];
    const window = ilcaRankingRegattas(regattas, "ILCA 4", cutoff.asOf);
    expect(window).toHaveLength(1);
    expect(window[0].id).toBe("snsc-ilca4");
  });
});

describe("ilcaSquadCutoff", () => {
  it("July intake window covers Jan – Jun of the intake year", () => {
    expect(ilcaSquadCutoff("july", 2026)).toEqual({
      asOf: "2026-06-30",
      intakeYear: 2026,
      label: expect.stringContaining("Jan – Jun 2026"),
    });
  });

  it("January intake window covers Jul – Dec of the prior year", () => {
    expect(ilcaSquadCutoff("january", 2027)).toEqual({
      asOf: "2026-12-31",
      intakeYear: 2027,
      label: expect.stringContaining("Jul – Dec 2026"),
    });
  });

  it("January 2027 window includes H2 regattas and excludes the next year", () => {
    const regattas = [
      { id: "jun", name: "Jun Regatta", date: "2026-06-20", totalFleetSize: 40, boatClass: "ILCA 4", countsForRanking: true, raceCount: 6 },
      { id: "sep", name: "Sep Regatta", date: "2026-09-15", totalFleetSize: 46, boatClass: "ILCA 4", countsForRanking: true, raceCount: 6 },
      { id: "jan-next", name: "Jan Next Year", date: "2027-01-10", totalFleetSize: 40, boatClass: "ILCA 4", countsForRanking: true, raceCount: 6 },
    ];
    const window = ilcaRankingRegattas(regattas, "ILCA 4", ilcaSquadCutoff("january", 2027).asOf);
    // Returned oldest → newest; H2 regatta included, next-year regatta excluded
    expect(window.map((r) => r.id)).toEqual(["jun", "sep"]);
  });

  it("July 2026 window excludes H2 regattas", () => {
    const regattas = [
      { id: "jun", name: "Jun Regatta", date: "2026-06-20", totalFleetSize: 40, boatClass: "ILCA 4", countsForRanking: true, raceCount: 6 },
      { id: "sep", name: "Sep Regatta", date: "2026-09-15", totalFleetSize: 46, boatClass: "ILCA 4", countsForRanking: true, raceCount: 6 },
    ];
    const window = ilcaRankingRegattas(regattas, "ILCA 4", ilcaSquadCutoff("july", 2026).asOf);
    expect(window.map((r) => r.id)).toEqual(["jun"]);
  });
});

describe("ageInIntakeYear", () => {
  it("uses age as of 31 Dec intake year", () => {
    // Born mid-2010 → 16 at end of 2026
    expect(ageInIntakeYear("2010-06-15", 2026)).toBe(16);
  });
});

describe("ilcaRegattaCountsForRanking", () => {
  it("excludes explicit non-ranking", () => {
    expect(
      ilcaRegattaCountsForRanking({
        boatClass: "ILCA 4",
        countsForRanking: false,
        raceCount: 6,
      })
    ).toBe(false);
  });

  it("excludes ILCA with fewer than min races", () => {
    expect(ILCA_MIN_RACES_FOR_RANKING).toBe(3);
    expect(
      ilcaRegattaCountsForRanking({
        boatClass: "ILCA 4",
        countsForRanking: true,
        raceCount: 2,
      })
    ).toBe(false);
    expect(
      ilcaRegattaCountsForRanking({
        boatClass: "ILCA 4",
        countsForRanking: true,
        raceCount: 3,
      })
    ).toBe(true);
  });

  it("allows ranking when raceCount unknown", () => {
    expect(
      ilcaRegattaCountsForRanking({
        boatClass: "ILCA 4",
        countsForRanking: true,
        raceCount: null,
      })
    ).toBe(true);
  });
});

describe("ilcaRankingRegattas", () => {
  it("skips low race-count events", () => {
    const window = ilcaRankingRegattas(
      [
        {
          id: "a",
          name: "Short",
          date: "2026-05-01",
          totalFleetSize: 20,
          boatClass: "ILCA 4",
          countsForRanking: true,
          raceCount: 1,
        },
        {
          id: "b",
          name: "Full",
          date: "2026-06-01",
          totalFleetSize: 20,
          boatClass: "ILCA 4",
          countsForRanking: true,
          raceCount: 5,
        },
      ],
      "ILCA 4",
      "2026-06-30"
    );
    expect(window.map((r) => r.id)).toEqual(["b"]);
  });
});

describe("computeIlcaRankings + squad", () => {
  const regattas = [
    {
      id: "r1",
      name: "A",
      date: "2026-03-01",
      totalFleetSize: 10,
      boatClass: "ILCA 4",
      countsForRanking: true,
    },
    {
      id: "r2",
      name: "B",
      date: "2026-04-01",
      totalFleetSize: 10,
      boatClass: "ILCA 4",
      countsForRanking: true,
    },
    {
      id: "r3",
      name: "C",
      date: "2026-05-01",
      totalFleetSize: 10,
      boatClass: "ILCA 4",
      countsForRanking: true,
    },
  ];

  const sailors = [
    {
      id: "m1",
      name: "Male1",
      gender: "M",
      dob: "2012-01-01", // 14 in 2026
      nationality: "SGP",
    },
    {
      id: "f1",
      name: "Female1",
      gender: "F",
      dob: "2012-01-01",
      nationality: "SGP",
    },
    {
      id: "m2",
      name: "Male2",
      gender: "M",
      dob: "2010-01-01", // 16 in 2026
      nationality: "SGP",
    },
  ];

  const results = [
    { sailorId: "m1", regattaId: "r1", rank: 1 },
    { sailorId: "m1", regattaId: "r2", rank: 1 },
    { sailorId: "m1", regattaId: "r3", rank: 1 },
    { sailorId: "f1", regattaId: "r1", rank: 2 },
    { sailorId: "f1", regattaId: "r2", rank: 2 },
    { sailorId: "f1", regattaId: "r3", rank: 2 },
    { sailorId: "m2", regattaId: "r1", rank: 3 },
    { sailorId: "m2", regattaId: "r2", rank: 3 },
    { sailorId: "m2", regattaId: "r3", rank: 3 },
  ];

  it("ranks by high points best 3 of 5", () => {
    const ranked = computeIlcaRankings(
      "ILCA 4",
      "2026-06-30",
      sailors,
      regattas,
      results,
      { intakeYear: 2026, restrictToNationalList: false }
    );
    expect(ranked[0]?.sailorId).toBe("m1");
    // 1st in fleet of 10 → 10 pts × 3 = 30
    expect(ranked[0]?.totalPoints).toBe(30);
    expect(ranked[1]?.totalPoints).toBe(27); // 9×3
  });

  it("selects squad with gender and birth-year buckets (SGP only)", () => {
    const ranked = computeIlcaRankings(
      "ILCA 4",
      "2026-06-30",
      sailors,
      regattas,
      results,
      { intakeYear: 2026, restrictToNationalList: false }
    );
    const squad = selectIlca4NationalSquad(ranked);
    expect(squad.some((s) => s.sailorId === "m1")).toBe(true);
    expect(squad.some((s) => s.sailorId === "f1")).toBe(true);
    expect(squad.length).toBeLessThanOrEqual(16);
  });

  it("excludes non-SGP from squad", () => {
    const withNat = sailors.map((s) =>
      s.id === "m1"
        ? { ...s, nationality: "THA" }
        : { ...s, nationality: "SGP" }
    );
    const ranked = computeIlcaRankings(
      "ILCA 4",
      "2026-06-30",
      withNat,
      regattas,
      results,
      { intakeYear: 2026, restrictToNationalList: false }
    );
    const squad = selectIlca4NationalSquad(ranked);
    expect(squad.some((s) => s.sailorId === "m1")).toBe(false);
  });

  it("excludes a top-ranked sailor whose birth year is unknown", () => {
    const missingAge: IlcaRankedSailor = {
      sailorId: "missing-age",
      name: "Missing Age",
      gender: "M",
      birthYear: null,
      ageInIntakeYear: null,
      nationality: "SGP",
      eventScores: [],
      bestThreePoints: [30, 30, 30],
      totalPoints: 90,
      rank: 1,
    };

    expect(selectIlca4NationalSquad([missingAge])).toEqual([]);
  });

  it("includes national-list sailors with no results at 0 points", () => {
    const roster = [
      ...sailors.map((s) => ({ ...s, ilca4NationalList: true })),
      {
        id: "absent",
        name: "No Start",
        gender: "M",
        dob: "2012-01-01",
        nationality: "SGP",
        ilca4NationalList: true,
      },
    ];
    const ranked = computeIlcaRankings(
      "ILCA 4",
      "2026-06-30",
      roster,
      regattas,
      results,
      { intakeYear: 2026, restrictToNationalList: true }
    );
    const absent = ranked.find((r) => r.sailorId === "absent");
    expect(absent).toBeTruthy();
    expect(absent?.totalPoints).toBe(0);
    expect(absent?.eventScores.every((e) => e.points === 0 && e.isDns)).toBe(
      true
    );
  });

  it("re-ranks correctly when a regatta is excluded", () => {
    const ranked = computeIlcaRankings(
      "ILCA 4",
      "2026-06-30",
      sailors,
      regattas,
      results,
      { intakeYear: 2026, restrictToNationalList: false }
    );
    // Exclude r1 (where m1 got 10 points)
    const reranked = reRankIlcaWithExcluded(ranked, new Set(["r1"]));
    expect(reranked).toBeDefined();
    const m1 = reranked.find((r) => r.sailorId === "m1");
    // m1 had r1=10, r2=10, r3=10 (total 30). Excluding r1 leaves r2=10, r3=10 (total 20)
    expect(m1?.totalPoints).toBe(20);
    expect(m1?.bestThreePoints).toEqual([10, 10, 0]);
  });

  it("formats squadReasonLabel correctly", () => {
    expect(squadReasonLabel("top2_overall")).toBe("Nat (Overall)");
    expect(squadReasonLabel("age16")).toBe("Nat (Age 16)");
    expect(squadReasonLabel("age15_or_under")).toBe("Nat (≤15)");
    expect(squadReasonLabel("fill_same_gender")).toBe("Nat (Invited)");
  });

  it("computes ILCA 6 ranking using ILCA 6 national list", () => {
    const ilca6Sailors = [
      { id: "s1", name: "Tan, Kenan Kee Zen", gender: "M", nationality: "SGP" },
      { id: "s2", name: "Non List Sailor", gender: "M", nationality: "SGP" },
    ];
    const ilca6Regattas = [
      { id: "r1", name: "Regatta 1", date: "2026-03-01", totalFleetSize: 10, boatClass: "ILCA 6", countsForRanking: true, raceCount: 4 },
    ];
    const ilca6Results = [
      { regattaId: "r1", sailorId: "s1", rank: 1, nettScore: 4, totalScore: 4, isDns: false },
      { regattaId: "r1", sailorId: "s2", rank: 2, nettScore: 5, totalScore: 5, isDns: false },
    ];

    const ranked = computeIlcaRankings("ILCA 6", "2026-06-30", ilca6Sailors, ilca6Regattas, ilca6Results);
    // Non-list sailor is excluded by default on national ranking board
    expect(ranked.some((r) => r.sailorId === "s1")).toBe(true);
    expect(ranked.some((r) => r.sailorId === "s2")).toBe(false);
  });

  it("computes ILCA 7 ranking directly from regatta performance without national list", () => {
    const ilca7Sailors = [
      { id: "s1", name: "Standard Sailor One", gender: "M", nationality: "SGP" },
      { id: "s2", name: "Standard Sailor Two", gender: "M", nationality: "SGP" },
    ];
    const ilca7Regattas = [
      { id: "r1", name: "Regatta 1", date: "2026-03-01", totalFleetSize: 10, boatClass: "ILCA 7", countsForRanking: true, raceCount: 4 },
    ];
    const ilca7Results = [
      { regattaId: "r1", sailorId: "s1", rank: 1, nettScore: 4, totalScore: 4, isDns: false },
      { regattaId: "r1", sailorId: "s2", rank: 2, nettScore: 5, totalScore: 5, isDns: false },
    ];

    const ranked = computeIlcaRankings("ILCA 7", "2026-06-30", ilca7Sailors, ilca7Regattas, ilca7Results);
    expect(ranked.length).toBe(2);
    expect(ranked[0].sailorId).toBe("s1");
    expect(ranked[0].rank).toBe(1);
    expect(ranked[1].sailorId).toBe("s2");
    expect(ranked[1].rank).toBe(2);
  });
});


