import type { EquipmentBoatClass } from "@/lib/equipment";

export function EquipmentClassTabs({
  classTab,
  showIlcaTab,
  isOwner,
  onSelectClass,
  onUnlockIlca,
}: {
  classTab: EquipmentBoatClass;
  showIlcaTab: boolean;
  isOwner: boolean;
  onSelectClass: (c: EquipmentBoatClass) => void;
  onUnlockIlca: () => void;
}) {
  return (
    <div
      role="tablist"
      aria-label="Equipment boat class"
      className="inline-flex rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-1 gap-1 shadow-2xs"
    >
      <button
        type="button"
        role="tab"
        aria-selected={classTab === "optimist"}
        id="equipment-tab-optimist"
        onClick={() => onSelectClass("optimist")}
        className={`rounded-full px-4 py-1.5 text-xs font-bold transition touch-manipulation min-h-[2.25rem] ${
          classTab === "optimist"
            ? "bg-[var(--sp-racing-orange)] text-white shadow-xs"
            : "text-[var(--sp-charcoal)] hover:text-[var(--sp-harbour-teal)]"
        }`}
      >
        Optimist
      </button>
      {showIlcaTab ? (
        <button
          type="button"
          role="tab"
          aria-selected={classTab === "ilca4"}
          id="equipment-tab-ilca4"
          onClick={() => onSelectClass("ilca4")}
          className={`rounded-full px-4 py-1.5 text-xs font-bold transition touch-manipulation min-h-[2.25rem] ${
            classTab === "ilca4"
              ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
              : "text-[var(--sp-charcoal)] hover:text-[var(--sp-harbour-teal)]"
          }`}
        >
          ILCA 4
        </button>
      ) : isOwner ? (
        <button
          type="button"
          onClick={onUnlockIlca}
          className="rounded-full px-3.5 py-1.5 text-xs font-bold text-[var(--sp-harbour-teal)] hover:underline touch-manipulation min-h-[2.25rem]"
        >
          + ILCA 4
        </button>
      ) : null}
    </div>
  );
}
