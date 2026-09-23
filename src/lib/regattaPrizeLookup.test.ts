import { describe, expect, it } from "vitest";
import { getPrizeWinnersForRegatta } from "./regattaPrizes";

describe("getPrizeWinnersForRegatta", () => {
  it("maps the live Cincapura Gold slug to the Gold fleet winners", () => {
    const view = getPrizeWinnersForRegatta("cincapura-regatta-2026-gold");
    expect(view).not.toBeNull();
    expect(view!.schedule.regattaName).toContain("Cincapura");
    expect(view!.fleets).toHaveLength(1);
    expect(view!.fleets[0].fleetName).toBe("Optimist Gold Fleet");
    const open = view!.fleets[0].categories.find(
      (c) => c.categoryName === "Open"
    );
    expect(open?.winners[0].sailorName).toBe("Kyle Jeremy Zhi Jun Soh");
  });

  it("maps the live Cincapura Silver slug to the Silver fleet winners", () => {
    const view = getPrizeWinnersForRegatta("cincapura-regatta-2026-silver");
    expect(view).not.toBeNull();
    expect(view!.fleets).toHaveLength(1);
    expect(view!.fleets[0].fleetName).toBe("Optimist Silver Fleet");
  });

  it("maps the legacy Cincapura Jul-26 slugs as well", () => {
    const view = getPrizeWinnersForRegatta("cincapura-gold-jul-26-2026-07-18");
    expect(view).not.toBeNull();
    expect(view!.fleets[0].fleetName).toBe("Optimist Gold Fleet");
  });

  it("maps the live SNSC ILCA 4 slug to the ILCA 4 prize winners", () => {
    const view = getPrizeWinnersForRegatta("snsc-ilca-4-sep-26-2026-09-11");
    expect(view).not.toBeNull();
    expect(view!.schedule.regattaName).toContain("SNSC");
    expect(view!.fleets).toHaveLength(1);
    expect(view!.fleets[0].fleetName).toBe("ILCA 4");
    const open = view!.fleets[0].categories.find(
      (c) => c.categoryName === "Open"
    );
    expect(open?.winners[0].sailorName).toBe("Goh, Ian");
  });

  it("maps the live Pesta Sukan ILCA4 slug to the ILCA 4 prize winners", () => {
    const view = getPrizeWinnersForRegatta(
      "pesta-sukan-ilca4-aug-26-2026-08-01"
    );
    expect(view).not.toBeNull();
    expect(view!.schedule.regattaName).toContain("Pesta Sukan");
    expect(view!.fleets[0].fleetName).toBe("ILCA 4");
  });

  it("returns null for fleets whose categories have no verified winners yet", () => {
    expect(getPrizeWinnersForRegatta("snsc-gold-sep-26-2026-09-11")).toBeNull();
    expect(
      getPrizeWinnersForRegatta("pesta-sukan-silver-aug-26-2026-08-01")
    ).toBeNull();
  });

  it("returns null for unrelated or empty slugs", () => {
    expect(getPrizeWinnersForRegatta("some-other-regatta-2026")).toBeNull();
    expect(getPrizeWinnersForRegatta("")).toBeNull();
  });

  it("strips categories without winners from fleets that have some", () => {
    const view = getPrizeWinnersForRegatta("snsc-ilca-4-sep-26-2026-09-11");
    for (const fleet of view!.fleets) {
      for (const category of fleet.categories) {
        expect(category.winners.length).toBeGreaterThan(0);
      }
    }
  });
});
