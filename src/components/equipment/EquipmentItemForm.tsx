import { ChevronDown, ChevronUp, Sparkles } from "lucide-react";
import {
  BRAND_OTHER,
  EQUIPMENT_SECTIONS,
  EQUIPMENT_TAGS,
  WIND_RANGES,
  YOUTH_EQUIPMENT_PRESETS,
  toSimplifiedCondition,
  fromSimplifiedCondition,
  SIMPLIFIED_CONDITION_META,
  type SimplifiedCondition,
  brandsForCategory,
  categoryLabel,
  isCustomBrand,
  isMastSetCategory,
  type EquipmentCategory,
  type EquipmentStatus,
  type EquipmentTag,
  type WindRange,
} from "@/lib/equipment";
import { fieldClass, labelClass, primaryBtn } from "./constants";
import type { EquipmentFormState } from "./types";

export function EquipmentItemForm({
  modal,
  form,
  showMore,
  busy,
  editing,
  onChange,
  onToggleTag,
  onShowMore,
  onSave,
}: {
  modal: "quick" | "edit" | "advanced";
  form: EquipmentFormState;
  showMore: boolean;
  busy: boolean;
  editing: boolean;
  onChange: (next: EquipmentFormState) => void;
  onToggleTag: (t: EquipmentTag) => void;
  onShowMore: (v: boolean) => void;
  onSave: () => void;
}) {
  const brandPresets = brandsForCategory(form.category);
  const showCustomBrand =
    form.brand === BRAND_OTHER ||
    (form.brand !== "" && isCustomBrand(form.category, form.brand));

  const setCategory = (category: EquipmentCategory) => {
    const presets = brandsForCategory(category);
    onChange({
      ...form,
      category,
      brand: category === "other" ? "" : presets[0] || BRAND_OTHER,
      brandCustom: "",
      model: modal === "quick" ? "" : form.model,
      label: modal === "quick" ? "" : form.label,
      windRange: modal === "quick" ? "" : form.windRange,
    });
  };

  const applyPreset = (preset: (typeof YOUTH_EQUIPMENT_PRESETS)[number]) => {
    onChange({
      ...form,
      category: preset.category,
      brand: preset.brand,
      brandCustom: "",
      model: preset.model,
      windRange: preset.windRange || form.windRange,
      condition: "good",
      isPrimary: true,
      status: "active",
    });
  };

  const currentSimplified = toSimplifiedCondition(form.condition);

  return (
    <>
      {modal === "quick" && (
        <div className="space-y-3 pb-2 border-b border-white/5">
          <div>
            <div className="flex items-center gap-1.5 mb-1.5">
              <Sparkles className="h-3.5 w-3.5 text-orange-400" />
              <p className="text-[13px] font-bold text-slate-200">
                1-Click Popular Gear Presets
              </p>
            </div>
            <div className="flex flex-wrap gap-1.5">
              {YOUTH_EQUIPMENT_PRESETS.slice(0, 6).map((p) => (
                <button
                  key={p.id}
                  type="button"
                  onClick={() => applyPreset(p)}
                  className={`rounded-lg px-2.5 py-1 text-[13px] font-bold border transition touch-manipulation ${
                    form.brand.toLowerCase() === p.brand.toLowerCase() &&
                    form.model.toLowerCase() === p.model.toLowerCase()
                      ? "bg-[var(--sp-racing-mist)]/30 border-[var(--sp-racing-orange)] text-[var(--sp-racing-orange)] shadow-xs"
                      : "border-[var(--sp-cool-veil)] bg-white text-[var(--sp-charcoal)] hover:border-[var(--sp-harbour-teal)] shadow-2xs"
                  }`}
                >
                  {p.name}
                </button>
              ))}
            </div>
          </div>

          <div>
            <p className={`${labelClass} mb-1.5`}>Or select part category</p>
            <div className="flex flex-wrap gap-1.5">
              {(
                [
                  "hull",
                  "sail",
                  "mast",
                  "boom",
                  "sprit",
                  "daggerboard",
                  "rudder",
                  "other",
                ] as EquipmentCategory[]
              ).map((cat) => (
                <button
                  key={cat}
                  type="button"
                  onClick={() => setCategory(cat)}
                  className={`rounded-full px-2.5 py-1 text-[13px] font-bold border touch-manipulation transition-colors ${
                    form.category === cat
                      ? "bg-[var(--sp-racing-mist)]/30 border-[var(--sp-racing-orange)] text-[var(--sp-racing-orange)] shadow-xs"
                      : "border-[var(--sp-cool-veil)] bg-white text-[var(--sp-charcoal)] hover:border-[var(--sp-harbour-teal)] shadow-2xs"
                  }`}
                >
                  {categoryLabel(cat)}
                </button>
              ))}
            </div>
          </div>
        </div>
      )}

      {modal === "edit" && (
        <label className={labelClass}>
          Part
          <select
            value={form.category}
            onChange={(e) =>
              setCategory(e.target.value as EquipmentCategory)
            }
            className={fieldClass}
          >
            {EQUIPMENT_SECTIONS.map((sec) => (
              <optgroup key={sec.id} label={sec.label}>
                {sec.categories.map((cat) => (
                  <option key={cat} value={cat}>
                    {categoryLabel(cat)}
                  </option>
                ))}
              </optgroup>
            ))}
          </select>
        </label>
      )}

      {form.category === "other" ? (
        <label className={labelClass}>
          Brand
          <input
            value={form.brand}
            onChange={(e) => onChange({ ...form, brand: e.target.value })}
            placeholder="Brand name"
            className={fieldClass}
          />
        </label>
      ) : (
        <label className={labelClass}>
          Brand
          <select
            value={showCustomBrand ? BRAND_OTHER : form.brand || BRAND_OTHER}
            onChange={(e) =>
              onChange({
                ...form,
                brand: e.target.value,
                brandCustom:
                  e.target.value === BRAND_OTHER ? form.brandCustom : "",
              })
            }
            className={fieldClass}
          >
            {brandPresets.map((b) => (
              <option key={b} value={b}>
                {b}
              </option>
            ))}
            <option value={BRAND_OTHER}>Other…</option>
          </select>
        </label>
      )}

      {form.category !== "other" && showCustomBrand && (
        <input
          value={form.brandCustom}
          onChange={(e) =>
            onChange({
              ...form,
              brandCustom: e.target.value,
              brand: BRAND_OTHER,
            })
          }
          placeholder="Other brand name"
          className={fieldClass}
        />
      )}

      {form.category === "other" && (
        <label className={labelClass}>
          What is this?
          <input
            value={form.label}
            onChange={(e) => onChange({ ...form, label: e.target.value })}
            placeholder="e.g. tiller extension, trolley"
            className={fieldClass}
          />
        </label>
      )}

      {(form.category === "hull" || form.category === "sail") && (
        <label className={labelClass}>
          {form.category === "hull" ? "Hull number" : "Sail number"}
          <input
            value={form.label}
            onChange={(e) => onChange({ ...form, label: e.target.value })}
            placeholder={form.category === "hull" ? "SZ 12345" : "e.g. 115"}
            className={fieldClass}
          />
        </label>
      )}

      {isMastSetCategory(form.category) && (
        <label className={labelClass}>
          Model
          <input
            value={form.model}
            onChange={(e) => onChange({ ...form, model: e.target.value })}
            placeholder="Optional"
            className={fieldClass}
          />
        </label>
      )}

      {form.category === "sail" && (
        <>
          <label className={labelClass}>
            Sail cut / series
            <input
              value={form.model}
              onChange={(e) => onChange({ ...form, model: e.target.value })}
              placeholder='e.g. "Racing", "Power"'
              className={fieldClass}
            />
          </label>
          <div>
            <p className={`${labelClass} mb-1.5`}>Wind range</p>
            <div className="flex flex-wrap gap-1.5">
              {(
                [
                  ["", "—"],
                  ...WIND_RANGES.map((w) => [w.value, w.label] as const),
                ] as const
              ).map(([val, lab]) => (
                <button
                  key={lab}
                  type="button"
                  onClick={() =>
                    onChange({
                      ...form,
                      windRange: val as WindRange | "",
                    })
                  }
                  className={`rounded-full px-3 py-1.5 text-[13px] font-bold border touch-manipulation ${
                    form.windRange === val
                      ? "bg-sky-50 border-sky-300 text-sky-900"
                      : "border-[var(--sp-cool-veil)] text-[var(--sp-slate-soft)] bg-white hover:border-[var(--sp-charcoal)]/30"
                  }`}
                >
                  {lab}
                </button>
              ))}
            </div>
          </div>
        </>
      )}

      {/* Primary & Condition: First-class controls visible directly */}
      <div className="space-y-2.5 pt-1">
        <div>
          <p className={`${labelClass} mb-1.5`}>Condition</p>
          <div className="grid grid-cols-3 gap-1.5">
            {(["race_ready", "practice_only", "needs_attention"] as SimplifiedCondition[]).map(
              (key) => {
                const meta = SIMPLIFIED_CONDITION_META[key];
                const active = currentSimplified === key;
                return (
                  <button
                    key={key}
                    type="button"
                    onClick={() =>
                      onChange({
                        ...form,
                        condition: fromSimplifiedCondition(key),
                      })
                    }
                    className={`rounded-xl px-2 py-2 text-center border transition touch-manipulation flex flex-col items-center gap-1 ${
                      active
                        ? `${meta.bg} ${meta.border} ${meta.text} ring-2 ring-[var(--sp-harbour-teal)]/30`
                        : "border-[var(--sp-cool-veil)] bg-white text-[var(--sp-slate-soft)] hover:border-[var(--sp-charcoal)]/30"
                    }`}
                  >
                    <span className={`h-2 w-2 rounded-full ${meta.dot}`} />
                    <span className="text-[13px] font-bold leading-tight">
                      {meta.shortLabel}
                    </span>
                  </button>
                );
              }
            )}
          </div>
        </div>

        <label className="flex items-center gap-2.5 text-[12px] text-[var(--sp-charcoal)] rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2.5 cursor-pointer hover:border-[var(--sp-charcoal)]/30">
          <input
            type="checkbox"
            checked={form.isPrimary}
            onChange={(e) =>
              onChange({ ...form, isPrimary: e.target.checked })
            }
            className="rounded border-[var(--sp-cool-veil)] text-[var(--sp-racing-orange)] focus:ring-[var(--sp-racing-orange)]"
          />
          <div>
            <span className="font-semibold text-[var(--sp-charcoal)]">⭐ Primary Race-Day Gear</span>
            <p className="text-[13px] text-[var(--sp-slate-soft)]">
              Rigged for competition (used on race day)
            </p>
          </div>
        </label>
      </div>

      {(showMore || modal === "edit") && (
        <div className="space-y-3 border-t border-[var(--sp-cool-veil)] pt-3">
          <div className="grid grid-cols-2 gap-2.5">
            <label className={labelClass}>
              Status
              <select
                value={form.status}
                onChange={(e) =>
                  onChange({
                    ...form,
                    status: e.target.value as EquipmentStatus,
                  })
                }
                className={fieldClass}
              >
                <option value="active">Active</option>
                <option value="backup">Backup</option>
                <option value="retired">Archived</option>
              </select>
            </label>
            <label className={labelClass}>
              Acquired
              <input
                type="date"
                value={form.acquiredOn}
                onChange={(e) =>
                  onChange({ ...form, acquiredOn: e.target.value })
                }
                className={fieldClass}
              />
            </label>
          </div>
          <div>
            <p className={`${labelClass} mb-1.5`}>Tags</p>
            <div className="flex flex-wrap gap-1.5">
              {EQUIPMENT_TAGS.map((t) => (
                <button
                  key={t.value}
                  type="button"
                  onClick={() => onToggleTag(t.value)}
                  className={`rounded-full px-2.5 py-1.5 text-[13px] font-bold border touch-manipulation ${
                    form.tags.includes(t.value)
                      ? "bg-orange-50 border-orange-300 text-orange-900"
                      : "border-[var(--sp-cool-veil)] text-[var(--sp-slate-soft)] bg-white hover:border-[var(--sp-charcoal)]/30"
                  }`}
                >
                  {t.label}
                </button>
              ))}
            </div>
          </div>
          <label className={labelClass}>
            Notes
            <textarea
              value={form.notes}
              onChange={(e) => onChange({ ...form, notes: e.target.value })}
              rows={2}
              placeholder="Optional maintenance notes or serial number"
              className={`${fieldClass} resize-none`}
            />
          </label>
        </div>
      )}

      {modal === "quick" && !showMore && (
        <button
          type="button"
          onClick={() => onShowMore(true)}
          className="flex items-center gap-1 text-[11px] font-bold text-[var(--sp-slate-soft)] hover:text-[var(--sp-charcoal)] touch-manipulation"
        >
          <ChevronDown className="h-3.5 w-3.5" />
          More details
        </button>
      )}
      {modal === "quick" && showMore && (
        <button
          type="button"
          onClick={() => onShowMore(false)}
          className="flex items-center gap-1 text-[11px] font-bold text-[var(--sp-slate-soft)] hover:text-[var(--sp-charcoal)] touch-manipulation"
        >
          <ChevronUp className="h-3.5 w-3.5" />
          Fewer details
        </button>
      )}

      <button
        type="button"
        disabled={busy}
        onClick={onSave}
        className={primaryBtn}
      >
        {busy ? "Saving…" : editing ? "Save changes" : "Save"}
      </button>
    </>
  );
}
