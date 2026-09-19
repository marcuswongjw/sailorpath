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
  /** Short icon glyph for section headers */
  icon: string;
  categories: EquipmentCategory[];
}[] = [
  {
    id: "hull",
    label: "Hull",
    hint: "Your race and backup boats",
    icon: "🛶",
    categories: ["hull"],
  },
  {
    id: "sail",
    label: "Sail",
    hint: "Race, training & wind-range sails",
    icon: "⛵",
    categories: ["sail"],
  },
  {
    id: "mast_set",
    label: "Mast set",
    hint: "Mast, boom & sprit — or add a full rig",
    icon: "📐",
    categories: ["mast", "boom", "sprit"],
  },
  {
    id: "foil_set",
    label: "Foil set",
    hint: "Daggerboard & rudder",
    icon: "🗡️",
    categories: ["daggerboard", "rudder"],
  },
  {
    id: "other",
    label: "Other",
    hint: "Sheets, tiller, trolley…",
    icon: "🧰",
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
    className: "bg-emerald-50 border-emerald-300 text-emerald-800",
  },
  good: {
    label: "Good",
    className: "bg-teal-50 border-teal-300 text-teal-800",
  },
  fair: {
    label: "Fair",
    className: "bg-amber-50 border-amber-300 text-amber-800",
  },
  worn: {
    label: "Needs repair",
    className: "bg-rose-50 border-rose-300 text-rose-800",
  },
  replace_soon: {
    label: "Replace soon",
    className: "bg-rose-50 border-rose-300 text-rose-800",
  },
};

export const WIND_RANGES: { value: WindRange; label: string }[] = [
  { value: "light", label: "Light" },
  { value: "medium", label: "Medium" },
  { value: "heavy", label: "Heavy" },
];

export const BRAND_PRESETS: Partial<Record<EquipmentCategory, string[]>> = {
  hull: ["Winner", "Far East", "Devoti", "Blueblue", "Nautivela", "XSP", "OnePlus", "Faccenda"],
  sail: ["OneSails", "OneSail", "J-Sail", "Northsail", "CD Sails", "Olimpic Sail", "Quantum"],
  daggerboard: ["DSK", "TEB", "N1 Foils", "Far East", "Optiparts", "XSP", "OnePlus"],
  rudder: ["DSK", "TEB", "N1 Foils", "Far East", "Optiparts", "XSP", "OnePlus"],
  mast: ["Optimax", "Blackgold", "Optiparts", "Selden"],
  boom: ["Optimax", "Blackgold", "Optiparts"],
  sprit: ["Optimax", "Blackgold", "Optiparts"],
};

export const BRAND_OTHER = "Other";

export type QuickEquipmentPreset = {
  id: string;
  name: string;
  subtitle: string;
  boatClass: EquipmentBoatClass;
  category: EquipmentCategory;
  brand: string;
  model: string;
  windRange?: WindRange;
  isPrimary?: boolean;
  bundleItems?: {
    category: EquipmentCategory;
    brand: string;
    model: string;
    label?: string;
  }[];
};

export const YOUTH_EQUIPMENT_PRESETS: QuickEquipmentPreset[] = [
  {
    id: "optimax-mk3",
    name: "Optimax Mk3 Rig (Flex)",
    subtitle: "Complete set: Mast, Boom & Sprit for lighter sailors (<40kg)",
    boatClass: "optimist",
    category: "mast",
    brand: "Optimax",
    model: "Mk3 Flex",
    bundleItems: [
      { category: "mast", brand: "Optimax", model: "Mk3 Flex" },
      { category: "boom", brand: "Optimax", model: "Mk3 (40mm)" },
      { category: "sprit", brand: "Optimax", model: "Mk3 (27mm)" },
    ],
  },
  {
    id: "optimax-mk4",
    name: "Optimax Mk4 Rig (Medium)",
    subtitle: "Complete set: Mast, Boom & Sprit for standard sailors (40-48kg)",
    boatClass: "optimist",
    category: "mast",
    brand: "Optimax",
    model: "Mk4 Medium",
    bundleItems: [
      { category: "mast", brand: "Optimax", model: "Mk4 Medium" },
      { category: "boom", brand: "Optimax", model: "Mk4 (45mm)" },
      { category: "sprit", brand: "Optimax", model: "Mk4 (29mm)" },
    ],
  },
  {
    id: "blackgold-set",
    name: "BlackGold Rig Set",
    subtitle: "Complete set: BlackGold Racing Mast, Boom & Sprit",
    boatClass: "optimist",
    category: "mast",
    brand: "Blackgold",
    model: "Racing Medium",
    bundleItems: [
      { category: "mast", brand: "Blackgold", model: "Medium" },
      { category: "boom", brand: "Blackgold", model: "40mm" },
      { category: "sprit", brand: "Blackgold", model: "Racing" },
    ],
  },
  {
    id: "dsk-flexi",
    name: "DSK FleXi Foil Set",
    subtitle: "Daggerboard & Rudder set (Active flex for rough seas / chop)",
    boatClass: "optimist",
    category: "daggerboard",
    brand: "DSK",
    model: "FleXi",
    bundleItems: [
      { category: "daggerboard", brand: "DSK", model: "FleXi" },
      { category: "rudder", brand: "DSK", model: "FleXi" },
    ],
  },
  {
    id: "dsk-exilis",
    name: "DSK Exilis Foil Set",
    subtitle: "Daggerboard & Rudder set (Stiff, high-lift flat water)",
    boatClass: "optimist",
    category: "daggerboard",
    brand: "DSK",
    model: "Exilis",
    bundleItems: [
      { category: "daggerboard", brand: "DSK", model: "Exilis" },
      { category: "rudder", brand: "DSK", model: "Exilis" },
    ],
  },
  {
    id: "teb-foils",
    name: "TEB Foil Set",
    subtitle: "TEB Racing Daggerboard & Rudder combo",
    boatClass: "optimist",
    category: "daggerboard",
    brand: "TEB",
    model: "Racing",
    bundleItems: [
      { category: "daggerboard", brand: "TEB", model: "Racing" },
      { category: "rudder", brand: "TEB", model: "Racing" },
    ],
  },
  {
    id: "onesails-cd",
    name: "OneSails CD Cut",
    subtitle: "Cross-cut radial racing sail (Heavy/Medium wind)",
    boatClass: "optimist",
    category: "sail",
    brand: "OneSails",
    model: "CD Cut Racing",
    windRange: "medium",
  },
  {
    id: "onesails-vx",
    name: "OneSails VX Cut",
    subtitle: "Power cut racing sail (Light to Medium wind)",
    boatClass: "optimist",
    category: "sail",
    brand: "OneSails",
    model: "VX Cut Racing",
    windRange: "light",
  },
  {
    id: "jsail-blue",
    name: "J-Sail Blue",
    subtitle: "Classic medium-heavy racing sail (Sailors 38-46kg)",
    boatClass: "optimist",
    category: "sail",
    brand: "J-Sail",
    model: "Blue 2.0",
    windRange: "medium",
  },
  {
    id: "jsail-red",
    name: "J-Sail Red",
    subtitle: "Power heavy air sail (Sailors 45kg+)",
    boatClass: "optimist",
    category: "sail",
    brand: "J-Sail",
    model: "Red Racing",
    windRange: "heavy",
  },
  {
    id: "north-v3",
    name: "North Sails V-3",
    subtitle: "Radial racing cut (Medium wind all-rounder)",
    boatClass: "optimist",
    category: "sail",
    brand: "Northsail",
    model: "V-3 Radial",
    windRange: "medium",
  },
  {
    id: "winner-hull",
    name: "Winner Optimist Hull",
    subtitle: "Winner 3D / Den hull",
    boatClass: "optimist",
    category: "hull",
    brand: "Winner",
    model: "3D Racing",
  },
  {
    id: "fareast-hull",
    name: "Far East Champion Hull",
    subtitle: "Far East IODA approved racing hull",
    boatClass: "optimist",
    category: "hull",
    brand: "Far East",
    model: "Champion",
  },
];

export type SimplifiedCondition = "race_ready" | "practice_only" | "needs_attention";

export function toSimplifiedCondition(
  condition: EquipmentCondition | string | null | undefined
): SimplifiedCondition {
  const s = String(condition || "").trim().toLowerCase();
  if (s === "new" || s === "good" || s === "race_ready" || s === "excellent") return "race_ready";
  if (s === "fair" || s === "practice_only" || s === "practice") return "practice_only";
  return "needs_attention";
}

export function fromSimplifiedCondition(
  simplified: SimplifiedCondition
): EquipmentCondition {
  if (simplified === "race_ready") return "good";
  if (simplified === "practice_only") return "fair";
  return "worn";
}

export function normalizeEquipmentCondition(val: unknown): EquipmentCondition {
  const s = String(val || "").trim().toLowerCase();
  if (s === "new" || s === "excellent") return "new";
  if (s === "good" || s === "race_ready") return "good";
  if (s === "fair" || s === "practice_only" || s === "practice") return "fair";
  if (s === "worn" || s === "needs_attention" || s === "needs_repair" || s === "repair") return "worn";
  if (s === "replace_soon" || s === "replace") return "replace_soon";
  return "good";
}

export const SIMPLIFIED_CONDITION_META: Record<
  SimplifiedCondition,
  { label: string; shortLabel: string; bg: string; text: string; border: string; dot: string }
> = {
  race_ready: {
    label: "Race Ready (Excellent / Good)",
    shortLabel: "Race Ready",
    bg: "bg-emerald-50",
    text: "text-emerald-800",
    border: "border-emerald-300",
    dot: "bg-emerald-500",
  },
  practice_only: {
    label: "Practice / Training Only",
    shortLabel: "Practice Only",
    bg: "bg-amber-50",
    text: "text-amber-800",
    border: "border-amber-300",
    dot: "bg-amber-500",
  },
  needs_attention: {
    label: "Needs Repair / Replacement",
    shortLabel: "Needs Repair",
    bg: "bg-rose-50",
    text: "text-rose-800",
    border: "border-rose-300",
    dot: "bg-rose-500",
  },
};

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

/** Resolve the brand string to persist from form select + optional custom field. */
export function resolveBrand(
  category: EquipmentCategory,
  brand: string,
  brandCustom: string
): string {
  if (category === "other") return brand.trim();
  if (brand === BRAND_OTHER || isCustomBrand(category, brand)) {
    return brandCustom.trim() || brand.trim();
  }
  return brand.trim();
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
    className: "bg-emerald-50 border-emerald-300 text-emerald-800",
  },
  good: {
    className: "bg-slate-100 border-slate-200 text-slate-700",
  },
  check_condition: {
    className: "bg-amber-50 border-amber-300 text-amber-800",
  },
  consider_replacement: {
    className: "bg-orange-50 border-orange-300 text-orange-800",
  },
  replace_soon: {
    className: "bg-rose-50 border-rose-300 text-rose-800",
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
