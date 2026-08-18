import {
  categoryLabel,
  groupEquipmentSections,
  type EquipmentCategory,
  type EquipmentItemDto,
} from "@/lib/equipment";
import { EquipmentCard } from "./EquipmentCard";
import { sectionIcon } from "./utils";

type Section = ReturnType<typeof groupEquipmentSections>[number];

export function EquipmentSectionList({
  sections,
  isOwner,
  selected,
  onToggleSelect,
  onLogUse,
  onEdit,
  onMakePrimary,
  onQuickAdd,
  onOpenFullRig,
}: {
  sections: Section[];
  isOwner: boolean;
  selected: Set<string>;
  onToggleSelect: (id: string) => void;
  onLogUse: (id: string) => void;
  onEdit: (item: EquipmentItemDto) => void;
  onMakePrimary: (item: EquipmentItemDto) => void;
  onQuickAdd: (cat: EquipmentCategory) => void;
  onOpenFullRig: () => void;
}) {
  return (
    <div className="space-y-3">
      {sections.map((sec) => {
        if (sec.isEmpty && !isOwner) return null;
        const isSet = sec.id === "mast_set" || sec.id === "foil_set";
        return (
          <div
            key={sec.id}
            className="rounded-2xl border border-white/[0.06] bg-black/20 overflow-hidden"
          >
            <div className="flex items-start justify-between gap-2 px-3.5 pt-3 pb-2">
              <div className="min-w-0 flex items-start gap-2.5">
                <span
                  className="flex h-8 w-8 shrink-0 items-center justify-center rounded-xl bg-white/[0.04] border border-white/[0.06] text-base leading-none"
                  aria-hidden
                >
                  {sectionIcon(sec.id)}
                </span>
                <div className="min-w-0 pt-0.5">
                  <p className="text-[12px] font-black text-white tracking-tight flex items-center gap-2">
                    {sec.label}
                    {!sec.isEmpty && (
                      <span className="text-[10px] font-bold text-slate-500 tabular-nums">
                        {sec.items.length}
                      </span>
                    )}
                  </p>
                  <p className="text-[10px] text-slate-400 mt-0.5 leading-snug">
                    {sec.hint}
                  </p>
                </div>
              </div>
              {isOwner && !isSet && (
                <button
                  type="button"
                  onClick={() => onQuickAdd(sec.categories[0])}
                  className="shrink-0 rounded-full border border-white/10 bg-white/5 px-2.5 py-1 text-[10px] font-bold text-orange-300 hover:border-orange-500/40 touch-manipulation"
                >
                  + Add
                </button>
              )}
            </div>

            {isSet && isOwner && (
              <div className="flex flex-wrap gap-1.5 px-3.5 pb-2">
                {sec.categories.map((cat) => (
                  <button
                    key={cat}
                    type="button"
                    onClick={() => onQuickAdd(cat)}
                    className="rounded-full border border-white/10 bg-white/[0.03] px-2.5 py-1 text-[10px] font-bold text-slate-300 hover:border-orange-500/35 touch-manipulation"
                  >
                    + {categoryLabel(cat)}
                  </button>
                ))}
                {sec.id === "mast_set" && (
                  <button
                    type="button"
                    onClick={onOpenFullRig}
                    className="rounded-full border border-orange-500/30 bg-orange-500/10 px-2.5 py-1 text-[10px] font-bold text-orange-200 touch-manipulation"
                  >
                    + Full rig set
                  </button>
                )}
              </div>
            )}

            {sec.isEmpty ? (
              <p className="text-[11px] text-slate-400 px-3.5 pb-3.5 pt-0.5">
                Nothing here yet
                {isOwner ? " — tap + to add." : "."}
              </p>
            ) : (
              <ul className="px-2.5 pb-2.5 space-y-2">
                {isSet
                  ? sec.byCategory
                      .filter((g) => g.items.length > 0)
                      .flatMap((g) =>
                        g.items.map((item) => (
                          <EquipmentCard
                            key={item.id}
                            item={item}
                            partLabel={g.label}
                            isOwner={isOwner}
                            selected={selected.has(item.id)}
                            onToggleSelect={() => onToggleSelect(item.id)}
                            onLogUse={() => onLogUse(item.id)}
                            onEdit={() => onEdit(item)}
                            onMakePrimary={() => onMakePrimary(item)}
                          />
                        ))
                      )
                  : sec.items.map((item) => (
                      <EquipmentCard
                        key={item.id}
                        item={item}
                        isOwner={isOwner}
                        selected={selected.has(item.id)}
                        onToggleSelect={() => onToggleSelect(item.id)}
                        onLogUse={() => onLogUse(item.id)}
                        onEdit={() => onEdit(item)}
                        onMakePrimary={() => onMakePrimary(item)}
                      />
                    ))}
              </ul>
            )}
          </div>
        );
      })}
    </div>
  );
}
