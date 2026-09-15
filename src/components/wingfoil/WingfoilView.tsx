"use client";

import { useState, useMemo, useEffect } from "react";
import {
  Wind,
  Calendar,
  MapPin,
  Trophy,
} from "lucide-react";
import {
  SINGAPORE_WINGFOIL_REGATTAS,
  loadWingfoilRegattas,
  fetchServerWingfoilRegattas,
  sortWingfoilRegattas,
  normalizeWingfoilCategory,
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
      ? sortWingfoilRegattas(initialRegattas)
      : sortWingfoilRegattas(SINGAPORE_WINGFOIL_REGATTAS)
  );
  const [selectedRegattaId, setSelectedRegattaId] = useState<string>(() => {
    const list = sortWingfoilRegattas(
      initialRegattas && initialRegattas.length > 0
        ? initialRegattas
        : SINGAPORE_WINGFOIL_REGATTAS
    );
    const withResults = list.find((r) => r.results && r.results.length > 0);
    return withResults ? withResults.id : list[0]?.id || SINGAPORE_WINGFOIL_REGATTAS[0].id;
  });
  const [genderFilter, setGenderFilter] = useState<"all" | "M" | "F">("all");
  const [activeTab, setActiveTab] = useState<"series" | "results">("series");

  // Re-hydrate from persistent storage and sync with server on mount
  useEffect(() => {
    let cancelled = false;
    const hydrate = async () => {
      const loaded = loadWingfoilRegattas();
      await Promise.resolve();
      if (cancelled) return;
      if (!initialRegattas && loaded.length > 0) {
        setRegattas(loaded);
      }

      const serverData = await fetchServerWingfoilRegattas();
      if (cancelled) return;
      if (serverData && serverData.length > 0) {
        setRegattas(serverData);
      }
    };

    void hydrate();
    return () => {
      cancelled = true;
    };
  }, [initialRegattas]);

  // Public showcase only queries and displays verified, published regattas (latest first)
  const publishedRegattas = useMemo(() => {
    return sortWingfoilRegattas(
      regattas.filter(
        (r) => !r.lifecycleStatus || r.lifecycleStatus === "published"
      )
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
      <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-4 border-b border-[var(--sp-cool-veil)] pb-5">
        <div className="flex items-center gap-3">
          <span className="flex h-10 w-10 sm:h-12 sm:w-12 shrink-0 items-center justify-center rounded-2xl bg-[var(--sp-harbour-teal)]/15 text-[var(--sp-harbour-teal)] border border-[var(--sp-harbour-teal)]/25">
            <Wind className="h-5 w-5 sm:h-6 sm:w-6" />
          </span>
          <div>
            <h1 className="text-2xl sm:text-3xl lg:text-4xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
              WingFoil Racing
            </h1>
          </div>
        </div>

        {/* View mode tabs */}
        <div className="flex items-center gap-1.5 rounded-xl bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] p-1 self-start lg:self-auto overflow-x-auto max-w-full shadow-xs">
          <button
            type="button"
            onClick={() => setActiveTab("series")}
            className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-colors flex items-center gap-1.5 shrink-0 ${
              activeTab === "series"
                ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs font-black"
                : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
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
                ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs font-black"
                : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
            }`}
          >
            Regatta Standings
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
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 bg-amber-50/80 border border-amber-200 rounded-2xl px-4 py-2.5 text-xs text-amber-900">
              <span>
                Part of the <strong className="text-amber-950 font-bold">{activeRegatta.seriesName}</strong> ({activeRegatta.seriesPart || "Round of 3"}).
              </span>
              <button
                type="button"
                onClick={() => setActiveTab("series")}
                className="inline-flex items-center gap-1 font-bold text-amber-800 hover:text-amber-950 shrink-0"
              >
                <Trophy className="h-3.5 w-3.5" /> View Overall Series Leaderboard →
              </button>
            </div>
          )}

          {/* Controls row */}
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-[var(--sp-warm-white)] rounded-xl border border-[var(--sp-cool-veil)] p-3 shadow-xs">
            <div className="flex flex-wrap items-center gap-2">
              <label className="text-xs font-semibold text-[var(--sp-slate-soft)] shrink-0">
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
                className="rounded-lg bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-3 py-1.5 text-xs font-bold text-[var(--sp-harbour-shadow)] focus:outline-none focus:border-[var(--sp-harbour-teal)]"
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

            {/* Gender Filter */}
            <div className="flex items-center gap-1 bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] rounded-xl p-1 shrink-0 self-start sm:self-auto">
              {(["all", "M", "F"] as const).map((g) => (
                <button
                  key={g}
                  type="button"
                  onClick={() => setGenderFilter(g)}
                  className={`px-2.5 py-1 rounded-lg text-xs font-bold transition-all ${
                    genderFilter === g
                      ? "bg-[var(--sp-harbour-teal)] text-white font-black shadow-xs"
                      : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
                  }`}
                >
                  {g === "all" ? "All" : g === "M" ? "Men / Boys" : "Women / Girls"}
                </button>
              ))}
            </div>
          </div>

          {/* Regatta Summary Card */}
          <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 flex flex-col md:flex-row md:items-center justify-between gap-4 shadow-xs">
            <div className="space-y-1">
              <div className="flex items-center gap-2 flex-wrap">
                <span className="text-[10px] font-black uppercase tracking-wider text-[var(--sp-harbour-teal)] bg-[var(--sp-harbour-teal)]/10 px-2 py-0.5 rounded border border-[var(--sp-harbour-teal)]/20">
                  {activeRegatta.format}
                </span>
                {activeRegatta.seriesPart && (
                  <span className="text-[10px] font-bold text-amber-800 bg-amber-100 px-2 py-0.5 rounded border border-amber-200">
                    {activeRegatta.seriesPart}
                  </span>
                )}
                <span className="text-xs font-bold text-[var(--sp-harbour-shadow)]">
                  {activeRegatta.name}
                </span>
              </div>
              <div className="flex items-center gap-4 text-xs text-[var(--sp-charcoal-slate)] pt-1">
                <span className="flex items-center gap-1">
                  <Calendar className="h-3.5 w-3.5 text-[var(--sp-slate-soft)]" />
                  {activeRegatta.dates}
                </span>
                <span className="flex items-center gap-1">
                  <MapPin className="h-3.5 w-3.5 text-[var(--sp-slate-soft)]" />
                  {activeRegatta.venue}
                </span>
              </div>
            </div>
            <div className="text-xs text-[var(--sp-charcoal-slate)] md:text-right border-t md:border-t-0 pt-2 md:pt-0 border-[var(--sp-cool-veil)] shrink-0">
              <p className="font-semibold text-[var(--sp-harbour-shadow)]">Organized by {activeRegatta.organizer}</p>
              <p className="text-[11px] text-[var(--sp-harbour-teal)] font-mono mt-0.5">{activeRegatta.scoringSystem}</p>
            </div>
          </div>

          {/* Results Table - Desktop */}
          {(() => {
            const maxRaces = Math.max(
              displayResults.reduce((max, r) => Math.max(max, r.races?.length || 0), 0),
              activeRegatta.results?.reduce((max, r) => Math.max(max, r.races?.length || 0), 0) || 0
            );

            return (
              <div className="hidden md:block rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] overflow-hidden shadow-xs">
                <div className="overflow-x-auto">
                  <table className="w-full text-left text-xs">
                    <thead className="bg-[var(--sp-sailcloth)] border-b border-[var(--sp-cool-veil)] text-[10px] uppercase tracking-wider text-[var(--sp-slate-soft)] font-bold">
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
                        <th className="px-4 py-3 text-right font-black text-[var(--sp-harbour-shadow)]">Nett</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-[var(--sp-cool-veil)] font-sans">
                      {displayResults.map((racer) => (
                        <tr key={racer.rank + racer.name} className="hover:bg-[var(--sp-sailcloth)]/50 transition-colors">
                          <td className="px-4 py-3 text-center">
                            <RankMedalBadge
                              rank={racer.rank}
                              nonPodiumClassName="font-mono font-bold text-[var(--sp-harbour-teal)]"
                            />
                          </td>
                          <td className="px-4 py-3">
                            <p className="font-bold text-[var(--sp-harbour-shadow)]">{racer.name}</p>
                            <p className="text-[10px] text-[var(--sp-slate-soft)]">{normalizeWingfoilCategory(racer.ageCategory)}</p>
                          </td>
                          <td className="px-2 py-3 text-center font-mono text-[var(--sp-charcoal-slate)]">
                            {racer.sailNumber}
                          </td>
                          <td className="px-2 py-3 text-center font-semibold text-[var(--sp-slate-soft)]">
                            {racer.gender}
                          </td>
                          <td className="px-3 py-3 min-w-[10rem]">
                            <p className="text-[var(--sp-charcoal-slate)] font-medium truncate">{racer.club}</p>
                            <p className="text-[10px] text-[var(--sp-slate-soft)] truncate">{racer.schoolName}</p>
                          </td>
                          {Array.from({ length: maxRaces }).map((_, i) => {
                            const r = racer.races[i];
                            if (!r) {
                              return (
                                <td key={i} className="px-2 py-3 text-center text-[var(--sp-slate-soft)]/40">
                                  —
                                </td>
                              );
                            }
                            return (
                              <td
                                key={i}
                                className={`px-2 py-3 text-center font-mono text-xs ${
                                  r.isDiscarded
                                    ? "line-through text-[var(--sp-slate-soft)] bg-[var(--sp-sailcloth)]/30"
                                    : r.score === 1
                                      ? "font-black text-amber-900 bg-amber-100"
                                      : r.score <= 3
                                        ? "font-bold text-[var(--sp-harbour-teal)] bg-[var(--sp-harbour-teal)]/10"
                                        : "text-[var(--sp-charcoal-slate)]"
                                }`}
                                title={r.code ? `Race ${i + 1}: ${r.code} (${r.score} pts)` : undefined}
                              >
                                {r.code && r.score !== 1 ? `${r.score}${r.code}` : r.score}
                              </td>
                            );
                          })}
                          <td className="px-3 py-3 text-right font-mono text-[var(--sp-slate-soft)]">
                            {racer.grossScore}
                          </td>
                          <td className="px-4 py-3 text-right font-mono font-black text-sm text-[var(--sp-harbour-shadow)]">
                            {racer.nettScore}
                          </td>
                        </tr>
                      ))}
                      {displayResults.length === 0 && (
                        <tr>
                          <td colSpan={maxRaces + 7} className="px-4 py-12 text-center text-[var(--sp-slate-soft)]">
                            {activeRegatta.status === "Upcoming" ? (
                              <div className="space-y-1.5 max-w-sm mx-auto">
                                <p className="text-sm font-bold text-[var(--sp-harbour-shadow)]">Upcoming Round</p>
                                <p className="text-xs text-[var(--sp-charcoal-slate)]">{activeRegatta.rulesNotes}</p>
                                <p className="text-[11px] text-[var(--sp-harbour-teal)] font-mono pt-1">Scheduled dates: {activeRegatta.dates}</p>
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
                <div className="border-t border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/40 px-4 py-2 text-[10px] text-[var(--sp-slate-soft)] flex items-center justify-between">
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
                className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-3 space-y-2.5 shadow-2xs"
              >
                <div className="flex items-start justify-between gap-2">
                  <div className="flex items-center gap-2">
                    <RankMedalBadge
                      rank={racer.rank}
                      className="h-7 w-7 text-xs"
                      nonPodiumClassName="flex h-7 w-7 shrink-0 items-center justify-center rounded-lg bg-[var(--sp-harbour-teal)]/15 text-[var(--sp-harbour-teal)] font-mono font-bold text-xs border border-[var(--sp-harbour-teal)]/30"
                    />
                    <div>
                      <p className="font-bold text-[var(--sp-harbour-shadow)] text-sm leading-tight">
                        {racer.name}
                      </p>
                      <p className="text-[10px] text-[var(--sp-slate-soft)] mt-0.5">
                        Sail #{racer.sailNumber} · {racer.gender === "M" ? "Male" : "Female"} · {normalizeWingfoilCategory(racer.ageCategory)}
                      </p>
                    </div>
                  </div>
                  <div className="text-right">
                    <span className="text-[9px] uppercase font-bold text-[var(--sp-slate-soft)] tracking-wider">
                      Nett
                    </span>
                    <p className="font-black text-[var(--sp-harbour-shadow)] text-base leading-none">
                      {racer.nettScore} <span className="text-[10px] text-[var(--sp-slate-soft)] font-normal">pts</span>
                    </p>
                  </div>
                </div>

                <div className="text-[11px] text-[var(--sp-charcoal-slate)] bg-[var(--sp-sailcloth)] rounded-lg px-2.5 py-1.5 border border-[var(--sp-cool-veil)]">
                  <p className="font-medium text-[var(--sp-charcoal-slate)] truncate">{racer.club}</p>
                  <p className="text-[10px] text-[var(--sp-slate-soft)] truncate">{racer.schoolName}</p>
                </div>

                {/* Heat Finishes Strip */}
                <div>
                  <div className="flex items-center justify-between text-[9px] text-[var(--sp-slate-soft)] font-bold uppercase mb-1">
                    <span>Heats R1–R{racer.races.length}</span>
                    <span>Gross: {racer.grossScore}</span>
                  </div>
                  <div className="flex flex-wrap gap-1 text-center font-mono">
                    {racer.races.map((r, i) => (
                      <div
                        key={i}
                        className={`min-w-[2rem] flex-1 rounded py-1 px-1 text-[10px] border ${
                          r.isDiscarded
                            ? "bg-[var(--sp-sailcloth)] border-[var(--sp-cool-veil)] text-[var(--sp-slate-soft)] line-through"
                            : r.score === 1
                              ? "bg-amber-100 border-amber-300 text-amber-900 font-bold"
                              : r.score <= 3
                                ? "bg-[var(--sp-harbour-teal)]/15 border-[var(--sp-harbour-teal)]/30 text-[var(--sp-harbour-teal)] font-semibold"
                                : "bg-[var(--sp-warm-white)] border-[var(--sp-cool-veil)] text-[var(--sp-charcoal-slate)]"
                        }`}
                      >
                        <p className="text-[7px] text-[var(--sp-slate-soft)] font-sans leading-none mb-0.5">
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
              <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-6 text-center text-[var(--sp-slate-soft)] shadow-xs">
                {activeRegatta.status === "Upcoming" ? (
                  <div className="space-y-1.5 max-w-sm mx-auto">
                    <p className="text-sm font-bold text-[var(--sp-harbour-shadow)]">Upcoming Round</p>
                    <p className="text-xs text-[var(--sp-charcoal-slate)]">{activeRegatta.rulesNotes}</p>
                    <p className="text-[11px] text-[var(--sp-harbour-teal)] font-mono pt-1">Scheduled dates: {activeRegatta.dates}</p>
                  </div>
                ) : (
                  "No competitors match the selected filter."
                )}
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
}
