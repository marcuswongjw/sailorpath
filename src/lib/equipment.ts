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
  | "spare"
  | "overseas";

export type WindRange = "light" | "medium" | "heavy";

export type SessionType = "regatta" | "training";

export type EquipmentBadge =
  | "new"
  | "good"
  | "check_condition"
  | "consider_replacement"
  | "replace_soon";

/**
 * UI sections: Mast Set groups mast/boom/sprit; Foil Set groups board/rudder.
 */
export const EQUIPMENT_CATEGORIES: {
  value: EquipmentCategory;
  label: string;
  section: "hull" | "sail" | "mast_set" | "foil_set" | "other";
}[] = [
  { value: "hull", label: "Hull", section: "hull" },
  { value: "sail", label: "Sail", section: "sail" },
  { value: "mast", label: "Mast", section: "mast_set" },
  { value: "boom", label: "Boom", section: "mast_set" },
  { value: "sprit", label: "Sprit", section: "mast_set" },
  { value: "daggerboard", label: "Daggerboard", section: "foil_set" },
  { value: "rudder", label: "Rudder", section: "foil_set" },
  { value: "other", label: "Other", section: "other" },
];

export const EQUIPMENT_SECTIONS: {
  id: "hull" | "sail" | "mast_set" | "foil_set" | "other";
  label: string;
  hint: string;
  categories: EquipmentCategory[];
}[] = [
  {
    id: "hull",
    label: "Hull",
    hint: "Boat / hull brand and hull number",
    categories: ["hull"],
  },
  {
    id: "sail",
    label: "Sail",
    hint: "Race and training sails",
    categories: ["sail"],
  },
  {
    id: "mast_set",
    label: "Mast set",
    hint: "Mast, boom & sprit — add each part or a full rig set",
    categories: ["mast", "boom", "sprit"],
  },
  {
    id: "foil_set",
    label: "Foil set",
    hint: "Daggerboard & rudder",
    categories: ["daggerboard", "rudder"],
  },
  {
    id: "other",
    label: "Other",
    hint: "Sheets, tiller, trolley, etc.",
    categories: ["other"],
  },
];

export const EQUIPMENT_TAGS: { value: EquipmentTag; label: string }[] = [
  { value: "racing", label: "Racing" },
  { value: "training", label: "Training" },
  { value: "spare", label: "Spare / Backup" },
  { value: "overseas", label: "Overseas" },
];

export const CONDITION_OPTIONS: {
  value: EquipmentCondition;
  label: string;
}[] = [
  { value: "new", label: "New / Excellent" },
  { value: "good", label: "Good" },
  { value: "fair", label: "Fair" },
  { value: "worn", label: "Needs repair" },
  { value: "replace_soon", label: "Replace soon" },
];

/** Condition chip colors (separate from replacement-alert badges). */
export const CONDITION_STYLES: Record<
  EquipmentCondition,
  { className: string; label: string }
> = {
  new: {
    label: "New / Excellent",
    className: "bg-emerald-500/15 border-emerald-500/30 text-emerald-300",
  },
  good: {
    label: "Good",
    className: "bg-sky-500/15 border-sky-500/30 text-sky-300",
  },
  fair: {
    label: "Fair",
    className: "bg-amber-500/15 border-amber-500/30 text-amber-200",
  },
  worn: {
    label: "Needs repair",
    className: "bg-rose-500/15 border-rose-500/35 text-rose-300",
  },
  replace_soon: {
    label: "Replace soon",
    className: "bg-rose-500/15 border-rose-500/35 text-rose-300",
  },
};

export const WIND_RANGES: { value: WindRange; label: string }[] = [
  { value: "light", label: "Light" },
  { value: "medium", label: "Medium" },
  { value: "heavy", label: "Heavy" },
];

export const BRAND_PRESETS: Partial<Record<EquipmentCategory, string[]>> = {
  hull: ["Winner", "XSP", "Far East", "OnePlus", "Faccenda"],
  sail: ["OneSail", "J-Sail", "Northsail", "CD Sails", "Olimpic Sail"],
  daggerboard: ["DSK", "XSP", "Far East", "OnePlus"],
  rudder: ["DSK", "XSP", "Far East", "OnePlus"],
  mast: ["Optiparts", "Blackgold", "Selden"],
  boom: ["Optiparts", "Blackgold"],
  sprit: ["Optiparts", "Blackgold"],
};

export const BRAND_OTHER = "Other";

export function brandsForCategory(category: EquipmentCategory): string[] {
  return BRAND_PRESETS[category] || [];
}

export function isCustomBrand(
  category: EquipmentCategory,
  brand: string | null | undefined
): boolean {
  const b = String(brand || "").trim();
  if (!b) return false;
  return !brandsForCategory(category).some(
    (p) => p.toLowerCase() === b.toLowerCase()
  );
}

export type EquipmentUsageHistory = {
  regattaId: string | null;
  regattaName: string | null;
  regattaDate: string | null;
  rank: number | null;
  usedOn: string;
};

export type EquipmentItemDto = {
  id: string;
  sailorId: string;
  boatClass: EquipmentBoatClass;
  category: EquipmentCategory;
  brand: string | null;
  model: string | null;
  /** Hull number / sail number / nickname / "what is this" for other */
  label: string | null;
  status: EquipmentStatus;
  condition: EquipmentCondition;
  isPrimary: boolean;
  tags: EquipmentTag[];
  windRange: WindRange | null;
  acquiredOn: string | null;
  retiredOn: string | null;
  useCount: number;
  /** Sessions logged as regatta (source regatta or linked regattaId) */
  regattaUseCount: number;
  /** Sessions logged as training */
  trainingUseCount: number;
  lastUsedOn: string | null;
  notes: string | null;
  badge: EquipmentBadge;
  badgeLabel: string;
  needsAttention: boolean;
  attentionReason: string | null;
  usageHistory?: EquipmentUsageHistory[];
};

export function parseTags(raw: string | null | undefined): EquipmentTag[] {
  if (!raw) return [];
  const allowed = new Set(EQUIPMENT_TAGS.map((t) => t.value));
  // Migrate legacy travel → spare; drop light_air / heavy_air (now wind fields)
  return String(raw)
    .split(/[,|]/)
    .map((s) => s.trim().toLowerCase().replace(/\s+/g, "_"))
    .map((s) => (s === "travel" ? "spare" : s))
    .filter((s) => s !== "light_air" && s !== "heavy_air")
    .filter((s): s is EquipmentTag => allowed.has(s as EquipmentTag));
}

export function serializeTags(tags: string[] | null | undefined): string | null {
  if (!tags?.length) return null;
  const allowed = new Set(EQUIPMENT_TAGS.map((t) => t.value));
  const clean = tags
    .map((t) => String(t).trim().toLowerCase().replace(/\s+/g, "_"))
    .map((t) => (t === "travel" ? "spare" : t))
    .filter((t) => t !== "light_air" && t !== "heavy_air")
    .filter((t) => allowed.has(t as EquipmentTag));
  return clean.length ? [...new Set(clean)].join(",") : null;
}

export function formatUseSummary(item: {
  useCount: number;
  regattaUseCount?: number;
  trainingUseCount?: number;
}): string {
  const r = item.regattaUseCount ?? 0;
  const t = item.trainingUseCount ?? 0;
  const total = item.useCount || r + t;
  if (r === 0 && t === 0) {
    return total === 1 ? "1 use" : `${total} uses`;
  }
  if (total <= 0) return "0 uses";
  // Compact when both present: "22 uses (14R · 8T)"
  if (r > 0 && t > 0) {
    return `${total} uses (${r}R · ${t}T)`;
  }
  if (r > 0) {
    return r === 1 ? "1 regatta" : `${r} regattas`;
  }
  return t === 1 ? "1 training session" : `${t} training sessions`;
}

export function isMastSetCategory(c: EquipmentCategory | string): boolean {
  return c === "mast" || c === "boom" || c === "sprit";
}

export function isFoilCategory(c: EquipmentCategory | string): boolean {
  return c === "daggerboard" || c === "rudder";
}

export function parseWindRange(raw: unknown): WindRange | null {
  const s = String(raw || "")
    .trim()
    .toLowerCase();
  if (s === "light" || s === "medium" || s === "heavy") return s;
  return null;
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
  if (item.category === "sail" && item.brand) {
    const parts = [item.brand, item.model, item.label ? `#${item.label}` : null]
      .filter(Boolean)
      .join(" ");
    if (parts) return parts;
  }
  if (item.category === "hull" && item.brand) {
    return [item.brand, item.label].filter(Boolean).join(" · ") || item.brand;
  }
  if (item.category === "other") {
    return (
      [item.brand, item.label].filter(Boolean).join(" · ") ||
      item.label?.trim() ||
      "Other"
    );
  }
  if (item.label?.trim()) return item.label.trim();
  const parts = [item.brand, item.model].filter(Boolean);
  if (parts.length) return parts.join(" ");
  return categoryLabel(item.category || "other");
}

export function monthsSince(ymd: string | null | undefined): number | null {
  if (!ymd || !/^\d{4}-\d{2}-\d{2}/.test(ymd)) return null;
  const d = new Date(`${ymd.slice(0, 10)}T12:00:00Z`);
  if (Number.isNaN(d.getTime())) return null;
  const now = new Date();
  return (
    (now.getUTCFullYear() - d.getUTCFullYear()) * 12 +
    (now.getUTCMonth() - d.getUTCMonth())
  );
}

/**
 * Replacement badge rules (highest severity wins):
 * New: < 3 months
 * Good: 3–12 months, condition good
 * Check condition: > 12 months OR condition fair
 * Consider replacement: > 18 months OR > 20 uses
 * Replace soon: > 24 months OR worn / replace_soon
 */
export function evaluateEquipmentBadge(item: {
  status: string;
  condition: string;
  useCount: number;
  acquiredOn?: string | null;
}): {
  badge: EquipmentBadge;
  badgeLabel: string;
  needsAttention: boolean;
  attentionReason: string | null;
} {
  if (item.status === "retired") {
    return {
      badge: "good",
      badgeLabel: "Archived",
      needsAttention: false,
      attentionReason: null,
    };
  }

  const age = monthsSince(item.acquiredOn);
  const cond = item.condition;
  const uses = item.useCount || 0;
  const needsRepair = cond === "worn" || cond === "replace_soon";

  // Severity order: replace_soon > consider > check > good > new
  if (needsRepair || (age != null && age > 24)) {
    return {
      badge: "replace_soon",
      badgeLabel: "Replace soon",
      needsAttention: true,
      attentionReason: needsRepair
        ? "Condition needs repair / replace soon"
        : `Over ${age} months old`,
    };
  }
  if ((age != null && age > 18) || uses > 20) {
    return {
      badge: "consider_replacement",
      badgeLabel: "Consider replacement",
      needsAttention: true,
      attentionReason:
        uses > 20
          ? `${uses} regatta uses logged`
          : `Over ${age} months old`,
    };
  }
  if ((age != null && age > 12) || cond === "fair") {
    return {
      badge: "check_condition",
      badgeLabel: "Check condition",
      needsAttention: true,
      attentionReason:
        cond === "fair" ? "Condition: fair" : `Over ${age} months old`,
    };
  }
  if (age != null && age < 3) {
    return {
      badge: "new",
      badgeLabel: "New",
      needsAttention: false,
      attentionReason: null,
    };
  }
  // 3–12 months and good (or unknown age with good)
  return {
    badge: "good",
    badgeLabel: "Good",
    needsAttention: false,
    attentionReason: null,
  };
}

/** @deprecated use evaluateEquipmentBadge */
export function evaluateEquipmentAttention(item: {
  category: string;
  status: string;
  condition: string;
  useCount: number;
  acquiredOn?: string | null;
}) {
  const b = evaluateEquipmentBadge(item);
  return {
    needsAttention: b.needsAttention,
    reason: b.attentionReason,
  };
}

export const BADGE_STYLES: Record<
  EquipmentBadge,
  { className: string }
> = {
  new: {
    className:
      "bg-emerald-500/15 border-emerald-500/30 text-emerald-300",
  },
  good: {
    className: "bg-white/5 border-white/10 text-slate-400",
  },
  check_condition: {
    className: "bg-amber-500/15 border-amber-500/30 text-amber-200",
  },
  consider_replacement: {
    className: "bg-orange-500/15 border-orange-500/35 text-orange-300",
  },
  replace_soon: {
    className: "bg-rose-500/15 border-rose-500/35 text-rose-300",
  },
};

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
  windRange?: string | null;
  acquiredOn: string | null;
  retiredOn: string | null;
  useCount: number | null;
  lastUsedOn: string | null;
  notes: string | null;
  regattaUseCount?: number | null;
  trainingUseCount?: number | null;
}): EquipmentItemDto {
  const tags = parseTags(row.tags);
  const badge = evaluateEquipmentBadge({
    status: row.status,
    condition: row.condition,
    useCount: row.useCount || 0,
    acquiredOn: row.acquiredOn,
  });
  const useCount = Number(row.useCount || 0);
  const regattaUseCount = Number(row.regattaUseCount ?? 0);
  const trainingUseCount = Number(row.trainingUseCount ?? 0);
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
    windRange: parseWindRange(row.windRange),
    acquiredOn: row.acquiredOn ? String(row.acquiredOn).slice(0, 10) : null,
    retiredOn: row.retiredOn ? String(row.retiredOn).slice(0, 10) : null,
    useCount,
    regattaUseCount,
    trainingUseCount,
    lastUsedOn: row.lastUsedOn ? String(row.lastUsedOn).slice(0, 10) : null,
    notes: row.notes,
    badge: badge.badge,
    badgeLabel: badge.badgeLabel,
    needsAttention: badge.needsAttention,
    attentionReason: badge.attentionReason,
  };
}

function sortItems(list: EquipmentItemDto[]) {
  return [...list].sort((a, b) => {
    if (a.isPrimary !== b.isPrimary) return a.isPrimary ? -1 : 1;
    return (b.useCount || 0) - (a.useCount || 0);
  });
}

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
      items: sortItems(byCat.get(cat) || []),
    }))
    .filter((g) => g.items.length > 0);
}

export function groupEquipmentSections(items: EquipmentItemDto[]) {
  return EQUIPMENT_SECTIONS.map((sec) => {
    const byCategory = sec.categories.map((cat) => ({
      category: cat,
      label: categoryLabel(cat),
      items: sortItems(items.filter((i) => i.category === cat)),
    }));
    const allItems = byCategory.flatMap((g) => g.items);
    return {
      ...sec,
      byCategory,
      items: allItems,
      isEmpty: allItems.length === 0,
    };
  });
}
