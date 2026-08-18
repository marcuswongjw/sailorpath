import { AlertTriangle, ChevronDown, ChevronUp } from "lucide-react";
import { displayName, type EquipmentItemDto } from "@/lib/equipment";
import { BadgeChip } from "./BadgeChip";

export function EquipmentAlerts({
  alerts,
  open,
  onToggleOpen,
  onEdit,
}: {
  alerts: EquipmentItemDto[];
  open: boolean;
  onToggleOpen: () => void;
  onEdit: (item: EquipmentItemDto) => void;
}) {
  if (alerts.length === 0) return null;

  return (
    <div className="rounded-xl border border-amber-500/30 bg-gradient-to-br from-amber-500/10 to-transparent overflow-hidden">
      <button
        type="button"
        onClick={onToggleOpen}
        className="w-full flex items-center justify-between gap-2 px-3 py-2.5 text-left touch-manipulation"
      >
        <span className="text-[11px] font-bold text-amber-200 flex items-center gap-1.5">
          <AlertTriangle className="h-3.5 w-3.5 shrink-0" />
          {alerts.length} replacement alert
          {alerts.length === 1 ? "" : "s"}
        </span>
        {open ? (
          <ChevronUp className="h-3.5 w-3.5 text-amber-300/70" />
        ) : (
          <ChevronDown className="h-3.5 w-3.5 text-amber-300/70" />
        )}
      </button>
      {open && (
        <ul className="px-3 pb-2.5 space-y-1.5 border-t border-amber-500/15 pt-2">
          {alerts.slice(0, 5).map((a) => (
            <li key={a.id}>
              <button
                type="button"
                onClick={() => onEdit(a)}
                className="w-full text-left rounded-lg px-2 py-1.5 hover:bg-amber-500/10 transition text-[11px] text-amber-50/90 flex items-center gap-2 flex-wrap"
              >
                <BadgeChip badge={a.badge} label={a.badgeLabel} />
                <span className="font-semibold text-white">
                  {displayName(a)}
                </span>
                {a.attentionReason && (
                  <span className="text-amber-200/60">
                    — {a.attentionReason}
                  </span>
                )}
              </button>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
