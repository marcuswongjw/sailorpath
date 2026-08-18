import { EQUIPMENT_SECTIONS, brandsForCategory } from "@/lib/equipment";

export function sectionIcon(id: string): string {
  return EQUIPMENT_SECTIONS.find((s) => s.id === id)?.icon || "•";
}

/** Default mast brand when opening the full-rig modal. */
export function defaultFullRigBrand(): string {
  return brandsForCategory("mast")[0] || "";
}
