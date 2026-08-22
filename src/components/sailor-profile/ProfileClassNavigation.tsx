"use client";

import { PROFILE_CARD_CLASS as cardClass } from "./helpers";

export type ProfileClassTab = "optimist" | "ilca4" | "journey";

type Props = {
  dualClass: boolean;
  preferIlcaFirst: boolean;
  activeTab: ProfileClassTab;
  optimistCount: number;
  ilcaCount: number;
  journeyCount: number;
  showStanding: boolean;
  showEquipment: boolean;
  onTabChange: (tab: ProfileClassTab) => void;
};

/** Boat-class tabs and sticky in-page navigation for long profiles. */
export function ProfileClassNavigation({
  dualClass,
  preferIlcaFirst,
  activeTab,
  optimistCount,
  ilcaCount,
  journeyCount,
  showStanding,
  showEquipment,
  onTabChange,
}: Props) {
  const tabs: ProfileClassTab[] = preferIlcaFirst
    ? ["ilca4", "optimist", "journey"]
    : ["optimist", "ilca4", "journey"];

  return (
    <>
      {dualClass && (
        <div
          className={`${cardClass} p-2 sm:p-2.5`}
          role="tablist"
          aria-label="Boat class"
        >
          <div className="flex gap-1 rounded-xl bg-black/30 border border-white/[0.06] p-1">
            {tabs.map((tab) => {
              const isIlca = tab === "ilca4";
              const isJourney = tab === "journey";
              const count = isJourney
                ? journeyCount
                : isIlca
                  ? ilcaCount
                  : optimistCount;
              const selected = activeTab === tab;
              return (
                <button
                  key={tab}
                  type="button"
                  role="tab"
                  aria-selected={selected}
                  onClick={() => onTabChange(tab)}
                  className={`flex-1 rounded-lg px-2.5 sm:px-3 py-2.5 text-[12px] sm:text-[13px] font-semibold transition-colors min-h-[44px] ${
                    selected
                      ? isIlca
                        ? "bg-sky-600 text-white shadow-sm"
                        : isJourney
                          ? "bg-violet-600 text-white shadow-sm"
                          : "bg-orange-500 text-white shadow-sm"
                      : "text-neutral-400 hover:text-white"
                  }`}
                >
                  {isIlca ? "ILCA 4" : isJourney ? "Journey" : "Optimist"}
                  <span
                    className={`ml-1.5 tabular-nums text-[10px] sm:text-[11px] ${
                      selected ? "text-white/80" : "text-neutral-400"
                    }`}
                  >
                    ({count})
                  </span>
                </button>
              );
            })}
          </div>
          <p className="text-[11px] text-neutral-500 mt-2 px-1">
            {activeTab === "ilca4"
              ? "ILCA 4 ranking, stats, and results"
              : activeTab === "journey"
                ? "Career milestones and highlights"
                : "Optimist series ranking, stats, and results"}
          </p>
        </div>
      )}

      <nav
        aria-label="Profile sections"
        className="sticky top-14 sm:top-16 z-20 -mx-1 px-1 py-1.5 flex gap-1.5 overflow-x-auto scrollbar-thin bg-[#090a0f]/95 backdrop-blur-md border-b border-white/5"
      >
        {activeTab !== "journey" && showStanding && (
          <a
            href="#profile-standing"
            className="shrink-0 rounded-full border border-white/10 bg-white/[0.03] px-3 py-1.5 text-[11px] font-bold text-slate-300 hover:text-white hover:border-orange-500/40 touch-manipulation"
          >
            Standing
          </a>
        )}
        <a
          href="#profile-results"
          className="shrink-0 rounded-full border border-white/10 bg-white/[0.03] px-3 py-1.5 text-[11px] font-bold text-slate-300 hover:text-white hover:border-orange-500/40 touch-manipulation"
        >
          {activeTab === "journey" ? "Journey" : "Results"}
        </a>
        {showEquipment && (
          <a
            href="#profile-equipment"
            className="shrink-0 rounded-full border border-white/10 bg-white/[0.03] px-3 py-1.5 text-[11px] font-bold text-slate-300 hover:text-white hover:border-orange-500/40 touch-manipulation"
          >
            Equipment
          </a>
        )}
      </nav>
    </>
  );
}
