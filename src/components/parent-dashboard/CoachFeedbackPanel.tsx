"use client";

import { Award } from "lucide-react";
import { CARD, NESTED, SECTION_TITLE, MUTED, BODY, INK } from "./styles";
import type { Athlete } from "./types";

export function CoachFeedbackPanel({ athlete }: { athlete: Athlete }) {
  return (
    <section className={`${CARD} p-5 sm:p-6 space-y-4`}>
      <div className="flex items-start justify-between gap-3">
        <div>
          <p className="text-[11px] font-bold uppercase tracking-[0.16em] text-[var(--sp-harbour-teal)]">
            Coach feed
          </p>
          <h3 className={`${SECTION_TITLE} flex items-center gap-2`}>
            <Award className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
            Coach Observations & Development Records
          </h3>
          <p className={`text-xs ${MUTED} mt-0.5`}>
            Technical debriefs, starts, tactics, and boat speed observations logged by accredited coaches.
          </p>
        </div>
        <span className={`text-[11px] font-bold ${MUTED} uppercase tracking-wider`}>
          Read-Only Feed
        </span>
      </div>

      {athlete.coachFeedback && athlete.coachFeedback.length > 0 ? (
        <div className="space-y-3">
          {athlete.coachFeedback.map((cf) => (
            <div key={cf.id} className={`${NESTED} p-3.5 space-y-1.5`}>
              <div className="flex flex-wrap items-center justify-between gap-2">
                <div className="flex items-center gap-2">
                  <span className={`text-xs font-bold ${INK}`}>{cf.title}</span>
                  {cf.category && (
                    <span className="rounded-full border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)] px-2 py-0.5 text-[10px] font-bold text-[var(--sp-harbour-teal)] capitalize">
                      {cf.category}
                    </span>
                  )}
                </div>
                <span className={`text-[13px] ${MUTED} font-mono`}>
                  {cf.recordDate}
                </span>
              </div>
              {cf.detail && (
                <p className={`text-xs ${BODY} leading-relaxed`}>{cf.detail}</p>
              )}
            </div>
          ))}
        </div>
      ) : (
        <div className={`rounded-xl border border-dashed border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-4 text-center text-xs ${MUTED}`}>
          No coach observations logged yet for this period. Entries recorded by your child&apos;s coaches will automatically show here.
        </div>
      )}
    </section>
  );
}
