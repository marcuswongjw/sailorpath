"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import {
  Calendar,
  Search,
  ExternalLink,
  Trophy,
  MapPin,
  ChevronRight,
  Filter,
} from "lucide-react";
import type { PublicClassRegattaRow } from "@/lib/publicDataLoader";

export type ClassRegattaListTableProps = {
  regattas: PublicClassRegattaRow[];
  classNameTitle: string;
};

export function ClassRegattaListTable({
  regattas,
  classNameTitle,
}: ClassRegattaListTableProps) {
  const [selectedYear, setSelectedYear] = useState<string>("all");
  const [selectedStatus, setSelectedStatus] = useState<"all" | "upcoming" | "past">("all");
  const [searchQuery, setSearchQuery] = useState<string>("");

  const availableYears = useMemo(() => {
    const years = new Set<string>();
    for (const r of regattas) {
      if (r.startDate) years.add(r.startDate.slice(0, 4));
    }
    return Array.from(years).sort((a, b) => b.localeCompare(a));
  }, [regattas]);

  const filteredRegattas = useMemo(() => {
    return regattas.filter((r) => {
      // Year filter
      if (selectedYear !== "all" && !r.startDate.startsWith(selectedYear)) {
        return false;
      }
      // Status filter
      if (selectedStatus === "upcoming" && r.timingStatus === "completed") {
        return false;
      }
      if (selectedStatus === "past" && r.timingStatus !== "completed") {
        return false;
      }
      // Search
      if (searchQuery.trim()) {
        const q = searchQuery.toLowerCase().trim();
        const matchName = r.name.toLowerCase().includes(q);
        const matchVenue = (r.venue || "").toLowerCase().includes(q);
        const matchRound = (r.roundLabel || "").toLowerCase().includes(q);
        if (!matchName && !matchVenue && !matchRound) return false;
      }
      return true;
    });
  }, [regattas, selectedYear, selectedStatus, searchQuery]);

  return (
    <div className="space-y-4">
      {/* Controls row */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-[var(--sp-warm-white)] rounded-2xl border border-[var(--sp-cool-veil)] p-3.5 shadow-xs">
        <div className="flex flex-wrap items-center gap-2">
          {/* Year selector */}
          <div className="flex items-center gap-1.5">
            <span className="text-xs font-semibold text-[var(--sp-slate-soft)]">Year:</span>
            <select
              value={selectedYear}
              onChange={(e) => setSelectedYear(e.target.value)}
              className="rounded-xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-3 py-1.5 text-xs font-bold text-[var(--sp-harbour-shadow)] focus:outline-none focus:border-[var(--sp-harbour-teal)]"
            >
              <option value="all">All years</option>
              {availableYears.map((y) => (
                <option key={y} value={y}>
                  {y}
                </option>
              ))}
            </select>
          </div>

          {/* Status buttons */}
          <div className="flex items-center gap-1 bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] rounded-xl p-1">
            {(["all", "upcoming", "past"] as const).map((s) => (
              <button
                key={s}
                type="button"
                onClick={() => setSelectedStatus(s)}
                className={`px-3 py-1 rounded-lg text-xs font-bold transition-all ${
                  selectedStatus === s
                    ? "bg-[var(--sp-harbour-teal)] text-white font-black shadow-xs"
                    : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
                }`}
              >
                {s === "all" ? "All" : s === "upcoming" ? "Upcoming" : "Past"}
              </button>
            ))}
          </div>
        </div>

        {/* Search */}
        <div className="relative w-full sm:w-60">
          <Search className="pointer-events-none absolute left-3 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-[var(--sp-slate-soft)]" />
          <input
            type="search"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Search regatta or venue…"
            className="sp-input w-full !pl-9 !py-1.5 text-xs"
          />
        </div>
      </div>

      {/* Regattas Table Layout */}
      <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] overflow-hidden shadow-xs">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs border-collapse">
            <thead>
              <tr className="border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/70 text-[var(--sp-slate-soft)] uppercase tracking-wider font-bold">
                <th className="py-3 px-4 min-w-[140px]">Dates</th>
                <th className="py-3 px-4 min-w-[240px]">Regatta</th>
                <th className="py-3 px-4 min-w-[160px]">Venue</th>
                <th className="py-3 px-4 min-w-[180px]">Results</th>
                <th className="py-3 px-4 text-right w-16"></th>
              </tr>
            </thead>
            <tbody className="divide-y divide-[var(--sp-cool-veil)]">
              {filteredRegattas.length === 0 ? (
                <tr>
                  <td colSpan={5} className="py-8 text-center text-slate-400">
                    No regattas matching your filters.
                  </td>
                </tr>
              ) : (
                filteredRegattas.map((row) => (
                  <tr
                    key={row.id}
                    className="hover:bg-[var(--sp-sailcloth)]/50 transition-colors group cursor-pointer"
                    onClick={() => {
                      window.location.href = row.canonicalHref;
                    }}
                  >
                    <td className="py-3.5 px-4 font-mono font-bold text-[var(--sp-charcoal)] whitespace-nowrap">
                      {row.datesText}
                    </td>
                    <td className="py-3.5 px-4">
                      <div className="space-y-0.5">
                        <Link
                          href={row.canonicalHref}
                          className="font-black text-sm text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-racing-orange)] transition-colors inline-flex items-center gap-1.5"
                          onClick={(e) => e.stopPropagation()}
                        >
                          <span>{row.name}</span>
                        </Link>
                        {row.roundLabel && (
                          <div className="flex items-center gap-1.5 text-[11px] text-amber-800">
                            <Trophy className="h-3 w-3 text-amber-600 shrink-0" />
                            <span>
                              {row.seriesLink?.seriesName} · <strong>{row.roundLabel}</strong>
                            </span>
                          </div>
                        )}
                      </div>
                    </td>
                    <td className="py-3.5 px-4 text-[var(--sp-charcoal-slate)]">
                      <div className="flex items-center gap-1">
                        <MapPin className="h-3 w-3 text-[var(--sp-slate-soft)] shrink-0" />
                        <span>{row.venue}</span>
                      </div>
                    </td>
                    <td className="py-3.5 px-4 whitespace-nowrap">
                      <span
                        className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-bold ${
                          row.resultStatus === "final"
                            ? "bg-emerald-50 text-emerald-800 border border-emerald-200"
                            : row.resultStatus === "provisional"
                            ? "bg-amber-50 text-amber-800 border border-amber-200"
                            : "bg-[var(--sp-sailcloth)] text-[var(--sp-slate-soft)] border border-[var(--sp-cool-veil)]"
                        }`}
                      >
                        {row.resultsSummary}
                      </span>
                    </td>
                    <td className="py-3.5 px-4 text-right">
                      <Link
                        href={row.canonicalHref}
                        className="text-[var(--sp-slate-soft)] group-hover:text-[var(--sp-harbour-teal)] transition-colors inline-block"
                        onClick={(e) => e.stopPropagation()}
                        aria-label={`View ${row.name}`}
                      >
                        <ChevronRight className="h-4 w-4" />
                      </Link>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
