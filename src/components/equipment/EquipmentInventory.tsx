"use client";

import { Lock, Settings } from "lucide-react";
import type { EquipmentInventoryProps } from "./types";
import { useEquipmentInventory } from "./useEquipmentInventory";
import { EquipmentAlerts } from "./EquipmentAlerts";
import { EquipmentArchive } from "./EquipmentArchive";
import { EquipmentBulkBar } from "./EquipmentBulkBar";
import { EquipmentClassTabs } from "./EquipmentClassTabs";
import { EquipmentEmptyState } from "./EquipmentEmptyState";
import { EquipmentHeader } from "./EquipmentHeader";
import { EquipmentItemForm } from "./EquipmentItemForm";
import { EquipmentModalShell } from "./EquipmentModalShell";
import { EquipmentSectionList } from "./EquipmentSectionList";
import { EquipmentToast } from "./EquipmentToast";
import { BulkTagForm } from "./BulkTagForm";
import { FullRigForm } from "./FullRigForm";
import { LogSessionForm } from "./LogSessionForm";
import Link from "next/link";

export function EquipmentInventory({
  sailorId,
  isOwner,
  canSeeEquipment,
  mayHaveIlca,
  preferredBoatClass = null,
  regattaOptions = [],
  cardClass = "rounded-2xl border border-white/5 bg-[#131520]/80",
  onGearByRegatta,
}: EquipmentInventoryProps) {
  const eq = useEquipmentInventory({
    sailorId,
    mayHaveIlca,
    onGearByRegatta,
    regattaOptions,
    preferredBoatClass,
  });

  if (eq.loading) {
    return (
      <section className={`${cardClass} p-4 sm:p-5`}>
        <div className="flex items-center gap-2 mb-4">
          <div className="h-3.5 w-3.5 rounded bg-white/10 animate-pulse" />
          <div className="h-3 w-20 rounded bg-white/10 animate-pulse" />
        </div>
        <div className="space-y-2">
          <div className="h-16 rounded-xl bg-white/[0.04] animate-pulse" />
          <div className="h-16 rounded-xl bg-white/[0.04] animate-pulse" />
        </div>
      </section>
    );
  }

  if (eq.isPrivate || !canSeeEquipment) {
    return (
      <section
        id="profile-equipment"
        className={`${cardClass} p-4 sm:p-5 scroll-mt-24`}
      >
        <div className="flex items-center gap-2 mb-3">
          <Settings className="h-3.5 w-3.5 text-orange-400/90" />
          <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
            Equipment
          </h2>
        </div>
        <div className="rounded-2xl border border-dashed border-white/10 bg-black/20 py-10 px-4 text-center space-y-3">
          <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-2xl bg-orange-500/10 border border-orange-500/20">
            <Lock className="h-5 w-5 text-orange-400/90" />
          </div>
          <div className="space-y-1">
            <p className="text-sm font-bold text-white">Equipment is private</p>
            <p className="text-[11px] text-slate-500 leading-relaxed max-w-xs mx-auto">
              Gear details are only visible to the sailor and linked parents —
              not shown on the public profile.
            </p>
          </div>
          {!isOwner && (
            <Link
              href="/claim-profile"
              className="inline-flex rounded-full border border-orange-500/30 bg-orange-500/10 px-4 py-2 text-[11px] font-bold text-orange-200 hover:bg-orange-500/20"
            >
              Claim this profile to manage gear
            </Link>
          )}
        </div>
      </section>
    );
  }

  return (
    <section
      id="profile-equipment"
      className={`${cardClass} p-4 sm:p-5 space-y-4 min-w-0 overflow-x-clip relative scroll-mt-24`}
    >
      <EquipmentToast toast={eq.toast} />

      <EquipmentHeader
        activeCount={eq.activeItems.length}
        primaryCount={eq.primaryCount}
        alertCount={eq.classAlerts.length}
        isOwner={isOwner}
        canLogSession={eq.activeItems.some((i) => i.status === "active")}
        onLogSession={() => eq.openLogUse()}
        onAdd={() => eq.openQuick()}
      />

      <EquipmentClassTabs
        classTab={eq.classTab}
        showIlcaTab={eq.showIlcaTab}
        isOwner={isOwner}
        onSelectClass={eq.setClassTab}
        onUnlockIlca={eq.unlockIlca}
      />

      {isOwner && (
        <EquipmentAlerts
          alerts={eq.classAlerts}
          open={eq.alertsOpen}
          onToggleOpen={() => eq.setAlertsOpen((o) => !o)}
          onEdit={eq.openEdit}
        />
      )}

      {isOwner && (
        <EquipmentBulkBar
          selectedCount={eq.selected.size}
          busy={eq.busy}
          onLogSession={() => eq.openLogUse([...eq.selected])}
          onTag={() => eq.setModal("bulkTag")}
          onArchive={() => void eq.bulkArchive()}
          onClear={() => eq.setSelected(new Set())}
        />
      )}

      {eq.activeItems.length === 0 ? (
        <EquipmentEmptyState
          isOwner={isOwner}
          onQuickAdd={eq.openQuick}
          onOpenFullRig={eq.openFullRig}
        />
      ) : (
        <EquipmentSectionList
          sections={eq.sections}
          isOwner={isOwner}
          selected={eq.selected}
          onToggleSelect={eq.toggleSelect}
          onLogUse={(id) => eq.openLogUse([id])}
          onEdit={eq.openEdit}
          onMakePrimary={(item) => void eq.makePrimary(item)}
          onQuickAdd={eq.openQuick}
          onOpenFullRig={eq.openFullRig}
        />
      )}

      {isOwner && (
        <EquipmentArchive archived={eq.archived} onEdit={eq.openEdit} />
      )}

      {eq.modal && (
        <EquipmentModalShell
          modal={eq.modal}
          selectedCount={eq.selected.size}
          editing={eq.editing}
          msg={eq.msg}
          onClose={eq.closeModal}
        >
          {eq.modal === "bulkTag" && (
            <BulkTagForm
              bulkTag={eq.bulkTag}
              busy={eq.busy}
              onChange={eq.setBulkTag}
              onApply={() => void eq.bulkTagApply()}
            />
          )}
          {eq.modal === "fullRig" && (
            <FullRigForm
              brand={eq.fullRigBrand}
              brandCustom={eq.fullRigBrandCustom}
              busy={eq.busy}
              onBrandChange={eq.setFullRigBrand}
              onBrandCustomChange={eq.setFullRigBrandCustom}
              onSave={() => void eq.saveFullRig()}
            />
          )}
          {eq.modal === "use" && (
            <LogSessionForm
              classItems={eq.classItems}
              useItemIds={eq.useItemIds}
              useSessionType={eq.useSessionType}
              useDate={eq.useDate}
              useRegattaId={eq.useRegattaId}
              useWind={eq.useWind}
              regattaOptions={eq.regattaOptions}
              busy={eq.busy}
              onToggleItem={(id, checked) => {
                eq.setUseItemIds((prev) =>
                  checked ? [...prev, id] : prev.filter((x) => x !== id)
                );
              }}
              onSessionType={(t) => {
                eq.setUseSessionType(t);
                if (t === "training") eq.setUseRegattaId("");
              }}
              onDate={eq.setUseDate}
              onRegattaId={(id, date) => {
                eq.setUseRegattaId(id);
                if (date) eq.setUseDate(date);
              }}
              onWind={eq.setUseWind}
              onSave={() => void eq.logUses()}
            />
          )}
          {(eq.modal === "quick" ||
            eq.modal === "edit" ||
            eq.modal === "advanced") && (
            <EquipmentItemForm
              modal={eq.modal}
              form={eq.form}
              showMore={eq.showMore}
              busy={eq.busy}
              editing={Boolean(eq.editing)}
              onChange={eq.setForm}
              onToggleTag={eq.toggleTag}
              onShowMore={eq.setShowMore}
              onSave={() => void eq.saveItem()}
            />
          )}
        </EquipmentModalShell>
      )}
    </section>
  );
}
