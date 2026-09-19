"use client";

import { useState } from "react";
import Link from "next/link";
import { DemoNavHeader } from "@/components/demo/DemoNavHeader";
import { SAMPLE_COACH_PANEL } from "@/lib/sampleProfile";
import {
  ClipboardList,
  CheckCircle2,
  Users,
  ChevronRight,
  GraduationCap,
  Plus,
  UserPlus,
  Shield,
  ExternalLink,
} from "lucide-react";

type CoachRosterSailor = {
  name: string;
  handle: string;
  rank: number;
  highlight: string;
  avgFinish?: string;
  selection?: string;
};

export function SampleCoachDemo() {
  const c = SAMPLE_COACH_PANEL;
  const [toast, setToast] = useState<string | null>(null);
  const [coachNotes, setCoachNotes] = useState(c.coachNotes);
  const [coachDevRecords, setCoachDevRecords] = useState(
    c.developmentRecords || []
  );
  const [compareTo, setCompareTo] = useState(
    c.compareOptions[0]?.name || ""
  );
  const [coachRoster, setCoachRoster] = useState<CoachRosterSailor[]>(
    c.squadTeaser.map((s) => ({
      ...s,
      avgFinish:
        s.name === "Kimberly Tan"
          ? "3.6"
          : s.name === "Ethan Koh"
            ? "7.1"
            : "9.4",
      selection:
        s.name === "Kimberly Tan"
          ? "On track"
          : s.name === "Ethan Koh"
            ? "Watch"
            : "Developing",
    }))
  );
  const [selectedCoachSailor, setSelectedCoachSailor] =
    useState<CoachRosterSailor | null>(null);

  const flash = (msg: string) => {
    setToast(msg);
    setTimeout(() => setToast(null), 2200);
  };

  return (
    <div className="min-h-screen bg-[#0d1017] text-slate-100 flex flex-col">
      <DemoNavHeader activeDemo="coach" />

      {toast && (
        <div className="fixed bottom-6 left-1/2 -translate-x-1/2 z-50 rounded-full bg-slate-900 border border-sky-500/40 px-5 py-2.5 text-xs font-bold text-white shadow-xl animate-fade-in">
          {toast}
        </div>
      )}

      {/* Hero Banner for Coach Squad Hub Demo */}
      <div className="border-b border-sky-500/20 bg-gradient-to-b from-sky-950/30 via-[#0d1017] to-[#0d1017]">
        <div className="mx-auto max-w-5xl px-4 sm:px-6 pt-6 pb-4">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
            <div className="flex items-center gap-3.5">
              <span className="flex h-12 w-12 items-center justify-center rounded-2xl bg-sky-500/15 text-sky-400 border border-sky-500/30 shadow-lg shadow-sky-950/50">
                <ClipboardList className="h-6 w-6" />
              </span>
              <div>
                <div className="flex items-center gap-2 flex-wrap">
                  <h1 className="text-xl sm:text-2xl font-black text-white tracking-tight">
                    Coach Squad Hub
                  </h1>
                  <span className="rounded-full bg-sky-500/15 border border-sky-500/30 px-2.5 py-0.5 text-[10px] font-black uppercase tracking-wider text-sky-300">
                    Live Demo
                  </span>
                </div>
                <p className="text-xs text-slate-400 mt-1">
                  {c.squadName} · Squad roster · Development log · Selection trials readiness
                </p>
              </div>
            </div>

            <div className="flex items-center gap-2 shrink-0">
              <Link
                href="/coach-tools"
                className="rounded-2xl border border-sky-500/40 bg-sky-500/15 hover:bg-sky-500/25 px-4 py-2 text-xs font-bold text-sky-300 transition-colors inline-flex items-center gap-1.5"
              >
                <span>Live Coach Portal</span>
                <ExternalLink className="h-3.5 w-3.5" />
              </Link>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content Area */}
      <main className="flex-1 mx-auto max-w-5xl px-4 sm:px-6 py-6 w-full space-y-6">
        {/* Squad Pulse Cards Strip */}
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
          <div className="rounded-2xl border border-white/10 bg-black/30 p-4 shadow-sm">
            <p className="text-[10px] font-bold uppercase tracking-wider text-slate-400">
              Fleet Split
            </p>
            <p className="mt-1 text-base font-black text-white font-mono">
              {c.squadPulse.goldCount} Gold · {c.squadPulse.silverCount} Silver
            </p>
            <p className="text-[10px] text-slate-500 mt-0.5">Optimist national series</p>
          </div>

          <div className="rounded-2xl border border-white/10 bg-black/30 p-4 shadow-sm">
            <p className="text-[10px] font-bold uppercase tracking-wider text-slate-400">
              Gear Health
            </p>
            <p className="mt-1 text-base font-black text-amber-400 font-mono">
              {c.squadPulse.gearNeedingRepair} Needs Repair
            </p>
            <p className="text-[10px] text-slate-500 mt-0.5">Equipment locker items</p>
          </div>

          <div className="rounded-2xl border border-white/10 bg-black/30 p-4 shadow-sm">
            <p className="text-[10px] font-bold uppercase tracking-wider text-slate-400">
              Selection Trials
            </p>
            <p className="mt-1 text-base font-black text-emerald-400 font-mono">
              {c.squadPulse.aocQualifiedCount} On AOC Roster
            </p>
            <p className="text-[10px] text-slate-500 mt-0.5">Provisional Perth &amp; Asian</p>
          </div>

          <div className="rounded-2xl border border-white/10 bg-black/30 p-4 shadow-sm">
            <p className="text-[10px] font-bold uppercase tracking-wider text-slate-400">
              Squad Actions
            </p>
            <p className="mt-1 text-base font-black text-orange-400 font-mono">
              {c.squadPulse.actionsCount} To Review
            </p>
            <p className="text-[10px] text-slate-500 mt-0.5">Pending debriefs &amp; tests</p>
          </div>
        </div>

        {/* Squad Selection Readiness & Pathway Bento */}
        <div className="rounded-3xl border border-sky-500/25 bg-gradient-to-b from-sky-500/[0.07] to-transparent p-5 sm:p-7 space-y-6">
          <div className="flex items-start justify-between gap-4 flex-wrap">
            <div className="flex items-center gap-3">
              <span className="flex h-10 w-10 items-center justify-center rounded-2xl bg-sky-500/20 text-sky-300 border border-sky-500/30">
                <Shield className="h-5 w-5" />
              </span>
              <div>
                <h2 className="text-base font-black text-white tracking-tight">
                  Selection Readiness &amp; Squad Diagnostics
                </h2>
                <p className="text-xs text-slate-400 mt-0.5">
                  Automated metric tracking against Singapore Sailing selection regulations
                </p>
              </div>
            </div>
            <span
              className={`inline-flex items-center gap-1.5 rounded-full px-3 py-1 text-xs font-bold border ${
                c.selectionReadiness.score >= 75
                  ? "bg-emerald-500/15 border-emerald-500/30 text-emerald-300"
                  : "bg-amber-500/15 border-amber-500/30 text-amber-200"
              }`}
            >
              <CheckCircle2 className="h-4 w-4" />
              <span>Selection {c.selectionReadiness.label} · {c.selectionReadiness.score}%</span>
            </span>
          </div>

          <p className="text-xs sm:text-sm text-slate-300 leading-relaxed bg-black/30 p-3.5 rounded-2xl border border-white/5">
            {c.selectionReadiness.detail}
          </p>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {/* Training Attendance */}
            <div className="rounded-2xl border border-white/10 bg-black/25 p-4 space-y-3">
              <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                Training Attendance (Last 4)
              </p>
              <ul className="space-y-2">
                {c.attendance.map((a) => (
                  <li
                    key={a.session}
                    className="flex justify-between text-xs items-center"
                  >
                    <span className="text-slate-300">{a.session}</span>
                    <span
                      className={`px-2 py-0.5 rounded text-[10px] font-bold uppercase tracking-wider ${
                        a.status === "attended"
                          ? "bg-emerald-500/15 text-emerald-300 border border-emerald-500/30"
                          : "bg-rose-500/15 text-rose-300 border border-rose-500/30"
                      }`}
                    >
                      {a.status === "attended" ? "Attended" : "Missed"}
                    </span>
                  </li>
                ))}
              </ul>
            </div>

            {/* Pathway Checklist */}
            <div className="rounded-2xl border border-white/10 bg-black/25 p-4 space-y-3">
              <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                Pathway Checklist
              </p>
              <ul className="space-y-2">
                {c.pathway.map((item) => (
                  <li
                    key={item.item}
                    className="text-xs text-slate-300 flex items-center gap-2"
                  >
                    <span
                      className={`font-mono text-xs ${
                        item.done ? "text-emerald-400 font-bold" : "text-slate-600"
                      }`}
                    >
                      {item.done ? "✓" : "○"}
                    </span>
                    <span className={item.done ? "text-slate-200" : "text-slate-400"}>
                      {item.item}
                    </span>
                  </li>
                ))}
              </ul>
            </div>

            {/* Compare to Squad Member */}
            <div className="rounded-2xl border border-white/10 bg-black/25 p-4 space-y-3">
              <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                Compare Squad Athletes
              </p>
              <select
                value={compareTo}
                onChange={(e) => setCompareTo(e.target.value)}
                className="w-full rounded-xl bg-black/50 border border-white/10 px-3 py-2 text-xs text-white focus:outline-none focus:border-sky-500"
              >
                {c.compareOptions.map((o) => (
                  <option key={o.name} value={o.name}>
                    {o.name} · Rank #{o.rank}
                  </option>
                ))}
              </select>
              <p className="text-[11px] text-slate-400 leading-snug">
                Compare Kimberly (#{c.nationalRank}) against {compareTo} for side-by-side finish distributions.
              </p>
            </div>
          </div>

          {/* Private Coach Notes Section */}
          <div className="border-t border-white/10 pt-5 space-y-3">
            <div className="flex items-center justify-between gap-2 flex-wrap">
              <div>
                <p className="text-xs font-bold text-white uppercase tracking-wider">
                  Private Coach Notes
                </p>
                <p className="text-[11px] text-slate-500">
                  Encrypted notes visible only to squad coaches — hidden from sailors and parents
                </p>
              </div>
              <button
                type="button"
                onClick={() => {
                  setCoachNotes((prev) => [
                    {
                      date: new Date().toISOString().slice(0, 10),
                      text: "(Demo) Tactical review: focus on starboard pin approaches and layline discipline.",
                    },
                    ...prev,
                  ]);
                  flash("Demo coach note added");
                }}
                className="rounded-full bg-sky-600 hover:bg-sky-500 px-3.5 py-1.5 text-xs font-bold text-white transition-colors"
              >
                + Add Coach Note
              </button>
            </div>

            <ul className="grid grid-cols-1 sm:grid-cols-2 gap-2.5 max-h-48 overflow-y-auto pr-1">
              {coachNotes.map((n, i) => (
                <li
                  key={i}
                  className="rounded-xl bg-black/30 border border-white/5 p-3 space-y-1"
                >
                  <p className="text-[10px] text-sky-400 font-mono font-bold">
                    {n.date}
                  </p>
                  <p className="text-xs text-slate-300 leading-relaxed">
                    {n.text}
                  </p>
                </li>
              ))}
            </ul>
          </div>
        </div>

        {/* Athlete Development & Coaching Log */}
        <div className="rounded-3xl border border-sky-500/25 bg-black/30 p-5 sm:p-7 space-y-5">
          <div className="flex items-center justify-between gap-2 flex-wrap">
            <div>
              <h2 className="text-base font-black text-white tracking-tight flex items-center gap-2">
                <GraduationCap className="h-5 w-5 text-sky-400" />
                Athlete Development Log
              </h2>
              <p className="text-xs text-slate-400 mt-0.5">
                6 structured coaching categories with selective family sharing
              </p>
            </div>
            <button
              type="button"
              onClick={() => {
                const newRec = {
                  id: `dev-${Date.now()}`,
                  category: "Technical",
                  type: "observation" as const,
                  title: "(Demo) Downwind wave pumping rhythm",
                  detail: "Consistent roll-tack cadence and steady mast angle in chop.",
                  recordDate: new Date().toISOString().slice(0, 10),
                  sentiment: "strength" as const,
                  visibility: "shared" as const,
                };
                setCoachDevRecords((prev) => [newRec, ...prev]);
                flash("Demo development entry added");
              }}
              className="rounded-full bg-sky-600 hover:bg-sky-500 px-3.5 py-1.5 text-xs font-bold text-white transition flex items-center gap-1.5"
            >
              <Plus className="h-3.5 w-3.5" />
              <span>Log Observation</span>
            </button>
          </div>

          <div className="space-y-2.5">
            {coachDevRecords.map((rec) => (
              <div
                key={rec.id}
                className="rounded-2xl border border-white/10 bg-black/25 p-4 space-y-2"
              >
                <div className="flex flex-wrap items-center justify-between gap-2">
                  <div className="flex items-center gap-2 flex-wrap">
                    <span className="text-xs font-bold text-white">{rec.title}</span>
                    <span className="rounded-md border border-sky-500/30 bg-sky-500/10 px-2 py-0.5 text-[10px] font-bold text-sky-300">
                      {rec.category}
                    </span>
                    <span
                      className={`rounded-md px-1.5 py-0.5 text-[9px] font-bold uppercase tracking-wider border ${
                        rec.sentiment === "strength"
                          ? "bg-emerald-500/15 border-emerald-500/30 text-emerald-300"
                          : rec.sentiment === "focus"
                          ? "bg-amber-500/15 border-amber-500/30 text-amber-300"
                          : "bg-white/10 border-white/15 text-slate-300"
                      }`}
                    >
                      {rec.sentiment}
                    </span>
                  </div>
                  <div className="flex items-center gap-2">
                    <span
                      className={`text-[10px] font-bold px-2 py-0.5 rounded-full border ${
                        rec.visibility === "shared"
                          ? "bg-emerald-500/10 border-emerald-500/30 text-emerald-300"
                          : "bg-white/5 border-white/10 text-slate-400"
                      }`}
                    >
                      {rec.visibility === "shared" ? "👥 Shared with Family" : "🔒 Coach Only"}
                    </span>
                    <span className="text-[10px] text-slate-500 font-mono">{rec.recordDate}</span>
                  </div>
                </div>
                {rec.detail && (
                  <p className="text-xs text-slate-300 leading-relaxed">{rec.detail}</p>
                )}
              </div>
            ))}
          </div>
        </div>

        {/* Squad Roster Section */}
        <div className="rounded-3xl border border-white/10 bg-black/30 p-5 sm:p-7 space-y-4">
          <div className="flex items-center justify-between gap-2 flex-wrap">
            <div className="flex items-center gap-2.5">
              <span className="flex h-9 w-9 items-center justify-center rounded-xl bg-orange-500/15 text-orange-400 border border-orange-500/30">
                <Users className="h-4 w-4" />
              </span>
              <div>
                <h2 className="text-base font-black text-white tracking-tight">
                  Squad Roster
                </h2>
                <p className="text-xs text-slate-400 mt-0.5">
                  Tap any sailor to inspect coach diagnostics and add athlete notes
                </p>
              </div>
            </div>
            <button
              type="button"
              onClick={() => {
                const n = coachRoster.length + 1;
                const newbie: CoachRosterSailor = {
                  name: `Demo Sailor ${n}`,
                  handle: "#",
                  rank: 12 + n,
                  highlight: "Newly added (demo)",
                  avgFinish: "—",
                  selection: "New",
                };
                setCoachRoster((prev) => [...prev, newbie]);
                flash(`Demo: added ${newbie.name} to squad`);
              }}
              className="inline-flex items-center gap-1.5 rounded-full bg-sky-600 hover:bg-sky-500 px-3.5 py-1.5 text-xs font-bold text-white transition-colors"
            >
              <UserPlus className="h-3.5 w-3.5" />
              <span>Add Sailor</span>
            </button>
          </div>

          <ul className="divide-y divide-white/5">
            {coachRoster.map((s) => {
              const active = selectedCoachSailor?.name === s.name;
              return (
                <li key={s.name} className="py-1">
                  <button
                    type="button"
                    onClick={() =>
                      setSelectedCoachSailor((cur) =>
                        cur?.name === s.name ? null : s
                      )
                    }
                    className={`w-full py-3 flex items-center justify-between gap-3 text-xs text-left rounded-xl px-3 transition-colors ${
                      active
                        ? "bg-sky-500/15 border border-sky-500/30"
                        : "hover:bg-white/5"
                    }`}
                  >
                    <div className="min-w-0">
                      <p className="font-bold text-white text-sm">{s.name}</p>
                      <p className="text-xs text-slate-400 truncate mt-0.5">
                        {s.highlight}
                        {s.selection ? ` · ${s.selection}` : ""}
                      </p>
                    </div>
                    <span className="flex items-center gap-2.5 shrink-0">
                      <span className="font-mono font-black text-orange-400 text-sm">
                        #{s.rank}
                      </span>
                      <ChevronRight
                        className={`h-4 w-4 text-slate-500 transition-transform ${
                          active ? "rotate-90 text-sky-300" : ""
                        }`}
                      />
                    </span>
                  </button>
                  {active && (
                    <div className="mb-3 mt-1 rounded-2xl border border-sky-500/25 bg-sky-500/[0.06] p-4 space-y-3">
                      <p className="text-xs font-bold text-sky-200 uppercase tracking-wider">
                        Coach Detail · {s.name}
                      </p>
                      <div className="grid grid-cols-2 sm:grid-cols-3 gap-2.5 text-xs">
                        <div className="rounded-xl bg-black/40 p-2.5 border border-white/5">
                          <p className="text-[10px] text-slate-400 uppercase font-bold">
                            National Rank
                          </p>
                          <p className="font-black text-white text-sm font-mono mt-0.5">#{s.rank}</p>
                        </div>
                        <div className="rounded-xl bg-black/40 p-2.5 border border-white/5">
                          <p className="text-[10px] text-slate-400 uppercase font-bold">
                            Avg Finish
                          </p>
                          <p className="font-black text-white text-sm font-mono mt-0.5">
                            {s.avgFinish || "—"}
                          </p>
                        </div>
                        <div className="rounded-xl bg-black/40 p-2.5 border border-white/5 col-span-2 sm:col-span-1">
                          <p className="text-[10px] text-slate-400 uppercase font-bold">
                            Selection Status
                          </p>
                          <p className="font-black text-sky-300 text-sm mt-0.5">
                            {s.selection || "—"}
                          </p>
                        </div>
                      </div>
                      <p className="text-xs text-slate-300 leading-relaxed">
                        {s.name === "Kimberly Tan"
                          ? "Strong mid-line starts · light-air height is focus. Coach notes stay private to your staff."
                          : "Demo athlete summary — coaches can track regatta histories and add private observations."}
                      </p>
                      <div className="flex items-center gap-2 pt-1">
                        <button
                          type="button"
                          onClick={() => {
                            setCoachNotes((prev) => [
                              {
                                date: new Date().toISOString().slice(0, 10),
                                text: `(Demo) Note on ${s.name}: review starts video before next NRS.`,
                              },
                              ...prev,
                            ]);
                            flash(`Demo coach note for ${s.name}`);
                          }}
                          className="rounded-full border border-sky-500/40 bg-sky-500/15 hover:bg-sky-500/25 px-3.5 py-1.5 text-xs font-bold text-sky-200 transition-colors"
                        >
                          + Add Note for {s.name.split(" ")[0]}
                        </button>
                      </div>
                    </div>
                  )}
                </li>
              );
            })}
          </ul>
        </div>

        {/* Bottom CTA Banner */}
        <div className="rounded-3xl border border-sky-500/30 bg-gradient-to-r from-sky-950/40 via-black to-sky-950/20 p-6 sm:p-8 flex flex-col sm:flex-row sm:items-center justify-between gap-6">
          <div className="space-y-1.5 max-w-xl">
            <h3 className="text-lg font-black text-white">
              Coach a club or national sailing squad?
            </h3>
            <p className="text-xs sm:text-sm text-slate-300 leading-relaxed">
              Get verified coach access to manage private squad rosters, monitor fleet transitions, and conduct technical debriefs directly within SailorPath.
            </p>
          </div>
          <div className="flex flex-col sm:flex-row items-center gap-3 shrink-0">
            <Link
              href="/register?role=coach"
              className="w-full sm:w-auto text-center rounded-2xl bg-sky-500 hover:bg-sky-400 text-black px-5 py-3 text-xs font-black shadow-lg shadow-sky-500/20 transition-all"
            >
              Request Coach Access
            </Link>
            <Link
              href="/coach-tools"
              className="w-full sm:w-auto text-center rounded-2xl bg-white/10 hover:bg-white/15 text-white border border-white/15 px-5 py-3 text-xs font-bold transition-all"
            >
              Coach Portal Sign In
            </Link>
          </div>
        </div>
      </main>
    </div>
  );
}
