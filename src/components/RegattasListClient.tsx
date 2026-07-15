"use client";

import { useState } from "react";
import Link from "next/link";
import { Trophy, Calendar, Users, ChevronRight, Compass } from "lucide-react";
import { RegattaRecord } from "@/lib/ranking";

interface RegattasListClientProps {
  initialRegattas: RegattaRecord[];
}

export function RegattasListClient({ initialRegattas }: RegattasListClientProps) {
  const [selectedTab, setSelectedTab] = useState<"all" | "Gold" | "Silver">("all");

  const filteredRegattas = initialRegattas.filter((reg) => {
    if (selectedTab === "all") return true;
    const div = reg.division || "Gold";
    return div === selectedTab || div === "Both";
  });

  return (
    <div className="space-y-8">
      {/* Fleet Filter Tabs */}
      <div className="flex border-b border-white/5 p-1 max-w-md bg-slate-950/60 rounded-2xl">
        <button
          onClick={() => setSelectedTab("all")}
          className={`flex-1 py-2 text-xs font-bold rounded-xl transition-all ${
            selectedTab === "all"
              ? "bg-orange-600 text-white shadow-lg shadow-orange-950/30"
              : "text-slate-400 hover:text-white"
          }`}
        >
          All Fleet Trials
        </button>
        <button
          onClick={() => setSelectedTab("Gold")}
          className={`flex-1 py-2 text-xs font-bold rounded-xl transition-all ${
            selectedTab === "Gold"
              ? "bg-orange-600 text-white shadow-lg shadow-orange-950/30"
              : "text-slate-400 hover:text-white"
          }`}
        >
          Gold Fleet
        </button>
        <button
          onClick={() => setSelectedTab("Silver")}
          className={`flex-1 py-2 text-xs font-bold rounded-xl transition-all ${
            selectedTab === "Silver"
              ? "bg-orange-600 text-white shadow-lg shadow-orange-950/30"
              : "text-slate-400 hover:text-white"
          }`}
        >
          Silver Fleet
        </button>
      </div>

      {/* Regattas Grid */}
      {filteredRegattas.length === 0 ? (
        <div className="glass-panel rounded-3xl p-12 text-center border border-white/5 flex flex-col items-center">
          <Compass className="h-8 w-8 text-slate-600 mb-2" />
          <p className="text-sm text-slate-400">No regattas found in this division split.</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {filteredRegattas.map((reg) => {
            const div = reg.division || "Gold";
            return (
              <Link
                key={reg.id}
                href={`/sg/optimist/regattas/${reg.slug}`}
                className="block glass-card rounded-2xl p-6 border border-white/5 hover:border-orange-500/20 hover:scale-[1.01] transition-all group relative overflow-hidden"
              >
                {/* Visual Glow */}
                <div className="absolute top-0 right-0 w-24 h-24 bg-orange-600/5 rounded-full blur-2xl group-hover:bg-orange-600/10 transition-all" />

                <div className="flex items-center justify-between">
                  <div className="space-y-3">
                    <div className="flex items-center gap-2">
                      <span className={`inline-flex items-center rounded-full px-2.5 py-0.5 text-[9px] font-black uppercase tracking-wider border ${
                        div === "Both"
                          ? "bg-purple-500/10 text-purple-400 border-purple-500/20"
                          : div === "Gold"
                          ? "bg-yellow-500/10 text-yellow-400 border-yellow-500/20"
                          : "bg-blue-500/10 text-blue-400 border-blue-500/20"
                      }`}>
                        {div === "Both" ? "Gold & Silver Split" : `${div} Fleet`}
                      </span>
                    </div>

                    <h2 className="text-base font-bold text-white group-hover:text-orange-500 transition-colors leading-tight">
                      {reg.name}
                    </h2>
                    
                    <div className="flex items-center gap-4 text-xs font-semibold text-slate-400 pt-1">
                      <span className="flex items-center gap-1">
                        <Calendar className="h-3.5 w-3.5 text-orange-500" />
                        {reg.date}
                      </span>
                      <span className="flex items-center gap-1">
                        <Users className="h-3.5 w-3.5 text-orange-500" />
                        {reg.totalFleetSize} Competitors
                      </span>
                    </div>
                  </div>

                  <div className="h-8 w-8 rounded-full bg-slate-900 border border-white/5 flex items-center justify-center text-slate-400 group-hover:bg-orange-600 group-hover:text-white transition-all flex-shrink-0 ml-4">
                    <ChevronRight className="h-4 w-4" />
                  </div>
                </div>
              </Link>
            );
          })}
        </div>
      )}
    </div>
  );
}
