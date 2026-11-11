"use client";

import { useId } from "react";
import dynamic from "next/dynamic";
import { PROFILE_CARD_CLASS as cardClass } from "./helpers";
import type { ProfileMode, TrendPoint } from "@/lib/profileAnalytics";

const PositionTrendChart = dynamic(
  () =>
    import("./PositionTrendChart").then((module) => module.PositionTrendChart),
  {
    ssr: false,
    loading: () => (
      <div className="h-48 w-full animate-pulse rounded-2xl bg-sailcloth border border-cool-veil" />
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
  /** Key-stat grid. Overview leaves this off so rank stays in the hero. */
  showStats?: boolean;
  keyStatsTitle: string;
  statCells: StatCell[];
  showMedals: boolean;
  medalTallyTitle: string;
  medals: MedalTally;
  trendPoints: TrendPoint[];
  trendMode: ProfileMode;
  trendGoldEntry: string | null;
  trendCaption: string;
  classLabel?: string;
  trendCountry: string;
  setTrendCountry: (country: string) => void;
  trendCountryOptions: { code: string; name: string }[];
};

/** Read-only performance cards kept separate from profile editing state. */
export function ProfilePerformanceSummary({
  showSummary,
  showStats = true,
  keyStatsTitle,
  statCells,
  showMedals,
  medalTallyTitle,
  medals,
  trendPoints,
  trendMode,
  trendGoldEntry,
  trendCaption,
  classLabel,
  trendCountry,
  setTrendCountry,
  trendCountryOptions,
}: Props) {
  const countrySelectId = useId();
  return (
    <>
      {showSummary && showStats && (
        <section className={`${cardClass} overflow-hidden`}>
          <div className="px-4 sm:px-5 pt-4 sm:pt-5 pb-1">
            <h2 className="text-[12px] font-bold uppercase tracking-[0.14em] text-slate-soft">
              {keyStatsTitle}
            </h2>
          </div>
          <div className="grid grid-cols-2 sm:grid-cols-4 divide-x divide-y sm:divide-y-0 divide-cool-veil">
            {statCells.map((stat) => (
              <div
                key={stat.label}
                className="px-2.5 sm:px-3 py-4 sm:py-5 text-center"
              >
                <p
                  className={`text-[1.65rem] sm:text-3xl font-black tabular-nums tracking-tight leading-none ${
                    stat.color.includes("text-emerald")
                      ? "text-harbour"
                      : stat.color.includes("text-sky") || stat.color.includes("text-blue")
                        ? "text-harbour-shadow"
                        : stat.color.includes("text-amber")
                          ? "text-racing-orange"
                          : "text-charcoal"
                  }`}
                >
                  {stat.value}
                </p>
                <p className="mt-1.5 text-[12px] font-bold uppercase tracking-[0.1em] text-slate-soft leading-tight">
                  {stat.label}
                </p>
                {stat.hint && (
                  <p className="mt-0.5 text-[13px] font-medium text-slate-soft leading-tight normal-case tracking-normal">
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
          <h2 className="text-[12px] font-bold uppercase tracking-[0.14em] text-slate-soft mb-3">
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
                className="rounded-xl border border-cool-veil bg-sailcloth/50 px-3 py-4 text-center"
              >
                <p className="text-xl" aria-hidden>
                  {medal.icon}
                </p>
                <p className="mt-1 text-2xl font-black text-harbour-shadow tabular-nums">
                  {medal.value}
                </p>
                <p className="mt-0.5 text-[13px] font-semibold text-slate-soft">
                  {medal.label}
                </p>
              </div>
            ))}
          </div>
        </section>
      )}

      {showSummary && (
        <section className={`${cardClass} p-4 sm:p-5`}>
          <h2 className="text-[12px] font-bold uppercase tracking-[0.14em] text-slate-soft">
            Position trend
          </h2>
          <div className="mt-3 flex flex-wrap items-center gap-2 text-sm text-charcoal">
            <label htmlFor={countrySelectId} className="font-medium text-charcoal">
              Regatta country
            </label>
            <select
              id={countrySelectId}
              value={trendCountry}
              onChange={(event) => setTrendCountry(event.target.value)}
              className="min-w-0 min-h-9 rounded-lg border border-cool-veil bg-sailcloth px-2.5 py-1.5 text-sm text-charcoal"
            >
              {trendCountryOptions.map((option) => (
                <option key={option.code} value={option.code}>{option.name}</option>
              ))}
            </select>
          </div>
          <p className="text-[12px] text-slate-soft mt-1.5 mb-4 font-medium">
            Finishing position by regatta
            {trendCaption}
          </p>
          {trendPoints.length >= 2 ? (
            <PositionTrendChart
              classLabel={classLabel}
              points={trendPoints}
              mode={trendMode}
              goldEntryDate={trendGoldEntry}
            />
          ) : (
            <p className="text-sm text-slate-soft py-6 text-center leading-relaxed">
              {trendCountry === "ALL"
                ? trendPoints.length === 1
                  ? "One ranked finish logged — the chart appears after a second ranked result."
                  : "No ranked finishes logged yet."
                : trendPoints.length === 1
                  ? "One finish in this country — the chart appears after a second ranked result."
                  : "No ranked finishes in this country yet. Overseas results remain in the results history."}
            </p>
          )}
        </section>
      )}
    </>
  );
}
