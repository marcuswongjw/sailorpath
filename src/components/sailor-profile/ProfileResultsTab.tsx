"use client";

import type React from "react";
import Link from "next/link";
import { X, StickyNote, Plus } from "lucide-react";
import { ProfileRegattaRow } from "./ProfileRegattaRow";
import { ProfileJourneyPanel } from "./ProfileJourneyPanel";
import type {
  ProfileResult,
} from "@/lib/profileAnalytics";
import type { JourneyHighlight } from "@/lib/sailingJourney";
import type {
  ObservationItem,
} from "./types";
import type { JourneyDraft } from "./ProfileJourneyPanel";

export type ProfileResultsTabProps = {
  cardClass: string;
  resultsTab: string;
  resultsTitle?: string;
  dualClass: boolean;
  activeResultsList: ProfileResult[];
  visibleResults: ProfileResult[];
  hasMoreResults: boolean;
  showAllResults: boolean;
  onShowAllToggle: () => void;
  optimistScope: "gold" | "all";
  showOptimistScopeFilter: boolean;
  onOptimistScopeChange: (scope: "gold" | "all") => void;
  ilca4Tenure: { label: string } | null;
  primaryIsIlca: boolean;
  ownerView: boolean;
  dismissSailorTip: boolean;
  onDismissSailorTip: () => void;
  demoMode: boolean;
  demoRole?: string | null;
  sailorId: string;
  awards: unknown[];
  showEquipment: boolean;
  gearByRegatta: Record<string, { category: string; brand: string | null; label: string | null }[]>;
  goldEntryDate: string | null;
  personalBusy: boolean;
  personalMsg: string | null;
  hasPrivateAccess: boolean;
  observations: ObservationItem[];
  obsForm: {
    raceNumber: string;
    position: string;
    wind: string;
    note: string;
    isPrivate: boolean;
  };
  editingObsId: string | null;
  obsBusy: boolean;
  obsMsg: string | null;
  expandedRegattaId: string | null;
  onToggleExpand: (id: string | null) => void;
  onDeleteResult: (r: ProfileResult) => void;
  setExpandedRegattaId: (id: string | null) => void;
  onObsFormChange: (f: ProfileResultsTabProps["obsForm"]) => void;
  onObsSave: (regattaId: string) => void;
  onObsCancel: () => void;
  onObsDelete: (o: ObservationItem) => void;
  onObsEdit: (o: ObservationItem, regattaId: string) => void;
  onObsDemoDelete: (regattaId: string, raceNumber: number) => void;
  /** Journey panel props (shown when dual-class and resultsTab === "journey") */
  displayJourney: JourneyHighlight[];
  journeyDraft: JourneyDraft;
  setJourneyDraft: React.Dispatch<React.SetStateAction<JourneyDraft>>;
  journeyBusy: boolean;
  journeyMsg: string | null;
  onAddJourney: () => void;
  onUpdateJourney: (id: string, updated: { when: string; title: string; detail: string }, isSystem?: boolean) => void;
  onRemoveJourney: (id: string, isSystem?: boolean) => void;
};

/**
 * Regattas tab for the sailor profile — shows the regatta results table,
 * scope filter (gold / all), owner tip banner, journey panel (dual-class),
 * and the list of ProfileRegattaRow entries.
 */
export function ProfileResultsTab({
  cardClass,
  resultsTab,
  resultsTitle,
  dualClass,
  activeResultsList,
  visibleResults,
  hasMoreResults,
  showAllResults,
  onShowAllToggle,
  optimistScope,
  showOptimistScopeFilter,
  onOptimistScopeChange,
  ilca4Tenure,
  primaryIsIlca,
  ownerView,
  dismissSailorTip,
  onDismissSailorTip,
  demoMode,
  demoRole,
  sailorId,
  awards,
  showEquipment,
  gearByRegatta,
  goldEntryDate,
  personalBusy,
  personalMsg,
  hasPrivateAccess,
  observations,
  obsForm,
  editingObsId,
  obsBusy,
  obsMsg,
  expandedRegattaId,
  onToggleExpand,
  onDeleteResult,
  setExpandedRegattaId,
  onObsFormChange,
  onObsSave,
  onObsCancel,
  onObsDelete,
  onObsEdit,
  onObsDemoDelete,
  displayJourney,
  journeyDraft,
  setJourneyDraft,
  journeyBusy,
  journeyMsg,
  onAddJourney,
  onUpdateJourney,
  onRemoveJourney,
}: ProfileResultsTabProps) {
  return (
    <div id="profile-results" className="scroll-mt-28 space-y-4">
      <section className={`${cardClass} overflow-hidden`}>
        <div className="px-4 sm:px-5 pt-4 sm:pt-5 pb-2 flex flex-wrap items-end justify-between gap-2">
          <div className="min-w-0 flex-1">
            <h2 className="text-[12px] font-bold uppercase tracking-[0.14em] text-slate-soft">
              {resultsTab === "journey"
                ? "Sailing journey"
                : resultsTitle
                  ? resultsTitle
                  : dualClass && resultsTab === "ilca4"
                    ? "Regatta results · ILCA 4"
                    : dualClass && resultsTab === "optimist"
                      ? "Regatta results · Optimist"
                      : "Regatta results"}
            </h2>
            {resultsTab !== "journey" && (
            <p className="text-[13px] text-slate-soft mt-1 font-medium">
              {(() => {
                const list = activeResultsList;
                const n = list.length;
                return showAllResults
                  ? `All ${n} listed`
                  : `Showing ${Math.min(8, n)} of ${n}`;
              })()}
              {showOptimistScopeFilter && optimistScope === "gold"
                ? " · gold fleet"
                : ""}
              {dualClass && resultsTab === "ilca4" && ilca4Tenure
                ? ` · in ILCA 4 ${ilca4Tenure.label} (from first race)`
                : ""}
              {!dualClass && primaryIsIlca && ilca4Tenure
                ? ` · in ILCA 4 ${ilca4Tenure.label} (from first race)`
                : ""}
            </p>
            )}
            {showOptimistScopeFilter && (
              <div
                className="mt-2 inline-flex rounded-full border border-cool-veil bg-sailcloth p-0.5 gap-0.5"
                role="group"
                aria-label="Optimist results filter"
              >
                <button
                  type="button"
                  onClick={() => onOptimistScopeChange("gold")}
                  className={`rounded-full px-3 py-1 text-[13px] font-bold touch-manipulation min-h-[1.75rem] cursor-pointer ${
                    optimistScope === "gold"
                      ? "bg-harbour text-sailcloth shadow-2xs"
                      : "text-slate-soft hover:text-charcoal"
                  }`}
                >
                  Gold only
                </button>
                <button
                  type="button"
                  onClick={() => onOptimistScopeChange("all")}
                  className={`rounded-full px-3 py-1 text-[13px] font-bold touch-manipulation min-h-[1.75rem] cursor-pointer ${
                    optimistScope === "all"
                      ? "bg-harbour text-sailcloth shadow-2xs"
                      : "text-slate-soft hover:text-charcoal"
                  }`}
                >
                  All Optimist
                </button>
              </div>
            )}
          </div>
          {ownerView && resultsTab !== "journey" && (
            <p className="text-[13px] text-slate-soft inline-flex items-center gap-1 font-medium">
              <StickyNote className="h-3 w-3 text-harbour" />
              Expand a row for race notes
            </p>
          )}
        </div>

        {ownerView &&
          !dismissSailorTip &&
          resultsTab !== "journey" &&
          (demoMode ? demoRole === "sailor" : true) && (
            <div className="mx-4 sm:mx-5 mb-3 flex items-start gap-2 rounded-xl border border-harbour/20 bg-aqua-mist/50 px-3.5 py-2.5 shadow-2xs">
              <p className="flex-1 text-[12px] text-charcoal leading-relaxed">
                <span className="font-bold text-harbour">Tip: </span>
                Expand any regatta to add race observations (place, wind, notes).
                Use the{" "}
                <span className="font-bold text-harbour-shadow">📝 Add note</span>{" "}
                control on each row.
              </p>
              <button
                type="button"
                onClick={onDismissSailorTip}
                className="shrink-0 rounded-md p-1 text-slate-soft hover:text-charcoal cursor-pointer"
                aria-label="Dismiss tip"
              >
                <X className="h-3.5 w-3.5" />
              </button>
            </div>
          )}

        {resultsTab === "journey" && dualClass ? (
          <ProfileJourneyPanel
            variant="tab"
            items={displayJourney}
            isOwner={ownerView}
            draft={journeyDraft}
            setDraft={setJourneyDraft}
            busy={journeyBusy}
            message={journeyMsg}
            onAdd={onAddJourney}
            onUpdate={(id, updated, isSystem) =>
              onUpdateJourney(id, updated, isSystem)
            }
            onRemove={(id, isSystem) => onRemoveJourney(id, isSystem)}
          />
        ) : null}

        {resultsTab !== "journey" && ownerView && !demoMode && (
          <div className="mx-4 sm:mx-5 mb-3 rounded-xl border border-cool-veil bg-sailcloth/50 p-3 flex flex-col sm:flex-row sm:items-center justify-between gap-2">
            <p className="text-[13px] text-slate-soft">
              Log an overseas, club, or training regatta — attach evidence for
              a Verified ✓ badge.
            </p>
            <div className="flex items-center gap-3 shrink-0">
              {personalMsg && (
                <p className="text-[13px] font-bold text-harbour">{personalMsg}</p>
              )}
              <Link
                href={`/athlete?id=${sailorId}&tab=results&action=new`}
                className="sp-secondary inline-flex items-center gap-1.5 rounded-lg px-3 py-1.5 text-[13px] font-bold cursor-pointer"
              >
                <Plus className="h-3.5 w-3.5" />
                Log a regatta result
              </Link>
            </div>
          </div>
        )}

        {resultsTab !== "journey" && visibleResults.length === 0 ? (
          <p className="px-5 pb-5 text-sm text-slate-soft font-medium">
            No regatta results yet.
          </p>
        ) : resultsTab !== "journey" ? (
          <>
            <div
              className={`hidden sm:grid gap-2 px-4 sm:px-5 py-2.5 border-t border-cool-veil text-[12px] font-bold uppercase tracking-wider text-slate-soft ${
                primaryIsIlca
                  ? "grid-cols-[1.25rem_2.75rem_1fr_2.5rem_4.25rem]"
                  : "grid-cols-[1.25rem_2.75rem_1fr_4.5rem_4.25rem]"
              }`}
            >
              <span />
              <span>{primaryIsIlca ? "Points" : "Rank"}</span>
              <span>Event</span>
              <span className="text-right">
                {primaryIsIlca ? "Rank" : "Nett Score"}
              </span>
              <span className="text-right">
                {primaryIsIlca ? "Class" : "Fleet"}
              </span>
            </div>
            <div className="divide-y divide-cool-veil">
              {visibleResults.map((res, idx) => (
                <ProfileRegattaRow
                  key={String(res.regattaId || res.id || idx)}
                  res={res as ProfileResult}
                  idx={idx}
                  expandedRegattaId={expandedRegattaId}
                  primaryIsIlca={primaryIsIlca}
                  ownerView={ownerView}
                  awards={awards}
                  showEquipment={showEquipment}
                  gearByRegatta={gearByRegatta}
                  goldEntryDate={goldEntryDate}
                  demoMode={demoMode}
                  personalBusy={personalBusy}
                  personalMsg={personalMsg}
                  hasPrivateAccess={hasPrivateAccess}
                  observations={observations}
                  obsForm={obsForm}
                  editingObsId={editingObsId}
                  obsBusy={obsBusy}
                  obsMsg={obsMsg}
                  onToggle={(id) => onToggleExpand(expandedRegattaId === id ? null : id)}
                  onDeleteResult={(r) => onDeleteResult(r)}
                  setExpandedRegattaId={setExpandedRegattaId}
                  onObsFormChange={(f) => onObsFormChange(f)}
                  onObsSave={(id) => onObsSave(id)}
                  onObsCancel={onObsCancel}
                  onObsDelete={(o) => onObsDelete(o)}
                  onObsEdit={(o, id) => onObsEdit(o, id)}
                  onObsDemoDelete={(regattaId, raceNumber) =>
                    onObsDemoDelete(regattaId, raceNumber)
                  }
                />
              ))}
            </div>
            {hasMoreResults && (
              <div className="border-t border-cool-veil px-4 sm:px-5 py-3 text-center bg-sailcloth/30">
                <button
                  type="button"
                  onClick={onShowAllToggle}
                  className="text-[12px] font-bold text-harbour hover:text-harbour-shadow transition cursor-pointer"
                >
                  {showAllResults
                    ? "Show fewer results"
                    : `View all ${activeResultsList.length} results →`}
                </button>
              </div>
            )}
          </>
        ) : null}
      </section>
    </div>
  );
}
