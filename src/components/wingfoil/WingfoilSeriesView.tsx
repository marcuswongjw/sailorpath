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
  normalizeWingfoilCategory,
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
        <div className="flex flex-wrap items-center gap-2 p-1.5 rounded-2xl bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] shadow-xs">
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
                <span
                  className={`text-[10px] px-1.5 py-0.2 rounded font-mono ${
                    isSelected
                      ? "bg-white/20 text-white font-bold"
                      : "bg-[var(--sp-sailcloth)] text-[var(--sp-slate-soft)]"
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
              className="inline-flex items-center gap-1.5 rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-3 py-1.5 font-bold text-[var(--sp-harbour-teal)] hover:border-[var(--sp-harbour-teal)] transition-colors shadow-2xs"
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
              className="inline-flex items-center gap-1.5 rounded-xl border border-amber-200 bg-amber-50/70 px-3 py-1.5 font-bold text-amber-900 hover:bg-amber-100 transition-colors shadow-2xs"
            >
              <span>Official Notice Board</span>
              <ExternalLink className="h-3.5 w-3.5" />
            </a>
          )}
        </div>
      </div>

      {/* Series Championship Banner */}
      <div className="relative overflow-hidden rounded-3xl bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] p-5 sm:p-7 shadow-xs">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-5">
          <div className="space-y-2">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-bold bg-amber-100 text-amber-800 border border-amber-200 tracking-wide uppercase">
              <Sparkles className="h-3.5 w-3.5" />
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
                  <h4 className="text-sm font-bold text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-racing-orange)] transition-colors">
                    {round.shortName}
                  </h4>
                  <div className="flex items-center justify-between mt-1 text-xs text-[var(--sp-charcoal-slate)]">
                    <span>{round.dates}</span>
                    <span className="font-mono text-[var(--sp-harbour-teal)] font-bold">
                      {hasRaces ? `${round.raceCount} races` : "Upcoming"}
                    </span>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>

      {/* If 0 races have been completed, show the upcoming championship schedule & specifications */}
      {series.totalRacesCompleted === 0 ? (
        <div className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-6 sm:p-8 space-y-6 shadow-xs">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-[var(--sp-cool-veil)] pb-5">
            <div>
              <div className="flex items-center gap-2 text-xs font-black uppercase tracking-wider text-amber-700">
                <Calendar className="h-4 w-4" />
                <span>Championship Schedule &amp; Race Structure</span>
              </div>
              <h3 className="text-xl sm:text-2xl font-black text-[var(--sp-harbour-shadow)] mt-1">
                {series.seriesName}
              </h3>
              <p className="text-xs sm:text-sm text-[var(--sp-charcoal-slate)] mt-1 max-w-2xl">
                Racing has not commenced for this series yet. Standings, discards, and division leaderboards will update live as heats conclude.
              </p>
            </div>
            <div className="rounded-2xl border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-harbour-teal)]/10 px-4 py-3 text-right shrink-0">
              <p className="text-[10px] font-bold uppercase tracking-wider text-[var(--sp-harbour-teal)]">Series Target</p>
              <p className="text-xl font-black text-[var(--sp-harbour-shadow)]">Up to 72 Races</p>
              <p className="text-[11px] text-[var(--sp-slate-soft)]">Min. 6 races to constitute series</p>
            </div>
          </div>

          {/* 3 Scheduled Rounds Cards */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {series.rounds.map((rnd, idx) => (
              <div
                key={rnd.id}
                className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50 p-5 space-y-3 hover:border-[var(--sp-harbour-teal)] transition-colors"
              >
                <div className="flex items-center justify-between gap-2">
                  <span className="rounded-full bg-amber-100 border border-amber-200 px-2.5 py-0.5 text-[10px] font-black text-amber-800 uppercase">
                    Round {idx + 1} of 3
                  </span>
                  <span className="text-[11px] font-mono text-[var(--sp-slate-soft)] font-semibold">
                    {rnd.status}
                  </span>
                </div>

                <div>
                  <h4 className="font-black text-[var(--sp-harbour-shadow)] text-base">{rnd.name}</h4>
                  <p className="text-xs text-[var(--sp-charcoal-slate)] mt-1 flex items-center gap-1.5">
                    <Calendar className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)] shrink-0" />
                    <span>{rnd.dates}</span>
                  </p>
                </div>

                <div className="pt-3 border-t border-[var(--sp-cool-veil)] space-y-1.5 text-xs text-[var(--sp-charcoal-slate)]">
                  <p className="flex items-start gap-1.5">
                    <MapPin className="h-3.5 w-3.5 text-[var(--sp-slate-soft)] shrink-0 mt-0.5" />
                    <span>
                      {rnd.id.includes("gp1")
                        ? "Constant Wind Sea Sport Centre (Kite Foil: Marina Parade / ECP D1)"
                        : rnd.id.includes("gp2")
                        ? "PAssion Wave @ East Coast (Kite Foil: Marina Parade / ECP D1)"
                        : "National Sailing Centre (Championship Grand Finale)"}
                    </span>
                  </p>
                  <p className="flex items-center gap-1.5 text-[11px] text-[var(--sp-slate-soft)]">
                    <Flag className="h-3 w-3 text-[var(--sp-slate-soft)] shrink-0" />
                    <span>Slalom / Course / Marathon · Up to 24 heats</span>
                  </p>
                </div>
              </div>
            ))}
          </div>

          {/* Series Notice of Race Specifications */}
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3 pt-2">
            <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-3.5 space-y-1">
              <p className="text-[10px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">Format</p>
              <p className="text-sm font-bold text-[var(--sp-harbour-shadow)]">Slalom / Course / Marathon</p>
              <p className="text-[11px] text-[var(--sp-charcoal-slate)]">Fast-paced course racing &amp; endurance</p>
            </div>
            <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-3.5 space-y-1">
              <p className="text-[10px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">Classes</p>
              <p className="text-sm font-bold text-[var(--sp-harbour-shadow)]">Wing Foil, Wind Foil, Techno 293, Kite Foil</p>
              <p className="text-[11px] text-[var(--sp-charcoal-slate)]">Open &amp; age-group divisions</p>
            </div>
            <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-3.5 space-y-1">
              <p className="text-[10px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">Constitution Rule</p>
              <p className="text-sm font-bold text-[var(--sp-harbour-shadow)]">Min. 3 Competitors</p>
              <p className="text-[11px] text-[var(--sp-charcoal-slate)]">Required to constitute a division (NoR 4.2)</p>
            </div>
            <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-3.5 space-y-1">
              <p className="text-[10px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">Scoring &amp; Discards</p>
              <p className="text-sm font-bold text-[var(--sp-harbour-shadow)]">Cumulative Discard Table</p>
              <p className="text-[11px] text-[var(--sp-charcoal-slate)]">Per NoR 12.5.2 (1 at 5 races, up to 12 discards)</p>
            </div>
          </div>
        </div>
      ) : (
        <>
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
                            {normalizeWingfoilCategory(sailor.ageCategory)}
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
              .filter((d) => d.division.id === "open" || d.isConstituted || d.champion)
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

      {/* Filter & Search Bar */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-3 shadow-xs">
        <div className="flex flex-wrap items-center gap-1.5 overflow-x-auto max-w-full">
          <button
            type="button"
            onClick={() => setDivisionFilter("all")}
            className={`rounded-lg px-3 py-1.5 text-xs font-bold transition-all shrink-0 ${
              divisionFilter === "all"
                ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)]"
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
                  ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                  : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)]"
              }`}
            >
              {div.shortLabel}
            </button>
          ))}
        </div>

        <div className="relative shrink-0">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-[var(--sp-slate-soft)]" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Search racer, sail #, club…"
            className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] pl-9 pr-3 py-1.5 text-xs text-[var(--sp-harbour-shadow)] placeholder:text-[var(--sp-slate-soft)] focus:outline-none focus:border-[var(--sp-harbour-teal)] w-full sm:w-56"
          />
        </div>
      </div>

      {/* Division Constitution Status Banner (NoR Clause 4.2) */}
      {activeDivision && (
        <div
          className={`flex items-start sm:items-center gap-2.5 rounded-xl px-3.5 py-2.5 text-xs ${
            activeDivision.isConstituted
              ? "bg-[var(--sp-harbour-teal)]/10 border border-[var(--sp-harbour-teal)]/20 text-[var(--sp-harbour-teal)]"
              : "bg-amber-50 border border-amber-200 text-amber-900"
          }`}
        >
          {activeDivision.isConstituted ? (
            <CheckCircle2 className="h-4 w-4 text-[var(--sp-harbour-teal)] shrink-0 mt-0.5 sm:mt-0" />
          ) : (
            <AlertTriangle className="h-4 w-4 text-amber-600 shrink-0 mt-0.5 sm:mt-0" />
          )}
          <span className="leading-snug">
            <strong className="text-[var(--sp-harbour-shadow)] font-bold">{activeDivision.division.name}</strong>:{" "}
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
      <div className="hidden md:block rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] overflow-hidden shadow-xs">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            {/* Top Tier Header: Grouped by Round */}
            <thead className="bg-[var(--sp-sailcloth)] border-b border-[var(--sp-cool-veil)] text-[10px] uppercase tracking-wider font-bold">
              <tr>
                <th colSpan={5} className="px-4 py-2.5 text-[var(--sp-slate-soft)] border-r border-[var(--sp-cool-veil)]">
                  Competitor Details
                </th>
                {roundsWithRaces.map((rnd) => (
                  <th
                    key={rnd.id}
                    colSpan={rnd.raceCount}
                    className="px-2 py-2.5 text-center border-r border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50"
                  >
                    <span className="text-amber-800 font-black">{rnd.shortName}</span>
                    <span className="ml-1 text-[var(--sp-slate-soft)] font-mono">
                      ({rnd.raceCount} races)
                    </span>
                  </th>
                ))}
                <th colSpan={2} className="px-4 py-2.5 text-right text-[var(--sp-harbour-teal)]">
                  Cumulative Points
                </th>
              </tr>

              {/* Second Tier Header: Columns */}
              <tr className="border-b border-[var(--sp-cool-veil)] text-[var(--sp-slate-soft)] bg-[var(--sp-sailcloth)]/30">
                <th className="px-4 py-2.5 w-12 text-center">Rank</th>
                <th className="px-4 py-2.5 min-w-[12rem]">Racer / Sailor</th>
                <th className="px-2 py-2.5 text-center w-14">Sail #</th>
                <th className="px-2 py-2.5 text-center w-12">Gender</th>
                <th className="px-2 py-2.5 text-center w-16">Div</th>
                <th className="px-3 py-2.5 min-w-[9rem] border-r border-[var(--sp-cool-veil)]">Club</th>
                {roundsWithRaces.flatMap((rnd) =>
                  Array.from({ length: rnd.raceCount }).map((_, i) => (
                    <th
                      key={`${rnd.id}-r${i}`}
                      className="px-1.5 py-2.5 text-center w-8 text-[10px] font-mono text-[var(--sp-slate-soft)]"
                    >
                      R{i + 1}
                    </th>
                  ))
                )}
                <th className="px-3 py-2.5 text-right w-16 text-[var(--sp-slate-soft)] font-mono">Gross</th>
                <th className="px-4 py-2.5 text-right w-20 font-black text-[var(--sp-harbour-shadow)] font-mono">
                  Nett
                </th>
              </tr>
            </thead>

            <tbody className="divide-y divide-[var(--sp-cool-veil)] font-sans">
              {filteredCompetitors.map((sailor) => (
                <tr
                  key={sailor.name}
                  className="hover:bg-[var(--sp-sailcloth)]/50 transition-colors"
                >
                  <td className="px-4 py-3 text-center">
                    <RankMedalBadge
                      rank={sailor.rank}
                      nonPodiumClassName="font-mono font-bold text-[var(--sp-harbour-teal)]"
                    />
                  </td>

                  <td className="px-4 py-3">
                    <p className="font-bold text-[var(--sp-harbour-shadow)]">{sailor.name}</p>
                    <p className="text-[10px] text-[var(--sp-slate-soft)] truncate">
                      {sailor.roundsAttended.length === series.rounds.length
                        ? "All rounds attended"
                        : `${sailor.roundsAttended.length} of ${series.rounds.length} rounds`}
                    </p>
                  </td>

                  <td className="px-2 py-3 text-center font-mono text-[var(--sp-charcoal-slate)]">
                    {sailor.sailNumber || "—"}
                  </td>

                  <td className="px-2 py-3 text-center font-semibold text-[var(--sp-slate-soft)]">
                    {sailor.gender || "—"}
                  </td>

                  <td className="px-2 py-3 text-center">
                    <span className="rounded bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-1.5 py-0.5 text-[10px] font-semibold text-[var(--sp-charcoal-slate)]">
                      {normalizeWingfoilCategory(sailor.ageCategory)}
                    </span>
                  </td>

                  <td className="px-3 py-3 border-r border-[var(--sp-cool-veil)]">
                    <p className="text-[var(--sp-charcoal-slate)] truncate max-w-[10rem]">
                      {sailor.club || "—"}
                    </p>
                  </td>

                  {/* All Race Scores across Grand Prix Rounds */}
                  {sailor.races.map((r, i) => (
                    <td
                      key={i}
                      className={`px-1.5 py-3 text-center font-mono text-xs ${
                        r.isDiscarded
                          ? "line-through text-[var(--sp-slate-soft)] bg-[var(--sp-sailcloth)]/30"
                          : r.score === 1
                          ? "font-black text-amber-900 bg-amber-100"
                          : r.score <= 3
                          ? "font-bold text-[var(--sp-harbour-teal)] bg-[var(--sp-harbour-teal)]/10"
                          : r.code === "DNC"
                          ? "text-rose-700 bg-rose-50"
                          : "text-[var(--sp-charcoal-slate)]"
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

                  <td className="px-3 py-3 text-right font-mono text-[var(--sp-slate-soft)] text-xs">
                    {sailor.grossScore}
                  </td>

                  <td className="px-4 py-3 text-right font-mono font-black text-sm text-[var(--sp-harbour-shadow)]">
                    {sailor.nettScore}
                  </td>
                </tr>
              ))}

              {filteredCompetitors.length === 0 && (
                <tr>
                  <td
                    colSpan={series.totalRacesCompleted + 7}
                    className="px-4 py-12 text-center text-[var(--sp-slate-soft)]"
                  >
                    No competitors match the selected filter.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Footer Scoring Legend */}
        <div className="border-t border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/40 px-4 py-2.5 text-[11px] text-[var(--sp-slate-soft)] flex flex-wrap items-center justify-between gap-2">
          <span>
            <strong className="text-[var(--sp-harbour-shadow)]">Scoring Rules:</strong> World Sailing RRS Appendix A &amp; NoR Clause 12. Low Points win.
            Non-attendees scored Attendee Count + 2 pts (DNC) per NoR 12.3.2.
          </span>
          <span className="font-mono text-[10px] text-[var(--sp-slate-soft)]">
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
              className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 space-y-3 shadow-2xs"
            >
              <div className="flex items-start justify-between gap-3">
                <div className="flex items-center gap-3">
                  <RankMedalBadge rank={sailor.rank} className="h-8 w-8 text-sm" />
                  <div>
                    <h4 className="font-bold text-[var(--sp-harbour-shadow)] text-sm">{sailor.name}</h4>
                    <p className="text-[11px] text-[var(--sp-slate-soft)]">
                      #{sailor.sailNumber || "—"} · {sailor.ageCategory} · {sailor.club || "Singapore"}
                    </p>
                  </div>
                </div>

                <div className="text-right font-mono">
                  <p className="text-base font-black text-[var(--sp-harbour-shadow)]">
                    {sailor.nettScore} <span className="text-[10px] font-normal text-[var(--sp-slate-soft)]">pts</span>
                  </p>
                  <p className="text-[10px] text-[var(--sp-slate-soft)]">Gross: {sailor.grossScore}</p>
                </div>
              </div>

              <div className="pt-2 border-t border-[var(--sp-cool-veil)] flex items-center justify-between">
                <span className="text-[11px] text-[var(--sp-slate-soft)]">
                  {sailor.roundsAttended.length} of {series.rounds.length} rounds attended
                </span>

                <button
                  type="button"
                  onClick={() => setExpandedSailor(isExpanded ? null : sailor.name)}
                  className="inline-flex items-center gap-1 text-[11px] font-bold text-[var(--sp-harbour-teal)] hover:underline"
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
                <div className="pt-2 border-t border-[var(--sp-cool-veil)] space-y-2">
                  <p className="text-[10px] uppercase font-bold text-[var(--sp-slate-soft)]">
                    Heat Scores (Struck through = Discarded)
                  </p>
                  <div className="flex flex-wrap gap-1">
                    {sailor.races.map((r, i) => (
                      <span
                        key={i}
                        className={`rounded px-1.5 py-0.5 font-mono text-[10px] ${
                          r.isDiscarded
                            ? "line-through text-[var(--sp-slate-soft)] bg-[var(--sp-sailcloth)]"
                            : r.score === 1
                            ? "font-bold text-amber-900 bg-amber-100 border border-amber-300"
                            : r.code === "DNC"
                            ? "text-rose-700 bg-rose-50"
                            : "text-[var(--sp-charcoal-slate)] bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)]"
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
