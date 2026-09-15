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
import {
  type WingfoilRegatta,
} from "@/lib/wingfoil";
import {
  calculateWingfoilSeries,
  OFFICIAL_WINGFOIL_DIVISIONS,
  isSailorInDivision,
  type WingfoilSeriesResult,
  type SeriesDivisionId,
  type WingfoilSeriesKey,
  WINGFOIL_SERIES_OPTIONS,
} from "@/lib/wingfoilSeries";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";

export function WingfoilSeriesView({
  regattas,
  initialSeriesKey = "ne-monsoon",
  onSelectRound,
}: {
  regattas: WingfoilRegatta[];
  initialSeriesKey?: WingfoilSeriesKey;
  onSelectRound?: (roundId: string) => void;
}) {
  const [selectedSeriesKey, setSelectedSeriesKey] =
    useState<WingfoilSeriesKey>(initialSeriesKey);

  const seriesMeta = useMemo(
    () =>
      WINGFOIL_SERIES_OPTIONS.find((s) => s.key === selectedSeriesKey) ||
      WINGFOIL_SERIES_OPTIONS[0],
    [selectedSeriesKey]
  );

  const series: WingfoilSeriesResult = useMemo(
    () => calculateWingfoilSeries(regattas, selectedSeriesKey),
    [regattas, selectedSeriesKey]
  );

  const [divisionFilter, setDivisionFilter] = useState<string>("all");
  const [searchQuery, setSearchQuery] = useState<string>("");
  const [expandedSailor, setExpandedSailor] = useState<string | null>(null);

  const activeDivision = useMemo(() => {
    if (divisionFilter === "all") return null;
    return series.divisions.find((d) => d.division.id === divisionFilter) || null;
  }, [series.divisions, divisionFilter]);

  const roundsWithRaces = useMemo(
    () => series.rounds.filter((rnd) => rnd.raceCount > 0),
    [series.rounds]
  );

  const filteredCompetitors = useMemo(() => {
    let list = series.competitors;

    if (divisionFilter !== "all") {
      list = list.filter((c) =>
        isSailorInDivision(c, divisionFilter as SeriesDivisionId)
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
      {/* Series Selection Toggle & Official Links */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
        <div className="flex flex-wrap items-center gap-2 p-1.5 rounded-2xl bg-white/[0.04] border border-white/10">
          {WINGFOIL_SERIES_OPTIONS.map((opt) => {
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
                    ? "bg-amber-500 text-slate-950 font-black shadow-lg shadow-amber-500/10"
                    : "text-slate-400 hover:text-white hover:bg-white/5"
                }`}
              >
                <Trophy
                  className={`h-3.5 w-3.5 ${
                    isSelected ? "text-slate-950" : "text-amber-400"
                  }`}
                />
                <span>{opt.shortName}</span>
                <span
                  className={`text-[10px] px-1.5 py-0.2 rounded font-mono ${
                    isSelected
                      ? "bg-black/20 text-slate-900 font-bold"
                      : "bg-white/10 text-slate-400"
                  }`}
                >
                  {opt.season}
                </span>
              </button>
            );
          })}
        </div>

        {/* Official Links */}
        <div className="flex items-center gap-2 text-xs">
          {seriesMeta.websiteUrl && (
            <a
              href={seriesMeta.websiteUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-1.5 rounded-xl border border-teal-500/30 bg-teal-500/10 px-3 py-1.5 font-bold text-teal-300 hover:bg-teal-500/20 transition-colors"
            >
              <span>SSF Event Hub</span>
              <ExternalLink className="h-3.5 w-3.5" />
            </a>
          )}
          {seriesMeta.noticeBoardUrl && (
            <a
              href={seriesMeta.noticeBoardUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-1.5 rounded-xl border border-amber-500/30 bg-amber-500/10 px-3 py-1.5 font-bold text-amber-300 hover:bg-amber-500/20 transition-colors"
            >
              <span>Official Notice Board</span>
              <ExternalLink className="h-3.5 w-3.5" />
            </a>
          )}
        </div>
      </div>

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
                {selectedSeriesKey === "sw-monsoon"
                  ? "World Sailing RRS B8 & NoR 12"
                  : "World Sailing RRS App. A & NoR 12"}
              </span>
            </div>

            <h2 className="text-2xl sm:text-3xl lg:text-4xl font-black text-white tracking-tight">
              {series.seriesName}
            </h2>

            {seriesMeta.description ? (
              <p className="text-xs sm:text-sm text-slate-300 leading-relaxed">
                {seriesMeta.description}
              </p>
            ) : null}
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
                <CheckCircle2 className="h-3 w-3" />
                {series.totalRacesCompleted >= 6
                  ? "Valid Series (6+ min)"
                  : "Target: 6+ min"}
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
                Across {series.rounds.length} Rounds
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
                {rnd.raceCount > 0 ? `${rnd.raceCount} races` : rnd.dates || rnd.status}
              </span>
            </button>
          ))}
        </div>
      </div>

      {/* If 0 races have been completed, show the upcoming championship schedule & specifications */}
      {series.totalRacesCompleted === 0 ? (
        <div className="rounded-3xl border border-white/10 bg-[#12131c] p-6 sm:p-8 space-y-6">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-white/10 pb-5">
            <div>
              <div className="flex items-center gap-2 text-xs font-black uppercase tracking-wider text-amber-400">
                <Calendar className="h-4 w-4" />
                <span>Championship Schedule &amp; Race Structure</span>
              </div>
              <h3 className="text-xl sm:text-2xl font-black text-white mt-1">
                {series.seriesName}
              </h3>
              <p className="text-xs sm:text-sm text-slate-400 mt-1 max-w-2xl">
                Racing has not commenced for this series yet. Standings, discards, and division leaderboards will update live as heats conclude.
              </p>
            </div>
            <div className="rounded-2xl border border-teal-500/20 bg-teal-500/10 px-4 py-3 text-right shrink-0">
              <p className="text-[10px] font-bold uppercase tracking-wider text-teal-400">Series Target</p>
              <p className="text-xl font-black text-white">Up to 72 Races</p>
              <p className="text-[11px] text-slate-400">Min. 6 races to constitute series</p>
            </div>
          </div>

          {/* 3 Scheduled Rounds Cards */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {series.rounds.map((rnd, idx) => (
              <div
                key={rnd.id}
                className="rounded-2xl border border-white/10 bg-white/[0.02] p-5 space-y-3 hover:border-amber-500/30 transition-colors"
              >
                <div className="flex items-center justify-between gap-2">
                  <span className="rounded-full bg-amber-500/15 border border-amber-500/30 px-2.5 py-0.5 text-[10px] font-black text-amber-300 uppercase">
                    Round {idx + 1} of 3
                  </span>
                  <span className="text-[11px] font-mono text-slate-400 font-semibold">
                    {rnd.status}
                  </span>
                </div>

                <div>
                  <h4 className="font-black text-white text-base">{rnd.name}</h4>
                  <p className="text-xs text-slate-400 mt-1 flex items-center gap-1.5">
                    <Calendar className="h-3.5 w-3.5 text-teal-400 shrink-0" />
                    <span>{rnd.dates}</span>
                  </p>
                </div>

                <div className="pt-3 border-t border-white/5 space-y-1.5 text-xs text-slate-400">
                  <p className="flex items-start gap-1.5">
                    <MapPin className="h-3.5 w-3.5 text-slate-500 shrink-0 mt-0.5" />
                    <span>
                      {rnd.id.includes("gp1")
                        ? "Constant Wind Sea Sport Centre (Kite Foil: Marina Parade / ECP D1)"
                        : rnd.id.includes("gp2")
                        ? "PAssion Wave @ East Coast (Kite Foil: Marina Parade / ECP D1)"
                        : "National Sailing Centre (Championship Grand Finale)"}
                    </span>
                  </p>
                  <p className="flex items-center gap-1.5 text-[11px] text-slate-500">
                    <Flag className="h-3 w-3 text-slate-500 shrink-0" />
                    <span>Slalom / Course / Marathon · Up to 24 heats</span>
                  </p>
                </div>
              </div>
            ))}
          </div>

          {/* Series Notice of Race Specifications */}
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3 pt-2">
            <div className="rounded-xl border border-white/5 bg-white/[0.02] p-3.5 space-y-1">
              <p className="text-[10px] font-bold uppercase tracking-wider text-slate-400">Format</p>
              <p className="text-sm font-bold text-white">Slalom / Course / Marathon</p>
              <p className="text-[11px] text-slate-500">Fast-paced course racing &amp; endurance</p>
            </div>
            <div className="rounded-xl border border-white/5 bg-white/[0.02] p-3.5 space-y-1">
              <p className="text-[10px] font-bold uppercase tracking-wider text-slate-400">Classes</p>
              <p className="text-sm font-bold text-white">Wing Foil, Wind Foil, Techno 293, Kite Foil</p>
              <p className="text-[11px] text-slate-500">Open &amp; age-group divisions</p>
            </div>
            <div className="rounded-xl border border-white/5 bg-white/[0.02] p-3.5 space-y-1">
              <p className="text-[10px] font-bold uppercase tracking-wider text-slate-400">Constitution Rule</p>
              <p className="text-sm font-bold text-white">Min. 3 Competitors</p>
              <p className="text-[11px] text-slate-500">Required to constitute a division (NoR 4.2)</p>
            </div>
            <div className="rounded-xl border border-white/5 bg-white/[0.02] p-3.5 space-y-1">
              <p className="text-[10px] font-bold uppercase tracking-wider text-slate-400">Scoring &amp; Discards</p>
              <p className="text-sm font-bold text-white">Cumulative Discard Table</p>
              <p className="text-[11px] text-slate-500">Per NoR 12.5.2 (1 at 5 races, up to 12 discards)</p>
            </div>
          </div>
        </div>
      ) : (
        <>
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

      {/* Division Champions (NoR Clause 16.1 & 4.2) */}
      <div className="rounded-2xl border border-white/10 bg-[#131520] p-4">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 mb-3">
          <div className="flex items-center gap-2 text-xs font-bold uppercase tracking-wider text-slate-400">
            <Medal className="h-4 w-4 text-amber-400" />
            <span>Official Division Champions (NoR 12.4.1 &amp; 16.1)</span>
          </div>
          <span className="text-[10px] text-slate-500 font-medium">
            Min. 3 competitors required to constitute a division (NoR Clause 4.2)
          </span>
        </div>

        {/* Constituted Division Champions Grid */}
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-2.5 text-xs">
          {series.divisions
            .filter((d) => d.isConstituted && d.champion)
            .map((div) => (
              <div
                key={div.division.id}
                className="rounded-xl bg-white/[0.03] border border-white/5 p-3 hover:border-amber-500/20 transition-colors flex flex-col justify-between gap-2"
              >
                <div>
                  <div className="flex items-center justify-between gap-1">
                    <p className="text-[10px] font-bold text-amber-400 uppercase tracking-wider truncate">
                      {div.division.shortLabel}
                    </p>
                    <span className="text-[9px] font-mono text-teal-400 bg-teal-500/10 border border-teal-500/20 px-1.5 py-0.2 rounded shrink-0 font-bold">
                      {div.competitorCount} entries
                    </span>
                  </div>
                  <p className="font-bold text-white text-sm mt-1 truncate">
                    {div.champion?.name || "Pending"}
                  </p>
                </div>
                <p className="text-[11px] font-mono text-slate-400 border-t border-white/5 pt-1.5 flex items-center justify-between">
                  <span>Rank #{div.champion?.rank}</span>
                  <span className="font-bold text-amber-300">
                    {div.champion?.nettScore} pts
                  </span>
                </p>
              </div>
            ))}
        </div>

        {/* Unconstituted Notice */}
        {series.divisions.some((d) => !d.isConstituted && d.division.id !== "open") && (
          <div className="mt-3 pt-2.5 border-t border-white/5 flex flex-wrap items-center gap-1.5 text-[11px] text-slate-500">
            <span className="font-medium text-slate-400">Did not constitute (&lt;3 entries per NoR 4.2):</span>
            {series.divisions
              .filter((d) => !d.isConstituted && d.division.id !== "open")
              .map((d) => (
                <span
                  key={d.division.id}
                  className="rounded bg-white/5 px-2 py-0.5 text-[10px] text-slate-400 border border-white/5"
                >
                  {d.division.shortLabel} ({d.competitorCount})
                </span>
              ))}
          </div>
        )}
      </div>

      {/* Filter & Search Bar */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 rounded-2xl border border-white/10 bg-[#0c0d14] p-3">
        <div className="flex flex-wrap items-center gap-1.5 overflow-x-auto max-w-full">
          <button
            type="button"
            onClick={() => setDivisionFilter("all")}
            className={`rounded-lg px-3 py-1.5 text-xs font-bold transition-all shrink-0 ${
              divisionFilter === "all"
                ? "bg-teal-500 text-slate-950 shadow-sm"
                : "text-slate-400 hover:text-white hover:bg-white/5"
            }`}
          >
            All Fleet
          </button>
          {OFFICIAL_WINGFOIL_DIVISIONS.map((div) => (
            <button
              key={div.id}
              type="button"
              onClick={() => setDivisionFilter(div.id)}
              className={`rounded-lg px-3 py-1.5 text-xs font-bold transition-all shrink-0 ${
                divisionFilter === div.id
                  ? "bg-teal-500 text-slate-950 shadow-sm"
                  : "text-slate-400 hover:text-white hover:bg-white/5"
              }`}
            >
              {div.shortLabel}
            </button>
          ))}
        </div>

        <div className="relative shrink-0">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-slate-500" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Search racer, sail #, club…"
            className="rounded-xl border border-white/10 bg-slate-900/80 pl-9 pr-3 py-1.5 text-xs text-white placeholder:text-slate-500 focus:outline-none focus:border-teal-500 w-full sm:w-56"
          />
        </div>
      </div>

      {/* Division Constitution Status Banner (NoR Clause 4.2) */}
      {activeDivision && (
        <div
          className={`flex items-start sm:items-center gap-2.5 rounded-xl px-3.5 py-2.5 text-xs ${
            activeDivision.isConstituted
              ? "bg-teal-500/10 border border-teal-500/20 text-teal-300"
              : "bg-amber-500/10 border border-amber-500/25 text-amber-300"
          }`}
        >
          {activeDivision.isConstituted ? (
            <CheckCircle2 className="h-4 w-4 text-teal-400 shrink-0 mt-0.5 sm:mt-0" />
          ) : (
            <AlertTriangle className="h-4 w-4 text-amber-400 shrink-0 mt-0.5 sm:mt-0" />
          )}
          <span className="leading-snug">
            <strong className="text-white font-bold">{activeDivision.division.name}</strong>:{" "}
            {activeDivision.isConstituted ? (
              <>
                Constituted with <strong>{activeDivision.competitorCount} competitors</strong> (min. 3 required per NoR Clause 4.2). Division rankings are based on overall class positions per NoR 12.4.1.
              </>
            ) : (
              <>
                Did not constitute ({activeDivision.competitorCount} competitor{activeDivision.competitorCount === 1 ? "" : "s"}). A minimum of 3 competitors is required to constitute a class and/or division per NoR Clause 4.2.
              </>
            )}
          </span>
        </div>
      )}

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
                {roundsWithRaces.map((rnd) => (
                  <th
                    key={rnd.id}
                    colSpan={rnd.raceCount}
                    className="px-2 py-2.5 text-center border-r border-white/10 bg-white/[0.02]"
                  >
                    <span className="text-amber-300 font-black">{rnd.shortName}</span>
                    <span className="ml-1 text-slate-500 font-mono">
                      ({rnd.raceCount} races)
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
                {roundsWithRaces.flatMap((rnd) =>
                  Array.from({ length: rnd.raceCount }).map((_, i) => (
                    <th
                      key={`${rnd.id}-r${i}`}
                      className="px-1.5 py-2.5 text-center w-8 text-[10px] font-mono text-slate-500"
                    >
                      R{i + 1}
                    </th>
                  ))
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
        </>
      )}
    </div>
  );
}
