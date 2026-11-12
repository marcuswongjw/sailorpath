"use client";

import { sailingClassDisplayLabel } from "@/lib/classPresentation";

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
    label: "Measurement certificate & sail numbers checked",
  },
  {
    id: "spares_rigging",
    label: "Spares kit (battens, sail ties, wind indicator)",
  },
  {
    id: "safety_rig",
    label: "Bailer, painter line & buoyancy bags",
  },
  {
    id: "race_bag",
    label: "Water, sunscreen & race bag packed",
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
  const athleteCustom = customChecklistItems[activeAthlete.id] || [];
  const allItems = [
    ...DEFAULT_RACE_CHECKLIST_ITEMS.map((item) => ({ ...item, isCustom: false })),
    ...athleteCustom.map((item) => ({ ...item, isCustom: true })),
  ];
  const state = checklistState[activeAthlete.id] || {};
  const doneCount = allItems.filter((item) => state[item.id]).length;

  return (
    <section className={`${CARD} p-5 space-y-4`}>
      <div className="flex items-start justify-between gap-2">
        <div>
          <p className={SECTION_KICKER}>Regatta prep</p>
          <h3 className={`${SECTION_TITLE} flex items-center gap-2`}>
            <Calendar className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
            Race-Day Checklist
          </h3>
        </div>
        <div className="flex items-center gap-2 shrink-0">
          <span className="rounded-full bg-[var(--sp-aqua-mist)] border border-[var(--sp-harbour-teal)]/20 px-2.5 py-1 text-[11px] font-bold text-[var(--sp-harbour-teal)]">
            {doneCount}/{allItems.length} ready
          </span>
          {doneCount > 0 && (
            <button
              type="button"
              onClick={() => onResetChecklist(activeAthlete.id)}
              className={`min-h-8 text-[11px] font-semibold ${MUTED} hover:text-[var(--sp-harbour-shadow)] inline-flex items-center gap-1 px-2 rounded-lg hover:bg-[var(--sp-sailcloth)] transition-colors`}
              title="Reset checklist"
            >
              <RotateCcw className="h-3 w-3" />
              Reset
            </button>
          )}
        </div>
      </div>

      {upcomingRegattas.length > 0 && (
        <div className="space-y-2 pb-3 border-b border-[var(--sp-cool-veil)]">
          <div className="flex items-center justify-between">
            <p className={`text-[11px] font-black uppercase tracking-wider ${MUTED}`}>
              Next Regattas
            </p>
            <Link href="/calendar" className={LINK_TEAL}>
              Calendar →
            </Link>
          </div>
          <div className="space-y-1.5">
            {upcomingRegattas.slice(0, 3).map((reg) => (
              <div
                key={reg.id}
                className={`${NESTED} px-3 py-2.5 text-xs flex justify-between items-center gap-2`}
              >
                <div className="min-w-0 flex-1">
                  <p className={`font-bold ${INK} truncate`}>{reg.name}</p>
                  <p className={`text-[12px] ${MUTED} font-mono mt-0.5`}>
                    {reg.date}
                    {reg.boatClass ? ` · ${sailingClassDisplayLabel(reg.boatClass)}` : ""}
                  </p>
                </div>
                <Link
                  href={`/calendar?${new URLSearchParams(reg.slug ? { event: reg.slug, year: reg.date.slice(0, 4) } : { q: reg.name, year: reg.date.slice(0, 4) }).toString()}`}
                  className="text-xs font-bold text-[var(--sp-harbour-teal)] hover:underline shrink-0"
                >
                  Details
                </Link>
              </div>
            ))}
          </div>
        </div>
      )}

      <div className="space-y-2.5">
        <div className="space-y-1.5">
          {allItems.map((item) => {
            const isDone = Boolean(state[item.id]);
            return (
              <div
                key={item.id}
                className={`group w-full rounded-xl px-3 py-2 text-xs flex items-center justify-between gap-2.5 transition-colors ${
                  isDone
                    ? "bg-[var(--sp-aqua-mist)]/70 border border-[var(--sp-harbour-teal)]/25 text-[var(--sp-harbour-shadow)]"
                    : `${NESTED} ${BODY} hover:border-[var(--sp-harbour-teal)]`
                }`}
              >
                <button
                  type="button"
                  onClick={() => onToggleItem(activeAthlete.id, item.id)}
                  className="flex items-start gap-2.5 flex-1 min-h-9 py-1 text-left min-w-0"
                >
                  {isDone ? (
                    <CheckSquare className="h-4 w-4 text-[var(--sp-harbour-teal)] shrink-0 mt-0.5" />
                  ) : (
                    <Square className={`h-4 w-4 ${MUTED} shrink-0 mt-0.5`} />
                  )}
                  <span className={isDone ? "line-through opacity-75" : "font-medium"}>
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
                    className={`opacity-70 group-hover:opacity-100 p-1.5 ${MUTED} hover:text-rose-600 transition-opacity shrink-0`}
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
            className="sp-input flex-1 min-w-0 min-h-11 text-base sm:text-sm"
          />
          <button
            type="button"
            onClick={() => onAddCustomItem(activeAthlete.id)}
            disabled={!newChecklistText.trim()}
            className={`${PRIMARY_BTN} min-h-11 px-3.5 py-2 disabled:opacity-40 shrink-0`}
          >
            <Plus className="h-3.5 w-3.5" />
            Add
          </button>
        </div>
      </div>
    </section>
  );
}
