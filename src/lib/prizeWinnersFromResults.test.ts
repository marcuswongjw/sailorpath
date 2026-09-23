import { describe, expect, it } from "vitest";
import type { RegattaPrizeFleet } from "@/lib/regattaPrizes";
import { fillUnlistedPrizeWinners, schoolLevel } from "./prizeWinnersFromResults";

const fleet: RegattaPrizeFleet = {
  fleetName: "Optimist Gold Fleet",
  boatClass: "Optimist",
  categories: [
    { categoryName: "Open", prizesAwarded: "1st to 3rd", winners: [] },
    { categoryName: "Female", prizesAwarded: "1st to 2nd", winners: [] },
    {
      categoryName: "Aged 11 - 12 years old (born between 2014 and 2015)",
      prizesAwarded: "1st to 2nd",
      winners: [],
    },
    { categoryName: "Primary School", prizesAwarded: "1st", winners: [] },
    { categoryName: "Secondary School", prizesAwarded: "1st", winners: [] },
    {
      categoryName: "Novice (first-time participants in a ranking race or regatta)",
      prizesAwarded: "1st to 3rd",
      winners: [],
    },
  ],
};

const results = [
  { sailorName: "Alyssa Wong", rank: 1, gender: "F", birthYear: 2013, school: "Raffles Girls' School", nettScore: 28, sailNumber: "150" },
  { sailorName: "Ashlyn Tham", rank: 2, gender: "F", birthYear: 2012, school: "St. Hilda's Secondary School", nettScore: 37 },
  { sailorName: "Rahul", rank: 3, gender: "M", birthYear: 2012, school: "Raffles Institution", nettScore: 40 },
  { sailorName: "Ethan Low", rank: 4, gender: "M", birthYear: 2014, school: "St. Hilda's Primary School", nettScore: 21 },
  { sailorName: "Did not start", rank: 44, gender: "F", birthYear: 2014, school: "Example Primary School", isDns: true, nettScore: 200 },
];

describe("fillUnlistedPrizeWinners", () => {
  const filled = fillUnlistedPrizeWinners([fleet], results, 2026);

  it("calculates open, female, age, and school prizes from the results", () => {
    const categories = new Map(filled[0].categories.map((category) => [category.categoryName, category.winners.map((winner) => winner.sailorName)]));
    expect(categories.get("Open")).toEqual(["Alyssa Wong", "Ashlyn Tham", "Rahul"]);
    expect(categories.get("Female")).toEqual(["Alyssa Wong", "Ashlyn Tham"]);
    expect(categories.get("Aged 11 - 12 years old (born between 2014 and 2015)")).toEqual(["Ethan Low"]);
    expect(categories.get("Primary School")).toEqual(["Ethan Low"]);
    expect(categories.get("Secondary School")).toEqual(["Alyssa Wong"]);
  });

  it("does not invent novice winners and skips DNS sailors", () => {
    expect(filled[0].categories.some((category) => /novice/i.test(category.categoryName))).toBe(false);
    expect(filled[0].categories.flatMap((category) => category.winners).some((winner) => winner.sailorName === "Did not start")).toBe(false);
  });

  it("keeps an official winner list instead of recalculating it", () => {
    const official: RegattaPrizeFleet = {
      ...fleet,
      categories: [
        {
          categoryName: "Female",
          prizesAwarded: "1st to 3rd",
          winners: [{ rank: 1, prizeTitle: "1st Female", sailorName: "Named On The Sheet" }],
        },
      ],
    };
    const next = fillUnlistedPrizeWinners([official], results, 2026);
    expect(next[0].categories[0].winners.map((winner) => winner.sailorName)).toEqual(["Named On The Sheet"]);
  });
});

describe("schoolLevel", () => {
  it("treats junior schools as primary and institutions as secondary", () => {
    expect(schoolLevel("Anglo-Chinese School (Junior)")).toBe("primary");
    expect(schoolLevel("St. Joseph's Institution Junior")).toBe("primary");
    expect(schoolLevel("Raffles Institution")).toBe("secondary");
    expect(schoolLevel("Raffles Girls' School")).toBe("secondary");
  });
});
