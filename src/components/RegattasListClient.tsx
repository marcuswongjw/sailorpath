"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import { Calendar, Search, Anchor, Globe, Sailboat } from "lucide-react";

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
  const [division, setDivision] = useState<string>("all");
  const [period, setPeriod] = useState<string>("all");
  const [geography, setGeography] = useState<string>("all");
  const [boatClass, setBoatClass] = useState<string>("all");

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
  }, [regattas, query, division, period, geography, boatClass]);

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
    <div className="mx-auto max-w-5xl w-full px-4 py-8 sm:py-12 space-y-6">
      <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-3">
        <div>
          <p className="text-xs font-bold text-orange-400 uppercase tracking-wide">
            Events
          </p>
          <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
            Regattas
          </h1>
          <p className="text-xs sm:text-sm text-slate-500 mt-1">
            Filter by country, class, fleet division, and period.
          </p>
        </div>
        <p className="text-[11px] text-slate-500 font-semibold">
          {filtered.length} of {regattas.length} events
        </p>
      </div>

      <div className="glass-panel rounded-2xl border border-white/5 p-3 sm:p-4 space-y-3 w-full">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-500" />
          <input
            type="search"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Search regatta name…"
            className="w-full rounded-xl bg-slate-950 border border-white/10 pl-10 pr-3 py-2.5 text-sm text-white placeholder-slate-500"
          />
        </div>
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-2">
          <select
            value={geography}
            onChange={(e) => setGeography(e.target.value)}
            className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-xs sm:text-sm text-white font-semibold"
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
            value={boatClass}
            onChange={(e) => setBoatClass(e.target.value)}
            className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-xs sm:text-sm text-white font-semibold"
            aria-label="Boat class"
          >
            <option value="all">All classes</option>
            {classes.map((c) => (
              <option key={c} value={c}>
                {c}
              </option>
            ))}
          </select>
          <select
            value={division}
            onChange={(e) => setDivision(e.target.value)}
            className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-xs sm:text-sm text-white font-semibold"
          >
            <option value="all">All divisions</option>
            <option value="Gold">Gold</option>
            <option value="Silver">Silver</option>
            <option value="Both">Both</option>
          </select>
          <select
            value={period}
            onChange={(e) => setPeriod(e.target.value)}
            className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-xs sm:text-sm text-white font-semibold"
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

      {regattas.length === 0 ? (
        <p className="text-sm text-slate-500">No regattas yet. Import from admin.</p>
      ) : filtered.length === 0 ? (
        <p className="text-sm text-slate-500 text-center py-10">
          No events match your filters.
        </p>
      ) : (
        <div className="space-y-8">
          {grouped.map(([periodLabel, list]) => (
            <section key={periodLabel} className="space-y-3">
              <div className="flex items-center gap-2">
                <Calendar className="h-4 w-4 text-orange-400" />
                <h2 className="text-sm font-black text-white uppercase tracking-wider">
                  {periodLabel}
                </h2>
                <span className="text-[10px] text-slate-600 font-bold">
                  {list.length}
                </span>
              </div>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                {list.map((r) => (
                  <Link
                    key={r.id}
                    href={`/sg/optimist/regattas/${r.slug}`}
                    className="glass-card rounded-2xl border border-white/5 p-4 sm:p-5 hover:border-orange-500/35 transition-all group flex flex-col gap-3"
                  >
                    <div className="flex items-start justify-between gap-3">
                      <div className="min-w-0">
                        <p className="font-bold text-white group-hover:text-orange-300 transition-colors leading-snug">
                          {r.name}
                        </p>
                        <p className="text-[11px] text-slate-500 mt-1.5 flex items-center gap-1.5 font-medium">
                          <Calendar className="h-3.5 w-3.5 shrink-0 text-slate-600" />
                          {formatNiceDate(r.date)}
                        </p>
                      </div>
                      <span className="shrink-0 rounded-full bg-orange-500/10 border border-orange-500/20 px-2 py-0.5 text-[10px] font-black text-orange-400">
                        {r.division || "Gold"}
                      </span>
                    </div>
                    <div className="flex flex-wrap items-center gap-2 text-[11px] text-slate-400 font-semibold border-t border-white/5 pt-3">
                      <span className="inline-flex items-center gap-1 rounded-lg bg-white/5 px-2 py-1">
                        <Globe className="h-3 w-3 text-slate-500" />
                        {r.geography || "SG"}
                      </span>
                      <span className="inline-flex items-center gap-1 rounded-lg bg-white/5 px-2 py-1">
                        <Sailboat className="h-3 w-3 text-slate-500" />
                        {r.boatClass || "Optimist"}
                      </span>
                      <span className="inline-flex items-center gap-1 rounded-lg bg-white/5 px-2 py-1">
                        <Anchor className="h-3 w-3 text-slate-500" />
                        Fleet {r.totalFleetSize}
                      </span>
                      <span className="ml-auto text-orange-400/90 text-[10px] font-bold group-hover:underline">
                        Results →
                      </span>
                    </div>
                  </Link>
                ))}
              </div>
            </section>
          ))}
        </div>
      )}
    </div>
  );
}
