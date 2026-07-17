"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import type { RankedSailor, Period } from "@/lib/ranking";
import { getPercentileBadge } from "@/lib/ranking";

const PERIODS: Period[] = [
  { year: 2026, half: "Jan-Jun" },
  { year: 2025, half: "Jul-Dec" },
  { year: 2025, half: "Jan-Jun" },
  { year: 2024, half: "Jul-Dec" },
  { year: 2024, half: "Jan-Jun" },
];

export function FleetRankingsView({
  fleet,
  initialPeriod,
}: {
  fleet: "Gold" | "Silver";
  initialPeriod?: Period;
}) {
  const [period, setPeriod] = useState<Period>(initialPeriod || PERIODS[0]);
  const [ranked, setRanked] = useState<RankedSailor[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      setLoading(true);
      setError(null);
      try {
        const res = await fetch(
          `/api/rankings?fleet=${fleet}&year=${period.year}&half=${encodeURIComponent(period.half)}`
        );
        const data = await res.json();
        if (!res.ok) throw new Error(data.error || "Failed to load rankings");
        if (!cancelled) setRanked(data.ranked || []);
      } catch (e) {
        if (!cancelled) {
          setRanked([]);
          setError(e instanceof Error ? e.message : "Error");
        }
      } finally {
        if (!cancelled) setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [fleet, period]);

  return (
    <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-8 sm:py-12 space-y-6">
      <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-4">
        <div>
          <p className="text-xs font-bold text-orange-400 uppercase tracking-wide">
            SG Optimist
          </p>
          <h1 className="text-2xl sm:text-3xl lg:text-4xl font-black text-white">
            {fleet} Fleet Standings
          </h1>
          <p className="text-xs sm:text-sm text-slate-500 mt-1">
            Best 3 of 5 · DNS = fleet size + 1 · rank-based scoring
          </p>
        </div>
        <select
          value={`${period.year}|${period.half}`}
          onChange={(e) => {
            const [year, half] = e.target.value.split("|");
            setPeriod({ year: Number(year), half: half as Period["half"] });
          }}
          className="w-full sm:w-auto rounded-xl bg-slate-950 border border-white/10 px-4 py-2.5 text-sm text-white"
        >
          {PERIODS.map((p) => (
            <option key={`${p.year}-${p.half}`} value={`${p.year}|${p.half}`}>
              {p.year} {p.half}
            </option>
          ))}
        </select>
      </div>

      {loading && <p className="text-sm text-slate-500">Loading rankings…</p>}
      {error && (
        <div className="rounded-xl border border-rose-500/30 bg-rose-500/10 p-4 text-xs sm:text-sm text-rose-300">
          {error}{" "}
          <Link href="/api/health" className="underline font-bold">
            Check /api/health
          </Link>
        </div>
      )}
      {!loading && !error && ranked.length === 0 && (
        <p className="text-sm text-slate-500">
          No ranked sailors for this period. Import regattas in admin and set
          gold/silver entry dates.{" "}
          <Link href="/sample" className="text-orange-400 font-bold">
            View sample profile
          </Link>
        </p>
      )}

      {/* Mobile cards */}
      <div className="md:hidden space-y-3">
        {ranked.map((s, i) => {
          const badge = getPercentileBadge(i + 1, ranked.length);
          return (
            <Link
              key={s.id}
              href={`/${s.handle}`}
              className="block glass-card rounded-2xl p-4 border border-white/5"
            >
              <div className="flex items-start justify-between gap-3">
                <div>
                  <p className="text-orange-400 font-black text-sm">#{i + 1}</p>
                  <p className="font-bold text-white mt-0.5">{s.name}</p>
                  <p className="text-xs text-slate-500 mt-1">
                    {s.sailNumber} · {s.club}
                  </p>
                </div>
                <div className="text-right">
                  <p className="font-black text-white text-lg">{s.overallScore}</p>
                  <span
                    className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${badge.className}`}
                  >
                    {badge.label}
                  </span>
                </div>
              </div>
              <p className="mt-3 text-[11px] font-mono text-slate-400">
                Best 3: {s.bestThreeScores.join(" · ")}
              </p>
            </Link>
          );
        })}
      </div>

      {/* Desktop table */}
      <div className="hidden md:block overflow-x-auto rounded-2xl border border-white/5">
        <table className="w-full text-left text-sm min-w-[720px]">
          <thead className="bg-white/5 text-xs text-slate-400 uppercase">
            <tr>
              <th className="px-4 lg:px-6 py-3">#</th>
              <th className="px-4 lg:px-6 py-3">Sailor</th>
              <th className="px-4 lg:px-6 py-3">Sail #</th>
              <th className="px-4 lg:px-6 py-3 hidden lg:table-cell">Club</th>
              <th className="px-4 lg:px-6 py-3">Best 3</th>
              <th className="px-4 lg:px-6 py-3">Overall</th>
              <th className="px-4 lg:px-6 py-3">Badge</th>
            </tr>
          </thead>
          <tbody>
            {ranked.map((s, i) => {
              const badge = getPercentileBadge(i + 1, ranked.length);
              return (
                <tr
                  key={s.id}
                  className="border-t border-white/5 hover:bg-white/[0.02]"
                >
                  <td className="px-4 lg:px-6 py-3.5 font-bold text-orange-400">
                    {i + 1}
                  </td>
                  <td className="px-4 lg:px-6 py-3.5">
                    <Link
                      href={`/${s.handle}`}
                      className="font-bold text-white hover:text-orange-400"
                    >
                      {s.name}
                    </Link>
                  </td>
                  <td className="px-4 lg:px-6 py-3.5 text-slate-400">
                    {s.sailNumber}
                  </td>
                  <td className="px-4 lg:px-6 py-3.5 text-slate-400 hidden lg:table-cell">
                    {s.club}
                  </td>
                  <td className="px-4 lg:px-6 py-3.5 text-slate-300 font-mono text-xs">
                    {s.bestThreeScores.join(" · ")}
                  </td>
                  <td className="px-4 lg:px-6 py-3.5 font-black text-white">
                    {s.overallScore}
                  </td>
                  <td className="px-4 lg:px-6 py-3.5">
                    <span
                      className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${badge.className}`}
                    >
                      {badge.label}
                    </span>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </div>
  );
}
