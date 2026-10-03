"use client";

import Link from "next/link";
import { Search, Sailboat } from "lucide-react";
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
  SECONDARY_BTN,
  MUTED,
  INK,
  BODY,
} from "@/components/parent-dashboard/styles";

export function ParentDashboard({
  initialData,
  demoMode = false,
}: {
  initialData?: FamilyDashboardInitialData;
  demoMode?: boolean;
} = {}) {
  const d = useFamilyDashboard({ initialData, demoMode });

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
    <div className="mx-auto max-w-6xl w-full px-4 py-8 sm:py-12 space-y-6 sm:space-y-8">
      <header className="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div className="min-w-0">
          <p className="text-[11px] font-bold uppercase tracking-[0.18em] text-[var(--sp-racing-orange)]">
            {d.isParentStyle ? "Parent workspace" : "Sailor workspace"}
          </p>
          <h1 className="mt-1 text-3xl font-black tracking-tight text-[var(--sp-harbour-shadow)] sm:text-4xl">
            {d.title}
          </h1>
          <p className={`mt-2 text-sm ${BODY} max-w-2xl`}>{d.subtitle}</p>
        </div>
        <div className="flex items-center gap-2">
          <Link href="/following" className={SECONDARY_BTN}>
            Following
          </Link>
          <Link href="/search" className={SECONDARY_BTN}>
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
            <Link href="/search" className="sp-btn-primary">
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
          />

          {activeAthlete && (
            <div className="space-y-6 sm:space-y-8">
              <AthleteHeroCard athlete={activeAthlete} />

              {activeAthlete.season ? (
                <PersonalSeasonCard season={activeAthlete.season} />
              ) : null}

              <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div className="lg:col-span-2 space-y-6">
                  <AthleteInsightGrid athlete={activeAthlete} />

                  <EquipmentInPlacePanel
                    activeAthlete={activeAthlete}
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

                  <CoachFeedbackPanel athlete={activeAthlete} />
                </div>

                <div className="space-y-6">
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

                  <PrivateNotesPanel
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
            </div>
          )}
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

      <p className={`text-center text-xs ${MUTED} pt-4`}>
        <Link href="/account" className={`${MUTED} hover:text-[var(--sp-harbour-teal)] transition-colors`}>
          Account Settings
        </Link>
        {" · "}
        <Link href="/search" className={`${MUTED} hover:text-[var(--sp-harbour-teal)] transition-colors`}>
          Find Sailors
        </Link>
        {" · "}
        <Link href="/support" className={`${MUTED} hover:text-[var(--sp-harbour-teal)] transition-colors`}>
          Support & Feedback
        </Link>
      </p>
    </div>
  );
}
