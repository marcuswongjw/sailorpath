import { EQUIPMENT_TAGS, type EquipmentTag } from "@/lib/equipment";
import { fieldClass, labelClass, primaryBtn } from "./constants";

export function BulkTagForm({
  bulkTag,
  busy,
  onChange,
  onApply,
}: {
  bulkTag: EquipmentTag;
  busy: boolean;
  onChange: (tag: EquipmentTag) => void;
  onApply: () => void;
}) {
  return (
    <>
      <label className={labelClass}>
        Tag
        <select
          value={bulkTag}
          onChange={(e) => onChange(e.target.value as EquipmentTag)}
          className={fieldClass}
        >
          {EQUIPMENT_TAGS.map((t) => (
            <option key={t.value} value={t.value}>
              {t.label}
            </option>
          ))}
        </select>
      </label>
      <button
        type="button"
        disabled={busy}
        onClick={onApply}
        className={primaryBtn}
      >
        Apply tag
      </button>
    </>
  );
}
