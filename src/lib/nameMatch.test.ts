import { describe, expect, it } from "vitest";
import {
  buildSailorNameIndex,
  combinedNameSimilarity,
  findDuplicateSailorPairs,
  chooseCanonicalSailor,
  exactNameMatches,
  findSailorByName,
  FUZZY_AUTO_MATCH_THRESHOLD,
  isExactNameMatch,
  nameTokenKey,
  normalizeName,
  suggestSailorByName,
} from "./nameMatch";

describe("normalizeName / nameTokenKey", () => {
  it("normalizes case and spaces", () => {
    expect(normalizeName("  Bryan  LEE ")).toBe("bryan lee");
  });

  it("token key is order-insensitive", () => {
    expect(nameTokenKey("Lee Thian Tsek Bryan")).toBe(
      nameTokenKey("Bryan Lee Thian Tsek")
    );
  });
});

describe("combinedNameSimilarity", () => {
  it("is 1 for same tokens different order", () => {
    expect(
      combinedNameSimilarity("Lee Thian Tsek Bryan", "Bryan Lee Thian Tsek")
    ).toBe(1);
  });

  it("scores partial overlap in 60%+ band for near-duplicates", () => {
    const sim = combinedNameSimilarity("Tan Wei Ming", "Tan Wei Ming John");
    expect(sim).toBeGreaterThanOrEqual(0.6);
  });

  it("is low for unrelated names", () => {
    expect(combinedNameSimilarity("Alice Wong", "Bob Lim")).toBeLessThan(0.5);
  });
});

describe("findSailorByName", () => {
  const sailors = [
    { id: "1", name: "Bryan Lee Thian Tsek" },
    { id: "2", name: "Mikaela Tan" },
  ];

  it("matches exact and token order", () => {
    expect(findSailorByName("Bryan Lee Thian Tsek", sailors)?.how).toBe(
      "exact"
    );
    expect(findSailorByName("Lee Thian Tsek Bryan", sailors)?.how).toBe(
      "tokens"
    );
  });

  it("matches aliases", () => {
    const hit = findSailorByName("B. Lee", sailors, [
      { sailorId: "1", aliasName: "B. Lee" },
    ]);
    expect(hit?.sailor?.id).toBe("1");
    expect(hit?.how).toBe("alias");
  });

  it("returns null when nothing close enough", () => {
    expect(findSailorByName("Completely Different Person", sailors)).toBeNull();
  });

  it("does not auto-link a fuzzy name at the suggestion threshold", () => {
    expect(
      combinedNameSimilarity("Mikaela Tann", "Mikaela Tan")
    ).toBeGreaterThanOrEqual(FUZZY_AUTO_MATCH_THRESHOLD);
    expect(findSailorByName("Mikaela Tann", sailors)).toBeNull();
    expect(suggestSailorByName("Mikaela Tann", sailors)?.id).toBe("2");
  });

  it("matches via prebuilt index (same results as array)", () => {
    const index = buildSailorNameIndex(sailors, [
      { sailorId: "1", aliasName: "B. Lee" },
    ]);
    expect(findSailorByName("Bryan Lee Thian Tsek", index)?.how).toBe("exact");
    expect(findSailorByName("Lee Thian Tsek Bryan", index)?.how).toBe("tokens");
    expect(findSailorByName("B. Lee", index)?.sailor?.id).toBe("1");
    expect(findSailorByName("Mikaela Tan", index)?.sailor?.id).toBe("2");
  });

  it("suggestSailorByName works with an index", () => {
    const index = buildSailorNameIndex(sailors);
    const sug = suggestSailorByName("Mikaela Tann", index);
    expect(sug?.id).toBe("2");
    expect(sug!.similarity).toBeGreaterThanOrEqual(0.35);
  });
});

describe("findDuplicateSailorPairs", () => {
  it("flags same-token names", () => {
    const pairs = findDuplicateSailorPairs([
      { id: "a", name: "Bryan Lee Thian Tsek" },
      { id: "b", name: "Lee Thian Tsek Bryan" },
      { id: "c", name: "Unrelated Sailor" },
    ]);
    expect(pairs.length).toBeGreaterThanOrEqual(1);
    expect(pairs[0].similarity).toBe(1);
    expect(pairs[0].band).toBe("high");
  });

  it("respects minSimilarity", () => {
    const pairs = findDuplicateSailorPairs(
      [
        { id: "a", name: "Tan Wei Ming" },
        { id: "b", name: "Tan Wei Ming John" },
      ],
      0.99
    );
    expect(pairs.every((p) => p.similarity >= 0.99)).toBe(true);
  });

  it("does not pair different names that share an ILCA 4 sail number", () => {
    const pairs = findDuplicateSailorPairs([
      {
        id: "a",
        name: "Alice Wong",
        sailNumberIlca4: "SGP 1234",
      },
      {
        id: "b",
        name: "Different Name",
        sailNumberIlca4: "SGP 1234",
      },
    ]);
    expect(pairs).toEqual([]);
  });
});

describe("exactNameMatches", () => {
  const sailors = [
    { id: "real", name: "Reyes Jit Eng Tan" },
    { id: "blank", name: "Tan Jit Eng Reyes" },
    { id: "other", name: "Reyes Tan" },
  ];

  it("treats reordered words as the same person", () => {
    expect(isExactNameMatch("Reyes Tan Jit Eng", "Reyes Jit Eng Tan")).toBe(
      true
    );
    expect(isExactNameMatch("Reyes Tan Jit Eng", "Reyes Tan")).toBe(false);
  });

  it("returns every 100% match so the result can be attached instead of creating a sailor", () => {
    const matches = exactNameMatches("Reyes Tan Jit Eng", sailors);
    expect(matches.map((sailor) => sailor.id).sort()).toEqual([
      "blank",
      "real",
    ]);
  });

  it("attaches a 100% match to the claimed sailor who already has results", () => {
    const chosen = chooseCanonicalSailor(
      [
        { id: "blank", name: "Tan Jit Eng Reyes", parentId: null, club: "N/A" },
        {
          id: "real",
          name: "Reyes Jit Eng Tan",
          parentId: "parent-1",
          club: "SAF Yacht Club",
        },
      ],
      (id) => id === "real"
    );
    expect(chosen.id).toBe("real");
  });
});

describe("suggestSailorByName", () => {
  it("suggests best match above threshold", () => {
    const s = suggestSailorByName("Mikaela", [
      { id: "1", name: "Mikaela Tan" },
      { id: "2", name: "Bob" },
    ]);
    expect(s?.id).toBe("1");
    expect(s!.similarity).toBeGreaterThanOrEqual(0.35);
  });
});
