import { describe, expect, it } from "vitest";
import {
  combinedNameSimilarity,
  findDuplicateSailorPairs,
  findSailorByName,
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
    expect(hit?.sailor.id).toBe("1");
    expect(hit?.how).toBe("alias");
  });

  it("returns null when nothing close enough", () => {
    expect(findSailorByName("Completely Different Person", sailors)).toBeNull();
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
