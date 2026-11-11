"use client";

import type { ProfileIlcaClass } from "@/lib/profileClasses";
import { isProfileIlcaClass } from "@/lib/profileClasses";
import type { BoardDiscipline } from "@/lib/boardProfile";

export type ProfileClassTab = "optimist" | ProfileIlcaClass | BoardDiscipline | "journey";
export type ProfileSectionTab = "overview" | "results" | "awards" | "journey" | "equipment";

type Props = {
  dualClass: boolean;
  preferIlcaFirst: boolean;
  activeTab: ProfileClassTab;
  sectionTab?: ProfileSectionTab;
  optimistCount: number;
  ilcaCount: number;
  journeyCount: number;
  awardsCount?: number;
  /** Count for the class currently on screen. */
  resultsCount?: number;
  showStanding: boolean;
  showEquipment: boolean;
  /** Keep Milestones reachable when an owner has none yet. */
  showMilestones?: boolean;
  onTabChange: (tab: ProfileClassTab) => void;
  onSectionTabChange?: (tab: ProfileSectionTab) => void;
};

function sectionButtonClass(active: boolean): string {
  return `shrink-0 rounded-full px-4 py-2 min-h-11 text-[13px] font-bold touch-manipulation transition cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-harbour ${
    active
      ? "bg-harbour text-sailcloth shadow-xs ring-2 ring-harbour/25 underline decoration-2 underline-offset-4"
      : "border border-cool-veil bg-warm-white text-charcoal hover:bg-aqua-mist hover:text-harbour"
  }`;
}

/** Section strip. Class selection lives once, beside the sailor’s name. */
export function ProfileClassNavigation({
  activeTab,
  sectionTab = "overview",
  optimistCount,
  ilcaCount,
  journeyCount,
  awardsCount = 0,
  resultsCount: resultsCountProp,
  showStanding,
  showEquipment,
  showMilestones,
  onSectionTabChange,
}: Props) {
  const resultsCount =
    resultsCountProp ?? (isProfileIlcaClass(activeTab) ? ilcaCount : optimistCount);
  const milestonesVisible = showMilestones ?? journeyCount > 0;

  return (
    <>
      <nav
        aria-label="Profile sections"
        className="sticky top-14 sm:top-16 z-20 -mx-3 px-3 sm:-mx-6 sm:px-6 py-2 flex items-center gap-2 overflow-x-auto scrollbar-thin bg-sailcloth/95 backdrop-blur-md border-b border-cool-veil"
      >
        <button
          type="button"
          aria-pressed={sectionTab === "overview"}
          onClick={() => onSectionTabChange?.("overview")}
          className={sectionButtonClass(sectionTab === "overview")}
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
            className="sr-only"
          >
            Standing
          </a>
        )}

        {/* Results / Regattas tab */}
        <button
          type="button"
          aria-pressed={sectionTab === "results"}
          onClick={() => onSectionTabChange?.("results")}
          className={sectionButtonClass(sectionTab === "results")}
        >
          Regattas
          {resultsCount > 0 && (
            <span
              className={`ml-1.5 tabular-nums ${
                sectionTab === "results" ? "text-sailcloth/90" : "text-slate-soft"
              }`}
            >
              {resultsCount}
            </span>
          )}
        </button>

        {/* Awards / Prizes tab */}
        {awardsCount != null && awardsCount > 0 && (
          <button
            type="button"
            aria-pressed={sectionTab === "awards"}
            onClick={() => onSectionTabChange?.("awards")}
            className={sectionButtonClass(sectionTab === "awards")}
          >
            Awards
            <span
              className={`ml-1.5 tabular-nums ${
                sectionTab === "awards" ? "text-sailcloth/90" : "text-racing-orange"
              }`}
            >
              {awardsCount}
            </span>
          </button>
        )}

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

        {milestonesVisible && (
        <button
          type="button"
          aria-pressed={sectionTab === "journey"}
          onClick={() => onSectionTabChange?.("journey")}
          className={sectionButtonClass(sectionTab === "journey")}
        >
          Milestones
          {journeyCount > 0 && (
            <span
              className={`ml-1.5 tabular-nums ${
                sectionTab === "journey" ? "text-sailcloth/90" : "text-slate-soft"
              }`}
            >
              {journeyCount}
            </span>
          )}
        </button>
        )}

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
              aria-pressed={sectionTab === "equipment"}
              onClick={() => onSectionTabChange?.("equipment")}
              className={sectionButtonClass(sectionTab === "equipment")}
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
