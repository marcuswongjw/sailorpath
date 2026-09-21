import { Wrench } from "lucide-react";
import type { EquipmentCategory } from "@/lib/equipment";

export function EquipmentEmptyState({
  isOwner,
  onQuickAdd,
  onOpenFullRig,
}: {
  isOwner: boolean;
  onQuickAdd: (cat: EquipmentCategory) => void;
  onOpenFullRig: () => void;
}) {
  return (
    <div className="rounded-2xl border border-dashed border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/60 py-10 px-4 text-center space-y-4">
      <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-2xl bg-orange-50 border border-orange-200">
        <Wrench className="h-6 w-6 text-[var(--sp-racing-orange)]" />
      </div>
      <div>
        <p className="text-sm font-bold text-[var(--sp-charcoal)]">
          {isOwner ? "Build your gear bag" : "No gear logged yet"}
        </p>
        <p className="text-[13px] text-[var(--sp-slate-soft)] mt-1 max-w-xs mx-auto leading-relaxed">
          {isOwner
            ? "Hull, sail, and foils stay private — only you and linked parents can see them. Start with what you race most."
            : "Only the sailor can add equipment from their profile. Gear stays private to the family."}
        </p>
      </div>
      {isOwner && (
        <div className="flex flex-wrap justify-center gap-2">
          {(
            [
              ["hull", "Hull"],
              ["sail", "Sail"],
              ["daggerboard", "Foil"],
            ] as const
          ).map(([cat, label]) => (
            <button
              key={cat}
              type="button"
              onClick={() => onQuickAdd(cat)}
              className="rounded-full border border-[var(--sp-cool-veil)] bg-white px-3.5 py-2 text-[13px] font-bold text-[var(--sp-charcoal)] hover:border-[var(--sp-charcoal)]/40 shadow-xs touch-manipulation"
            >
              + {label}
            </button>
          ))}
          <button
            type="button"
            onClick={onOpenFullRig}
            className="rounded-full border border-orange-300 bg-orange-50 px-3.5 py-2 text-[15px] font-bold text-orange-900 hover:bg-orange-100 shadow-xs touch-manipulation"
          >
            + Full rig set
          </button>
        </div>
      )}
    </div>
  );
}
