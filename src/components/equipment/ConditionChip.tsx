import { CONDITION_STYLES, type EquipmentCondition } from "@/lib/equipment";

export function ConditionChip({
  condition,
  interactive = false,
  onClick,
}: {
  condition: EquipmentCondition;
  interactive?: boolean;
  onClick?: () => void;
}) {
  const s = CONDITION_STYLES[condition] || CONDITION_STYLES.good;
  if (interactive && onClick) {
    return (
      <button
        type="button"
        onClick={(e) => {
          e.stopPropagation();
          onClick();
        }}
        title="Click to toggle condition (Race Ready / Practice Only / Needs Repair)"
        className={`inline-flex items-center gap-1 rounded-full border px-2 py-0.5 text-[9px] font-bold transition hover:opacity-80 touch-manipulation cursor-pointer ${s.className}`}
      >
        <span className="h-1.5 w-1.5 rounded-full bg-current opacity-80" />
        {s.label}
      </button>
    );
  }
  return (
    <span
      className={`inline-flex rounded-full border px-1.5 py-0.5 text-[9px] font-bold ${s.className}`}
    >
      {s.label}
    </span>
  );
}
