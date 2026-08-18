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
        <ul className="space-y-1.5 max-h-36 overflow-y-auto rounded-xl border border-white/5 bg-black/20 p-1.5">
          {classItems
            .filter((i) => i.status === "active")
            .map((i) => {
              const on = useItemIds.includes(i.id);
              return (
                <label
                  key={i.id}
                  className={`flex items-center gap-2.5 rounded-lg px-2.5 py-2 text-[12px] cursor-pointer transition ${
                    on
                      ? "bg-sky-500/15 border border-sky-500/25 text-white"
                      : "border border-transparent text-slate-300 hover:bg-white/[0.03]"
                  }`}
                >
                  <input
                    type="checkbox"
                    checked={on}
                    onChange={(e) => onToggleItem(i.id, e.target.checked)}
                    className="rounded border-white/20"
                  />
                  <span className="min-w-0 flex-1 truncate font-semibold">
                    {displayName(i)}
                  </span>
                  <span className="text-[10px] text-slate-500 shrink-0">
                    {categoryLabel(i.category)}
                  </span>
                </label>
              );
            })}
        </ul>
      </div>

      <div>
        <p className={`${labelClass} mb-1.5`}>Type</p>
        <div className="grid grid-cols-2 gap-1.5 rounded-xl border border-white/10 bg-black/25 p-1">
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
                    ? "bg-sky-600 text-white"
                    : "bg-emerald-600 text-white"
                  : "text-slate-400 hover:text-white"
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
                  ? "bg-white/10 border-white/25 text-white"
                  : "border-white/10 text-slate-400"
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
        className="w-full rounded-full bg-sky-600 py-3 text-xs font-bold text-white disabled:opacity-50 touch-manipulation"
      >
        {busy ? "Saving…" : "Save session"}
      </button>
    </>
  );
}
