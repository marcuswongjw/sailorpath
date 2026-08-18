/**
 * Build create/update payloads for POST/PATCH /api/account/equipment.
 */

import {
  BRAND_OTHER,
  isMastSetCategory,
  resolveBrand,
  type EquipmentBoatClass,
  type EquipmentCategory,
  type EquipmentCondition,
  type EquipmentStatus,
  type EquipmentTag,
  type WindRange,
} from "@/lib/equipment";

export type EquipmentFormLike = {
  boatClass: EquipmentBoatClass;
  category: EquipmentCategory;
  brand: string;
  brandCustom: string;
  model: string;
  label: string;
  status: EquipmentStatus;
  condition: EquipmentCondition;
  isPrimary: boolean;
  tags: EquipmentTag[];
  windRange: WindRange | "";
  acquiredOn: string;
  notes: string;
};

export type EquipmentSavePayload = {
  sailorId: string;
  boatClass: EquipmentBoatClass;
  category: EquipmentCategory;
  brand: string | null;
  model: string | null;
  label: string | null;
  status: EquipmentStatus;
  condition: EquipmentCondition;
  isPrimary: boolean;
  tags: EquipmentTag[];
  windRange: WindRange | null;
  acquiredOn: string | null;
  notes: string | null;
};

/**
 * Happy-path create/update body from the inventory form.
 * Returns an error string when required fields are missing.
 */
export function buildEquipmentSavePayload(
  sailorId: string,
  form: EquipmentFormLike
): { ok: true; payload: EquipmentSavePayload } | { ok: false; error: string } {
  if (!sailorId.trim()) {
    return { ok: false, error: "sailorId required" };
  }
  const brand = resolveBrand(form.category, form.brand, form.brandCustom);
  if (!brand && form.category !== "other") {
    return { ok: false, error: "Select a brand" };
  }

  const model =
    form.category === "sail" || isMastSetCategory(form.category)
      ? form.model.trim() || null
      : null;
  const label =
    form.category === "hull" ||
    form.category === "sail" ||
    form.category === "other"
      ? form.label.trim() || null
      : null;

  return {
    ok: true,
    payload: {
      sailorId: sailorId.trim(),
      boatClass: form.boatClass,
      category: form.category,
      brand: brand || null,
      model,
      label,
      status: form.status,
      condition: form.condition,
      isPrimary: form.isPrimary,
      tags: form.tags,
      windRange: form.category === "sail" ? form.windRange || null : null,
      acquiredOn: form.acquiredOn.trim() || null,
      notes: form.notes.trim() || null,
    },
  };
}

export function buildFullRigPayload(
  sailorId: string,
  boatClass: EquipmentBoatClass,
  brand: string,
  brandCustom: string
): { ok: true; payload: Record<string, unknown> } | { ok: false; error: string } {
  const resolved =
    brand === BRAND_OTHER ? brandCustom.trim() : brand.trim();
  if (!resolved) {
    return { ok: false, error: "Select or enter a brand" };
  }
  return {
    ok: true,
    payload: {
      sailorId,
      boatClass,
      fullRig: true,
      brand: resolved,
      tags: ["racing"],
    },
  };
}
