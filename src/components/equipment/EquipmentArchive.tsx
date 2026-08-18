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
    <details className="group rounded-xl border border-white/5 bg-black/15 open:bg-black/20">
      <summary className="cursor-pointer list-none flex items-center justify-between gap-2 px-3.5 py-2.5 text-[11px] font-semibold text-slate-500 touch-manipulation">
        <span className="inline-flex items-center gap-1.5">
          <Archive className="h-3.5 w-3.5" />
          Past equipment ({archived.length})
        </span>
        <ChevronDown className="h-3.5 w-3.5 group-open:rotate-180 transition" />
      </summary>
      <ul className="px-3.5 pb-3 space-y-1.5 border-t border-white/5 pt-2">
        {archived.map((r) => (
          <li
            key={r.id}
            className="text-[11px] text-slate-500 flex items-center justify-between gap-2"
          >
            <span>
              {displayName(r)}
              <span className="text-slate-600">
                {" "}
                · {categoryLabel(r.category)}
              </span>
            </span>
            <button
              type="button"
              onClick={() => onEdit(r)}
              className="text-[10px] font-bold text-slate-400 hover:text-white"
            >
              Edit
            </button>
          </li>
        ))}
      </ul>
    </details>
  );
}
