"use client";

import { Sailboat } from "lucide-react";
import { formatEventWhen } from "@/lib/profileUi";
import { ordinal, profileBoatClassGroup } from "@/lib/profileAnalytics";
import type {
  ProfileMode,
  TrendPoint,
  ProfileResult,
} from "@/lib/profileAnalytics";
import { ProfileStandingCard } from "./ProfileStandingCard";
import { ProfilePerformanceSummary } from "./ProfilePerformanceSummary";
import type { SeriesStandingProps } from "./types";

export type ProfileOverviewTabProps = {
  activeStanding: SeriesStandingProps | null;
  standingIsIlca: boolean;
  seriesDnsCount: number;
  cardClass: string;
  resultsTab: string;
  trendPoints: TrendPoint[];
  trendMode: ProfileMode;
  trendGoldEntry: string | null;
  trendCaption: string;
  activeResultsList: ProfileResult[];
  primaryIsIlca: boolean;
  onNavigateTab: (tab: string) => void;
};

/**
 * Overview answers “how is this sailor doing?” and “what next?”:
 * the class standing, a short trend, and a few recent regattas.
 */
export function ProfileOverviewTab({
  activeStanding,
  standingIsIlca,
  seriesDnsCount,
  cardClass,
  resultsTab,
  trendPoints,
  trendMode,
  trendGoldEntry,
  trendCaption,
  activeResultsList,
  primaryIsIlca,
  onNavigateTab,
}: ProfileOverviewTabProps) {
  const classLabel = standingIsIlca || resultsTab === "ilca4" ? "ILCA 4" : "Optimist";
  const recent = activeResultsList.slice(0, 3);

  return (
    <div className="grid gap-4 lg:grid-cols-2 lg:items-start">
      <div className="space-y-4 min-w-0">
        {activeStanding && resultsTab !== "journey" ? (
          <ProfileStandingCard
            standing={activeStanding}
            standingIsIlca={standingIsIlca}
            seriesDnsCount={seriesDnsCount}
            cardClass={cardClass}
          />
        ) : (
          <section className={`${cardClass} p-4 sm:p-5`}>
            <h2 className="text-[13px] font-bold text-harbour-shadow">
              {classLabel} standing
            </h2>
            <p className="mt-2 text-[14px] text-charcoal leading-relaxed">
              {`No ranked ${classLabel} results for this series yet.`}
            </p>
          </section>
        )}

        <ProfilePerformanceSummary
          showSummary={resultsTab !== "journey"}
          showStats={false}
          keyStatsTitle=""
          statCells={[]}
          showMedals={false}
          medalTallyTitle=""
          medals={{ gold: 0, silver: 0, bronze: 0, top10: 0 }}
          trendPoints={trendPoints}
          trendMode={trendMode}
          trendGoldEntry={trendGoldEntry}
          trendCaption={trendCaption}
        />
      </div>

      <section className={`${cardClass} p-4 sm:p-5 space-y-1 min-w-0`}>
        <div className="flex items-center justify-between gap-2 pb-2">
          <h2 className="text-[15px] font-black text-harbour-shadow">
            Recent {classLabel} regattas
          </h2>
          {activeResultsList.length > 0 && (
            <button
              type="button"
              onClick={() => onNavigateTab("results")}
              className="shrink-0 text-[13px] font-bold text-racing-orange hover:text-harbour transition cursor-pointer"
            >
              View all
            </button>
          )}
        </div>

        {recent.length === 0 ? (
          <p className="py-6 text-[13px] text-slate-soft leading-relaxed">
            No {classLabel} regattas on this profile yet.
          </p>
        ) : (
          <ul className="divide-y divide-cool-veil">
            {recent.map((res, idx) => {
              const rank = res.rank != null ? Number(res.rank) : null;
              const dns = Boolean(res.isDns || res.isDNS);
              const isIlcaRow =
                primaryIsIlca ||
                profileBoatClassGroup(res.boatClass) === "ilca4" ||
                classLabel === "ILCA 4";
              const dateStr = formatEventWhen(res.regattaDate as string);
              const place = dns
                ? "DNS"
                : rank != null && Number.isFinite(rank)
                  ? ordinal(rank)
                  : "—";
              return (
                <li key={String(res.id || idx)}>
                  <button
                    type="button"
                    onClick={() => onNavigateTab("results")}
                    className="flex w-full items-center gap-3 py-3 text-left hover:bg-sailcloth/60 rounded-xl px-1"
                  >
                    <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-aqua-mist text-harbour">
                      <Sailboat className="h-4 w-4" aria-hidden />
                    </span>
                    <span className="min-w-0 flex-1">
                      <span className="block text-[14px] font-bold text-harbour-shadow truncate">
                        {res.regattaName || "Regatta"}
                      </span>
                      <span className="mt-0.5 block text-[12px] text-slate-soft truncate">
                        {[res.geography, dateStr].filter(Boolean).join(" · ") ||
                          dateStr ||
                          "Date to be confirmed"}
                      </span>
                    </span>
                    <span className="shrink-0 text-right">
                      <span className="block text-lg font-black tabular-nums text-harbour-shadow">
                        {place}
                      </span>
                      <span className="block text-[11px] font-semibold text-slate-soft">
                        {isIlcaRow ? "ILCA 4" : "Optimist"}
                      </span>
                    </span>
                  </button>
                </li>
              );
            })}
          </ul>
        )}
      </section>
    </div>
  );
}
