"use client";

export type SailorFilterBarProps = {
  dbSearch: string;
  onDbSearchChange: (v: string) => void;
  dbFleetFilter: string;
  onDbFleetFilterChange: (v: string) => void;
  dbSquadFilter: string;
  onDbSquadFilterChange: (v: string) => void;
  filteredCount: number;
  totalCount: number;
  selectedCount: number;
};

/**
 * Search, fleet, and squad filter bar for the sailor admin panel.
 */
export function SailorFilterBar({
  dbSearch,
  onDbSearchChange,
  dbFleetFilter,
  onDbFleetFilterChange,
  dbSquadFilter,
  onDbSquadFilterChange,
  filteredCount,
  totalCount,
  selectedCount,
}: SailorFilterBarProps) {
  return (
    <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3 shadow-xs">
      <div>
        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Search</label>
        <input
          type="search"
          placeholder="Name, sail #, club, school…"
          value={dbSearch}
          onChange={(e) => onDbSearchChange(e.target.value)}
          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
        />
      </div>
      <div>
        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
          Class / Series
        </label>
        <select
          value={dbFleetFilter}
          onChange={(e) => onDbFleetFilterChange(e.target.value)}
          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
        >
          <option value="all">All sailors</option>
          <option value="series">Optimist · In SG Fleet</option>
          <option value="guest">Optimist · Guest</option>
          <option value="gold">Optimist · Has Gold entry</option>
          <option value="silver">Optimist · Series · no Gold</option>
          <option value="ilca4">ILCA 4 (sail # or national list)</option>
          <option value="dual">Dual-class (Opti + ILCA 4)</option>
        </select>
      </div>
      <div>
        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Squad Jul 26</label>
        <select
          value={dbSquadFilter}
          onChange={(e) => onDbSquadFilterChange(e.target.value)}
          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
        >
          <option value="all">All squads</option>
          <option value="Nat A">Nat A</option>
          <option value="Nat B">Nat B</option>
          <option value="DS">DS</option>
        </select>
      </div>
      <p className="sm:col-span-2 lg:col-span-4 text-[11px] text-[var(--sp-slate-soft)]">
        Showing <strong className="text-[var(--sp-charcoal)]">{filteredCount}</strong> of{" "}
        {totalCount} sailors
        {selectedCount > 0 && (
          <>
            {" "}
            · <strong className="text-[var(--sp-racing-orange)]">{selectedCount}</strong> selected
            for bulk edit
          </>
        )}
      </p>
    </div>
  );
}
