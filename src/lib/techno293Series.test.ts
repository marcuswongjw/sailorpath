import { describe, expect, it } from "vitest";
import {
  getNoRDiscardsCount,
  calculateTechno293SeriesResults,
  isTechno293SailorInDivision,
  OFFICIAL_TECHNO293_DIVISIONS,
} from "./techno293Series";
import { SINGAPORE_TECHNO293_REGATTAS } from "./techno293";

describe("Techno 293 Series Scoring Engine", () => {
  it("computes official NoR clause 12.5.2 discards schedule", () => {
    expect(getNoRDiscardsCount(3)).toBe(0);
    expect(getNoRDiscardsCount(4)).toBe(0);
    expect(getNoRDiscardsCount(5)).toBe(1);
    expect(getNoRDiscardsCount(8)).toBe(1);
    expect(getNoRDiscardsCount(9)).toBe(2);
    expect(getNoRDiscardsCount(12)).toBe(2);
    expect(getNoRDiscardsCount(13)).toBe(3);
    expect(getNoRDiscardsCount(16)).toBe(3);
    expect(getNoRDiscardsCount(17)).toBe(4);
    expect(getNoRDiscardsCount(20)).toBe(4);
    expect(getNoRDiscardsCount(25)).toBe(5);
  });

  it("evaluates sailor eligibility for divisions", () => {
    expect(
      isTechno293SailorInDivision(
        { name: "Trevor Ng", ageCategory: "U17", gender: "M" },
        "open"
      )
    ).toBe(true);

    expect(
      isTechno293SailorInDivision(
        { name: "Trevor Ng", ageCategory: "U17", gender: "M" },
        "u17"
      )
    ).toBe(true);

    expect(
      isTechno293SailorInDivision(
        { name: "Axl Tan", ageCategory: "Open", gender: "M" },
        "u17"
      )
    ).toBe(false);

    expect(
      isTechno293SailorInDivision(
        { name: "Kate Teo", ageCategory: "Open", gender: "F" },
        "women"
      )
    ).toBe(true);
  });

  it("calculates cumulative series across GP1 and GP2 correctly", () => {
    const series = calculateTechno293SeriesResults(SINGAPORE_TECHNO293_REGATTAS);

    // GP1 (8 races) + GP2 (9 races) = 17 races
    expect(series.totalRacesCompleted).toBe(17);
    expect(series.discardsApplied).toBe(4);
    expect(series.competitors.length).toBe(8);

    // Trevor Ng should be 1st overall in series
    const leader = series.competitors[0];
    expect(leader.name).toBe("Trevor Ng");
    expect(leader.rank).toBe(1);

    // Addy Armand Anuar should be 2nd
    const second = series.competitors[1];
    expect(second.name).toBe("Addy Armand Anuar");
    expect(second.rank).toBe(2);
  });

  it("enforces minimum 3 competitors requirement for division constitution per NoR 4.2", () => {
    const series = calculateTechno293SeriesResults(SINGAPORE_TECHNO293_REGATTAS);

    const openDiv = series.divisions.find((d) => d.division.id === "open");
    expect(openDiv).toBeDefined();
    expect(openDiv?.isConstituted).toBe(true);
    expect(openDiv?.competitorCount).toBe(8);
    expect(openDiv?.champion?.name).toBe("Trevor Ng");

    const u17Div = series.divisions.find((d) => d.division.id === "u17");
    expect(u17Div).toBeDefined();
    expect(u17Div?.isConstituted).toBe(true);
    expect(u17Div?.competitorCount).toBe(5); // Trevor, Addy, Shan Qi, Eunice, Kerraine
    expect(u17Div?.champion?.name).toBe("Trevor Ng");

    const womenDiv = series.divisions.find((d) => d.division.id === "women");
    expect(womenDiv).toBeDefined();
    // Kate, Eunice, Kerraine = 3 competitors => constituted!
    expect(womenDiv?.competitorCount).toBe(3);
    expect(womenDiv?.isConstituted).toBe(true);
  });

  it("calculates cumulative NE Monsoon series results across GP1, GP2, and GP3", () => {
    const series = calculateTechno293SeriesResults(SINGAPORE_TECHNO293_REGATTAS, "ne-monsoon");

    // GP1 (11) + GP2 (14) + GP3 (7) = 32 races
    expect(series.totalRacesCompleted).toBe(32);
    // 32 races -> 7 discards per NoR clause 12.5.2
    expect(series.discardsApplied).toBe(7);
    expect(series.competitors.length).toBe(8);

    // Leader of NE series should be Axl Tan
    const leader = series.competitors[0];
    expect(leader.name).toBe("Axl Tan");
    expect(leader.rank).toBe(1);

    // Division champions
    const openDiv = series.divisions.find((d) => d.division.id === "open");
    expect(openDiv?.champion?.name).toBe("Axl Tan");

    const u17Div = series.divisions.find((d) => d.division.id === "u17");
    expect(u17Div?.isConstituted).toBe(true);
    expect(u17Div?.champion?.name).toBe("Trevor Ng");
  });
});
