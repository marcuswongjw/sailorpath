import { CONDITION_STYLES, type EquipmentCondition } from "@/lib/equipment";

export function ConditionChip({ condition }: { condition: EquipmentCondition }) {
  const s = CONDITION_STYLES[condition] || CONDITION_STYLES.good;
  return (
    <span
      className={`inline-flex rounded-full border px-1.5 py-0.5 text-[9px] font-bold ${s.className}`}
    >
      {s.label}
    </span>
  );
}
