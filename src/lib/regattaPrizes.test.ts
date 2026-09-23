import { describe, it, expect } from "vitest";
import {
  SNSC_2026_PRIZE_SCHEDULE,
  PESTA_SUKAN_2026_PRIZE_SCHEDULE,
  CINCAPURA_2026_PRIZE_SCHEDULE,
  SAFYC_OPTIMIST_2026_PRIZE_SCHEDULE,
} from "./regattaPrizes";
import {
  CINCAPURA_2026_GOLD_RESULTS,
  CINCAPURA_2026_SILVER_RESULTS,
} from "./cincapuraResultsData";

describe("regattaPrizes", () => {
  it("defines SNSC 2026 prize categories and winners per NoR", () => {
    expect(SNSC_2026_PRIZE_SCHEDULE.regattaName).toContain("Singapore National Sailing Championships");
    expect(SNSC_2026_PRIZE_SCHEDULE.entryFees.singleHanded).toBe(117);
    expect(SNSC_2026_PRIZE_SCHEDULE.entryFees.doubleHanded).toBe(234);

    const ilca4 = SNSC_2026_PRIZE_SCHEDULE.fleets.find((f) => f.fleetName === "ILCA 4");
    expect(ilca4).toBeDefined();

    const openCat = ilca4?.categories.find((c) => c.categoryName === "Open");
    expect(openCat?.winners[0].sailorName).toBe("Goh, Ian");
    expect(openCat?.winners[0].rank).toBe(1);

    const femaleCat = ilca4?.categories.find((c) => c.categoryName === "Female");
    expect(femaleCat?.winners[0].sailorName).toBe("Wai, Zhi Tong");

    const u13Cat = ilca4?.categories.find((c) => c.categoryName.includes("13 Years & Under"));
    expect(u13Cat?.winners[0].sailorName).toBe("Lin, Shin Chen Rui");

    const wingfoil = SNSC_2026_PRIZE_SCHEDULE.fleets.find((f) => f.fleetName === "WingFoil");
    const wfOpen = wingfoil?.categories.find((c) => c.categoryName === "Open");
    expect(wfOpen?.winners[0].sailorName).toBe("Kate En Rui Bateman");
  });

  it("defines Pesta Sukan 2026 prize categories and winners per NoR", () => {
    expect(PESTA_SUKAN_2026_PRIZE_SCHEDULE.regattaName).toContain("Pesta Sukan 2026");
    expect(PESTA_SUKAN_2026_PRIZE_SCHEDULE.entryFees.singleHanded).toBe(78);
    expect(PESTA_SUKAN_2026_PRIZE_SCHEDULE.entryFees.doubleHanded).toBe(156);

    const ilca4 = PESTA_SUKAN_2026_PRIZE_SCHEDULE.fleets.find((f) => f.fleetName === "ILCA 4");
    expect(ilca4).toBeDefined();

    const openCat = ilca4?.categories.find((c) => c.categoryName === "Open");
    expect(openCat?.winners[0].sailorName).toBe("Caleb Peck");
    expect(openCat?.winners[1].sailorName).toBe("Lucas Zhihong Cao");
    expect(openCat?.winners[2].sailorName).toBe("Yuk Jun Lim");

    const femaleCat = ilca4?.categories.find((c) => c.categoryName === "Female");
    expect(femaleCat?.winners[0].sailorName).toBe("Lyric Yuxuan Li");

    const u13Cat = ilca4?.categories.find((c) => c.categoryName.includes("13 Years & Under"));
    expect(u13Cat?.winners[0].sailorName).toBe("Charles Shing Chak Kong");

    const gold = PESTA_SUKAN_2026_PRIZE_SCHEDULE.fleets.find((f) => f.fleetName === "Optimist Gold Fleet");
    expect(gold?.categories.find((c) => c.categoryName === "Open")?.winners[0].sailorName).toBe(
      "Alyssa Li Lin Wong"
    );
    const silver = PESTA_SUKAN_2026_PRIZE_SCHEDULE.fleets.find((f) => f.fleetName === "Optimist Silver Fleet");
    expect(silver?.categories.find((c) => c.categoryName === "Open")?.winners[0].sailorName).toBe(
      "Bryan Thian Tsek Lee"
    );
  });

  it("defines Cincapura Regatta 2026 prize categories and verified winners", () => {
    expect(CINCAPURA_2026_PRIZE_SCHEDULE.regattaName).toContain("Cincapura Regatta 2026");
    expect(CINCAPURA_2026_PRIZE_SCHEDULE.fleets).toHaveLength(6);

    const goldFleet = CINCAPURA_2026_PRIZE_SCHEDULE.fleets.find((f) => f.fleetName === "Optimist Gold Fleet");
    expect(goldFleet).toBeDefined();
    const goldOpen = goldFleet?.categories.find((c) => c.categoryName === "Open");
    expect(goldOpen?.winners).toHaveLength(10);
    expect(goldOpen?.winners[0].sailorName).toBe("Kyle Jeremy Zhi Jun Soh");
    expect(goldOpen?.winners[0].rank).toBe(1);
    expect(goldOpen?.winners[1].sailorName).toBe("Alyssa Li Lin Wong");
    expect(goldOpen?.winners[2].sailorName).toBe("Wangsun Chen");

    const goldFemale = goldFleet?.categories.find((c) => c.categoryName === "Female");
    expect(goldFemale?.winners).toHaveLength(3);
    expect(goldFemale?.winners[0].sailorName).toBe("Alyssa Li Lin Wong");

    const silverFleet = CINCAPURA_2026_PRIZE_SCHEDULE.fleets.find((f) => f.fleetName === "Optimist Silver Fleet");
    expect(silverFleet).toBeDefined();
    const silverOpen = silverFleet?.categories.find((c) => c.categoryName === "Open");
    expect(silverOpen?.winners).toHaveLength(10);
    expect(silverOpen?.winners[0].sailorName).toBe("Adele Ziyi Chiang");
    expect(silverOpen?.winners[1].sailorName).toBe("Bryan Thian Tsek Lee");
    expect(silverOpen?.winners[2].sailorName).toBe("Ryan Feiran Zheng");

    const silverNovice = silverFleet?.categories.find((c) => c.categoryName === "Novice");
    expect(silverNovice?.winners).toHaveLength(5);
    expect(silverNovice?.winners[0].sailorName).toBe("Allison Li Xin Teh");

    const ilca4 = CINCAPURA_2026_PRIZE_SCHEDULE.fleets.find((f) => f.fleetName === "ILCA 4");
    expect(ilca4?.categories.find((c) => c.categoryName === "Open")?.winners[0].sailorName).toBe("Mika Tew");
    const ilca6 = CINCAPURA_2026_PRIZE_SCHEDULE.fleets.find((f) => f.fleetName === "ILCA 6");
    expect(ilca6?.categories.find((c) => c.categoryName === "Open")?.winners[0].sailorName).toBe("Sarah Rui-En Yong");
    const skiff = CINCAPURA_2026_PRIZE_SCHEDULE.fleets.find((f) => f.fleetName === "29er");
    expect(skiff?.categories[0].winners[0].sailorName).toBe("Cheryl Ho / Gemma Chen");
    const techno = CINCAPURA_2026_PRIZE_SCHEDULE.fleets.find((f) => f.fleetName === "Techno 293");
    expect(techno?.categories.find((c) => c.categoryName === "Open")?.winners[0].sailorName).toBe("Addy Armand Anuar");
    expect(techno?.categories.find((c) => c.categoryName === "Female")?.winners[0].sailorName).toBe("Kate Teo");
  });

  it("records the 2nd SAFYC Optimist Championships from the final results", () => {
    expect(SAFYC_OPTIMIST_2026_PRIZE_SCHEDULE.datesText).toBe("4–5 July 2026");
    const gold = SAFYC_OPTIMIST_2026_PRIZE_SCHEDULE.fleets[0];
    const silver = SAFYC_OPTIMIST_2026_PRIZE_SCHEDULE.fleets[1];
    expect(gold.categories[0].winners[0].sailorName).toBe("Alyssa Wong Li Lin");
    expect(silver.categories[0].winners[0].sailorName).toBe("Lee Thian Tsek Bryan");
    expect(silver.categories[0].winners).toHaveLength(10);
  });

  it("provides complete race-by-race datasets for Cincapura 2026 Gold and Silver", () => {
    expect(CINCAPURA_2026_GOLD_RESULTS).toHaveLength(86);
    expect(CINCAPURA_2026_SILVER_RESULTS).toHaveLength(55);

    // Verify Gold winner
    const goldWinner = CINCAPURA_2026_GOLD_RESULTS[0];
    expect(goldWinner.sailorName).toBe("Kyle Jeremy Zhi Jun Soh");
    expect(goldWinner.races).toHaveLength(3);
    expect(goldWinner.totalScore).toBe(21);
    expect(goldWinner.nettScore).toBe(21);

    // Verify Silver winner
    const silverWinner = CINCAPURA_2026_SILVER_RESULTS[0];
    expect(silverWinner.sailorName).toBe("Adele Ziyi Chiang");
    expect(silverWinner.races).toHaveLength(4);
    expect(silverWinner.races[3].discarded).toBe(true);
    expect(silverWinner.totalScore).toBe(23);
    expect(silverWinner.nettScore).toBe(11);
  });
});

