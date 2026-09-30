"use client";

import Link from "next/link";
import { Users, User, ChevronRight, Award, CheckCircle2 } from "lucide-react";
import { relationLabel, type ClaimRelation } from "@/lib/claimRelation";
import { fleetPillClass } from "@/components/sailor-profile/helpers";
import { birthYear } from "@/lib/age";
import {
  CARD,
  NESTED,
  SECONDARY_BTN,
  PRIMARY_BTN,
  MUTED,
  INK,
  BODY,
} from "./styles";

type Athlete = {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  sailNumberIlca4?: string | null;
  club: string;
  school?: string | null;
  gender?: string | null;
  nationality?: string | null;
  avatarUrl?: string | null;
  currentFleet?: string | null;
  ownerRelation?: ClaimRelation | null;
  nationalSquadStatus?: string | null;
  dob?: string | null;
  standing: {
    periodLabel: string;
    fleet: string;
    overallRank: number;
    fleetSize: number;
    best3of5: number;
    trendNote: string;
  } | null;
  selectionTrials?: {
    rank: number;
    nettScore: number;
    eventsSailed: number;
    isQualifiedAsian: boolean;
    isQualifiedPerth: boolean;
    asianTeamRank?: number;
    gapToCutoff?: number;
  } | null;
  recentResults?: {
    regattaName: string;
    regattaDate: string;
    rank: number;
    boatClass: string | null;
  }[];
  primaryGear?: {
    id: string;
    category: string;
    brand: string | null;
    model: string | null;
    label: string | null;
    condition: string;
    status: string;
    isPrimary: boolean;
  }[];
  equipmentAlertCount?: number;
  equipmentAlerts?: { label: string; reason: string }[];
  coachFeedback?: {
    id: string;
    type: string;
    category: string | null;
    title: string;
    detail: string | null;
    recordDate: string;
    status: string;
  }[];
  notes?: {
    id: string;
    body: string;
    createdAt: string;
  }[];
};

export type AthleteSelectorProps = {
  athletes: Athlete[];
  selectedAthleteId: string | "all";
  onSelectAthlete: (id: string) => void;
};

function formatAgeCategory(dob?: string | null) {
  const by = birthYear(dob);
  if (!by) return null;
  const currentYear = new Date().getFullYear();
  const age = currentYear - by;
  return `${by} · U${age + 1} (${age} yrs)`;
}

export function AthleteSelector({
  athletes,
  selectedAthleteId,
  onSelectAthlete,
}: AthleteSelectorProps) {
  return (
    <>
      {athletes.length > 1 && (
        <div
          className="flex items-center gap-2 overflow-x-auto pb-1 border-b border-[var(--sp-cool-veil)]"
          role="tablist"
          aria-label="Linked athletes"
        >
          <button
            type="button"
            role="tab"
            aria-selected={selectedAthleteId === "all"}
            data-testid="tab-all-summary"
            onClick={() => onSelectAthlete("all")}
            className={`flex items-center gap-2 px-4 py-2 rounded-full text-xs font-bold transition-colors whitespace-nowrap ${
              selectedAthleteId === "all"
                ? "bg-harbour text-sailcloth shadow-xs"
                : `${NESTED} ${MUTED} hover:border-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-shadow)]`
            }`}
          >
            <Users className="h-3.5 w-3.5" />
            All Athletes Summary ({athletes.length})
          </button>

          {athletes.map((a) => {
            const isSelected = selectedAthleteId === a.id;
            return (
              <button
                key={a.id}
                type="button"
                role="tab"
                aria-selected={isSelected}
                onClick={() => onSelectAthlete(a.id)}
                className={`flex items-center gap-2 px-4 py-2 rounded-full text-xs font-bold transition-colors whitespace-nowrap ${
                  isSelected
                    ? "bg-harbour text-sailcloth shadow-xs"
                    : `${NESTED} ${MUTED} hover:border-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-shadow)]`
                }`}
              >
                {a.avatarUrl ? (
                  // eslint-disable-next-line @next/next/no-img-element
                  <img
                    src={a.avatarUrl}
                    alt=""
                    className="h-4 w-4 rounded-full object-cover"
                  />
                ) : (
                  <User className="h-3.5 w-3.5" />
                )}
                <span>{a.name}</span>
                {a.standing?.fleet && (
                  <span
                    className={`text-[10px] px-1.5 py-0.5 rounded-full font-black border ${
                      isSelected
                        ? "border-sailcloth/30 bg-white/15 text-sailcloth"
                        : fleetPillClass(a.standing.fleet)
                    }`}
                  >
                    {a.standing.fleet} #{a.standing.overallRank}
                  </span>
                )}
                {(a.equipmentAlertCount ?? 0) > 0 && (
                  <span className="h-2 w-2 rounded-full bg-rose-500" aria-label="Equipment alert" />
                )}
              </button>
            );
          })}
        </div>
      )}

      {selectedAthleteId === "all" && athletes.length > 1 && (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {athletes.map((a) => (
            <article
              key={a.id}
              className={`${CARD} p-5 space-y-4 hover:border-[var(--sp-harbour-teal)] transition-colors`}
            >
              <div className="flex items-start justify-between gap-3">
                <div className="flex items-center gap-3 min-w-0">
                  {a.avatarUrl ? (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img
                      src={a.avatarUrl}
                      alt=""
                      className="h-12 w-12 rounded-2xl object-cover border border-[var(--sp-cool-veil)] shrink-0"
                    />
                  ) : (
                    <span className="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-[var(--sp-harbour-teal)] text-[var(--sp-sailcloth)] border border-[var(--sp-harbour-teal)]">
                      <User className="h-6 w-6" />
                    </span>
                  )}
                  <div className="min-w-0">
                    <div className="flex flex-wrap items-center gap-2">
                      <h3 className={`text-base font-black ${INK}`}>{a.name}</h3>
                      {a.ownerRelation && (
                        <span className="rounded-full border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)] px-2 py-0.5 text-[10px] font-bold text-[var(--sp-harbour-teal)]">
                          {relationLabel(a.ownerRelation)}
                        </span>
                      )}
                    </div>
                    <p className={`text-xs ${MUTED} mt-0.5`}>
                      {[a.club, a.sailNumber, formatAgeCategory(a.dob)]
                        .filter(Boolean)
                        .join(" · ")}
                    </p>
                  </div>
                </div>
                <div className="flex items-center gap-1.5 shrink-0">
                  <Link
                    href={`/athlete?id=${a.id}`}
                    className={`${SECONDARY_BTN} px-2.5 py-1.5 text-[11px]`}
                  >
                    Athlete Hub ↗
                  </Link>
                  <button
                    type="button"
                    onClick={() => onSelectAthlete(a.id)}
                    className={`${PRIMARY_BTN} px-3 py-1.5`}
                  >
                    Open Dashboard
                    <ChevronRight className="h-3 w-3" />
                  </button>
                </div>
              </div>

              <div className="grid grid-cols-2 sm:grid-cols-3 gap-2.5">
                <div className={`${NESTED} p-2.5`}>
                  <p className={`text-[11px] font-bold ${MUTED} uppercase`}>
                    Series Rank
                  </p>
                  <p className={`text-sm font-black ${INK} mt-0.5`}>
                    {a.standing ? (
                      <>
                        #{a.standing.overallRank}{" "}
                        <span className={`text-[11px] font-normal ${MUTED}`}>
                          ({a.standing.fleet})
                        </span>
                      </>
                    ) : (
                      <span className={`${MUTED} text-xs font-normal`}>—</span>
                    )}
                  </p>
                </div>

                <div className={`${NESTED} p-2.5`}>
                  <p className={`text-[11px] font-bold ${MUTED} uppercase`}>
                    Selection Trials
                  </p>
                  <p className={`text-sm font-black ${INK} mt-0.5`}>
                    {a.selectionTrials ? (
                      <>
                        #{a.selectionTrials.rank}{" "}
                        <span className="text-[11px] font-normal text-[var(--sp-harbour-teal)]">
                          ({a.selectionTrials.nettScore} pts)
                        </span>
                      </>
                    ) : (
                      <span className={`${MUTED} text-xs font-normal`}>N/A</span>
                    )}
                  </p>
                </div>

                <div className={`${NESTED} p-2.5 col-span-2 sm:col-span-1`}>
                  <p className={`text-[11px] font-bold ${MUTED} uppercase`}>
                    Locker Alerts
                  </p>
                  <p className="text-sm font-black mt-0.5">
                    {(a.equipmentAlertCount ?? 0) > 0 ? (
                      <span className="text-rose-700 font-bold">
                        {a.equipmentAlertCount} alert
                        {a.equipmentAlertCount === 1 ? "" : "s"}
                      </span>
                    ) : (
                      <span className="text-[var(--sp-harbour-teal)] font-semibold text-xs flex items-center gap-1">
                        <CheckCircle2 className="h-3 w-3" /> All good
                      </span>
                    )}
                  </p>
                </div>
              </div>

              {a.coachFeedback && a.coachFeedback.length > 0 && (
                <div className="rounded-xl border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)]/60 p-2.5 text-xs flex items-start gap-2">
                  <Award className="h-4 w-4 text-[var(--sp-harbour-teal)] shrink-0 mt-0.5" />
                  <div className="min-w-0 flex-1">
                    <p className="font-bold text-[11px] text-[var(--sp-harbour-teal)] truncate">
                      Latest Coach Feedback: {a.coachFeedback[0].title}
                    </p>
                    <p className={`${BODY} text-[11px] line-clamp-1 mt-0.5`}>
                      {a.coachFeedback[0].detail}
                    </p>
                  </div>
                </div>
              )}
            </article>
          ))}
        </div>
      )}
    </>
  );
}
