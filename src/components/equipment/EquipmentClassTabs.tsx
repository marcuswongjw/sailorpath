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
      className="inline-flex rounded-full border border-white/10 bg-black/25 p-0.5 gap-0.5"
    >
      <button
        type="button"
        role="tab"
        aria-selected={classTab === "optimist"}
        id="equipment-tab-optimist"
        onClick={() => onSelectClass("optimist")}
        className={`rounded-full px-3.5 py-2 text-[11px] font-bold transition touch-manipulation min-h-[2.25rem] ${
          classTab === "optimist"
            ? "bg-orange-600 text-white shadow-sm"
            : "text-slate-400 hover:text-white"
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
          className={`rounded-full px-3.5 py-2 text-[11px] font-bold transition touch-manipulation min-h-[2.25rem] ${
            classTab === "ilca4"
              ? "bg-sky-600 text-white shadow-sm"
              : "text-slate-400 hover:text-white"
          }`}
        >
          ILCA 4
        </button>
      ) : isOwner ? (
        <button
          type="button"
          onClick={onUnlockIlca}
          className="rounded-full px-3.5 py-2 text-[11px] font-bold text-sky-300/90 hover:text-sky-200 touch-manipulation min-h-[2.25rem]"
        >
          + ILCA 4
        </button>
      ) : null}
    </div>
  );
}
