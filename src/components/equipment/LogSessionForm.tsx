import {
  WIND_RANGES,
  categoryLabel,
  displayName,
  type EquipmentItemDto,
  type SessionType,
  type WindRange,
} from "@/lib/equipment";
import { fieldClass, labelClass } from "./constants";
import type { RegattaOption } from "./types";

export function LogSessionForm({
  classItems,
  useItemIds,
  useSessionType,
  useDate,
  useRegattaId,
  useWind,
  regattaOptions,
  busy,
  onToggleItem,
  onSessionType,
  onDate,
  onRegattaId,
  onWind,
  onSave,
}: {
  classItems: EquipmentItemDto[];
  useItemIds: string[];
  useSessionType: SessionType;
  useDate: string;
  useRegattaId: string;
  useWind: WindRange | "";
  regattaOptions: RegattaOption[];
  busy: boolean;
  onToggleItem: (id: string, checked: boolean) => void;
  onSessionType: (t: SessionType) => void;
  onDate: (d: string) => void;
  onRegattaId: (id: string, date?: string) => void;
  onWind: (w: WindRange | "") => void;
  onSave: () => void;
}) {
  return (
    <>
      <div>
        <p className={`${labelClass} mb-1.5`}>Gear used</p>
        <ul className="space-y-1.5 max-h-36 overflow-y-auto rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50 p-1.5">
          {classItems
            .filter((i) => i.status === "active")
            .map((i) => {
              const on = useItemIds.includes(i.id);
              return (
                <label
                  key={i.id}
                  className={`flex items-center gap-2.5 rounded-lg px-2.5 py-2 text-[12px] cursor-pointer transition ${
                    on
                      ? "bg-[var(--sp-harbour-teal)]/10 border border-[var(--sp-harbour-teal)]/40 text-[var(--sp-charcoal)] font-semibold"
                      : "border border-transparent text-[var(--sp-charcoal)] hover:bg-white"
                  }`}
                >
                  <input
                    type="checkbox"
                    checked={on}
                    onChange={(e) => onToggleItem(i.id, e.target.checked)}
                    className="rounded border-[var(--sp-cool-veil)] text-[var(--sp-harbour-teal)] focus:ring-[var(--sp-harbour-teal)]"
                  />
                  <span className="min-w-0 flex-1 truncate font-semibold">
                    {displayName(i)}
                  </span>
                  <span className="text-[10px] text-[var(--sp-slate-soft)] shrink-0">
                    {categoryLabel(i.category)}
                  </span>
                </label>
              );
            })}
        </ul>
      </div>

      <div>
        <p className={`${labelClass} mb-1.5`}>Type</p>
        <div className="grid grid-cols-2 gap-1.5 rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-1">
          {(
            [
              ["regatta", "Regatta"],
              ["training", "Training"],
            ] as const
          ).map(([val, lab]) => (
            <button
              key={val}
              type="button"
              onClick={() => onSessionType(val)}
              className={`rounded-lg py-2 text-[12px] font-bold transition touch-manipulation ${
                useSessionType === val
                  ? val === "regatta"
                    ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                    : "bg-emerald-600 text-white shadow-xs"
                  : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-charcoal)]"
              }`}
            >
              {lab}
            </button>
          ))}
        </div>
      </div>

      <label className={labelClass}>
        Date
        <input
          type="date"
          value={useDate}
          onChange={(e) => onDate(e.target.value)}
          className={fieldClass}
        />
      </label>

      {useSessionType === "regatta" && (
        <label className={labelClass}>
          Link regatta result
          <select
            value={useRegattaId}
            onChange={(e) => {
              const id = e.target.value;
              const r = regattaOptions.find((x) => x.id === id);
              onRegattaId(id, r?.date);
            }}
            className={fieldClass}
          >
            <option value="">Select result…</option>
            {regattaOptions.map((r) => (
              <option key={r.id} value={r.id}>
                {r.date} · {r.name}
              </option>
            ))}
          </select>
        </label>
      )}

      <div>
        <p className={`${labelClass} mb-1.5`}>Wind</p>
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
              onClick={() => onWind(val as WindRange | "")}
              className={`rounded-full px-3 py-1.5 text-[11px] font-bold border touch-manipulation ${
                useWind === val
                  ? "bg-[var(--sp-harbour-teal)] text-white border-[var(--sp-harbour-teal)] shadow-xs"
                  : "border-[var(--sp-cool-veil)] bg-white text-[var(--sp-slate-soft)] hover:border-[var(--sp-charcoal)]/30"
              }`}
            >
              {lab}
            </button>
          ))}
        </div>
      </div>

      <button
        type="button"
        disabled={busy || !useItemIds.length}
        onClick={onSave}
        className="w-full rounded-full bg-[var(--sp-racing-orange)] py-3 text-xs font-bold text-white shadow-sm hover:brightness-105 disabled:opacity-50 touch-manipulation"
      >
        {busy ? "Saving…" : "Save session"}
      </button>
    </>
  );
}
