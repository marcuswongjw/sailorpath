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
          <Settings className="h-4 w-4 text-[var(--sp-racing-orange)] shrink-0" />
          <h2 className="text-xs font-bold uppercase tracking-[0.14em] text-[var(--sp-harbour-shadow)]">
            Equipment
          </h2>
          {activeCount > 0 && (
            <span className="rounded-full bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-2 py-0.5 text-[10px] font-bold text-[var(--sp-charcoal)] tabular-nums">
              {activeCount}
            </span>
          )}
        </div>
        <p className="text-xs text-[var(--sp-slate-soft)] max-w-md leading-relaxed">
          Track every hull, sail, foil, and rig. Know what to rig on race day
          — and when it&apos;s time to replace.
        </p>
        {activeCount > 0 && (
          <p className="text-xs text-[var(--sp-charcoal)] font-semibold mt-1.5 tabular-nums">
            {primaryCount} primary
            {alertCount > 0 ? (
              <span className="text-amber-700 font-bold"> · {alertCount} need attention</span>
            ) : null}
          </p>
        )}
        {isOwner && !canLogSession && (
          <p className="text-xs text-amber-800 bg-amber-50 border border-amber-200 rounded-lg px-2.5 py-1 mt-2 leading-snug max-w-md">
            Tip: add at least one active item, then use{" "}
            <strong className="text-amber-900 font-bold">Log session</strong> after each
            race to track wear.
          </p>
        )}
        {isOwner && canLogSession && activeCount > 0 && activeCount <= 2 && (
          <p className="text-xs text-[var(--sp-slate-soft)] mt-1.5 leading-snug max-w-md">
            Tip: Log session after race day so you know which sail/foil saw
            action.
          </p>
        )}
      </div>
      {isOwner && (
        <div className="flex flex-col items-stretch sm:items-end gap-1.5 shrink-0">
          <div className="flex flex-wrap gap-2 justify-end">
            <button
              type="button"
              onClick={onLogSession}
              disabled={!canLogSession}
              title={
                canLogSession
                  ? "Log race-day or training use"
                  : "Add active gear first"
              }
              className={secondaryBtn}
            >
              Log session
            </button>
            <button
              type="button"
              onClick={onAdd}
              className="rounded-full bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] px-4 py-2 text-xs font-bold text-white inline-flex items-center gap-1 shadow-xs transition-colors touch-manipulation min-h-[2.25rem]"
            >
              <Plus className="h-3.5 w-3.5" />
              Add
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
