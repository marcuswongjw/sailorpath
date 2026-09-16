"use client";

import type React from "react";
import { Anchor } from "lucide-react";
import type { JourneyHighlight } from "@/lib/sailingJourney";
import { PROFILE_CARD_CLASS } from "@/components/sailor-profile/helpers";

export type JourneyDraft = {
  when: string;
  title: string;
  detail: string;
};

type Props = {
  variant: "tab" | "card";
  items: JourneyHighlight[];
  isOwner: boolean;
  draft: JourneyDraft;
  setDraft: React.Dispatch<React.SetStateAction<JourneyDraft>>;
  busy: boolean;
  message: string | null;
  onAdd: () => void;
  onRemove: (id: string, isSystem?: boolean) => void;
};

/**
 * Sailing journey highlights — shared UI for dual-class tab panel and
 * single-class card section. Visual accents differ by `variant`.
 */
export function ProfileJourneyPanel({
  variant,
  items,
  isOwner,
  draft,
  setDraft,
  busy,
  message,
  onAdd,
  onRemove,
}: Props) {
  const isTab = variant === "tab";
  const hasSystem = items.some((j) => j.system);

  const body = (
    <>
      {isTab ? (
        <p className="text-[11px] text-slate-soft font-medium">
          Key moments — campaigns, firsts, and milestones.
          {hasSystem ? " Fleet milestones are filled in automatically." : ""}
        </p>
      ) : (
        <>
          <div className="flex items-center gap-2 mb-1">
            <Anchor className="h-3.5 w-3.5 text-harbour" />
            <h2 className="text-[11px] font-bold uppercase tracking-[0.14em] text-slate-soft">
              Sailing journey
            </h2>
          </div>
          <p className="text-[11px] text-slate-soft mb-4 font-medium">
            Key moments — campaigns, firsts, and milestones.
            {hasSystem ? " Fleet milestones are filled in automatically." : ""}
          </p>
        </>
      )}

      {items.length === 0 ? (
        <p className="text-sm text-slate-soft font-medium py-4">
          {isOwner
            ? "No highlights yet. Add one below."
            : "No journey highlights shared yet."}
        </p>
      ) : (
        <ol
          className={`relative space-y-0 border-l border-cool-veil ${
            isTab ? "" : "ml-0.5"
          }`}
        >
          {items.map((it) => (
            <li key={it.id} className="relative pl-4 pb-4 last:pb-0">
              <span
                className={`absolute -left-[4px] top-1.5 h-2 w-2 rounded-full ${
                  it.system
                    ? "bg-racing-orange"
                    : "bg-harbour"
                }`}
              />
              {it.when && (
                <p className="text-[11px] font-bold uppercase tracking-wide text-harbour">
                  {it.when}
                </p>
              )}
              <p className="text-sm font-bold text-harbour-shadow mt-0.5 inline-flex flex-wrap items-baseline gap-x-1.5 gap-y-0.5">
                <span>{it.title}</span>
                {it.system ? (
                  <span className="rounded px-1.5 py-px text-[9px] font-bold uppercase tracking-wide text-racing-orange bg-racing-mist/40 border border-racing-orange/30">
                    milestone
                  </span>
                ) : null}
              </p>
              {it.detail && (
                <p className="text-xs text-slate-soft mt-0.5 leading-relaxed font-medium">
                  {it.detail}
                </p>
              )}
              {isOwner && (
                <button
                  type="button"
                  disabled={busy}
                  onClick={() => onRemove(it.id, it.system)}
                  className="mt-1 text-[10px] font-bold text-rose-600 hover:underline cursor-pointer"
                >
                  Remove
                </button>
              )}
            </li>
          ))}
        </ol>
      )}

      {isOwner && (
        <div className="mt-4 space-y-2 border-t border-cool-veil pt-3">
          <input
            value={draft.when}
            onChange={(e) =>
              setDraft((d) => ({ ...d, when: e.target.value }))
            }
            placeholder="When (e.g. Oct 2025)"
            className="w-full rounded-lg bg-sailcloth border border-cool-veil px-2.5 py-1.5 text-xs text-charcoal"
          />
          <input
            value={draft.title}
            onChange={(e) =>
              setDraft((d) => ({ ...d, title: e.target.value }))
            }
            placeholder="Milestone title"
            className="w-full rounded-lg bg-sailcloth border border-cool-veil px-2.5 py-1.5 text-xs text-charcoal"
          />
          <textarea
            value={draft.detail}
            onChange={(e) =>
              setDraft((d) => ({ ...d, detail: e.target.value }))
            }
            placeholder="Details, boat class, takeaways"
            rows={2}
            className="w-full rounded-lg bg-sailcloth border border-cool-veil px-2.5 py-1.5 text-xs text-charcoal"
          />
          <button
            type="button"
            disabled={busy}
            onClick={onAdd}
            className="sp-primary rounded-lg px-3 py-1.5 text-xs font-bold text-white shadow-xs disabled:opacity-50 cursor-pointer"
          >
            {busy ? "Saving…" : "Add milestone"}
          </button>
          {message && (
            <p className="text-[11px] font-bold text-harbour">{message}</p>
          )}
        </div>
      )}
    </>
  );

  if (isTab) {
    return (
      <div className="px-4 sm:px-5 pb-5 pt-1 space-y-3">{body}</div>
    );
  }

  return <section className={`${PROFILE_CARD_CLASS} p-5`}>{body}</section>;
}
