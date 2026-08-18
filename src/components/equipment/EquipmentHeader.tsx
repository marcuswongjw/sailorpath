import { Plus, Settings } from "lucide-react";
import { secondaryBtn } from "./constants";

export function EquipmentHeader({
  activeCount,
  primaryCount,
  alertCount,
  isOwner,
  canLogSession,
  onLogSession,
  onAdd,
}: {
  activeCount: number;
  primaryCount: number;
  alertCount: number;
  isOwner: boolean;
  canLogSession: boolean;
  onLogSession: () => void;
  onAdd: () => void;
}) {
  return (
    <div className="flex items-start justify-between gap-3 flex-wrap">
      <div className="min-w-0 flex-1">
        <div className="flex items-center gap-2 mb-1">
          <Settings className="h-3.5 w-3.5 text-orange-400/90 shrink-0" />
          <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
            Equipment
          </h2>
          {activeCount > 0 && (
            <span className="rounded-full bg-white/5 border border-white/10 px-2 py-0.5 text-[10px] font-bold text-slate-400 tabular-nums">
              {activeCount}
            </span>
          )}
        </div>
        <p className="text-[11px] text-neutral-500 max-w-md leading-relaxed">
          Track every hull, sail, foil, and rig. Know what to rig on race day
          — and when it&apos;s time to replace.
        </p>
        {activeCount > 0 && (
          <p className="text-[10px] text-slate-600 mt-1.5 tabular-nums">
            {primaryCount} primary
            {alertCount > 0 ? ` · ${alertCount} need attention` : ""}
          </p>
        )}
      </div>
      {isOwner && (
        <div className="flex flex-wrap gap-2 shrink-0">
          <button
            type="button"
            onClick={onLogSession}
            disabled={!canLogSession}
            className={secondaryBtn}
          >
            Log session
          </button>
          <button
            type="button"
            onClick={onAdd}
            className="rounded-full bg-orange-600 px-3.5 py-2 text-[11px] font-bold text-white inline-flex items-center gap-1 touch-manipulation min-h-[2.25rem] shadow-md shadow-orange-950/30"
          >
            <Plus className="h-3.5 w-3.5" />
            Add
          </button>
        </div>
      )}
    </div>
  );
}
