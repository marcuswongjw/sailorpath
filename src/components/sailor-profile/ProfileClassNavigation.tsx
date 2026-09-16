"use client";

import { PROFILE_CARD_CLASS as cardClass } from "./helpers";

export type ProfileClassTab = "optimist" | "ilca4" | "journey";
export type ProfileSectionTab = "overview" | "results" | "journey" | "equipment";

type Props = {
  dualClass: boolean;
  preferIlcaFirst: boolean;
  activeTab: ProfileClassTab;
  sectionTab?: ProfileSectionTab;
  optimistCount: number;
  ilcaCount: number;
  journeyCount: number;
  showStanding: boolean;
  showEquipment: boolean;
  onTabChange: (tab: ProfileClassTab) => void;
  onSectionTabChange?: (tab: ProfileSectionTab) => void;
};

/** Boat-class tabs and segmented in-page navigation for profiles. */
export function ProfileClassNavigation({
  dualClass,
  preferIlcaFirst,
  activeTab,
  sectionTab = "overview",
  optimistCount,
  ilcaCount,
  journeyCount,
  showStanding,
  showEquipment,
  onTabChange,
  onSectionTabChange,
}: Props) {
  const classTabs: ProfileClassTab[] = preferIlcaFirst
    ? ["ilca4", "optimist", "journey"]
    : ["optimist", "ilca4", "journey"];

  const resultsCount = activeTab === "ilca4" ? ilcaCount : optimistCount;

  return (
    <>
      {dualClass && (
        <div
          className={`${cardClass} p-2 sm:p-2.5`}
          role="tablist"
          aria-label="Boat class"
        >
          <div className="flex gap-1 rounded-xl bg-sailcloth border border-cool-veil p-1">
            {classTabs.map((tab) => {
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
                  className={`flex-1 rounded-lg px-2.5 sm:px-3 py-2 text-[12px] sm:text-[13px] font-bold transition-colors min-h-[40px] cursor-pointer ${
                    selected
                      ? "bg-harbour text-sailcloth shadow-xs"
                      : "text-slate-soft hover:text-charcoal hover:bg-white/40"
                  }`}
                >
                  {isIlca ? "ILCA 4" : isJourney ? "Journey" : "Optimist"}
                  <span
                    className={`ml-1.5 tabular-nums text-[10px] sm:text-[11px] ${
                      selected ? "text-sailcloth/90" : "text-slate-soft"
                    }`}
                  >
                    ({count})
                  </span>
                </button>
              );
            })}
          </div>
          <p className="text-[11px] text-slate-soft mt-1.5 px-1 font-medium">
            {activeTab === "ilca4"
              ? "ILCA 4 ranking, stats, and results"
              : activeTab === "journey"
                ? "Career milestones and highlights"
                : "Optimist series ranking, stats, and results"}
          </p>
        </div>
      )}

      {/* Segmented Tab Navigation Bar */}
      <nav
        aria-label="Profile sections"
        className="sticky top-14 sm:top-16 z-20 -mx-1 px-1 py-2 flex items-center gap-1.5 overflow-x-auto scrollbar-thin bg-sailcloth/95 backdrop-blur-md border-b border-cool-veil"
      >
        <button
          type="button"
          onClick={() => onSectionTabChange?.("overview")}
          className={`shrink-0 rounded-full px-4 py-1.5 text-[11px] font-bold touch-manipulation transition cursor-pointer ${
            sectionTab === "overview"
              ? "bg-harbour text-sailcloth shadow-xs"
              : "border border-cool-veil bg-warm-white text-charcoal hover:bg-aqua-mist hover:text-harbour"
          }`}
        >
          Overview
        </button>

        {/* Backward-compatibility anchor for Overview */}
        <a href="#profile-hero" className="sr-only">
          Overview
        </a>

        {/* Backward-compatibility anchor for Standing */}
        {activeTab !== "journey" && showStanding && (
          <a
            href="#profile-standing"
            onClick={(e) => {
              if (onSectionTabChange) {
                e.preventDefault();
                onSectionTabChange("overview");
                const el = document.getElementById("profile-standing");
                el?.scrollIntoView({ behavior: "smooth" });
              }
            }}
            className="shrink-0 rounded-full border border-cool-veil bg-warm-white px-3.5 py-1.5 text-[11px] font-bold text-charcoal hover:bg-aqua-mist hover:text-harbour touch-manipulation"
          >
            Standing
          </a>
        )}

        {/* Results / Regattas tab */}
        <button
          type="button"
          onClick={() => onSectionTabChange?.("results")}
          className={`shrink-0 rounded-full px-4 py-1.5 text-[11px] font-bold touch-manipulation transition cursor-pointer ${
            sectionTab === "results"
              ? "bg-harbour text-sailcloth shadow-xs"
              : "border border-cool-veil bg-warm-white text-charcoal hover:bg-aqua-mist hover:text-harbour"
          }`}
        >
          Regattas
          {resultsCount > 0 && (
            <span
              className={`ml-1.5 tabular-nums text-[10px] ${
                sectionTab === "results" ? "text-sailcloth/90" : "text-slate-soft"
              }`}
            >
              ({resultsCount})
            </span>
          )}
        </button>

        {/* Backward-compatibility link for Results/Journey */}
        <a
          href="#profile-results"
          onClick={(e) => {
            if (onSectionTabChange) {
              e.preventDefault();
              onSectionTabChange(activeTab === "journey" ? "journey" : "results");
            }
          }}
          className="sr-only"
        >
          {activeTab === "journey" ? "Journey" : "Results"}
        </a>

        {/* Milestones / Journey tab */}
        <button
          type="button"
          onClick={() => onSectionTabChange?.("journey")}
          className={`shrink-0 rounded-full px-4 py-1.5 text-[11px] font-bold touch-manipulation transition cursor-pointer ${
            sectionTab === "journey"
              ? "bg-harbour text-sailcloth shadow-xs"
              : "border border-cool-veil bg-warm-white text-charcoal hover:bg-aqua-mist hover:text-harbour"
          }`}
        >
          Milestones
          {journeyCount > 0 && (
            <span
              className={`ml-1.5 tabular-nums text-[10px] ${
                sectionTab === "journey" ? "text-sailcloth/90" : "text-slate-soft"
              }`}
            >
              ({journeyCount})
            </span>
          )}
        </button>

        {/* Backward-compatibility link for Milestones */}
        {activeTab !== "journey" && journeyCount > 0 && (
          <a
            href="#profile-journey"
            onClick={(e) => {
              if (onSectionTabChange) {
                e.preventDefault();
                onSectionTabChange("journey");
              }
            }}
            className="sr-only"
          >
            Milestones
          </a>
        )}

        {/* Equipment Tab */}
        {showEquipment && (
          <>
            <button
              type="button"
              onClick={() => onSectionTabChange?.("equipment")}
              className={`shrink-0 rounded-full px-4 py-1.5 text-[11px] font-bold touch-manipulation transition cursor-pointer ${
                sectionTab === "equipment"
                  ? "bg-harbour text-sailcloth shadow-xs"
                  : "border border-cool-veil bg-warm-white text-charcoal hover:bg-aqua-mist hover:text-harbour"
              }`}
            >
              Equipment
            </button>
            <a
              href="#profile-equipment"
              onClick={(e) => {
                if (onSectionTabChange) {
                  e.preventDefault();
                  onSectionTabChange("equipment");
                }
              }}
              className="sr-only"
            >
              Equipment
            </a>
          </>
        )}
      </nav>
    </>
  );
}
