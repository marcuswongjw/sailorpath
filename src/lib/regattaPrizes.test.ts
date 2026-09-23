import { describe, it, expect } from "vitest";
import {
  SNSC_2026_PRIZE_SCHEDULE,
  PESTA_SUKAN_2026_PRIZE_SCHEDULE,
} from "./regattaPrizes";

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
    expect(openCat?.winners[0].sailorName).toBe("Goh, Ian");

    const femaleCat = ilca4?.categories.find((c) => c.categoryName === "Female");
    expect(femaleCat?.winners[0].sailorName).toBe("Li, Lyric Yuxuan");

    const u13Cat = ilca4?.categories.find((c) => c.categoryName.includes("13 Years & Under"));
    expect(u13Cat?.winners[0].sailorName).toBe("Kong, Charles Shing Chak");
  });
});
