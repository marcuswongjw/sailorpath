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

export function SquadPulseCards({
  members,
  actionsCount,
  rankingPeriod,
  averageBest,
}: SquadPulseCardsProps) {
  // Fleet breakdown
  const goldCount = useMemo(() => members.filter((m) => m.fleet === "Gold").length, [members]);
  const silverCount = useMemo(() => members.filter((m) => m.fleet === "Silver").length, [members]);
  const unrankedCount = members.length - goldCount - silverCount;

  // Movement stats
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

  // Selection readiness
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
      {/* 1. Squad Composition */}
      <div className="flex flex-col justify-between rounded-2xl border border-white/10 bg-white/[0.03] p-4 sm:p-5 transition hover:border-white/20">
        <div className="flex items-center justify-between">
          <span className="text-[11px] font-bold uppercase tracking-wider text-slate-400">Roster</span>
          <div className="flex h-7 w-7 items-center justify-center rounded-lg bg-orange-500/10 text-orange-400">
            <Users className="h-4 w-4" />
          </div>
        </div>
        <div className="mt-3">
          <p className="text-2xl font-black text-white sm:text-3xl">{members.length}</p>
          <div className="mt-1 flex flex-wrap items-center gap-1.5 text-[11px] font-medium text-slate-400">
            <span className="inline-flex items-center gap-1 rounded bg-white/5 px-1.5 py-0.5 text-amber-300">
              Gold {goldCount}
            </span>
            <span className="inline-flex items-center gap-1 rounded bg-white/5 px-1.5 py-0.5 text-sky-300">
              Silver {silverCount}
            </span>
            {unrankedCount > 0 && (
              <span className="inline-flex items-center gap-1 rounded bg-white/5 px-1.5 py-0.5 text-slate-400">
                Other {unrankedCount}
              </span>
            )}
          </div>
        </div>
      </div>

      {/* 2. Rank Trajectory & Momentum */}
      <div className="flex flex-col justify-between rounded-2xl border border-white/10 bg-white/[0.03] p-4 sm:p-5 transition hover:border-white/20">
        <div className="flex items-center justify-between">
          <span className="text-[11px] font-bold uppercase tracking-wider text-slate-400">Avg Best 3</span>
          <div className="flex h-7 w-7 items-center justify-center rounded-lg bg-emerald-500/10 text-emerald-400">
            <TrendingUp className="h-4 w-4" />
          </div>
        </div>
        <div className="mt-3">
          <p className="text-2xl font-black text-white sm:text-3xl">{averageBest}</p>
          <div className="mt-1 flex items-center gap-1.5 text-[11px] font-semibold">
            {movementStats.climbed > 0 || movementStats.dropped > 0 ? (
              <span className="inline-flex items-center gap-1 text-slate-300">
                <span className="text-emerald-400">▲ {movementStats.climbed}</span>
                <span className="text-rose-400">▼ {movementStats.dropped}</span>
                <span className="text-[10px] text-slate-500 font-normal">
                  ({movementStats.net >= 0 ? `+${movementStats.net}` : movementStats.net} net)
                </span>
              </span>
            ) : (
              <span className="text-[11px] text-slate-500 font-normal">{rankingPeriod}</span>
            )}
          </div>
        </div>
      </div>

      {/* 3. Selection Readiness */}
      <div className="flex flex-col justify-between rounded-2xl border border-white/10 bg-white/[0.03] p-4 sm:p-5 transition hover:border-white/20">
        <div className="flex items-center justify-between">
          <span className="text-[11px] font-bold uppercase tracking-wider text-slate-400">Selection</span>
          <div className="flex h-7 w-7 items-center justify-center rounded-lg bg-sky-500/10 text-sky-400">
            <Target className="h-4 w-4" />
          </div>
        </div>
        <div className="mt-3">
          <p className="text-2xl font-black text-white sm:text-3xl">
            {readinessStats.ready} <span className="text-sm font-semibold text-slate-400">ready</span>
          </p>
          <p className="mt-1 text-[11px] font-medium text-slate-400">
            {readinessStats.watch > 0 ? `${readinessStats.watch} developing / on bubble` : "All records established"}
          </p>
        </div>
      </div>

      {/* 4. Squad Action Centre */}
      <div className={`flex flex-col justify-between rounded-2xl border p-4 sm:p-5 transition ${
        actionsCount > 0
          ? "border-amber-500/30 bg-amber-500/[0.04] hover:border-amber-500/40"
          : "border-white/10 bg-white/[0.03] hover:border-white/20"
      }`}>
        <div className="flex items-center justify-between">
          <span className="text-[11px] font-bold uppercase tracking-wider text-slate-400">Triage & Alerts</span>
          <div className={`flex h-7 w-7 items-center justify-center rounded-lg ${
            actionsCount > 0 ? "bg-amber-500/15 text-amber-400" : "bg-emerald-500/10 text-emerald-400"
          }`}>
            {actionsCount > 0 ? <AlertTriangle className="h-4 w-4" /> : <CheckCircle2 className="h-4 w-4" />}
          </div>
        </div>
        <div className="mt-3">
          <p className={`text-2xl font-black sm:text-3xl ${actionsCount > 0 ? "text-amber-300" : "text-emerald-400"}`}>
            {actionsCount}
          </p>
          <p className="mt-1 text-[11px] font-medium text-slate-400">
            {actionsCount > 0 ? "Items need coach attention" : "All squad items reviewed"}
          </p>
        </div>
      </div>
    </section>
  );
}
