"use client";

import { useState } from "react";
import Link from "next/link";
import {
  Search,
  Sailboat,
  LayoutGrid,
  CheckSquare,
  MessageSquare,
  AlertTriangle,
  ChevronRight,
} from "lucide-react";
import {
  PrivateNotesPanel,
  PreRaceChecklist,
  EquipmentInPlacePanel,
  AthleteSelector,
} from "@/components/parent-dashboard";
import { PendingClaimsSection } from "@/components/parent-dashboard/PendingClaimsSection";
import { PersonalSeasonCard } from "@/components/PersonalSeasonCard";
import { AthleteHeroCard } from "@/components/parent-dashboard/AthleteHeroCard";
import { AthleteInsightGrid } from "@/components/parent-dashboard/AthleteInsightGrid";
import { CoachFeedbackPanel } from "@/components/parent-dashboard/CoachFeedbackPanel";
import {
  useFamilyDashboard,
  type FamilyDashboardInitialData,
} from "@/components/parent-dashboard/useFamilyDashboard";
import type { NoteCategory } from "@/components/parent-dashboard/types";
import {
  CARD,
  NESTED,
  SECONDARY_BTN,
  MUTED,
  INK,
  BODY,
} from "@/components/parent-dashboard/styles";

type WorkspaceTab = "overview" | "gear" | "notes";

export function ParentDashboard({
  initialData,
  demoMode = false,
}: {
  initialData?: FamilyDashboardInitialData;
  demoMode?: boolean;
} = {}) {
  const d = useFamilyDashboard({ initialData, demoMode });
  const [workspaceTab, setWorkspaceTab] = useState<WorkspaceTab>("overview");

  if (d.loading) {
    return (
      <div className="flex-1 flex flex-col items-center justify-center gap-3 py-24 px-4">
        <div
          className="h-1 w-40 max-w-[60vw] overflow-hidden rounded-full bg-[var(--sp-cool-veil)]"
          role="status"
          aria-live="polite"
          aria-label="Loading dashboard"
        >
          <div className="h-full w-1/2 animate-pulse rounded-full bg-[var(--sp-harbour-teal)]" />
        </div>
        <p className="text-sm font-semibold text-[var(--sp-slate-soft)]">Loading dashboard…</p>
      </div>
    );
  }

  const { activeAthlete } = d;

  return (
    <div className="mx-auto max-w-6xl w-full px-3 sm:px-4 py-5 sm:py-8 space-y-5 sm:space-y-7">
      <header className="flex flex-col gap-3.5 sm:flex-row sm:items-end sm:justify-between">
        <div className="min-w-0">
          <p className="text-[11px] font-bold uppercase tracking-[0.18em] text-[var(--sp-racing-orange)]">
            {d.isParentStyle ? "Parent workspace" : "Sailor workspace"}
          </p>
          <h1 className="mt-1 text-2xl sm:text-4xl font-black tracking-tight text-[var(--sp-harbour-shadow)]">
            {d.title}
          </h1>
          <p className={`mt-1.5 text-sm ${BODY} max-w-2xl`}>{d.subtitle}</p>
        </div>
        <div className="flex flex-wrap items-center gap-2">
          <Link href="/following" className={SECONDARY_BTN}>
            Following
          </Link>
          <Link href="/sailors" className={SECONDARY_BTN}>
            <Search className="h-3.5 w-3.5" />
            Find a sailor
          </Link>
          <Link href="/account" className={SECONDARY_BTN}>
            Settings
          </Link>
        </div>
      </header>

      {d.error && (
        <p className="text-sm font-bold text-[var(--sp-color-error)] rounded-xl border border-rose-200 bg-rose-50 px-4 py-3">
          {d.error}
        </p>
      )}

      <PendingClaimsSection
        pendingClaims={d.pendingClaims}
        onChanged={() => void d.reload()}
        demoMode={demoMode}
      />

      {d.athletes.length === 0 ? (
        <div className={`${CARD} p-8 sm:p-12 text-center space-y-4`}>
          <Sailboat className={`h-10 w-10 ${MUTED} mx-auto`} />
          <h2 className={`text-lg font-bold ${INK}`}>No linked sailor profiles yet</h2>
          <p className={`text-sm ${BODY} max-w-md mx-auto leading-relaxed`}>
            Search for your child (or yourself), open their profile, and submit a claim as{" "}
            <strong className={INK}>Parent</strong> or{" "}
            <strong className={INK}>Sailor</strong>. Once verified, their dashboard will appear here.
          </p>
          <div className="flex flex-col sm:flex-row gap-2 justify-center pt-2">
            <Link href="/sailors" className="sp-btn-primary">
              Search sailors
            </Link>
            <Link href="/claim-profile" className={SECONDARY_BTN}>
              How claiming works
            </Link>
          </div>
        </div>
      ) : (
        <>
          <AthleteSelector
            athletes={d.athletes}
            selectedAthleteId={d.selectedAthleteId}
            onSelectAthlete={(id) => d.setSelectedAthleteId(id)}
            demoMode={demoMode}
          />

          {activeAthlete && (() => {
            const alertCount = activeAthlete.equipmentAlertCount ?? 0;
            const coachNotesCount =
              (activeAthlete.coachFeedback?.length ?? 0) +
              (activeAthlete.notes?.length ?? 0);

            return (
              <div className="space-y-4 sm:space-y-6">
                <AthleteHeroCard athlete={activeAthlete} demoMode={demoMode} />

                <div
                  className="sp-tabs-scroll items-center gap-2 border-b border-[var(--sp-cool-veil)] pb-2"
                  role="tablist"
                  aria-label="Athlete workspace sections"
                >
                  <button
                    type="button"
                    role="tab"
                    aria-selected={workspaceTab === "overview"}
                    onClick={() => setWorkspaceTab("overview")}
                    className={`min-h-11 inline-flex items-center gap-2 rounded-full px-4 py-2 text-xs font-bold transition-colors whitespace-nowrap ${
                      workspaceTab === "overview"
                        ? "bg-harbour text-sailcloth shadow-xs"
                        : `${NESTED} ${MUTED} hover:border-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-shadow)]`
                    }`}
                  >
                    <LayoutGrid className="h-3.5 w-3.5" />
                    Overview
                  </button>

                  <button
                    type="button"
                    role="tab"
                    aria-selected={workspaceTab === "gear"}
                    onClick={() => setWorkspaceTab("gear")}
                    className={`min-h-11 inline-flex items-center gap-2 rounded-full px-4 py-2 text-xs font-bold transition-colors whitespace-nowrap ${
                      workspaceTab === "gear"
                        ? "bg-harbour text-sailcloth shadow-xs"
                        : `${NESTED} ${MUTED} hover:border-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-shadow)]`
                    }`}
                  >
                    <CheckSquare className="h-3.5 w-3.5" />
                    Gear &amp; Prep
                    {alertCount > 0 && (
                      <span
                        className={`rounded-full px-1.5 py-0.5 text-[10px] font-black leading-none ${
                          workspaceTab === "gear"
                            ? "bg-rose-500 text-white"
                            : "bg-rose-100 text-rose-700"
                        }`}
                      >
                        {alertCount}
                      </span>
                    )}
                  </button>

                  <button
                    type="button"
                    role="tab"
                    aria-selected={workspaceTab === "notes"}
                    onClick={() => setWorkspaceTab("notes")}
                    className={`min-h-11 inline-flex items-center gap-2 rounded-full px-4 py-2 text-xs font-bold transition-colors whitespace-nowrap ${
                      workspaceTab === "notes"
                        ? "bg-harbour text-sailcloth shadow-xs"
                        : `${NESTED} ${MUTED} hover:border-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-shadow)]`
                    }`}
                  >
                    <MessageSquare className="h-3.5 w-3.5" />
                    Coach &amp; Notes
                    {coachNotesCount > 0 && (
                      <span
                        className={`rounded-full px-1.5 py-0.5 text-[10px] font-black leading-none ${
                          workspaceTab === "notes"
                            ? "bg-white/20 text-sailcloth"
                            : "bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)]"
                        }`}
                      >
                        {coachNotesCount}
                      </span>
                    )}
                  </button>
                </div>

                {workspaceTab === "overview" && (
                  <div className="space-y-4 sm:space-y-6" role="tabpanel">
                    {alertCount > 0 && (
                      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2.5 rounded-2xl border border-rose-200 bg-rose-50 px-4 py-3">
                        <div className="flex items-center gap-2 text-xs font-bold text-[var(--sp-color-error)]">
                          <AlertTriangle className="h-4 w-4 shrink-0" />
                          <span>
                            {alertCount} equipment alert
                            {alertCount === 1 ? " requires" : "s require"} attention before racing
                          </span>
                        </div>
                        <button
                          type="button"
                          onClick={() => setWorkspaceTab("gear")}
                          className="inline-flex items-center gap-1 self-start sm:self-auto text-xs font-black text-rose-700 hover:underline min-h-8"
                        >
                          Review Gear &amp; Prep
                          <ChevronRight className="h-3.5 w-3.5" />
                        </button>
                      </div>
                    )}

                    {activeAthlete.season ? (
                      <PersonalSeasonCard
                        season={activeAthlete.season}
                        showSailorName={false}
                        showExplanation={false}
                      />
                    ) : null}

                    <AthleteInsightGrid athlete={activeAthlete} demoMode={demoMode} />
                  </div>
                )}

                {workspaceTab === "gear" && (
                  <div className="grid grid-cols-1 lg:grid-cols-12 gap-5 sm:gap-6" role="tabpanel">
                    <div className="lg:col-span-5">
                      <PreRaceChecklist
                        activeAthlete={activeAthlete}
                        upcomingRegattas={d.upcomingRegattas}
                        checklistState={d.checklistState}
                        customChecklistItems={d.customChecklistItems}
                        newChecklistText={d.newChecklistText}
                        onToggleItem={(id, itemId) => d.toggleChecklistItem(id, itemId)}
                        onAddCustomItem={(id) => d.addCustomChecklistItem(id)}
                        onRemoveCustomItem={(id, itemId) =>
                          d.removeCustomChecklistItem(id, itemId)
                        }
                        onResetChecklist={(id) => d.resetChecklist(id)}
                        onNewChecklistTextChange={(v) => d.setNewChecklistText(v)}
                      />
                    </div>
                    <div className="lg:col-span-7">
                      <EquipmentInPlacePanel
                        activeAthlete={activeAthlete}
                        demoMode={demoMode}
                        showAddGearModal={d.showAddGearModal}
                        addGearTab={d.addGearTab}
                        addGearBusy={d.addGearBusy}
                        customGearCategory={d.customGearCategory}
                        customGearBrand={d.customGearBrand}
                        customGearModel={d.customGearModel}
                        customGearLabel={d.customGearLabel}
                        customGearCondition={d.customGearCondition}
                        customGearPrimary={d.customGearPrimary}
                        onOpenAddGear={() => d.setShowAddGearModal(true)}
                        onCloseAddGear={() => d.setShowAddGearModal(false)}
                        onSetAddGearTab={(tab) => d.setAddGearTab(tab)}
                        onSetCustomCategory={(cat) => d.setCustomGearCategory(cat)}
                        onSetCustomBrand={(val) => d.setCustomGearBrand(val)}
                        onSetCustomModel={(val) => d.setCustomGearModel(val)}
                        onSetCustomLabel={(val) => d.setCustomGearLabel(val)}
                        onSetCustomCondition={(val) => d.setCustomGearCondition(val)}
                        onSetCustomPrimary={(val) => d.setCustomGearPrimary(val)}
                        onToggleCondition={(gearId, currentCondition) =>
                          void d.handleToggleGearCondition(
                            activeAthlete.id,
                            gearId,
                            currentCondition
                          )
                        }
                        onTogglePrimary={(gearId, currentPrimary) =>
                          void d.handleToggleGearPrimary(
                            activeAthlete.id,
                            gearId,
                            currentPrimary
                          )
                        }
                        onDeleteGear={(gearId) =>
                          void d.handleDeleteGear(activeAthlete.id, gearId)
                        }
                        onAddGearPreset={(preset) =>
                          void d.handleAddGearPreset(activeAthlete.id, preset)
                        }
                        onCreateCustomGear={() =>
                          void d.handleCreateCustomGear(activeAthlete.id)
                        }
                      />
                    </div>
                  </div>
                )}

                {workspaceTab === "notes" && (
                  <div className="grid grid-cols-1 lg:grid-cols-12 gap-5 sm:gap-6" role="tabpanel">
                    <div className="lg:col-span-7">
                      <CoachFeedbackPanel athlete={activeAthlete} />
                    </div>
                    <div className="lg:col-span-5">
                      <PrivateNotesPanel
                        isParent={activeAthlete.ownerRelation === "parent"}
                        activeAthlete={activeAthlete}
                        noteDraft={d.noteDraft}
                        selectedCategory={d.selectedCategory}
                        noteBusy={d.noteBusy}
                        onDraftChange={(id, value) =>
                          d.setNoteDraft((prev) => ({ ...prev, [id]: value }))
                        }
                        onCategoryChange={(cat) =>
                          d.setSelectedCategory(cat as NoteCategory)
                        }
                        onAddNote={(id) => void d.addNote(id)}
                        onDeleteNote={(id) => void d.deleteNote(id)}
                      />
                    </div>
                  </div>
                )}
              </div>
            );
          })()}
        </>
      )}

      {demoMode && (
        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-6 sm:p-8 text-center space-y-3 shadow-xs">
          <p className="text-[11px] font-bold uppercase tracking-[0.18em] text-[var(--sp-racing-orange)]">
            Ready to track your sailor?
          </p>
          <h2 className="text-xl sm:text-2xl font-black text-[var(--sp-harbour-shadow)]">
            Claim your sailor&apos;s profile on SailorPath
          </h2>
          <p className={`text-sm ${BODY} max-w-lg mx-auto`}>
            Follow race results, monitor selection trial standings, track equipment wear, and review coach debriefs all in one place.
          </p>
          <div className="pt-2 flex flex-col sm:flex-row gap-3 justify-center items-center">
            <Link href="/claim-profile" className="sp-btn-primary">
              Claim sailor profile
            </Link>
            <Link href="/sample" className={SECONDARY_BTN}>
              View sailor profile demo
            </Link>
          </div>
        </div>
      )}

      <p className={`text-center text-xs ${MUTED} pt-2`}>
        <Link href="/support" className={`${MUTED} hover:text-[var(--sp-harbour-teal)] transition-colors`}>
          Support &amp; Feedback
        </Link>
      </p>
    </div>
  );
}
