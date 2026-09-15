"use client";

import { useState, useMemo, useEffect } from "react";
import {
  Wind,
  Calendar,
  MapPin,
  Trophy,
  ExternalLink,
  Sparkles,
  Layers,
  FileText,
  Compass,
} from "lucide-react";
import {
  SINGAPORE_TECHNO293_REGATTAS,
  loadTechno293Regattas,
  fetchServerTechno293Regattas,
  sortTechno293Regattas,
  TECHNO293_SPECIFICATIONS,
  type Techno293Regatta,
} from "@/lib/techno293";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";
import { Techno293SeriesView } from "./Techno293SeriesView";

export function Techno293View({
  initialRegattas,
}: {
  initialRegattas?: Techno293Regatta[];
} = {}) {
  const [regattas, setRegattas] = useState<Techno293Regatta[]>(
    initialRegattas && initialRegattas.length > 0
      ? sortTechno293Regattas(initialRegattas)
      : sortTechno293Regattas(SINGAPORE_TECHNO293_REGATTAS)
  );

  const [selectedRegattaId, setSelectedRegattaId] = useState<string>(() => {
    const list = sortTechno293Regattas(
      initialRegattas && initialRegattas.length > 0
        ? initialRegattas
        : SINGAPORE_TECHNO293_REGATTAS
    );
    const withResults = list.find((r) => r.results && r.results.length > 0);
    return withResults ? withResults.id : list[0]?.id || SINGAPORE_TECHNO293_REGATTAS[0].id;
  });

  const [genderFilter, setGenderFilter] = useState<"all" | "M" | "F">("all");
  const [activeTab, setActiveTab] = useState<
    "series" | "results" | "specs"
  >("series");

  useEffect(() => {
    let cancelled = false;
    const hydrate = async () => {
      const loaded = loadTechno293Regattas();
      await Promise.resolve();
      if (cancelled) return;
      if (!initialRegattas && loaded.length > 0) {
        setRegattas(loaded);
      }

      const serverData = await fetchServerTechno293Regattas();
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

  const publishedRegattas = useMemo(() => {
    return sortTechno293Regattas(
      regattas.filter(
        (r) => !r.lifecycleStatus || r.lifecycleStatus === "published"
      )
    );
  }, [regattas]);

  const activeRegatta = useMemo(
    () =>
      publishedRegattas.find((r) => r.id === selectedRegattaId) ||
      publishedRegattas[0] ||
      SINGAPORE_TECHNO293_REGATTAS[0],
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

  const maxRacesInActive = useMemo(() => {
    if (!activeRegatta.results || activeRegatta.results.length === 0) return 0;
    return Math.max(...activeRegatta.results.map((r) => r.races.length), 0);
  }, [activeRegatta]);

  return (
    <div className="mx-auto w-full max-w-7xl min-w-0 px-3 sm:px-6 lg:px-8 pt-4 pb-8 sm:pt-6 sm:pb-10 space-y-5 sm:space-y-6">
      {/* Hero Header */}
      <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-4 border-b border-[var(--sp-cool-veil)] pb-5">
        <div className="flex items-center gap-3">
          <span className="flex h-10 w-10 sm:h-12 sm:w-12 shrink-0 items-center justify-center rounded-2xl bg-[var(--sp-harbour-teal)]/15 text-[var(--sp-harbour-teal)] border border-[var(--sp-harbour-teal)]/25 shadow-xs">
            <Compass className="h-5 w-5 sm:h-6 sm:w-6" />
          </span>
          <div>
            <div className="flex items-center gap-2">
              <span className="text-xs font-bold uppercase tracking-widest text-[var(--sp-harbour-teal)]">
                World Sailing International Class
              </span>
              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[10px] font-bold bg-[var(--sp-harbour-teal)]/10 text-[var(--sp-harbour-teal)] border border-[var(--sp-harbour-teal)]/20">
                <Sparkles className="h-3 w-3" /> One Design
              </span>
            </div>
            <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
              Singapore Techno 293
            </h1>
          </div>
        </div>

        {/* View Tabs */}
        <div className="flex flex-wrap items-center gap-1.5 p-1 rounded-2xl bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] shrink-0 shadow-xs">
          <button
            type="button"
            onClick={() => setActiveTab("series")}
            className={`px-3 sm:px-4 py-2 rounded-xl text-xs font-bold transition-all flex items-center gap-1.5 ${
              activeTab === "series"
                ? "bg-[var(--sp-harbour-teal)] text-white font-black shadow-xs"
                : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)]"
            }`}
          >
            <Trophy className="h-3.5 w-3.5" />
            <span>Overall Championship</span>
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("results")}
            className={`px-3 sm:px-4 py-2 rounded-xl text-xs font-bold transition-all flex items-center gap-1.5 ${
              activeTab === "results"
                ? "bg-[var(--sp-harbour-teal)] text-white font-black shadow-xs"
                : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)]"
            }`}
          >
            <Layers className="h-3.5 w-3.5" />
            <span>Regatta Standings</span>
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("specs")}
            className={`px-3 sm:px-4 py-2 rounded-xl text-xs font-bold transition-all flex items-center gap-1.5 ${
              activeTab === "specs"
                ? "bg-[var(--sp-harbour-teal)] text-white font-black shadow-xs"
                : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)]"
            }`}
          >
            <FileText className="h-3.5 w-3.5" />
            <span>Class Specs</span>
          </button>
        </div>
      </div>

      {/* Tab 1: Overall Championship */}
      {activeTab === "series" && (
        <Techno293SeriesView
          regattas={publishedRegattas}
          onSelectRound={(roundId) => {
            setSelectedRegattaId(roundId);
            setActiveTab("results");
          }}
        />
      )}

      {/* Tab 2: Regatta Standings */}
      {activeTab === "results" && (
        <div className="space-y-6">
          {/* Regatta Selector */}
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] rounded-2xl p-3 sm:p-4 shadow-xs">
            <div className="flex items-center gap-3">
              <label className="text-xs font-bold uppercase tracking-wider text-[var(--sp-slate-soft)] shrink-0">
                Regatta:
              </label>
              <select
                value={selectedRegattaId}
                onChange={(e) => setSelectedRegattaId(e.target.value)}
                className="rounded-xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-3 py-1.5 text-xs font-bold text-[var(--sp-harbour-shadow)] focus:outline-none focus:border-[var(--sp-harbour-teal)]"
              >
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
                      ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                      : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
                  }`}
                >
                  {g === "all" ? "All" : g === "M" ? "Men / Boys" : "Women / Girls"}
                </button>
              ))}
            </div>
          </div>

          {/* Active Regatta Header */}
          <div className="bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] rounded-3xl p-5 sm:p-6 shadow-xs space-y-3">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2">
              <div>
                <span className="text-xs font-bold text-[var(--sp-harbour-teal)] uppercase tracking-wide">
                  {activeRegatta.seriesName || "Singapore Techno 293 Event"}
                </span>
                <h2 className="text-xl sm:text-2xl font-black text-[var(--sp-harbour-shadow)] mt-0.5">
                  {activeRegatta.name}
                </h2>
              </div>
              <span
                className={`self-start sm:self-auto px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider ${
                  activeRegatta.status === "Completed"
                    ? "bg-emerald-50 text-emerald-800 border border-emerald-200"
                    : "bg-blue-50 text-blue-800 border border-blue-200"
                }`}
              >
                {activeRegatta.status}
              </span>
            </div>

            <div className="flex flex-wrap items-center gap-4 text-xs text-[var(--sp-charcoal-slate)] pt-1">
              <div className="flex items-center gap-1.5">
                <Calendar className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)]" />
                <span>{activeRegatta.dates}</span>
              </div>
              <div className="flex items-center gap-1.5">
                <MapPin className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)]" />
                <span>{activeRegatta.venue}</span>
              </div>
              <div className="flex items-center gap-1.5">
                <Wind className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)]" />
                <span>Format: {activeRegatta.format}</span>
              </div>
              {activeRegatta.websiteUrl && (
                <a
                  href={activeRegatta.websiteUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex items-center gap-1 text-[var(--sp-harbour-teal)] hover:underline"
                >
                  <ExternalLink className="h-3.5 w-3.5" />
                  <span>Official Notice Board</span>
                </a>
              )}
            </div>

            {activeRegatta.rulesNotes && (
              <p className="text-xs text-[var(--sp-slate-soft)] pt-2 border-t border-[var(--sp-cool-veil)]">
                {activeRegatta.rulesNotes}
              </p>
            )}
          </div>

          {/* Regatta Scorecard Table */}
          {displayResults.length === 0 ? (
            <div className="p-8 text-center rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs">
              <Calendar className="h-8 w-8 text-[var(--sp-slate-soft)] mx-auto mb-2" />
              <div className="text-base font-bold text-[var(--sp-harbour-shadow)]">
                Standings will be published following the conclusion of racing.
              </div>
              <p className="text-xs text-[var(--sp-slate-soft)] mt-1 max-w-md mx-auto">
                {activeRegatta.name} is scheduled for {activeRegatta.dates} at {activeRegatta.venue}.
              </p>
            </div>
          ) : (
            <div className="overflow-hidden rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs">
              <div className="overflow-x-auto">
                <table className="w-full text-left text-xs border-collapse">
                  <thead>
                    <tr className="border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] text-[var(--sp-slate-soft)] uppercase tracking-wider font-semibold text-[11px]">
                      <th className="py-3 px-3 sm:px-4 w-12 text-center">Rank</th>
                      <th className="py-3 px-3 sm:px-4">Sailor</th>
                      <th className="py-3 px-2 sm:px-3 text-center">Sail #</th>
                      <th className="py-3 px-2 sm:px-3 text-center">Division</th>
                      {Array.from({ length: maxRacesInActive }).map((_, i) => (
                        <th
                          key={i}
                          className="py-3 px-2 text-center font-bold text-[var(--sp-harbour-shadow)]"
                        >
                          R{i + 1}
                        </th>
                      ))}
                      <th className="py-3 px-3 text-right text-[var(--sp-slate-soft)]">Gross</th>
                      <th className="py-3 px-4 text-right font-black text-[var(--sp-harbour-teal)]">
                        Nett
                      </th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-[var(--sp-cool-veil)] font-sans">
                    {displayResults.map((s) => (
                      <tr
                        key={s.name}
                        className="hover:bg-[var(--sp-sailcloth)]/50 transition-colors"
                      >
                        <td className="py-3.5 px-3 sm:px-4 text-center">
                          <div className="flex justify-center">
                            <RankMedalBadge rank={s.rank} />
                          </div>
                        </td>

                        <td className="py-3.5 px-3 sm:px-4">
                          <div className="font-bold text-[var(--sp-harbour-shadow)]">{s.name}</div>
                          {s.club && (
                            <div className="text-[11px] text-[var(--sp-slate-soft)]">
                              {s.club}
                            </div>
                          )}
                        </td>

                        <td className="py-3.5 px-2 sm:px-3 text-center font-mono font-medium text-[var(--sp-charcoal-slate)] tabular-nums">
                          {s.sailNumber || "—"}
                        </td>

                        <td className="py-3.5 px-2 sm:px-3 text-center">
                          <span className="px-2 py-0.5 rounded-md text-[10px] font-bold bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal-slate)] border border-[var(--sp-cool-veil)]">
                            {s.ageCategory || s.division || "Open"}
                          </span>
                        </td>

                        {Array.from({ length: maxRacesInActive }).map((_, i) => {
                          const r = s.races[i];
                          if (!r) {
                            return (
                              <td
                                key={i}
                                className="py-3.5 px-2 text-center text-[var(--sp-slate-soft)] font-mono tabular-nums"
                              >
                                —
                              </td>
                            );
                          }
                          return (
                            <td
                              key={i}
                              className={`py-3.5 px-2 text-center font-mono tabular-nums ${
                                r.isDiscarded
                                  ? "text-[var(--sp-slate-soft)] line-through bg-red-50 text-red-700/80"
                                  : "text-[var(--sp-charcoal-slate)] font-semibold"
                              }`}
                            >
                              {r.code ? `${r.score} ${r.code}` : r.score}
                            </td>
                          );
                        })}

                        <td className="py-3.5 px-3 text-right font-mono tabular-nums text-[var(--sp-slate-soft)]">
                          {s.grossScore}
                        </td>

                        <td className="py-3.5 px-4 text-right font-mono tabular-nums text-sm font-black text-[var(--sp-harbour-teal)]">
                          {s.nettScore}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}
        </div>
      )}

      {/* Tab 3: Class Specifications */}
      {activeTab === "specs" && (
        <div className="space-y-6">
          <div className="p-6 rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs space-y-4">
            <h2 className="text-xl font-black text-[var(--sp-harbour-shadow)]">
              Techno 293 One Design Class Overview
            </h2>
            <p className="text-sm text-[var(--sp-charcoal-slate)] leading-relaxed max-w-3xl">
              The Bic Techno 293 is the World Sailing recognized international youth windsurfing class and former Youth Olympic Games equipment. Known for its strict one-design hull and progressive rig sizes, the class offers close tactical racing from light wind pumping up to 30 knots.
            </p>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 pt-4 border-t border-[var(--sp-cool-veil)]">
              <div className="bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] rounded-2xl p-4 space-y-1">
                <div className="text-xs font-bold uppercase text-[var(--sp-harbour-teal)]">
                  Board Specifications
                </div>
                <div className="text-sm font-semibold text-[var(--sp-harbour-shadow)]">
                  {TECHNO293_SPECIFICATIONS.boardSpec}
                </div>
                <div className="text-xs text-[var(--sp-slate-soft)]">
                  {TECHNO293_SPECIFICATIONS.daggerboardFin}
                </div>
              </div>

              <div className="bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] rounded-2xl p-4 space-y-1">
                <div className="text-xs font-bold uppercase text-[var(--sp-harbour-teal)]">
                  Rig Categories
                </div>
                <div className="text-sm font-semibold text-[var(--sp-harbour-shadow)]">
                  {TECHNO293_SPECIFICATIONS.rigSizes}
                </div>
                <div className="text-xs text-[var(--sp-slate-soft)]">
                  Official World Sailing OD sail plans
                </div>
              </div>

              <div className="bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] rounded-2xl p-4 space-y-1">
                <div className="text-xs font-bold uppercase text-[var(--sp-harbour-teal)]">
                  Racing Format & Wind Limits
                </div>
                <div className="text-sm font-semibold text-[var(--sp-harbour-shadow)]">
                  {TECHNO293_SPECIFICATIONS.formatName}
                </div>
                <div className="text-xs text-[var(--sp-slate-soft)]">
                  {TECHNO293_SPECIFICATIONS.windLimit}
                </div>
              </div>

              <div className="bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] rounded-2xl p-4 space-y-1">
                <div className="text-xs font-bold uppercase text-[var(--sp-harbour-teal)]">
                  Scoring & Ranking Policy
                </div>
                <div className="text-sm font-semibold text-[var(--sp-harbour-shadow)]">
                  {TECHNO293_SPECIFICATIONS.scoringSystem}
                </div>
                <div className="text-xs text-[var(--sp-slate-soft)]">
                  {TECHNO293_SPECIFICATIONS.rankingPolicy}
                </div>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
