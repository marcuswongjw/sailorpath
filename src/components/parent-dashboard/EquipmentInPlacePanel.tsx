"use client";

import {
  Plus,
  Sailboat,
  AlertTriangle,
  Star,
  Trash2,
  X,
} from "lucide-react";
import { useModalDialog } from "@/components/ui/useModalDialog";
import {
  YOUTH_EQUIPMENT_PRESETS,
  SIMPLIFIED_CONDITION_META,
  toSimplifiedCondition,
  brandsForCategory,
  categoryLabel,
  type QuickEquipmentPreset,
  type EquipmentCategory,
  type SimplifiedCondition,
} from "@/lib/equipment";
import {
  CARD,
  NESTED,
  PRIMARY_BTN,
  SECTION_KICKER,
  SECTION_TITLE,
  MUTED,
  BODY,
  INK,
  formatSgFleetLabel,
} from "./styles";

type GearItem = {
  id: string;
  category: string;
  brand: string | null;
  model: string | null;
  label: string | null;
  condition: string;
  status: string;
  isPrimary: boolean;
};

export type EquipmentInPlacePanelProps = {
  activeAthlete: {
    id: string;
    name: string;
    currentFleet?: string | null;
    handle: string;
    equipmentAlertCount?: number;
    equipmentAlerts?: { label: string; reason: string }[];
    primaryGear?: GearItem[];
  };
  demoMode?: boolean;
  showAddGearModal: boolean;
  addGearTab: "presets" | "custom";
  addGearBusy: boolean;
  customGearCategory: EquipmentCategory;
  customGearBrand: string;
  customGearModel: string;
  customGearLabel: string;
  customGearCondition: SimplifiedCondition;
  customGearPrimary: boolean;
  onOpenAddGear: () => void;
  onCloseAddGear: () => void;
  onSetAddGearTab: (tab: "presets" | "custom") => void;
  onSetCustomCategory: (cat: EquipmentCategory) => void;
  onSetCustomBrand: (val: string) => void;
  onSetCustomModel: (val: string) => void;
  onSetCustomLabel: (val: string) => void;
  onSetCustomCondition: (val: SimplifiedCondition) => void;
  onSetCustomPrimary: (val: boolean) => void;
  onToggleCondition: (gearId: string, currentCondition: string) => void;
  onTogglePrimary: (gearId: string, currentPrimary: boolean) => void;
  onDeleteGear: (gearId: string) => void;
  onAddGearPreset: (preset: QuickEquipmentPreset) => void;
  onCreateCustomGear: () => void;
};

export function EquipmentInPlacePanel({
  activeAthlete,
  showAddGearModal,
  addGearTab,
  addGearBusy,
  customGearCategory,
  customGearBrand,
  customGearModel,
  customGearLabel,
  customGearCondition,
  customGearPrimary,
  onOpenAddGear,
  onCloseAddGear,
  onSetAddGearTab,
  onSetCustomCategory,
  onSetCustomBrand,
  onSetCustomModel,
  onSetCustomLabel,
  onSetCustomCondition,
  onSetCustomPrimary,
  onToggleCondition,
  onTogglePrimary,
  onDeleteGear,
  onAddGearPreset,
  onCreateCustomGear,
}: EquipmentInPlacePanelProps) {
  const dialogRef = useModalDialog(showAddGearModal, onCloseAddGear);
  const gearItems = activeAthlete.primaryGear ?? [];
  const fleetSubtitle = formatSgFleetLabel(activeAthlete.currentFleet);

  return (
    <>
      <section className={`${CARD} p-5 space-y-4`}>
        <div className="flex items-center justify-between gap-3 flex-wrap">
          <div>
            <p className={SECTION_KICKER}>Boat locker</p>
            <h3 className={`${SECTION_TITLE} flex items-center gap-2`}>
              <Sailboat className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
              Boat Locker
              {gearItems.length > 0 && (
                <span className={`text-xs font-semibold ${MUTED}`}>
                  ({gearItems.length})
                </span>
              )}
            </h3>
          </div>
          <button
            type="button"
            onClick={onOpenAddGear}
            className={`${PRIMARY_BTN} min-h-10 px-3.5 py-2 text-xs`}
          >
            <Plus className="h-3.5 w-3.5" />
            Add Equipment
          </button>
        </div>

        {(activeAthlete.equipmentAlertCount ?? 0) > 0 && (
          <div className="rounded-xl border border-rose-200 bg-rose-50 px-3.5 py-2.5 space-y-1">
            <p className="text-xs font-bold text-[var(--sp-color-error)] flex items-center gap-1.5">
              <AlertTriangle className="h-3.5 w-3.5 shrink-0" />
              {activeAthlete.equipmentAlertCount} Equipment Alert
              {activeAthlete.equipmentAlertCount === 1 ? "" : "s"}
            </p>
            {(activeAthlete.equipmentAlerts || []).map((al, idx) => (
              <p key={idx} className="text-xs text-[var(--sp-color-error)] pl-5">
                <span className="font-bold">{al.label}:</span> {al.reason}
              </p>
            ))}
          </div>
        )}

        {gearItems.length > 0 ? (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5">
            {[...gearItems]
              .sort((a, b) => {
                const rank = (cond: string) => {
                  const s = toSimplifiedCondition(cond);
                  return s === "needs_attention" ? 0 : s === "practice_only" ? 1 : 2;
                };
                return rank(a.condition) - rank(b.condition);
              })
              .map((g) => {
                const brandModel = [g.brand, g.model].filter(Boolean).join(" ");
                const title = g.label || brandModel || "Equipment Item";
                const subtitle = g.label && brandModel && g.label !== brandModel ? brandModel : null;
                const simplified = toSimplifiedCondition(g.condition);

                return (
                  <div
                    key={g.id}
                    className={`${NESTED} p-3 flex flex-col justify-between gap-2.5 hover:border-[var(--sp-harbour-teal)] transition`}
                  >
                    <div className="flex items-start justify-between gap-2">
                      <div className="min-w-0 flex-1">
                        <span className={`text-[10px] font-black uppercase tracking-wider ${MUTED}`}>
                          {categoryLabel(g.category as EquipmentCategory)}
                        </span>
                        <p className={`text-sm font-bold ${INK} mt-0.5 truncate`}>
                          {title}
                        </p>
                        {subtitle && (
                          <p className={`text-xs ${MUTED} truncate`}>{subtitle}</p>
                        )}
                      </div>
                      <div className="flex items-center gap-0.5 shrink-0">
                        <button
                          type="button"
                          title={g.isPrimary ? "Primary race gear (click to unset)" : "Set as primary race gear"}
                          onClick={() => onTogglePrimary(g.id, g.isPrimary)}
                          className={`min-h-8 px-2 rounded-full text-[10px] font-bold inline-flex items-center gap-1 transition ${
                            g.isPrimary
                              ? "text-[var(--sp-racing-deep)] bg-[var(--sp-racing-mist)]/60 border border-[var(--sp-racing-orange)]/25"
                              : `${MUTED} hover:text-[var(--sp-racing-orange)] hover:bg-[var(--sp-warm-white)]`
                          }`}
                        >
                          <Star className={`h-3 w-3 ${g.isPrimary ? "fill-[var(--sp-racing-orange)] text-[var(--sp-racing-orange)]" : ""}`} />
                          {g.isPrimary ? "Primary" : ""}
                        </button>
                        <button
                          type="button"
                          title="Remove gear from locker"
                          aria-label={`Remove ${title}`}
                          onClick={() => onDeleteGear(g.id)}
                          className={`inline-flex h-8 w-8 items-center justify-center rounded-lg ${MUTED} hover:text-rose-600 hover:bg-rose-50 transition`}
                        >
                          <Trash2 className="h-3.5 w-3.5" />
                        </button>
                      </div>
                    </div>

                    <div className="pt-1.5 border-t border-[var(--sp-cool-veil)]">
                      <button
                        type="button"
                        onClick={() => onToggleCondition(g.id, g.condition)}
                        title="Click to cycle condition: Race Ready, Practice Only, Needs Repair"
                        className={`text-[11px] font-bold px-2.5 py-1 rounded-full border transition inline-flex items-center gap-1.5 touch-manipulation ${
                          simplified === "race_ready"
                            ? "bg-[var(--sp-aqua-mist)] border-[var(--sp-harbour-teal)]/30 text-[var(--sp-harbour-teal)]"
                            : simplified === "practice_only"
                            ? "bg-[var(--sp-racing-mist)]/50 border-[var(--sp-racing-orange)]/30 text-[var(--sp-racing-deep)]"
                            : "bg-rose-50 border-rose-200 text-rose-700"
                        }`}
                      >
                        <span className="h-1.5 w-1.5 rounded-full bg-current opacity-80" />
                        {simplified === "race_ready"
                          ? "Race Ready"
                          : simplified === "practice_only"
                          ? "Practice Only"
                          : "Needs Repair"}
                      </button>
                    </div>
                  </div>
                );
              })}
          </div>
        ) : (
          <div className="rounded-xl border border-dashed border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-5 text-center space-y-2.5">
            <Sailboat className={`h-6 w-6 ${MUTED} mx-auto`} />
            <p className={`text-xs font-bold ${INK}`}>No equipment logged yet</p>
            <p className={`text-xs ${MUTED} max-w-xs mx-auto`}>
              Track hull, sails, spars, and foils to spot worn gear before regattas.
            </p>
            <div className="pt-1">
              <button
                type="button"
                onClick={onOpenAddGear}
                className={PRIMARY_BTN}
              >
                <Plus className="h-3.5 w-3.5" />
                Add Equipment
              </button>
            </div>
          </div>
        )}
      </section>

      {showAddGearModal && (
        <dialog
          ref={dialogRef}
          aria-labelledby="add-gear-title"
          {...({ closedby: "any" } as Record<string, string>)}
          className="m-auto w-[calc(100%-1.5rem)] max-w-lg max-h-[92dvh] flex flex-col overflow-hidden rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-0 shadow-2xl"
        >
          <div className="flex items-center justify-between px-5 py-4 border-b border-[var(--sp-cool-veil)] shrink-0">
            <div>
              <h3 id="add-gear-title" className={`text-sm font-bold ${INK} flex items-center gap-1.5`}>
                <Plus className="h-4 w-4 text-[var(--sp-racing-orange)]" />
                Add Equipment to Locker
              </h3>
              <p className={`text-xs ${MUTED}`}>
                For {activeAthlete.name}
                {fleetSubtitle ? ` (${fleetSubtitle})` : ""}
              </p>
            </div>
            <button
              type="button"
              onClick={onCloseAddGear}
              aria-label="Close add equipment"
              className={`inline-flex h-10 w-10 items-center justify-center rounded-lg ${MUTED} hover:text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)] transition`}
            >
              <X className="h-4 w-4" />
            </button>
          </div>

          <div className="flex-1 overflow-y-auto p-5 sm:p-6 space-y-4">
            <div className={`flex rounded-xl ${NESTED} p-1`}>
              <button
                type="button"
                onClick={() => onSetAddGearTab("presets")}
                className={`min-h-10 flex-1 py-1.5 text-xs font-bold rounded-lg transition ${
                  addGearTab === "presets"
                    ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                    : `${MUTED} hover:text-[var(--sp-harbour-shadow)]`
                }`}
              >
                1-Click Popular Presets
              </button>
              <button
                type="button"
                onClick={() => onSetAddGearTab("custom")}
                className={`min-h-10 flex-1 py-1.5 text-xs font-bold rounded-lg transition ${
                  addGearTab === "custom"
                    ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                    : `${MUTED} hover:text-[var(--sp-harbour-shadow)]`
                }`}
              >
                Custom Gear
              </button>
            </div>

            {addGearTab === "presets" ? (
              <div className="space-y-2">
                <p className={`text-[13px] ${MUTED}`}>
                  Select standard youth equipment packages to add immediately:
                </p>
                <div className="grid grid-cols-1 gap-2">
                  {YOUTH_EQUIPMENT_PRESETS.map((preset) => (
                    <div
                      key={preset.id}
                      className={`${NESTED} p-3 flex items-center justify-between gap-3 hover:border-[var(--sp-racing-orange)]/40 transition`}
                    >
                      <div className="min-w-0 flex-1">
                        <div className="flex items-center gap-2">
                          <span className={`text-xs font-bold ${INK}`}>
                            {preset.name}
                          </span>
                          <span className={`text-[9px] font-bold uppercase tracking-wider px-1.5 py-0.5 rounded-full bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] ${MUTED}`}>
                            {preset.category}
                          </span>
                        </div>
                        <p className={`text-[13px] ${MUTED} mt-0.5 leading-snug`}>
                          {preset.subtitle}
                        </p>
                      </div>
                      <button
                        type="button"
                        disabled={addGearBusy}
                        onClick={() => onAddGearPreset(preset)}
                        className="shrink-0 sp-btn-primary min-h-10 px-3 py-1.5 disabled:opacity-50"
                      >
                        {addGearBusy ? "Adding…" : "+ Add"}
                      </button>
                    </div>
                  ))}
                </div>
              </div>
            ) : (
              <div className="space-y-3">
                <div>
                  <label className={`text-[11px] font-bold ${BODY} block mb-1`}>
                    Equipment Category
                  </label>
                  <select
                    value={customGearCategory}
                    onChange={(e) => {
                      const cat = e.target.value as EquipmentCategory;
                      onSetCustomCategory(cat);
                      const presets = brandsForCategory(cat);
                      onSetCustomBrand(presets[0] || "");
                    }}
                    className="sp-select w-full min-h-11 text-base sm:text-sm"
                  >
                    {(
                      [
                        "hull",
                        "sail",
                        "mast",
                        "boom",
                        "sprit",
                        "daggerboard",
                        "rudder",
                        "other",
                      ] as EquipmentCategory[]
                    ).map((cat) => (
                      <option key={cat} value={cat}>
                        {categoryLabel(cat)}
                      </option>
                    ))}
                  </select>
                </div>

                <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5">
                  <div>
                    <label className={`text-[11px] font-bold ${BODY} block mb-1`}>
                      Brand / Maker
                    </label>
                    <input
                      value={customGearBrand}
                      onChange={(e) => onSetCustomBrand(e.target.value)}
                      placeholder="e.g. Winner, OneSails, Optimax"
                      className="sp-input w-full min-h-11 text-base sm:text-sm"
                    />
                  </div>
                  <div>
                    <label className={`text-[11px] font-bold ${BODY} block mb-1`}>
                      Model / Cut
                    </label>
                    <input
                      value={customGearModel}
                      onChange={(e) => onSetCustomModel(e.target.value)}
                      placeholder="e.g. CD Cut, Mk3 Flex"
                      className="sp-input w-full min-h-11 text-base sm:text-sm"
                    />
                  </div>
                </div>

                <div>
                  <label className={`text-[11px] font-bold ${BODY} block mb-1`}>
                    Sail # / Serial / Identifier
                  </label>
                  <input
                    value={customGearLabel}
                    onChange={(e) => onSetCustomLabel(e.target.value)}
                    placeholder="e.g. SIN 4639 or Hull #184491"
                    className="sp-input w-full min-h-11 text-base sm:text-sm"
                  />
                </div>

                <div>
                  <label className={`text-[11px] font-bold ${BODY} block mb-1.5`}>
                    Condition
                  </label>
                  <div className="grid grid-cols-3 gap-1.5">
                    {(["race_ready", "practice_only", "needs_attention"] as SimplifiedCondition[]).map(
                      (key) => {
                        const meta = SIMPLIFIED_CONDITION_META[key];
                        const active = customGearCondition === key;
                        const lightActive =
                          key === "race_ready"
                            ? "bg-[var(--sp-aqua-mist)] border-[var(--sp-harbour-teal)]/40 text-[var(--sp-harbour-teal)]"
                            : key === "practice_only"
                            ? "bg-[var(--sp-racing-mist)]/50 border-[var(--sp-racing-orange)]/40 text-[var(--sp-racing-deep)]"
                            : "bg-rose-50 border-rose-200 text-rose-700";
                        return (
                          <button
                            key={key}
                            type="button"
                            onClick={() => onSetCustomCondition(key)}
                            className={`min-h-11 rounded-xl px-2 py-2 text-center border transition flex flex-col items-center justify-center gap-1 ${
                              active
                                ? lightActive
                                : `${NESTED} ${MUTED} hover:border-[var(--sp-harbour-teal)]`
                            }`}
                          >
                            <span className={`h-2 w-2 rounded-full ${
                              key === "race_ready"
                                ? "bg-[var(--sp-harbour-teal)]"
                                : key === "practice_only"
                                ? "bg-[var(--sp-racing-orange)]"
                                : "bg-rose-600"
                            }`} />
                            <span className="text-[11px] font-bold leading-tight">
                              {meta.shortLabel}
                            </span>
                          </button>
                        );
                      }
                    )}
                  </div>
                </div>

                <label className={`min-h-11 flex items-center gap-2.5 text-xs ${BODY} ${NESTED} px-3 py-2 cursor-pointer`}>
                  <input
                    type="checkbox"
                    checked={customGearPrimary}
                    onChange={(e) => onSetCustomPrimary(e.target.checked)}
                    className="h-4 w-4 rounded border-[var(--sp-cool-veil)] accent-[var(--sp-racing-orange)]"
                  />
                  <span className={`font-semibold ${INK}`}>Set as Primary Race-Day Gear</span>
                </label>

                <button
                  type="button"
                  disabled={addGearBusy}
                  onClick={onCreateCustomGear}
                  className="w-full min-h-11 sp-btn-primary py-2.5 disabled:opacity-50"
                >
                  {addGearBusy ? "Saving…" : "Save to Equipment Locker"}
                </button>
              </div>
            )}
          </div>
        </dialog>
      )}
    </>
  );
}
