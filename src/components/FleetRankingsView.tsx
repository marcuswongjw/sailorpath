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
  const [period, setPeriod] = useState<Period>(
    initialPeriod || PERIODS[0]
  );
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
    <div className="mx-auto max-w-5xl px-4 py-10 space-y-6">
      <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4">
        <div>
          <p className="text-xs font-bold text-orange-400 uppercase tracking-wide">
            SG Optimist
          </p>
          <h1 className="text-3xl font-black text-white">{fleet} Fleet</h1>
          <p className="text-xs text-slate-500 mt-1">
            Best 3 of 5 · DNS = fleet size + 1
          </p>
        </div>
        <select
          value={`${period.year}|${period.half}`}
          onChange={(e) => {
            const [year, half] = e.target.value.split("|");
            setPeriod({ year: Number(year), half: half as Period["half"] });
          }}
          className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-xs text-white"
        >
          {PERIODS.map((p) => (
            <option key={`${p.year}-${p.half}`} value={`${p.year}|${p.half}`}>
              {p.year} {p.half}
            </option>
          ))}
        </select>
      </div>

      {loading && (
        <p className="text-sm text-slate-500">Loading rankings…</p>
      )}
      {error && (
        <div className="rounded-xl border border-rose-500/30 bg-rose-500/10 p-4 text-xs text-rose-300">
          {error}{" "}
          <Link href="/api/health" className="underline font-bold">
            Check /api/health
          </Link>
        </div>
      )}
      {!loading && !error && ranked.length === 0 && (
        <p className="text-sm text-slate-500">
          No ranked sailors for this period. Import regattas in admin and set
          gold/silver entry dates.
        </p>
      )}

      <div className="overflow-x-auto rounded-2xl border border-white/5">
        <table className="w-full text-left text-sm">
          <thead className="bg-white/5 text-xs text-slate-400 uppercase">
            <tr>
              <th className="px-4 py-3">#</th>
              <th className="px-4 py-3">Sailor</th>
              <th className="px-4 py-3">Sail #</th>
              <th className="px-4 py-3">Best 3</th>
              <th className="px-4 py-3">Overall</th>
              <th className="px-4 py-3">Badge</th>
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
                  <td className="px-4 py-3 font-bold text-orange-400">
                    {i + 1}
                  </td>
                  <td className="px-4 py-3">
                    <Link
                      href={`/${s.handle}`}
                      className="font-bold text-white hover:text-orange-400"
                    >
                      {s.name}
                    </Link>
                  </td>
                  <td className="px-4 py-3 text-slate-400">{s.sailNumber}</td>
                  <td className="px-4 py-3 text-slate-300 font-mono text-xs">
                    {s.bestThreeScores.join(" · ")}
                  </td>
                  <td className="px-4 py-3 font-black text-white">
                    {s.overallScore}
                  </td>
                  <td className="px-4 py-3">
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
