"use client";

import dynamic from "next/dynamic";
import { PROFILE_CARD_CLASS as cardClass } from "./helpers";
import type { ProfileMode, TrendPoint } from "@/lib/profileAnalytics";

const PositionTrendChart = dynamic(
  () =>
    import("./PositionTrendChart").then((module) => module.PositionTrendChart),
  {
    ssr: false,
    loading: () => (
      <div className="h-48 w-full animate-pulse rounded-2xl bg-white/5 border border-white/5" />
    ),
  }
);

type StatCell = {
  label: string;
  value: string;
  color: string;
  hint?: string | null;
};

type MedalTally = {
  gold: number;
  silver: number;
  bronze: number;
  top10: number;
};

type Props = {
  showSummary: boolean;
  keyStatsTitle: string;
  statCells: StatCell[];
  showMedals: boolean;
  medalTallyTitle: string;
  medals: MedalTally;
  trendPoints: TrendPoint[];
  trendMode: ProfileMode;
  trendGoldEntry: string | null;
  trendCaption: string;
};

/** Read-only performance cards kept separate from profile editing state. */
export function ProfilePerformanceSummary({
  showSummary,
  keyStatsTitle,
  statCells,
  showMedals,
  medalTallyTitle,
  medals,
  trendPoints,
  trendMode,
  trendGoldEntry,
  trendCaption,
}: Props) {
  return (
    <>
      {showSummary && (
        <section className={`${cardClass} overflow-hidden`}>
          <div className="px-4 sm:px-5 pt-4 sm:pt-5 pb-1">
            <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
              {keyStatsTitle}
            </h2>
          </div>
          <div className="grid grid-cols-2 sm:grid-cols-4 divide-x divide-y sm:divide-y-0 divide-white/[0.06]">
            {statCells.map((stat) => (
              <div
                key={stat.label}
                className="px-2.5 sm:px-3 py-4 sm:py-5 text-center"
              >
                <p
                  className={`text-[1.65rem] sm:text-3xl font-semibold tabular-nums tracking-tight leading-none ${stat.color}`}
                >
                  {stat.value}
                </p>
                <p className="mt-1.5 text-[9px] sm:text-[10px] font-medium uppercase tracking-[0.1em] text-neutral-500 leading-tight">
                  {stat.label}
                </p>
                {stat.hint && (
                  <p className="mt-0.5 text-[9px] sm:text-[10px] font-medium text-neutral-600 leading-tight normal-case tracking-normal">
                    {stat.hint}
                  </p>
                )}
              </div>
            ))}
          </div>
        </section>
      )}

      {showMedals && (
        <section className={`${cardClass} p-4 sm:p-5`}>
          <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500 mb-3">
            {medalTallyTitle}
          </h2>
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-2.5">
            {(
              [
                { label: "Gold", value: medals.gold, icon: "🥇" },
                { label: "Silver", value: medals.silver, icon: "🥈" },
                { label: "Bronze", value: medals.bronze, icon: "🥉" },
                { label: "Top 10", value: medals.top10, icon: "🏆" },
              ] as const
            ).map((medal) => (
              <div
                key={medal.label}
                className="rounded-xl border border-white/[0.05] bg-black/20 px-3 py-4 text-center"
              >
                <p className="text-lg" aria-hidden>
                  {medal.icon}
                </p>
                <p className="mt-1 text-2xl font-semibold text-white tabular-nums">
                  {medal.value}
                </p>
                <p className="mt-0.5 text-[11px] text-neutral-500">
                  {medal.label}
                </p>
              </div>
            ))}
          </div>
        </section>
      )}

      {showSummary && (
        <section className={`${cardClass} p-4 sm:p-5`}>
          <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
            Position trend
          </h2>
          <p className="text-[12px] text-neutral-400 mt-0.5 mb-4">
            Finishing position by regatta (lower is better)
            {trendCaption}
          </p>
          {trendPoints.length >= 2 ? (
            <PositionTrendChart
              points={trendPoints}
              mode={trendMode}
              goldEntryDate={trendGoldEntry}
            />
          ) : (
            <p className="text-sm text-neutral-500 py-6 text-center leading-relaxed">
              {trendPoints.length === 1
                ? "One finish so far — the chart appears after a second ranked result."
                : "No ranked finishes yet to chart. Results and series DNS will show here once they land."}
            </p>
          )}
        </section>
      )}
    </>
  );
}
