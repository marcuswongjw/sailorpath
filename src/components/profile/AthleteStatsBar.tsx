"use client";

import { TrendingUp } from "lucide-react";

type Props = {
  ageDisplay: string;
  ageHint: string;
  weightDisplay: string | number;
  weightHint: string;
  eventsCount: number;
  gender: string | null | undefined;
};

/** Always-visible 1×4 athlete stats strip on sailor profiles. */
export function AthleteStatsBar({
  ageDisplay,
  ageHint,
  weightDisplay,
  weightHint,
  eventsCount,
  gender,
}: Props) {
  return (
    <div className="glass-card rounded-2xl p-3 sm:p-4 border border-white/5">
      <h2 className="text-[10px] font-bold text-slate-500 tracking-wider uppercase mb-2 flex items-center gap-1.5 px-0.5">
        <TrendingUp className="h-3.5 w-3.5 text-orange-500" />
        Athlete statistics
      </h2>
      <div className="grid grid-cols-4 gap-1.5 sm:gap-2">
        <div className="bg-white/5 border border-white/5 rounded-xl px-1.5 py-2.5 sm:p-3 text-center min-w-0">
          <span className="block text-[9px] sm:text-[10px] text-slate-500 font-bold uppercase truncate">
            Age
          </span>
          <span className="block text-base sm:text-xl font-extrabold text-white mt-0.5 tabular-nums">
            {ageDisplay}
          </span>
          <span className="block text-[9px] text-slate-600">{ageHint}</span>
        </div>
        <div className="bg-white/5 border border-white/5 rounded-xl px-1.5 py-2.5 sm:p-3 text-center min-w-0">
          <span className="block text-[9px] sm:text-[10px] text-slate-500 font-bold uppercase truncate">
            Weight
          </span>
          <span className="block text-base sm:text-xl font-extrabold text-white mt-0.5 font-mono tabular-nums">
            {weightDisplay}
          </span>
          <span className="block text-[9px] text-slate-600">{weightHint}</span>
        </div>
        <div className="bg-white/5 border border-white/5 rounded-xl px-1.5 py-2.5 sm:p-3 text-center min-w-0">
          <span className="block text-[9px] sm:text-[10px] text-slate-500 font-bold uppercase truncate">
            Events
          </span>
          <span className="block text-base sm:text-xl font-extrabold text-orange-500 mt-0.5 tabular-nums">
            {eventsCount}
          </span>
          <span className="block text-[9px] text-slate-600">logged</span>
        </div>
        <div className="bg-white/5 border border-white/5 rounded-xl px-1.5 py-2.5 sm:p-3 text-center min-w-0">
          <span className="block text-[9px] sm:text-[10px] text-slate-500 font-bold uppercase truncate">
            Gender
          </span>
          <span className="block text-base sm:text-xl font-extrabold text-white mt-0.5">
            {gender || "—"}
          </span>
          <span className="block text-[9px] text-slate-600">&nbsp;</span>
        </div>
      </div>
    </div>
  );
}
