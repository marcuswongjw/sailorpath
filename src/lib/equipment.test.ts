import { describe, expect, it } from "vitest";
import {
  evaluateEquipmentAttention,
  parseTags,
  serializeTags,
  displayName,
  brandsForCategory,
  groupEquipmentSections,
  isCustomBrand,
  BRAND_OTHER,
} from "./equipment";

describe("equipment helpers", () => {
  it("parses and serializes tags", () => {
    expect(parseTags("racing,training")).toEqual(["racing", "training"]);
    expect(serializeTags(["racing", "nope" as never])).toBe("racing");
  });

  it("displayName prefers label", () => {
    expect(displayName({ label: "Race", brand: "North", category: "sail" })).toBe(
      "Race"
    );
    expect(displayName({ brand: "North", model: "3DL", category: "sail" })).toBe(
      "North 3DL"
    );
  });

  it("uses SG brand presets and allows other", () => {
    expect(brandsForCategory("hull")).toContain("Winner");
    expect(brandsForCategory("hull")).toContain("Faccenda");
    expect(brandsForCategory("sail")).toContain("OneSail");
    expect(brandsForCategory("daggerboard")).toContain("DSK");
    expect(isCustomBrand("hull", "McLaughlin")).toBe(true);
    expect(isCustomBrand("hull", "Winner")).toBe(false);
    expect(BRAND_OTHER).toBe("Other");
  });

  it("groups mast/boom/sprit as mast set", () => {
    const sections = groupEquipmentSections([
      {
        id: "1",
        sailorId: "s",
        boatClass: "optimist",
        category: "mast",
        brand: "Optiparts",
        model: null,
        label: null,
        status: "active",
        condition: "good",
        isPrimary: true,
        tags: [],
        acquiredOn: null,
        retiredOn: null,
        useCount: 0,
        lastUsedOn: null,
        notes: null,
      },
      {
        id: "2",
        sailorId: "s",
        boatClass: "optimist",
        category: "daggerboard",
        brand: "DSK",
        model: null,
        label: null,
        status: "active",
        condition: "good",
        isPrimary: true,
        tags: [],
        acquiredOn: null,
        retiredOn: null,
        useCount: 0,
        lastUsedOn: null,
        notes: null,
      },
    ]);
    const mast = sections.find((s) => s.id === "mast_set");
    const foil = sections.find((s) => s.id === "foil_set");
    expect(mast?.items).toHaveLength(1);
    expect(foil?.items).toHaveLength(1);
  });

  it("flags worn sails and high use", () => {
    expect(
      evaluateEquipmentAttention({
        category: "sail",
        status: "active",
        condition: "worn",
        useCount: 2,
      }).needsAttention
    ).toBe(true);

    expect(
      evaluateEquipmentAttention({
        category: "sail",
        status: "active",
        condition: "good",
        useCount: 15,
      }).needsAttention
    ).toBe(true);

    expect(
      evaluateEquipmentAttention({
        category: "sail",
        status: "active",
        condition: "good",
        useCount: 3,
        acquiredOn: "2026-07-01",
      }).needsAttention
    ).toBe(false);
  });
});
