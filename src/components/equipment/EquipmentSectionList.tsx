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
  onCycleCondition,
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
  onCycleCondition?: (item: EquipmentItemDto) => void;
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
            className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/60 overflow-hidden shadow-2xs"
          >
            <div className="flex items-start justify-between gap-2 px-3.5 pt-3 pb-2">
              <div className="min-w-0 flex items-start gap-2.5">
                <span
                  className="flex h-8 w-8 shrink-0 items-center justify-center rounded-xl bg-white border border-[var(--sp-cool-veil)] text-base leading-none text-[var(--sp-harbour-teal)] shadow-2xs"
                  aria-hidden
                >
                  {sectionIcon(sec.id)}
                </span>
                <div className="min-w-0 pt-0.5">
                  <p className="text-[13px] font-bold text-[var(--sp-charcoal)] tracking-tight flex items-center gap-2">
                    {sec.label}
                    {!sec.isEmpty && (
                      <span className="text-[11px] font-bold text-[var(--sp-slate-soft)] bg-white border border-[var(--sp-cool-veil)] px-1.5 py-0.5 rounded-full tabular-nums">
                        {sec.items.length}
                      </span>
                    )}
                  </p>
                  <p className="text-[13px] text-[var(--sp-slate-soft)] mt-0.5 leading-snug">
                    {sec.hint}
                  </p>
                </div>
              </div>
              {isOwner && !isSet && (
                <button
                  type="button"
                  onClick={() => onQuickAdd(sec.categories[0])}
                  className="shrink-0 rounded-full border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] px-3 py-1 text-[13px] font-bold text-[var(--sp-harbour-teal)] transition-colors shadow-2xs touch-manipulation"
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
                    className="rounded-full border border-[var(--sp-cool-veil)] bg-white px-2.5 py-1 text-[13px] font-bold text-[var(--sp-charcoal)] hover:border-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-teal)] transition-colors touch-manipulation shadow-2xs"
                  >
                    + {categoryLabel(cat)}
                  </button>
                ))}
                {sec.id === "mast_set" && (
                  <button
                    type="button"
                    onClick={onOpenFullRig}
                    className="rounded-full border border-[var(--sp-racing-orange)]/30 bg-[var(--sp-racing-mist)]/20 px-2.5 py-1 text-[15px] font-bold text-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-mist)]/30 transition-colors touch-manipulation shadow-2xs"
                  >
                    + Full rig set
                  </button>
                )}
              </div>
            )}

            {sec.isEmpty ? (
              <p className="text-xs text-[var(--sp-slate-soft)] px-3.5 pb-3.5 pt-0.5">
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
                            onCycleCondition={
                              onCycleCondition
                                ? () => onCycleCondition(item)
                                : undefined
                            }
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
                        onCycleCondition={
                          onCycleCondition
                            ? () => onCycleCondition(item)
                            : undefined
                        }
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
