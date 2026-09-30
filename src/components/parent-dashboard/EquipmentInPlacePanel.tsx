"use client";

import Link from "next/link";
import {
  Plus,
  Sailboat,
  AlertTriangle,
  Star,
  Trash2,
  X,
} from "lucide-react";
import {
  YOUTH_EQUIPMENT_PRESETS,
  SIMPLIFIED_CONDITION_META,
  toSimplifiedCondition,
  fromSimplifiedCondition,
  brandsForCategory,
  categoryLabel,
  type QuickEquipmentPreset,
  type EquipmentCategory,
  type SimplifiedCondition,
} from "@/lib/equipment";

const CARD =
  "rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs";
const NESTED =
  "rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]";
const SECONDARY_BTN =
  "inline-flex items-center justify-center gap-1.5 rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-4 py-2 text-xs font-bold text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)] transition-colors";
const PRIMARY_BTN = "sp-btn-primary";
const SECTION_KICKER =
  "text-[11px] font-bold uppercase tracking-[0.16em] text-[var(--sp-racing-orange)]";
const SECTION_TITLE =
  "mt-1 text-base font-black text-[var(--sp-harbour-shadow)]";
const MUTED = "text-[var(--sp-slate-soft)]";
const BODY = "text-[var(--sp-charcoal-slate)]";
const INK = "text-[var(--sp-harbour-shadow)]";

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
  return (
    <>
      <section className={`${CARD} p-5 sm:p-6 space-y-4`}>
        <div className="flex items-start justify-between gap-3 flex-wrap">
          <div>
            <p className={SECTION_KICKER}>Boat locker</p>
            <h3 className={`${SECTION_TITLE} flex items-center gap-2`}>
              <Sailboat className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
              Boat Locker & Equipment
            </h3>
            <p className={`text-xs ${MUTED} mt-0.5`}>
              Track hull condition, sails, spars, measurement certificates, and race-day gear.
            </p>
          </div>
          <div className="flex items-center gap-2">
            <button
              type="button"
              onClick={onOpenAddGear}
              className={PRIMARY_BTN}
            >
              <Plus className="h-3.5 w-3.5" />
              Add Equipment
            </button>
            <Link
              href={`/${activeAthlete.handle}#profile-equipment`}
              className={`${SECONDARY_BTN} px-2.5 py-1.5 text-[11px]`}
            >
              Full Profile →
            </Link>
          </div>
        </div>

        {(activeAthlete.equipmentAlertCount ?? 0) > 0 && (
          <div className="rounded-xl border border-rose-200 bg-rose-50 p-3.5 space-y-2">
            <p className="text-xs font-bold text-[var(--sp-color-error)] flex items-center gap-1.5">
              <AlertTriangle className="h-4 w-4 shrink-0" />
              {activeAthlete.equipmentAlertCount} Equipment Alert
              {activeAthlete.equipmentAlertCount === 1 ? "" : "s"} Require Action
            </p>
            <div className="space-y-1 pl-5">
              {(activeAthlete.equipmentAlerts || []).map((al, idx) => (
                <p key={idx} className="text-xs text-[var(--sp-color-error)]">
                  <span className="font-bold">{al.label}:</span> {al.reason}
                </p>
              ))}
            </div>
          </div>
        )}

        {activeAthlete.primaryGear && activeAthlete.primaryGear.length > 0 ? (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-2.5">
            {activeAthlete.primaryGear.map((g) => (
              <div
                key={g.id}
                className={`${NESTED} p-3 flex flex-col justify-between gap-2.5 hover:border-[var(--sp-harbour-teal)] transition group`}
              >
                <div className="flex items-start justify-between gap-1.5">
                  <div className="min-w-0 flex-1">
                    <div className="flex items-center gap-1.5">
                      <span className={`text-[11px] font-black uppercase tracking-wider ${MUTED}`}>
                        {g.category}
                      </span>
                      {g.isPrimary && (
                        <span className="text-[9px] font-bold text-[var(--sp-racing-orange)] bg-[var(--sp-racing-mist)]/50 border border-[var(--sp-racing-orange)]/25 px-1.5 py-0.5 rounded-full">
                          Primary
                        </span>
                      )}
                    </div>
                    <p className={`text-xs font-bold ${INK} mt-0.5 truncate`}>
                      {g.label || [g.brand, g.model].filter(Boolean).join(" ") || "Equipment Item"}
                    </p>
                  </div>
                  <div className="flex items-center gap-1 shrink-0">
                    <button
                      type="button"
                      title={g.isPrimary ? "Primary race gear (click to unset)" : "Make primary race gear"}
                      onClick={() => onTogglePrimary(g.id, g.isPrimary)}
                      className={`p-1 rounded-lg hover:bg-[var(--sp-warm-white)] transition ${
                        g.isPrimary ? "text-[var(--sp-racing-orange)]" : `${MUTED} hover:text-[var(--sp-racing-orange)]`
                      }`}
                    >
                      <Star className={`h-3.5 w-3.5 ${g.isPrimary ? "fill-[var(--sp-racing-orange)]" : ""}`} />
                    </button>
                    <button
                      type="button"
                      title="Remove gear from locker"
                      onClick={() => onDeleteGear(g.id)}
                      className={`p-1 rounded-lg ${MUTED} hover:text-rose-600 hover:bg-rose-50 transition`}
                    >
                      <Trash2 className="h-3.5 w-3.5" />
                    </button>
                  </div>
                </div>

                <div className="flex items-center justify-between pt-1.5 border-t border-[var(--sp-cool-veil)]">
                  {(() => {
                    const simplified = toSimplifiedCondition(g.condition);
                    return (
                      <button
                        type="button"
                        onClick={() => onToggleCondition(g.id, g.condition)}
                        title="Click to toggle condition (Race Ready / Practice Only / Needs Repair)"
                        className={`text-[10px] font-bold capitalize px-2 py-0.5 rounded-full border transition flex items-center gap-1 touch-manipulation ${
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
                    );
                  })()}
                  <span className={`text-[13px] ${MUTED} font-medium`}>
                    Tap to toggle
                  </span>
                </div>
              </div>
            ))}
          </div>
        ) : (
          <div className="rounded-xl border border-dashed border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-6 text-center space-y-3">
            <div className="mx-auto flex h-10 w-10 items-center justify-center rounded-xl bg-[var(--sp-racing-mist)]/50 border border-[var(--sp-racing-orange)]/20">
              <Sailboat className="h-5 w-5 text-[var(--sp-racing-orange)]" />
            </div>
            <div className="space-y-1">
              <p className={`text-xs font-bold ${INK}`}>No equipment registered yet</p>
              <p className={`text-[13px] ${MUTED} max-w-sm mx-auto`}>
                Add your sailor&apos;s hull, spars, sails, and foils to track safety checks, condition, and race-day readiness.
              </p>
            </div>
            <div className="flex flex-wrap justify-center gap-2 pt-1">
              <button
                type="button"
                onClick={onOpenAddGear}
                className={PRIMARY_BTN}
              >
                <Plus className="h-3.5 w-3.5" />
                Add Equipment
              </button>
              <button
                type="button"
                onClick={() => onAddGearPreset(YOUTH_EQUIPMENT_PRESETS[0])}
                className={SECONDARY_BTN}
              >
                + Optimax Rig Set
              </button>
              <button
                type="button"
                onClick={() => onAddGearPreset(YOUTH_EQUIPMENT_PRESETS[6])}
                className={SECONDARY_BTN}
              >
                + OneSails Racing Sail
              </button>
            </div>
          </div>
        )}
      </section>

      {showAddGearModal && (
        <div
          className="fixed inset-0 z-50 flex items-start justify-center overflow-y-auto bg-black/60 backdrop-blur-xs p-4 sm:pt-20"
          role="dialog"
          aria-modal="true"
          aria-labelledby="add-gear-title"
          onMouseDown={(event) => {
            if (event.target === event.currentTarget) onCloseAddGear();
          }}
        >
          <div className="w-full max-w-lg rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-4 shadow-2xl relative my-8">
            <div className="flex items-center justify-between pb-2 border-b border-[var(--sp-cool-veil)]">
              <div>
                <h3 id="add-gear-title" className={`text-sm font-bold ${INK} flex items-center gap-1.5`}>
                  <Plus className="h-4 w-4 text-[var(--sp-racing-orange)]" />
                  Add Equipment to Locker
                </h3>
                <p className={`text-xs ${MUTED}`}>
                  For {activeAthlete.name} ({activeAthlete.currentFleet || "Optimist"} Fleet)
                </p>
              </div>
              <button
                type="button"
                onClick={onCloseAddGear}
                aria-label="Close add equipment"
                className={`rounded-lg p-1.5 ${MUTED} hover:text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)] transition`}
              >
                <X className="h-4 w-4" />
              </button>
            </div>

            <div className={`flex rounded-xl ${NESTED} p-1`}>
              <button
                type="button"
                onClick={() => onSetAddGearTab("presets")}
                className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition ${
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
                className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition ${
                  addGearTab === "custom"
                    ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                    : `${MUTED} hover:text-[var(--sp-harbour-shadow)]`
                }`}
              >
                Custom Gear
              </button>
            </div>

            {addGearTab === "presets" ? (
              <div className="space-y-2 max-h-80 overflow-y-auto pr-1">
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
                        className="shrink-0 sp-btn-primary px-3 py-1.5 disabled:opacity-50"
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
                    className="sp-select w-full text-xs"
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

                <div className="grid grid-cols-2 gap-2">
                  <div>
                    <label className={`text-[11px] font-bold ${BODY} block mb-1`}>
                      Brand / Maker
                    </label>
                    <input
                      value={customGearBrand}
                      onChange={(e) => onSetCustomBrand(e.target.value)}
                      placeholder="e.g. Winner, OneSails, Optimax"
                      className="sp-input w-full text-xs"
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
                      className="sp-input w-full text-xs"
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
                    className="sp-input w-full text-xs"
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
                            className={`rounded-xl px-2 py-2 text-center border transition flex flex-col items-center gap-1 ${
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
                            <span className="text-[10px] font-bold leading-tight">
                              {meta.shortLabel}
                            </span>
                          </button>
                        );
                      }
                    )}
                  </div>
                </div>

                <label className={`flex items-center gap-2.5 text-xs ${BODY} ${NESTED} px-3 py-2 cursor-pointer`}>
                  <input
                    type="checkbox"
                    checked={customGearPrimary}
                    onChange={(e) => onSetCustomPrimary(e.target.checked)}
                    className="rounded border-[var(--sp-cool-veil)] accent-[var(--sp-racing-orange)]"
                  />
                  <span className={`font-semibold ${INK}`}>Set as Primary Race-Day Gear</span>
                </label>

                <button
                  type="button"
                  disabled={addGearBusy}
                  onClick={onCreateCustomGear}
                  className="w-full sp-btn-primary py-2.5 disabled:opacity-50"
                >
                  {addGearBusy ? "Saving…" : "Save to Equipment Locker"}
                </button>
              </div>
            )}
          </div>
        </div>
      )}
    </>
  );
}
