"use client";

import { Plus, Sparkles, Loader2 } from "lucide-react";
import {
  REGATTA_CLASS_FAMILIES,
  ILCA_FLEETS,
  OPTIMIST_FLEETS,
} from "@/lib/admin/regattaClass";
import { emptyRegattaForm, type RegattaFormState } from "@/components/admin/adminForms";

export type RegattaFilterBarProps = {
  regattaSearch: string;
  onRegattaSearchChange: (v: string) => void;
  regattaClassFilter: string;
  onRegattaClassFilterChange: (v: string) => void;
  regattaDivisionFilter: string;
  onRegattaDivisionFilterChange: (v: string) => void;
  regattaRankingFilter: string;
  onRegattaRankingFilterChange: (v: string) => void;
  isSuperadmin?: boolean;
  isSeeding?: boolean;
  onAddRegatta: (form: RegattaFormState) => void;
  onSeed2026?: () => void;
};

/**
 * Search, filter, and action bar for the regatta admin panel.
 * Provides text search, class/fleet/ranking dropdowns, "Add regatta" button,
 * and the superadmin-only "Link 2026 events" seed button.
 */
export function RegattaFilterBar({
  regattaSearch,
  onRegattaSearchChange,
  regattaClassFilter,
  onRegattaClassFilterChange,
  regattaDivisionFilter,
  onRegattaDivisionFilterChange,
  regattaRankingFilter,
  onRegattaRankingFilterChange,
  isSuperadmin,
  isSeeding = false,
  onAddRegatta,
  onSeed2026,
}: RegattaFilterBarProps) {
  return (
    <div className="glass-panel rounded-2xl border border-slate-200 p-4 flex flex-col sm:flex-row sm:items-end gap-3 w-full">
      <div className="flex-1 min-w-0">
        <label className="text-[12px] font-bold text-slate-700 uppercase tracking-wider">
          Search events
        </label>
        <input
          type="search"
          value={regattaSearch}
          onChange={(e) => onRegattaSearchChange(e.target.value)}
          placeholder="Name, date, division, class…"
          className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-xs text-slate-900 placeholder:text-slate-400 focus:outline-none focus:border-orange-500"
        />
      </div>
      <div>
        <label className="text-[12px] font-bold text-slate-700 uppercase tracking-wider">
          Class
        </label>
        <select
          value={regattaClassFilter}
          onChange={(e) => {
            onRegattaClassFilterChange(e.target.value);
            onRegattaDivisionFilterChange("all");
          }}
          className="mt-1 w-full sm:w-36 rounded-xl border border-slate-300 bg-white px-3 py-2 text-xs text-slate-900 font-medium focus:outline-none focus:border-orange-500"
        >
          {REGATTA_CLASS_FAMILIES.map((family) => (
            <option key={family.id} value={family.id}>
              {family.label}
            </option>
          ))}
        </select>
      </div>
      <div>
        <label className="text-[12px] font-bold text-slate-700 uppercase tracking-wider">
          {regattaClassFilter === "ilca" ? "ILCA fleet" : "Fleet"}
        </label>
        <select
          value={regattaDivisionFilter}
          onChange={(e) => onRegattaDivisionFilterChange(e.target.value)}
          className="mt-1 w-full sm:w-36 rounded-xl border border-slate-300 bg-white px-3 py-2 text-xs text-slate-900 font-medium focus:outline-none focus:border-orange-500"
        >
          <option value="all">
            {regattaClassFilter === "ilca" ? "All ILCA" : "All fleets"}
          </option>
          {(regattaClassFilter === "ilca"
            ? ILCA_FLEETS
            : regattaClassFilter === "optimist" || regattaClassFilter === "all"
              ? OPTIMIST_FLEETS
              : []
          ).map(
            (fleet) => (
              <option key={fleet} value={fleet}>
                {fleet === "NonRanking" ? "Non-ranking" : fleet}
              </option>
            )
          )}
        </select>
      </div>
      <div>
        <label className="text-[12px] font-bold text-slate-700 uppercase tracking-wider">
          Ranking
        </label>
        <select
          value={regattaRankingFilter}
          onChange={(e) => onRegattaRankingFilterChange(e.target.value)}
          className="mt-1 w-full sm:w-36 rounded-xl border border-slate-300 bg-white px-3 py-2 text-xs text-slate-900 font-medium focus:outline-none focus:border-orange-500"
        >
          <option value="all">All events</option>
          <option value="series">Series only</option>
          <option value="nonranking">Non-ranking only</option>
        </select>
      </div>
      <button
        type="button"
        onClick={() =>
          onAddRegatta({
            ...emptyRegattaForm(),
            boatClass:
              regattaClassFilter === "wingfoil"
                ? "WingFoil"
                : regattaClassFilter === "29er"
                  ? "29er"
                  : regattaClassFilter === "techno"
                    ? "Techno 293"
                    : regattaClassFilter === "iqfoil"
                      ? "iQFOiL"
                    : regattaDivisionFilter === "ILCA 6" ||
                        regattaDivisionFilter === "ILCA 7" ||
                        regattaDivisionFilter === "ILCA 4"
                      ? regattaDivisionFilter
                      : regattaClassFilter === "ilca"
                        ? "ILCA 4"
                        : "Optimist",
            division:
              regattaClassFilter === "ilca" ||
              regattaDivisionFilter.startsWith("ILCA")
                ? "Open"
                : regattaDivisionFilter === "Gold" ||
                    regattaDivisionFilter === "Silver"
                  ? regattaDivisionFilter
                  : "Gold",
            date: new Date().toISOString().split("T")[0],
          })
        }
        className="rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2.5 text-xs font-bold text-white flex items-center justify-center gap-1 shrink-0"
      >
        <Plus className="h-4 w-4" />
        Add regatta
      </button>
      {isSuperadmin && (
        <button
          type="button"
          disabled={isSeeding}
          onClick={onSeed2026}
          className="rounded-full border border-sky-300 bg-sky-50 hover:bg-sky-100 px-3.5 py-2.5 text-xs font-bold text-sky-800 flex items-center justify-center gap-1.5 shrink-0 transition-colors disabled:opacity-50 shadow-xs"
          title="Attach 2026 main regatta events to their class sheets. Does not publish new results."
        >
          {isSeeding ? (
            <Loader2 className="h-3.5 w-3.5 animate-spin" />
          ) : (
            <Sparkles className="h-3.5 w-3.5 text-sky-600" />
          )}
          Link 2026 events
        </button>
      )}
    </div>
  );
}
