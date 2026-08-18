import type { ReactNode } from "react";
import { X } from "lucide-react";
import { displayName, type EquipmentItemDto } from "@/lib/equipment";
import type { ModalKind } from "./types";

function modalTitle(modal: Exclude<ModalKind, null>): string {
  switch (modal) {
    case "use":
      return "Log session";
    case "fullRig":
      return "Add full rig set";
    case "bulkTag":
      return "Tag selected";
    case "edit":
      return "Edit equipment";
    default:
      return "Quick add";
  }
}

function modalSubtitle(
  modal: Exclude<ModalKind, null>,
  selectedCount: number,
  editing: EquipmentItemDto | null
): string {
  switch (modal) {
    case "use":
      return "Record regatta or training use";
    case "fullRig":
      return "Mast + boom + sprit in one step";
    case "bulkTag":
      return `${selectedCount} item(s)`;
    case "edit":
      return displayName(editing || {});
    default:
      return "Part, brand, number — more details optional";
  }
}

export function EquipmentModalShell({
  modal,
  selectedCount,
  editing,
  msg,
  onClose,
  children,
}: {
  modal: Exclude<ModalKind, null>;
  selectedCount: number;
  editing: EquipmentItemDto | null;
  msg: string | null;
  onClose: () => void;
  children: ReactNode;
}) {
  return (
    <div className="fixed inset-0 z-[80] flex items-end sm:items-center justify-center p-0 sm:p-4">
      <button
        type="button"
        className="absolute inset-0 bg-black/75 backdrop-blur-[2px]"
        aria-label="Close"
        onClick={onClose}
      />
      <div className="relative w-full max-w-md max-h-[92vh] overflow-y-auto rounded-t-3xl sm:rounded-2xl border border-white/10 bg-[#12141c] p-5 sm:p-6 space-y-4 shadow-2xl pb-[max(1.25rem,env(safe-area-inset-bottom))]">
        <div className="sm:hidden flex justify-center -mt-1 mb-1">
          <div className="h-1 w-10 rounded-full bg-white/15" />
        </div>
        <div className="flex items-start justify-between gap-3">
          <div>
            <h3 className="text-base font-black text-white tracking-tight">
              {modalTitle(modal)}
            </h3>
            <p className="text-[11px] text-slate-500 mt-0.5">
              {modalSubtitle(modal, selectedCount, editing)}
            </p>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="rounded-full border border-white/10 p-2 text-slate-400 hover:text-white touch-manipulation shrink-0"
            aria-label="Close"
          >
            <X className="h-4 w-4" />
          </button>
        </div>

        {msg && (
          <p className="rounded-xl border border-rose-500/30 bg-rose-500/10 px-3 py-2 text-[11px] text-rose-200 font-semibold">
            {msg}
          </p>
        )}

        {children}
      </div>
    </div>
  );
}
