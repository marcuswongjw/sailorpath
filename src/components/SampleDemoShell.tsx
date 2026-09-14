"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import { useSearchParams } from "next/navigation";
import { SailorProfileView } from "@/components/SailorProfileView";
import {
  DEMO_ROLE_COPY,
  SAMPLE_COACH_PANEL,
  SAMPLE_EQUIPMENT,
  SAMPLE_ILCA_STANDING,
  SAMPLE_OBSERVATIONS,
  SAMPLE_PARENT_PANEL,
  SAMPLE_RESULTS,
  SAMPLE_SAILOR,
  SAMPLE_SERIES_STANDING,
  type DemoRole,
} from "@/lib/sampleProfile";
import {
  Users,
  User,
  Heart,
  ClipboardList,
  Sparkles,
  Settings,
  X,
  Calendar,
  AlertTriangle,
  CheckCircle2,
  Wrench,
  GraduationCap,
  UserPlus,
  ChevronRight,
  Target,
  CheckSquare,
  Square,
  RotateCcw,
  ArrowRight,
} from "lucide-react";
import { trackClientUsage } from "@/lib/clientUsage";

type CoachRosterSailor = {
  name: string;
  handle: string;
  rank: number;
  highlight: string;
  avgFinish?: string;
  selection?: string;
};

const ROLES: DemoRole[] = ["public", "sailor", "parent", "coach"];

function PrivacySettingsBody({
  childLabel,
  onSave,
}: {
  childLabel?: string;
  onSave: () => void;
}) {
  const [weight, setWeight] = useState(false);
  const [fullDob, setFullDob] = useState(false);

  return (
    <div className="space-y-4">
      <p className="text-[12px] text-neutral-400 leading-relaxed">
        {childLabel
          ? `Manage ${childLabel}'s privacy. Birth year is always public when set; month and day stay private unless shared. Equipment is always private to the family.`
          : "Birth year is always public when set. Month/day and weight stay private unless shared. Equipment is always private to the sailor and linked parents."}
      </p>
      <div className="space-y-2">
        {(
          [
            {
              label: "Share weight",
              hint: "Show kg on public profile",
              checked: weight,
              set: setWeight,
            },
            {
              label: "Also share month & day",
              hint: "Year is always public; this also shows the full date",
              checked: fullDob,
              set: setFullDob,
            },
          ] as const
        ).map((row) => (
          <label
            key={row.label}
            className="flex flex-col gap-1.5 rounded-xl border border-white/[0.08] px-3 py-2.5 cursor-pointer hover:bg-white/[0.02]"
          >
            <span className="flex items-center justify-between gap-3">
              <span className="text-xs font-medium text-neutral-200">
                {row.label}
              </span>
              <input
                type="checkbox"
                checked={row.checked}
                onChange={(e) => row.set(e.target.checked)}
                className="rounded border-neutral-600 shrink-0"
              />
            </span>
            <span className="text-[10px] text-neutral-500">{row.hint}</span>
          </label>
        ))}
      </div>
      <button
        type="button"
        onClick={onSave}
        className="w-full rounded-xl bg-orange-600 py-2.5 text-[12px] font-bold text-white hover:bg-orange-500"
      >
        Save privacy (demo)
      </button>
    </div>
  );
}

export function SampleDemoShell() {
  const searchParams = useSearchParams();
  const initial = (searchParams.get("view") || "public").toLowerCase();
  const startRole: DemoRole = ROLES.includes(initial as DemoRole)
    ? (initial as DemoRole)
    : "public";

  const [role, setRole] = useState<DemoRole>(startRole);
  const [toast, setToast] = useState<string | null>(null);
  const [coachNotes, setCoachNotes] = useState(SAMPLE_COACH_PANEL.coachNotes);
  const [parentNotes, setParentNotes] = useState(SAMPLE_PARENT_PANEL.parentNotes);
  const [selectedAthleteId, setSelectedAthleteId] = useState<string>("sample-kimberly");
  const [checklistItems, setChecklistItems] = useState(SAMPLE_PARENT_PANEL.morningChecklist);
  const [settingsOpen, setSettingsOpen] = useState(false);
  const [compareTo, setCompareTo] = useState(
    SAMPLE_COACH_PANEL.compareOptions[0]?.name || ""
  );
  const [coachRoster, setCoachRoster] = useState<CoachRosterSailor[]>(
    SAMPLE_COACH_PANEL.squadTeaser.map((s) => ({
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

  const copy = DEMO_ROLE_COPY[role];

  // Access matrix:
  // public — public only, can claim
  // sailor — owner + private; privacy Settings only on sailor demo view
  // parent — parent dashboard; no privacy toggles on demo
  // coach — never privacy; no private weight/equipment unless shared
  const canSeePrivate = role === "sailor" || role === "parent";
  const isOwner = role === "sailor";
  /** Demo: privacy controls only on sailor view */
  const canManagePrivacy = role === "sailor";
  const canClaim = role === "public";

  const flash = (msg: string) => {
    setToast(msg);
    setTimeout(() => setToast(null), 2200);
  };

  const setRoleAndUrl = (r: DemoRole) => {
    if (r !== role) {
      trackClientUsage("demo_role_switch", "/sample", {
        from: role,
        to: r,
      });
    }
    setRole(r);
    setSettingsOpen(false);
    setSelectedCoachSailor(null);
    if (typeof window !== "undefined") {
      const u = new URL(window.location.href);
      u.searchParams.set("view", r);
      window.history.replaceState({}, "", u.toString());
    }
  };

  const rolePanels = useMemo(() => {
    if (role === "public") {
      return null; // claim banner lives inside SailorProfileView
    }

    if (role === "sailor") {
      return null; // tip lives inline near regatta table
    }

    if (role === "parent") {
      const p = SAMPLE_PARENT_PANEL;
      const currentAthlete =
        p.athletes.find((a) => a.id === selectedAthleteId) || p.athletes[0];
      const completedCount = checklistItems.filter((i) => i.checked).length;

      return (
        <div className="mx-auto max-w-5xl px-4 sm:px-6 space-y-6 pb-6 pt-4">
          {/* Header & Multi-Athlete Switcher */}
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-white/10 pb-4">
            <div className="flex items-center gap-3">
              <span className="flex h-10 w-10 items-center justify-center rounded-2xl bg-emerald-500/15 text-emerald-400 border border-emerald-500/30">
                <Heart className="h-5 w-5" />
              </span>
              <div>
                <div className="flex items-center gap-2">
                  <h3 className="text-base font-black text-white tracking-tight">
                    Parent Dashboard Command Center
                  </h3>
                  <span className="rounded-full bg-emerald-500/15 border border-emerald-500/30 px-2 py-0.5 text-[10px] font-black text-emerald-300">
                    Live Demo
                  </span>
                </div>
                <p className="text-xs text-slate-400">
                  {p.claimStatus} · Linked to 2 athletes
                </p>
              </div>
            </div>

            {/* Athlete Switcher Pills */}
            <div className="flex items-center gap-1.5 p-1 rounded-2xl bg-black/40 border border-white/10 self-start sm:self-auto">
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

          {/* ALL ATHLETES VIEW */}
          {selectedAthleteId === "all" ? (
            <div className="space-y-4">
              <div className="rounded-2xl border border-white/10 bg-white/[0.02] p-5">
                <h4 className="text-sm font-bold text-white mb-1">
                  Family Fleet Summary
                </h4>
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
                        <h4 className="text-base font-black text-white">{ath.name}</h4>
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
                    <h4 className="text-xl font-black text-white">
                      {currentAthlete.name}
                    </h4>
                    <span className="rounded-full bg-emerald-500/20 text-emerald-300 border border-emerald-500/30 px-2 py-0.5 text-[10px] font-bold">
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

              {/* 5-Card Bento Grid */}
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
                    {p.equipmentLocker.map((item) => (
                      <div
                        key={item.type}
                        className="rounded-xl bg-black/25 border border-white/5 p-2.5"
                      >
                        <div className="flex items-center justify-between text-[10px]">
                          <span className="font-bold text-slate-400 uppercase">
                            {item.type}
                          </span>
                          <span
                            className={`px-1.5 py-0.2 rounded font-bold uppercase text-[9px] ${
                              item.condition === "good"
                                ? "bg-emerald-500/15 text-emerald-300"
                                : "bg-amber-500/15 text-amber-300"
                            }`}
                          >
                            {item.condition}
                          </span>
                        </div>
                        <p className="text-xs font-bold text-white mt-1 truncate">
                          {item.brand}
                        </p>
                      </div>
                    ))}
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
                      <button
                        key={item.id}
                        type="button"
                        onClick={() => {
                          setChecklistItems((prev) =>
                            prev.map((i) =>
                              i.id === item.id ? { ...i, checked: !i.checked } : i
                            )
                          );
                        }}
                        className={`w-full text-left flex items-start gap-2.5 p-2 rounded-xl transition-colors ${
                          item.checked
                            ? "bg-emerald-500/10 border border-emerald-500/20 text-slate-200"
                            : "bg-black/20 border border-white/5 text-slate-400 hover:bg-white/5"
                        }`}
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
                    ))}
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
                <div className="flex items-center justify-between gap-2">
                  <div>
                    <h4 className="text-xs font-black text-white uppercase tracking-wider">
                      Private Parent Journal
                    </h4>
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
            </div>
          )}
        </div>
      );
    }

    // coach
    const c = SAMPLE_COACH_PANEL;
    return (
      <div className="mx-auto max-w-3xl px-4 sm:px-6 space-y-4 pb-2 pt-4">
        <div className="rounded-2xl border border-blue-500/25 bg-blue-500/[0.06] p-5 sm:p-6 space-y-5">
          <div className="flex items-start justify-between gap-3 flex-wrap">
            <div className="flex items-center gap-2">
              <ClipboardList className="h-5 w-5 text-blue-400" />
              <div>
                <h3 className="text-sm font-black text-white uppercase tracking-wider">
                  Coach view · {c.squadName}
                </h3>
                <p className="text-[11px] text-slate-500">
                  Private coach tools — no privacy controls on this view
                </p>
              </div>
            </div>
            <span
              className={`inline-flex items-center gap-1 rounded-full px-2.5 py-1 text-[11px] font-bold border ${
                c.selectionReadiness.score >= 75
                  ? "bg-emerald-500/15 border-emerald-500/30 text-emerald-300"
                  : "bg-amber-500/15 border-amber-500/30 text-amber-200"
              }`}
            >
              <CheckCircle2 className="h-3.5 w-3.5" />
              Selection {c.selectionReadiness.label} ·{" "}
              {c.selectionReadiness.score}
            </span>
          </div>

          <p className="text-[12px] text-slate-400 leading-relaxed">
            {c.selectionReadiness.detail}
          </p>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div className="rounded-xl border border-white/10 bg-black/20 p-4">
              <p className="text-[10px] font-bold text-slate-500 uppercase mb-2">
                Training attendance (last 4)
              </p>
              <ul className="space-y-1.5">
                {c.attendance.map((a) => (
                  <li
                    key={a.session}
                    className="flex justify-between text-[12px]"
                  >
                    <span className="text-slate-300">{a.session}</span>
                    <span
                      className={
                        a.status === "attended"
                          ? "text-emerald-400 font-semibold"
                          : "text-rose-400 font-semibold"
                      }
                    >
                      {a.status === "attended" ? "Attended" : "Missed"}
                    </span>
                  </li>
                ))}
              </ul>
            </div>
            <div className="rounded-xl border border-white/10 bg-black/20 p-4">
              <p className="text-[10px] font-bold text-slate-500 uppercase mb-2">
                Pathway checklist
              </p>
              <ul className="space-y-1.5">
                {c.pathway.map((item) => (
                  <li
                    key={item.item}
                    className="text-xs text-slate-300 flex items-center gap-2"
                  >
                    <span
                      className={
                        item.done ? "text-emerald-400" : "text-slate-600"
                      }
                    >
                      {item.done ? "☑" : "☐"}
                    </span>
                    {item.item}
                  </li>
                ))}
              </ul>
            </div>
          </div>

          <div className="rounded-xl border border-white/10 bg-black/20 p-4 space-y-2">
            <p className="text-[10px] font-bold text-slate-500 uppercase">
              Compare to squad member
            </p>
            <select
              value={compareTo}
              onChange={(e) => setCompareTo(e.target.value)}
              className="w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-xs text-white"
            >
              {c.compareOptions.map((o) => (
                <option key={o.name} value={o.name}>
                  {o.name} · #{o.rank}
                </option>
              ))}
            </select>
            <p className="text-[11px] text-slate-500">
              Demo: compare Kimberly (#{c.nationalRank}) with {compareTo}
              product charts side-by-side finish trends.
            </p>
          </div>

          <div>
            <p className="text-[10px] font-bold text-slate-500 uppercase mb-2">
              Private coach notes
              <span className="ml-1.5 font-normal normal-case tracking-normal text-slate-600">
                (only you — not sailor or parent)
              </span>
            </p>
            <ul className="space-y-2 max-h-40 overflow-y-auto">
              {coachNotes.map((n, i) => (
                <li
                  key={i}
                  className="rounded-lg bg-black/25 border border-white/5 px-3 py-2"
                >
                  <p className="text-[10px] text-slate-500 font-mono">
                    {n.date}
                  </p>
                  <p className="text-xs text-slate-300 mt-0.5 leading-relaxed">
                    {n.text}
                  </p>
                </li>
              ))}
            </ul>
            <button
              type="button"
              onClick={() => {
                setCoachNotes((prev) => [
                  {
                    date: new Date().toISOString().slice(0, 10),
                    text: "(Demo) New coach note — SailorPath stores notes per athlete with visibility controls.",
                  },
                  ...prev,
                ]);
                flash("Demo coach note added");
              }}
              className="mt-3 rounded-full bg-blue-600/90 px-4 py-2 text-[11px] font-bold text-white"
            >
              + Add coach note
            </button>
          </div>
        </div>

        <div className="rounded-2xl border border-white/10 bg-white/[0.02] p-4 space-y-3">
          <div className="flex items-center justify-between gap-2">
            <div className="flex items-center gap-2">
              <Users className="h-4 w-4 text-orange-400" />
              <h3 className="text-xs font-black text-white uppercase tracking-wider">
                Squad roster
              </h3>
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
              className="inline-flex items-center gap-1 rounded-full bg-blue-600/90 px-3 py-1.5 text-[11px] font-bold text-white"
            >
              <UserPlus className="h-3.5 w-3.5" />
              Add sailor
            </button>
          </div>
          <p className="text-[11px] text-slate-500">
            Tap a sailor for coach detail — no full public profile under this
            dashboard.
          </p>
          <ul className="divide-y divide-white/5">
            {coachRoster.map((s) => {
              const active = selectedCoachSailor?.name === s.name;
              return (
                <li key={s.name}>
                  <button
                    type="button"
                    onClick={() =>
                      setSelectedCoachSailor((cur) =>
                        cur?.name === s.name ? null : s
                      )
                    }
                    className={`w-full py-2.5 flex items-center justify-between gap-3 text-xs text-left rounded-lg px-2 -mx-1 transition-colors ${
                      active
                        ? "bg-blue-500/15 border border-blue-500/25"
                        : "hover:bg-white/5"
                    }`}
                  >
                    <div className="min-w-0">
                      <p className="font-bold text-white">{s.name}</p>
                      <p className="text-[11px] text-slate-500 truncate">
                        {s.highlight}
                        {s.selection ? ` · ${s.selection}` : ""}
                      </p>
                    </div>
                    <span className="flex items-center gap-2 shrink-0">
                      <span className="font-mono font-black text-orange-400">
                        #{s.rank}
                      </span>
                      <ChevronRight
                        className={`h-4 w-4 text-slate-500 transition-transform ${
                          active ? "rotate-90 text-blue-300" : ""
                        }`}
                      />
                    </span>
                  </button>
                  {active && (
                    <div className="mb-3 mt-1 rounded-xl border border-blue-500/20 bg-blue-500/[0.06] px-3 py-3 space-y-2">
                      <p className="text-[11px] font-bold text-blue-200 uppercase tracking-wide">
                        Coach detail · {s.name}
                      </p>
                      <div className="grid grid-cols-2 gap-2 text-[12px]">
                        <div className="rounded-lg bg-black/25 px-2.5 py-2">
                          <p className="text-[10px] text-slate-500 uppercase">
                            Rank
                          </p>
                          <p className="font-bold text-white">#{s.rank}</p>
                        </div>
                        <div className="rounded-lg bg-black/25 px-2.5 py-2">
                          <p className="text-[10px] text-slate-500 uppercase">
                            Avg finish
                          </p>
                          <p className="font-bold text-white">
                            {s.avgFinish || "—"}
                          </p>
                        </div>
                        <div className="rounded-lg bg-black/25 px-2.5 py-2 col-span-2">
                          <p className="text-[10px] text-slate-500 uppercase">
                            Selection
                          </p>
                          <p className="font-bold text-white">
                            {s.selection || "—"}
                          </p>
                        </div>
                      </div>
                      <p className="text-[11px] text-slate-400 leading-relaxed">
                        {s.name === "Kimberly Tan"
                          ? "Strong mid-line starts · light-air height is focus. Coach notes stay private."
                          : "Demo athlete summary — the planned coach view opens a focused athlete detail panel."}
                      </p>
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
                        className="rounded-full border border-blue-500/30 px-3 py-1.5 text-[11px] font-bold text-blue-200"
                      >
                        + Note on {s.name.split(" ")[0]}
                      </button>
                    </div>
                  )}
                </li>
              );
            })}
          </ul>
        </div>
      </div>
    );
  }, [
    role,
    coachNotes,
    parentNotes,
    compareTo,
    coachRoster,
    selectedCoachSailor,
    checklistItems,
    selectedAthleteId,
  ]);

  return (
    <div className="flex-1 flex flex-col">
      {/* Demo chrome: title + view tabs */}
      <div className="sticky top-0 z-40 border-b border-amber-500/30 bg-[#12100a]/95 backdrop-blur-md">
        <div className="mx-auto max-w-3xl px-3 sm:px-4 py-3 space-y-3">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2">
            <div>
              <p className="text-[10px] font-bold uppercase tracking-[0.14em] text-amber-400/90">
                Demo profile
              </p>
              <h1 className="text-base sm:text-lg font-bold text-white tracking-tight">
                Kimberly Tan · SGP 115 · SailorPath Profile
              </h1>
              <p className="text-[11px] text-slate-500 mt-0.5">
                b. {SAMPLE_SAILOR.dob.slice(0, 4)} · dual-class Optimist + ILCA 4 ·
                switch views below
              </p>
            </div>
            {canManagePrivacy && (
              <button
                type="button"
                onClick={() => setSettingsOpen(true)}
                className="rounded-full border border-white/15 px-3 py-2 min-h-[40px] inline-flex items-center gap-1.5 text-[11px] font-bold text-slate-300 hover:bg-white/5 self-start sm:self-center"
                title="Privacy settings"
              >
                <Settings className="h-3.5 w-3.5" />
                Settings
              </button>
            )}
          </div>

          {/* Prominent view tabs */}
          <div
            className="flex gap-1 p-1.5 rounded-2xl bg-black/50 border border-white/15"
            role="tablist"
            aria-label="Profile view"
          >
            {ROLES.map((r) => {
              const active = role === r;
              const Icon =
                r === "public"
                  ? Sparkles
                  : r === "sailor"
                    ? User
                    : r === "parent"
                      ? Heart
                      : ClipboardList;
              return (
                <button
                  key={r}
                  type="button"
                  role="tab"
                  aria-selected={active}
                  onClick={() => setRoleAndUrl(r)}
                  className={`flex-1 inline-flex items-center justify-center gap-1.5 rounded-xl px-2 sm:px-3 py-2.5 min-h-[44px] text-[12px] sm:text-[13px] font-bold transition-all ${
                    active
                      ? "bg-orange-600 text-white shadow-lg shadow-orange-950/40 ring-2 ring-orange-400/40"
                      : "text-slate-400 hover:text-white hover:bg-white/5"
                  }`}
                >
                  <Icon className="h-4 w-4 shrink-0" />
                  <span>{DEMO_ROLE_COPY[r].title}</span>
                </button>
              );
            })}
          </div>
          <p className="text-[11px] text-slate-400 leading-snug px-0.5">
            <span className="font-bold text-white">{copy.who}.</span>{" "}
            {copy.value}
          </p>
        </div>
      </div>

      {toast && (
        <div className="fixed bottom-6 left-1/2 -translate-x-1/2 z-50 rounded-full bg-slate-900 border border-orange-500/40 px-5 py-2.5 text-xs font-bold text-white shadow-xl">
          {toast}
        </div>
      )}

      {/* Settings modal — privacy for sailor / parent only */}
      {settingsOpen && canManagePrivacy && (
        <div
          className="fixed inset-0 z-50 flex items-end sm:items-center justify-center p-0 sm:p-4 bg-black/70"
          role="dialog"
          aria-modal="true"
          aria-label="Privacy settings"
        >
          <div className="w-full sm:max-w-md rounded-t-2xl sm:rounded-2xl border border-white/10 bg-[#12141c] p-5 shadow-2xl">
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center gap-2">
                <Settings className="h-4 w-4 text-orange-400" />
                <h2 className="text-sm font-bold text-white">
                  Privacy settings
                </h2>
              </div>
              <button
                type="button"
                onClick={() => setSettingsOpen(false)}
                className="rounded-lg p-1.5 text-slate-500 hover:text-white"
                aria-label="Close"
              >
                <X className="h-4 w-4" />
              </button>
            </div>
            <PrivacySettingsBody
              onSave={() => {
                flash("Demo privacy saved");
                setSettingsOpen(false);
              }}
            />
          </div>
        </div>
      )}

      {/* Coach: dashboard only (no full profile underneath) */}
      {role === "coach" && rolePanels}

      {/* Parent: dashboard + light profile */}
      {role === "parent" && rolePanels}

      {role === "parent" && (
        <SailorProfileView
          initialSailor={SAMPLE_SAILOR}
          initialResults={SAMPLE_RESULTS}
          initialEquipment={SAMPLE_EQUIPMENT}
          initialSeriesStanding={SAMPLE_SERIES_STANDING}
          initialIlcaStanding={SAMPLE_ILCA_STANDING}
          initialObservations={SAMPLE_OBSERVATIONS}
          canSeePrivate
          canClaim={false}
          isOwner={false}
          isLoggedIn
          demoMode
          demoRole="parent"
          hidePrivacySection
          profileVerified
        />
      )}

      {/* Public + Sailor profile views */}
      {(role === "public" || role === "sailor") && (
        <SailorProfileView
          initialSailor={SAMPLE_SAILOR}
          initialResults={SAMPLE_RESULTS}
          initialEquipment={SAMPLE_EQUIPMENT}
          initialSeriesStanding={SAMPLE_SERIES_STANDING}
          initialIlcaStanding={SAMPLE_ILCA_STANDING}
          initialObservations={
            role === "sailor" ? SAMPLE_OBSERVATIONS : []
          }
          canSeePrivate={canSeePrivate}
          canClaim={canClaim}
          isOwner={isOwner}
          isLoggedIn={role !== "public"}
          demoMode
          demoRole={role}
          hidePrivacySection={role === "sailor"}
          profileVerified={role === "sailor"}
          onDemoClaim={() =>
            flash("Demo: claim would submit after you register & sign in")
          }
        />
      )}
    </div>
  );
}
