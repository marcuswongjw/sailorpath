"use client";

import type { JourneyHighlight } from "@/lib/sailingJourney";

type Draft = { when: string; title: string; detail: string };

type Props = {
  journey: JourneyHighlight[];
  isOwner: boolean;
  demoMode?: boolean;
  journeyBusy: boolean;
  journeyMsg: string | null;
  journeyDraft: Draft;
  onDraftChange: (draft: Draft) => void;
  onAdd: () => void;
  onRemove: (id: string) => void;
};

/** Owner-edited sailing journey highlights (not full results log). */
export function SailingJourneyPanel({
  journey,
  isOwner,
  demoMode,
  journeyBusy,
  journeyMsg,
  journeyDraft,
  onDraftChange,
  onAdd,
  onRemove,
}: Props) {
  return (
    <div className="glass-panel rounded-2xl border border-white/5 p-4 sm:p-6 space-y-4">
      <div>
        <h2 className="text-base sm:text-lg font-bold text-white">
          Sailing Journey
        </h2>
        <p className="text-xs text-slate-500 mt-1 leading-snug">
          Key moments you want to remember — representing Singapore, a first
          win, a special event — not every race result.
        </p>
      </div>
      {journey.length === 0 ? (
        <p className="text-sm text-slate-500">
          {isOwner
            ? "No highlights yet. Add your first memory below."
            : "No journey highlights shared yet."}
        </p>
      ) : (
        <ol className="relative border-l border-white/10 ml-2 space-y-0">
          {journey.map((it, idx) => (
            <li key={it.id} className="relative pl-6 pb-5 last:pb-0">
              <span
                className={`absolute -left-[5px] top-1.5 h-2.5 w-2.5 rounded-full border-2 border-[#090a0f] ${
                  idx === 0 ? "bg-orange-500" : "bg-slate-500"
                }`}
              />
              {it.when && (
                <p className="text-[11px] font-bold text-slate-500 uppercase tracking-wide">
                  {it.when}
                </p>
              )}
              <p className="text-sm font-bold text-white mt-0.5 leading-snug">
                {it.title}
              </p>
              {it.detail && (
                <p className="text-xs text-slate-400 mt-1 leading-relaxed">
                  {it.detail}
                </p>
              )}
              {isOwner && (
                <button
                  type="button"
                  disabled={journeyBusy}
                  onClick={() => onRemove(it.id)}
                  className="mt-1.5 text-[10px] font-bold text-rose-400/90 hover:text-rose-300"
                >
                  Remove
                </button>
              )}
            </li>
          ))}
        </ol>
      )}
      {isOwner && (
        <div className="rounded-xl border border-orange-500/20 bg-orange-500/5 p-3 space-y-2">
          <p className="text-[10px] font-bold text-orange-300 uppercase">
            {demoMode ? "Add highlight (demo)" : "Add highlight"}
          </p>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-2">
            <input
              value={journeyDraft.when}
              onChange={(e) =>
                onDraftChange({ ...journeyDraft, when: e.target.value })
              }
              placeholder="When (e.g. Jun 2026)"
              className="rounded-lg bg-slate-950 border border-white/10 px-2 py-1.5 text-xs text-white"
            />
            <input
              value={journeyDraft.title}
              onChange={(e) =>
                onDraftChange({ ...journeyDraft, title: e.target.value })
              }
              placeholder="Title (e.g. First Nationals win)"
              className="sm:col-span-2 rounded-lg bg-slate-950 border border-white/10 px-2 py-1.5 text-xs text-white"
            />
            <textarea
              value={journeyDraft.detail}
              onChange={(e) =>
                onDraftChange({ ...journeyDraft, detail: e.target.value })
              }
              placeholder="What made it special…"
              rows={2}
              className="sm:col-span-3 rounded-lg bg-slate-950 border border-white/10 px-2 py-1.5 text-xs text-white resize-none"
            />
          </div>
          <button
            type="button"
            disabled={journeyBusy || !journeyDraft.title.trim()}
            onClick={onAdd}
            className="rounded-full bg-orange-600 hover:bg-orange-500 disabled:opacity-40 px-4 py-1.5 text-[11px] font-bold text-white"
          >
            {journeyBusy ? "Saving…" : "Add to journey"}
          </button>
          {journeyMsg && (
            <p className="text-[11px] text-emerald-300">{journeyMsg}</p>
          )}
        </div>
      )}
    </div>
  );
}
