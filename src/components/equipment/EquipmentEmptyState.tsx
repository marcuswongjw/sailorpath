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
    <div className="rounded-2xl border border-dashed border-white/10 bg-black/20 py-10 px-4 text-center space-y-4">
      <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-2xl bg-orange-500/10 border border-orange-500/20">
        <Wrench className="h-6 w-6 text-orange-400/90" />
      </div>
      <div>
        <p className="text-sm font-bold text-white">
          {isOwner ? "Build your gear bag" : "No equipment logged yet"}
        </p>
        <p className="text-[11px] text-slate-500 mt-1 max-w-xs mx-auto leading-relaxed">
          {isOwner
            ? "Start with the hull and race sail you use most. You can add the rest anytime."
            : "This sailor hasn’t added private gear yet."}
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
              className="rounded-full border border-white/10 bg-white/5 px-3.5 py-2 text-[11px] font-bold text-slate-200 hover:border-orange-500/40 touch-manipulation"
            >
              + {label}
            </button>
          ))}
          <button
            type="button"
            onClick={onOpenFullRig}
            className="rounded-full border border-orange-500/30 bg-orange-500/10 px-3.5 py-2 text-[11px] font-bold text-orange-200 touch-manipulation"
          >
            + Full rig set
          </button>
        </div>
      )}
    </div>
  );
}
