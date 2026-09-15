import { describe, expect, it } from "vitest";
import {
  getNoRDiscardsCount,
  calculateWingfoilSeries,
  isNEMonsoonSeriesRegatta,
} from "./wingfoilSeries";
import type { WingfoilRegatta } from "./wingfoil";

describe("getNoRDiscardsCount", () => {
  it("matches the official Singapore Sailing NoR Clause 12.5.2 discard table", () => {
    expect(getNoRDiscardsCount(1)).toBe(0);
    expect(getNoRDiscardsCount(4)).toBe(0);
    expect(getNoRDiscardsCount(5)).toBe(1);
    expect(getNoRDiscardsCount(8)).toBe(1);
    expect(getNoRDiscardsCount(9)).toBe(2);
    expect(getNoRDiscardsCount(12)).toBe(2);
    expect(getNoRDiscardsCount(16)).toBe(3);
    expect(getNoRDiscardsCount(20)).toBe(4); // 20 races in GP1 = 4 discards in series!
    expect(getNoRDiscardsCount(25)).toBe(5);
    expect(getNoRDiscardsCount(30)).toBe(6);
    expect(getNoRDiscardsCount(38)).toBe(7);
    expect(getNoRDiscardsCount(46)).toBe(8);
    expect(getNoRDiscardsCount(54)).toBe(9);
    expect(getNoRDiscardsCount(62)).toBe(10);
    expect(getNoRDiscardsCount(70)).toBe(11);
    expect(getNoRDiscardsCount(72)).toBe(12);
  });
});

describe("calculateWingfoilSeries", () => {
  const dummyGP1: WingfoilRegatta = {
    id: "ne-monsoon-series-gp1-2026",
    name: "2026 Northeast Monsoon Grand Prix 1 (Round 1 of 3)",
    shortName: "NE Monsoon GP1",
    dates: "10-11 Jan 2026",
    venue: "ECP",
    organizer: "SSF & WAS",
    format: "Sprint Slalom",
    status: "Completed",
    scoringSystem: "Appendix A",
    rulesNotes: "Round 1",
    seriesName: "2026 Northeast Monsoon Grand Prix Series",
    results: [
      {
        rank: 1,
        name: "Jun Hao Lo",
        sailNumber: "43",
        gender: "M",
        ageCategory: "Open",
        schoolName: "",
        club: "",
        races: [{ score: 1 }, { score: 1 }, { score: 1 }, { score: 1 }, { score: 1 }],
        grossScore: 5,
        nettScore: 4,
      },
      {
        rank: 2,
        name: "Wearn Haw Tan",
        sailNumber: "29",
        gender: "M",
        ageCategory: "Master",
        schoolName: "",
        club: "",
        races: [{ score: 2 }, { score: 2 }, { score: 1 }, { score: 2 }, { score: 2 }],
        grossScore: 9,
        nettScore: 7,
      },
      {
        rank: 3,
        name: "Alice Lim",
        sailNumber: "99",
        gender: "F",
        ageCategory: "16&U",
        schoolName: "",
        club: "",
        races: [{ score: 3 }, { score: 3 }, { score: 3 }, { score: 3 }, { score: 3 }],
        grossScore: 15,
        nettScore: 12,
      },
    ],
  };

  const dummyGP2: WingfoilRegatta = {
    id: "ne-monsoon-series-gp2-2026",
    name: "2026 Northeast Monsoon Grand Prix 2 (Round 2 of 3)",
    shortName: "NE Monsoon GP2",
    dates: "31 Jan - 1 Feb 2026",
    venue: "Changi",
    organizer: "SSF & WAS",
    format: "Sprint Slalom",
    status: "Completed",
    scoringSystem: "Appendix A",
    rulesNotes: "Round 2",
    seriesName: "2026 Northeast Monsoon Grand Prix Series",
    results: [
      {
        rank: 1,
        name: "Wearn Haw Tan",
        sailNumber: "29",
        gender: "M",
        ageCategory: "Master",
        schoolName: "",
        club: "",
        races: [{ score: 1 }, { score: 1 }, { score: 1 }],
        grossScore: 3,
        nettScore: 3,
      },
      {
        rank: 2,
        name: "Jun Hao Lo",
        sailNumber: "43",
        gender: "M",
        ageCategory: "Open",
        schoolName: "",
        club: "",
        races: [{ score: 2 }, { score: 2 }, { score: 2 }],
        grossScore: 6,
        nettScore: 6,
      },
      // Alice Lim did not attend GP2
    ],
  };

  it("aggregates races across rounds and correctly assigns DNC penalty to non-attendees", () => {
    const series = calculateWingfoilSeries([dummyGP1, dummyGP2]);

    expect(series.totalRacesCompleted).toBe(8); // 5 in GP1 + 3 in GP2
    expect(series.discardsApplied).toBe(1); // 8 races = 1 discard
    expect(series.competitors).toHaveLength(3);

    // Jun Hao Lo: GP1: [1, 1, 1, 1, 1], GP2: [2, 2, 2] -> 8 races
    const junHao = series.competitors.find((c) => c.name === "Jun Hao Lo");
    expect(junHao).toBeDefined();
    expect(junHao?.races).toHaveLength(8);
    // Worst score is 2, 1 discard -> nett = gross (11) - 2 = 9
    expect(junHao?.nettScore).toBe(9);

    // Wearn Haw Tan: GP1: [2, 2, 1, 2, 2], GP2: [1, 1, 1] -> 8 races
    // Gross: 9 + 3 = 12. Worst is 2, 1 discard -> nett = 12 - 2 = 10
    const wearnHaw = series.competitors.find((c) => c.name === "Wearn Haw Tan");
    expect(wearnHaw).toBeDefined();
    expect(wearnHaw?.nettScore).toBe(10);

    // Jun Hao wins with lower nett score (9 vs 10)
    expect(series.competitors[0].name).toBe("Jun Hao Lo");
    expect(series.competitors[1].name).toBe("Wearn Haw Tan");

    // Alice Lim did not attend GP2 (which had 2 attendees).
    // NoR 12.3.2: Non-attendee scores attendeeCount + 2 = 2 + 2 = 4 for each race in GP2!
    const alice = series.competitors.find((c) => c.name === "Alice Lim");
    expect(alice).toBeDefined();
    expect(alice?.roundsAttended).toEqual(["ne-monsoon-series-gp1-2026"]);
    // GP1 (5 races): [3, 3, 3, 3, 3]
    // GP2 (3 races): [4 (DNC), 4 (DNC), 4 (DNC)]
    const dncRaces = alice?.races.filter((r) => r.code === "DNC");
    expect(dncRaces).toHaveLength(3);
    expect(dncRaces?.[0].score).toBe(4);
  });

  it("extracts division champions per NoR 16.1", () => {
    const series = calculateWingfoilSeries([dummyGP1, dummyGP2]);

    expect(series.divisionChampions.open?.name).toBe("Jun Hao Lo");
    expect(series.divisionChampions.masters?.name).toBe("Wearn Haw Tan");
    expect(series.divisionChampions.women?.name).toBe("Alice Lim");
    expect(series.divisionChampions.youthU16?.name).toBe("Alice Lim");
  });
});
