import { Star } from "lucide-react";
import {
  EQUIPMENT_TAGS,
  displayName,
  formatUseSummary,
  type EquipmentItemDto,
} from "@/lib/equipment";
import { BadgeChip } from "./BadgeChip";
import { ConditionChip } from "./ConditionChip";

export function EquipmentCard({
  item,
  partLabel,
  isOwner,
  selected,
  onToggleSelect,
  onLogUse,
  onEdit,
  onMakePrimary,
  onCycleCondition,
}: {
  item: EquipmentItemDto;
  partLabel?: string;
  isOwner: boolean;
  selected: boolean;
  onToggleSelect: () => void;
  onLogUse: () => void;
  onEdit: () => void;
  onMakePrimary: () => void;
  onCycleCondition?: () => void;
}) {
  const tags = item.tags
    .map((t) => EQUIPMENT_TAGS.find((x) => x.value === t)?.label || t)
    .filter(Boolean);

  return (
    <li
      className={`list-none rounded-xl border transition ${
        selected
          ? "border-[var(--sp-racing-orange)]/50 bg-[var(--sp-racing-mist)]/15 shadow-xs"
          : item.needsAttention
            ? "border-amber-300 bg-amber-50/60 shadow-xs"
            : item.isPrimary
              ? "border-[var(--sp-harbour-teal)]/40 bg-[var(--sp-warm-white)] ring-1 ring-[var(--sp-harbour-teal)]/20 shadow-xs"
              : "border-[var(--sp-cool-veil)] bg-white shadow-2xs"
      }`}
    >
      <div className="px-3.5 pt-3 pb-2.5 flex items-start gap-3">
        {isOwner && (
          <input
            type="checkbox"
            checked={selected}
            onChange={onToggleSelect}
            className="mt-1 shrink-0 rounded border-[var(--sp-cool-veil)]"
            aria-label={`Select ${displayName(item)}`}
          />
        )}
        <div className="min-w-0 flex-1">
          <div className="flex items-start gap-1.5 flex-wrap">
            <button
              type="button"
              disabled={!isOwner || item.isPrimary}
              onClick={onMakePrimary}
              aria-label={
                item.isPrimary
                  ? `${displayName(item)} is primary gear`
                  : `Make ${displayName(item)} primary`
              }
              aria-pressed={item.isPrimary}
              title={item.isPrimary ? "Primary gear" : "Make primary"}
              className={`mt-0.5 shrink-0 touch-manipulation min-h-[2.25rem] min-w-[2.25rem] inline-flex items-center justify-center rounded-lg ${
                item.isPrimary
                  ? "text-amber-500"
                  : "text-[var(--sp-slate-soft)] hover:text-amber-500"
              }`}
            >
              <Star
                className={`h-4 w-4 ${
                  item.isPrimary ? "fill-amber-400" : ""
                }`}
                aria-hidden
              />
            </button>
            <p className="text-sm font-bold text-[var(--sp-charcoal)] leading-snug min-w-0">
              {displayName(item)}
            </p>
            {partLabel && (
              <span className="text-[12px] font-bold uppercase tracking-wide text-[var(--sp-slate-soft)] mt-0.5">
                {partLabel}
              </span>
            )}
          </div>

          <div className="mt-1.5 flex flex-wrap items-center gap-1.5">
            <ConditionChip
              condition={item.condition}
              interactive={isOwner && Boolean(onCycleCondition)}
              onClick={onCycleCondition}
            />
            <BadgeChip badge={item.badge} label={item.badgeLabel} />
            {item.windRange && (
              <span className="inline-flex rounded-full border border-sky-200 bg-sky-50 px-2 py-0.5 text-[12px] font-bold uppercase text-sky-800">
                {item.windRange}
              </span>
            )}
            {item.isPrimary && (
              <span className="inline-flex rounded-full border border-amber-300 bg-amber-50 px-2 py-0.5 text-[11px] font-bold text-amber-900">
                Primary
              </span>
            )}
            {tags.slice(0, 3).map((t) => (
              <span
                key={t}
                className="inline-flex rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2 py-0.5 text-[11px] font-semibold text-[var(--sp-charcoal)]"
              >
                {t}
              </span>
            ))}
          </div>

          <p className="text-xs text-[var(--sp-slate-soft)] mt-1.5 tabular-nums">
            {formatUseSummary(item)}
            {item.category === "sail" && item.model ? ` · ${item.model}` : ""}
          </p>

          {(item.usageHistory?.length ?? 0) > 0 && (
            <p className="text-xs text-[var(--sp-slate-soft)] mt-1 leading-snug">
              <span className="font-semibold text-[var(--sp-charcoal)]">Used at</span>{" "}
              {item
                .usageHistory!.filter((u) => u.regattaName)
                .slice(0, 3)
                .map(
                  (u) =>
                    `${u.regattaName}${u.rank != null ? ` (#${u.rank})` : ""}`
                )
                .join(" · ")}
            </p>
          )}
        </div>
      </div>

      {isOwner && (
        <div className="flex border-t border-[var(--sp-cool-veil)] divide-x divide-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/40 rounded-b-xl">
          {!item.isPrimary && (
            <button
              type="button"
              onClick={onMakePrimary}
              className="flex-1 min-h-[2.5rem] py-2 text-xs font-semibold text-[var(--sp-racing-orange)] hover:bg-white touch-manipulation transition-colors"
            >
              Make primary
            </button>
          )}
          <button
            type="button"
            onClick={onLogUse}
            className="flex-1 min-h-[2.5rem] py-2 text-xs font-semibold text-[var(--sp-harbour-teal)] hover:bg-white touch-manipulation transition-colors"
          >
            Log session
          </button>
          <button
            type="button"
            onClick={onEdit}
            className="flex-1 min-h-[2.5rem] py-2 text-xs font-semibold text-[var(--sp-slate-soft)] hover:text-[var(--sp-charcoal)] hover:bg-white touch-manipulation transition-colors"
          >
            Edit
          </button>
        </div>
      )}
    </li>
  );
}
