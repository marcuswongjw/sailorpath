"use client";

import { useState } from "react";
import Link from "next/link";
import {
  Trophy,
  User,
  Users,
  Compass,
  ArrowRight,
  Shield,
} from "lucide-react";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";

type PreviewTab = "standings" | "profile" | "coach";
type StandingsClass = "optimist" | "ilca4" | "wingfoil";

const SAMPLE_STANDINGS: Record<
  StandingsClass,
  {
    title: string;
    subtitle: string;
    link: string;
    linkLabel: string;
    rows: Array<{
      rank: number;
      name: string;
      sailNumber: string;
      club: string;
      score: string;
      scoreLabel: string;
      tag: string;
      tagColor: string;
    }>;
  }
> = {
  optimist: {
    title: "Optimist Gold Fleet",
    subtitle: "Rolling Best 3 of 5 Series · Appendix A Discard Scoring",
    link: "/sg/optimist/gold",
    linkLabel: "Open Full Gold Rankings",
    rows: [
      {
        rank: 1,
        name: "Lucas Wong",
        sailNumber: "SGP 4658",
        club: "SAF Yacht Club",
        score: "4.0",
        scoreLabel: "Best 3 Nett",
        tag: "National Squad A",
        tagColor: "bg-emerald-500/15 text-emerald-300 border-emerald-500/30",
      },
      {
        rank: 2,
        name: "Chloe Tan",
        sailNumber: "SGP 4612",
        club: "Singapore Sailing Club",
        score: "7.0",
        scoreLabel: "Best 3 Nett",
        tag: "National Squad A",
        tagColor: "bg-emerald-500/15 text-emerald-300 border-emerald-500/30",
      },
      {
        rank: 3,
        name: "Ethan Lee",
        sailNumber: "SGP 4589",
        club: "Changi Sailing Club",
        score: "11.0",
        scoreLabel: "Best 3 Nett",
        tag: "National Squad B",
        tagColor: "bg-sky-500/15 text-sky-300 border-sky-500/30",
      },
      {
        rank: 4,
        name: "Sarah Chen",
        sailNumber: "SGP 4701",
        club: "National Sailing Centre",
        score: "14.0",
        scoreLabel: "Best 3 Nett",
        tag: "Asian Trials Bubble",
        tagColor: "bg-amber-500/15 text-amber-300 border-amber-500/30",
      },
    ],
  },
  ilca4: {
    title: "ILCA 4 National Ranking",
    subtitle: "High Ranking Points System · Transition from Optimist",
    link: "/sg/ilca4",
    linkLabel: "Open ILCA 4 Standings",
    rows: [
      {
        rank: 1,
        name: "Kimberly Tan",
        sailNumber: "SGP 214980",
        club: "SAF Yacht Club / RI",
        score: "294.0",
        scoreLabel: "High Points",
        tag: "Youth Squad Leader",
        tagColor: "bg-sky-500/15 text-sky-300 border-sky-500/30",
      },
      {
        rank: 2,
        name: "Marcus Koh",
        sailNumber: "SGP 218402",
        club: "Changi Sailing Club",
        score: "281.5",
        scoreLabel: "High Points",
        tag: "National Squad",
        tagColor: "bg-emerald-500/15 text-emerald-300 border-emerald-500/30",
      },
      {
        rank: 3,
        name: "Aiden Ng",
        sailNumber: "SGP 216310",
        club: "Singapore Sailing Club",
        score: "268.0",
        scoreLabel: "High Points",
        tag: "Top Transition Intake",
        tagColor: "bg-orange-500/15 text-orange-300 border-orange-500/30",
      },
      {
        rank: 4,
        name: "Hannah Lim",
        sailNumber: "SGP 217045",
        club: "National Sailing Centre",
        score: "252.0",
        scoreLabel: "High Points",
        tag: "Youth Squad",
        tagColor: "bg-sky-500/15 text-sky-300 border-sky-500/30",
      },
    ],
  },
  wingfoil: {
    title: "WingFoil Sprint Slalom",
    subtitle: "Downwind Sprint Slalom · Stand-Alone Series with Heats",
    link: "/sg/wingfoil",
    linkLabel: "Open WingFoil Hub",
    rows: [
      {
        rank: 1,
        name: "Daniel Teo",
        sailNumber: "SGP 18",
        club: "Aloha Sea Sports Centre",
        score: "5.0",
        scoreLabel: "Nett (1 Discard)",
        tag: "Slalom Champion",
        tagColor: "bg-purple-500/15 text-purple-300 border-purple-500/30",
      },
      {
        rank: 2,
        name: "Ryan Seah",
        sailNumber: "SGP 09",
        club: "East Coast Foilers",
        score: "8.0",
        scoreLabel: "Nett (1 Discard)",
        tag: "Podium Finisher",
        tagColor: "bg-emerald-500/15 text-emerald-300 border-emerald-500/30",
      },
      {
        rank: 3,
        name: "Julian Gomez",
        sailNumber: "SGP 24",
        club: "Changi Water Sports",
        score: "12.0",
        scoreLabel: "Nett (1 Discard)",
        tag: "Heat 1 Winner",
        tagColor: "bg-amber-500/15 text-amber-300 border-amber-500/30",
      },
      {
        rank: 4,
        name: "Liam Tay",
        sailNumber: "SGP 03",
        club: "Constant Wind",
        score: "15.0",
        scoreLabel: "Nett (1 Discard)",
        tag: "Top Sprint Speed",
        tagColor: "bg-sky-500/15 text-sky-300 border-sky-500/30",
      },
    ],
  },
};

export function HomeLivePreview() {
  const [activeTab, setActiveTab] = useState<PreviewTab>("standings");
  const [selectedClass, setSelectedClass] = useState<StandingsClass>("optimist");

  const standingsData = SAMPLE_STANDINGS[selectedClass];

  return (
    <div className="w-full max-w-5xl mx-auto">
      {/* Outer Card with subtle glow */}
      <div className="relative rounded-3xl border border-white/10 bg-[#0d0f18]/90 backdrop-blur-xl shadow-2xl shadow-black/60 overflow-hidden">
        {/* Ambient Top Glow */}
        <div className="absolute top-0 left-1/2 -translate-x-1/2 h-36 w-3/4 bg-gradient-to-r from-orange-500/10 via-amber-500/10 to-sky-500/10 rounded-full blur-3xl pointer-events-none" />

        {/* Tab Navigation Bar */}
        <div className="relative border-b border-white/10 p-3 sm:p-4 flex flex-wrap items-center justify-between gap-3 bg-white/[0.02]">
          <div className="flex items-center gap-1 sm:gap-2">
            <button
              type="button"
              onClick={() => setActiveTab("standings")}
              className={`inline-flex items-center gap-2 px-3.5 py-2 rounded-xl text-xs font-bold transition-all ${
                activeTab === "standings"
                  ? "bg-orange-600 text-white shadow-md shadow-orange-600/30"
                  : "text-slate-400 hover:text-white hover:bg-white/5"
              }`}
            >
              <Trophy className="h-3.5 w-3.5" />
              <span>Live Standings &amp; Podiums</span>
            </button>
            <button
              type="button"
              onClick={() => setActiveTab("profile")}
              className={`inline-flex items-center gap-2 px-3.5 py-2 rounded-xl text-xs font-bold transition-all ${
                activeTab === "profile"
                  ? "bg-orange-600 text-white shadow-md shadow-orange-600/30"
                  : "text-slate-400 hover:text-white hover:bg-white/5"
              }`}
            >
              <User className="h-3.5 w-3.5" />
              <span>Athlete Journey Profile</span>
            </button>
            <button
              type="button"
              onClick={() => setActiveTab("coach")}
              className={`inline-flex items-center gap-2 px-3.5 py-2 rounded-xl text-xs font-bold transition-all ${
                activeTab === "coach"
                  ? "bg-orange-600 text-white shadow-md shadow-orange-600/30"
                  : "text-slate-400 hover:text-white hover:bg-white/5"
              }`}
            >
              <Users className="h-3.5 w-3.5" />
              <span>Coach Squad View</span>
            </button>
          </div>

          <div className="hidden md:flex items-center gap-1 text-[11px] font-bold text-slate-500">
            <span className="inline-block h-2 w-2 rounded-full bg-emerald-400 animate-pulse mr-1" />
            Interactive Preview
          </div>
        </div>

        {/* Tab 1: Live Standings Preview */}
        {activeTab === "standings" && (
          <div className="p-4 sm:p-6 space-y-4">
            {/* Class Switcher Sub-pills */}
            <div className="flex flex-wrap items-center justify-between gap-3">
              <div className="flex items-center gap-1.5 p-1 rounded-xl bg-black/40 border border-white/5">
                {(
                  [
                    ["optimist", "Optimist Gold"],
                    ["ilca4", "ILCA 4"],
                    ["wingfoil", "WingFoil Sprint"],
                  ] as const
                ).map(([key, label]) => (
                  <button
                    key={key}
                    type="button"
                    onClick={() => setSelectedClass(key)}
                    className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-colors ${
                      selectedClass === key
                        ? "bg-white/10 text-white border border-white/10 shadow-sm"
                        : "text-slate-400 hover:text-white"
                    }`}
                  >
                    {label}
                  </button>
                ))}
              </div>

              <span className="text-[11px] text-slate-400 font-medium">
                {standingsData.subtitle}
              </span>
            </div>

            <div className="rounded-xl border border-amber-500/20 bg-amber-500/[0.05] px-3.5 py-2 text-[11px] text-amber-300/90 flex items-center justify-between gap-2">
              <span>⚠️ Demo preview with illustrative sample names and results. Open class links below for official live standings.</span>
            </div>

            {/* Standings Table Card */}
            <div className="rounded-2xl border border-white/5 bg-black/30 overflow-hidden">
              <div className="overflow-x-auto">
                <table className="w-full text-left text-xs min-w-[480px]">
                  <thead>
                    <tr className="border-b border-white/5 bg-white/[0.02] text-[10px] uppercase font-bold text-slate-400 tracking-wider">
                      <th className="py-2.5 px-3 text-center w-14">Rank</th>
                      <th className="py-2.5 px-4">Sailor / Competitor</th>
                      <th className="py-2.5 px-3 text-center">Sail #</th>
                      <th className="py-2.5 px-4 text-right font-bold text-orange-300">
                        {standingsData.rows[0].scoreLabel}
                      </th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-white/5 font-semibold text-slate-300">
                    {standingsData.rows.map((row) => (
                      <tr
                        key={row.rank}
                        className="hover:bg-white/[0.02] transition-colors"
                      >
                        <td className="py-3 px-3 text-center">
                          <RankMedalBadge
                            rank={row.rank}
                            nonPodiumClassName="font-mono font-bold text-slate-400"
                          />
                        </td>
                        <td className="py-3 px-4">
                          <div className="font-bold text-white flex items-center gap-1.5">
                            <span>{row.name}</span>
                          </div>
                          <div className="text-[10px] text-slate-400 mt-0.5">
                            {row.club}
                          </div>
                        </td>
                        <td className="py-3 px-3 text-center font-mono font-bold text-slate-300">
                          {row.sailNumber}
                        </td>
                        <td className="py-3 px-4 text-right font-mono font-black text-orange-300 text-sm">
                          {row.score}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>

            {/* Bottom Footer Action */}
            <div className="flex flex-col sm:flex-row items-center justify-between gap-3 pt-2 text-xs">
              <p className="text-slate-400">
                Official RRS Appendix A &amp; High Points calculation rules applied automatically.
              </p>
              <Link
                href={standingsData.link}
                className="inline-flex items-center gap-1.5 text-xs font-bold text-orange-400 hover:text-orange-300 group"
              >
                <span>{standingsData.linkLabel}</span>
                <ArrowRight className="h-3.5 w-3.5 transition-transform group-hover:translate-x-0.5" />
              </Link>
            </div>
          </div>
        )}

        {/* Tab 2: Athlete Profile Tour */}
        {activeTab === "profile" && (
          <div className="p-5 sm:p-7 space-y-5">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-white/5 pb-5">
              <div className="flex items-center gap-3.5">
                <div className="h-12 w-12 rounded-2xl bg-gradient-to-tr from-orange-600 to-amber-500 flex items-center justify-center font-black text-lg text-white shadow-lg shadow-orange-600/30">
                  KT
                </div>
                <div>
                  <div className="flex items-center gap-2">
                    <h3 className="text-base font-bold text-white">Kimberly Tan</h3>
                    <span className="text-xs">🇸🇬</span>
                  </div>
                  <p className="text-xs text-slate-400">
                    SGP 4658 (Opti) · SGP 214980 (ILCA 4) · SAF Yacht Club
                  </p>
                </div>
              </div>

              <div className="flex items-center gap-2">
                <span className="px-3 py-1 rounded-full text-xs font-bold bg-sky-500/15 text-sky-300 border border-sky-500/30">
                  Dual-Class Verified
                </span>
                <span className="px-3 py-1 rounded-full text-xs font-bold bg-emerald-500/15 text-emerald-300 border border-emerald-500/30">
                  Claimed Profile
                </span>
              </div>
            </div>

            {/* Career Progression & Medal Tally */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
              <div className="rounded-xl border border-white/5 bg-white/[0.02] p-3.5 space-y-1">
                <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                  Transition Timeline
                </p>
                <p className="text-xs font-bold text-white">
                  Optimist Gold (2022–25) → ILCA 4 (2025–Present)
                </p>
                <p className="text-[11px] text-slate-400">
                  Preserves all historical regattas and personal bests.
                </p>
              </div>

              <div className="rounded-xl border border-white/5 bg-white/[0.02] p-3.5 space-y-1">
                <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                  Career Podium Tally
                </p>
                <div className="flex items-center gap-2 font-mono text-xs font-black text-white pt-0.5">
                  <span className="text-amber-400">🥇 4 Gold</span>
                  <span className="text-slate-300">🥈 3 Silver</span>
                  <span className="text-amber-600">🥉 2 Bronze</span>
                </div>
                <p className="text-[11px] text-slate-400">
                  Automatic aggregation across national regattas.
                </p>
              </div>

              <div className="rounded-xl border border-white/5 bg-white/[0.02] p-3.5 space-y-1">
                <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                  Privacy &amp; Logbook
                </p>
                <p className="text-xs font-bold text-white">
                  Equipment, Mast, Sails, Private Notes
                </p>
                <p className="text-[11px] text-slate-400">
                  Choose what to publish and what stays private.
                </p>
              </div>
            </div>

            <div className="flex items-center justify-between pt-2">
              <p className="text-xs text-slate-400">
                Sailors and parents can claim profiles and log milestones.
              </p>
              <Link
                href="/sample"
                className="inline-flex items-center gap-1.5 text-xs font-bold text-orange-400 hover:text-orange-300 group"
              >
                <span>Explore Interactive Demo Profile</span>
                <ArrowRight className="h-3.5 w-3.5 transition-transform group-hover:translate-x-0.5" />
              </Link>
            </div>
          </div>
        )}

        {/* Tab 3: Coach Squad Workspace */}
        {activeTab === "coach" && (
          <div className="p-5 sm:p-7 space-y-5">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-white/5 pb-4">
              <div>
                <div className="flex items-center gap-2">
                  <h3 className="text-base font-bold text-white">
                    Changi Racing Squad
                  </h3>
                  <span className="px-2 py-0.5 rounded-full text-[10px] font-black bg-sky-500/20 text-sky-300 border border-sky-500/30 uppercase">
                    8 Athletes Active
                  </span>
                </div>
                <p className="text-xs text-slate-400 mt-0.5">
                  Private coach squad workspace with automated fleet monitoring
                </p>
              </div>

              <Link
                href="/coach-tools"
                className="inline-flex items-center gap-1.5 rounded-full bg-sky-600 hover:bg-sky-500 px-4 py-2 text-xs font-bold text-white transition-colors"
              >
                <span>Open Coach Tools</span>
                <ArrowRight className="h-3.5 w-3.5" />
              </Link>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
              <div className="rounded-xl border border-sky-500/20 bg-sky-500/5 p-4 space-y-1">
                <div className="flex items-center gap-2">
                  <Shield className="h-4 w-4 text-sky-400" />
                  <p className="text-xs font-bold text-white">Live Squad Health</p>
                </div>
                <p className="text-xs text-slate-300 font-semibold pt-1">
                  3 Sailors in National Top 10
                </p>
                <p className="text-[11px] text-slate-400">
                  Instant visibility into ranking movements and carry-forward points.
                </p>
              </div>

              <div className="rounded-xl border border-orange-500/20 bg-orange-500/5 p-4 space-y-1">
                <div className="flex items-center gap-2">
                  <Trophy className="h-4 w-4 text-orange-400" />
                  <p className="text-xs font-bold text-white">Selection Readiness</p>
                </div>
                <p className="text-xs text-slate-300 font-semibold pt-1">
                  2 Sailors in Asian Trials Roster
                </p>
                <p className="text-[11px] text-slate-400">
                  Automatic point cushion buffers against cutoff lines.
                </p>
              </div>

              <div className="rounded-xl border border-emerald-500/20 bg-emerald-500/5 p-4 space-y-1">
                <div className="flex items-center gap-2">
                  <Compass className="h-4 w-4 text-emerald-400" />
                  <p className="text-xs font-bold text-white">Head-to-Head Compare</p>
                </div>
                <p className="text-xs text-slate-300 font-semibold pt-1">
                  1-Click Side-by-Side Analysis
                </p>
                <p className="text-[11px] text-slate-400">
                  Compare two squad members across all shared regattas.
                </p>
              </div>
            </div>

            <div className="flex items-center justify-between pt-1 text-xs text-slate-400">
              <span>Coaching dashboard is restricted to verified club and national coaches.</span>
              <Link
                href="/register?role=coach&next=%2Fcoach-tools"
                className="font-bold text-sky-400 hover:text-sky-300"
              >
                Apply for coach access →
              </Link>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
