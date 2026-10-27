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
      { categoryName: "Asian", rank: 3, medal: "bronze", sailNumber: "SGP 159" },
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
    expect(getPrizeDefinitionsForSheet({ slug: "2026-optimist-european-championship-boys", boatClass: "Optimist", division: "Boys" })?.fleets[0].fleetName).toBe("Optimist Boys");
    expect(getPrizeDefinitionsForSheet({ slug: "2026-ilca-4-youth-worlds-boys", boatClass: "ILCA 4", division: "Boys" })?.fleets[0].fleetName).toBe("ILCA 4 Boys");
    expect(getRegattaPrizeSchedule("optimist-asian-oceanian-thailand-selection-trials-2026-optimist")).toBeNull();
    expect(getPrizeDefinitionsForSheet({ slug: "2026-ilca-4-youth-worlds-girls", boatClass: "ILCA 4", division: "Girls" })?.fleets[0].fleetName).toBe("ILCA 4 Girls");
  });
  it("preserves the Worlds overall prizes alongside girls' prizes", () => {
    const schedule = getRegattaPrizeSchedule("2026-optimist-world-championship-overall")!;
    const filled = fillUnlistedPrizeWinners(schedule.fleets, [
      { sailorName: "Manuel Bragança", handle: "manuel-braganca-worlds26-fc4e07", rank: 1 },
      { sailorName: "Ines Mendez Larminaux", handle: "ines-mendez-larminaux-hkrw-80c3e8", rank: 6 },
    ], 2026);
    expect(filled[0].categories.map((c) => c.categoryName)).toEqual(expect.arrayContaining(["Open", "Girls"]));
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


describe("remaining championship categories", () => {
  it("counts a fleet podium using its category rank, not its colour or overall position", () => {
    const awards = getSailorPrizes({ name: "Eren Kaan Erendemir", handle: "eren-kaan-erendemir-worlds26-52181c" });
    expect(awards).toMatchObject([{ categoryName: "Silver Fleet", rank: 1, medal: "gold", notes: "Overall position 72; 134 points nett." }]);
    const bronze = getSailorPrizes({ name: "Jonny Jaap Seekamp", handle: "jonny-jaap-seekamp-worlds26-d9ef32" });
    expect(bronze[0].medal).toBe("bronze");
  });
  it("uses continental eligibility independently of the open podium", () => {
    const categories = getRegattaPrizeSchedule("2025-optimist-asian-oceanian-championship-overall")!.fleets[0].categories;
    expect(categories.find((c) => c.categoryName === "Asian")!.winners.map((w) => w.sailorName)).toEqual(["Sorawit Naksuk", "Ethan Chia Han Wei", "Anya Alessia Zahedi"]);
    expect(categories.find((c) => c.categoryName === "Oceanian")!.winners.map((w) => w.sailorName)).toEqual(["William Harris", "Balthazar Roche", "Jeffrey Chenglin Du"]);
    const reportAward = getSailorPrizes({ name: "Kornelia Pajak", handle: "asian-uae-kornelia-p-748bbf" }).find((a) => a.categoryName === "Silver Fleet")!;
    expect(reportAward.isOfficialNoR).toBe(false);
    expect(reportAward.sourceUrl).toContain("sail-world.com/news/291403");
  });
  it("links U16 podiums without inferring ages from profiles", () => {
    const award = getSailorPrizes({ name: "Xuacu García Rigo", handle: "ilca4-worlds26-esp-xuacu-garc-a-rigo-967f4c" })[0];
    expect(award).toMatchObject({ categoryName: "Boys U16", rank: 1, prizeTitle: "U16 Boys’ World Champion" });
    const penghu = getRegattaPrizeSchedule("2026-ilca-asian-cup-ilca4")!.fleets[0].categories.find((c) => c.categoryName === "Boys U16")!;
    expect(penghu.winners.map((w) => w.sailorHandle)).toEqual(["ilca4-worlds26-kor-jiun-choi-614785", "lim-yuk-jun", "austin-lee-thai25-554015"]);
  });
  it("keeps named world-champion trophies in the same first-place honour", () => {
    const schedule = getRegattaPrizeSchedule("2026-optimist-world-championship-overall")!;
    const filled = fillUnlistedPrizeWinners(schedule.fleets, [{ sailorName: "Manuel Bragança", handle: "manuel-braganca-worlds26-fc4e07", rank: 1 }], 2026);
    expect(filled[0].categories[0].winners[0].prizeTitle).toContain("Peter Barclay Trophy");
    expect(filled[0].categories[0].winners[0].prizeTitle).toContain("Beacon Challenge Cup");
  });
  it("links 20th Asian Games 2026 medalists to sailor profiles across ILCA 4, ILCA 6, ILCA 7, 29er, and iQFOiL", () => {
    const ianGoh = getSailorPrizes({ name: "Ian Goh", handle: "ian-goh", sailNumberIlca4: "222713" });
    expect(ianGoh).toEqual(expect.arrayContaining([
      expect.objectContaining({ regattaSlug: "20th-asian-games-2026-ilca4", rank: 2, medal: "silver", prizeTitle: "Silver Medal (2nd Boy)" }),
    ]));

    const janiaAng = getSailorPrizes({ name: "Jania Ang", handle: "jania-ang" });
    expect(janiaAng).toEqual(expect.arrayContaining([
      expect.objectContaining({ regattaSlug: "20th-asian-games-2026-ilca6", rank: 2, medal: "silver", prizeTitle: "Silver Medal" }),
    ]));

    const johnWong = getSailorPrizes({ name: "John Wong Tze Xiang", handle: "john-tze-xiang-wong-acb2ce" });
    expect(johnWong).toEqual(expect.arrayContaining([
      expect.objectContaining({ regattaSlug: "20th-asian-games-2026-iqfoil", rank: 3, medal: "bronze", prizeTitle: "Bronze Medal" }),
    ]));

    const seanKumNigelTan = getSailorPrizes({ name: "Sean Kum Kok Wei / Nigel Tan Xu Yuan", handle: "sean-kum-nigel-tan-2472" });
    expect(seanKumNigelTan).toEqual(expect.arrayContaining([
      expect.objectContaining({ regattaSlug: "20th-asian-games-2026-29er", rank: 2, medal: "silver", prizeTitle: "Silver Medal" }),
    ]));
  });
});
