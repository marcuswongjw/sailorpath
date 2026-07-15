"use client";

import { useState } from "react";
import Link from "next/link";
import { RankedSailor } from "@/lib/ranking";
import { Trophy, Calendar, Sparkles, Medal, ArrowRight } from "lucide-react";

interface FleetRankingsViewProps {
  fleet: "Gold" | "Silver";
  initialRankings: RankedSailor[];
  initialRegattasUsed: any[];
  isDemo: boolean;
}

export function FleetRankingsView({
  fleet,
  initialRankings,
  initialRegattasUsed,
  isDemo,
}: FleetRankingsViewProps) {
  const [selectedPeriod, setSelectedPeriod] = useState("2026-Jan-Jun");

  // Periods list
  const periods = [
    { value: "2026-Jan-Jun", label: "Jan - Jun 2026 (Current)" },
    { value: "2025-Jul-Dec", label: "Jul - Dec 2025 (Previous)" },
  ];

  return (
    <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-12 flex-1 flex flex-col gap-8">
      {/* Page Header */}
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
                Official Singapore national rankings computed using best 3 of the 5 most recent regattas.
              </p>
            </div>
          </div>
        </div>

        {/* Period Selector Dropdown */}
        <div className="flex items-center gap-2">
          <Calendar className="h-4 w-4 text-orange-500" />
          <span className="text-xs font-bold text-slate-400 uppercase">Period:</span>
          <select
            value={selectedPeriod}
            onChange={(e) => setSelectedPeriod(e.target.value)}
            className="rounded-lg bg-slate-800 border border-white/5 text-white px-3 py-1.5 text-xs font-bold focus:border-orange-500 focus:outline-none"
          >
            {periods.map((p) => (
              <option key={p.value} value={p.value}>
                {p.label}
              </option>
            ))}
          </select>
        </div>
      </div>

      {/* Regattas Used Summary Card */}
      <div className="glass-card rounded-2xl p-6 border border-white/5">
        <h2 className="text-xs font-bold text-slate-400 tracking-wider uppercase mb-4 flex items-center gap-2">
          <Sparkles className="h-4 w-4 text-orange-500" />
          REGATTAS SCORING IN THIS PERIOD
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-5 gap-3">
          {initialRegattasUsed.map((reg, idx) => (
            <Link
              key={reg.id}
              href={`/sg/optimist/regattas/${reg.slug}`}
              className="bg-white/5 border border-white/5 hover:border-orange-500/20 rounded-xl p-3 flex flex-col justify-between group transition-all"
            >
              <div>
                <span className="text-[10px] font-bold text-orange-400 font-mono">R0{idx + 1}</span>
                <p className="text-xs font-bold text-white mt-1 line-clamp-1 group-hover:text-orange-500 transition-colors">
                  {reg.name}
                </p>
              </div>
              <div className="mt-4 flex justify-between items-center text-[10px] text-slate-500 font-semibold">
                <span>Fleet: {reg.totalFleetSize}</span>
                <span className="flex items-center gap-0.5 text-orange-400 group-hover:translate-x-0.5 transition-transform">
                  View <ArrowRight className="h-2 w-2" />
                </span>
              </div>
            </Link>
          ))}
        </div>
      </div>

      {/* Leaderboard Table */}
      <div className="glass-panel rounded-3xl border border-white/5 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="border-b border-white/5 bg-white/5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                <th className="py-4 px-6 text-center w-16">Rank</th>
                <th className="py-4 px-6">Sailor</th>
                <th className="py-4 px-6 text-center w-20">Age</th>
                <th className="py-4 px-6 text-center w-20">Gender</th>
                {fleet === "Gold" && (
                  <th className="py-4 px-6 text-center w-24">Squad</th>
                )}
                {initialRegattasUsed.map((_, idx) => (
                  <th key={idx} className="py-4 px-4 text-center w-24">
                    R0{idx + 1}
                  </th>
                ))}
                <th className="py-4 px-6 text-right w-28">Overall Points</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-white/5 text-sm font-medium">
              {initialRankings.length === 0 ? (
                <tr>
                  <td colSpan={5 + initialRegattasUsed.length} className="text-center py-12 text-slate-400">
                    No active sailors resolved in this fleet for the selected period.
                  </td>
                </tr>
              ) : (
                initialRankings.map((sailor, idx) => {
                  const isPodium = idx < 3;
                  const podiumColors =
                    idx === 0
                      ? "text-yellow-400 bg-yellow-500/10 border-yellow-500/20"
                      : idx === 1
                      ? "text-slate-300 bg-slate-400/10 border-slate-400/20"
                      : "text-amber-600 bg-amber-700/10 border-amber-700/20";

                  // Calculate age by birth year
                  const birthYear = sailor.dob ? new Date(sailor.dob).getFullYear() : null;
                  const currentYear = new Date().getFullYear();
                  const ageByBirthYear = birthYear ? currentYear - birthYear : "N/A";
                  const gender = sailor.gender || "N/A";
                  const squad = sailor.nationalSquadStatus || "-";

                  return (
                    <tr key={sailor.id} className="hover:bg-white/5 transition-colors">
                      {/* Rank Column */}
                      <td className="py-4 px-6 text-center">
                        {isPodium ? (
                          <span
                            className={`inline-flex h-7 w-7 items-center justify-center rounded-full border text-xs font-black ${podiumColors}`}
                          >
                            {idx + 1}
                          </span>
                        ) : (
                          <span className="text-slate-400 font-bold">{idx + 1}</span>
                        )}
                      </td>

                      {/* Sailor Name & Sail Number */}
                      <td className="py-4 px-6">
                        <Link href={`/${sailor.handle}`} className="group block">
                          <span className="block font-bold text-white group-hover:text-orange-500 transition-colors">
                            {sailor.firstName} {sailor.lastName}
                          </span>
                          <span className="block text-xs text-slate-500 font-mono mt-0.5">
                            {sailor.sailNumber}
                          </span>
                        </Link>
                      </td>

                      {/* Age */}
                      <td className="py-4 px-6 text-center text-slate-300 text-xs font-mono font-bold">
                        {ageByBirthYear}
                      </td>

                      {/* Gender */}
                      <td className="py-4 px-6 text-center text-slate-300 text-xs font-bold">
                        {gender}
                      </td>

                      {/* Squad (Gold Only) */}
                      {fleet === "Gold" && (
                        <td className="py-4 px-6 text-center">
                          <span className={`inline-block px-2 py-0.5 rounded text-[10px] font-extrabold ${
                            squad === "Nat A"
                              ? "bg-red-500/10 text-red-400 border border-red-500/20"
                              : squad === "Nat B"
                              ? "bg-blue-500/10 text-blue-400 border border-blue-500/20"
                              : squad === "DS"
                              ? "bg-amber-500/10 text-amber-400 border border-amber-500/20"
                              : "text-slate-500"
                          }`}>
                            {squad}
                          </span>
                        </td>
                      )}

                      {/* Individual Regatta Scores */}
                      {initialRegattasUsed.map((reg) => {
                        const scoreInfo = sailor.regattaScores.find((rs) => rs.regattaId === reg.id);
                        if (!scoreInfo) {
                          return (
                            <td key={reg.id} className="py-4 px-4 text-center text-slate-600">
                              -
                            </td>
                          );
                        }

                        const score = scoreInfo.score;
                        const isDNS = scoreInfo.isDNS;

                        return (
                          <td key={reg.id} className="py-4 px-4 text-center font-mono">
                            <span
                              className={`inline-block px-2 py-0.5 rounded text-xs font-bold ${
                                isDNS
                                  ? "bg-rose-500/10 text-rose-500 border border-rose-500/20"
                                  : "bg-slate-800 text-slate-300"
                              }`}
                            >
                              {score}
                            </span>
                          </td>
                        );
                      })}

                      {/* Overall Score */}
                      <td className="py-4 px-6 text-right font-black text-white text-base">
                        {sailor.overallScore}
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Squad Criteria details card for Gold Fleet */}
      {fleet === "Gold" && (
        <div className="glass-card rounded-2xl p-6 border border-white/5 space-y-4">
          <h2 className="text-xs font-bold text-slate-400 tracking-wider uppercase flex items-center gap-2">
            <Trophy className="h-4 w-4 text-orange-500" />
            National Squad Qualification Criteria
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 text-xs leading-relaxed text-slate-400">
            <div className="bg-white/5 p-4 rounded-xl border border-white/5 space-y-1">
              <h3 className="font-bold text-white flex items-center gap-1.5">
                <span className="h-2 w-2 rounded-full bg-red-500" />
                National A Squad (Nat A)
              </h3>
              <p className="text-[11px] text-slate-400">
                Typically the top 5 sailors on the final trial leaderboard. Selected to represent Team Singapore at the IODA World Championship and Asian Games.
              </p>
            </div>
            <div className="bg-white/5 p-4 rounded-xl border border-white/5 space-y-1">
              <h3 className="font-bold text-white flex items-center gap-1.5">
                <span className="h-2 w-2 rounded-full bg-blue-500" />
                National B Squad (Nat B)
              </h3>
              <p className="text-[11px] text-slate-400">
                Typically ranks 6-15 on the ranking board. Represent Singapore at continental championships (Europeans, North Americans).
              </p>
            </div>
            <div className="bg-white/5 p-4 rounded-xl border border-white/5 space-y-1">
              <h3 className="font-bold text-white flex items-center gap-1.5">
                <span className="h-2 w-2 rounded-full bg-amber-500" />
                Development Squad (DS)
              </h3>
              <p className="text-[11px] text-slate-400">
                Promising younger sailors (U12 top performers or ranks 16-30) selected for specialized training blocks to prepare for the National A/B squad pathway.
              </p>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
