"use client";

import { useMemo } from "react";
import Link from "next/link";
import { Calendar, RotateCcw, CheckSquare, Square, Trash2, Plus } from "lucide-react";
import {
  CARD,
  NESTED,
  SECTION_KICKER,
  SECTION_TITLE,
  MUTED,
  BODY,
  INK,
  LINK_TEAL,
  PRIMARY_BTN,
} from "./styles";

const DEFAULT_RACE_CHECKLIST_ITEMS = [
  {
    id: "measurement_cert",
    label: "Official class measurement certificate verified & onboard",
  },
  {
    id: "spares_rigging",
    label: "Spare battens, sail ties (2.5mm / 3.0mm) & wind indicator checked",
  },
] as const;

export type PreRaceChecklistProps = {
  activeAthlete: {
    id: string;
  };
  upcomingRegattas: {
    id: string;
    name: string;
    date: string;
    boatClass: string | null;
    division: string | null;
    slug: string | null;
  }[];
  checklistState: Record<string, Record<string, boolean>>;
  customChecklistItems: Record<string, Array<{ id: string; label: string }>>;
  newChecklistText: string;
  onToggleItem: (athleteId: string, itemId: string) => void;
  onAddCustomItem: (athleteId: string) => void;
  onRemoveCustomItem: (athleteId: string, itemId: string) => void;
  onResetChecklist: (athleteId: string) => void;
  onNewChecklistTextChange: (value: string) => void;
};

export function PreRaceChecklist({
  activeAthlete,
  upcomingRegattas,
  checklistState,
  customChecklistItems,
  newChecklistText,
  onToggleItem,
  onAddCustomItem,
  onRemoveCustomItem,
  onResetChecklist,
  onNewChecklistTextChange,
}: PreRaceChecklistProps) {
  return (
    <section className={`${CARD} p-5 space-y-4`}>
      <div className="flex items-start justify-between gap-2">
        <div>
          <p className={SECTION_KICKER}>Race day</p>
          <h3 className={`${SECTION_TITLE} flex items-center gap-2`}>
            <Calendar className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
            Regatta Prep & Checklist
          </h3>
          <p className={`text-[13px] ${MUTED} mt-0.5`}>
            Upcoming calendar & race-day verification items.
          </p>
        </div>
        <button
          type="button"
          onClick={() => onResetChecklist(activeAthlete.id)}
          className={`text-[11px] font-semibold ${MUTED} hover:text-[var(--sp-harbour-shadow)] inline-flex items-center gap-1 p-1`}
          title="Reset checklist"
        >
          <RotateCcw className="h-3 w-3" />
          Reset
        </button>
      </div>

      {upcomingRegattas.length > 0 ? (
        <div className="space-y-2">
          <div className="flex items-center justify-between">
            <p className={`text-[11px] font-black uppercase tracking-wider ${MUTED}`}>
              Upcoming Regattas
            </p>
            <Link href="/calendar" className={LINK_TEAL}>
              Full Calendar →
            </Link>
          </div>
          <div className="space-y-1.5">
            {upcomingRegattas.slice(0, 3).map((reg) => (
              <div
                key={reg.id}
                className={`${NESTED} p-2.5 text-xs flex justify-between items-center gap-2`}
              >
                <div className="min-w-0 flex-1">
                  <p className={`font-bold ${INK} truncate`}>{reg.name}</p>
                  <p className={`text-[13px] ${MUTED} font-mono mt-0.5`}>
                    {reg.date}{" "}
                    {reg.boatClass ? `· ${reg.boatClass}` : ""}
                  </p>
                </div>
                <Link
                  href="/calendar"
                  className="text-xs font-bold text-[var(--sp-harbour-teal)] hover:underline shrink-0"
                >
                  Details
                </Link>
              </div>
            ))}
          </div>
        </div>
      ) : (
        <div className={`rounded-xl border border-dashed border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-3 text-xs ${MUTED} text-center`}>
          No upcoming regattas scheduled.{" "}
          <Link href="/calendar" className="text-[var(--sp-harbour-teal)] font-bold hover:underline">
            View full calendar
          </Link>
        </div>
      )}

      <div className="space-y-2.5 pt-2 border-t border-[var(--sp-cool-veil)]">
        <div className="flex items-center justify-between">
          <p className={`text-[11px] font-black uppercase tracking-wider ${MUTED}`}>
            Race Day Morning Checklist
          </p>
          {(() => {
            const athleteCustom = customChecklistItems[activeAthlete.id] || [];
            const allItems = [...DEFAULT_RACE_CHECKLIST_ITEMS, ...athleteCustom];
            const state = checklistState[activeAthlete.id] || {};
            const doneCount = allItems.filter((item) => state[item.id]).length;
            return (
              <span className="text-[11px] font-bold text-[var(--sp-harbour-teal)]">
                {doneCount}/{allItems.length} ready
              </span>
            );
          })()}
        </div>

        <div className="space-y-1.5">
          {[
            ...DEFAULT_RACE_CHECKLIST_ITEMS.map((item) => ({ ...item, isCustom: false })),
            ...(customChecklistItems[activeAthlete.id] || []).map((item) => ({ ...item, isCustom: true })),
          ].map((item) => {
            const isDone = Boolean(checklistState[activeAthlete.id]?.[item.id]);
            return (
              <div
                key={item.id}
                className={`group w-full rounded-xl p-2.5 text-xs flex items-center justify-between gap-2.5 transition-colors ${
                  isDone
                    ? "bg-[var(--sp-aqua-mist)]/70 border border-[var(--sp-harbour-teal)]/25 text-[var(--sp-harbour-shadow)]"
                    : `${NESTED} ${BODY} hover:border-[var(--sp-harbour-teal)]`
                }`}
              >
                <button
                  type="button"
                  onClick={() => onToggleItem(activeAthlete.id, item.id)}
                  className="flex items-start gap-2.5 flex-1 text-left min-w-0"
                >
                  {isDone ? (
                    <CheckSquare className="h-4 w-4 text-[var(--sp-harbour-teal)] shrink-0 mt-0.5" />
                  ) : (
                    <Square className={`h-4 w-4 ${MUTED} shrink-0 mt-0.5`} />
                  )}
                  <span className={isDone ? "line-through opacity-75" : "font-normal"}>
                    {item.label}
                  </span>
                </button>
                {item.isCustom && (
                  <button
                    type="button"
                    onClick={(e) => {
                      e.stopPropagation();
                      onRemoveCustomItem(activeAthlete.id, item.id);
                    }}
                    className={`opacity-60 group-hover:opacity-100 p-1 ${MUTED} hover:text-rose-600 transition-opacity shrink-0`}
                    title="Remove item"
                  >
                    <Trash2 className="h-3.5 w-3.5" />
                  </button>
                )}
              </div>
            );
          })}
        </div>

        <div className="flex items-center gap-2 pt-1">
          <input
            type="text"
            value={newChecklistText}
            onChange={(e) => onNewChecklistTextChange(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === "Enter") {
                e.preventDefault();
                onAddCustomItem(activeAthlete.id);
              }
            }}
            placeholder="Add race prep item…"
            className="sp-input flex-1 text-xs"
          />
          <button
            type="button"
            onClick={() => onAddCustomItem(activeAthlete.id)}
            disabled={!newChecklistText.trim()}
            className={`${PRIMARY_BTN} px-3 py-1.5 disabled:opacity-40 shrink-0`}
          >
            <Plus className="h-3.5 w-3.5" />
            Add
          </button>
        </div>
      </div>
    </section>
  );
}
