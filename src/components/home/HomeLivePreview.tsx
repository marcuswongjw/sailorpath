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
  Heart,
  Calendar,
  CheckSquare,
  Square,
  Wrench,
  AlertTriangle,
  Target,
  CheckCircle2,
  Plus,
  GraduationCap,
} from "lucide-react";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";

type PreviewTab = "standings" | "profile" | "parent" | "coach";
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
  const [parentDemoAthlete, setParentDemoAthlete] = useState<"kimberly" | "alex">("kimberly");
  const [demoChecklist, setDemoChecklist] = useState([
    { id: "1", text: "Official class measurement certificate verified & onboard", done: true },
    { id: "2", text: "Spare battens, sail ties (2.5mm / 3.0mm) & wind indicator checked", done: true },
  ]);
  const [newChecklistText, setNewChecklistText] = useState("");

  const standingsData = SAMPLE_STANDINGS[selectedClass];

  return (
    <div className="w-full max-w-5xl mx-auto">
      {/* Outer Card with subtle glow */}
      <div className="relative rounded-3xl border border-white/10 bg-[#0d0f18] shadow-xl overflow-hidden">

        {/* Tab Navigation Bar */}
        <div className="relative border-b border-white/10 p-2.5 sm:p-4 flex items-center justify-between gap-3 bg-white/[0.02]">
          <div className="flex items-center gap-1.5 sm:gap-2 overflow-x-auto no-scrollbar w-full md:w-auto pb-1 md:pb-0 scroll-smooth">
            <button
              type="button"
              onClick={() => setActiveTab("standings")}
              className={`inline-flex items-center gap-1.5 sm:gap-2 px-3 sm:px-3.5 py-2 rounded-xl text-[15px] font-semibold transition-all whitespace-nowrap shrink-0 ${
                activeTab === "standings"
                  ? "bg-harbour text-white shadow-md"
                  : "text-slate-400 hover:text-white hover:bg-white/5"
              }`}
            >
              <Trophy className="h-3.5 w-3.5 shrink-0" />
              <span>Live Standings</span>
            </button>
            <button
              type="button"
              onClick={() => setActiveTab("profile")}
              className={`inline-flex items-center gap-1.5 sm:gap-2 px-3 sm:px-3.5 py-2 rounded-xl text-[15px] font-semibold transition-all whitespace-nowrap shrink-0 ${
                activeTab === "profile"
                  ? "bg-harbour text-white shadow-md"
                  : "text-slate-400 hover:text-white hover:bg-white/5"
              }`}
            >
              <User className="h-3.5 w-3.5 shrink-0" />
              <span>Athlete Profile</span>
            </button>
            <button
              type="button"
              onClick={() => setActiveTab("parent")}
              className={`inline-flex items-center gap-1.5 sm:gap-2 px-3 sm:px-3.5 py-2 rounded-xl text-[15px] font-semibold transition-all whitespace-nowrap shrink-0 ${
                activeTab === "parent"
                  ? "bg-harbour text-white shadow-md"
                  : "text-slate-400 hover:text-white hover:bg-white/5"
              }`}
            >
              <Heart className="h-3.5 w-3.5 shrink-0" />
              <span>Parent Command Center</span>
            </button>
            <button
              type="button"
              onClick={() => setActiveTab("coach")}
              className={`inline-flex items-center gap-1.5 sm:gap-2 px-3 sm:px-3.5 py-2 rounded-xl text-[15px] font-semibold transition-all whitespace-nowrap shrink-0 ${
                activeTab === "coach"
                  ? "bg-harbour text-white shadow-md"
                  : "text-slate-400 hover:text-white hover:bg-white/5"
              }`}
            >
              <Users className="h-3.5 w-3.5 shrink-0" />
              <span>Coach Squad View</span>
            </button>
          </div>

          <div className="hidden md:flex items-center gap-1 text-[13px] font-bold text-slate-500 shrink-0">
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
                    className={`px-3 py-1.5 rounded-lg text-[15px] font-semibold transition-colors ${
                      selectedClass === key
                        ? "bg-harbour text-white border border-harbour shadow-sm"
                        : "text-slate-400 hover:text-charcoal"
                    }`}
                  >
                    {label}
                  </button>
                ))}
              </div>

              <span className="text-[13px] text-slate-400 font-medium">
                {standingsData.subtitle}
              </span>
            </div>

            <div className="rounded-xl border border-amber-500/20 bg-amber-500/[0.05] px-3.5 py-2 text-[13px] text-amber-700 flex items-center justify-between gap-2">
              <span>⚠️ Demo preview with illustrative sample names and results. Open class links below for official live standings.</span>
            </div>

            {/* Standings Table Card */}
            <div className="rounded-2xl border border-white/5 bg-black/30 overflow-hidden">
              <div className="overflow-x-auto">
                <table className="w-full text-left text-sm min-w-[480px]">
                  <thead>
                    <tr className="border-b border-white/5 bg-white/[0.02] text-[13px] uppercase font-bold text-slate-400 tracking-wider">
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
                          <div className="text-[13px] text-slate-400 mt-0.5">
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
            <div className="flex flex-col sm:flex-row items-center justify-between gap-3 pt-2 text-[13px]">
              <p className="text-slate-400">
                Official RRS Appendix A &amp; High Points calculation rules applied automatically.
              </p>
              <Link
                href={standingsData.link}
                className="inline-flex items-center gap-1.5 text-[13px] font-semibold text-harbour hover:text-harbour-shadow hover:underline group"
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
                <div className="h-12 w-12 rounded-2xl bg-harbour flex items-center justify-center font-black text-lg text-white shadow-lg">
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
                <p className="text-[13px] font-bold text-slate-400 uppercase tracking-wider">
                  Transition Timeline
                </p>
                <p className="text-xs font-bold text-white">
                  Optimist Gold (2022–25) → ILCA 4 (2025–Present)
                </p>
                <p className="text-[13px] text-slate-400">
                  Preserves all historical regattas and personal bests.
                </p>
              </div>

              <div className="rounded-xl border border-white/5 bg-white/[0.02] p-3.5 space-y-1">
                <p className="text-[13px] font-bold text-slate-400 uppercase tracking-wider">
                  Career Podium Tally
                </p>
                <div className="flex items-center gap-2 font-mono text-xs font-black text-white pt-0.5">
                  <span className="text-amber-700">🥇 4 Gold</span>
                  <span className="text-slate-300">🥈 3 Silver</span>
                  <span className="text-amber-800">🥉 2 Bronze</span>
                </div>
                <p className="text-[13px] text-slate-400">
                  Automatic aggregation across national regattas.
                </p>
              </div>

              <div className="rounded-xl border border-white/5 bg-white/[0.02] p-3.5 space-y-1">
                <p className="text-[13px] font-bold text-slate-400 uppercase tracking-wider">
                  Privacy &amp; Logbook
                </p>
                <p className="text-xs font-bold text-white">
                  Equipment, Mast, Sails, Private Notes
                </p>
                <p className="text-[13px] text-slate-400">
                  Choose what to publish and what stays private.
                </p>
              </div>
            </div>

            <div className="flex items-center justify-between pt-2">
              <p className="text-[13px] text-slate-400">
                Sailors and parents can claim profiles and log milestones.
              </p>
              <Link
                href="/sample"
                className="inline-flex items-center gap-1.5 text-[13px] font-semibold text-harbour hover:text-harbour-shadow hover:underline group"
              >
                <span>Explore Interactive Demo Profile</span>
                <ArrowRight className="h-3.5 w-3.5 transition-transform group-hover:translate-x-0.5" />
              </Link>
            </div>
          </div>
        )}

        {/* Tab 3: Parent Command Center Preview */}
        {activeTab === "parent" && (
          <div className="p-5 sm:p-7 space-y-5 text-left">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-white/5 pb-4">
              <div>
                <div className="flex items-center gap-2">
                  <h3 className="text-base font-bold text-white">
                    Family Dashboard Command Center
                  </h3>
                  <span className="px-2 py-0.5 rounded-full text-[10px] font-black bg-emerald-500/20 text-emerald-300 border border-emerald-500/30 uppercase">
                    Parent Verified
                  </span>
                </div>
                <p className="text-xs text-slate-400 mt-0.5">
                  Multi-athlete tracking, Selection Trials qualification, boat locker, and pre-race prep.
                </p>
              </div>

              {/* Child Switcher Pills */}
              <div className="flex items-center gap-1.5 p-1 rounded-xl bg-black/40 border border-white/5 self-start sm:self-auto">
                <button
                  type="button"
                  onClick={() => setParentDemoAthlete("kimberly")}
                  className={`px-3 py-1.5 rounded-lg text-[15px] font-semibold transition-colors ${
                    parentDemoAthlete === "kimberly"
                      ? "bg-harbour text-white"
                      : "text-slate-400 hover:text-charcoal"
                  }`}
                >
                  Kimberly (Gold #3)
                </button>
                <button
                  type="button"
                  onClick={() => setParentDemoAthlete("alex")}
                  className={`px-3 py-1.5 rounded-lg text-[15px] font-semibold transition-colors ${
                    parentDemoAthlete === "alex"
                      ? "bg-harbour text-white"
                      : "text-slate-400 hover:text-charcoal"
                  }`}
                >
                  Alex (Silver #8)
                </button>
              </div>
            </div>

            {/* Bento Grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {/* Card 1: Selection Trials & Asian Games status */}
              <div className="rounded-2xl border border-amber-500/20 bg-amber-500/[0.04] p-4 sm:p-5 space-y-3">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <Target className="h-4 w-4 text-amber-400" />
                    <p className="text-xs font-bold text-white uppercase tracking-wider">
                      2026 Selection Trials
                    </p>
                  </div>
                  <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-amber-500/20 text-amber-300 border border-amber-500/30">
                    {parentDemoAthlete === "kimberly" ? "Trials Rank #3" : "Silver Pathway"}
                  </span>
                </div>

                <div className="grid grid-cols-3 gap-2 text-center">
                  <div className="rounded-xl bg-black/30 p-2 border border-white/5">
                    <p className="text-[13px] uppercase font-bold text-slate-500">Combined</p>
                    <p className="text-sm font-black text-white font-mono mt-0.5">
                      {parentDemoAthlete === "kimberly" ? "18 pts" : "48 pts"}
                    </p>
                  </div>
                  <div className="rounded-xl bg-black/30 p-2 border border-white/5">
                    <p className="text-[13px] uppercase font-bold text-slate-500">Events</p>
                    <p className="text-sm font-black text-white font-mono mt-0.5">3 Sailed</p>
                  </div>
                  <div className="rounded-xl bg-black/30 p-2 border border-white/5">
                    <p className="text-[13px] uppercase font-bold text-slate-500">Buffer</p>
                    <p className="text-sm font-black text-emerald-400 font-mono mt-0.5">
                      {parentDemoAthlete === "kimberly" ? "+14 pts" : "On Track"}
                    </p>
                  </div>
                </div>

                <div className="rounded-xl bg-emerald-500/10 border border-emerald-500/20 p-2.5 flex items-start gap-2">
                  <CheckCircle2 className="h-4 w-4 text-emerald-400 shrink-0 mt-0.5" />
                  <p className="text-[13px] text-emerald-700 leading-snug">
                    {parentDemoAthlete === "kimberly"
                      ? "Provisional Asian Games Qualifier (Top 5 qualify). Gender quota allocation satisfied."
                      : "Silver fleet podium contender. Target top-5 in next 2 regattas for Gold promotion."}
                  </p>
                </div>
              </div>

              {/* Card 2: Interactive Pre-Race Checklist */}
              <div className="rounded-2xl border border-white/10 bg-white/[0.02] p-4 sm:p-5 space-y-3">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <CheckSquare className="h-4 w-4 text-emerald-400" />
                    <p className="text-xs font-bold text-white uppercase tracking-wider">
                      Pre-Race Checklist
                    </p>
                  </div>
                  <span className="text-[10px] font-mono text-emerald-400 font-bold">
                    {demoChecklist.filter((i) => i.done).length}/{demoChecklist.length} Ready
                  </span>
                </div>

                <div className="space-y-1.5">
                  {demoChecklist.map((item) => (
                    <button
                      key={item.id}
                      type="button"
                      onClick={() =>
                        setDemoChecklist((prev) =>
                          prev.map((i) => (i.id === item.id ? { ...i, done: !i.done } : i))
                        )
                      }
                      className={`w-full text-left flex items-center gap-2 p-2 rounded-lg text-[13px] transition-colors ${
                        item.done
                          ? "bg-emerald-500/10 text-slate-300 line-through opacity-80"
                          : "bg-black/20 text-white hover:bg-white/5"
                      }`}
                    >
                      {item.done ? (
                        <CheckSquare className="h-3.5 w-3.5 text-emerald-400 shrink-0" />
                      ) : (
                        <Square className="h-3.5 w-3.5 text-slate-500 shrink-0" />
                      )}
                      <span className="truncate">{item.text}</span>
                    </button>
                  ))}
                </div>

                <div className="flex items-center gap-2 pt-1">
                  <input
                    type="text"
                    value={newChecklistText}
                    onChange={(e) => setNewChecklistText(e.target.value)}
                    onKeyDown={(e) => {
                      if (e.key === "Enter") {
                        e.preventDefault();
                        const trimmed = newChecklistText.trim();
                        if (!trimmed) return;
                        setDemoChecklist((prev) => [
                          ...prev,
                          { id: String(Date.now()), text: trimmed, done: false },
                        ]);
                        setNewChecklistText("");
                      }
                    }}
                    placeholder="Try adding custom item…"
                    className="flex-1 rounded-xl bg-black/30 border border-white/10 px-3 py-1.5 text-sm text-white placeholder-slate-500 focus:outline-none focus:border-harbour"
                  />
                  <button
                    type="button"
                    onClick={() => {
                      const trimmed = newChecklistText.trim();
                      if (!trimmed) return;
                      setDemoChecklist((prev) => [
                        ...prev,
                        { id: String(Date.now()), text: trimmed, done: false },
                      ]);
                      setNewChecklistText("");
                    }}
                    className="rounded-xl bg-harbour hover:bg-harbour-shadow px-3 py-1.5 text-[15px] font-semibold text-white transition flex items-center gap-1 shrink-0"
                  >
                    <Plus className="h-3.5 w-3.5" />
                    <span>Add</span>
                  </button>
                </div>
              </div>

              {/* Card 3: Equipment Locker Alert */}
              <div className="rounded-2xl border border-white/10 bg-white/[0.02] p-4 space-y-2">
                <div className="flex items-center gap-2">
                  <Wrench className="h-4 w-4 text-orange-400" />
                  <p className="text-xs font-bold text-white">Boat Locker Alert</p>
                </div>
                <div className="rounded-xl bg-amber-500/10 border border-amber-500/20 p-2.5 flex items-start gap-2">
                  <AlertTriangle className="h-3.5 w-3.5 text-amber-400 shrink-0 mt-0.5" />
                  <p className="text-[13px] text-amber-800 leading-snug">
                    Sail: J-Sails Blue (2025) is ~18 months old. Measurement backup advised before Asian Championships.
                  </p>
                </div>
              </div>

              {/* Card 4: Upcoming 2026 Racing Fixtures */}
              <div className="rounded-2xl border border-sky-500/20 bg-sky-500/[0.04] p-4 space-y-2">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <Calendar className="h-4 w-4 text-sky-400" />
                    <p className="text-xs font-bold text-white">2026 Racing Calendar</p>
                  </div>
                  <Link
                    href="/calendar"
                    className="text-[13px] font-bold text-harbour hover:text-harbour-shadow hover:underline"
                  >
                    Open Calendar →
                  </Link>
                </div>
                <p className="text-xs text-slate-300 font-medium leading-relaxed">
                  Singapore Youth Championships (20–23 Jun) · SSF Selection Trials (22–30 Aug) · NOR &amp; Entry links live.
                </p>
              </div>
            </div>

            <div className="flex flex-col sm:flex-row items-center justify-between gap-2 pt-1 text-[13px] text-slate-400">
              <span>Dedicated private workspaces for parents with athlete profile claiming.</span>
              <div className="flex items-center gap-3">
                <Link
                  href="/demo/parent"
                  className="font-bold text-harbour hover:text-harbour-shadow hover:underline"
                >
                  Explore Parent Demo →
                </Link>
                <span className="text-slate-soft">·</span>
                <Link
                  href="/parent"
                  className="font-semibold text-slate-300 hover:text-white"
                >
                  Parent Portal
                </Link>
              </div>
            </div>
          </div>
        )}

        {/* Tab 4: Coach Squad Workspace */}
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
                className="inline-flex items-center gap-1.5 rounded-full bg-harbour hover:bg-harbour-shadow px-4 py-2 text-[15px] font-semibold text-white transition-colors"
              >
                <span>Open Coach Tools</span>
                <ArrowRight className="h-3.5 w-3.5" />
              </Link>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              <div className="rounded-xl border border-sky-500/20 bg-sky-500/5 p-4 space-y-1">
                <div className="flex items-center gap-2">
                  <Shield className="h-4 w-4 text-sky-400" />
                  <p className="text-xs font-bold text-white">Squad Pulse Cards</p>
                </div>
                <p className="text-xs text-slate-300 font-semibold pt-1">
                  Fleet Segregation &amp; Gear Condition
                </p>
                <p className="text-[13px] text-slate-400">
                  Instant visibility into Gold/Silver squad splits, gear repair alerts, and carry-forward points.
                </p>
              </div>

              <div className="rounded-xl border border-blue-500/20 bg-blue-500/5 p-4 space-y-1">
                <div className="flex items-center gap-2">
                  <GraduationCap className="h-4 w-4 text-blue-400" />
                  <p className="text-xs font-bold text-white">Athlete Development Log</p>
                </div>
                <p className="text-xs text-slate-300 font-semibold pt-1">
                  6 Structured Coaching Categories
                </p>
                <p className="text-[13px] text-slate-400">
                  Log Technical, Tactical, Physical, Mental, Equipment, and Communication observations with sentiment tracking.
                </p>
              </div>

              <div className="rounded-xl border border-orange-500/20 bg-orange-500/5 p-4 space-y-1">
                <div className="flex items-center gap-2">
                  <Trophy className="h-4 w-4 text-orange-400" />
                  <p className="text-xs font-bold text-white">Selection Readiness</p>
                </div>
                <p className="text-xs text-slate-300 font-semibold pt-1">
                  Asian Games &amp; Perth Trials Roster
                </p>
                <p className="text-[13px] text-slate-400">
                  Automatic point cushion buffers against cutoff lines with gender quotas and birth year allocations.
                </p>
              </div>

              <div className="rounded-xl border border-emerald-500/20 bg-emerald-500/5 p-4 space-y-1">
                <div className="flex items-center gap-2">
                  <Compass className="h-4 w-4 text-emerald-400" />
                  <p className="text-xs font-bold text-white">Selective Debrief Sharing</p>
                </div>
                <p className="text-xs text-slate-300 font-semibold pt-1">
                  Coach-Only vs Family-Shared Notes
                </p>
                <p className="text-[13px] text-slate-400">
                  Control debrief visibility per athlete and run 1-click head-to-head comparison across shared regattas.
                </p>
              </div>
            </div>

            <div className="flex flex-col sm:flex-row items-center justify-between gap-2 pt-1 text-[13px] text-slate-400">
              <span>Coaching dashboard is restricted to verified club and national coaches.</span>
              <div className="flex items-center gap-3">
                <Link
                  href="/demo/coach"
                  className="font-bold text-harbour hover:text-harbour-shadow hover:underline"
                >
                  Explore Coach Demo →
                </Link>
                <span className="text-slate-soft">·</span>
                <Link
                  href="/register?role=coach&next=%2Fcoach-tools"
                  className="font-semibold text-slate-300 hover:text-white"
                >
                  Apply for Access
                </Link>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
