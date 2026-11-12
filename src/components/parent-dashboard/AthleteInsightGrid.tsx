"use client";

import Link from "next/link";
import { Trophy, Sailboat, CheckCircle2, ChevronRight } from "lucide-react";
import {
  CARD,
  NESTED,
  SECTION_KICKER,
  MUTED,
  BODY,
  INK,
  LINK_TEAL,
} from "./styles";
import type { Athlete } from "./types";

function SelectionTrialCell({ athlete }: { athlete: Athlete }) {
  const trials = athlete.selectionTrials;
  const isSelected = Boolean(
    trials?.isQualifiedAsian || trials?.isQualifiedPerth
  );

  if (isSelected) {
    const squadDetails =
      trials?.isQualifiedAsian && trials?.isQualifiedPerth
        ? "Asian Games & Perth Camp"
        : trials?.isQualifiedAsian
          ? `Asian Games Squad (Rank #${trials.asianTeamRank})`
          : "Selected for Perth Camp";

    return (
      <div className="space-y-2 pt-1">
        <div>
          <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-black bg-[var(--sp-aqua-mist)] border border-[var(--sp-harbour-teal)]/30 text-[var(--sp-harbour-teal)]">
            <CheckCircle2 className="h-3.5 w-3.5" />
            Selected
          </span>
        </div>
        <p className={`text-sm font-bold ${INK} leading-tight`}>{squadDetails}</p>
        <p className={`text-[13px] ${MUTED} font-mono`}>
          Trials Rank #{trials?.rank} · {trials?.nettScore} pts ({trials?.eventsSailed}/2 events)
        </p>
      </div>
    );
  }

  return (
    <div className="space-y-2 pt-1">
      <div>
        <span className={`inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold ${NESTED} ${BODY}`}>
          Not Selected
        </span>
      </div>
      <p className={`text-xs ${BODY}`}>
        Trials Rank #{trials?.rank} ({trials?.eventsSailed}/2 events)
      </p>
      {trials?.gapToCutoff != null && (
        <p className={`text-[13px] ${MUTED} font-mono`}>
          {trials.gapToCutoff > 0
            ? `+${trials.gapToCutoff.toFixed(1)}`
            : trials.gapToCutoff.toFixed(1)}{" "}
          pts to cutoff
        </p>
      )}
    </div>
  );
}

export function AthleteInsightGrid({
  athlete,
  demoMode = false,
}: {
  athlete: Athlete;
  demoMode?: boolean;
}) {
  const profileHref = demoMode ? "/sample" : `/sailors/${athlete.handle}`;
  const isGoldFleet =
    athlete.standing?.fleet === "Gold" ||
    athlete.currentFleet === "Gold" ||
    athlete.currentFleet === "Series";
  const trials = athlete.selectionTrials;
  const showTrials = Boolean(
    isGoldFleet && trials && (trials.eventsSailed > 0 || trials.rank > 0)
  );

  return (
    <section className={`${CARD} p-4 sm:p-6`}>
      <div
        className={`grid grid-cols-1 ${
          showTrials ? "md:grid-cols-2 divide-y md:divide-y-0 md:divide-x divide-[var(--sp-cool-veil)]" : ""
        } gap-5 sm:gap-6`}
      >
        {showTrials && (
          <div className="space-y-3 md:pr-5">
            <div className="flex items-center justify-between gap-2">
              <span className={`${SECTION_KICKER} flex items-center gap-1.5`}>
                <Trophy className="h-3.5 w-3.5" />
                Selection Trial
              </span>
              <Link href="/sg/optimist/selection" className={LINK_TEAL}>
                Trials board →
              </Link>
            </div>
            <SelectionTrialCell athlete={athlete} />
          </div>
        )}

        <div className={`space-y-3 ${showTrials ? "pt-4 md:pt-0 md:pl-5" : ""}`}>
          <div className="flex items-center justify-between gap-2">
            <span className="text-[11px] font-bold uppercase tracking-[0.16em] text-[var(--sp-harbour-teal)] flex items-center gap-1.5">
              <Sailboat className="h-3.5 w-3.5" />
              Recent Results
            </span>
            <Link href={profileHref} className={LINK_TEAL}>
              Full profile →
            </Link>
          </div>
          {athlete.recentResults && athlete.recentResults.length > 0 ? (
            <div className="space-y-2 pt-0.5">
              {athlete.recentResults.slice(0, 3).map((r, i) => {
                const href = r.regattaSlug ? `/regattas/${r.regattaSlug}` : null;
                const inner = (
                  <>
                    <div className="min-w-0 flex-1">
                      <p className={`font-bold ${INK} truncate text-xs sm:text-sm`}>
                        {r.regattaName}
                      </p>
                      <p className={`text-[12px] ${MUTED} font-mono mt-0.5`}>
                        {r.regattaDate}
                      </p>
                    </div>
                    <div className="flex items-center gap-1.5 shrink-0">
                      <span className="text-xs font-black text-[var(--sp-racing-deep)] tabular-nums px-2.5 py-1 rounded-md bg-[var(--sp-racing-mist)]/50 border border-[var(--sp-racing-orange)]/20">
                        #{r.rank}
                      </span>
                      {href && (
                        <ChevronRight className={`h-3.5 w-3.5 ${MUTED}`} />
                      )}
                    </div>
                  </>
                );
                return href ? (
                  <Link
                    key={i}
                    href={href}
                    className={`flex items-center justify-between gap-2 p-2.5 ${NESTED} hover:border-[var(--sp-harbour-teal)] transition-colors`}
                  >
                    {inner}
                  </Link>
                ) : (
                  <div
                    key={i}
                    className={`flex items-center justify-between gap-2 p-2.5 ${NESTED}`}
                  >
                    {inner}
                  </div>
                );
              })}
            </div>
          ) : (
            <p className={`text-xs ${MUTED} pt-1`}>
              No recent regatta finishes logged.
            </p>
          )}
        </div>
      </div>
    </section>
  );
}
