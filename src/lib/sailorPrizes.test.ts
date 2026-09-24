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

    it("links official SNSC 2025 prizes to sailors (Pailin, Katelynn, Ian Goh, Kenan Tan)", () => {
      const pailin = getSailorPrizes({
        name: "Pailin Jaroenpon",
        sailNumber: "1253",
      });
      const pailinSnsc = pailin.filter((p) => p.year === 2025 && p.regattaName.includes("Singapore National"));
      expect(pailinSnsc.length).toBe(2); // 1st Open & 1st Female
      expect(pailinSnsc.every((p) => p.medal === "gold")).toBe(true);

      const katelynn = getSailorPrizes({
        name: "Katelynn Kai En Lee",
        sailNumber: "3383",
      });
      const katelynnSnsc = katelynn.filter((p) => p.year === 2025 && p.regattaName.includes("Singapore National"));
      expect(katelynnSnsc.length).toBe(2); // 1st Silver Champion & 1st Female
      expect(katelynnSnsc.every((p) => p.medal === "gold")).toBe(true);

      const ian = getSailorPrizes({
        name: "Ian Goh",
        sailNumber: "222713",
      });
      const ianSnsc = ian.find((p) => p.year === 2025 && p.regattaName.includes("Singapore National"));
      expect(ianSnsc).toBeDefined();
      expect(ianSnsc?.prizeTitle).toBe("1st (National Champion)");
      expect(ianSnsc?.boatClass).toBe("ILCA 4");

      const kenan = getSailorPrizes({
        name: "Kenan Kee Zen Tan",
        sailNumber: "1",
      });
      const kenanSnsc = kenan.find((p) => p.year === 2025 && p.regattaName.includes("Singapore National"));
      expect(kenanSnsc).toBeDefined();
      expect(kenanSnsc?.prizeTitle).toBe("1st (National Champion)");
      expect(kenanSnsc?.boatClass).toBe("ILCA 6");
    });

    it("links official SNSC 2025 prizes for Board Classes (Techno 293, Wingfoil, iQFOiL)", () => {
      // Techno 293
      const trevor = getSailorPrizes({
        name: "Trevor Ng",
        sailNumber: "45",
      });
      const trevorSnsc = trevor.filter((p) => p.year === 2025 && p.boatClass === "Techno 293");
      expect(trevorSnsc.length).toBe(2); // 1st Open & 1st 17&U
      expect(trevorSnsc.every((p) => p.medal === "gold")).toBe(true);

      // WingFoil
      const malo = getSailorPrizes({
        name: "Malo Pichoir",
        sailNumber: "123",
      });
      const maloSnsc = malo.filter((p) => p.year === 2025 && p.boatClass === "WingFoil");
      expect(maloSnsc.length).toBe(2); // 1st Open & 1st 18&U
      expect(maloSnsc.every((p) => p.medal === "gold")).toBe(true);

      const victoria = getSailorPrizes({
        name: "Victoria Natasha Chew",
        sailNumber: "12",
      });
      const vicSnsc = victoria.find((p) => p.year === 2025 && p.boatClass === "WingFoil");
      expect(vicSnsc).toBeDefined();
      expect(vicSnsc?.prizeTitle).toBe("1st Female");

      // iQFOiL
      const jonas = getSailorPrizes({
        name: "Jonas Knick",
        sailNumber: "39",
      });
      const jonasSnsc = jonas.filter((p) => p.year === 2025 && p.boatClass === "iQFOiL");
      expect(jonasSnsc.length).toBe(2); // 1st Open & 1st 18&U
      expect(jonasSnsc.every((p) => p.medal === "gold")).toBe(true);

      const angyal = getSailorPrizes({
        name: "Angyal Chew",
        sailNumber: "711",
      });
      const angyalSnsc = angyal.filter((p) => p.year === 2025 && p.boatClass === "iQFOiL");
      expect(angyalSnsc.length).toBe(3); // 2nd Open, 1st Female, 2nd 18&U
      const femalePrize = angyalSnsc.find((p) => p.prizeTitle === "1st Female");
      expect(femalePrize?.medal).toBe("gold");
    });
  });
});
