import { Archive, ChevronDown } from "lucide-react";
import {
  categoryLabel,
  displayName,
  type EquipmentItemDto,
} from "@/lib/equipment";

export function EquipmentArchive({
  archived,
  onEdit,
}: {
  archived: EquipmentItemDto[];
  onEdit: (item: EquipmentItemDto) => void;
}) {
  if (archived.length === 0) return null;

  return (
    <details className="group rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/60 open:bg-[var(--sp-sailcloth)]">
      <summary className="cursor-pointer list-none flex items-center justify-between gap-2 px-3.5 py-2.5 text-[13px] font-semibold text-[var(--sp-charcoal)] touch-manipulation">
        <span className="inline-flex items-center gap-1.5">
          <Archive className="h-3.5 w-3.5 text-[var(--sp-slate-soft)]" />
          Past equipment ({archived.length})
        </span>
        <ChevronDown className="h-3.5 w-3.5 text-[var(--sp-slate-soft)] group-open:rotate-180 transition" />
      </summary>
      <ul className="px-3.5 pb-3 space-y-1.5 border-t border-[var(--sp-cool-veil)] pt-2">
        {archived.map((r) => (
          <li
            key={r.id}
            className="text-[13px] text-[var(--sp-slate-soft)] flex items-center justify-between gap-2"
          >
            <span>
              <span className="text-[var(--sp-charcoal)] font-medium">{displayName(r)}</span>
              <span> · {categoryLabel(r.category)}</span>
            </span>
            <button
              type="button"
              onClick={() => onEdit(r)}
              className="text-[10px] font-bold text-[var(--sp-harbour-teal)] hover:underline"
            >
              Edit
            </button>
          </li>
        ))}
      </ul>
    </details>
  );
}
