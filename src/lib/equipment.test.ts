import { describe, expect, it } from "vitest";
import {
  evaluateEquipmentAttention,
  evaluateEquipmentBadge,
  parseTags,
  serializeTags,
  displayName,
  brandsForCategory,
  groupEquipmentSections,
  isCustomBrand,
  BRAND_OTHER,
  parseWindRange,
} from "./equipment";

describe("equipment helpers", () => {
  it("parses and serializes tags", () => {
    expect(parseTags("racing,training")).toEqual(["racing", "training"]);
    expect(serializeTags(["racing", "nope" as never])).toBe("racing");
  });

  it("migrates travel tag to spare / backup", () => {
    expect(parseTags("travel,racing")).toEqual(["spare", "racing"]);
    expect(serializeTags(["travel" as never, "overseas"])).toBe(
      "spare,overseas"
    );
  });

  it("parses wind range", () => {
    expect(parseWindRange("Light")).toBe("light");
    expect(parseWindRange("medium")).toBe("medium");
    expect(parseWindRange("heavy")).toBe("heavy");
    expect(parseWindRange("nope")).toBe(null);
  });

  it("displayName formats sails and hulls with numbers", () => {
    expect(
      displayName({ brand: "North", model: "3DL", category: "sail" })
    ).toBe("North 3DL");
    expect(
      displayName({
        brand: "J-Sail",
        model: "Racing",
        label: "115",
        category: "sail",
      })
    ).toBe("J-Sail Racing #115");
    expect(
      displayName({ brand: "XSP", label: "SZ 1", category: "hull" })
    ).toBe("XSP · SZ 1");
    expect(displayName({ label: "Race sail", category: "other" })).toBe(
      "Race sail"
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
        windRange: null,
        acquiredOn: null,
        retiredOn: null,
        useCount: 0,
        lastUsedOn: null,
        notes: null,
        badge: "good",
        badgeLabel: "Good",
        needsAttention: false,
        attentionReason: null,
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
        windRange: null,
        acquiredOn: null,
        retiredOn: null,
        useCount: 0,
        lastUsedOn: null,
        notes: null,
        badge: "good",
        badgeLabel: "Good",
        needsAttention: false,
        attentionReason: null,
      },
    ]);
    const mast = sections.find((s) => s.id === "mast_set");
    const foil = sections.find((s) => s.id === "foil_set");
    expect(mast?.items).toHaveLength(1);
    expect(foil?.items).toHaveLength(1);
  });

  it("replacement badges by age, condition, and uses", () => {
    // New: < 3 months
    expect(
      evaluateEquipmentBadge({
        status: "active",
        condition: "good",
        useCount: 0,
        acquiredOn: "2026-07-01",
      }).badge
    ).toBe("new");

    // Good: 3–12 months, condition good
    expect(
      evaluateEquipmentBadge({
        status: "active",
        condition: "good",
        useCount: 2,
        acquiredOn: "2025-12-01",
      }).badge
    ).toBe("good");

    // Check condition: fair
    expect(
      evaluateEquipmentBadge({
        status: "active",
        condition: "fair",
        useCount: 1,
        acquiredOn: "2026-06-01",
      })
    ).toMatchObject({
      badge: "check_condition",
      needsAttention: true,
    });

    // Consider replacement: > 20 regatta uses
    expect(
      evaluateEquipmentBadge({
        status: "active",
        condition: "good",
        useCount: 21,
        acquiredOn: "2026-06-01",
      })
    ).toMatchObject({
      badge: "consider_replacement",
      needsAttention: true,
    });

    // Replace soon: needs repair
    expect(
      evaluateEquipmentBadge({
        status: "active",
        condition: "worn",
        useCount: 2,
      })
    ).toMatchObject({
      badge: "replace_soon",
      needsAttention: true,
    });
  });

  it("flags worn sails and high use via attention helper", () => {
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
        useCount: 21,
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
