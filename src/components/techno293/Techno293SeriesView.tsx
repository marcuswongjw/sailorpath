"use client";

import { useState, useMemo } from "react";
import {
  Trophy,
  Medal,
  Calendar,
  Search,
  ChevronDown,
  Sparkles,
  CheckCircle2,
  AlertTriangle,
  ExternalLink,
  MapPin,
  Flag,
} from "lucide-react";
import { type Techno293Regatta } from "@/lib/techno293";
import {
  calculateTechno293SeriesResults,
  OFFICIAL_TECHNO293_DIVISIONS,
  isTechno293SailorInDivision,
  type Techno293SeriesResult,
  type Techno293DivisionId,
} from "@/lib/techno293Series";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";

export function Techno293SeriesView({
  regattas,
  onSelectRound,
}: {
  regattas: Techno293Regatta[];
  onSelectRound?: (roundId: string) => void;
}) {
  const series: Techno293SeriesResult = useMemo(
    () => calculateTechno293SeriesResults(regattas),
    [regattas]
  );

  const [divisionFilter, setDivisionFilter] = useState<string>("all");
  const [searchQuery, setSearchQuery] = useState<string>("");
  const [expandedSailor, setExpandedSailor] = useState<string | null>(null);

  const roundsWithRaces = useMemo(
    () => series.rounds.filter((rnd) => rnd.raceCount > 0),
    [series.rounds]
  );

  const filteredCompetitors = useMemo(() => {
    let list = series.competitors;

    if (divisionFilter !== "all") {
      list = list.filter((c) =>
        isTechno293SailorInDivision(c, divisionFilter as Techno293DivisionId)
      );
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
      {/* Series Header Card */}
      <div className="relative overflow-hidden rounded-3xl bg-gradient-to-br from-cyan-950/70 via-slate-900/90 to-blue-950/80 border border-cyan-500/20 p-5 sm:p-7 shadow-2xl backdrop-blur-md">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-5">
          <div className="space-y-2">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-bold bg-cyan-500/15 text-cyan-300 border border-cyan-500/30 tracking-wide uppercase">
              <Sparkles className="h-3.5 w-3.5" />
              Singapore Sailing Grand Prix Series
            </div>
            <h2 className="text-2xl sm:text-3xl font-black text-white tracking-tight flex items-center gap-3">
              <span>{series.seriesName}</span>
            </h2>
            <p className="text-sm text-slate-300 max-w-2xl leading-relaxed">
              Cumulative ranking across Grand Prix 1, 2, and 3. Scored using RRS Appendix A with cumulative series discards per Notice of Race clause 12.5.2.
            </p>
          </div>

          <div className="grid grid-cols-3 gap-2.5 sm:gap-3 shrink-0">
            <div className="bg-white/[0.04] border border-white/10 rounded-2xl p-3 text-center">
              <div className="text-xs text-slate-400 font-medium">Completed</div>
              <div className="text-xl sm:text-2xl font-black text-cyan-400">
                {series.totalRacesCompleted}
              </div>
              <div className="text-[10px] text-slate-400">Races Sailed</div>
            </div>

            <div className="bg-white/[0.04] border border-white/10 rounded-2xl p-3 text-center">
              <div className="text-xs text-slate-400 font-medium">Discards</div>
              <div className="text-xl sm:text-2xl font-black text-amber-400">
                {series.discardsApplied}
              </div>
              <div className="text-[10px] text-slate-400">Worst Dropped</div>
            </div>

            <div className="bg-white/[0.04] border border-white/10 rounded-2xl p-3 text-center">
              <div className="text-xs text-slate-400 font-medium">Fleet</div>
              <div className="text-xl sm:text-2xl font-black text-emerald-400">
                {series.competitors.length}
              </div>
              <div className="text-[10px] text-slate-400">Competitors</div>
            </div>
          </div>
        </div>

        {/* Grand Prix Rounds Navigation */}
        <div className="mt-6 pt-5 border-t border-white/10">
          <div className="text-xs font-bold uppercase tracking-wider text-slate-400 mb-3 flex items-center gap-2">
            <Calendar className="h-3.5 w-3.5 text-cyan-400" />
            <span>Grand Prix Series Rounds</span>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
            {series.rounds.map((round, idx) => {
              const hasRaces = round.raceCount > 0;
              return (
                <div
                  key={round.id}
                  onClick={() => onSelectRound && onSelectRound(round.id)}
                  className={`group relative p-3.5 rounded-2xl border transition-all text-left ${
                    onSelectRound ? "cursor-pointer" : ""
                  } ${
                    hasRaces
                      ? "bg-white/[0.04] border-white/10 hover:border-cyan-400/40 hover:bg-white/[0.07]"
                      : "bg-white/[0.02] border-white/5 opacity-75"
                  }`}
                >
                  <div className="flex items-center justify-between gap-2 mb-1">
                    <span className="text-xs font-black text-cyan-400">
                      Round {idx + 1}
                    </span>
                    <span
                      className={`text-[10px] px-2 py-0.5 rounded-full font-bold uppercase ${
                        round.status === "Completed"
                          ? "bg-emerald-500/20 text-emerald-300 border border-emerald-500/30"
                          : "bg-blue-500/20 text-blue-300 border border-blue-500/30"
                      }`}
                    >
                      {round.status}
                    </span>
                  </div>
                  <div className="text-sm font-bold text-white group-hover:text-cyan-300 transition-colors line-clamp-1">
                    {round.shortName}
                  </div>
                  <div className="text-xs text-slate-400 mt-1 flex items-center justify-between">
                    <span>{round.dates}</span>
                    <span className="font-semibold text-slate-300">
                      {hasRaces ? `${round.raceCount} races` : "Upcoming"}
                    </span>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>

      {/* Series Podium */}
      {top3.length > 0 && (
        <div className="space-y-3">
          <div className="flex items-center justify-between">
            <h3 className="text-base sm:text-lg font-black text-white flex items-center gap-2">
              <Trophy className="h-4 w-4 text-amber-400" />
              <span>Series Championship Leaders</span>
            </h3>
            <span className="text-xs text-slate-400">
              Low point cumulative series
            </span>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-3.5 sm:gap-4">
            {top3.map((sailor, idx) => {
              const isFirst = idx === 0;
              const isSecond = idx === 1;
              const borderStyles = isFirst
                ? "border-amber-400/50 bg-gradient-to-b from-amber-500/15 via-slate-900/90 to-slate-900/80 shadow-amber-500/10"
                : isSecond
                ? "border-slate-300/40 bg-gradient-to-b from-slate-300/10 via-slate-900/90 to-slate-900/80"
                : "border-amber-700/40 bg-gradient-to-b from-amber-700/10 via-slate-900/90 to-slate-900/80";

              return (
                <div
                  key={sailor.name}
                  className={`relative p-5 rounded-3xl border ${borderStyles} shadow-xl backdrop-blur-md flex flex-col justify-between`}
                >
                  <div className="flex items-start justify-between gap-3 mb-3">
                    <div className="flex items-center gap-2.5">
                      <RankMedalBadge rank={sailor.rank} />
                      <div>
                        <div className="text-xs font-bold uppercase tracking-wider text-slate-400">
                          {isFirst ? "Series Leader" : `Podium ${sailor.rank}`}
                        </div>
                        <h4 className="text-lg sm:text-xl font-black text-white">
                          {sailor.name}
                        </h4>
                      </div>
                    </div>
                  </div>

                  <div className="flex items-center justify-between text-xs text-slate-400 pt-3 border-t border-white/10 mt-2">
                    <div>
                      <span className="font-semibold text-slate-200">
                        {sailor.sailNumber || "—"}
                      </span>
                      <span className="mx-1.5">•</span>
                      <span>{sailor.ageCategory}</span>
                    </div>
                    <div className="text-right">
                      <span className="text-lg font-black text-cyan-400">
                        {sailor.nettScore}
                      </span>
                      <span className="text-[10px] text-slate-400 ml-1">
                        pts nett ({sailor.grossScore} gross)
                      </span>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      )}

      {/* Division Champions Summary */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
        {series.divisions
          .filter((d) => d.division.id !== "u15")
          .map((div) => {
            return (
              <div
                key={div.division.id}
                className="bg-white/[0.03] border border-white/10 rounded-2xl p-4 flex items-center justify-between gap-3"
              >
                <div>
                  <div className="text-xs font-bold text-cyan-400 flex items-center gap-1.5">
                    <Medal className="h-3.5 w-3.5 text-cyan-400" />
                    <span>{div.division.shortLabel} Division</span>
                  </div>
                  <div className="text-sm font-black text-white mt-1">
                    {div.champion ? div.champion.name : "To be decided"}
                  </div>
                  <div className="text-[11px] text-slate-400">
                    {div.champion
                      ? `${div.champion.nettScore} pts (${div.competitorCount} sailors)`
                      : `${div.competitorCount} competitors`}
                  </div>
                </div>
                {div.isConstituted ? (
                  <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-emerald-500/20 text-emerald-300 border border-emerald-500/30">
                    Constituted
                  </span>
                ) : (
                  <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-amber-500/20 text-amber-300 border border-amber-500/30">
                    &lt;3 entries
                  </span>
                )}
              </div>
            );
          })}
      </div>

      {/* Filter and Search Bar */}
      <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-3 pt-2">
        <div className="flex flex-wrap items-center gap-1.5 p-1 rounded-2xl bg-white/[0.04] border border-white/10">
          <button
            type="button"
            onClick={() => setDivisionFilter("all")}
            className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all ${
              divisionFilter === "all"
                ? "bg-cyan-500 text-slate-950 font-black shadow-md shadow-cyan-500/20"
                : "text-slate-400 hover:text-white"
            }`}
          >
            All Competitors ({series.competitors.length})
          </button>
          {OFFICIAL_TECHNO293_DIVISIONS.map((div) => {
            const count = series.competitors.filter((c) =>
              isTechno293SailorInDivision(c, div.id)
            ).length;
            if (count === 0 && div.id === "u15") return null;
            const isSelected = divisionFilter === div.id;
            return (
              <button
                key={div.id}
                type="button"
                onClick={() => setDivisionFilter(div.id)}
                className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all ${
                  isSelected
                    ? "bg-cyan-500 text-slate-950 font-black shadow-md shadow-cyan-500/20"
                    : "text-slate-400 hover:text-white"
                }`}
              >
                {div.shortLabel} ({count})
              </button>
            );
          })}
        </div>

        <div className="relative min-w-[220px]">
          <Search className="h-4 w-4 absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Search sailor or sail number..."
            className="w-full pl-9 pr-3 py-1.5 rounded-xl bg-white/[0.04] border border-white/10 text-xs text-white placeholder-slate-400 focus:outline-none focus:border-cyan-400"
          />
        </div>
      </div>

      {/* Master Series Standings Table */}
      <div className="overflow-hidden rounded-3xl border border-white/10 bg-slate-900/60 shadow-xl backdrop-blur-md">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs border-collapse">
            <thead>
              <tr className="border-b border-white/10 bg-white/[0.03] text-slate-400 uppercase tracking-wider font-semibold text-[11px]">
                <th className="py-3 px-3 sm:px-4 w-12 text-center">Rank</th>
                <th className="py-3 px-3 sm:px-4">Sailor</th>
                <th className="py-3 px-2 sm:px-3 text-center">Sail #</th>
                <th className="py-3 px-2 sm:px-3 text-center">Category</th>
                {roundsWithRaces.map((rnd) => (
                  <th
                    key={rnd.id}
                    className="py-3 px-2 text-center cursor-pointer hover:text-cyan-300 transition-colors"
                    onClick={() => onSelectRound && onSelectRound(rnd.id)}
                    title={`Click to view ${rnd.name} round standings`}
                  >
                    <div className="font-bold">{rnd.shortName}</div>
                    <div className="text-[10px] lowercase text-slate-400">
                      {rnd.raceCount} races
                    </div>
                  </th>
                ))}
                <th className="py-3 px-3 text-right">Gross</th>
                <th className="py-3 px-4 text-right font-black text-cyan-400">
                  Nett
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-white/5">
              {filteredCompetitors.length === 0 ? (
                <tr>
                  <td
                    colSpan={5 + roundsWithRaces.length}
                    className="py-8 text-center text-slate-400 text-sm"
                  >
                    No competitors found matching your criteria.
                  </td>
                </tr>
              ) : (
                filteredCompetitors.map((sailor) => {
                  const isExpanded = expandedSailor === sailor.name;

                  return (
                    <tr
                      key={sailor.name}
                      onClick={() =>
                        setExpandedSailor(isExpanded ? null : sailor.name)
                      }
                      className={`group hover:bg-white/[0.04] transition-colors cursor-pointer ${
                        sailor.rank <= 3 ? "bg-white/[0.01]" : ""
                      }`}
                    >
                      <td className="py-3.5 px-3 sm:px-4 text-center">
                        <div className="flex justify-center">
                          <RankMedalBadge rank={sailor.rank} />
                        </div>
                      </td>

                      <td className="py-3.5 px-3 sm:px-4">
                        <div className="font-bold text-white group-hover:text-cyan-300 transition-colors flex items-center gap-2">
                          <span>{sailor.name}</span>
                          <ChevronDown
                            className={`h-3 w-3 text-slate-400 transition-transform ${
                              isExpanded ? "rotate-180 text-cyan-400" : ""
                            }`}
                          />
                        </div>
                        {sailor.club && (
                          <div className="text-[11px] text-slate-400">
                            {sailor.club}
                          </div>
                        )}
                      </td>

                      <td className="py-3.5 px-2 sm:px-3 text-center font-mono font-medium text-slate-300">
                        {sailor.sailNumber || "—"}
                      </td>

                      <td className="py-3.5 px-2 sm:px-3 text-center">
                        <span className="px-2 py-0.5 rounded-md text-[10px] font-bold bg-white/5 text-slate-300 border border-white/10">
                          {sailor.ageCategory}
                        </span>
                      </td>

                      {/* Round Scores */}
                      {roundsWithRaces.map((rnd) => {
                        const roundRaces = sailor.races.filter(
                          (r) => r.roundId === rnd.id
                        );
                        const roundNett = roundRaces.reduce(
                          (acc, r) => acc + (r.isDiscarded ? 0 : r.score),
                          0
                        );
                        const attended = sailor.roundsAttended.includes(rnd.id);

                        return (
                          <td
                            key={rnd.id}
                            className="py-3.5 px-2 text-center font-mono"
                          >
                            {attended ? (
                              <div>
                                <span className="font-bold text-slate-200">
                                  {roundNett}
                                </span>
                                <div className="text-[9px] text-slate-400">
                                  {roundRaces.length} races
                                </div>
                              </div>
                            ) : (
                              <span className="text-slate-400 italic">DNC</span>
                            )}
                          </td>
                        );
                      })}

                      <td className="py-3.5 px-3 text-right font-mono text-slate-400">
                        {sailor.grossScore}
                      </td>

                      <td className="py-3.5 px-4 text-right font-mono text-sm font-black text-cyan-400">
                        {sailor.nettScore}
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Expanded Sailor Race Breakdown Card */}
      {expandedSailor && (
        <div className="p-4 sm:p-5 rounded-2xl bg-white/[0.03] border border-cyan-500/20 space-y-3">
          {(() => {
            const s = series.competitors.find((c) => c.name === expandedSailor);
            if (!s) return null;
            return (
              <>
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <span className="text-sm font-bold text-white">
                      Race-by-Race Breakdown: {s.name} ({s.sailNumber})
                    </span>
                    <span className="text-xs text-slate-400">
                      • {s.ageCategory} • {s.nettScore} pts nett
                    </span>
                  </div>
                  <button
                    type="button"
                    onClick={() => setExpandedSailor(null)}
                    className="text-xs text-slate-400 hover:text-white"
                  >
                    Close
                  </button>
                </div>

                <div className="flex flex-wrap gap-2 pt-2">
                  {s.races.map((r) => (
                    <div
                      key={`${r.roundId}-${r.raceInRound}`}
                      className={`px-2.5 py-1.5 rounded-lg border text-xs font-mono flex items-center gap-1.5 ${
                        r.isDiscarded
                          ? "bg-red-500/10 border-red-500/20 text-slate-400 line-through"
                          : "bg-white/5 border-white/10 text-white font-bold"
                      }`}
                      title={`${r.roundShortName} R${r.raceInRound}: ${r.score} pts ${
                        r.isDiscarded ? "(Discarded)" : ""
                      }`}
                    >
                      <span className="text-[10px] text-slate-400">
                        {r.roundShortName} R{r.raceInRound}:
                      </span>
                      <span>
                        {r.code ? `${r.score} ${r.code}` : `${r.score}`}
                      </span>
                    </div>
                  ))}
                </div>
              </>
            );
          })()}
        </div>
      )}
    </div>
  );
}
