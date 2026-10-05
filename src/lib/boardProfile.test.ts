import { describe, expect, it } from "vitest";
import {
  boardDisciplineOf,
  pickInitialProfileClass,
  summarizeBoardClass,
} from "./boardProfile";

describe("boardDisciplineOf", () => {
  it("keeps Windsurfing apart from WingFoil", () => {
    expect(boardDisciplineOf("Windsurfing LT")).toBe("windsurfing");
    expect(boardDisciplineOf("Windsurfing")).toBe("windsurfing");
    expect(boardDisciplineOf("WingFoil")).toBe("wingfoil");
    expect(boardDisciplineOf("Wing Foil")).toBe("wingfoil");
    expect(boardDisciplineOf("Techno 293")).toBe("techno293");
    expect(boardDisciplineOf("iQFOiL")).toBe("iqfoil");
    expect(boardDisciplineOf("Optimist")).toBeNull();
    expect(boardDisciplineOf("ILCA 4")).toBeNull();
  });
});

describe("summarizeBoardClass", () => {
  it("counts the latest season and uses a real best finish", () => {
    const summary = summarizeBoardClass("techno293", [
      {
        boatClass: "Techno 293",
        regattaId: "a",
        regattaName: "NSC Cup 2024",
        regattaDate: "2024-11-30",
        rank: 2,
        division: "U17",
      },
      {
        boatClass: "Techno 293",
        regattaId: "b",
        regattaName: "SNSC 2025",
        regattaDate: "2025-09-06",
        rank: 1,
        division: "U17",
      },
      {
        boatClass: "Techno 293",
        regattaId: "c",
        regattaName: "NSC Cup 2 2025",
        regattaDate: "2025-05-31",
        rank: 4,
        division: "U17",
      },
      {
        boatClass: "Techno 293",
        regattaId: "d",
        regattaName: "DNS event",
        regattaDate: "2025-06-01",
        rank: 12,
        isDns: true,
        division: "U17",
      },
    ]);

    expect(summary.label).toBe("Techno 293");
    expect(summary.seasonYear).toBe(2025);
    expect(summary.seasonEventCount).toBe(3);
    expect(summary.bestFinishLabel).toBe("1st");
    expect(summary.bestFinishEvent).toBe("SNSC 2025");
    expect(summary.sharedDivision).toBe("U17");
    expect(summary).not.toHaveProperty("nationalRank");
  });

  it("labels Windsurfing LT and skips a division when the results disagree", () => {
    const summary = summarizeBoardClass("windsurfing", [
      {
        boatClass: "Windsurfing LT",
        regattaId: "w1",
        regattaName: "NSC Cup 2024",
        regattaDate: "2024-11-30",
        rank: 3,
        division: "U17",
      },
      {
        boatClass: "Windsurfing LT",
        regattaId: "w2",
        regattaName: "Later cup",
        regattaDate: "2024-12-01",
        rank: 1,
        division: "U15",
      },
    ]);
    expect(summary.label).toBe("Windsurfing LT");
    expect(summary.bestFinishLabel).toBe("1st");
    expect(summary.sharedDivision).toBeNull();
  });

  it("does not invent a finish when every result is DNS", () => {
    const summary = summarizeBoardClass(
      "wingfoil",
      [
        {
          boatClass: "WingFoil",
          regattaId: "wf",
          regattaName: "SNSC",
          regattaDate: "2026-09-05",
          isDns: true,
          rank: 8,
        },
      ],
      2026
    );
    expect(summary.bestFinish).toBeNull();
    expect(summary.bestFinishLabel).toBeNull();
    expect(summary.seasonEventCount).toBe(1);
  });
});

describe("pickInitialProfileClass", () => {
  it("opens a Techno sailor on Techno even when an older Optimist result exists", () => {
    expect(
      pickInitialProfileClass([
        { boatClass: "Optimist", regattaDate: "2022-03-01" },
        { boatClass: "Techno 293", regattaDate: "2025-09-06" },
      ])
    ).toBe("techno293");
  });

  it("does not treat a blank boat class as a board class", () => {
    expect(
      pickInitialProfileClass([{ boatClass: "", regattaDate: "2026-01-01" }])
    ).toBeNull();
  });
});
