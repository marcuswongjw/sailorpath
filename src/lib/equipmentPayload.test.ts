import { describe, expect, it } from "vitest";
import { BRAND_OTHER } from "./equipment";
import {
  buildEquipmentSavePayload,
  buildFullRigPayload,
  type EquipmentFormLike,
} from "./equipmentPayload";

const baseForm = (): EquipmentFormLike => ({
  boatClass: "optimist",
  category: "sail",
  brand: "OneSail",
  brandCustom: "",
  model: "Racing",
  label: "115",
  status: "active",
  condition: "good",
  isPrimary: true,
  tags: ["racing"],
  windRange: "medium",
  acquiredOn: "2026-01-15",
  notes: "Race sail",
});

describe("equipment payload happy paths", () => {
  it("builds a sail create payload", () => {
    const result = buildEquipmentSavePayload("sailor-1", baseForm());
    expect(result.ok).toBe(true);
    if (!result.ok) return;
    expect(result.payload).toMatchObject({
      sailorId: "sailor-1",
      category: "sail",
      brand: "OneSail",
      model: "Racing",
      label: "115",
      windRange: "medium",
      tags: ["racing"],
      isPrimary: true,
    });
  });

  it("resolves Other brand custom text", () => {
    const result = buildEquipmentSavePayload("sailor-1", {
      ...baseForm(),
      category: "hull",
      brand: BRAND_OTHER,
      brandCustom: "McLaughlin",
      model: "",
      label: "SZ 2",
      windRange: "",
    });
    expect(result.ok).toBe(true);
    if (!result.ok) return;
    expect(result.payload.brand).toBe("McLaughlin");
    expect(result.payload.model).toBeNull();
    expect(result.payload.windRange).toBeNull();
    expect(result.payload.label).toBe("SZ 2");
  });

  it("rejects missing brand on non-other categories", () => {
    const result = buildEquipmentSavePayload("sailor-1", {
      ...baseForm(),
      brand: "",
      brandCustom: "",
    });
    expect(result.ok).toBe(false);
    if (result.ok) return;
    expect(result.error).toMatch(/brand/i);
  });

  it("builds a full-rig payload", () => {
    const result = buildFullRigPayload("sailor-1", "optimist", "Rooster", "");
    expect(result).toEqual({
      ok: true,
      payload: {
        sailorId: "sailor-1",
        boatClass: "optimist",
        fullRig: true,
        brand: "Rooster",
        tags: ["racing"],
      },
    });
  });

  it("rejects empty full-rig brand", () => {
    const result = buildFullRigPayload("sailor-1", "optimist", "Other", "  ");
    expect(result.ok).toBe(false);
  });

  it("rejects missing sailor id", () => {
    const result = buildEquipmentSavePayload("", baseForm());
    expect(result.ok).toBe(false);
  });

  it("normalizes empty optional fields to null", () => {
    const result = buildEquipmentSavePayload("sailor-1", {
      ...baseForm(),
      model: "  ",
      label: "",
      notes: "   ",
      acquiredOn: "",
      windRange: "",
      tags: [],
      isPrimary: false,
    });
    expect(result.ok).toBe(true);
    if (!result.ok) return;
    expect(result.payload.model).toBeNull();
    expect(result.payload.label).toBeNull();
    expect(result.payload.notes).toBeNull();
    expect(result.payload.acquiredOn).toBeNull();
    expect(result.payload.windRange).toBeNull();
    expect(result.payload.tags).toEqual([]);
    expect(result.payload.isPrimary).toBe(false);
  });

  it("accepts mast without wind range", () => {
    const result = buildEquipmentSavePayload("sailor-1", {
      ...baseForm(),
      boatClass: "ilca4",
      category: "mast",
      brand: "Selden",
      model: "Radial",
      windRange: "",
      tags: ["training"],
    });
    expect(result.ok).toBe(true);
    if (!result.ok) return;
    expect(result.payload.category).toBe("mast");
    expect(result.payload.windRange).toBeNull();
  });
});
