"use client";

import { Anchor } from "lucide-react";
import { formatEventWhen } from "@/lib/profileUi";
import { profileBoatClassGroup } from "@/lib/profileAnalytics";
import type {
  ProfileMode,
  TrendPoint,
  ProfileResult,
} from "@/lib/profileAnalytics";
import { ProfileAwardsCabinet } from "./ProfileAwardsCabinet";
import { ProfileStandingCard } from "./ProfileStandingCard";
import { ProfilePerformanceSummary } from "./ProfilePerformanceSummary";
import type { JourneyHighlight } from "@/lib/sailingJourney";
import type { SeriesStandingProps } from "./types";

export type ProfileOverviewTabProps = {
  awards: unknown[];
  sailorName: string;
  ownerView: boolean;
  activeStanding: SeriesStandingProps | null;
  standingIsIlca: boolean;
  seriesDnsCount: number;
  cardClass: string;
  resultsTab: string;
  keyStatsTitle: string;
  statCells: StatCell[];
  showMedals: boolean;
  medalTallyTitle: string;
  medals: MedalTally;
  trendPoints: TrendPoint[];
  trendMode: ProfileMode;
  trendGoldEntry: string | null;
  trendCaption: string;
  activeResultsList: ProfileResult[];
  primaryIsIlca: boolean;
  displayJourney: JourneyHighlight[];
  showEquipmentSection: boolean;
  onNavigateTab: (tab: string) => void;
};

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
  show: boolean;
};

/**
 * Overview tab for the sailor profile — shows awards, standing, performance
 * summary, recent regattas, career milestones, and equipment locker snapshot.
 */
export function ProfileOverviewTab({
  awards,
  sailorName,
  ownerView,
  activeStanding,
  standingIsIlca,
  seriesDnsCount,
  cardClass,
  resultsTab,
  keyStatsTitle,
  statCells,
  showMedals,
  medalTallyTitle,
  medals,
  trendPoints,
  trendMode,
  trendGoldEntry,
  trendCaption,
  activeResultsList,
  primaryIsIlca,
  displayJourney,
  showEquipmentSection,
  onNavigateTab,
}: ProfileOverviewTabProps) {
  return (
    <div className="space-y-4">
      {/* Awards & Honours Cabinet */}
      {awards.length > 0 && (
        <ProfileAwardsCabinet
          awards={awards as never}
          sailorName={sailorName}
          isOwner={ownerView}
        />
      )}

      {/* Series / ILCA national standing */}
      {activeStanding && resultsTab !== "journey" && (
        <ProfileStandingCard
          standing={activeStanding}
          standingIsIlca={standingIsIlca}
          seriesDnsCount={seriesDnsCount}
          cardClass={cardClass}
        />
      )}

      <ProfilePerformanceSummary
        showSummary={resultsTab !== "journey"}
        keyStatsTitle={keyStatsTitle}
        statCells={statCells}
        showMedals={showMedals}
        medalTallyTitle={medalTallyTitle}
        medals={medals}
        trendPoints={trendPoints}
        trendMode={trendMode}
        trendGoldEntry={trendGoldEntry}
        trendCaption={trendCaption}
      />

      {/* Recent Regattas Snapshot */}
      {activeResultsList.length > 0 && (
        <section className={`${cardClass} p-4 sm:p-5 space-y-3`}>
          <div className="flex items-center justify-between gap-2">
            <div>
              <h2 className="text-[12px] font-bold uppercase tracking-[0.14em] text-slate-soft">
                Recent Regattas
              </h2>
              <p className="text-xs text-slate-soft mt-0.5 font-medium">
                Latest competition finishes
              </p>
            </div>
            <button
              type="button"
              onClick={() => onNavigateTab("results")}
              className="text-[11px] font-bold text-harbour hover:text-harbour-shadow transition cursor-pointer"
            >
              View all {activeResultsList.length} results →
            </button>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-3 gap-2.5">
            {activeResultsList.slice(0, 3).map((res, idx) => {
              const rank = res.rank != null ? Number(res.rank) : null;
              const dns = Boolean(res.isDns || res.isDNS);
              const isIlcaRow =
                primaryIsIlca ||
                profileBoatClassGroup((res as ProfileResult).boatClass) ===
                  "ilca4";
              const fleetSize = res.totalFleetSize ?? res.fleetSize;
              const dateStr = formatEventWhen(res.regattaDate as string);
              return (
                <div
                  key={String(res.id || idx)}
                  className="rounded-xl border border-cool-veil bg-sailcloth/60 p-3.5 flex flex-col justify-between"
                >
                  <div>
                    <p className="text-[13px] text-slate-soft truncate font-medium">
                      {dateStr}
                    </p>
                    <p
                      className="text-[13px] font-bold text-harbour-shadow line-clamp-1 mt-0.5"
                      title={res.regattaName}
                    >
                      {res.regattaName}
                    </p>
                  </div>
                  <div className="mt-3 flex items-baseline justify-between">
                    <span
                      className={`text-xl font-black tabular-nums ${
                        dns
                          ? "text-racing-orange"
                          : isIlcaRow
                            ? "text-harbour"
                            : "text-charcoal"
                      }`}
                    >
                      {dns ? "DNS" : rank != null ? `#${rank}` : "—"}
                    </span>
                    {fleetSize ? (
                      <span className="text-[13px] text-slate-soft tabular-nums font-medium">
                        of {fleetSize} boats
                      </span>
                    ) : null}
                  </div>
                </div>
              );
            })}
          </div>
        </section>
      )}

      {/* Career Milestones Snapshot */}
      {displayJourney.length > 0 && (
        <section className={`${cardClass} p-4 sm:p-5 space-y-3`}>
          <div className="flex items-center justify-between gap-2">
            <div>
              <h2 className="text-[12px] font-bold uppercase tracking-[0.14em] text-slate-soft">
                Career Milestones
              </h2>
              <p className="text-xs text-slate-soft mt-0.5 font-medium">
                Key pathway achievements
              </p>
            </div>
            <button
              type="button"
              onClick={() => onNavigateTab("journey")}
              className="text-[11px] font-bold text-harbour hover:text-harbour-shadow transition cursor-pointer"
            >
              View all {displayJourney.length} milestones →
            </button>
          </div>
          <div className="space-y-2">
            {displayJourney.slice(0, 2).map((m) => (
              <div
                key={m.id}
                className="flex items-start gap-3 rounded-xl border border-cool-veil bg-sailcloth/50 px-3.5 py-2.5"
              >
                <span className="mt-0.5 flex h-7 w-7 shrink-0 items-center justify-center rounded-lg bg-aqua-mist text-harbour font-bold text-xs">
                  ★
                </span>
                <div className="min-w-0 flex-1">
                  <div className="flex items-center justify-between gap-2">
                    <p className="text-[13px] font-bold text-harbour-shadow truncate">
                      {m.title}
                    </p>
                    {m.when && (
                      <span className="text-[13px] text-slate-soft font-medium shrink-0">
                        {m.when}
                      </span>
                    )}
                  </div>
                  {m.detail && (
                    <p className="text-[12px] text-slate-soft mt-0.5 line-clamp-2 leading-relaxed">
                      {m.detail}
                    </p>
                  )}
                </div>
              </div>
            ))}
          </div>
        </section>
      )}

      {/* Equipment Locker Snapshot */}
      {showEquipmentSection && (
        <section
          className={`${cardClass} p-4 sm:p-5 flex items-center justify-between gap-3`}
        >
          <div className="flex items-center gap-3 min-w-0">
            <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-aqua-mist border border-harbour/20 text-harbour">
              <Anchor className="h-5 w-5" />
            </div>
            <div>
              <h2 className="text-[13px] font-bold text-harbour-shadow">
                Boat Locker & Equipment
              </h2>
              <p className="text-[13px] text-slate-soft mt-0.5 font-medium">
                Private gear inventory, condition statuses & use logs
              </p>
            </div>
          </div>
          <button
            type="button"
            onClick={() => onNavigateTab("equipment")}
            className="shrink-0 sp-secondary inline-flex items-center px-3.5 py-2 text-xs font-bold transition touch-manipulation cursor-pointer"
          >
            Open Locker →
          </button>
        </section>
      )}
    </div>
  );
}
