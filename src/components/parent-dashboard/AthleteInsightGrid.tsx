"use client";

import Link from "next/link";
import { Trophy, Award, Sailboat, CheckCircle2 } from "lucide-react";
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
  const isGoldFleet =
    athlete.standing?.fleet === "Gold" ||
    athlete.currentFleet === "Gold" ||
    athlete.currentFleet === "Series";
  const trials = athlete.selectionTrials;
  const tookPart = Boolean(
    isGoldFleet && trials && (trials.eventsSailed > 0 || trials.rank > 0)
  );

  if (!tookPart) {
    return (
      <div className="space-y-1.5 pt-1">
        <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold ${NESTED} ${MUTED}`}>
          Not Applicable
        </span>
        <p className={`text-[13px] ${MUTED} leading-snug`}>
          Only for Gold fleet sailors who took part in selection trial.
        </p>
      </div>
    );
  }

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
        <p className={`text-xs font-bold ${INK} leading-tight`}>{squadDetails}</p>
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

export function AthleteInsightGrid({ athlete }: { athlete: Athlete }) {
  const fleetHref =
    athlete.standing?.fleet === "Gold"
      ? "/sg/optimist/gold"
      : "/sg/optimist/silver";

  return (
    <section className={`${CARD} p-5 sm:p-6`}>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 divide-y md:divide-y-0 md:divide-x divide-[var(--sp-cool-veil)]">
        <div className="space-y-3 md:pr-4 flex flex-col justify-between">
          <div className="space-y-2.5">
            <div className="flex items-center justify-between gap-2">
              <span className={`${SECTION_KICKER} flex items-center gap-1.5`}>
                <Trophy className="h-3.5 w-3.5" />
                Selection Trial
              </span>
              <Link href="/sg/optimist/selection" className={LINK_TEAL}>
                Board →
              </Link>
            </div>
            <SelectionTrialCell athlete={athlete} />
          </div>
          <div className="pt-2">
            <Link
              href="/sg/optimist/selection"
              className="text-xs font-bold text-[var(--sp-harbour-teal)] hover:underline inline-flex items-center gap-1"
            >
              View Trials Board →
            </Link>
          </div>
        </div>

        <div className="space-y-3 pt-4 md:pt-0 md:px-4 flex flex-col justify-between">
          <div className="space-y-2.5">
            <div className="flex items-center justify-between gap-2">
              <span className="text-[11px] font-bold uppercase tracking-[0.16em] text-[var(--sp-harbour-teal)] flex items-center gap-1.5">
                <Award className="h-3.5 w-3.5" />
                National Ranking
              </span>
              <Link href={fleetHref} className={LINK_TEAL}>
                Board →
              </Link>
            </div>
            {athlete.standing ? (
              <div className="space-y-1 pt-1">
                <div className="flex items-baseline gap-2">
                  <span className={`text-3xl font-black ${INK} tabular-nums`}>
                    #{athlete.standing.overallRank}
                  </span>
                  <span className={`text-xs font-semibold ${BODY}`}>
                    in {athlete.standing.fleet} Fleet
                  </span>
                </div>
                <p className={`text-[13px] ${MUTED}`}>
                  {athlete.standing.fleetSize} sailors · {athlete.standing.periodLabel}
                </p>
                <p className={`text-[13px] ${MUTED}`}>
                  Best 3 of 5:{" "}
                  <span className={`font-bold ${INK}`}>
                    {athlete.standing.best3of5} pts
                  </span>
                </p>
              </div>
            ) : (
              <div className="pt-1">
                <span className={`text-xs ${MUTED}`}>
                  No series ranking recorded for current half.
                </span>
              </div>
            )}
          </div>
          <div className="pt-2">
            <Link
              href={fleetHref}
              className="text-xs font-bold text-[var(--sp-harbour-teal)] hover:underline inline-flex items-center gap-1"
            >
              Explore Fleet Board →
            </Link>
          </div>
        </div>

        <div className="space-y-3 pt-4 md:pt-0 md:pl-4 flex flex-col justify-between">
          <div className="space-y-2.5">
            <div className="flex items-center justify-between gap-2">
              <span className="text-[11px] font-bold uppercase tracking-[0.16em] text-[var(--sp-harbour-teal)] flex items-center gap-1.5">
                <Sailboat className="h-3.5 w-3.5" />
                Recent Results
              </span>
              <Link href={`/${athlete.handle}`} className={LINK_TEAL}>
                All →
              </Link>
            </div>
            {athlete.recentResults && athlete.recentResults.length > 0 ? (
              <div className="space-y-1.5 pt-1">
                {athlete.recentResults.slice(0, 3).map((r, i) => (
                  <div
                    key={i}
                    className={`flex items-center justify-between gap-2 p-2 ${NESTED} text-xs`}
                  >
                    <div className="min-w-0 flex-1">
                      <p className={`font-bold ${INK} truncate text-xs`}>
                        {r.regattaName}
                      </p>
                      <p className={`text-[13px] ${MUTED} font-mono`}>
                        {r.regattaDate}
                      </p>
                    </div>
                    <span className="text-xs font-black text-[var(--sp-racing-deep)] tabular-nums px-2 py-0.5 rounded-md bg-[var(--sp-racing-mist)]/50 border border-[var(--sp-racing-orange)]/20 shrink-0">
                      #{r.rank}
                    </span>
                  </div>
                ))}
              </div>
            ) : (
              <div className="pt-1">
                <span className={`text-xs ${MUTED}`}>
                  No recent regatta finishes logged.
                </span>
              </div>
            )}
          </div>
          <div className="pt-2">
            <Link
              href={`/${athlete.handle}`}
              className="text-xs font-bold text-[var(--sp-harbour-teal)] hover:underline inline-flex items-center gap-1"
            >
              View Full Profile →
            </Link>
          </div>
        </div>
      </div>
    </section>
  );
}
