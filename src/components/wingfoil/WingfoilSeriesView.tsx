"use client";

import { useState, useMemo } from "react";
import {
  Trophy,
  Medal,
  Calendar,
  Flame,
  Search,
  Filter,
  Info,
  ChevronDown,
  Sparkles,
  Users,
  CheckCircle2,
} from "lucide-react";
import {
  type WingfoilRegatta,
} from "@/lib/wingfoil";
import {
  calculateWingfoilSeries,
  type WingfoilSeriesResult,
  type SeriesSailorResult,
  getNoRDiscardsCount,
} from "@/lib/wingfoilSeries";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";

export function WingfoilSeriesView({
  regattas,
  onSelectRound,
}: {
  regattas: WingfoilRegatta[];
  onSelectRound?: (roundId: string) => void;
}) {
  const series: WingfoilSeriesResult = useMemo(
    () => calculateWingfoilSeries(regattas),
    [regattas]
  );

  const [divisionFilter, setDivisionFilter] = useState<string>("all");
  const [searchQuery, setSearchQuery] = useState<string>("");
  const [expandedSailor, setExpandedSailor] = useState<string | null>(null);

  const filteredCompetitors = useMemo(() => {
    let list = series.competitors;

    if (divisionFilter !== "all") {
      list = list.filter((c) => {
        const cat = c.ageCategory.toLowerCase();
        if (divisionFilter === "women") return c.gender === "F";
        if (divisionFilter === "masters")
          return cat.includes("master") && !cat.includes("grand");
        if (divisionFilter === "grandmasters")
          return cat.includes("grand master") || cat.includes("grandmaster");
        if (divisionFilter === "youth")
          return (
            cat.includes("16&u") ||
            cat.includes("u16") ||
            cat.includes("u19") ||
            cat.includes("19&u")
          );
        if (divisionFilter === "open")
          return cat.includes("open") || !cat.includes("fun");
        return true;
      });
    }

    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase().trim();
      list = list.filter(
        (c) =>
          c.name.toLowerCase().includes(q) ||
          c.sailNumber.toLowerCase().includes(q) ||
          (c.club && c.club.toLowerCase().includes(q))
      );
    }

    return list;
  }, [series.competitors, divisionFilter, searchQuery]);

  const top3 = series.competitors.slice(0, 3);

  return (
    <div className="space-y-6">
      {/* Series Championship Banner */}
      <div className="relative overflow-hidden rounded-3xl border border-amber-500/20 bg-gradient-to-br from-[#1b1710] via-[#12131c] to-[#0c0d14] p-6 sm:p-8 shadow-2xl">
        <div className="absolute -top-16 -right-16 h-64 w-64 rounded-full bg-amber-500/10 blur-3xl pointer-events-none" />
        <div className="absolute -bottom-16 -left-16 h-64 w-64 rounded-full bg-teal-500/10 blur-3xl pointer-events-none" />

        <div className="relative z-10 flex flex-col lg:flex-row lg:items-center justify-between gap-6">
          <div className="space-y-2 max-w-2xl">
            <div className="flex flex-wrap items-center gap-2">
              <span className="inline-flex items-center gap-1.5 rounded-full bg-amber-500/20 border border-amber-500/30 px-3 py-1 text-xs font-black uppercase tracking-wider text-amber-300">
                <Trophy className="h-3.5 w-3.5 text-amber-400" />
                Overall Championship
              </span>
              <span className="rounded-full bg-teal-500/10 border border-teal-500/20 px-2.5 py-0.5 text-[11px] font-bold text-teal-400">
                World Sailing RRS App. A &amp; NoR 12
              </span>
            </div>

            <h2 className="text-2xl sm:text-3xl lg:text-4xl font-black text-white tracking-tight">
              2026 Northeast Monsoon Grand Prix Series
            </h2>

            <p className="text-xs sm:text-sm text-slate-300 leading-relaxed">
              Official Singapore Championship series uniting Round 1 (GP1), Round 2 (GP2), and Round 3 (GP3).
              All individual heats pooled into a continuous series ranking of up to 72 races under World Sailing Low Point scoring with cumulative discards.
            </p>
          </div>

          {/* Series Metrics Stats Box */}
          <div className="grid grid-cols-2 sm:grid-cols-3 gap-2.5 shrink-0 bg-white/[0.03] border border-white/10 rounded-2xl p-3.5 backdrop-blur-md">
            <div className="space-y-0.5">
              <p className="text-[10px] font-bold uppercase tracking-wider text-slate-400">
                Races Sailed
              </p>
              <p className="text-xl font-black text-white">
                {series.totalRacesCompleted} <span className="text-xs text-slate-400 font-normal">/ 72</span>
              </p>
              <p className="text-[10px] text-teal-400 flex items-center gap-1">
                <CheckCircle2 className="h-3 w-3" /> Valid Series (6+ min)
              </p>
            </div>

            <div className="space-y-0.5">
              <p className="text-[10px] font-bold uppercase tracking-wider text-slate-400">
                Discards Applied
              </p>
              <p className="text-xl font-black text-amber-300">
                {series.discardsApplied}
              </p>
              <p className="text-[10px] text-slate-400">
                NoR Clause 12.5.2
              </p>
            </div>

            <div className="col-span-2 sm:col-span-1 space-y-0.5">
              <p className="text-[10px] font-bold uppercase tracking-wider text-slate-400">
                Competitors
              </p>
              <p className="text-xl font-black text-white">
                {series.competitors.length}
              </p>
              <p className="text-[10px] text-slate-400">
                Across 3 Rounds
              </p>
            </div>
          </div>
        </div>

        {/* Rounds Navigation Quick Chips */}
        <div className="mt-6 pt-5 border-t border-white/10 flex flex-wrap items-center gap-2 text-xs">
          <span className="text-slate-400 font-semibold mr-1">Rounds included:</span>
          {series.rounds.map((rnd, idx) => (
            <button
              key={rnd.id}
              type="button"
              onClick={() => onSelectRound?.(rnd.id)}
              className={`inline-flex items-center gap-1.5 rounded-xl border px-3 py-1.5 font-bold transition-all ${
                rnd.raceCount > 0
                  ? "border-amber-500/30 bg-amber-500/10 text-amber-200 hover:bg-amber-500/20"
                  : "border-white/10 bg-white/5 text-slate-400 hover:bg-white/10"
              }`}
            >
              <span>Round {idx + 1}: {rnd.shortName}</span>
              <span className="rounded-md bg-black/40 px-1.5 py-0.5 text-[10px] font-mono text-slate-300">
                {rnd.raceCount > 0 ? `${rnd.raceCount} races` : rnd.status}
              </span>
            </button>
          ))}
        </div>
      </div>

      {/* Top 3 Podium Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {top3.map((sailor, idx) => {
          const isWinner = idx === 0;
          return (
            <div
              key={sailor.name}
              className={`relative overflow-hidden rounded-2xl p-5 border transition-all ${
                isWinner
                  ? "border-amber-500/40 bg-gradient-to-b from-amber-500/15 via-[#181613] to-[#0e0f17] shadow-xl shadow-amber-500/5 ring-1 ring-amber-500/30"
                  : idx === 1
                  ? "border-slate-400/30 bg-gradient-to-b from-slate-400/10 via-[#15161f] to-[#0e0f17]"
                  : "border-amber-700/30 bg-gradient-to-b from-amber-700/10 via-[#15161f] to-[#0e0f17]"
              }`}
            >
              {isWinner && (
                <div className="absolute top-3 right-3 flex items-center gap-1 text-[10px] font-black uppercase tracking-wider text-amber-300 bg-amber-500/20 border border-amber-500/30 px-2 py-0.5 rounded-full">
                  <Sparkles className="h-3 w-3 text-amber-400" />
                  Series Champion
                </div>
              )}

              <div className="flex items-start gap-3">
                <RankMedalBadge
                  rank={idx + 1}
                  className="h-9 w-9 text-base"
                />
                <div className="space-y-1 min-w-0 flex-1">
                  <div className="flex items-center gap-2">
                    <span className="text-xs font-mono font-bold text-slate-400">
                      #{sailor.sailNumber || "—"}
                    </span>
                    <span className="rounded bg-white/10 px-1.5 py-0.5 text-[10px] font-semibold text-slate-300">
                      {sailor.ageCategory}
                    </span>
                  </div>
                  <h3 className="text-base sm:text-lg font-black text-white truncate">
                    {sailor.name}
                  </h3>
                  <p className="text-xs text-slate-400 truncate">
                    {sailor.club || sailor.schoolName || "Singapore"}
                  </p>
                </div>
              </div>

              <div className="mt-4 pt-3 border-t border-white/5 flex items-center justify-between text-xs font-mono">
                <span className="text-slate-400">
                  {sailor.roundsAttended.length} of {series.rounds.length} rounds sailed
                </span>
                <span className="font-black text-base text-amber-300">
                  {sailor.nettScore} <span className="text-[10px] font-normal text-slate-400">pts</span>
                </span>
              </div>
            </div>
          );
        })}
      </div>

      {/* Division Champions (NoR Clause 16.1) */}
      <div className="rounded-2xl border border-white/10 bg-[#131520] p-4">
        <div className="flex items-center gap-2 text-xs font-bold uppercase tracking-wider text-slate-400 mb-3">
          <Medal className="h-4 w-4 text-amber-400" />
          <span>Official Division Champions (NoR 12.4.1 &amp; 16.1)</span>
        </div>

        <div className="grid grid-cols-2 sm:grid-cols-4 gap-2.5 text-xs">
          <div className="rounded-xl bg-white/[0.03] border border-white/5 p-3">
            <p className="text-[10px] font-bold text-amber-400 uppercase tracking-wider">
              Masters (40+) Champion
            </p>
            <p className="font-bold text-white text-sm mt-0.5 truncate">
              {series.divisionChampions.masters?.name || "Pending"}
            </p>
            <p className="text-[11px] font-mono text-slate-400">
              {series.divisionChampions.masters?.nettScore != null
                ? `${series.divisionChampions.masters.nettScore} pts (Rank #${series.divisionChampions.masters.rank})`
                : "—"}
            </p>
          </div>

          <div className="rounded-xl bg-white/[0.03] border border-white/5 p-3">
            <p className="text-[10px] font-bold text-amber-400 uppercase tracking-wider">
              Grand Masters (50+)
            </p>
            <p className="font-bold text-white text-sm mt-0.5 truncate">
              {series.divisionChampions.grandMasters?.name || "Pending"}
            </p>
            <p className="text-[11px] font-mono text-slate-400">
              {series.divisionChampions.grandMasters?.nettScore != null
                ? `${series.divisionChampions.grandMasters.nettScore} pts (Rank #${series.divisionChampions.grandMasters.rank})`
                : "—"}
            </p>
          </div>

          <div className="rounded-xl bg-white/[0.03] border border-white/5 p-3">
            <p className="text-[10px] font-bold text-teal-400 uppercase tracking-wider">
              Youth (16&amp;U / U19)
            </p>
            <p className="font-bold text-white text-sm mt-0.5 truncate">
              {series.divisionChampions.youthU16?.name ||
                series.divisionChampions.youthU19?.name ||
                "Pending"}
            </p>
            <p className="text-[11px] font-mono text-slate-400">
              {(series.divisionChampions.youthU16 || series.divisionChampions.youthU19)?.nettScore != null
                ? `${(series.divisionChampions.youthU16 || series.divisionChampions.youthU19)!.nettScore} pts`
                : "—"}
            </p>
          </div>

          <div className="rounded-xl bg-white/[0.03] border border-white/5 p-3">
            <p className="text-[10px] font-bold text-pink-400 uppercase tracking-wider">
              Women&apos;s Division
            </p>
            <p className="font-bold text-white text-sm mt-0.5 truncate">
              {series.divisionChampions.women?.name || "Pending"}
            </p>
            <p className="text-[11px] font-mono text-slate-400">
              {series.divisionChampions.women?.nettScore != null
                ? `${series.divisionChampions.women.nettScore} pts`
                : "—"}
            </p>
          </div>
        </div>
      </div>

      {/* Filter & Search Bar */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 rounded-2xl border border-white/10 bg-[#0c0d14] p-3">
        <div className="flex flex-wrap items-center gap-1.5">
          {[
            { id: "all", label: "All Fleet" },
            { id: "open", label: "Open" },
            { id: "masters", label: "Masters (40+)" },
            { id: "grandmasters", label: "Grand Masters (50+)" },
            { id: "youth", label: "Youth (U16/U19)" },
            { id: "women", label: "Women" },
          ].map((div) => (
            <button
              key={div.id}
              type="button"
              onClick={() => setDivisionFilter(div.id)}
              className={`rounded-lg px-3 py-1.5 text-xs font-bold transition-all ${
                divisionFilter === div.id
                  ? "bg-teal-500 text-slate-950 shadow-sm"
                  : "text-slate-400 hover:text-white hover:bg-white/5"
              }`}
            >
              {div.label}
            </button>
          ))}
        </div>

        <div className="relative">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-slate-500" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Search racer, sail #, club…"
            className="rounded-xl border border-white/10 bg-slate-900/80 pl-9 pr-3 py-1.5 text-xs text-white placeholder:text-slate-500 focus:outline-none focus:border-teal-500 w-full sm:w-64"
          />
        </div>
      </div>

      {/* Series Master Scorecard Table (Desktop) */}
      <div className="hidden md:block rounded-2xl border border-white/10 bg-[#0c0d14] overflow-hidden shadow-xl">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            {/* Top Tier Header: Grouped by Round */}
            <thead className="bg-[#131520] border-b border-white/10 text-[10px] uppercase tracking-wider font-bold">
              <tr>
                <th colSpan={5} className="px-4 py-2.5 text-slate-400 border-r border-white/10">
                  Competitor Details
                </th>
                {series.rounds.map((rnd) => (
                  <th
                    key={rnd.id}
                    colSpan={rnd.raceCount || 1}
                    className="px-2 py-2.5 text-center border-r border-white/10 bg-white/[0.02]"
                  >
                    <span className="text-amber-300 font-black">{rnd.shortName}</span>
                    <span className="ml-1 text-slate-500 font-mono">
                      ({rnd.raceCount > 0 ? `${rnd.raceCount} races` : "Upcoming"})
                    </span>
                  </th>
                ))}
                <th colSpan={2} className="px-4 py-2.5 text-right text-teal-300">
                  Cumulative Points
                </th>
              </tr>

              {/* Second Tier Header: Columns */}
              <tr className="border-b border-white/10 text-slate-400 bg-white/[0.01]">
                <th className="px-4 py-2.5 w-12 text-center">Rank</th>
                <th className="px-4 py-2.5 min-w-[12rem]">Racer / Sailor</th>
                <th className="px-2 py-2.5 text-center w-14">Sail #</th>
                <th className="px-2 py-2.5 text-center w-16">Div</th>
                <th className="px-3 py-2.5 min-w-[9rem] border-r border-white/10">Club</th>
                {series.rounds.flatMap((rnd) =>
                  rnd.raceCount > 0
                    ? Array.from({ length: rnd.raceCount }).map((_, i) => (
                        <th
                          key={`${rnd.id}-r${i}`}
                          className="px-1.5 py-2.5 text-center w-8 text-[10px] font-mono text-slate-500"
                        >
                          R{i + 1}
                        </th>
                      ))
                    : [
                        <th
                          key={`${rnd.id}-empty`}
                          className="px-3 py-2.5 text-center text-slate-600 font-normal italic"
                        >
                          Upcoming
                        </th>,
                      ]
                )}
                <th className="px-3 py-2.5 text-right w-16 text-slate-500 font-mono">Gross</th>
                <th className="px-4 py-2.5 text-right w-20 font-black text-teal-300 font-mono">
                  Nett
                </th>
              </tr>
            </thead>

            <tbody className="divide-y divide-white/5 font-sans">
              {filteredCompetitors.map((sailor) => (
                <tr
                  key={sailor.name}
                  className="hover:bg-white/[0.02] transition-colors"
                >
                  <td className="px-4 py-3 text-center">
                    <RankMedalBadge
                      rank={sailor.rank}
                      nonPodiumClassName="font-mono font-bold text-teal-400"
                    />
                  </td>

                  <td className="px-4 py-3">
                    <p className="font-bold text-white">{sailor.name}</p>
                    <p className="text-[10px] text-slate-500 truncate">
                      {sailor.roundsAttended.length === series.rounds.length
                        ? "All rounds attended"
                        : `${sailor.roundsAttended.length} of ${series.rounds.length} rounds`}
                    </p>
                  </td>

                  <td className="px-2 py-3 text-center font-mono text-slate-300">
                    {sailor.sailNumber || "—"}
                  </td>

                  <td className="px-2 py-3 text-center">
                    <span className="rounded bg-white/5 border border-white/10 px-1.5 py-0.5 text-[10px] font-semibold text-slate-300">
                      {sailor.ageCategory}
                    </span>
                  </td>

                  <td className="px-3 py-3 border-r border-white/10">
                    <p className="text-slate-300 truncate max-w-[10rem]">
                      {sailor.club || "—"}
                    </p>
                  </td>

                  {/* All Race Scores across Grand Prix Rounds */}
                  {sailor.races.map((r, i) => (
                    <td
                      key={i}
                      className={`px-1.5 py-3 text-center font-mono text-xs ${
                        r.isDiscarded
                          ? "line-through text-slate-600 bg-white/[0.01]"
                          : r.score === 1
                          ? "font-black text-amber-300 bg-amber-500/10"
                          : r.score <= 3
                          ? "font-bold text-teal-200"
                          : r.code === "DNC"
                          ? "text-rose-400/60 bg-rose-500/5"
                          : "text-slate-400"
                      }`}
                      title={
                        r.code
                          ? `${r.roundShortName} Race ${r.raceInRound}: ${r.code} (${r.score} pts)`
                          : `${r.roundShortName} Race ${r.raceInRound}: ${r.score} pts`
                      }
                    >
                      {r.code && r.score !== 1 ? `${r.score}${r.code}` : r.score}
                    </td>
                  ))}

                  <td className="px-3 py-3 text-right font-mono text-slate-500 text-xs">
                    {sailor.grossScore}
                  </td>

                  <td className="px-4 py-3 text-right font-mono font-black text-sm text-teal-300">
                    {sailor.nettScore}
                  </td>
                </tr>
              ))}

              {filteredCompetitors.length === 0 && (
                <tr>
                  <td
                    colSpan={series.totalRacesCompleted + 7}
                    className="px-4 py-12 text-center text-slate-400"
                  >
                    No competitors match the selected filter.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Footer Scoring Legend */}
        <div className="border-t border-white/5 bg-[#0c0d14] px-4 py-2.5 text-[11px] text-slate-400 flex flex-wrap items-center justify-between gap-2">
          <span>
            <strong className="text-white">Scoring Rules:</strong> World Sailing RRS Appendix A &amp; NoR Clause 12. Low Points win.
            Non-attendees scored Attendee Count + 2 pts (DNC) per NoR 12.3.2.
          </span>
          <span className="font-mono text-[10px] text-slate-500">
            Discards: {series.discardsApplied} of {series.totalRacesCompleted} races discarded per NoR 12.5.2 scale
          </span>
        </div>
      </div>

      {/* Mobile Competitor Cards View */}
      <div className="md:hidden space-y-3">
        {filteredCompetitors.map((sailor) => {
          const isExpanded = expandedSailor === sailor.name;
          return (
            <div
              key={sailor.name}
              className="rounded-2xl border border-white/10 bg-[#131520] p-4 space-y-3"
            >
              <div className="flex items-start justify-between gap-3">
                <div className="flex items-center gap-3">
                  <RankMedalBadge rank={sailor.rank} className="h-8 w-8 text-sm" />
                  <div>
                    <h4 className="font-bold text-white text-sm">{sailor.name}</h4>
                    <p className="text-[11px] text-slate-400">
                      #{sailor.sailNumber || "—"} · {sailor.ageCategory} · {sailor.club || "Singapore"}
                    </p>
                  </div>
                </div>

                <div className="text-right font-mono">
                  <p className="text-base font-black text-amber-300">
                    {sailor.nettScore} <span className="text-[10px] font-normal text-slate-400">pts</span>
                  </p>
                  <p className="text-[10px] text-slate-500">Gross: {sailor.grossScore}</p>
                </div>
              </div>

              <div className="pt-2 border-t border-white/5 flex items-center justify-between">
                <span className="text-[11px] text-slate-400">
                  {sailor.roundsAttended.length} of {series.rounds.length} rounds attended
                </span>

                <button
                  type="button"
                  onClick={() => setExpandedSailor(isExpanded ? null : sailor.name)}
                  className="inline-flex items-center gap-1 text-[11px] font-bold text-teal-400 hover:text-teal-300"
                >
                  {isExpanded ? "Hide score breakdown" : "View all heats"}
                  <ChevronDown
                    className={`h-3 w-3 transition-transform ${
                      isExpanded ? "rotate-180" : ""
                    }`}
                  />
                </button>
              </div>

              {isExpanded && (
                <div className="pt-2 border-t border-white/5 space-y-2">
                  <p className="text-[10px] uppercase font-bold text-slate-400">
                    Heat Scores (Struck through = Discarded)
                  </p>
                  <div className="flex flex-wrap gap-1">
                    {sailor.races.map((r, i) => (
                      <span
                        key={i}
                        className={`rounded px-1.5 py-0.5 font-mono text-[10px] ${
                          r.isDiscarded
                            ? "line-through text-slate-600 bg-white/5"
                            : r.score === 1
                            ? "font-bold text-amber-300 bg-amber-500/20 border border-amber-500/30"
                            : r.code === "DNC"
                            ? "text-rose-400 bg-rose-500/10"
                            : "text-slate-300 bg-white/10"
                        }`}
                      >
                        {r.code && r.score !== 1 ? `${r.score}${r.code}` : r.score}
                      </span>
                    ))}
                  </div>
                </div>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
}
