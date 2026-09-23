import { describe, expect, it } from "vitest";
import { getPrizeWinnersForRegatta, inferPrizeFleetName } from "./regattaPrizes";

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
  });

  it("maps the Pesta Sukan Silver slug to the official Silver prize winners", () => {
    const view = getPrizeWinnersForRegatta("pesta-sukan-silver-aug-26-2026-08-01");
    expect(view).not.toBeNull();
    expect(view!.fleets[0].fleetName).toBe("Optimist Silver Fleet");
    const open = view!.fleets[0].categories.find((c) => c.categoryName === "Open");
    expect(open?.winners[0].sailorName).toBe("Bryan Thian Tsek Lee");
  });

  it("does not show ILCA 4 prizes for ILCA 6 or 29er slugs", () => {
    expect(inferPrizeFleetName("snsc-ilca-6-sep-26-2026-09-11")).toBe("ILCA 6");
    expect(inferPrizeFleetName("snsc-29er-sep-26-2026-09-11")).toBe("29er");
    expect(getPrizeWinnersForRegatta("snsc-ilca-6-sep-26-2026-09-11")).toBeNull();
    expect(getPrizeWinnersForRegatta("snsc-29er-sep-26-2026-09-11")).toBeNull();
    const cincapuraIlca6 = getPrizeWinnersForRegatta("cincapura-ilca-6-jul-26-2026-07-18");
    expect(cincapuraIlca6?.fleets[0].fleetName).toBe("ILCA 6");
    expect(cincapuraIlca6?.fleets[0].categories[0].winners[0].sailorName).toBe(
      "Sarah Rui-En Yong"
    );
  });

  it("can select one fleet on the event slug", () => {
    const view = getPrizeWinnersForRegatta("snsc-2026", "WingFoil");
    expect(view).not.toBeNull();
    expect(view!.fleets.map((fleet) => fleet.fleetName)).toEqual(["WingFoil"]);
    expect(view!.fleets[0].categories.length).toBeGreaterThan(0);
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
