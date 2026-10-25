import { describe, expect, it } from "vitest";
import { getPrizeDefinitionsForSheet, getPrizeWinnersForRegatta, getRegattaPrizeSchedule, hasOverallPrizeWinners } from "./regattaPrizes";
import { getSailorPrizes, mergeSailorPrizes } from "./sailorPrizes";
import { fillUnlistedPrizeWinners } from "./prizeWinnersFromResults";
import { INTERNATIONAL_REGATTA_PRIZE_SCHEDULES } from "./internationalRegattaPrizes";

describe("international girls' awards", () => {
  it("links a mixed-fleet girls' medalist outside the overall podium to her existing profile", () => {
    const awards = getSailorPrizes({ name: "Anya Alessia Zahedi", handle: "anya-alessia-zahedi" }, [{
      regattaSlug: "2025-optimist-asian-oceanian-championship-overall", rank: 4, boatClass: "Optimist", countsForRanking: false,
    }]);
    expect(awards.filter((a) => a.regattaSlug.includes("2025-optimist-asian"))).toMatchObject([
      { categoryName: "Girls", rank: 1, medal: "gold", sailNumber: "SGP 159" },
    ]);
  });
  it("does not attach international awards to a different handle with a similar name", () => {
    expect(getSailorPrizes({ name: "Margaux Nguyen-Minh", handle: "another-margaux" }, [], INTERNATIONAL_REGATTA_PRIZE_SCHEDULES)).toEqual([]);
  });
  it("keeps the open and European girls' podiums distinct", () => {
    const categories = getPrizeWinnersForRegatta("2026-optimist-european-championship-girls")!.fleets[0].categories;
    expect(categories[0].winners[2].sailorName).toBe("Morgan Rosenthal");
    expect(categories[1].winners[2].sailorName).toBe("Barbara Gmurek");
    const maria = getSailorPrizes({ name: "Maria De Lluc Bestard", handle: "maria-de-lluc-bestard-euro26-dfd246" }, []);
    expect(maria.filter((a) => a.regattaSlug.includes("european")).map((a) => a.categoryName)).toEqual(["Overall (Girls)", "European Girls"]);
  });
  it("does not use girls' schedules on boys' results sheets or selection trials", () => {
    expect(getPrizeDefinitionsForSheet({ slug: "2026-optimist-european-championship-girls", boatClass: "Optimist", division: "Boys" })).toBeNull();
    expect(getRegattaPrizeSchedule("2026-optimist-european-championship-boys")).toBeNull();
    expect(getRegattaPrizeSchedule("2026-ilca-4-youth-worlds-boys")).toBeNull();
    expect(getRegattaPrizeSchedule("optimist-asian-oceanian-thailand-selection-trials-2026-optimist")).toBeNull();
    expect(getPrizeDefinitionsForSheet({ slug: "2026-ilca-4-youth-worlds-girls", boatClass: "ILCA 4", division: "Girls" })?.fleets[0].fleetName).toBe("ILCA 4 Girls");
  });
  it("preserves the Worlds overall prizes alongside girls' prizes", () => {
    const schedule = getRegattaPrizeSchedule("2026-optimist-world-championship-overall")!;
    const filled = fillUnlistedPrizeWinners(schedule.fleets, [
      { sailorName: "Manuel Bragança", handle: "manuel-braganca-worlds26-fc4e07", rank: 1 },
      { sailorName: "Ines Mendez Larminaux", handle: "ines-mendez-larminaux-hkrw-80c3e8", rank: 6 },
    ], 2026);
    expect(filled[0].categories.map((c) => c.categoryName)).toEqual(["Open", "Girls"]);
    expect(filled[0].categories[0].prizesAwarded).toBe("1st to 20th");
    expect(hasOverallPrizeWinners(filled)).toBe(true);
  });
  it("keeps the recorded overall podium visible for girls-only category additions", () => {
    const penghu = getRegattaPrizeSchedule("2026-ilca-asian-cup-ilca4")!;
    expect(hasOverallPrizeWinners(penghu.fleets)).toBe(false);
    expect(penghu.fleets[0].categories[0].winners.map((w) => w.sailorName)).toEqual(["Pinchanok Klaysomboon", "Songha Lee", "Mika Tew"]);
    const awards = getSailorPrizes({ name: "Mika Tew", handle: "mika-tew-0741h6l" }, []);
    expect(awards.filter((a) => a.regattaSlug === penghu.regattaSlug).map((a) => [a.categoryName, a.rank])).toEqual([["Girls U16", 2], ["Girls U18", 3]]);
  });
  it("suppresses a duplicate recorded podium while retaining the separate European honour", () => {
    const sailor = { name: "Maria De Lluc Bestard", handle: "maria-de-lluc-bestard-euro26-dfd246" };
    const awards = getSailorPrizes(sailor, [{ regattaSlug: "2026-optimist-european-championship-girls", rank: 1, boatClass: "Optimist", division: "Girls" }]);
    expect(mergeSailorPrizes(awards).filter((a) => a.regattaSlug.includes("european"))).toHaveLength(2);
  });
});
