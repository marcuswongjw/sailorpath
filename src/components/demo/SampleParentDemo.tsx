"use client";

import { useState } from "react";
import Link from "next/link";
import { DemoNavHeader } from "@/components/demo/DemoNavHeader";
import {
  SAMPLE_PARENT_PANEL,
  SAMPLE_SAILOR,
  SAMPLE_RESULTS,
  SAMPLE_EQUIPMENT,
  SAMPLE_SERIES_STANDING,
  SAMPLE_ILCA_STANDING,
  SAMPLE_OBSERVATIONS,
} from "@/lib/sampleProfile";
import { SailorProfileView } from "@/components/SailorProfileView";
import {
  Heart,
  Calendar,
  AlertTriangle,
  CheckCircle2,
  Wrench,
  GraduationCap,
  Target,
  CheckSquare,
  Square,
  RotateCcw,
  ArrowRight,
  Plus,
  Trash2,
  ShieldCheck,
  ChevronDown,
  ChevronUp,
} from "lucide-react";

export function SampleParentDemo() {
  const p = SAMPLE_PARENT_PANEL;
  const [selectedAthleteId, setSelectedAthleteId] = useState<string>("sample-kimberly");
  const [checklistItems, setChecklistItems] = useState(p.morningChecklist);
  const [newChecklistInput, setNewChecklistInput] = useState("");
  const [parentNotes, setParentNotes] = useState(p.parentNotes);
  const [showFullProfile, setShowFullProfile] = useState(false);
  const [toast, setToast] = useState<string | null>(null);

  const flash = (msg: string) => {
    setToast(msg);
    setTimeout(() => setToast(null), 2200);
  };

  const currentAthlete =
    p.athletes.find((a) => a.id === selectedAthleteId) || p.athletes[0];
  const completedCount = checklistItems.filter((i) => i.checked).length;

  return (
    <div className="min-h-screen bg-[#0d1017] text-slate-100 flex flex-col">
      <DemoNavHeader activeDemo="parent" />

      {toast && (
        <div className="fixed bottom-6 left-1/2 -translate-x-1/2 z-50 rounded-full bg-slate-900 border border-emerald-500/40 px-5 py-2.5 text-xs font-bold text-white shadow-xl animate-fade-in">
          {toast}
        </div>
      )}

      {/* Hero Banner for Parent Command Center Demo */}
      <div className="border-b border-emerald-500/20 bg-gradient-to-b from-emerald-950/30 via-[#0d1017] to-[#0d1017]">
        <div className="mx-auto max-w-5xl px-4 sm:px-6 pt-6 pb-4">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
            <div className="flex items-center gap-3.5">
              <span className="flex h-12 w-12 items-center justify-center rounded-2xl bg-emerald-500/15 text-emerald-400 border border-emerald-500/30 shadow-lg shadow-emerald-950/50">
                <Heart className="h-6 w-6" />
              </span>
              <div>
                <div className="flex items-center gap-2 flex-wrap">
                  <h1 className="text-xl sm:text-2xl font-black text-white tracking-tight">
                    Parent Command Center
                  </h1>
                  <span className="rounded-full bg-emerald-500/15 border border-emerald-500/30 px-2.5 py-0.5 text-[10px] font-black uppercase tracking-wider text-emerald-300">
                    Live Demo
                  </span>
                </div>
                <p className="text-xs text-slate-400 mt-1">
                  Multi-athlete tracking · 2026 Selection Trials · Morning race checklist · Equipment lockers
                </p>
              </div>
            </div>

            {/* Athlete Switcher Pills */}
            <div className="flex items-center gap-1.5 p-1 rounded-2xl bg-black/60 border border-white/10 self-start sm:self-auto">
              {p.athletes.map((ath) => (
                <button
                  key={ath.id}
                  type="button"
                  onClick={() => setSelectedAthleteId(ath.id)}
                  className={`px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all ${
                    selectedAthleteId === ath.id
                      ? "bg-emerald-600 text-white shadow-sm shadow-emerald-900/40"
                      : "text-slate-400 hover:text-white hover:bg-white/5"
                  }`}
                >
                  <span>{ath.name}</span>
                  <span className="ml-1.5 text-[10px] font-mono opacity-80 font-normal">
                    ({ath.rankLabel})
                  </span>
                </button>
              ))}
              <button
                type="button"
                onClick={() => setSelectedAthleteId("all")}
                className={`px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all ${
                  selectedAthleteId === "all"
                    ? "bg-emerald-600 text-white shadow-sm shadow-emerald-900/40"
                    : "text-slate-400 hover:text-white hover:bg-white/5"
                }`}
              >
                All Athletes
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content Area */}
      <main className="flex-1 mx-auto max-w-5xl px-4 sm:px-6 py-6 w-full space-y-6">
        {/* ALL ATHLETES VIEW */}
        {selectedAthleteId === "all" ? (
          <div className="space-y-4">
            <div className="rounded-2xl border border-white/10 bg-white/[0.02] p-5">
              <h2 className="text-sm font-bold text-white mb-1">
                Family Fleet Summary
              </h2>
              <p className="text-xs text-slate-400">
                Side-by-side progression tracking across Optimist Gold and Silver series.
              </p>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {p.athletes.map((ath) => (
                <div
                  key={ath.id}
                  className="rounded-2xl border border-emerald-500/20 bg-emerald-500/[0.04] p-5 space-y-4"
                >
                  <div className="flex items-start justify-between gap-3">
                    <div>
                      <h3 className="text-base font-black text-white">{ath.name}</h3>
                      <p className="text-xs text-slate-400 font-mono mt-0.5">
                        {ath.sailNumber}
                        {ath.sailNumberIlca4 ? ` · ${ath.sailNumberIlca4}` : ""}
                      </p>
                      <p className="text-xs text-emerald-400 font-bold mt-1">
                        {ath.boatClass} · {ath.rankLabel}
                      </p>
                    </div>
                    <span className="rounded-full bg-emerald-500/15 border border-emerald-500/30 px-2.5 py-1 text-xs font-black text-emerald-300 font-mono">
                      #{ath.rank}
                    </span>
                  </div>
                  <div className="rounded-xl bg-black/30 border border-white/5 p-3 space-y-1">
                    <p className="text-[10px] font-bold uppercase tracking-wider text-slate-500">
                      Status / Pathway
                    </p>
                    <p className="text-xs font-medium text-slate-200">
                      {ath.selectionStatus}
                    </p>
                  </div>
                  <button
                    type="button"
                    onClick={() => setSelectedAthleteId(ath.id)}
                    className="w-full rounded-xl bg-white/10 hover:bg-white/15 py-2 text-xs font-bold text-white transition-colors"
                  >
                    Open {ath.name}&apos;s Workspace →
                  </button>
                </div>
              ))}
            </div>
          </div>
        ) : (
          /* SINGLE ATHLETE BENTO WORKSPACE */
          <div className="space-y-5">
            {/* Athlete Hero Card */}
            <div className="rounded-2xl border border-emerald-500/25 bg-gradient-to-r from-emerald-500/[0.08] via-teal-500/[0.04] to-transparent p-5 sm:p-6 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
              <div className="space-y-1.5">
                <div className="flex items-center gap-2 flex-wrap">
                  <h2 className="text-xl font-black text-white">
                    {currentAthlete.name}
                  </h2>
                  <span className="rounded-full bg-emerald-500/20 text-emerald-300 border border-emerald-500/30 px-2 py-0.5 text-[10px] font-bold inline-flex items-center gap-1">
                    <ShieldCheck className="h-3 w-3" />
                    Verified Athlete
                  </span>
                  <span className="rounded-full bg-blue-500/20 text-blue-300 border border-blue-500/30 px-2 py-0.5 text-[10px] font-mono font-bold">
                    Opti {currentAthlete.sailNumber}
                  </span>
                  {currentAthlete.sailNumberIlca4 && (
                    <span className="rounded-full bg-purple-500/20 text-purple-300 border border-purple-500/30 px-2 py-0.5 text-[10px] font-mono font-bold">
                      ILCA {currentAthlete.sailNumberIlca4}
                    </span>
                  )}
                </div>
                <p className="text-xs text-slate-400">
                  {p.club} · {p.coachName} · {currentAthlete.selectionStatus}
                </p>
              </div>
              <div className="flex items-center gap-2 shrink-0">
                <Link
                  href="/calendar"
                  className="rounded-xl border border-sky-500/30 bg-sky-500/10 hover:bg-sky-500/20 px-3.5 py-2 text-xs font-bold text-sky-300 transition-colors inline-flex items-center gap-1.5"
                >
                  <Calendar className="h-3.5 w-3.5" />
                  Racing Calendar
                </Link>
              </div>
            </div>

            {/* Bento Grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {/* Card 1: 2026 Asian Games & Selection Trials Standings */}
              <div className="rounded-2xl border border-amber-500/25 bg-amber-500/[0.04] p-5 space-y-4">
                <div className="flex items-center justify-between gap-2">
                  <p className="text-[10px] font-black uppercase tracking-wider text-amber-400 flex items-center gap-1.5">
                    <Target className="h-3.5 w-3.5" />
                    2026 Selection Trials Standings
                  </p>
                  <span className="rounded-full bg-amber-500/15 border border-amber-500/30 px-2 py-0.5 text-[10px] font-bold text-amber-300">
                    Rank #{p.selectionTrials.trialsRank}
                  </span>
                </div>
                <div className="grid grid-cols-3 gap-2">
                  <div className="rounded-xl bg-black/30 border border-white/5 p-3 text-center">
                    <p className="text-[10px] font-bold uppercase text-slate-500">
                      Combined Score
                    </p>
                    <p className="text-lg font-black text-white font-mono mt-0.5">
                      {p.selectionTrials.totalPoints}
                    </p>
                  </div>
                  <div className="rounded-xl bg-black/30 border border-white/5 p-3 text-center">
                    <p className="text-[10px] font-bold uppercase text-slate-500">
                      Events Sailed
                    </p>
                    <p className="text-lg font-black text-white font-mono mt-0.5">
                      {p.selectionTrials.eventsCount}
                    </p>
                  </div>
                  <div className="rounded-xl bg-black/30 border border-white/5 p-3 text-center">
                    <p className="text-[10px] font-bold uppercase text-slate-500">
                      Cutoff Buffer
                    </p>
                    <p className="text-lg font-black text-emerald-400 font-mono mt-0.5">
                      +{p.selectionTrials.gapToCutoff} pts
                    </p>
                  </div>
                </div>
                <div className="rounded-xl bg-emerald-500/10 border border-emerald-500/20 p-3 space-y-1">
                  <div className="flex items-center gap-1.5 text-xs font-bold text-emerald-300">
                    <CheckCircle2 className="h-3.5 w-3.5" />
                    <span>Provisional Asian Games &amp; Perth Qualifier</span>
                  </div>
                  <p className="text-[11px] text-slate-300 leading-snug">
                    {p.selectionTrials.selectionNote}
                  </p>
                </div>
                <Link
                  href="/sg/optimist/selection"
                  className="inline-flex items-center gap-1 text-xs font-bold text-amber-400 hover:text-amber-300"
                >
                  <span>View full 2026 Selection Board</span>
                  <ArrowRight className="h-3 w-3" />
                </Link>
              </div>

              {/* Card 2: Equipment Locker & Maintenance Alerts */}
              <div className="rounded-2xl border border-white/10 bg-white/[0.02] p-5 space-y-4">
                <div className="flex items-center justify-between gap-2">
                  <p className="text-[10px] font-black uppercase tracking-wider text-slate-400 flex items-center gap-1.5">
                    <Wrench className="h-3.5 w-3.5 text-orange-400" />
                    Boat Locker &amp; Equipment
                  </p>
                  <span className="text-[10px] font-semibold text-slate-500">
                    4 Registered Items
                  </span>
                </div>
                <div className="grid grid-cols-2 gap-2">
                  {p.equipmentLocker.map((item) => {
                    const cond = String(item.condition);
                    const isReady = cond === "race_ready" || cond === "good";
                    const isPractice = cond === "practice_only" || cond === "fair";
                    return (
                      <div
                        key={item.type}
                        className="rounded-xl bg-black/25 border border-white/5 p-2.5"
                      >
                        <div className="flex items-center justify-between text-[10px]">
                          <span className="font-bold text-slate-400 uppercase">
                            {item.type}
                          </span>
                          <span
                            className={`px-1.5 py-0.5 rounded font-bold uppercase text-[9px] ${
                              isReady
                                ? "bg-emerald-500/15 text-emerald-300"
                                : isPractice
                                ? "bg-amber-500/15 text-amber-300"
                                : "bg-rose-500/15 text-rose-300"
                            }`}
                          >
                            {isReady ? "Race Ready" : isPractice ? "Practice Only" : "Needs Repair"}
                          </span>
                        </div>
                        <p className="text-xs font-bold text-white mt-1 truncate">
                          {item.brand}
                        </p>
                      </div>
                    );
                  })}
                </div>
                <div className="rounded-xl bg-amber-500/10 border border-amber-500/25 p-3 flex items-start gap-2.5">
                  <AlertTriangle className="h-4 w-4 text-amber-400 shrink-0 mt-0.5" />
                  <p className="text-xs text-amber-200 leading-snug">
                    Sail acquired Feb 2025 (~18 months). Consider measuring a backup sail before AOC trials.
                  </p>
                </div>
              </div>

              {/* Card 3: Coach Observations & Debriefs */}
              <div className="rounded-2xl border border-blue-500/25 bg-blue-500/[0.04] p-5 space-y-3">
                <p className="text-[10px] font-black uppercase tracking-wider text-blue-400 flex items-center gap-1.5">
                  <GraduationCap className="h-3.5 w-3.5" />
                  Coach Technical Debriefs
                </p>
                <div className="space-y-2">
                  {p.coachDebriefs.map((deb, idx) => (
                    <div
                      key={idx}
                      className="rounded-xl bg-black/30 border border-white/5 p-3 space-y-1"
                    >
                      <div className="flex items-center justify-between text-[10px]">
                        <span className="font-bold text-blue-300">{deb.coachName}</span>
                        <span className="rounded bg-white/5 px-1.5 py-0.5 text-slate-400 font-mono">
                          {deb.category} · {deb.date}
                        </span>
                      </div>
                      <p className="text-xs text-slate-300 leading-relaxed">
                        {deb.note}
                      </p>
                    </div>
                  ))}
                </div>
              </div>

              {/* Card 4: Pre-Race Morning Checklist & Calendar */}
              <div className="rounded-2xl border border-white/10 bg-white/[0.02] p-5 space-y-3.5">
                <div className="flex items-center justify-between gap-2">
                  <p className="text-[10px] font-black uppercase tracking-wider text-slate-400 flex items-center gap-1.5">
                    <CheckSquare className="h-3.5 w-3.5 text-emerald-400" />
                    Pre-Race Morning Checklist
                  </p>
                  <div className="flex items-center gap-2">
                    <span className="text-[10px] font-mono text-emerald-400 font-bold">
                      {completedCount}/{checklistItems.length} Ready
                    </span>
                    <button
                      type="button"
                      onClick={() => {
                        setChecklistItems((prev) =>
                          prev.map((i) => ({ ...i, checked: false }))
                        );
                        flash("Demo checklist reset");
                      }}
                      className="text-[10px] text-slate-500 hover:text-white p-1"
                      title="Reset checklist"
                    >
                      <RotateCcw className="h-3 w-3" />
                    </button>
                  </div>
                </div>

                {/* Interactive Checklist toggles in demo */}
                <div className="space-y-1.5">
                  {checklistItems.map((item) => (
                    <div
                      key={item.id}
                      className={`group flex items-center justify-between p-2 rounded-xl transition-colors ${
                        item.checked
                          ? "bg-emerald-500/10 border border-emerald-500/20 text-slate-200"
                          : "bg-black/20 border border-white/5 text-slate-400 hover:bg-white/5"
                      }`}
                    >
                      <button
                        type="button"
                        onClick={() => {
                          setChecklistItems((prev) =>
                            prev.map((i) =>
                              i.id === item.id ? { ...i, checked: !i.checked } : i
                            )
                          );
                        }}
                        className="w-full text-left flex items-start gap-2.5 min-w-0"
                      >
                        {item.checked ? (
                          <CheckSquare className="h-4 w-4 text-emerald-400 shrink-0 mt-0.5" />
                        ) : (
                          <Square className="h-4 w-4 text-slate-600 shrink-0 mt-0.5" />
                        )}
                        <span
                          className={`text-xs ${
                            item.checked ? "line-through opacity-80" : ""
                          }`}
                        >
                          {item.label}
                        </span>
                      </button>
                      {item.id.startsWith("custom") && (
                        <button
                          type="button"
                          onClick={() => {
                            setChecklistItems((prev) =>
                              prev.filter((i) => i.id !== item.id)
                            );
                            flash("Checklist item removed");
                          }}
                          className="text-slate-500 hover:text-rose-400 p-1 opacity-70 group-hover:opacity-100 transition shrink-0 ml-2"
                          title="Remove custom item"
                        >
                          <Trash2 className="h-3.5 w-3.5" />
                        </button>
                      )}
                    </div>
                  ))}
                </div>

                {/* Add Custom Item Input */}
                <div className="flex items-center gap-2 pt-1">
                  <input
                    type="text"
                    value={newChecklistInput}
                    onChange={(e) => setNewChecklistInput(e.target.value)}
                    onKeyDown={(e) => {
                      if (e.key === "Enter") {
                        e.preventDefault();
                        const trimmed = newChecklistInput.trim();
                        if (!trimmed) return;
                        setChecklistItems((prev) => [
                          ...prev,
                          { id: `custom-${Date.now()}`, label: trimmed, checked: false },
                        ]);
                        setNewChecklistInput("");
                        flash("Custom item added");
                      }
                    }}
                    placeholder="Add custom prep item…"
                    className="flex-1 rounded-xl bg-black/30 border border-white/10 px-3 py-1.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-emerald-500"
                  />
                  <button
                    type="button"
                    onClick={() => {
                      const trimmed = newChecklistInput.trim();
                      if (!trimmed) return;
                      setChecklistItems((prev) => [
                        ...prev,
                        { id: `custom-${Date.now()}`, label: trimmed, checked: false },
                      ]);
                      setNewChecklistInput("");
                      flash("Custom item added");
                    }}
                    className="rounded-xl bg-emerald-600 hover:bg-emerald-500 px-3 py-1.5 text-xs font-bold text-white transition flex items-center gap-1 shrink-0"
                  >
                    <Plus className="h-3.5 w-3.5" />
                    <span>Add</span>
                  </button>
                </div>

                {/* Upcoming Calendar Hook */}
                <div className="pt-2 border-t border-white/5">
                  <p className="text-[10px] font-bold text-slate-500 uppercase mb-2">
                    Upcoming 2026 Fixtures
                  </p>
                  <div className="space-y-1.5">
                    {p.nextEvents.slice(0, 2).map((ev) => (
                      <div
                        key={ev.name}
                        className="flex items-center justify-between text-xs p-2 rounded-lg bg-black/20"
                      >
                        <div>
                          <p className="font-bold text-white truncate max-w-[220px]">
                            {ev.name}
                          </p>
                          <p className="text-[10px] text-slate-500">{ev.date} · {ev.venue}</p>
                        </div>
                        <span className="text-[10px] font-bold text-orange-400">
                          {ev.deadline}
                        </span>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </div>

            {/* Card 5: Private Parent Journal */}
            <div className="rounded-2xl border border-white/10 bg-white/[0.02] p-5 space-y-3">
              <div className="flex items-center justify-between gap-2 flex-wrap">
                <div>
                  <h3 className="text-xs font-black text-white uppercase tracking-wider">
                    Private Parent Journal
                  </h3>
                  <p className="text-[11px] text-slate-500">
                    Encrypted notes visible only to the guardian — separate from public logs
                  </p>
                </div>
                <button
                  type="button"
                  onClick={() => {
                    setParentNotes((prev) => [
                      {
                        date: new Date().toISOString().slice(0, 10),
                        text: "(Demo) Extra fitness conditioning before Singapore Youth Championships.",
                      },
                      ...prev,
                    ]);
                    flash("Demo parent note added");
                  }}
                  className="rounded-full bg-emerald-600 hover:bg-emerald-500 px-3 py-1.5 text-xs font-bold text-white transition-colors"
                >
                  + Add Note
                </button>
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5">
                {parentNotes.map((n, i) => (
                  <div
                    key={i}
                    className="rounded-xl bg-black/25 border border-white/5 p-3 space-y-1"
                  >
                    <div className="flex items-center justify-between text-[10px]">
                      <span className="font-mono text-emerald-400 font-bold">
                        {n.date}
                      </span>
                      <span className="rounded bg-white/5 px-1.5 py-0.5 text-slate-500">
                        Private
                      </span>
                    </div>
                    <p className="text-xs text-slate-300 leading-relaxed">
                      {n.text}
                    </p>
                  </div>
                ))}
              </div>
            </div>

            {/* Collapsible Sailor Profile Inspection */}
            <div className="border border-white/10 rounded-2xl bg-white/[0.01] overflow-hidden">
              <button
                type="button"
                onClick={() => setShowFullProfile(!showFullProfile)}
                className="w-full flex items-center justify-between p-4 hover:bg-white/[0.02] transition-colors text-left"
              >
                <div>
                  <h4 className="text-sm font-bold text-white">
                    {showFullProfile ? "Hide" : "Inspect"} Kimberly&apos;s Full Sailor Profile
                  </h4>
                  <p className="text-xs text-slate-500 mt-0.5">
                    Preview how race results, rankings, and dual-class cards appear alongside your parent dashboard.
                  </p>
                </div>
                <span className="rounded-xl bg-white/10 p-2 text-slate-300">
                  {showFullProfile ? (
                    <ChevronUp className="h-4 w-4" />
                  ) : (
                    <ChevronDown className="h-4 w-4" />
                  )}
                </span>
              </button>

              {showFullProfile && (
                <div className="border-t border-white/10 p-4 sm:p-6 bg-black/40">
                  <SailorProfileView
                    initialSailor={SAMPLE_SAILOR}
                    initialResults={SAMPLE_RESULTS}
                    initialEquipment={SAMPLE_EQUIPMENT}
                    initialSeriesStanding={SAMPLE_SERIES_STANDING}
                    initialIlcaStanding={SAMPLE_ILCA_STANDING}
                    initialObservations={SAMPLE_OBSERVATIONS}
                    canSeePrivate={true}
                    canClaim={false}
                    isOwner={false}
                    isLoggedIn={true}
                    demoMode={true}
                    demoRole="parent"
                    hidePrivacySection={true}
                    profileVerified={true}
                  />
                </div>
              )}
            </div>
          </div>
        )}

        {/* Bottom CTA Banner */}
        <div className="rounded-3xl border border-emerald-500/30 bg-gradient-to-r from-emerald-950/40 via-black to-emerald-950/20 p-6 sm:p-8 flex flex-col sm:flex-row sm:items-center justify-between gap-6">
          <div className="space-y-1.5 max-w-xl">
            <h3 className="text-lg font-black text-white">
              Ready to manage your sailor&apos;s pathway?
            </h3>
            <p className="text-xs sm:text-sm text-slate-300 leading-relaxed">
              Claim your child&apos;s verified SailorPath profile to track selection trials, log gear maintenance, and organize pre-race morning checklists.
            </p>
          </div>
          <div className="flex flex-col sm:flex-row items-center gap-3 shrink-0">
            <Link
              href="/claim-profile"
              className="w-full sm:w-auto text-center rounded-2xl bg-emerald-500 hover:bg-emerald-400 text-black px-5 py-3 text-xs font-black shadow-lg shadow-emerald-500/20 transition-all"
            >
              Claim Sailor Profile
            </Link>
            <Link
              href="/parent"
              className="w-full sm:w-auto text-center rounded-2xl bg-white/10 hover:bg-white/15 text-white border border-white/15 px-5 py-3 text-xs font-bold transition-all"
            >
              Sign In to Parent Hub
            </Link>
          </div>
        </div>
      </main>
    </div>
  );
}
