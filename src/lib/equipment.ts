/** Optimist / ILCA equipment inventory helpers */

export type EquipmentBoatClass = "optimist" | "ilca4" | "other";

export type EquipmentCategory =
  | "hull"
  | "sail"
  | "mast"
  | "boom"
  | "sprit"
  | "daggerboard"
  | "rudder"
  | "other";

export type EquipmentStatus = "active" | "backup" | "retired";

export type EquipmentCondition =
  | "new"
  | "good"
  | "fair"
  | "worn"
  | "replace_soon";

export type EquipmentTag =
  | "racing"
  | "training"
  | "light_air"
  | "heavy_air"
  | "travel";

export const EQUIPMENT_CATEGORIES: {
  value: EquipmentCategory;
  label: string;
  group: string;
}[] = [
  { value: "hull", label: "Hull", group: "Boat" },
  { value: "sail", label: "Sail", group: "Sail" },
  { value: "mast", label: "Mast", group: "Spars" },
  { value: "boom", label: "Boom", group: "Spars" },
  { value: "sprit", label: "Sprit", group: "Spars" },
  { value: "daggerboard", label: "Daggerboard", group: "Foils" },
  { value: "rudder", label: "Rudder", group: "Foils" },
  { value: "other", label: "Other", group: "Other" },
];

export const EQUIPMENT_TAGS: { value: EquipmentTag; label: string }[] = [
  { value: "racing", label: "Racing" },
  { value: "training", label: "Training" },
  { value: "light_air", label: "Light air" },
  { value: "heavy_air", label: "Heavy air" },
  { value: "travel", label: "Travel" },
];

export const BRAND_PRESETS: Partial<Record<EquipmentCategory, string[]>> = {
  hull: ["McLaughlin", "Winner", "Nautivela", "Blueblue", "Far East"],
  sail: ["North", "Doyle", "Quantum", "One Sails", "WB-Sails"],
  mast: ["Optiparts", "Blackgold", "Selden"],
  boom: ["Optiparts", "Blackgold"],
  sprit: ["Optiparts", "Blackgold"],
  daggerboard: ["Optiparts", "Nautix", "WinDesign"],
  rudder: ["Optiparts", "Nautix", "WinDesign"],
};

export type EquipmentItemDto = {
  id: string;
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
  acquiredOn: string | null;
  retiredOn: string | null;
  useCount: number;
  lastUsedOn: string | null;
  notes: string | null;
  needsAttention?: boolean;
  attentionReason?: string | null;
};

/** Soft life thresholds (advisory only). */
export const EQUIPMENT_ALERTS = {
  sailMaxUses: 12,
  sailMaxMonths: 14,
  foilMaxMonths: 36,
  sparMaxMonths: 36,
} as const;

export function parseTags(raw: string | null | undefined): EquipmentTag[] {
  if (!raw) return [];
  const allowed = new Set(EQUIPMENT_TAGS.map((t) => t.value));
  return String(raw)
    .split(/[,|]/)
    .map((s) => s.trim().toLowerCase().replace(/\s+/g, "_"))
    .filter((s): s is EquipmentTag => allowed.has(s as EquipmentTag));
}

export function serializeTags(tags: string[] | null | undefined): string | null {
  if (!tags?.length) return null;
  const allowed = new Set(EQUIPMENT_TAGS.map((t) => t.value));
  const clean = tags
    .map((t) => String(t).trim().toLowerCase().replace(/\s+/g, "_"))
    .filter((t) => allowed.has(t as EquipmentTag));
  return clean.length ? clean.join(",") : null;
}

export function categoryLabel(c: EquipmentCategory | string): string {
  return EQUIPMENT_CATEGORIES.find((x) => x.value === c)?.label || c;
}

export function displayName(item: {
  brand?: string | null;
  model?: string | null;
  label?: string | null;
  category?: string;
}): string {
  if (item.label?.trim()) return item.label.trim();
  const parts = [item.brand, item.model].filter(Boolean);
  if (parts.length) return parts.join(" ");
  return categoryLabel(item.category || "other");
}

function monthsSince(ymd: string | null | undefined): number | null {
  if (!ymd || !/^\d{4}-\d{2}-\d{2}/.test(ymd)) return null;
  const d = new Date(`${ymd.slice(0, 10)}T12:00:00Z`);
  if (Number.isNaN(d.getTime())) return null;
  const now = new Date();
  return (
    (now.getUTCFullYear() - d.getUTCFullYear()) * 12 +
    (now.getUTCMonth() - d.getUTCMonth())
  );
}

export function evaluateEquipmentAttention(item: {
  category: string;
  status: string;
  condition: string;
  useCount: number;
  acquiredOn?: string | null;
}): { needsAttention: boolean; reason: string | null } {
  if (item.status === "retired") {
    return { needsAttention: false, reason: null };
  }
  if (item.condition === "replace_soon") {
    return { needsAttention: true, reason: "Marked replace soon" };
  }
  if (item.condition === "worn") {
    return { needsAttention: true, reason: "Condition: worn" };
  }
  const age = monthsSince(item.acquiredOn);
  if (item.category === "sail") {
    if (item.useCount >= EQUIPMENT_ALERTS.sailMaxUses) {
      return {
        needsAttention: true,
        reason: `${item.useCount} logged uses — consider a fresh race sail`,
      };
    }
    if (age != null && age >= EQUIPMENT_ALERTS.sailMaxMonths) {
      return {
        needsAttention: true,
        reason: `~${age} months old — check sail shape`,
      };
    }
  }
  if (
    (item.category === "daggerboard" || item.category === "rudder") &&
    age != null &&
    age >= EQUIPMENT_ALERTS.foilMaxMonths
  ) {
    return {
      needsAttention: true,
      reason: `Foils ~${age} months — inspect edges`,
    };
  }
  if (
    (item.category === "mast" ||
      item.category === "boom" ||
      item.category === "sprit") &&
    age != null &&
    age >= EQUIPMENT_ALERTS.sparMaxMonths
  ) {
    return {
      needsAttention: true,
      reason: `Spars ~${age} months — check for wear`,
    };
  }
  return { needsAttention: false, reason: null };
}

export function mapEquipmentRow(row: {
  id: string;
  sailorId: string;
  boatClass: string;
  category: string;
  brand: string | null;
  model: string | null;
  label: string | null;
  status: string;
  condition: string;
  isPrimary: boolean;
  tags: string | null;
  acquiredOn: string | null;
  retiredOn: string | null;
  useCount: number | null;
  lastUsedOn: string | null;
  notes: string | null;
}): EquipmentItemDto {
  const tags = parseTags(row.tags);
  const attn = evaluateEquipmentAttention({
    category: row.category,
    status: row.status,
    condition: row.condition,
    useCount: row.useCount || 0,
    acquiredOn: row.acquiredOn,
  });
  return {
    id: row.id,
    sailorId: row.sailorId,
    boatClass: row.boatClass as EquipmentBoatClass,
    category: row.category as EquipmentCategory,
    brand: row.brand,
    model: row.model,
    label: row.label,
    status: row.status as EquipmentStatus,
    condition: row.condition as EquipmentCondition,
    isPrimary: Boolean(row.isPrimary),
    tags,
    acquiredOn: row.acquiredOn ? String(row.acquiredOn).slice(0, 10) : null,
    retiredOn: row.retiredOn ? String(row.retiredOn).slice(0, 10) : null,
    useCount: Number(row.useCount || 0),
    lastUsedOn: row.lastUsedOn ? String(row.lastUsedOn).slice(0, 10) : null,
    notes: row.notes,
    needsAttention: attn.needsAttention,
    attentionReason: attn.reason,
  };
}

/** Group for inventory layout */
export function groupEquipmentItems(items: EquipmentItemDto[]) {
  const order = EQUIPMENT_CATEGORIES.map((c) => c.value);
  const byCat = new Map<EquipmentCategory, EquipmentItemDto[]>();
  for (const c of order) byCat.set(c, []);
  for (const it of items) {
    const list = byCat.get(it.category) || [];
    list.push(it);
    byCat.set(it.category, list);
  }
  return order
    .map((cat) => ({
      category: cat,
      label: categoryLabel(cat),
      items: (byCat.get(cat) || []).sort((a, b) => {
        if (a.isPrimary !== b.isPrimary) return a.isPrimary ? -1 : 1;
        return (b.useCount || 0) - (a.useCount || 0);
      }),
    }))
    .filter((g) => g.items.length > 0);
}
