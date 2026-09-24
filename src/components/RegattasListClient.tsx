"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import {
  Calendar,
  Search,
  Anchor,
  Globe,
  Sailboat,
  Trophy,
  Award,
  Filter,
  List,
  LayoutGrid,
  Sparkles,
} from "lucide-react";

export type PublicRegatta = {
  id: string;
  name: string;
  slug: string;
  date: string;
  totalFleetSize: number;
  division?: string | null;
  raceCount?: number | null;
  geography?: string | null;
  boatClass?: string | null;
  countsForRanking?: boolean;
};

function periodKey(dateStr: string): string {
  const ymd = String(dateStr || "").slice(0, 10);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(ymd)) return "Other";
  const year = Number(ymd.slice(0, 4));
  const month = Number(ymd.slice(5, 7));
  if (!Number.isFinite(year) || !Number.isFinite(month)) return "Other";
  const half = month <= 6 ? "Jan – Jun" : "Jul – Dec";
  return `${half} ${year}`;
}

function formatNiceDate(dateStr: string) {
  const ymd = String(dateStr || "").slice(0, 10);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(ymd)) return dateStr;
  const parts = ymd.split("-");
  if (parts.length === 3) {
    const [y, m, d] = parts;
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    const monthName = months[Number(m) - 1];
    if (monthName) return `${Number(d)} ${monthName} ${y}`;
  }
  return dateStr;
}

type RegattasListProps = {
  regattas: PublicRegatta[];
  /** Page title */
  title?: string;
  /** Subtitle under the title */
  description?: string;
  /** Badge label e.g. "Optimist" / "ILCA 4" */
  badgeLabel?: string;
  /**
   * Base path for event detail links (no trailing slash).
   * Default: /sg/optimist/regattas
   */
  detailBasePath?: string;
  /** Hide boat-class filter (list is already class-filtered) */
  hideBoatClassFilter?: boolean;
  /** Hide division filter (for single-fleet classes like ILCA 4) */
  hideDivisionFilter?: boolean;
  /** Accent: orange (Optimist) or sky (ILCA) */
  accent?: "orange" | "sky";
  /** Shown when the class has no regattas at all. */
  emptyMessage?: string;
};

export function RegattasListClient({
  regattas,
  title = "Regattas & Competitions",
  description = "Explore published Singapore Optimist ranking series results and local events.",
  badgeLabel = "Regatta Directory",
  detailBasePath = "/sg/optimist/regattas",
  hideBoatClassFilter = true,
  hideDivisionFilter,
  accent = "orange",
  emptyMessage = "No regattas yet. Import from admin.",
}: RegattasListProps) {
  const [query, setQuery] = useState("");
  const [rankingFilter, setRankingFilter] = useState<"all" | "ranking" | "non-ranking">("all");
  const [division, setDivision] = useState<string>("all");
  const [period, setPeriod] = useState<string>("all");
  const [boatClassFilter, setBoatClassFilter] = useState<string>("all");
  const [geography, setGeography] = useState<string>("all");
  const [viewMode, setViewMode] = useState<"grid" | "compact">("grid");

  // Metric counts
  const metrics = useMemo(() => {
    let rankingCount = 0;
    let nonRankingCount = 0;
    for (const r of regattas) {
      if (r.countsForRanking !== false) {
        rankingCount++;
      } else {
        nonRankingCount++;
      }
    }
    return {
      total: regattas.length,
      ranking: rankingCount,
      nonRanking: nonRankingCount,
    };
  }, [regattas]);

  const boatClasses = useMemo(() => {
    const set = new Set<string>();
    for (const r of regattas) {
      if (r.boatClass) set.add(r.boatClass);
    }
    return Array.from(set).sort();
  }, [regattas]);

  const periods = useMemo(() => {
    const set = new Set<string>();
    for (const r of regattas) set.add(periodKey(r.date));
    return Array.from(set).sort((a, b) => {
      const ya = Number(a.slice(-4)) || 0;
      const yb = Number(b.slice(-4)) || 0;
      if (ya !== yb) return yb - ya;
      return a.startsWith("Jul") ? -1 : 1;
    });
  }, [regattas]);

  const geographies = useMemo(() => {
    const set = new Set<string>();
    for (const r of regattas) {
      const g = String(r.geography || "SGP").trim();
      if (g) set.add(g);
    }
    return Array.from(set).sort();
  }, [regattas]);

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    return regattas.filter((r) => {
      // Ranking vs Non-Ranking filter
      if (rankingFilter === "ranking" && r.countsForRanking === false) return false;
      if (rankingFilter === "non-ranking" && r.countsForRanking !== false) return false;

      if (!hideBoatClassFilter && boatClassFilter !== "all" && r.boatClass !== boatClassFilter) {
        return false;
      }
      if (division !== "all" && String(r.division || "Gold") !== division) {
        return false;
      }
      if (period !== "all" && periodKey(r.date) !== period) return false;
      if (
        geography !== "all" &&
        String(r.geography || "SGP").toUpperCase() !== geography.toUpperCase()
      ) {
        return false;
      }
      if (!q) return true;
      return `${r.name} ${r.date} ${r.division || ""} ${r.geography || ""} ${r.boatClass || ""}`
        .toLowerCase()
        .includes(q);
    });
  }, [regattas, query, rankingFilter, hideBoatClassFilter, boatClassFilter, division, period, geography]);

  const grouped = useMemo(() => {
    const map = new Map<string, PublicRegatta[]>();
    for (const r of filtered) {
      const k = periodKey(r.date);
      if (!map.has(k)) map.set(k, []);
      map.get(k)!.push(r);
    }
    for (const [, list] of map) {
      list.sort((a, b) => String(b.date).localeCompare(String(a.date)));
    }
    return Array.from(map.entries()).sort((a, b) => {
      const ya = Number(a[0].slice(-4)) || 0;
      const yb = Number(b[0].slice(-4)) || 0;
      if (ya !== yb) return yb - ya;
      return a[0].startsWith("Jul") ? -1 : 1;
    });
  }, [filtered]);

  return (
    <div className="mx-auto max-w-5xl w-full px-4 py-8 sm:py-12 space-y-8">
      {/* Header Banner */}
      <div className="flex flex-col md:flex-row md:items-end justify-between gap-4">
        <div>
          <div
            className={`inline-flex items-center gap-1.5 px-3 py-1 rounded-full border text-xs font-bold mb-3 ${
              accent === "sky"
                ? "bg-[var(--sp-aqua-mist)] border-[var(--sp-harbour-teal)]/30 text-[var(--sp-harbour-teal)]"
                : "bg-[var(--sp-racing-mist)]/30 border-[var(--sp-racing-orange)]/30 text-[var(--sp-racing-orange)]"
            }`}
          >
            <Sparkles className="h-3.5 w-3.5" />
            {badgeLabel}
          </div>
          <h1 className="text-3xl sm:text-4xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
            {title}
          </h1>
          <p className="text-sm text-[var(--sp-slate-soft)] mt-1 max-w-xl">{description}</p>
        </div>

        {/* View mode toggle */}
        <div className="flex items-center gap-2 self-start md:self-end">
          <span className="text-[11px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">View</span>
          <div className="inline-flex rounded-xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] p-1">
            <button
              type="button"
              onClick={() => setViewMode("grid")}
              className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-colors inline-flex items-center gap-1.5 ${
                viewMode === "grid"
                  ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                  : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
              }`}
            >
              <LayoutGrid className="h-3.5 w-3.5" />
              Grid
            </button>
            <button
              type="button"
              onClick={() => setViewMode("compact")}
              className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-colors inline-flex items-center gap-1.5 ${
                viewMode === "compact"
                  ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                  : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
              }`}
            >
              <List className="h-3.5 w-3.5" />
              List
            </button>
          </div>
        </div>
      </div>

      {/* Summary KPI Bar */}
      <div className="grid grid-cols-3 gap-3">
        <div className="rounded-2xl p-4 border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs text-center sm:text-left flex flex-col sm:flex-row items-center gap-3">
          <div className="h-10 w-10 rounded-xl border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)] flex items-center justify-center shrink-0">
            <Trophy className="h-5 w-5 text-[var(--sp-harbour-teal)]" />
          </div>
          <div>
            <span className="block text-[11px] font-bold uppercase text-[var(--sp-slate-soft)] tracking-wider">
              Total Events
            </span>
            <span className="text-xl sm:text-2xl font-black text-[var(--sp-harbour-shadow)] tabular-nums">
              {metrics.total}
            </span>
          </div>
        </div>

        <div className="rounded-2xl p-4 border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs text-center sm:text-left flex flex-col sm:flex-row items-center gap-3">
          <div className="h-10 w-10 rounded-xl bg-[var(--sp-racing-mist)]/40 border border-[var(--sp-racing-orange)]/30 flex items-center justify-center shrink-0">
            <Award className="h-5 w-5 text-[var(--sp-racing-orange)]" />
          </div>
          <div>
            <span className="block text-[11px] font-bold uppercase text-[var(--sp-slate-soft)] tracking-wider">
              Series Ranking
            </span>
            <span className="text-xl sm:text-2xl font-black text-[var(--sp-racing-orange)] tabular-nums">
              {metrics.ranking}
            </span>
          </div>
        </div>

        <div className="rounded-2xl p-4 border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs text-center sm:text-left flex flex-col sm:flex-row items-center gap-3">
          <div className="h-10 w-10 rounded-xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] flex items-center justify-center shrink-0">
            <Anchor className="h-5 w-5 text-[var(--sp-slate-soft)]" />
          </div>
          <div>
            <span className="block text-[11px] font-bold uppercase text-[var(--sp-slate-soft)] tracking-wider">
              Non-Ranking / Local
            </span>
            <span className="text-xl sm:text-2xl font-black text-[var(--sp-charcoal-slate)] tabular-nums">
              {metrics.nonRanking}
            </span>
          </div>
        </div>
      </div>

      {/* Main Filter Control Box */}
      <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 sm:p-5 space-y-4 shadow-xs">
        {/* Ranking vs Non-Ranking Segmented Control */}
        <div className="space-y-2">
          <label className="text-[11px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)] flex items-center gap-1.5">
            <Filter className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)]" />
            Ranking Event Category
          </label>
          <div className="grid grid-cols-3 gap-1.5 p-1 rounded-xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)]">
            <button
              type="button"
              onClick={() => setRankingFilter("all")}
              className={`py-2 px-3 rounded-lg text-xs font-bold transition-all text-center flex items-center justify-center gap-1.5 ${
                rankingFilter === "all"
                  ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                  : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
              }`}
            >
              All Events ({regattas.length})
            </button>
            <button
              type="button"
              onClick={() => setRankingFilter("ranking")}
              className={`py-2 px-3 rounded-lg text-xs font-bold transition-all text-center flex items-center justify-center gap-1.5 ${
                rankingFilter === "ranking"
                  ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                  : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
              }`}
            >
              <Trophy className="h-3.5 w-3.5" />
              Series Ranking ({metrics.ranking})
            </button>
            <button
              type="button"
              onClick={() => setRankingFilter("non-ranking")}
              className={`py-2 px-3 rounded-lg text-xs font-bold transition-all text-center flex items-center justify-center gap-1.5 ${
                rankingFilter === "non-ranking"
                  ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                  : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
              }`}
            >
              <Anchor className="h-3.5 w-3.5" />
              Non-Ranking ({metrics.nonRanking})
            </button>
          </div>
        </div>

        {/* Search input & Select filters */}
        <div className="grid grid-cols-1 sm:grid-cols-5 gap-2.5">
          <div className="relative sm:col-span-2">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-[var(--sp-slate-soft)]" />
            <input
              type="search"
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              placeholder="Search regatta name…"
              className="sp-input w-full pl-10 text-xs sm:text-sm"
            />
          </div>

          {!hideBoatClassFilter && boatClasses.length > 1 && (
            <select
              value={boatClassFilter}
              onChange={(e) => setBoatClassFilter(e.target.value)}
              className="sp-select text-xs sm:text-sm font-semibold"
              aria-label="Boat Class"
            >
              <option value="all">All classes</option>
              {boatClasses.map((c) => (
                <option key={c} value={c}>
                  {c}
                </option>
              ))}
            </select>
          )}

          <select
            value={geography}
            onChange={(e) => setGeography(e.target.value)}
            className="sp-select text-xs sm:text-sm font-semibold"
            aria-label="Geography"
          >
            <option value="all">All countries</option>
            {geographies.map((g) => (
              <option key={g} value={g}>
                {g}
              </option>
            ))}
          </select>

          {!hideDivisionFilter && (
            <select
              value={division}
              onChange={(e) => setDivision(e.target.value)}
              className="sp-select text-xs sm:text-sm font-semibold"
            >
              <option value="all">All divisions</option>
              <option value="Gold">Gold</option>
              <option value="Silver">Silver</option>
              <option value="Both">Both</option>
              <option value="Open">Open</option>
            </select>
          )}

          <select
            value={period}
            onChange={(e) => setPeriod(e.target.value)}
            className="sp-select text-xs sm:text-sm font-semibold"
          >
            <option value="all">All periods</option>
            {periods.map((p) => (
              <option key={p} value={p}>
                {p}
              </option>
            ))}
          </select>
        </div>
      </div>

      {/* Regatta Results List */}
      {regattas.length === 0 ? (
        <p className="text-sm text-[var(--sp-slate-soft)] text-center py-12">
          {emptyMessage}
        </p>
      ) : filtered.length === 0 ? (
        <div className="rounded-2xl p-12 text-center border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] space-y-3 shadow-xs">
          <Search className="h-8 w-8 text-[var(--sp-slate-soft)] mx-auto" />
          <p className="text-sm text-[var(--sp-slate-soft)] font-medium">
            No regattas match your selected filters.
          </p>
          <button
            type="button"
            onClick={() => {
              setQuery("");
              setRankingFilter("all");
              setDivision("all");
              setPeriod("all");
              setGeography("all");
            }}
            className="text-xs text-[var(--sp-racing-orange)] hover:underline font-bold"
          >
            Reset all filters
          </button>
        </div>
      ) : (
        <div className="space-y-10">
          {grouped.map(([periodLabel, list]) => (
            <section key={periodLabel} className="space-y-4">
              <div className="flex items-center gap-2 border-b border-[var(--sp-cool-veil)] pb-2">
                <Calendar className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
                <h2 className="text-base font-black text-[var(--sp-harbour-shadow)] uppercase tracking-wider">
                  {periodLabel}
                </h2>
                <span className="ml-auto text-xs font-bold text-[var(--sp-slate-soft)] bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-2.5 py-0.5 rounded-full">
                  {list.length} {list.length === 1 ? "event" : "events"}
                </span>
              </div>

              {viewMode === "grid" ? (
                /* Grid View */
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {list.map((r) => {
                    const isRanking = r.countsForRanking !== false;
                    return (
                      <Link
                        key={r.id}
                        href={`${detailBasePath}/${r.slug}`}
                        className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 hover:border-[var(--sp-harbour-teal)] hover:shadow-md transition-all group flex flex-col justify-between gap-4 relative overflow-hidden shadow-xs"
                      >
                        <div className="space-y-2">
                          <div className="flex items-start justify-between gap-3">
                            <h3 className="font-bold text-base text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-harbour-teal)] transition-colors leading-snug">
                              {r.name}
                            </h3>
                            {isRanking ? (
                              <span className="shrink-0 inline-flex items-center gap-1 rounded-full bg-[var(--sp-racing-mist)]/30 border border-[var(--sp-racing-orange)]/30 px-2.5 py-0.5 text-[10px] font-black text-[var(--sp-racing-orange)]">
                                <Trophy className="h-3 w-3" />
                                Series
                              </span>
                            ) : (
                              <span className="shrink-0 inline-flex items-center gap-1 rounded-full bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-2.5 py-0.5 text-[10px] font-bold text-[var(--sp-slate-soft)]">
                                Non-ranking
                              </span>
                            )}
                          </div>
                          <p className="text-xs text-[var(--sp-slate-soft)] flex items-center gap-1.5 font-medium">
                            <Calendar className="h-3.5 w-3.5 shrink-0 text-[var(--sp-slate-soft)]" />
                            {formatNiceDate(r.date)}
                          </p>
                        </div>

                        <div className="flex flex-wrap items-center gap-2 text-xs text-[var(--sp-charcoal-slate)] font-semibold border-t border-[var(--sp-cool-veil)] pt-3">
                          <span className="inline-flex items-center gap-1 rounded-lg bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-2.5 py-1 text-[11px]">
                            <Globe className="h-3 w-3 text-[var(--sp-slate-soft)]" />
                            {r.geography || "SGP"}
                          </span>
                          <span className="inline-flex items-center gap-1 rounded-lg bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-2.5 py-1 text-[11px]">
                            <Sailboat className="h-3 w-3 text-[var(--sp-slate-soft)]" />
                            {r.boatClass || "Optimist"}
                          </span>
                          <span className="inline-flex items-center gap-1 rounded-lg bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-2.5 py-1 text-[11px]">
                            <Anchor className="h-3 w-3 text-[var(--sp-slate-soft)]" />
                            Fleet {r.totalFleetSize}
                          </span>
                          {r.raceCount != null && r.raceCount > 0 && (
                            <span className="inline-flex items-center gap-1 rounded-lg bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-2.5 py-1 text-[11px]">
                              {r.raceCount} Races
                            </span>
                          )}
                          <span className="ml-auto text-[var(--sp-racing-orange)] text-xs font-bold group-hover:translate-x-0.5 transition-transform">
                            Results →
                          </span>
                        </div>
                      </Link>
                    );
                  })}
                </div>
              ) : (
                /* Compact List View */
                <div className="divide-y divide-[var(--sp-cool-veil)] rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs overflow-hidden">
                  {list.map((r) => {
                    const isRanking = r.countsForRanking !== false;
                    return (
                      <Link
                        key={r.id}
                        href={`${detailBasePath}/${r.slug}`}
                        className="p-4 hover:bg-[var(--sp-sailcloth)] transition-colors flex flex-col sm:flex-row sm:items-center justify-between gap-3 group"
                      >
                        <div className="min-w-0 space-y-1">
                          <div className="flex items-center gap-2">
                            <span className="font-bold text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-harbour-teal)] transition-colors">
                              {r.name}
                            </span>
                            {isRanking ? (
                              <span className="rounded-full bg-[var(--sp-racing-mist)]/30 border border-[var(--sp-racing-orange)]/30 px-2 py-0.5 text-[9px] font-black text-[var(--sp-racing-orange)]">
                                Series
                              </span>
                            ) : (
                              <span className="rounded-full bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-2 py-0.5 text-[9px] font-bold text-[var(--sp-slate-soft)]">
                                Non-Ranking
                              </span>
                            )}
                          </div>
                          <p className="text-xs text-[var(--sp-slate-soft)]">
                            {formatNiceDate(r.date)} • {r.geography || "SGP"} • Fleet {r.totalFleetSize}
                          </p>
                        </div>

                        <div className="flex items-center gap-3 shrink-0">
                          <span className="text-xs font-bold text-[var(--sp-racing-orange)] group-hover:underline">
                            View Results →
                          </span>
                        </div>
                      </Link>
                    );
                  })}
                </div>
              )}
            </section>
          ))}
        </div>
      )}
    </div>
  );
}
