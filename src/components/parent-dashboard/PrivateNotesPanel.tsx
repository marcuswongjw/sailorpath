"use client";

import { Trash2, StickyNote, Lock, Plus } from "lucide-react";

const CARD =
  "rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs";
const NESTED =
  "rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]";
const SECTION_TITLE =
  "mt-1 text-base font-black text-[var(--sp-harbour-shadow)]";
const MUTED = "text-[var(--sp-slate-soft)]";
const BODY = "text-[var(--sp-charcoal-slate)]";
const PRIMARY_BTN = "sp-btn-primary";

const NOTE_CATEGORIES = [
  "General",
  "Training",
  "Regatta Debrief",
  "Logistics",
  "Gear",
] as const;

function parseNoteCategory(body: string): { category: string | null; text: string } {
  const match = body.match(/^\[(.*?)\]\s*(.*)$/);
  if (match) {
    return { category: match[1], text: match[2] };
  }
  return { category: null, text: body };
}

export type PrivateNotesPanelProps = {
  activeAthlete: {
    id: string;
    name?: string;
    notes?: { id: string; body: string; createdAt: string }[];
  };
  noteDraft: Record<string, string>;
  selectedCategory: string;
  noteBusy: string | null;
  onDraftChange: (id: string, value: string) => void;
  onCategoryChange: (cat: string) => void;
  onAddNote: (sailorId: string) => void;
  onDeleteNote: (id: string) => void;
};

export function PrivateNotesPanel({
  activeAthlete,
  noteDraft,
  selectedCategory,
  noteBusy,
  onDraftChange,
  onCategoryChange,
  onAddNote,
  onDeleteNote,
}: PrivateNotesPanelProps) {
  return (
    <section className={`${CARD} p-5 space-y-4`}>
      <div>
        <p className="text-[11px] font-bold uppercase tracking-[0.16em] text-[var(--sp-harbour-teal)]">Private notes</p>
        <h3 className={`${SECTION_TITLE} flex items-center gap-2`}>
          <StickyNote className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
          Private Parent Journal
        </h3>
        <p className={`text-[13px] ${MUTED} mt-0.5 flex items-center gap-1`}>
          <Lock className="h-3 w-3" />
          100% private to your parent account.
        </p>
      </div>

      <div className="space-y-2">
        <div className="flex flex-wrap gap-1.5">
          {NOTE_CATEGORIES.map((cat) => (
            <button
              key={cat}
              type="button"
              onClick={() => onCategoryChange(cat)}
              className={`px-2 py-0.5 rounded-full text-[10px] font-bold transition-colors border ${
                selectedCategory === cat
                  ? "bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)] border-[var(--sp-harbour-teal)]/30"
                  : `${NESTED} ${MUTED} hover:text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)]`
              }`}
            >
              {cat}
            </button>
          ))}
        </div>

        <div className="flex gap-2">
          <input
            value={noteDraft[activeAthlete.id] || ""}
            onChange={(e) => onDraftChange(activeAthlete.id, e.target.value)}
            placeholder={`Add a private ${selectedCategory.toLowerCase()} note…`}
            className="sp-input flex-1 min-w-0 text-xs"
            onKeyDown={(e) => {
              if (e.key === "Enter") void onAddNote(activeAthlete.id);
            }}
          />
          <button
            type="button"
            disabled={
              noteBusy === activeAthlete.id ||
              !(noteDraft[activeAthlete.id] || "").trim()
            }
            onClick={() => void onAddNote(activeAthlete.id)}
            className={`${PRIMARY_BTN} px-3 py-2 disabled:opacity-40 shrink-0`}
          >
            <Plus className="h-4 w-4" />
            Save
          </button>
        </div>
      </div>

      {(activeAthlete.notes?.length ?? 0) === 0 ? (
        <p className={`text-[13px] ${MUTED} text-center py-3`}>
          No private notes yet. Log training thoughts, regatta debriefs, logistics, or equipment orders.
        </p>
      ) : (
        <div className="space-y-2 max-h-72 overflow-y-auto pr-1">
          {activeAthlete.notes!.map((n) => {
            const parsed = parseNoteCategory(n.body);
            return (
              <div
                key={n.id}
                className={`${NESTED} p-2.5 flex items-start justify-between gap-2`}
              >
                <div className="min-w-0 flex-1 space-y-1">
                  <div className="flex items-center gap-2">
                    {parsed.category && (
                      <span className="rounded-full px-1.5 py-0.5 text-[9px] font-black uppercase tracking-wider bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)] border border-[var(--sp-harbour-teal)]/25">
                        {parsed.category}
                      </span>
                    )}
                    <span className={`text-[13px] ${MUTED} font-mono`}>
                      {n.createdAt ? n.createdAt.slice(0, 10) : ""}
                    </span>
                  </div>
                  <p className={`text-xs ${BODY} leading-relaxed whitespace-pre-wrap`}>
                    {parsed.text}
                  </p>
                </div>
                <button
                  type="button"
                  disabled={noteBusy === n.id}
                  onClick={() => void onDeleteNote(n.id)}
                  className={`${MUTED} hover:text-rose-600 p-1 shrink-0 transition-colors`}
                  aria-label="Delete note"
                >
                  <Trash2 className="h-3.5 w-3.5" />
                </button>
              </div>
            );
          })}
        </div>
      )}
    </section>
  );
}
