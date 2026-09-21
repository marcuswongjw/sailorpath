"use client";

import { useState } from "react";
import Link from "next/link";
import { DemoNavHeader } from "@/components/demo/DemoNavHeader";
import {
  SAMPLE_PARENT_PANEL,
} from "@/lib/sampleProfile";
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
} from "lucide-react";

export function SampleParentDemo() {
  const p = SAMPLE_PARENT_PANEL;
  const [selectedAthleteId, setSelectedAthleteId] = useState<string>("sample-kimberly");
  const [checklistItems, setChecklistItems] = useState(p.morningChecklist);
  const [newChecklistInput, setNewChecklistInput] = useState("");
  const [parentNotes, setParentNotes] = useState(p.parentNotes);
  const [toast, setToast] = useState<string | null>(null);

  const flash = (msg: string) => {
    setToast(msg);
    setTimeout(() => setToast(null), 2200);
  };

  const currentAthlete =
    p.athletes.find((a) => a.id === selectedAthleteId) || p.athletes[0];
  const completedCount = checklistItems.filter((i) => i.checked).length;

  return (
    <div className="min-h-screen bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal-slate)] flex flex-col">
      <DemoNavHeader activeDemo="parent" />

      {toast && (
        <div className="fixed bottom-6 left-1/2 -translate-x-1/2 z-50 rounded-full bg-[var(--sp-harbour-shadow)] border border-[var(--sp-harbour-teal)] text-white px-5 py-2.5 text-xs font-bold shadow-xl animate-fade-in">
          {toast}
        </div>
      )}

      {/* Hero Banner for Parent Command Center Demo */}
      <div className="border-b border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)]">
        <div className="mx-auto max-w-5xl px-4 sm:px-6 pt-6 pb-4">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
            <div className="flex items-center gap-3.5">
              <span className="flex h-12 w-12 items-center justify-center rounded-2xl bg-[var(--sp-harbour-teal)]/10 text-[var(--sp-harbour-teal)] border border-[var(--sp-harbour-teal)]/20 shadow-xs">
                <Heart className="h-6 w-6" />
              </span>
              <div>
                <div className="flex items-center gap-2 flex-wrap">
                  <h1 className="text-xl sm:text-2xl font-black font-display text-[var(--sp-harbour-shadow)] tracking-tight">
                    Parent Command Center
                  </h1>
                  <span className="rounded-full bg-[var(--sp-harbour-teal)]/15 border border-[var(--sp-harbour-teal)]/30 px-2.5 py-0.5 text-[12px] font-black uppercase tracking-wider text-[var(--sp-harbour-teal)]">
                    Live Demo
                  </span>
                </div>
                <p className="text-xs text-[var(--sp-slate-soft)] mt-1">
                  Multi-athlete tracking · 2026 Selection Trials · Morning race checklist · Equipment lockers
                </p>
              </div>
            </div>

            {/* Athlete Switcher Pills */}
            <div className="flex items-center gap-1.5 p-1 rounded-2xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] self-start sm:self-auto">
              {p.athletes.map((ath) => (
                <button
                  key={ath.id}
                  type="button"
                  onClick={() => setSelectedAthleteId(ath.id)}
                  className={`px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all ${
                    selectedAthleteId === ath.id
                      ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                      : "text-[var(--sp-charcoal-slate)] hover:text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-warm-white)]"
                  }`}
                >
                  <span>{ath.name}</span>
                  <span className="ml-1.5 text-[13px] font-mono opacity-80 font-normal">
                    ({ath.rankLabel})
                  </span>
                </button>
              ))}
              <button
                type="button"
                onClick={() => setSelectedAthleteId("all")}
                className={`px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all ${
                  selectedAthleteId === "all"
                    ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                    : "text-[var(--sp-charcoal-slate)] hover:text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-warm-white)]"
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
            <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-xs">
              <h2 className="text-sm font-bold text-[var(--sp-harbour-shadow)] mb-1">
                Family Fleet Summary
              </h2>
              <p className="text-xs text-[var(--sp-slate-soft)]">
                Side-by-side progression tracking across Optimist Gold and Silver series.
              </p>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {p.athletes.map((ath) => (
                <div
                  key={ath.id}
                  className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 space-y-4 shadow-xs"
                >
                  <div className="flex items-start justify-between gap-3">
                    <div>
                      <h3 className="text-base font-black text-[var(--sp-harbour-shadow)]">{ath.name}</h3>
                      <p className="text-xs text-[var(--sp-slate-soft)] font-mono mt-0.5">
                        {ath.sailNumber}
                        {ath.sailNumberIlca4 ? ` · ${ath.sailNumberIlca4}` : ""}
                      </p>
                      <p className="text-xs text-[var(--sp-harbour-teal)] font-bold mt-1">
                        {ath.boatClass} · {ath.rankLabel}
                      </p>
                    </div>
                    <span className="rounded-full bg-[var(--sp-harbour-teal)]/10 border border-[var(--sp-harbour-teal)]/25 px-2.5 py-1 text-xs font-black text-[var(--sp-harbour-teal)] font-mono">
                      #{ath.rank}
                    </span>
                  </div>
                  <div className="rounded-xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] p-3 space-y-1">
                    <p className="text-[12px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">
                      Status / Pathway
                    </p>
                    <p className="text-xs font-medium text-[var(--sp-harbour-shadow)]">
                      {ath.selectionStatus}
                    </p>
                  </div>
                  <button
                    type="button"
                    onClick={() => setSelectedAthleteId(ath.id)}
                    className="w-full rounded-xl bg-[var(--sp-sailcloth)] hover:bg-[var(--sp-cool-veil)]/60 border border-[var(--sp-cool-veil)] py-2 text-xs font-bold text-[var(--sp-harbour-shadow)] transition-colors"
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
            <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 flex flex-col sm:flex-row sm:items-center justify-between gap-4 shadow-xs">
              <div className="space-y-1.5">
                <div className="flex items-center gap-2 flex-wrap">
                  <h2 className="text-xl font-black font-display text-[var(--sp-harbour-shadow)]">
                    {currentAthlete.name}
                  </h2>
                  <span className="rounded-full bg-emerald-500/15 text-emerald-700 dark:text-emerald-300 border border-emerald-500/30 px-2.5 py-0.5 text-[11px] font-bold inline-flex items-center gap-1">
                    <ShieldCheck className="h-3 w-3" />
                    Verified Athlete
                  </span>
                  <span className="rounded-full bg-[var(--sp-harbour-teal)]/10 text-[var(--sp-harbour-teal)] border border-[var(--sp-harbour-teal)]/20 px-2 py-0.5 text-[11px] font-mono font-bold">
                    Opti {currentAthlete.sailNumber}
                  </span>
                  {currentAthlete.sailNumberIlca4 && (
                    <span className="rounded-full bg-purple-500/10 text-purple-700 border border-purple-500/20 px-2 py-0.5 text-[11px] font-mono font-bold">
                      ILCA {currentAthlete.sailNumberIlca4}
                    </span>
                  )}
                </div>
                <p className="text-xs text-[var(--sp-slate-soft)]">
                  {p.club} · {p.coachName} · {currentAthlete.selectionStatus}
                </p>
              </div>
              <div className="flex items-center gap-2 shrink-0">
                <Link
                  href="/calendar"
                  className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] hover:bg-[var(--sp-cool-veil)]/50 px-3.5 py-2 text-xs font-bold text-[var(--sp-harbour-shadow)] transition-colors inline-flex items-center gap-1.5 shadow-xs"
                >
                  <Calendar className="h-3.5 w-3.5 text-[var(--sp-racing-orange)]" />
                  Racing Calendar
                </Link>
              </div>
            </div>

            {/* Bento Grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {/* Card 1: 2026 Asian Games & Selection Trials Standings */}
              <div className="rounded-2xl border border-[var(--sp-racing-orange)]/25 bg-[var(--sp-warm-white)] p-5 space-y-4 shadow-xs">
                <div className="flex items-center justify-between gap-2">
                  <p className="text-[12px] font-black uppercase tracking-wider text-[var(--sp-racing-orange)] flex items-center gap-1.5">
                    <Target className="h-3.5 w-3.5" />
                    2026 Selection Trials Standings
                  </p>
                  <span className="rounded-full bg-[var(--sp-racing-orange)]/15 border border-[var(--sp-racing-orange)]/30 px-2 py-0.5 text-[11px] font-bold text-[var(--sp-racing-deep)]">
                    Rank #{p.selectionTrials.trialsRank}
                  </span>
                </div>
                <div className="grid grid-cols-3 gap-2">
                  <div className="rounded-xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] p-3 text-center">
                    <p className="text-[12px] font-bold uppercase text-[var(--sp-slate-soft)]">
                      Combined Score
                    </p>
                    <p className="text-lg font-black text-[var(--sp-harbour-shadow)] font-mono mt-0.5">
                      {p.selectionTrials.totalPoints}
                    </p>
                  </div>
                  <div className="rounded-xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] p-3 text-center">
                    <p className="text-[12px] font-bold uppercase text-[var(--sp-slate-soft)]">
                      Events Sailed
                    </p>
                    <p className="text-lg font-black text-[var(--sp-harbour-shadow)] font-mono mt-0.5">
                      {p.selectionTrials.eventsCount}
                    </p>
                  </div>
                  <div className="rounded-xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] p-3 text-center">
                    <p className="text-[12px] font-bold uppercase text-[var(--sp-slate-soft)]">
                      Cutoff Buffer
                    </p>
                    <p className="text-lg font-black text-emerald-600 font-mono mt-0.5">
                      +{p.selectionTrials.gapToCutoff} pts
                    </p>
                  </div>
                </div>
                <div className="rounded-xl bg-emerald-500/10 border border-emerald-500/20 p-3 space-y-1">
                  <div className="flex items-center gap-1.5 text-xs font-bold text-emerald-700 dark:text-emerald-300">
                    <CheckCircle2 className="h-3.5 w-3.5 text-emerald-600" />
                    <span>Provisional Asian Games &amp; Perth Qualifier</span>
                  </div>
                  <p className="text-[13px] text-[var(--sp-charcoal-slate)] leading-snug">
                    {p.selectionTrials.selectionNote}
                  </p>
                </div>
                <Link
                  href="/sg/optimist/selection"
                  className="inline-flex items-center gap-1 text-xs font-bold text-[var(--sp-racing-orange)] hover:underline"
                >
                  <span>View full 2026 Selection Board</span>
                  <ArrowRight className="h-3 w-3" />
                </Link>
              </div>

              {/* Card 2: Equipment Locker & Maintenance Alerts */}
              <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 space-y-4 shadow-xs">
                <div className="flex items-center justify-between gap-2">
                  <p className="text-[12px] font-black uppercase tracking-wider text-[var(--sp-slate-soft)] flex items-center gap-1.5">
                    <Wrench className="h-3.5 w-3.5 text-[var(--sp-racing-orange)]" />
                    Boat Locker &amp; Equipment
                  </p>
                  <span className="text-[13px] font-semibold text-[var(--sp-slate-soft)]">
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
                        className="rounded-xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] p-2.5"
                      >
                        <div className="flex items-center justify-between text-[13px]">
                          <span className="font-bold text-[var(--sp-slate-soft)] uppercase">
                            {item.type}
                          </span>
                          <span
                            className={`px-1.5 py-0.5 rounded font-bold uppercase text-[12px] ${
                              isReady
                                ? "bg-emerald-500/15 text-emerald-700 dark:text-emerald-300"
                                : isPractice
                                ? "bg-amber-500/15 text-amber-700"
                                : "bg-rose-500/15 text-rose-700"
                            }`}
                          >
                            {isReady ? "Race Ready" : isPractice ? "Practice Only" : "Needs Repair"}
                          </span>
                        </div>
                        <p className="text-xs font-bold text-[var(--sp-harbour-shadow)] mt-1 truncate">
                          {item.brand}
                        </p>
                      </div>
                    );
                  })}
                </div>
                <div className="rounded-xl bg-amber-500/10 border border-amber-500/25 p-3 flex items-start gap-2.5">
                  <AlertTriangle className="h-4 w-4 text-amber-600 shrink-0 mt-0.5" />
                  <p className="text-xs text-amber-800 leading-snug">
                    Sail acquired Feb 2025 (~18 months). Consider measuring a backup sail before AOC trials.
                  </p>
                </div>
              </div>

              {/* Card 3: Coach Observations & Debriefs */}
              <div className="rounded-2xl border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-warm-white)] p-5 space-y-3 shadow-xs">
                <p className="text-[12px] font-black uppercase tracking-wider text-[var(--sp-harbour-teal)] flex items-center gap-1.5">
                  <GraduationCap className="h-3.5 w-3.5" />
                  Coach Technical Debriefs
                </p>
                <div className="space-y-2">
                  {p.coachDebriefs.map((deb, idx) => (
                    <div
                      key={idx}
                      className="rounded-xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] p-3 space-y-1"
                    >
                      <div className="flex items-center justify-between text-[13px]">
                        <span className="font-bold text-[var(--sp-harbour-teal)]">{deb.coachName}</span>
                        <span className="rounded bg-[var(--sp-cool-veil)]/50 px-1.5 py-0.5 text-[var(--sp-slate-soft)] font-mono">
                          {deb.category} · {deb.date}
                        </span>
                      </div>
                      <p className="text-xs text-[var(--sp-charcoal-slate)] leading-relaxed">
                        {deb.note}
                      </p>
                    </div>
                  ))}
                </div>
              </div>

              {/* Card 4: Pre-Race Morning Checklist */}
              <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 space-y-3.5 shadow-xs">
                <div className="flex items-center justify-between gap-2">
                  <p className="text-[12px] font-black uppercase tracking-wider text-[var(--sp-slate-soft)] flex items-center gap-1.5">
                    <CheckSquare className="h-3.5 w-3.5 text-emerald-600" />
                    Pre-Race Morning Checklist
                  </p>
                  <div className="flex items-center gap-2">
                    <span className="text-[13px] font-mono text-emerald-600 font-bold">
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
                      className="text-[10px] text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)] p-1"
                      title="Reset checklist"
                    >
                      <RotateCcw className="h-3 w-3" />
                    </button>
                  </div>
                </div>

                {/* Interactive Checklist toggles */}
                <div className="space-y-1.5">
                  {checklistItems.map((item) => (
                    <div
                      key={item.id}
                      className={`group flex items-center justify-between p-2 rounded-xl transition-colors ${
                        item.checked
                          ? "bg-emerald-500/10 border border-emerald-500/20 text-[var(--sp-harbour-shadow)]"
                          : "bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal-slate)] hover:bg-[var(--sp-cool-veil)]/40"
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
                          <CheckSquare className="h-4 w-4 text-emerald-600 shrink-0 mt-0.5" />
                        ) : (
                          <Square className="h-4 w-4 text-[var(--sp-slate-soft)] shrink-0 mt-0.5" />
                        )}
                        <span
                          className={`text-xs ${
                            item.checked ? "line-through opacity-70" : ""
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
                          className="text-[var(--sp-slate-soft)] hover:text-rose-600 p-1 opacity-70 group-hover:opacity-100 transition shrink-0 ml-2"
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
                    className="flex-1 sp-input py-1.5 px-3 text-xs"
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
                    className="sp-btn-primary px-3 py-1.5 text-xs font-bold flex items-center gap-1 shrink-0"
                  >
                    <Plus className="h-3.5 w-3.5" />
                    <span>Add</span>
                  </button>
                </div>

                {/* Upcoming Calendar Hook */}
                <div className="pt-2 border-t border-[var(--sp-cool-veil)]">
                  <p className="text-[12px] font-bold text-[var(--sp-slate-soft)] uppercase mb-2">
                    Upcoming 2026 Fixtures
                  </p>
                  <div className="space-y-1.5">
                    {p.nextEvents.slice(0, 2).map((ev) => (
                      <div
                        key={ev.name}
                        className="flex items-center justify-between text-xs p-2 rounded-lg bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)]"
                      >
                        <div>
                          <p className="font-bold text-[var(--sp-harbour-shadow)] truncate max-w-[220px]">
                            {ev.name}
                          </p>
                          <p className="text-[13px] text-[var(--sp-slate-soft)]">{ev.date} · {ev.venue}</p>
                        </div>
                        <span className="text-[13px] font-bold text-[var(--sp-racing-orange)]">
                          {ev.deadline}
                        </span>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </div>

            {/* Card 5: Private Parent Journal */}
            <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 space-y-3 shadow-xs">
              <div className="flex items-center justify-between gap-2 flex-wrap">
                <div>
                  <h3 className="text-xs font-black uppercase tracking-wider text-[var(--sp-harbour-shadow)]">
                    Private Parent Journal
                  </h3>
                  <p className="text-[13px] text-[var(--sp-slate-soft)]">
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
                  className="sp-btn-primary px-3 py-1.5 text-xs font-bold"
                >
                  + Add Note
                </button>
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5">
                {parentNotes.map((n, i) => (
                  <div
                    key={i}
                    className="rounded-xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] p-3 space-y-1"
                  >
                    <div className="flex items-center justify-between text-[13px]">
                      <span className="font-mono text-[var(--sp-harbour-teal)] font-bold">
                        {n.date}
                      </span>
                      <span className="rounded bg-[var(--sp-cool-veil)]/50 px-1.5 py-0.5 text-[var(--sp-slate-soft)]">
                        Private
                      </span>
                    </div>
                    <p className="text-xs text-[var(--sp-charcoal-slate)] leading-relaxed">
                      {n.text}
                    </p>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {/* Bottom CTA Banner */}
        <div className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-6 sm:p-8 flex flex-col sm:flex-row sm:items-center justify-between gap-6 shadow-sm">
          <div className="space-y-1.5 max-w-xl">
            <h3 className="text-lg font-black font-display text-[var(--sp-harbour-shadow)]">
              Ready to manage your sailor&apos;s pathway?
            </h3>
            <p className="text-xs sm:text-sm text-[var(--sp-charcoal-slate)] leading-relaxed">
              Claim your child&apos;s verified SailorPath profile to track selection trials, log gear maintenance, and organize pre-race morning checklists.
            </p>
          </div>
          <div className="flex flex-col sm:flex-row items-center gap-3 shrink-0">
            <Link
              href="/claim-profile"
              className="w-full sm:w-auto text-center sp-btn-primary px-5 py-3 text-xs font-bold"
            >
              Claim Sailor Profile
            </Link>
            <Link
              href="/parent"
              className="w-full sm:w-auto text-center rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] hover:bg-[var(--sp-cool-veil)]/50 text-[var(--sp-harbour-shadow)] px-5 py-3 text-xs font-bold transition-colors"
            >
              Sign In to Parent Hub
            </Link>
          </div>
        </div>
      </main>
    </div>
  );
}
