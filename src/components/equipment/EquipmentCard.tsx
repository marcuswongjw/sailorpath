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
}: {
  item: EquipmentItemDto;
  partLabel?: string;
  isOwner: boolean;
  selected: boolean;
  onToggleSelect: () => void;
  onLogUse: () => void;
  onEdit: () => void;
  onMakePrimary: () => void;
}) {
  const tags = item.tags
    .map((t) => EQUIPMENT_TAGS.find((x) => x.value === t)?.label || t)
    .filter(Boolean);

  return (
    <li
      className={`list-none rounded-xl border transition ${
        selected
          ? "border-orange-500/40 bg-orange-500/[0.07]"
          : item.needsAttention
            ? "border-amber-500/25 bg-amber-500/[0.05]"
            : item.isPrimary
              ? "border-white/10 bg-gradient-to-br from-white/[0.04] to-transparent"
              : "border-white/[0.05] bg-black/25"
      }`}
    >
      <div className="px-3 pt-2.5 pb-2 flex items-start gap-2.5">
        {isOwner && (
          <input
            type="checkbox"
            checked={selected}
            onChange={onToggleSelect}
            className="mt-1 shrink-0 rounded border-white/20"
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
                  ? "text-amber-400"
                  : "text-slate-500 hover:text-amber-400"
              }`}
            >
              <Star
                className={`h-3.5 w-3.5 ${
                  item.isPrimary ? "fill-amber-400/60" : ""
                }`}
                aria-hidden
              />
            </button>
            <p className="text-[13px] font-bold text-white leading-snug min-w-0">
              {displayName(item)}
            </p>
            {partLabel && (
              <span className="text-[9px] font-bold uppercase tracking-wide text-slate-500 mt-0.5">
                {partLabel}
              </span>
            )}
          </div>

          <div className="mt-1.5 flex flex-wrap items-center gap-1">
            <ConditionChip condition={item.condition} />
            <BadgeChip badge={item.badge} label={item.badgeLabel} />
            {item.windRange && (
              <span className="inline-flex rounded-full border border-sky-500/25 bg-sky-500/10 px-1.5 py-0.5 text-[9px] font-bold uppercase text-sky-300">
                {item.windRange}
              </span>
            )}
            {item.isPrimary && (
              <span className="inline-flex rounded-full border border-amber-500/25 bg-amber-500/10 px-1.5 py-0.5 text-[9px] font-bold text-amber-200">
                Primary
              </span>
            )}
            {tags.slice(0, 3).map((t) => (
              <span
                key={t}
                className="inline-flex rounded-full border border-white/10 bg-white/[0.03] px-1.5 py-0.5 text-[9px] font-semibold text-slate-400"
              >
                {t}
              </span>
            ))}
          </div>

          <p className="text-[10px] text-slate-400 mt-1.5 tabular-nums">
            {formatUseSummary(item)}
            {item.category === "sail" && item.model ? ` · ${item.model}` : ""}
          </p>

          {(item.usageHistory?.length ?? 0) > 0 && (
            <p className="text-[10px] text-slate-400 mt-1 leading-snug">
              <span className="text-slate-500">Used at</span>{" "}
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
        <div className="flex border-t border-white/[0.04] divide-x divide-white/[0.04]">
          {!item.isPrimary && (
            <button
              type="button"
              onClick={onMakePrimary}
              className="flex-1 min-h-[2.75rem] py-2.5 text-[10px] font-bold text-amber-400/90 hover:bg-white/[0.03] touch-manipulation"
            >
              Make primary
            </button>
          )}
          <button
            type="button"
            onClick={onLogUse}
            className="flex-1 min-h-[2.75rem] py-2.5 text-[10px] font-bold text-sky-400 hover:bg-white/[0.03] touch-manipulation"
          >
            Log session
          </button>
          <button
            type="button"
            onClick={onEdit}
            className="flex-1 min-h-[2.75rem] py-2.5 text-[10px] font-bold text-slate-400 hover:bg-white/[0.03] touch-manipulation"
          >
            Edit
          </button>
        </div>
      )}
    </li>
  );
}
