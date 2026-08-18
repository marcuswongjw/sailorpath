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
    <div className="sticky top-14 z-20 rounded-xl border border-orange-500/35 bg-[#1a1210]/95 backdrop-blur-md px-3 py-2.5 flex flex-wrap items-center gap-2 shadow-xl">
      <span className="text-[11px] font-black text-orange-200 tabular-nums">
        {selectedCount} selected
      </span>
      <div className="flex flex-wrap gap-1.5 ml-auto">
        <button
          type="button"
          disabled={busy}
          onClick={onLogSession}
          className="inline-flex items-center gap-1 rounded-full bg-sky-600 px-2.5 py-1.5 text-[10px] font-bold text-white touch-manipulation"
        >
          <History className="h-3 w-3" />
          Log session
        </button>
        <button
          type="button"
          disabled={busy}
          onClick={onTag}
          className="inline-flex items-center gap-1 rounded-full border border-white/15 px-2.5 py-1.5 text-[10px] font-bold text-white touch-manipulation"
        >
          <Tag className="h-3 w-3" />
          Tag
        </button>
        <button
          type="button"
          disabled={busy}
          onClick={onArchive}
          className="inline-flex items-center gap-1 rounded-full border border-white/15 px-2.5 py-1.5 text-[10px] font-bold text-slate-300 touch-manipulation"
        >
          <Archive className="h-3 w-3" />
          Archive
        </button>
        <button
          type="button"
          onClick={onClear}
          className="text-[10px] text-slate-500 px-1 touch-manipulation"
        >
          Clear
        </button>
      </div>
    </div>
  );
}
