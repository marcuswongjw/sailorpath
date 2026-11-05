"use client";

import { useMemo, useState } from "react";
import { ChevronRight, MapPin, Search } from "lucide-react";
import type { PublicClassRegattaRow } from "@/lib/publicDataLoader";

export type ClassRegattaListTableProps = {
  regattas: PublicClassRegattaRow[];
  classNameTitle: string;
};

export function ClassRegattaListTable({ regattas, classNameTitle }: ClassRegattaListTableProps) {
  const [selectedYear, setSelectedYear] = useState("all");
  const [selectedStatus, setSelectedStatus] = useState<"all" | "upcoming" | "past">("all");
  const [searchQuery, setSearchQuery] = useState("");
  const years = useMemo(() => [...new Set(regattas.map((row) => row.startDate.slice(0, 4)).filter(Boolean))].sort((a, b) => b.localeCompare(a)), [regattas]);
  const filtered = useMemo(() => {
    const query = searchQuery.trim().toLowerCase();
    return regattas.filter((row) =>
      (selectedYear === "all" || row.startDate.startsWith(selectedYear)) &&
      (selectedStatus === "all" || (selectedStatus === "past" ? row.timingStatus === "completed" : row.timingStatus !== "completed")) &&
      (!query || [row.name, row.venue, row.roundLabel].some((value) => value?.toLowerCase().includes(query)))
    );
  }, [regattas, selectedYear, selectedStatus, searchQuery]);

  return (
    <div className="space-y-3">
      <div className="flex flex-wrap items-end gap-3 rounded-2xl border border-cool-veil bg-warm-white p-4">
        <label className="min-w-0 flex-1 sm:min-w-52">
          <span className="mb-1 block text-xs font-semibold text-slate-soft">Search {classNameTitle} events</span>
          <span className="relative block">
            <Search aria-hidden="true" className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-soft" />
            <input type="search" value={searchQuery} onChange={(event) => setSearchQuery(event.target.value)} placeholder="Regatta or venue" className="sp-input w-full !pl-9 !py-2 text-sm" />
          </span>
        </label>
        <label>
          <span className="mb-1 block text-xs font-semibold text-slate-soft">Year</span>
          <select value={selectedYear} onChange={(event) => setSelectedYear(event.target.value)} className="min-h-10 rounded-xl border border-cool-veil bg-sailcloth px-3 text-sm font-semibold text-harbour-shadow">
            <option value="all">All years</option>
            {years.map((year) => <option key={year} value={year}>{year}</option>)}
          </select>
        </label>
        <label>
          <span className="mb-1 block text-xs font-semibold text-slate-soft">When</span>
          <select value={selectedStatus} onChange={(event) => setSelectedStatus(event.target.value as typeof selectedStatus)} className="min-h-10 rounded-xl border border-cool-veil bg-sailcloth px-3 text-sm font-semibold text-harbour-shadow">
            <option value="all">All events</option><option value="upcoming">Upcoming / in progress</option><option value="past">Past</option>
          </select>
        </label>
      </div>
      {filtered.length === 0 ? (
        <p className="rounded-2xl border border-cool-veil bg-warm-white p-6 text-sm text-slate-soft">No events match your filters.</p>
      ) : (
        <ul className="divide-y divide-cool-veil overflow-hidden rounded-2xl border border-cool-veil bg-warm-white">
          {filtered.map((row) => (
            <li key={`${row.source?.kind ?? "event"}:${row.id}`}>
              <a href={row.canonicalHref} className="group flex items-center gap-3 px-4 py-4 hover:bg-sailcloth focus-visible:outline-2 focus-visible:outline-harbour sm:px-5">
                <div className="min-w-0 flex-1">
                  <div className="flex flex-wrap items-center gap-x-3 gap-y-1">
                    <span className="text-sm font-bold text-harbour-shadow group-hover:text-harbour">{row.name}</span>
                    <span className="text-xs font-semibold text-slate-soft">{row.datesText}</span>
                  </div>
                  <div className="mt-1.5 flex flex-wrap items-center gap-x-3 gap-y-1 text-xs text-slate-soft">
                    {row.venue && <span className="inline-flex items-center gap-1"><MapPin className="h-3 w-3" aria-hidden="true" />{row.venue}</span>}
                    {row.roundLabel && <span>{row.seriesLink?.seriesName ? `${row.seriesLink.seriesName} · ` : ""}{row.roundLabel}</span>}
                    {row.source?.kind === "special_scorecard" && <span>Race scorecard</span>}
                    {row.source?.kind === "normalized_result" && <span>Event result</span>}
                  </div>
                  <span className={`mt-2 inline-block rounded-full px-2.5 py-1 text-xs font-semibold ${row.resultStatus === "final" ? "bg-emerald-50 text-emerald-800" : row.resultStatus === "provisional" ? "bg-amber-50 text-amber-800" : "bg-sailcloth text-slate-soft"}`}>{row.resultsSummary.replace(/^(?:Specialist|Published) scorecard(?: · )?/i, "") || "Results available"}</span>
                </div>
                <ChevronRight className="h-5 w-5 shrink-0 text-slate-soft group-hover:text-harbour" aria-hidden="true" />
              </a>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
