import { BRAND_OTHER, brandsForCategory } from "@/lib/equipment";
import { fieldClass, labelClass, primaryBtn } from "./constants";

export function FullRigForm({
  brand,
  brandCustom,
  busy,
  onBrandChange,
  onBrandCustomChange,
  onSave,
}: {
  brand: string;
  brandCustom: string;
  busy: boolean;
  onBrandChange: (v: string) => void;
  onBrandCustomChange: (v: string) => void;
  onSave: () => void;
}) {
  return (
    <>
      <label className={labelClass}>
        Brand
        <select
          value={brand}
          onChange={(e) => onBrandChange(e.target.value)}
          className={fieldClass}
        >
          {brandsForCategory("mast").map((b) => (
            <option key={b} value={b}>
              {b}
            </option>
          ))}
          <option value={BRAND_OTHER}>Other…</option>
        </select>
      </label>
      {brand === BRAND_OTHER && (
        <input
          value={brandCustom}
          onChange={(e) => onBrandCustomChange(e.target.value)}
          placeholder="Brand name"
          className={fieldClass}
        />
      )}
      <p className="text-[11px] text-slate-500 leading-relaxed">
        Creates primary mast, boom, and sprit with the same brand — typical for
        Optimist rig replacements.
      </p>
      <button
        type="button"
        disabled={busy}
        onClick={onSave}
        className={primaryBtn}
      >
        {busy ? "Saving…" : "Add mast + boom + sprit"}
      </button>
    </>
  );
}
