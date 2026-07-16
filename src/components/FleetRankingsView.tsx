"use client";

import { useState } from "react";
import Link from "next/link";
import { RankedSailor, Period } from "@/lib/ranking";
import { Trophy, Calendar, Sparkles, Medal, ArrowRight, RefreshCw } from "lucide-react";

interface FleetRankingsViewProps {
  fleet: "Gold" | "Silver";
  initialRankings: RankedSailor[];
  initialRegattasUsed: any[];
  isDemo: boolean;
  initialPeriod?: Period;
}

function parsePeriodValue(value: string): Period {
  const [yearStr, halfKey] = value.split("-");
  const year = Number(yearStr);
  const half = halfKey === "Jul-Dec" ? "Jul-Dec" : "Jan-Jun";
  return { year, half: half as Period["half"] };
}

export function FleetRankingsView({
  fleet,
  initialRankings,
  initialRegattasUsed,
  isDemo,
  initialPeriod = { year: 2026, half: "Jan-Jun" },
}: FleetRankingsViewProps) {
  const defaultValue = `${initialPeriod.year}-${initialPeriod.half}`;
  const [selectedPeriod, setSelectedPeriod] = useState(defaultValue);
  const [rankings, setRankings] = useState(initialRankings);
  const [regattasUsed, setRegattasUsed] = useState(initialRegattasUsed);
  const [loading, setLoading] = useState(false);
  const [demoFlag, setDemoFlag] = useState(isDemo);

  const periods = [
    { value: "2026-Jan-Jun", label: "Jan - Jun 2026 (Current)" },
    { value: "2025-Jul-Dec", label: "Jul - Dec 2025 (Previous)" },
    { value: "2025-Jan-Jun", label: "Jan - Jun 2025" },
    { value: "2024-Jul-Dec", label: "Jul - Dec 2024" },
  ];

  async function onPeriodChange(value: string) {
    setSelectedPeriod(value);
    setLoading(true);
    try {
      const p = parsePeriodValue(value);
      const res = await fetch(
        `/api/rankings?fleet=${encodeURIComponent(fleet)}&year=${p.year}&half=${encodeURIComponent(p.half)}`
      );
      const data = await res.json();
      if (data.data) {
        setRankings(data.data.rankings || []);
        setRegattasUsed(data.data.regattasUsed || []);
        setDemoFlag(!!data.isDemo);
      }
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-12 flex-1 flex flex-col gap-8">
      <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-6">
        <div>
          <div className="flex items-center gap-2">
            <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-orange-600/10 text-orange-500 border border-orange-500/20">
              <Trophy className="h-5 w-5" />
            </span>
            <div>
              <h1 className="text-3xl font-black text-white tracking-tight">
                Optimist {fleet} Fleet Rankings
              </h1>
              <p className="text-xs text-slate-400 mt-0.5">
                Official Singapore national rankings · best 3 of 5 most recent regattas · DNS =
                fleet size + 1
                {demoFlag ? " · demo data" : ""}
              </p>
            </div>
          </div>
        </div>

        <div className="flex items-center gap-2">
          <Calendar className="h-4 w-4 text-orange-500" />
          <span className="text-xs font-bold text-slate-400 uppercase">Period:</span>
          <select
            value={selectedPeriod}
            onChange={(e) => onPeriodChange(e.target.value)}
            disabled={loading}
            className="rounded-lg bg-slate-800 border border-white/5 text-white px-3 py-1.5 text-xs font-bold focus:border-orange-500 focus:outline-none"
          >
            {periods.map((p) => (
              <option key={p.value} value={p.value}>
                {p.label}
              </option>
            ))}
          </select>
          {loading && <RefreshCw className="h-4 w-4 text-orange-500 animate-spin" />}
        </div>
      </div>

      <div className="glass-card rounded-2xl p-6 border border-white/5">
        <h2 className="text-xs font-bold text-slate-400 tracking-wider uppercase mb-4 flex items-center gap-2">
          <Sparkles className="h-4 w-4 text-orange-500" />
          REGATTAS SCORING IN THIS PERIOD
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-5 gap-3">
          {regattasUsed.map((reg) => (
            <Link
              key={reg.id}
              href={`/sg/optimist/regattas/${reg.slug}`}
              className="bg-white/5 border border-white/5 hover:border-orange-500/20 rounded-xl p-3 flex flex-col justify-between group transition-all"
            >
              <div>
                <div className="text-xs font-bold text-white group-hover:text-orange-400 transition-colors">
                  {reg.name}
                </div>
                <div className="text-[10px] text-slate-500 mt-1">{reg.date}</div>
              </div>
              <div className="mt-2 text-[10px] text-slate-400 flex items-center gap-1">
                Fleet {reg.totalFleetSize}
                <ArrowRight className="h-3 w-3 opacity-0 group-hover:opacity-100" />
              </div>
            </Link>
          ))}
          {!regattasUsed.length && (
            <p className="text-xs text-slate-500 col-span-full">No ranking regattas in this window.</p>
          )}
        </div>
      </div>

      <div className="glass-card rounded-2xl border border-white/5 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-sm">
            <thead className="bg-white/5 text-[10px] uppercase tracking-wider text-slate-400">
              <tr>
                <th className="px-4 py-3 font-bold">#</th>
                <th className="px-4 py-3 font-bold">Sailor</th>
                <th className="px-4 py-3 font-bold">Sail #</th>
                <th className="px-4 py-3 font-bold">Club</th>
                <th className="px-4 py-3 font-bold">Best-3</th>
              </tr>
            </thead>
            <tbody>
              {rankings.map((sailor, idx) => (
                <tr
                  key={sailor.id}
                  className="border-t border-white/5 hover:bg-orange-500/5 transition-colors"
                >
                  <td className="px-4 py-3 font-black text-white tabular-nums">
                    {idx + 1}
                    {idx < 3 && (
                      <Medal className="inline h-3.5 w-3.5 ml-1 text-orange-400" />
                    )}
                  </td>
                  <td className="px-4 py-3">
                    <Link
                      href={`/${sailor.handle}`}
                      className="font-bold text-orange-400 hover:text-orange-300"
                    >
                      {sailor.name}
                    </Link>
                  </td>
                  <td className="px-4 py-3 font-mono text-xs text-slate-400">
                    {sailor.sailNumber}
                  </td>
                  <td className="px-4 py-3 text-slate-400">{sailor.club}</td>
                  <td className="px-4 py-3 font-black text-white tabular-nums">
                    {sailor.overallScore}
                  </td>
                </tr>
              ))}
              {!rankings.length && (
                <tr>
                  <td colSpan={5} className="px-4 py-10 text-center text-slate-500 text-xs">
                    No sailors active in this fleet for the selected period.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
