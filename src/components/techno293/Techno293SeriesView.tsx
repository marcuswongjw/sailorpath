"use client";

import { useState, useMemo } from "react";
import {
  Trophy,
  Medal,
  Calendar,
  Search,
  ChevronDown,
  Sparkles,
} from "lucide-react";
import { type Techno293Regatta } from "@/lib/techno293";
import {
  calculateTechno293SeriesResults,
  OFFICIAL_TECHNO293_DIVISIONS,
  isTechno293SailorInDivision,
  TECHNO293_SERIES_OPTIONS,
  type Techno293SeriesResult,
  type Techno293DivisionId,
  type Techno293SeriesKey,
} from "@/lib/techno293Series";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";

export function Techno293SeriesView({
  regattas,
  onSelectRound,
}: {
  regattas: Techno293Regatta[];
  onSelectRound?: (roundId: string) => void;
}) {
  const [selectedSeriesKey, setSelectedSeriesKey] =
    useState<Techno293SeriesKey>("sw-monsoon");

  const series: Techno293SeriesResult = useMemo(
    () => calculateTechno293SeriesResults(regattas, selectedSeriesKey),
    [regattas, selectedSeriesKey]
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
      {/* Series Selection Switcher */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
        <div className="flex flex-wrap items-center gap-2 p-1.5 rounded-2xl bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] shadow-xs">
          {TECHNO293_SERIES_OPTIONS.map((opt) => {
            const isSelected = selectedSeriesKey === opt.key;
            return (
              <button
                key={opt.key}
                type="button"
                onClick={() => {
                  setSelectedSeriesKey(opt.key);
                  setDivisionFilter("all");
                  setSearchQuery("");
                }}
                className={`px-3.5 py-2 rounded-xl text-xs font-bold transition-all flex items-center gap-2 ${
                  isSelected
                    ? "bg-[var(--sp-harbour-teal)] text-white font-black shadow-xs"
                    : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)]"
                }`}
              >
                <Trophy
                  className={`h-3.5 w-3.5 ${
                    isSelected ? "text-white" : "text-amber-500"
                  }`}
                />
                <span>{opt.shortName}</span>
              </button>
            );
          })}
        </div>
      </div>

      {/* Series Header Card */}
      <div className="relative overflow-hidden rounded-3xl bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] p-5 sm:p-7 shadow-xs">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-5">
          <div className="space-y-2">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-bold bg-amber-100 text-amber-800 border border-amber-200 tracking-wide uppercase">
              <Sparkles className="h-3.5 w-3.5 text-amber-600" />
              Singapore Sailing Grand Prix Series
            </div>
            <h2 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight flex items-center gap-3">
              <span>{series.seriesName}</span>
            </h2>
          </div>

          <div className="grid grid-cols-3 gap-2.5 sm:gap-3 shrink-0">
            <div className="bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] rounded-2xl p-3 text-center">
              <div className="text-xs text-[var(--sp-slate-soft)] font-medium">Completed</div>
              <div className="text-xl sm:text-2xl font-black text-[var(--sp-harbour-shadow)]">
                {series.totalRacesCompleted}
              </div>
              <div className="text-[10px] text-[var(--sp-slate-soft)]">Races Sailed</div>
            </div>

            <div className="bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] rounded-2xl p-3 text-center">
              <div className="text-xs text-[var(--sp-slate-soft)] font-medium">Discards</div>
              <div className="text-xl sm:text-2xl font-black text-[var(--sp-harbour-teal)]">
                {series.discardsApplied}
              </div>
              <div className="text-[10px] text-[var(--sp-slate-soft)]">Worst Dropped</div>
            </div>

            <div className="bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] rounded-2xl p-3 text-center">
              <div className="text-xs text-[var(--sp-slate-soft)] font-medium">Fleet</div>
              <div className="text-xl sm:text-2xl font-black text-emerald-700">
                {series.competitors.length}
              </div>
              <div className="text-[10px] text-[var(--sp-slate-soft)]">Competitors</div>
            </div>
          </div>
        </div>

        {/* Grand Prix Rounds Navigation */}
        <div className="mt-6 pt-5 border-t border-[var(--sp-cool-veil)]">
          <div className="text-xs font-bold uppercase tracking-wider text-[var(--sp-slate-soft)] mb-3 flex items-center gap-2">
            <Calendar className="h-3.5 w-3.5 text-amber-600" />
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
                      ? "bg-[var(--sp-warm-white)] border-[var(--sp-cool-veil)] hover:border-[var(--sp-harbour-teal)] hover:shadow-xs"
                      : "bg-[var(--sp-sailcloth)]/50 border-[var(--sp-cool-veil)] opacity-75"
                  }`}
                >
                  <div className="flex items-center justify-between gap-2 mb-1">
                    <span className="text-xs font-black text-amber-700">
                      Round {idx + 1}
                    </span>
                    <span
                      className={`text-[10px] px-2 py-0.5 rounded-full font-bold uppercase ${
                        round.status === "Completed"
                          ? "bg-emerald-50 text-emerald-800 border border-emerald-200"
                          : "bg-blue-50 text-blue-800 border border-blue-200"
                      }`}
                    >
                      {round.status}
                    </span>
                  </div>
                  <div className="text-sm font-bold text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-racing-orange)] transition-colors line-clamp-1">
                    {round.shortName}
                  </div>
                  <div className="text-xs text-[var(--sp-charcoal-slate)] mt-1 flex items-center justify-between">
                    <span>{round.dates}</span>
                    <span className="font-semibold text-[var(--sp-harbour-teal)] font-mono">
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
            <h3 className="text-base sm:text-lg font-black text-[var(--sp-harbour-shadow)] flex items-center gap-2">
              <Trophy className="h-4 w-4 text-amber-500" />
              <span>Series Championship Leaders</span>
            </h3>
            <span className="text-xs text-[var(--sp-slate-soft)]">
              Low point cumulative series
            </span>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-3.5 sm:gap-4">
            {top3.map((sailor, idx) => {
              const isFirst = idx === 0;
              const borderStyles = isFirst
                ? "border-amber-300 bg-amber-50/70 shadow-xs"
                : "border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs";

              return (
                <div
                  key={sailor.name}
                  className={`relative p-5 rounded-2xl border ${borderStyles} flex flex-col justify-between`}
                >
                  {isFirst && (
                    <div className="absolute top-3 right-3 flex items-center gap-1 text-[10px] font-black uppercase tracking-wider text-amber-900 bg-amber-100 border border-amber-300 px-2 py-0.5 rounded-full">
                      <Sparkles className="h-3 w-3 text-amber-600" />
                      Series Leader
                    </div>
                  )}
                  <div className="flex items-start justify-between gap-3 mb-3">
                    <div className="flex items-center gap-2.5">
                      <RankMedalBadge rank={sailor.rank} />
                      <div>
                        <div className="text-xs font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">
                          {isFirst ? "Podium #1" : `Podium #${sailor.rank}`}
                        </div>
                        <h4 className="text-lg sm:text-xl font-black text-[var(--sp-harbour-shadow)]">
                          {sailor.name}
                        </h4>
                      </div>
                    </div>
                  </div>

                  <div className="flex items-center justify-between text-xs text-[var(--sp-charcoal-slate)] pt-3 border-t border-[var(--sp-cool-veil)] mt-2">
                    <div>
                      <span className="font-mono font-semibold text-[var(--sp-charcoal-slate)]">
                        {sailor.sailNumber || "—"}
                      </span>
                      <span className="mx-1.5 text-[var(--sp-slate-soft)]">•</span>
                      <span className="rounded bg-[var(--sp-sailcloth)] px-1.5 py-0.5 text-[10px] font-semibold text-[var(--sp-charcoal-slate)] border border-[var(--sp-cool-veil)]">
                        {sailor.ageCategory}
                      </span>
                    </div>
                    <div className="text-right font-mono tabular-nums">
                      <span className="text-lg font-black text-[var(--sp-harbour-shadow)]">
                        {sailor.nettScore}
                      </span>
                      <span className="text-[10px] text-[var(--sp-slate-soft)] ml-1">
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
                className="bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] rounded-2xl p-4 flex items-center justify-between gap-3 shadow-xs"
              >
                <div>
                  <div className="text-xs font-bold text-amber-800 flex items-center gap-1.5">
                    <Medal className="h-3.5 w-3.5 text-amber-600" />
                    <span>{div.division.shortLabel} Division</span>
                  </div>
                  <div className="text-sm font-black text-[var(--sp-harbour-shadow)] mt-1">
                    {div.champion ? div.champion.name : "To be decided"}
                  </div>
                  <div className="text-[11px] text-[var(--sp-slate-soft)]">
                    {div.champion
                      ? `${div.champion.nettScore} pts (${div.competitorCount} sailors)`
                      : `${div.competitorCount} competitors`}
                  </div>
                </div>
                {div.isConstituted ? (
                  <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-800 border border-emerald-200">
                    Constituted
                  </span>
                ) : (
                  <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-amber-50 text-amber-800 border border-amber-200">
                    &lt;3 entries
                  </span>
                )}
              </div>
            );
          })}
      </div>

      {/* Filter and Search Bar */}
      <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-3 pt-2">
        <div className="flex flex-wrap items-center gap-1.5 p-1 rounded-2xl bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] shadow-xs">
          <button
            type="button"
            onClick={() => setDivisionFilter("all")}
            className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all ${
              divisionFilter === "all"
                ? "bg-[var(--sp-harbour-teal)] text-white font-black shadow-xs"
                : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)]"
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
                    ? "bg-[var(--sp-harbour-teal)] text-white font-black shadow-xs"
                    : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)]"
                }`}
              >
                {div.shortLabel} ({count})
              </button>
            );
          })}
        </div>

        <div className="relative min-w-[220px]">
          <Search className="h-4 w-4 absolute left-3 top-1/2 -translate-y-1/2 text-[var(--sp-slate-soft)]" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Search sailor or sail number..."
            className="w-full pl-9 pr-3 py-1.5 rounded-xl bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] text-xs text-[var(--sp-harbour-shadow)] placeholder:text-[var(--sp-slate-soft)] focus:outline-none focus:border-[var(--sp-harbour-teal)] shadow-xs"
          />
        </div>
      </div>

      {/* Master Series Standings Table */}
      <div className="overflow-hidden rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs border-collapse">
            <thead>
              <tr className="border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] text-[var(--sp-slate-soft)] uppercase tracking-wider font-semibold text-[11px]">
                <th className="py-3 px-3 sm:px-4 w-12 text-center">Rank</th>
                <th className="py-3 px-3 sm:px-4">Sailor</th>
                <th className="py-3 px-2 sm:px-3 text-center">Sail #</th>
                <th className="py-3 px-2 sm:px-3 text-center">Category</th>
                {roundsWithRaces.map((rnd) => (
                  <th
                    key={rnd.id}
                    className="py-3 px-2 text-center cursor-pointer hover:text-[var(--sp-harbour-shadow)] transition-colors"
                    onClick={() => onSelectRound && onSelectRound(rnd.id)}
                    title={`Click to view ${rnd.name} round standings`}
                  >
                    <div className="font-bold">{rnd.shortName}</div>
                    <div className="text-[10px] lowercase text-[var(--sp-slate-soft)]">
                      {rnd.raceCount} races
                    </div>
                  </th>
                ))}
                <th className="py-3 px-3 text-right text-[var(--sp-slate-soft)]">Gross</th>
                <th className="py-3 px-4 text-right font-black text-[var(--sp-harbour-teal)]">
                  Nett
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-[var(--sp-cool-veil)] font-sans">
              {filteredCompetitors.length === 0 ? (
                <tr>
                  <td
                    colSpan={5 + roundsWithRaces.length}
                    className="py-8 text-center text-[var(--sp-slate-soft)] text-sm"
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
                      className="group hover:bg-[var(--sp-sailcloth)]/50 transition-colors cursor-pointer"
                    >
                      <td className="py-3.5 px-3 sm:px-4 text-center">
                        <div className="flex justify-center">
                          <RankMedalBadge rank={sailor.rank} />
                        </div>
                      </td>

                      <td className="py-3.5 px-3 sm:px-4">
                        <div className="font-bold text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-racing-orange)] transition-colors flex items-center gap-2">
                          <span>{sailor.name}</span>
                          <ChevronDown
                            className={`h-3 w-3 text-[var(--sp-slate-soft)] transition-transform ${
                              isExpanded ? "rotate-180 text-[var(--sp-harbour-teal)]" : ""
                            }`}
                          />
                        </div>
                        {sailor.club && (
                          <div className="text-[11px] text-[var(--sp-slate-soft)]">
                            {sailor.club}
                          </div>
                        )}
                      </td>

                      <td className="py-3.5 px-2 sm:px-3 text-center font-mono font-medium text-[var(--sp-charcoal-slate)] tabular-nums">
                        {sailor.sailNumber || "—"}
                      </td>

                      <td className="py-3.5 px-2 sm:px-3 text-center">
                        <span className="px-2 py-0.5 rounded-md text-[10px] font-bold bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal-slate)] border border-[var(--sp-cool-veil)]">
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
                            className="py-3.5 px-2 text-center font-mono tabular-nums"
                          >
                            {attended ? (
                              <div>
                                <span className="font-bold text-[var(--sp-charcoal-slate)]">
                                  {roundNett}
                                </span>
                                <div className="text-[9px] text-[var(--sp-slate-soft)]">
                                  {roundRaces.length} races
                                </div>
                              </div>
                            ) : (
                              <span className="text-[var(--sp-slate-soft)] italic">DNC</span>
                            )}
                          </td>
                        );
                      })}

                      <td className="py-3.5 px-3 text-right font-mono tabular-nums text-[var(--sp-slate-soft)]">
                        {sailor.grossScore}
                      </td>

                      <td className="py-3.5 px-4 text-right font-mono tabular-nums text-sm font-black text-[var(--sp-harbour-teal)]">
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
        <div className="p-4 sm:p-5 rounded-2xl bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] shadow-xs space-y-3">
          {(() => {
            const s = series.competitors.find((c) => c.name === expandedSailor);
            if (!s) return null;
            return (
              <>
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <span className="text-sm font-bold text-[var(--sp-harbour-shadow)]">
                      Race-by-Race Breakdown: {s.name} ({s.sailNumber})
                    </span>
                    <span className="text-xs text-[var(--sp-slate-soft)]">
                      • {s.ageCategory} • {s.nettScore} pts nett
                    </span>
                  </div>
                  <button
                    type="button"
                    onClick={() => setExpandedSailor(null)}
                    className="text-xs text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
                  >
                    Close
                  </button>
                </div>

                <div className="flex flex-wrap gap-2 pt-2">
                  {s.races.map((r) => (
                    <div
                      key={`${r.roundId}-${r.raceInRound}`}
                      className={`px-2.5 py-1.5 rounded-lg border text-xs font-mono tabular-nums flex items-center gap-1.5 ${
                        r.isDiscarded
                          ? "bg-red-50 border-red-200 text-[var(--sp-slate-soft)] line-through"
                          : "bg-[var(--sp-sailcloth)] border-[var(--sp-cool-veil)] text-[var(--sp-charcoal-slate)] font-bold"
                      }`}
                      title={`${r.roundShortName} R${r.raceInRound}: ${r.score} pts ${
                        r.isDiscarded ? "(Discarded)" : ""
                      }`}
                    >
                      <span className="text-[10px] text-[var(--sp-slate-soft)]">
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
