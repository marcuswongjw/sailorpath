import { Archive, History, Tag } from "lucide-react";

export function EquipmentBulkBar({
  selectedCount,
  busy,
  onLogSession,
  onTag,
  onArchive,
  onClear,
}: {
  selectedCount: number;
  busy: boolean;
  onLogSession: () => void;
  onTag: () => void;
  onArchive: () => void;
  onClear: () => void;
}) {
  if (selectedCount === 0) return null;

  return (
    <div className="sticky top-14 z-20 rounded-xl border border-[var(--sp-racing-orange)]/40 bg-[var(--sp-warm-white)]/95 backdrop-blur-md px-3 py-2.5 flex flex-wrap items-center gap-2 shadow-xl">
      <span className="text-[13px] font-black text-[var(--sp-charcoal)] tabular-nums">
        {selectedCount} selected
      </span>
      <div className="flex flex-wrap gap-1.5 ml-auto">
        <button
          type="button"
          disabled={busy}
          onClick={onLogSession}
          className="inline-flex items-center gap-1 rounded-full bg-sky-600 px-2.5 py-1.5 text-[15px] font-semibold text-white touch-manipulation"
        >
          <History className="h-3 w-3" />
          Log session
        </button>
        <button
          type="button"
          disabled={busy}
          onClick={onTag}
          className="inline-flex items-center gap-1 rounded-full border border-[var(--sp-harbour-teal)] px-2.5 py-1.5 text-[13px] font-semibold text-[var(--sp-harbour-teal)] touch-manipulation"
        >
          <Tag className="h-3 w-3" />
          Tag
        </button>
        <button
          type="button"
          disabled={busy}
          onClick={onArchive}
          className="inline-flex items-center gap-1 rounded-full border border-[var(--sp-harbour-teal)] px-2.5 py-1.5 text-[13px] font-semibold text-[var(--sp-harbour-teal)] touch-manipulation"
        >
          <Archive className="h-3 w-3" />
          Archive
        </button>
        <button
          type="button"
          onClick={onClear}
          className="text-[13px] text-[var(--sp-slate-soft)] px-1 touch-manipulation"
        >
          Clear
        </button>
      </div>
    </div>
  );
}
