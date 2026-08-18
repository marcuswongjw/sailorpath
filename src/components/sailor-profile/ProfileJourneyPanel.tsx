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
        <p className="text-[11px] text-neutral-500">
          Key moments — campaigns, firsts, and milestones.
          {hasSystem ? " Fleet milestones are filled in automatically." : ""}
        </p>
      ) : (
        <>
          <div className="flex items-center gap-2 mb-1">
            <Anchor className="h-3.5 w-3.5 text-sky-400/90" />
            <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
              Sailing journey
            </h2>
          </div>
          <p className="text-[11px] text-neutral-500 mb-4">
            Key moments — campaigns, firsts, and milestones.
            {hasSystem ? " Fleet milestones are filled in automatically." : ""}
          </p>
        </>
      )}

      {items.length === 0 ? (
        <p className="text-sm text-neutral-600">
          {isOwner
            ? "No highlights yet. Add one below."
            : "No journey highlights shared yet."}
        </p>
      ) : (
        <ol
          className={`relative space-y-0 border-l border-white/10 ${
            isTab ? "" : "ml-0.5"
          }`}
        >
          {items.map((it) => (
            <li key={it.id} className="relative pl-4 pb-4 last:pb-0">
              <span
                className={`absolute -left-[3px] top-1.5 h-1.5 w-1.5 rounded-full ${
                  it.system
                    ? "bg-amber-400"
                    : isTab
                      ? "bg-violet-400"
                      : "bg-neutral-500"
                }`}
              />
              {it.when && (
                <p
                  className={`text-[11px] font-semibold uppercase tracking-wide ${
                    isTab ? "text-violet-300" : "text-orange-400"
                  }`}
                >
                  {it.when}
                </p>
              )}
              <p className="text-sm font-semibold text-white mt-0.5 inline-flex flex-wrap items-baseline gap-x-1.5 gap-y-0.5">
                <span>{it.title}</span>
                {it.system ? (
                  <span className="rounded px-1 py-px text-[9px] font-medium uppercase tracking-wide text-amber-400/90 bg-amber-500/10 border border-amber-500/20">
                    milestone
                  </span>
                ) : null}
              </p>
              {it.detail && (
                <p className="text-xs text-neutral-500 mt-0.5 leading-relaxed">
                  {it.detail}
                </p>
              )}
              {isOwner && (
                <button
                  type="button"
                  disabled={busy}
                  onClick={() => onRemove(it.id, it.system)}
                  className="mt-1 text-[10px] text-rose-400/90"
                >
                  Remove
                </button>
              )}
            </li>
          ))}
        </ol>
      )}

      {isOwner && (
        <div className="mt-4 space-y-2 border-t border-white/[0.06] pt-3">
          <input
            value={draft.when}
            onChange={(e) =>
              setDraft((d) => ({ ...d, when: e.target.value }))
            }
            placeholder="When"
            className="w-full rounded-lg bg-black/40 border border-white/10 px-2 py-1.5 text-xs text-white"
          />
          <input
            value={draft.title}
            onChange={(e) =>
              setDraft((d) => ({ ...d, title: e.target.value }))
            }
            placeholder="Title"
            className="w-full rounded-lg bg-black/40 border border-white/10 px-2 py-1.5 text-xs text-white"
          />
          <textarea
            value={draft.detail}
            onChange={(e) =>
              setDraft((d) => ({ ...d, detail: e.target.value }))
            }
            placeholder="Detail"
            rows={2}
            className="w-full rounded-lg bg-black/40 border border-white/10 px-2 py-1.5 text-xs text-white resize-none"
          />
          <button
            type="button"
            disabled={busy || !draft.title.trim()}
            onClick={onAdd}
            className="rounded-lg bg-white/10 px-3 py-1.5 text-[11px] font-semibold text-white disabled:opacity-40"
          >
            {busy ? "Saving…" : "Add highlight"}
          </button>
          {message && (
            <p className="text-[11px] text-emerald-400">{message}</p>
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
