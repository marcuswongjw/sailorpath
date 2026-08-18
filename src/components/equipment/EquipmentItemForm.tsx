import { ChevronDown, ChevronUp } from "lucide-react";
import {
  BRAND_OTHER,
  CONDITION_OPTIONS,
  EQUIPMENT_SECTIONS,
  EQUIPMENT_TAGS,
  WIND_RANGES,
  brandsForCategory,
  categoryLabel,
  isCustomBrand,
  isMastSetCategory,
  type EquipmentCategory,
  type EquipmentCondition,
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

  return (
    <>
      {modal === "quick" && (
        <div>
          <p className={`${labelClass} mb-1.5`}>Part</p>
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
                className={`rounded-full px-2.5 py-1.5 text-[10px] font-bold border touch-manipulation ${
                  form.category === cat
                    ? "bg-orange-500/20 border-orange-500/40 text-orange-100"
                    : "border-white/10 text-slate-400"
                }`}
              >
                {categoryLabel(cat)}
              </button>
            ))}
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
                  className={`rounded-full px-3 py-1.5 text-[11px] font-bold border touch-manipulation ${
                    form.windRange === val
                      ? "bg-sky-500/20 border-sky-500/40 text-sky-100"
                      : "border-white/10 text-slate-400"
                  }`}
                >
                  {lab}
                </button>
              ))}
            </div>
          </div>
        </>
      )}

      {(showMore || modal === "edit") && (
        <div className="space-y-3 border-t border-white/5 pt-3">
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
              Condition
              <select
                value={form.condition}
                onChange={(e) =>
                  onChange({
                    ...form,
                    condition: e.target.value as EquipmentCondition,
                  })
                }
                className={fieldClass}
              >
                {CONDITION_OPTIONS.map((c) => (
                  <option key={c.value} value={c.value}>
                    {c.label}
                  </option>
                ))}
              </select>
            </label>
          </div>
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
          <div>
            <p className={`${labelClass} mb-1.5`}>Tags</p>
            <div className="flex flex-wrap gap-1.5">
              {EQUIPMENT_TAGS.map((t) => (
                <button
                  key={t.value}
                  type="button"
                  onClick={() => onToggleTag(t.value)}
                  className={`rounded-full px-2.5 py-1.5 text-[10px] font-bold border touch-manipulation ${
                    form.tags.includes(t.value)
                      ? "bg-orange-500/20 border-orange-500/40 text-orange-200"
                      : "border-white/10 text-slate-400"
                  }`}
                >
                  {t.label}
                </button>
              ))}
            </div>
          </div>
          <label className="flex items-center gap-2.5 text-[12px] text-slate-300 rounded-xl border border-white/5 bg-black/20 px-3 py-2.5 cursor-pointer">
            <input
              type="checkbox"
              checked={form.isPrimary}
              onChange={(e) =>
                onChange({ ...form, isPrimary: e.target.checked })
              }
              className="rounded border-white/20"
            />
            <span>
              <span className="font-semibold text-white">Primary</span>
              <span className="text-slate-500">
                {" "}
                — main {categoryLabel(form.category).toLowerCase()} for race
                day
              </span>
            </span>
          </label>
          <label className={labelClass}>
            Notes
            <textarea
              value={form.notes}
              onChange={(e) => onChange({ ...form, notes: e.target.value })}
              rows={2}
              placeholder="Optional"
              className={`${fieldClass} resize-none`}
            />
          </label>
        </div>
      )}

      {modal === "quick" && !showMore && (
        <button
          type="button"
          onClick={() => onShowMore(true)}
          className="flex items-center gap-1 text-[11px] font-bold text-slate-400 hover:text-slate-200 touch-manipulation"
        >
          <ChevronDown className="h-3.5 w-3.5" />
          More details
        </button>
      )}
      {modal === "quick" && showMore && (
        <button
          type="button"
          onClick={() => onShowMore(false)}
          className="flex items-center gap-1 text-[11px] font-bold text-slate-400 hover:text-slate-200 touch-manipulation"
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
