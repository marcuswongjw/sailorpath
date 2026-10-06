import { describe, expect, it } from "vitest";
import type { RegattaPrizeFleet } from "@/lib/regattaPrizes";
import { eligibilityForCategory, fillUnlistedPrizeWinners, schoolLevel } from "./prizeWinnersFromResults";

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

describe("eligibilityForCategory", () => {
  function allows(name: string, birthYear: number, eventYear = 2026): boolean {
    const rule = eligibilityForCategory(name);
    if (!rule) return false;
    return rule({ sailorName: "Sailor", rank: 1, birthYear }, eventYear);
  }

  it("reads and-under, exact age, and a named birth year", () => {
    expect(allows("15 and Under", 2011)).toBe(true);
    expect(allows("15 and Under", 2010)).toBe(false);
    expect(allows("15 years and under", 2011)).toBe(true);
    expect(allows("15 years & under", 2010)).toBe(false);
    expect(allows("10 Years Old and Under (Born in the year 2016)", 2016, 2030)).toBe(true);
    expect(allows("10 Years Old and Under (Born in the year 2016)", 2017, 2030)).toBe(true);
    expect(allows("10 Years Old and Under (Born in the year 2016)", 2015, 2030)).toBe(false);
    expect(allows("9 Years Old (Born in the year 2017)", 2017, 2030)).toBe(true);
    expect(allows("9 Years Old (Born in the year 2017)", 2016, 2030)).toBe(false);
    expect(allows("9 Years Old (Born in the year 2017)", 2018, 2030)).toBe(false);
    expect(allows("8 Years Old and Under (Born in 2018 or after)", 2018, 2030)).toBe(true);
    expect(allows("8 Years Old and Under (Born in 2018 or after)", 2019, 2030)).toBe(true);
    expect(allows("8 Years Old and Under (Born in 2018 or after)", 2017, 2030)).toBe(false);
    expect(allows("10 Years Old", 2015, 2025)).toBe(true);
    expect(allows("10 Years Old", 2016, 2025)).toBe(false);
    expect(allows("under 10", 2017)).toBe(true);
    expect(allows("under 10", 2016)).toBe(false);
    expect(allows("12 Years and Under", 2014)).toBe(true);
    expect(allows("12 Years and Under", 2013)).toBe(false);
  });

  it("does not guess novice winners", () => {
    expect(eligibilityForCategory("Novice (first-time participants in a ranking race or regatta)")).toBeNull();
    expect(eligibilityForCategory("Novice 10 Years Old")).toBeNull();
  });

  it("fills empty age categories from the published order", () => {
    const ageFleet: RegattaPrizeFleet = {
      fleetName: "Optimist Silver Fleet",
      boatClass: "Optimist",
      categories: [
        { categoryName: "15 and Under", prizesAwarded: "1st to 3rd", winners: [] },
        {
          categoryName: "10 Years Old and Under (Born in the year 2016)",
          prizesAwarded: "1st to 3rd",
          winners: [],
        },
        { categoryName: "9 Years Old (Born in the year 2017)", prizesAwarded: "1st", winners: [] },
        {
          categoryName: "8 Years Old and Under (Born in 2018 or after)",
          prizesAwarded: "1st",
          winners: [],
        },
        { categoryName: "10 Years Old", prizesAwarded: "1st", winners: [] },
        { categoryName: "Novice", prizesAwarded: "1st to 3rd", winners: [] },
      ],
    };
    const filled = fillUnlistedPrizeWinners(
      [ageFleet],
      [
        { sailorName: "Older", rank: 1, birthYear: 2015 },
        { sailorName: "Ten", rank: 2, birthYear: 2016 },
        { sailorName: "Nine", rank: 3, birthYear: 2017 },
        { sailorName: "Eight", rank: 4, birthYear: 2018 },
        { sailorName: "Too Old", rank: 5, birthYear: 2010 },
      ],
      2026
    );
    const names = new Map(
      filled[0].categories.map((category) => [
        category.categoryName,
        category.winners.map((winner) => winner.sailorName),
      ])
    );
    expect(names.get("15 and Under")).toEqual(["Older", "Ten", "Nine"]);
    expect(names.get("10 Years Old and Under (Born in the year 2016)")).toEqual(["Ten", "Nine", "Eight"]);
    expect(names.get("9 Years Old (Born in the year 2017)")).toEqual(["Nine"]);
    expect(names.get("8 Years Old and Under (Born in 2018 or after)")).toEqual(["Eight"]);
    expect(names.get("10 Years Old")).toEqual(["Ten"]);
    expect(names.has("Novice")).toBe(false);
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
