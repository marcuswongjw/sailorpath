"use client";

import { UserPlus } from "lucide-react";
import dynamic from "next/dynamic";
import {
  type SailorRecordProps,
  type RegattaResultItem,
  type ObservationItem,
  type SailorProfileViewProps,
  HeroAthleteCard,
  ProfileClassNavigation,
  ProfileAwardsCabinet,
  ProfileOverviewTab,
  ProfileResultsTab,
  type ProfileSectionTab,
} from "@/components/sailor-profile";
import { useSailorProfileState } from "@/components/sailor-profile/useSailorProfileState";

const EquipmentInventory = dynamic(
  () =>
    import("@/components/EquipmentInventory").then((m) => m.EquipmentInventory),
  {
    ssr: false,
    loading: () => (
      <div className="h-40 w-full animate-pulse rounded-2xl bg-white/5 border border-white/5" />
    ),
  }
);

const ClaimPanel = dynamic(
  () =>
    import("@/components/sailor-profile/ClaimPanel").then((m) => m.ClaimPanel),
  { ssr: false }
);

const ProfileOwnerEditor = dynamic(
  () =>
    import("@/components/sailor-profile/ProfileOwnerEditor").then(
      (m) => m.ProfileOwnerEditor
    ),
  { ssr: false }
);

const ProfileJourneyPanel = dynamic(
  () =>
    import("@/components/sailor-profile/ProfileJourneyPanel").then(
      (m) => m.ProfileJourneyPanel
    )
);

export type {
  SailorRecordProps,
  RegattaResultItem,
  ObservationItem,
  SailorProfileViewProps,
};

export function SailorProfileView(props: SailorProfileViewProps) {
  const {
    cardClass,
    router,
    initialSailor,
    canClaim,
    isOwner,
    isLoggedIn,
    profileClaimed,
    demoMode,
    demoRole,
    onDemoClaim,
    profileVerified,
    isPublicWeight,
    setIsPublicWeight,
    isPublicDob,
    setIsPublicDob,
    claimStatus,
    setClaimStatus,
    claimMsg,
    setClaimMsg,
    claimPanelOpen,
    setClaimPanelOpen,
    editing,
    setEditing,
    previewPublic,
    setPreviewPublic,
    saveBusy,
    saveMsg,
    expandedRegattaId,
    setExpandedRegattaId,
    observations,
    setObservations,
    obsForm,
    setObsForm,
    editingObsId,
    obsBusy,
    obsMsg,
    form,
    setForm,
    displaySailor,
    results,
    personalBusy,
    personalMsg,
    avatarBusy,
    avatarMsg,
    journeyDraft,
    setJourneyDraft,
    journeyBusy,
    journeyMsg,
    showAllResults,
    setShowAllResults,
    optimistScope,
    setOptimistScope,
    resultsTab,
    setResultsTab,
    sectionTab,
    setSectionTab,
    dismissSailorTip,
    setDismissSailorTip,
    gearByRegatta,
    setGearByRegatta,
    ownerView,
    hasPrivateAccess,
    showWeight,
    showEquipment,
    saveProfile,
    uploadAvatar,
    resetObsForm,
    startEditObservation,
    saveObservation,
    addJourneyItem,
    removeJourneyItem,
    updateJourneyItem,
    deletePersonalResult,
    deleteObservation,
    leftOptimistYear,
    preferIlcaFirst,
    fleetBadge,
    analytics,
    awards,
    heroMedals,
    bornYear,
    showFullDob,
    fullDobLabel,
    optimistResults,
    ilca4Results,
    hasIlcaResults,
    dualClass,
    showOptimistScopeFilter,
    ilca4Tenure,
    activeResultsList,
    visibleResults,
    hasMoreResults,
    seriesDnsCount,
    primaryIsIlca,
    sailDisplay,
    sailIlca4,
    noc,
    activeStanding,
    standingIsIlca,
    activeBoatClass,
    showEquipmentSection,
    trendPoints,
    trendMode,
    trendGoldEntry,
    trendCaption,
    displayJourney,
    showUnclaimedBanner,
  } = useSailorProfileState(props);

  return (
    <div
      id="profile-hero"
      className="mx-auto max-w-5xl px-3 sm:px-6 py-6 sm:py-10 flex-1 w-full min-w-0 space-y-4 sm:space-y-5 bg-sailcloth text-charcoal overflow-x-clip"
    >
      {/* Claim banner — single primary CTA for unclaimed profiles (header repeats suppressed) */}
      {showUnclaimedBanner && (
        <div className="rounded-2xl border border-racing-orange/30 bg-warm-white p-4 sm:p-5 shadow-sm flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div className="min-w-0">
            <p className="text-sm font-bold text-harbour-shadow flex items-center gap-1.5">
              <span className="h-2 w-2 rounded-full bg-racing-orange" />
              Is this you? Claim your profile
            </p>
            <p className="text-[13px] text-slate-soft mt-1 leading-snug">
              Link as sailor or parent to unlock logbook, privacy controls, race notes, and equipment tracking.
            </p>
          </div>
          <button
            type="button"
            onClick={() => {
              if (demoMode) {
                onDemoClaim?.();
                return;
              }
              if (!isLoggedIn) {
                router.push(
                  `/login?next=${encodeURIComponent(
                    `/${displaySailor.handle || ""}`
                  )}`
                );
                return;
              }
              setClaimPanelOpen(true);
            }}
            className="shrink-0 sp-primary inline-flex items-center gap-1.5 px-4 py-2.5 text-xs font-bold text-white shadow-sm"
          >
            <UserPlus className="h-3.5 w-3.5" />
            Claim this profile
          </button>
        </div>
      )}

      {/* Coach squad context strip (demo) */}
      {demoMode && demoRole === "coach" && (
        <div className="rounded-2xl border border-harbour/25 bg-aqua-mist/50 px-4 py-3 flex flex-wrap items-center gap-x-4 gap-y-1.5 text-xs text-charcoal shadow-xs">
          <span className="font-bold text-harbour">Squad context</span>
          <span className="text-slate-soft">
            Avg. finish:{" "}
            <span className="font-semibold text-charcoal">3.6</span>
            <span className="text-slate-soft"> · Squad avg: 5.2</span>
          </span>
          <span className="text-slate-soft">
            <span className="font-semibold text-charcoal">#3</span> of 100 nationally
            <span className="text-slate-soft"> · </span>
            <span className="font-semibold text-harbour">#1 of 12</span> in squad
          </span>
        </div>
      )}

      {/* ── Hero Athlete Card ─────────────────────────────────── */}
      <HeroAthleteCard
        displaySailor={displaySailor}
        fleetBadge={fleetBadge}
        activeStanding={activeStanding}
        standingIsIlca={standingIsIlca}
        dualClass={dualClass}
        selectedBoatClass={activeBoatClass}
        preferIlcaFirst={preferIlcaFirst}
        optimistCount={optimistResults.length}
        ilcaCount={ilca4Results.length}
        onSelectBoatClass={(cls) => {
          setResultsTab(cls);
          setShowAllResults(false);
        }}
        onViewAwards={() => setSectionTab("awards")}
        medals={heroMedals}
        profileClaimed={profileClaimed}
        profileVerified={profileVerified}
        showUnclaimedBanner={showUnclaimedBanner}
        canClaim={canClaim}
        claimStatus={claimStatus}
        claimMsg={claimMsg}
        claimPanelOpen={claimPanelOpen}
        onToggleClaimPanel={() => setClaimPanelOpen((o) => !o)}
        onDemoClaim={onDemoClaim}
        demoMode={demoMode}
        isLoggedIn={isLoggedIn}
        isOwner={isOwner}
        ownerView={ownerView}
        previewPublic={previewPublic}
        onTogglePreviewPublic={() => {
          setPreviewPublic((p) => {
            const next = !p;
            if (next) {
              setEditing(false);
              setExpandedRegattaId(null);
            }
            return next;
          });
        }}
        editing={editing}
        onToggleEditing={() => setEditing((e) => !e)}
        avatarBusy={avatarBusy}
        avatarMsg={avatarMsg}
        onUploadAvatar={(f) => void uploadAvatar(f)}
        showWeight={showWeight}
        bornYear={bornYear}
        fullDobLabel={fullDobLabel}
        showFullDob={showFullDob}
        leftOptimistYear={leftOptimistYear}
        sailDisplay={sailDisplay}
        sailIlca4={sailIlca4}
        noc={noc}
        totalRegattasCount={results.length}
        followControl={isLoggedIn ? props.followControl : null}
      />

      {/* Claim panel */}
      {claimPanelOpen && canClaim && !demoMode && claimStatus !== "pending" && (
        <ClaimPanel
          sailorId={initialSailor.id}
          sailorName={displaySailor.name}
          sailNumber={displaySailor.sailNumber}
          onClose={() => setClaimPanelOpen(false)}
          onResult={(status, msg) => {
            setClaimStatus(status);
            setClaimMsg(msg);
          }}
        />
      )}

      {/* Owner editor */}
      {ownerView && editing && (
        <ProfileOwnerEditor
          form={form}
          setForm={setForm}
          isPublicWeight={isPublicWeight}
          setIsPublicWeight={setIsPublicWeight}
          isPublicDob={isPublicDob}
          setIsPublicDob={setIsPublicDob}
          saveBusy={saveBusy}
          saveMsg={saveMsg}
          onSave={() => void saveProfile()}
        />
      )}

      <ProfileClassNavigation
        dualClass={dualClass}
        preferIlcaFirst={preferIlcaFirst}
        activeTab={resultsTab}
        sectionTab={sectionTab}
        optimistCount={optimistResults.length}
        ilcaCount={ilca4Results.length}
        journeyCount={displayJourney.length}
        awardsCount={awards.length}
        showStanding={Boolean(activeStanding)}
        showEquipment={showEquipmentSection || !isOwner}
        showMilestones={displayJourney.length > 0 || ownerView}
        onTabChange={(tab) => {
          setResultsTab(tab);
          if (tab === "journey") {
            setSectionTab("journey");
          }
          setShowAllResults(false);
        }}
        onSectionTabChange={(tab) => {
          setSectionTab(tab);
        }}
      />

      {/* ── OVERVIEW TAB ────────────────────────────────────────── */}
      {sectionTab === "overview" && (
        <ProfileOverviewTab
          activeStanding={activeStanding ?? null}
          standingIsIlca={standingIsIlca}
          seriesDnsCount={seriesDnsCount}
          cardClass={cardClass}
          resultsTab={resultsTab}
          trendPoints={trendPoints}
          trendMode={trendMode}
          trendGoldEntry={trendGoldEntry}
          trendCaption={trendCaption}
          activeResultsList={activeResultsList}
          primaryIsIlca={primaryIsIlca}
          onNavigateTab={(tab) => setSectionTab(tab as ProfileSectionTab)}
        />
      )}

      {/* ── REGATTAS TAB ────────────────────────────────────────── */}
      {sectionTab === "results" && (
        <ProfileResultsTab
          cardClass={cardClass}
          resultsTab={resultsTab}
          dualClass={dualClass}
          activeResultsList={activeResultsList}
          visibleResults={visibleResults}
          hasMoreResults={hasMoreResults}
          showAllResults={showAllResults}
          onShowAllToggle={() => setShowAllResults((v) => !v)}
          optimistScope={optimistScope}
          showOptimistScopeFilter={showOptimistScopeFilter}
          onOptimistScopeChange={(scope) => {
            setOptimistScope(scope);
            setShowAllResults(false);
          }}
          ilca4Tenure={ilca4Tenure}
          primaryIsIlca={primaryIsIlca}
          ownerView={ownerView}
          dismissSailorTip={dismissSailorTip}
          onDismissSailorTip={() => setDismissSailorTip(true)}
          demoMode={demoMode}
          demoRole={demoRole}
          sailorId={initialSailor.id}
          awards={awards}
          showEquipment={showEquipment}
          gearByRegatta={gearByRegatta}
          goldEntryDate={analytics.goldEntryDate}
          personalBusy={personalBusy}
          personalMsg={personalMsg}
          hasPrivateAccess={hasPrivateAccess}
          observations={observations}
          obsForm={obsForm}
          editingObsId={editingObsId}
          obsBusy={obsBusy}
          obsMsg={obsMsg}
          expandedRegattaId={expandedRegattaId}
          onToggleExpand={(id) => setExpandedRegattaId(expandedRegattaId === id ? null : id)}
          onDeleteResult={(r) => void deletePersonalResult(r)}
          setExpandedRegattaId={setExpandedRegattaId}
          onObsFormChange={(f) => setObsForm(f)}
          onObsSave={(id) => void saveObservation(id)}
          onObsCancel={resetObsForm}
          onObsDelete={(o) => void deleteObservation(o)}
          onObsEdit={(o, id) => startEditObservation(o, id)}
          onObsDemoDelete={(regattaId, raceNumber) =>
            setObservations((prev) =>
              prev.filter(
                (x) =>
                  !(
                    x.regattaId === regattaId &&
                    Number(x.raceNumber) === raceNumber
                  )
              )
            )
          }
          displayJourney={displayJourney}
          journeyDraft={journeyDraft}
          setJourneyDraft={setJourneyDraft}
          journeyBusy={journeyBusy}
          journeyMsg={journeyMsg}
          onAddJourney={() => void addJourneyItem()}
          onUpdateJourney={(id, updated, isSystem) =>
            void updateJourneyItem(id, updated, isSystem)
          }
          onRemoveJourney={(id, isSystem) => void removeJourneyItem(id, isSystem)}
        />
      )}

      {/* ── AWARDS TAB ─────────────────────────────────────────── */}
      {sectionTab === "awards" && (
        <div id="profile-awards-tab" className="scroll-mt-28">
          <ProfileAwardsCabinet
            awards={awards}
            sailorName={displaySailor.name}
            isOwner={ownerView}
          />
        </div>
      )}

      {/* ── MILESTONES TAB ──────────────────────────────────────── */}
      {sectionTab === "journey" && (
        <div id="profile-journey" className="scroll-mt-28">
          <ProfileJourneyPanel
            variant="tab"
            items={displayJourney}
            isOwner={ownerView}
            draft={journeyDraft}
            setDraft={setJourneyDraft}
            busy={journeyBusy}
            message={journeyMsg}
            onAdd={() => void addJourneyItem()}
            onUpdate={(id, updated, isSystem) =>
              void updateJourneyItem(id, updated, isSystem)
            }
            onRemove={(id, isSystem) => void removeJourneyItem(id, isSystem)}
          />
        </div>
      )}

      {/* ── EQUIPMENT TAB ───────────────────────────────────────── */}
      {sectionTab === "equipment" && (
        <div id="profile-equipment" className="scroll-mt-28">
          {showEquipmentSection ? (
            <EquipmentInventory
              sailorId={initialSailor.id}
              isOwner={ownerView}
              canSeeEquipment={showEquipment}
              mayHaveIlca={Boolean(
                hasIlcaResults ||
                  displaySailor.sailNumberIlca4 ||
                  displaySailor.ilca4NationalList
              )}
              preferredBoatClass={
                resultsTab === "ilca4"
                  ? "ilca4"
                  : resultsTab === "optimist"
                    ? "optimist"
                    : null
              }
              regattaOptions={(results || [])
                .filter((r) => r.regattaId)
                .map((r) => ({
                  id: String(r.regattaId),
                  name: String(r.regattaName || "Regatta"),
                  date: String(r.regattaDate || "").slice(0, 10),
                }))
                .filter(
                  (r, i, arr) => arr.findIndex((x) => x.id === r.id) === i
                )
                .slice(0, 40)}
              cardClass={cardClass}
              onGearByRegatta={setGearByRegatta}
            />
          ) : (
            <section
              id="profile-equipment-private"
              className={`${cardClass} p-4 sm:p-5`}
            >
              <h2 className="text-[12px] font-medium uppercase tracking-[0.14em] text-neutral-500">
                Equipment
              </h2>
              <p className="mt-2 text-[13px] text-neutral-400 leading-relaxed">
                Gear is private to the sailor and their linked family — not shown
                on public profiles.
                {showUnclaimedBanner
                  ? " Claim this profile to add hull, sail, and foils."
                  : ""}
              </p>
            </section>
          )}
        </div>
      )}

      {/* Privacy controls live under Edit profile only (not on Optimist/ILCA/Journey tabs). */}
    </div>
  );
}
