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
  CheckCircle2,
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
  const d = new Date(dateStr);
  if (!Number.isFinite(d.getTime())) return "Other";
  const y = d.getFullYear();
  const m = d.getMonth();
  const half = m < 6 ? "Jan – Jun" : "Jul – Dec";
  return `${half} ${y}`;
}

function formatNiceDate(dateStr: string) {
  const d = new Date(dateStr);
  if (!Number.isFinite(d.getTime())) return dateStr;
  return d.toLocaleDateString("en-SG", {
    day: "numeric",
    month: "short",
    year: "numeric",
  });
}

export function RegattasListClient({ regattas }: { regattas: PublicRegatta[] }) {
  const [query, setQuery] = useState("");
  const [rankingFilter, setRankingFilter] = useState<"all" | "ranking" | "non-ranking">("all");
  const [division, setDivision] = useState<string>("all");
  const [period, setPeriod] = useState<string>("all");
  const [geography, setGeography] = useState<string>("all");
  const [boatClass, setBoatClass] = useState<string>("all");
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
      const g = String(r.geography || "SG").trim();
      if (g) set.add(g);
    }
    return Array.from(set).sort();
  }, [regattas]);

  const classes = useMemo(() => {
    const set = new Set<string>();
    for (const r of regattas) {
      const c = String(r.boatClass || "Optimist").trim();
      if (c) set.add(c);
    }
    return Array.from(set).sort();
  }, [regattas]);

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    return regattas.filter((r) => {
      // Ranking vs Non-Ranking filter
      if (rankingFilter === "ranking" && r.countsForRanking === false) return false;
      if (rankingFilter === "non-ranking" && r.countsForRanking !== false) return false;

      if (division !== "all" && String(r.division || "Gold") !== division) {
        return false;
      }
      if (period !== "all" && periodKey(r.date) !== period) return false;
      if (
        geography !== "all" &&
        String(r.geography || "SG").toUpperCase() !== geography.toUpperCase()
      ) {
        return false;
      }
      if (
        boatClass !== "all" &&
        String(r.boatClass || "Optimist") !== boatClass
      ) {
        return false;
      }
      if (!q) return true;
      return `${r.name} ${r.date} ${r.division || ""} ${r.geography || ""} ${r.boatClass || ""}`
        .toLowerCase()
        .includes(q);
    });
  }, [regattas, query, rankingFilter, division, period, geography, boatClass]);

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
          <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-orange-500/10 border border-orange-500/20 text-orange-400 text-xs font-bold mb-3">
            <Sparkles className="h-3.5 w-3.5" />
            Regatta Directory
          </div>
          <h1 className="text-3xl sm:text-4xl font-black text-white tracking-tight">
            Regattas & Competitions
          </h1>
          <p className="text-sm text-slate-400 mt-1 max-w-xl">
            Explore official Singapore Optimist ranking series regattas and local practice events.
          </p>
        </div>

        {/* View mode toggle */}
        <div className="flex items-center gap-2 self-start md:self-end">
          <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">View</span>
          <div className="inline-flex rounded-xl bg-slate-900 border border-white/10 p-1">
            <button
              type="button"
              onClick={() => setViewMode("grid")}
              className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-colors inline-flex items-center gap-1.5 ${
                viewMode === "grid"
                  ? "bg-orange-500 text-white shadow-lg shadow-orange-500/20"
                  : "text-slate-400 hover:text-white"
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
                  ? "bg-orange-500 text-white shadow-lg shadow-orange-500/20"
                  : "text-slate-400 hover:text-white"
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
        <div className="glass-panel rounded-2xl p-4 border border-white/5 text-center sm:text-left flex flex-col sm:flex-row items-center gap-3">
          <div className="h-10 w-10 rounded-xl bg-orange-500/10 border border-orange-500/20 flex items-center justify-center shrink-0">
            <Trophy className="h-5 w-5 text-orange-400" />
          </div>
          <div>
            <span className="block text-[10px] font-bold uppercase text-slate-500 tracking-wider">
              Total Events
            </span>
            <span className="text-xl sm:text-2xl font-black text-white tabular-nums">
              {metrics.total}
            </span>
          </div>
        </div>

        <div className="glass-panel rounded-2xl p-4 border border-white/5 text-center sm:text-left flex flex-col sm:flex-row items-center gap-3">
          <div className="h-10 w-10 rounded-xl bg-amber-500/10 border border-amber-500/20 flex items-center justify-center shrink-0">
            <Award className="h-5 w-5 text-amber-400" />
          </div>
          <div>
            <span className="block text-[10px] font-bold uppercase text-slate-500 tracking-wider">
              Series Ranking
            </span>
            <span className="text-xl sm:text-2xl font-black text-amber-400 tabular-nums">
              {metrics.ranking}
            </span>
          </div>
        </div>

        <div className="glass-panel rounded-2xl p-4 border border-white/5 text-center sm:text-left flex flex-col sm:flex-row items-center gap-3">
          <div className="h-10 w-10 rounded-xl bg-sky-500/10 border border-sky-500/20 flex items-center justify-center shrink-0">
            <Anchor className="h-5 w-5 text-sky-400" />
          </div>
          <div>
            <span className="block text-[10px] font-bold uppercase text-slate-500 tracking-wider">
              Non-Ranking / Local
            </span>
            <span className="text-xl sm:text-2xl font-black text-sky-400 tabular-nums">
              {metrics.nonRanking}
            </span>
          </div>
        </div>
      </div>

      {/* Main Filter Control Box */}
      <div className="glass-panel rounded-2xl border border-white/5 p-4 sm:p-5 space-y-4">
        {/* Ranking vs Non-Ranking Segmented Control */}
        <div className="space-y-2">
          <label className="text-[11px] font-bold uppercase tracking-wider text-slate-400 flex items-center gap-1.5">
            <Filter className="h-3.5 w-3.5 text-orange-400" />
            Ranking Event Category
          </label>
          <div className="grid grid-cols-3 gap-1.5 p-1 rounded-xl bg-slate-950 border border-white/10">
            <button
              type="button"
              onClick={() => setRankingFilter("all")}
              className={`py-2 px-3 rounded-lg text-xs font-bold transition-all text-center flex items-center justify-center gap-1.5 ${
                rankingFilter === "all"
                  ? "bg-slate-800 text-white shadow"
                  : "text-slate-400 hover:text-slate-200"
              }`}
            >
              All Events ({regattas.length})
            </button>
            <button
              type="button"
              onClick={() => setRankingFilter("ranking")}
              className={`py-2 px-3 rounded-lg text-xs font-bold transition-all text-center flex items-center justify-center gap-1.5 ${
                rankingFilter === "ranking"
                  ? "bg-amber-500/20 text-amber-300 border border-amber-500/30 shadow"
                  : "text-slate-400 hover:text-slate-200"
              }`}
            >
              <Trophy className="h-3.5 w-3.5 text-amber-400" />
              Series Ranking ({metrics.ranking})
            </button>
            <button
              type="button"
              onClick={() => setRankingFilter("non-ranking")}
              className={`py-2 px-3 rounded-lg text-xs font-bold transition-all text-center flex items-center justify-center gap-1.5 ${
                rankingFilter === "non-ranking"
                  ? "bg-sky-500/20 text-sky-300 border border-sky-500/30 shadow"
                  : "text-slate-400 hover:text-slate-200"
              }`}
            >
              <Anchor className="h-3.5 w-3.5 text-sky-400" />
              Non-Ranking ({metrics.nonRanking})
            </button>
          </div>
        </div>

        {/* Search input & Select filters */}
        <div className="grid grid-cols-1 sm:grid-cols-5 gap-2.5">
          <div className="relative sm:col-span-2">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-500" />
            <input
              type="search"
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              placeholder="Search regatta name…"
              className="w-full rounded-xl bg-slate-950 border border-white/10 pl-10 pr-3 py-2.5 text-xs sm:text-sm text-white placeholder-slate-500 focus:border-orange-500 focus:outline-none"
            />
          </div>

          <select
            value={geography}
            onChange={(e) => setGeography(e.target.value)}
            className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-xs sm:text-sm text-white font-semibold focus:border-orange-500 focus:outline-none"
            aria-label="Country / geography"
          >
            <option value="all">All countries</option>
            {geographies.map((g) => (
              <option key={g} value={g}>
                {g}
              </option>
            ))}
          </select>

          <select
            value={division}
            onChange={(e) => setDivision(e.target.value)}
            className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-xs sm:text-sm text-white font-semibold focus:border-orange-500 focus:outline-none"
          >
            <option value="all">All divisions</option>
            <option value="Gold">Gold</option>
            <option value="Silver">Silver</option>
            <option value="Both">Both</option>
          </select>

          <select
            value={period}
            onChange={(e) => setPeriod(e.target.value)}
            className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-xs sm:text-sm text-white font-semibold focus:border-orange-500 focus:outline-none"
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
        <p className="text-sm text-slate-500 text-center py-12">
          No regattas yet. Import from admin.
        </p>
      ) : filtered.length === 0 ? (
        <div className="glass-panel rounded-2xl p-12 text-center border border-white/5 space-y-3">
          <Search className="h-8 w-8 text-slate-600 mx-auto" />
          <p className="text-sm text-slate-400 font-semibold">
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
            className="text-xs text-orange-400 hover:underline font-bold"
          >
            Reset all filters
          </button>
        </div>
      ) : (
        <div className="space-y-10">
          {grouped.map(([periodLabel, list]) => (
            <section key={periodLabel} className="space-y-4">
              <div className="flex items-center gap-2 border-b border-white/5 pb-2">
                <Calendar className="h-4 w-4 text-orange-400" />
                <h2 className="text-base font-black text-white uppercase tracking-wider">
                  {periodLabel}
                </h2>
                <span className="ml-auto text-xs font-bold text-slate-500 bg-white/5 px-2.5 py-0.5 rounded-full">
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
                        href={`/sg/optimist/regattas/${r.slug}`}
                        className="glass-card rounded-2xl border border-white/5 p-5 hover:border-orange-500/40 transition-all group flex flex-col justify-between gap-4 relative overflow-hidden"
                      >
                        <div className="space-y-2">
                          <div className="flex items-start justify-between gap-3">
                            <h3 className="font-bold text-base text-white group-hover:text-orange-300 transition-colors leading-snug">
                              {r.name}
                            </h3>
                            {isRanking ? (
                              <span className="shrink-0 inline-flex items-center gap-1 rounded-full bg-amber-500/10 border border-amber-500/30 px-2.5 py-0.5 text-[10px] font-black text-amber-400">
                                <Trophy className="h-3 w-3" />
                                Series
                              </span>
                            ) : (
                              <span className="shrink-0 inline-flex items-center gap-1 rounded-full bg-slate-800 border border-slate-700 px-2.5 py-0.5 text-[10px] font-bold text-slate-400">
                                Practice
                              </span>
                            )}
                          </div>
                          <p className="text-xs text-slate-400 flex items-center gap-1.5 font-medium">
                            <Calendar className="h-3.5 w-3.5 shrink-0 text-slate-500" />
                            {formatNiceDate(r.date)}
                          </p>
                        </div>

                        <div className="flex flex-wrap items-center gap-2 text-xs text-slate-300 font-semibold border-t border-white/5 pt-3">
                          <span className="inline-flex items-center gap-1 rounded-lg bg-white/5 px-2.5 py-1 text-[11px]">
                            <Globe className="h-3 w-3 text-slate-400" />
                            {r.geography || "SG"}
                          </span>
                          <span className="inline-flex items-center gap-1 rounded-lg bg-white/5 px-2.5 py-1 text-[11px]">
                            <Sailboat className="h-3 w-3 text-slate-400" />
                            {r.boatClass || "Optimist"}
                          </span>
                          <span className="inline-flex items-center gap-1 rounded-lg bg-white/5 px-2.5 py-1 text-[11px]">
                            <Anchor className="h-3 w-3 text-slate-400" />
                            Fleet {r.totalFleetSize}
                          </span>
                          {r.raceCount != null && r.raceCount > 0 && (
                            <span className="inline-flex items-center gap-1 rounded-lg bg-white/5 px-2.5 py-1 text-[11px]">
                              {r.raceCount} Races
                            </span>
                          )}
                          <span className="ml-auto text-orange-400 text-xs font-bold group-hover:translate-x-0.5 transition-transform">
                            Results →
                          </span>
                        </div>
                      </Link>
                    );
                  })}
                </div>
              ) : (
                /* Compact List View */
                <div className="divide-y divide-white/5 glass-panel rounded-2xl border border-white/5 overflow-hidden">
                  {list.map((r) => {
                    const isRanking = r.countsForRanking !== false;
                    return (
                      <Link
                        key={r.id}
                        href={`/sg/optimist/regattas/${r.slug}`}
                        className="p-4 hover:bg-white/5 transition-colors flex flex-col sm:flex-row sm:items-center justify-between gap-3 group"
                      >
                        <div className="min-w-0 space-y-1">
                          <div className="flex items-center gap-2">
                            <span className="font-bold text-white group-hover:text-orange-300 transition-colors">
                              {r.name}
                            </span>
                            {isRanking ? (
                              <span className="rounded-full bg-amber-500/10 border border-amber-500/30 px-2 py-0.5 text-[9px] font-black text-amber-400">
                                Series
                              </span>
                            ) : (
                              <span className="rounded-full bg-slate-800 border border-slate-700 px-2 py-0.5 text-[9px] font-bold text-slate-400">
                                Non-Ranking
                              </span>
                            )}
                          </div>
                          <p className="text-xs text-slate-400">
                            {formatNiceDate(r.date)} • {r.geography || "SG"} • Fleet {r.totalFleetSize}
                          </p>
                        </div>

                        <div className="flex items-center gap-3 shrink-0">
                          <span className="text-xs font-bold text-orange-400 group-hover:underline">
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
