import { describe, it, expect } from "vitest";
import {
  matchesSailorName,
  deriveMedalTier,
  getSailorPrizes,
  getSailorMedalCounts,
} from "./sailorPrizes";

describe("sailorPrizes", () => {
  describe("matchesSailorName", () => {
    it("matches exact name", () => {
      expect(matchesSailorName("Keira Carlyle", "Keira Carlyle")).toBe(true);
    });

    it("matches name with middle name (token subset)", () => {
      expect(matchesSailorName("Keira Marie Carlyle", "Keira Carlyle")).toBe(true);
      expect(matchesSailorName("Keira Carlyle", "Keira Marie Carlyle")).toBe(true);
      expect(matchesSailorName("Kenan Kee Zen Tan", "Kenan Tan")).toBe(true);
      expect(matchesSailorName("Austin Jia Yu Yeo", "Austin Yeo")).toBe(true);
    });

    it("matches double-handed team members", () => {
      expect(matchesSailorName("Cheryl Yong / Febe Wong", "Cheryl Yong")).toBe(true);
      expect(matchesSailorName("Cheryl Yong / Febe Wong", "Febe Wong")).toBe(true);
      expect(matchesSailorName("Sean Kum / Nigel Tan", "Sean Kum")).toBe(true);
    });

    it("does not match different sailors with common first names", () => {
      expect(matchesSailorName("Cheryl Yong", "Cheryl Ho")).toBe(false);
      expect(matchesSailorName("Kenan Tan", "Darren Lai")).toBe(false);
    });
  });

  describe("deriveMedalTier", () => {
    it("identifies gold, silver, and bronze", () => {
      expect(deriveMedalTier(1)).toBe("gold");
      expect(deriveMedalTier(2)).toBe("silver");
      expect(deriveMedalTier(3)).toBe("bronze");
      expect(deriveMedalTier(4)).toBe("other");
      expect(deriveMedalTier(1, "1st Female")).toBe("gold");
      expect(deriveMedalTier(2, "2nd Female")).toBe("silver");
    });
  });

  describe("getSailorPrizes & medal counts", () => {
    it("links official prizes to Keira Carlyle", () => {
      const prizes = getSailorPrizes({
        name: "Keira Carlyle",
        sailNumber: "225225",
        handle: "keira-carlyle",
      });

      expect(prizes.length).toBeGreaterThan(0);
      const temasek = prizes.find((p) => p.regattaName.includes("Temasek"));
      expect(temasek).toBeDefined();
      expect(temasek?.rank).toBe(1);
      expect(temasek?.medal).toBe("gold");

      const counts = getSailorMedalCounts(prizes);
      expect(counts.gold).toBeGreaterThanOrEqual(1);
      expect(counts.total).toBe(prizes.length);
    });

    it("links official prizes to Cheryl Yong (29er double-handed)", () => {
      const prizes = getSailorPrizes({
        name: "Cheryl Yong",
        sailNumber: "2466",
        handle: "cheryl-yong",
      });

      expect(prizes.length).toBeGreaterThan(0);
      const sysc29er = prizes.find((p) => p.regattaName.includes("Youth") && p.boatClass === "29er");
      expect(sysc29er).toBeDefined();
      expect(sysc29er?.rank).toBe(1);
      expect(sysc29er?.medal).toBe("gold");

      const csc29er = prizes.find((p) => p.regattaName.includes("CSC") && p.boatClass === "29er");
      expect(csc29er).toBeDefined();
      expect(csc29er?.rank).toBe(1);
      expect(csc29er?.medal).toBe("gold");
      expect(csc29er?.prizeTitle).toBe("1st Youth Mixed");
    });

    it("links official prizes for 6th CSC ILCA & 29er Open (Ikuto Mori & Maia Lim)", () => {
      const ikutoPrizes = getSailorPrizes({
        name: "Ikuto Mori",
        sailNumber: "219178",
        handle: "ikuto-mori",
      });
      const ikutoCsc = ikutoPrizes.filter((p) => p.regattaName.includes("CSC"));
      expect(ikutoCsc.length).toBe(2); // Youth Mixed 1st & Open Mixed 1st
      expect(ikutoCsc[0].medal).toBe("gold");

      const maiaPrizes = getSailorPrizes({
        name: "Maia Lim Laurie",
        sailNumber: "223201",
        handle: "maia-lim-laurie-6vmk",
      });
      const maiaCsc = maiaPrizes.find((p) => p.regattaName.includes("CSC") && p.categoryName === "Female");
      expect(maiaCsc).toBeDefined();
      expect(maiaCsc?.rank).toBe(1);
      expect(maiaCsc?.medal).toBe("gold");
    });
  });
});
