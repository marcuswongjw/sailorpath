"use client";

import { useMemo } from "react";
import { Users, TrendingUp, Target, AlertTriangle, CheckCircle2 } from "lucide-react";
import type { CoachSquadMember } from "@/lib/coachDashboard";

type SquadPulseCardsProps = {
  members: CoachSquadMember[];
  actionsCount: number;
  rankingPeriod: string;
  averageBest: string;
};

const CARD =
  "flex flex-col justify-between rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 sm:p-5 shadow-xs hover:border-[var(--sp-harbour-teal)] transition-colors";

export function SquadPulseCards({
  members,
  actionsCount,
  rankingPeriod,
  averageBest,
}: SquadPulseCardsProps) {
  const goldCount = useMemo(() => members.filter((m) => m.fleet === "Gold").length, [members]);
  const silverCount = useMemo(() => members.filter((m) => m.fleet === "Silver").length, [members]);
  const unrankedCount = members.length - goldCount - silverCount;

  const movementStats = useMemo(() => {
    let climbed = 0;
    let dropped = 0;
    let net = 0;
    for (const m of members) {
      if (m.recentMovement != null) {
        if (m.recentMovement > 0) climbed++;
        else if (m.recentMovement < 0) dropped++;
        net += m.recentMovement;
      }
    }
    return { climbed, dropped, net };
  }, [members]);

  const readinessStats = useMemo(() => {
    let ready = 0;
    let watch = 0;
    for (const m of members) {
      if (m.selectionReadiness.tone === "ready") ready++;
      else watch++;
    }
    return { ready, watch };
  }, [members]);

  return (
    <section className="grid grid-cols-2 gap-3 sm:gap-4 lg:grid-cols-4" aria-label="Squad summary">
      <div className={CARD}>
        <div className="flex items-center justify-between">
          <span className="text-[11px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">Roster</span>
          <div className="flex h-7 w-7 items-center justify-center rounded-lg bg-[var(--sp-racing-mist)]/50 text-[var(--sp-racing-orange)]">
            <Users className="h-4 w-4" />
          </div>
        </div>
        <div className="mt-3">
          <p className="text-2xl font-black text-[var(--sp-harbour-shadow)] sm:text-3xl">{members.length}</p>
          <div className="mt-1 flex flex-wrap items-center gap-1.5 text-[11px] font-medium text-[var(--sp-slate-soft)]">
            <span className="inline-flex items-center gap-1 rounded-full border border-[var(--sp-racing-orange)]/30 bg-[var(--sp-racing-mist)]/40 px-1.5 py-0.5 text-[var(--sp-racing-orange)]">
              Gold {goldCount}
            </span>
            <span className="inline-flex items-center gap-1 rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-1.5 py-0.5 text-[var(--sp-charcoal-slate)]">
              Silver {silverCount}
            </span>
            {unrankedCount > 0 && (
              <span className="inline-flex items-center gap-1 rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-1.5 py-0.5 text-[var(--sp-slate-soft)]">
                Other {unrankedCount}
              </span>
            )}
          </div>
        </div>
      </div>

      <div className={CARD}>
        <div className="flex items-center justify-between">
          <span className="text-[11px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">Avg Best 3</span>
          <div className="flex h-7 w-7 items-center justify-center rounded-lg bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)]">
            <TrendingUp className="h-4 w-4" />
          </div>
        </div>
        <div className="mt-3">
          <p className="text-2xl font-black text-[var(--sp-harbour-shadow)] sm:text-3xl">{averageBest}</p>
          <div className="mt-1 flex items-center gap-1.5 text-[11px] font-semibold">
            {movementStats.climbed > 0 || movementStats.dropped > 0 ? (
              <span className="inline-flex items-center gap-1 text-[var(--sp-charcoal-slate)]">
                <span className="text-[var(--sp-harbour-teal)]">▲ {movementStats.climbed}</span>
                <span className="text-rose-700">▼ {movementStats.dropped}</span>
                <span className="text-[10px] text-[var(--sp-slate-soft)] font-normal">
                  ({movementStats.net >= 0 ? `+${movementStats.net}` : movementStats.net} net)
                </span>
              </span>
            ) : (
              <span className="text-[11px] text-[var(--sp-slate-soft)] font-normal">{rankingPeriod}</span>
            )}
          </div>
        </div>
      </div>

      <div className={CARD}>
        <div className="flex items-center justify-between">
          <span className="text-[11px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">Selection</span>
          <div className="flex h-7 w-7 items-center justify-center rounded-lg bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)]">
            <Target className="h-4 w-4" />
          </div>
        </div>
        <div className="mt-3">
          <p className="text-2xl font-black text-[var(--sp-harbour-shadow)] sm:text-3xl">
            {readinessStats.ready}{" "}
            <span className="text-sm font-semibold text-[var(--sp-slate-soft)]">ready</span>
          </p>
          <p className="mt-1 text-[11px] font-medium text-[var(--sp-slate-soft)]">
            {readinessStats.watch > 0 ? `${readinessStats.watch} developing / on bubble` : "All records established"}
          </p>
        </div>
      </div>

      <div
        className={
          actionsCount > 0
            ? "flex flex-col justify-between rounded-2xl border border-[var(--sp-racing-orange)]/25 bg-[var(--sp-racing-mist)]/40 p-4 sm:p-5 shadow-xs hover:border-[var(--sp-racing-orange)]/40 transition-colors"
            : CARD
        }
      >
        <div className="flex items-center justify-between">
          <span className="text-[11px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">Triage & Alerts</span>
          <div
            className={`flex h-7 w-7 items-center justify-center rounded-lg ${
              actionsCount > 0
                ? "bg-[var(--sp-racing-mist)] text-[var(--sp-racing-orange)]"
                : "bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)]"
            }`}
          >
            {actionsCount > 0 ? <AlertTriangle className="h-4 w-4" /> : <CheckCircle2 className="h-4 w-4" />}
          </div>
        </div>
        <div className="mt-3">
          <p
            className={`text-2xl font-black sm:text-3xl ${
              actionsCount > 0 ? "text-[var(--sp-racing-deep)]" : "text-[var(--sp-harbour-teal)]"
            }`}
          >
            {actionsCount}
          </p>
          <p className="mt-1 text-[11px] font-medium text-[var(--sp-slate-soft)]">
            {actionsCount > 0 ? "Items need coach attention" : "All squad items reviewed"}
          </p>
        </div>
      </div>
    </section>
  );
}
