"use client";

import { useState, useMemo, useEffect } from "react";
import {
  Wind,
  Calendar,
  MapPin,
  ChevronRight,
  Trophy,
} from "lucide-react";
import {
  SINGAPORE_WINGFOIL_REGATTAS,
  loadWingfoilRegattas,
  fetchServerWingfoilRegattas,
  type WingfoilRegatta,
} from "@/lib/wingfoil";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";
import { WingfoilSeriesView } from "./WingfoilSeriesView";

export function WingfoilView({
  initialRegattas,
}: {
  initialRegattas?: WingfoilRegatta[];
} = {}) {
  const [regattas, setRegattas] = useState<WingfoilRegatta[]>(
    initialRegattas && initialRegattas.length > 0
      ? initialRegattas
      : SINGAPORE_WINGFOIL_REGATTAS
  );
  const [selectedRegattaId, setSelectedRegattaId] = useState<string>(
    (initialRegattas && initialRegattas[0]?.id) ||
      SINGAPORE_WINGFOIL_REGATTAS[0].id
  );
  const [genderFilter, setGenderFilter] = useState<"all" | "M" | "F">("all");
  const [activeTab, setActiveTab] = useState<
    "series" | "results" | "calendar"
  >("series");

  // Re-hydrate from persistent storage and sync with server on mount
  useEffect(() => {
    const loaded = loadWingfoilRegattas();
    if (!initialRegattas && loaded.length > 0) {
      setRegattas(loaded);
    }

    fetchServerWingfoilRegattas().then((serverData) => {
      if (serverData && serverData.length > 0) {
        setRegattas(serverData);
      }
    });
  }, [initialRegattas]);

  // Public showcase only queries and displays verified, published regattas
  const publishedRegattas = useMemo(() => {
    return regattas.filter(
      (r) => !r.lifecycleStatus || r.lifecycleStatus === "published"
    );
  }, [regattas]);

  const activeRegatta = useMemo(
    () =>
      publishedRegattas.find((r) => r.id === selectedRegattaId) ||
      publishedRegattas[0] ||
      SINGAPORE_WINGFOIL_REGATTAS[0],
    [publishedRegattas, selectedRegattaId]
  );

  const displayResults = useMemo(() => {
    if (!activeRegatta.results) return [];
    let rows = activeRegatta.results;
    if (genderFilter !== "all") {
      rows = rows.filter((r) => r.gender === genderFilter);
    }
    return rows;
  }, [activeRegatta, genderFilter]);

  return (
    <div className="mx-auto w-full max-w-7xl min-w-0 px-3 sm:px-6 lg:px-8 pt-4 pb-8 sm:pt-6 sm:pb-10 space-y-5 sm:space-y-6">
      {/* Hero Header */}
      <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-4 border-b border-white/10 pb-5">
        <div className="flex items-center gap-3">
          <span className="flex h-10 w-10 sm:h-12 sm:w-12 shrink-0 items-center justify-center rounded-2xl bg-teal-500/15 text-teal-400 border border-teal-500/25">
            <Wind className="h-5 w-5 sm:h-6 sm:w-6" />
          </span>
          <div>
            <h1 className="text-2xl sm:text-3xl lg:text-4xl font-black text-white tracking-tight">
              WingFoil Racing
            </h1>
          </div>
        </div>

        {/* View mode tabs */}
        <div className="flex items-center gap-1.5 rounded-xl bg-white/[0.03] border border-white/10 p-1 self-start lg:self-auto overflow-x-auto max-w-full">
          <button
            type="button"
            onClick={() => setActiveTab("series")}
            className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-colors flex items-center gap-1.5 shrink-0 ${
              activeTab === "series"
                ? "bg-amber-500 text-slate-950 shadow-sm font-black"
                : "text-slate-400 hover:text-white"
            }`}
          >
            <Trophy className="h-3.5 w-3.5" />
            Overall Championship
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("results")}
            className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-colors shrink-0 ${
              activeTab === "results"
                ? "bg-teal-500 text-slate-950 shadow-sm"
                : "text-slate-400 hover:text-white"
            }`}
          >
            Regatta Standings
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("calendar")}
            className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-colors shrink-0 ${
              activeTab === "calendar"
                ? "bg-teal-500 text-slate-950 shadow-sm"
                : "text-slate-400 hover:text-white"
            }`}
          >
            Singapore Series
          </button>
        </div>
      </div>

      {/* TAB 0: Overall Series Championship */}
      {activeTab === "series" && (
        <WingfoilSeriesView
          regattas={publishedRegattas}
          onSelectRound={(roundId) => {
            setSelectedRegattaId(roundId);
            setActiveTab("results");
          }}
        />
      )}

      {/* TAB 1: Regatta Results & Scorecard */}
      {activeTab === "results" && (
        <div className="space-y-4">
          {/* Series Link Banner */}
          {activeRegatta.seriesName && (
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 bg-amber-500/10 border border-amber-500/20 rounded-2xl px-4 py-2.5 text-xs">
              <span className="text-amber-200">
                Part of the <strong className="text-white">{activeRegatta.seriesName}</strong> ({activeRegatta.seriesPart || "Round of 3"}).
              </span>
              <button
                type="button"
                onClick={() => setActiveTab("series")}
                className="inline-flex items-center gap-1 font-bold text-amber-400 hover:text-amber-300 shrink-0"
              >
                <Trophy className="h-3.5 w-3.5" /> View Overall Series Leaderboard →
              </button>
            </div>
          )}

          {/* Controls row */}
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-[#0c0d14] rounded-xl border border-white/10 p-3">
            <div className="flex flex-wrap items-center gap-2">
              <label className="text-xs font-semibold text-slate-400 shrink-0">
                Regatta:
              </label>
              <select
                value={selectedRegattaId}
                onChange={(e) => {
                  if (e.target.value === "overall-series") {
                    setActiveTab("series");
                  } else {
                    setSelectedRegattaId(e.target.value);
                  }
                }}
                className="rounded-lg bg-slate-900 border border-white/10 px-3 py-1.5 text-xs font-bold text-white focus:outline-none focus:border-teal-500"
              >
                <option value="overall-series">
                  🏆 2026 NE Monsoon Series (Overall Championship)
                </option>
                {publishedRegattas.map((r) => (
                  <option key={r.id} value={r.id}>
                    {r.shortName} · {r.dates} {r.results && r.results.length > 0 ? "✓" : "(Upcoming)"}
                  </option>
                ))}
              </select>
            </div>

            <div className="flex items-center gap-2">
              <label className="text-xs font-semibold text-slate-400 shrink-0">
                Gender:
              </label>
              <select
                value={genderFilter}
                onChange={(e) => setGenderFilter(e.target.value as "all" | "M" | "F")}
                className="rounded-lg bg-slate-900 border border-white/10 px-2.5 py-1.5 text-xs font-semibold text-white focus:outline-none focus:border-teal-500"
              >
                <option value="all">All competitors</option>
                <option value="F">Female only</option>
                <option value="M">Male only</option>
              </select>
            </div>
          </div>

          {/* Regatta Summary Card */}
          <div className="rounded-xl border border-white/10 bg-[#131520] p-4 flex flex-col md:flex-row md:items-center justify-between gap-4">
            <div className="space-y-1">
              <div className="flex items-center gap-2 flex-wrap">
                <span className="text-[10px] font-black uppercase tracking-wider text-teal-400 bg-teal-500/10 px-2 py-0.5 rounded border border-teal-500/20">
                  {activeRegatta.format}
                </span>
                {activeRegatta.seriesPart && (
                  <span className="text-[10px] font-bold text-amber-400 bg-amber-500/10 px-2 py-0.5 rounded border border-amber-500/20">
                    {activeRegatta.seriesPart}
                  </span>
                )}
                <span className="text-xs font-bold text-slate-300">
                  {activeRegatta.name}
                </span>
              </div>
              <div className="flex items-center gap-4 text-xs text-slate-400 pt-1">
                <span className="flex items-center gap-1">
                  <Calendar className="h-3.5 w-3.5 text-slate-500" />
                  {activeRegatta.dates}
                </span>
                <span className="flex items-center gap-1">
                  <MapPin className="h-3.5 w-3.5 text-slate-500" />
                  {activeRegatta.venue}
                </span>
              </div>
            </div>
            <div className="text-xs text-slate-400 md:text-right border-t md:border-t-0 pt-2 md:pt-0 border-white/5 shrink-0">
              <p className="font-semibold text-slate-300">Organized by {activeRegatta.organizer}</p>
              <p className="text-[11px] text-teal-400 font-mono mt-0.5">{activeRegatta.scoringSystem}</p>
            </div>
          </div>

          {/* Results Table - Desktop */}
          {(() => {
            const maxRaces = Math.max(
              displayResults.reduce((max, r) => Math.max(max, r.races?.length || 0), 0),
              activeRegatta.results?.reduce((max, r) => Math.max(max, r.races?.length || 0), 0) || 0,
              9
            );

            return (
              <div className="hidden md:block rounded-xl border border-white/10 bg-[#0c0d14] overflow-hidden">
                <div className="overflow-x-auto">
                  <table className="w-full text-left text-xs">
                    <thead className="bg-white/[0.02] border-b border-white/10 text-[10px] uppercase tracking-wider text-slate-400 font-bold">
                      <tr>
                        <th className="px-4 py-3 w-12 text-center">Rank</th>
                        <th className="px-4 py-3 min-w-[12rem]">Racer / Sailor</th>
                        <th className="px-2 py-3 text-center">Sail #</th>
                        <th className="px-2 py-3 text-center">Gender</th>
                        <th className="px-3 py-3 min-w-[10rem]">School &amp; Club</th>
                        {Array.from({ length: maxRaces }).map((_, i) => (
                          <th key={i} className="px-2 py-3 text-center w-9">
                            R{i + 1}
                          </th>
                        ))}
                        <th className="px-3 py-3 text-right">Gross</th>
                        <th className="px-4 py-3 text-right font-black text-teal-300">Nett</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-white/5 font-sans">
                      {displayResults.map((racer) => (
                        <tr key={racer.rank + racer.name} className="hover:bg-white/[0.02] transition-colors">
                          <td className="px-4 py-3 text-center">
                            <RankMedalBadge
                              rank={racer.rank}
                              nonPodiumClassName="font-mono font-bold text-teal-400"
                            />
                          </td>
                          <td className="px-4 py-3">
                            <p className="font-bold text-white">{racer.name}</p>
                            <p className="text-[10px] text-slate-500">{racer.ageCategory}</p>
                          </td>
                          <td className="px-2 py-3 text-center font-mono text-slate-300">
                            {racer.sailNumber}
                          </td>
                          <td className="px-2 py-3 text-center font-semibold text-slate-400">
                            {racer.gender}
                          </td>
                          <td className="px-3 py-3 min-w-[10rem]">
                            <p className="text-slate-300 font-medium truncate">{racer.club}</p>
                            <p className="text-[10px] text-slate-500 truncate">{racer.schoolName}</p>
                          </td>
                          {racer.races.map((r, i) => (
                            <td
                              key={i}
                              className={`px-2 py-3 text-center font-mono text-xs ${
                                r.isDiscarded
                                  ? "line-through text-slate-600 bg-white/[0.01]"
                                  : r.score === 1
                                    ? "font-black text-amber-300 bg-amber-500/10"
                                    : r.score <= 3
                                      ? "font-bold text-teal-200"
                                      : "text-slate-400"
                              }`}
                              title={r.code ? `Race ${i + 1}: ${r.code} (${r.score} pts)` : undefined}
                            >
                              {r.code && r.score !== 1 ? `${r.score}${r.code}` : r.score}
                            </td>
                          ))}
                          <td className="px-3 py-3 text-right font-mono text-slate-400">
                            {racer.grossScore}
                          </td>
                          <td className="px-4 py-3 text-right font-mono font-black text-sm text-teal-300">
                            {racer.nettScore}
                          </td>
                        </tr>
                      ))}
                      {displayResults.length === 0 && (
                        <tr>
                          <td colSpan={maxRaces + 7} className="px-4 py-12 text-center text-slate-400">
                            {activeRegatta.status === "Upcoming" ? (
                              <div className="space-y-1.5 max-w-sm mx-auto">
                                <p className="text-sm font-bold text-white">Upcoming Round</p>
                                <p className="text-xs text-slate-400">{activeRegatta.rulesNotes}</p>
                                <p className="text-[11px] text-teal-400 font-mono pt-1">Scheduled dates: {activeRegatta.dates}</p>
                              </div>
                            ) : (
                              "No competitors match the selected filter."
                            )}
                          </td>
                        </tr>
                      )}
                    </tbody>
                  </table>
                </div>
                <div className="border-t border-white/5 px-4 py-2 text-[10px] text-slate-500 flex items-center justify-between">
                  <span>Scoring: Low points win. {activeRegatta.scoringSystem || "Discards applied after 4+ races."}</span>
                  <span>RDG = Redress · DNF = Did Not Finish · DSQ = Disqualified · DNC = Did Not Compete</span>
                </div>
              </div>
            );
          })()}

          {/* Results Cards - Mobile */}
          <div className="md:hidden space-y-2.5">
            {displayResults.map((racer) => (
              <div
                key={racer.rank + racer.name}
                className="rounded-xl border border-white/10 bg-[#131520] p-3 space-y-2.5"
              >
                <div className="flex items-start justify-between gap-2">
                  <div className="flex items-center gap-2">
                    <RankMedalBadge
                      rank={racer.rank}
                      className="h-7 w-7 text-xs"
                      nonPodiumClassName="flex h-7 w-7 shrink-0 items-center justify-center rounded-lg bg-teal-500/15 text-teal-400 font-mono font-bold text-xs border border-teal-500/30"
                    />
                    <div>
                      <p className="font-bold text-white text-sm leading-tight">
                        {racer.name}
                      </p>
                      <p className="text-[10px] text-slate-400 mt-0.5">
                        Sail #{racer.sailNumber} · {racer.gender === "M" ? "Male" : "Female"} · {racer.ageCategory}
                      </p>
                    </div>
                  </div>
                  <div className="text-right">
                    <span className="text-[9px] uppercase font-bold text-slate-500 tracking-wider">
                      Nett
                    </span>
                    <p className="font-black text-teal-300 text-base leading-none">
                      {racer.nettScore} <span className="text-[10px] text-slate-500 font-normal">pts</span>
                    </p>
                  </div>
                </div>

                <div className="text-[11px] text-slate-400 bg-white/[0.02] rounded-lg px-2.5 py-1.5 border border-white/5">
                  <p className="font-medium text-slate-300 truncate">{racer.club}</p>
                  <p className="text-[10px] text-slate-500 truncate">{racer.schoolName}</p>
                </div>

                {/* Heat Finishes Strip */}
                <div>
                  <div className="flex items-center justify-between text-[9px] text-slate-500 font-bold uppercase mb-1">
                    <span>Heats R1–R{racer.races.length}</span>
                    <span>Gross: {racer.grossScore}</span>
                  </div>
                  <div className="flex flex-wrap gap-1 text-center font-mono">
                    {racer.races.map((r, i) => (
                      <div
                        key={i}
                        className={`min-w-[2rem] flex-1 rounded py-1 px-1 text-[10px] border ${
                          r.isDiscarded
                            ? "bg-slate-900 border-white/5 text-slate-600 line-through"
                            : r.score === 1
                              ? "bg-amber-500/20 border-amber-500/40 text-amber-300 font-bold"
                              : r.score <= 3
                                ? "bg-teal-500/15 border-teal-500/30 text-teal-200 font-semibold"
                                : "bg-white/5 border-white/5 text-slate-300"
                        }`}
                      >
                        <p className="text-[7px] text-slate-500 font-sans leading-none mb-0.5">
                          R{i + 1}
                        </p>
                        <p className="leading-tight font-black">
                          {r.score}
                        </p>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            ))}

            {displayResults.length === 0 && (
              <div className="rounded-xl border border-white/10 bg-[#131520] p-6 text-center text-slate-400">
                {activeRegatta.status === "Upcoming" ? (
                  <div className="space-y-1.5 max-w-sm mx-auto">
                    <p className="text-sm font-bold text-white">Upcoming Round</p>
                    <p className="text-xs text-slate-400">{activeRegatta.rulesNotes}</p>
                    <p className="text-[11px] text-teal-400 font-mono pt-1">Scheduled dates: {activeRegatta.dates}</p>
                  </div>
                ) : (
                  "No competitors match the selected filter."
                )}
              </div>
            )}
          </div>
        </div>
      )}

      {/* TAB 2: Singapore Regatta Series */}
      {activeTab === "calendar" && (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {publishedRegattas.map((reg) => (
            <div
              key={reg.id}
              className="rounded-xl border border-white/10 bg-[#131520] p-5 flex flex-col justify-between gap-4"
            >
              <div className="space-y-2">
                <div className="flex items-center justify-between gap-2">
                  <span className="text-[10px] font-black uppercase tracking-wider text-teal-400 bg-teal-500/15 px-2 py-0.5 rounded border border-teal-500/30">
                    {reg.format}
                  </span>
                  <span className="text-xs font-semibold text-slate-400">
                    {reg.status}
                  </span>
                </div>
                <h3 className="text-base font-bold text-white">{reg.name}</h3>
                <div className="space-y-1 text-xs text-slate-400 pt-1">
                  <p className="flex items-center gap-1.5">
                    <Calendar className="h-3.5 w-3.5 text-slate-500" />
                    {reg.dates}
                  </p>
                  <p className="flex items-center gap-1.5">
                    <MapPin className="h-3.5 w-3.5 text-slate-500" />
                    {reg.venue}
                  </p>
                </div>
                <p className="text-xs text-slate-400 leading-relaxed pt-2">
                  {reg.rulesNotes}
                </p>
              </div>

              <div className="pt-3 border-t border-white/5 flex items-center justify-between">
                <span className="text-[11px] text-slate-500">{reg.organizer}</span>
                {reg.results && (
                  <button
                    type="button"
                    onClick={() => {
                      setSelectedRegattaId(reg.id);
                      setActiveTab("results");
                    }}
                    className="inline-flex items-center gap-1 text-xs font-bold text-teal-300 hover:text-teal-200"
                  >
                    View results <ChevronRight className="h-3.5 w-3.5" />
                  </button>
                )}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
