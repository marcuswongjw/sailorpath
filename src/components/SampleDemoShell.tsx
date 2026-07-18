"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import { useSearchParams } from "next/navigation";
import { SailorProfileView } from "@/components/SailorProfileView";
import {
  DEMO_ROLE_COPY,
  SAMPLE_COACH_PANEL,
  SAMPLE_EQUIPMENT,
  SAMPLE_PARENT_PANEL,
  SAMPLE_RACE_LOG,
  SAMPLE_RESULTS,
  SAMPLE_SAILOR,
  SAMPLE_SERIES_STANDING,
  type DemoRole,
  type RaceObservation,
} from "@/lib/sampleProfile";
import {
  Users,
  User,
  Heart,
  ClipboardList,
  Trophy,
  MessageSquare,
  BookOpen,
  Sparkles,
} from "lucide-react";

const ROLES: DemoRole[] = ["public", "sailor", "parent", "coach"];

function scoreMark(s: {
  score: number;
  isDNS?: boolean;
  isOverseas?: boolean;
}) {
  if (s.isOverseas) return `${s.score}†`;
  if (s.isDNS) return `${s.score}*`;
  return String(s.score);
}

export function SampleDemoShell() {
  const searchParams = useSearchParams();
  const initial = (searchParams.get("view") || "public").toLowerCase();
  const startRole: DemoRole = ROLES.includes(initial as DemoRole)
    ? (initial as DemoRole)
    : "public";

  const [role, setRole] = useState<DemoRole>(startRole);
  const [toast, setToast] = useState<string | null>(null);
  const [raceNotes, setRaceNotes] = useState<RaceObservation[]>(
    SAMPLE_RACE_LOG.observations
  );
  const [coachNotes, setCoachNotes] = useState(SAMPLE_COACH_PANEL.coachNotes);

  const copy = DEMO_ROLE_COPY[role];
  const canSeePrivate = role !== "public";
  const isOwner = role === "sailor" || role === "parent";

  const flash = (msg: string) => {
    setToast(msg);
    setTimeout(() => setToast(null), 2200);
  };

  const standing = SAMPLE_SERIES_STANDING;

  const rolePanels = useMemo(() => {
    if (role === "public") {
      return (
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 pb-8 -mt-2">
          <div className="glass-panel rounded-2xl border border-white/5 p-5 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
            <div>
              <p className="text-xs font-bold text-slate-400 uppercase tracking-wider">
                Public value
              </p>
              <p className="text-sm text-slate-300 mt-1 max-w-2xl">
                Families and clubs can follow fleet standing, squad history, and
                regatta results without exposing private training data.
              </p>
            </div>
            <div className="flex flex-wrap gap-2">
              <Link
                href="/sg/optimist/gold"
                className="rounded-full bg-orange-600 px-4 py-2 text-[11px] font-bold text-white"
              >
                Open Gold standings
              </Link>
              <Link
                href="/register"
                className="rounded-full border border-white/15 px-4 py-2 text-[11px] font-bold text-white"
              >
                Claim a real profile
              </Link>
            </div>
          </div>
        </div>
      );
    }

    if (role === "sailor") {
      return (
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 space-y-6 pb-10">
          {/* Series standing */}
          <div className="glass-panel rounded-2xl border border-orange-500/20 p-5 md:p-6">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-4">
              <div className="flex items-center gap-2">
                <Trophy className="h-5 w-5 text-orange-500" />
                <div>
                  <h3 className="text-sm font-black text-white uppercase tracking-wider">
                    My series standing
                  </h3>
                  <p className="text-[11px] text-slate-500">
                    {standing.periodLabel} · {standing.fleet} fleet
                  </p>
                </div>
              </div>
              <div className="text-right">
                <p className="text-[10px] font-bold text-slate-500 uppercase">
                  Best 3 of 5
                </p>
                <p className="text-3xl font-black text-white">
                  {standing.best3of5}
                </p>
                <p className="text-sm font-bold text-orange-400">
                  Rank #{standing.overallRank}
                </p>
              </div>
            </div>
            <div className="grid grid-cols-5 gap-2">
              {standing.rScores.map((r) => (
                <div
                  key={r.label}
                  className="rounded-xl bg-white/5 border border-white/5 px-2 py-2 text-center"
                  title={r.regatta}
                >
                  <p className="text-[9px] font-black text-orange-400">
                    {r.label}
                  </p>
                  <p className="text-[9px] text-slate-500 line-clamp-1">
                    {r.regatta}
                  </p>
                  <p className="text-sm font-mono font-bold text-white mt-1">
                    {scoreMark(r)}
                  </p>
                </div>
              ))}
            </div>
            <p className="text-[11px] text-emerald-400/90 mt-3 font-semibold">
              {standing.trendNote}
            </p>
          </div>

          {/* Race log */}
          <div className="glass-panel rounded-2xl border border-white/5 p-5 md:p-6">
            <div className="flex items-center gap-2 mb-1">
              <BookOpen className="h-5 w-5 text-orange-500" />
              <h3 className="text-sm font-black text-white uppercase tracking-wider">
                Race-by-race log
              </h3>
            </div>
            <p className="text-[11px] text-slate-500 mb-4">
              {SAMPLE_RACE_LOG.regattaName} · {SAMPLE_RACE_LOG.raceCount} races
              (demo — your notes stay private until you share them)
            </p>
            <div className="space-y-2 max-h-80 overflow-y-auto">
              {raceNotes.map((o) => (
                <div
                  key={o.raceNumber}
                  className="rounded-xl border border-white/5 bg-white/[0.02] px-3 py-2.5"
                >
                  <div className="flex items-center justify-between gap-2">
                    <span className="text-xs font-black text-orange-400">
                      Race {o.raceNumber}
                    </span>
                    <span className="text-[11px] font-mono text-slate-400">
                      P{o.position ?? "—"} · {o.wind}
                    </span>
                  </div>
                  <p className="text-xs text-slate-300 mt-1 leading-relaxed">
                    {o.note}
                  </p>
                </div>
              ))}
            </div>
            <button
              type="button"
              onClick={() => {
                setRaceNotes((prev) => [
                  ...prev,
                  {
                    raceNumber: prev.length + 1,
                    position: null,
                    wind: "—",
                    note: "(Demo) New observation — in the live app you type your own notes after each race.",
                  },
                ]);
                flash("Demo note added — live app saves to your account");
              }}
              className="mt-4 rounded-full bg-white/5 border border-white/10 px-4 py-2 text-[11px] font-bold text-slate-300 hover:text-white"
            >
              + Add observation (demo)
            </button>
          </div>
        </div>
      );
    }

    if (role === "parent") {
      return (
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 space-y-6 pb-10">
          <div className="glass-panel rounded-2xl border border-emerald-500/20 p-5 md:p-6 space-y-4">
            <div className="flex items-center gap-2">
              <Heart className="h-5 w-5 text-emerald-400" />
              <h3 className="text-sm font-black text-white uppercase tracking-wider">
                Parent dashboard
              </h3>
            </div>
            <p className="text-xs text-emerald-300/90 font-semibold">
              {SAMPLE_PARENT_PANEL.claimStatus}
            </p>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <p className="text-[10px] font-bold text-slate-500 uppercase mb-2">
                  Growth highlights
                </p>
                <ul className="space-y-1.5">
                  {SAMPLE_PARENT_PANEL.highlights.map((h) => (
                    <li
                      key={h}
                      className="text-xs text-slate-300 flex gap-2 leading-relaxed"
                    >
                      <span className="text-emerald-400">✓</span>
                      {h}
                    </li>
                  ))}
                </ul>
              </div>
              <div>
                <p className="text-[10px] font-bold text-slate-500 uppercase mb-2">
                  Upcoming events
                </p>
                <ul className="space-y-2">
                  {SAMPLE_PARENT_PANEL.nextEvents.map((e) => (
                    <li
                      key={e.name}
                      className="rounded-lg bg-white/5 border border-white/5 px-3 py-2"
                    >
                      <p className="text-xs font-bold text-white">{e.name}</p>
                      <p className="text-[11px] text-slate-500">
                        {e.date} · {e.venue}
                      </p>
                    </li>
                  ))}
                </ul>
              </div>
            </div>
            <div className="flex flex-wrap gap-2 pt-2">
              <button
                type="button"
                onClick={() =>
                  flash(`Demo: message queued to ${SAMPLE_PARENT_PANEL.coachContact}`)
                }
                className="inline-flex items-center gap-1.5 rounded-full bg-emerald-600 px-4 py-2 text-[11px] font-bold text-white"
              >
                <MessageSquare className="h-3.5 w-3.5" />
                Message coach (demo)
              </button>
              <Link
                href="/sg/optimist/gold"
                className="rounded-full border border-white/15 px-4 py-2 text-[11px] font-bold text-slate-300"
              >
                View live standings
              </Link>
            </div>
          </div>

          {/* Compact series strip for parent */}
          <div className="glass-card rounded-2xl border border-white/5 p-4">
            <p className="text-[10px] font-bold text-slate-500 uppercase mb-2">
              Series at a glance
            </p>
            <p className="text-sm text-white font-bold">
              #{standing.overallRank} Gold · Best 3 of 5 = {standing.best3of5}
            </p>
            <p className="text-[11px] text-slate-500 mt-1">{standing.trendNote}</p>
          </div>
        </div>
      );
    }

    // coach
    return (
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 space-y-6 pb-10">
        <div className="glass-panel rounded-2xl border border-blue-500/20 p-5 md:p-6 space-y-4">
          <div className="flex items-center gap-2">
            <ClipboardList className="h-5 w-5 text-blue-400" />
            <div>
              <h3 className="text-sm font-black text-white uppercase tracking-wider">
                Coach view · {SAMPLE_COACH_PANEL.squadName}
              </h3>
              <p className="text-[11px] text-slate-500">
                Technical notes + pathway for this athlete
              </p>
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <p className="text-[10px] font-bold text-slate-500 uppercase mb-2">
                Pathway checklist
              </p>
              <ul className="space-y-1.5">
                {SAMPLE_COACH_PANEL.pathway.map((p) => (
                  <li
                    key={p.item}
                    className="text-xs text-slate-300 flex items-center gap-2"
                  >
                    <span
                      className={
                        p.done ? "text-emerald-400" : "text-slate-600"
                      }
                    >
                      {p.done ? "☑" : "☐"}
                    </span>
                    {p.item}
                  </li>
                ))}
              </ul>
            </div>
            <div>
              <p className="text-[10px] font-bold text-slate-500 uppercase mb-2">
                Coach notes
              </p>
              <ul className="space-y-2 max-h-40 overflow-y-auto">
                {coachNotes.map((n, i) => (
                  <li
                    key={i}
                    className="rounded-lg bg-white/5 border border-white/5 px-3 py-2"
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
                      text: "(Demo) New coach note — live app stores notes per athlete with parent visibility controls.",
                    },
                    ...prev,
                  ]);
                  flash("Demo coach note added");
                }}
                className="mt-3 rounded-full bg-blue-600/90 px-4 py-2 text-[11px] font-bold text-white"
              >
                + Add coach note (demo)
              </button>
            </div>
          </div>
        </div>

        <div className="glass-panel rounded-2xl border border-white/5 p-5">
          <div className="flex items-center gap-2 mb-3">
            <Users className="h-4 w-4 text-orange-400" />
            <h3 className="text-xs font-black text-white uppercase tracking-wider">
              Squad roster (demo)
            </h3>
          </div>
          <ul className="divide-y divide-white/5">
            {SAMPLE_COACH_PANEL.squadTeaser.map((s) => (
              <li
                key={s.name}
                className="py-2.5 flex items-center justify-between gap-3 text-xs"
              >
                <div>
                  <p className="font-bold text-white">{s.name}</p>
                  <p className="text-[11px] text-slate-500">{s.highlight}</p>
                </div>
                <span className="font-mono font-black text-orange-400">
                  #{s.rank}
                </span>
              </li>
            ))}
          </ul>
          <p className="text-[11px] text-slate-600 mt-3">
            Live product: real squad rosters, compare athletes, export standings.
          </p>
        </div>
      </div>
    );
  }, [role, raceNotes, coachNotes, standing]);

  return (
    <div className="flex-1 flex flex-col">
      {/* Demo banner + role switcher */}
      <div className="sticky top-0 z-40 border-b border-amber-500/30 bg-[#12100a]/95 backdrop-blur-md">
        <div className="mx-auto max-w-7xl px-4 py-3 space-y-3">
          <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-2">
            <p className="text-xs font-semibold text-amber-100/95">
              <span className="font-black text-amber-300">DEMO PROFILE</span>
              {" — "}
              Fictional data to show Public · Sailor · Parent · Coach experiences.
              Not live database records.
            </p>
            <div className="flex flex-wrap gap-2">
              <Link
                href="/register"
                className="rounded-full bg-orange-600 px-3 py-1.5 text-[11px] font-bold text-white hover:bg-orange-500"
              >
                Claim your profile
              </Link>
              <Link
                href="/sg/optimist/gold"
                className="rounded-full border border-white/15 px-3 py-1.5 text-[11px] font-bold text-slate-300"
              >
                Live standings
              </Link>
            </div>
          </div>

          <div className="flex flex-col sm:flex-row sm:items-center gap-3">
            <div className="flex flex-wrap gap-1 p-1 rounded-full bg-black/40 border border-white/10">
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
                    onClick={() => {
                      setRole(r);
                      if (typeof window !== "undefined") {
                        const u = new URL(window.location.href);
                        u.searchParams.set("view", r);
                        window.history.replaceState({}, "", u.toString());
                      }
                    }}
                    className={`inline-flex items-center gap-1.5 rounded-full px-3.5 py-1.5 text-[11px] font-bold transition-all ${
                      active
                        ? "bg-orange-600 text-white shadow-lg shadow-orange-950/30"
                        : "text-slate-400 hover:text-white"
                    }`}
                  >
                    <Icon className="h-3.5 w-3.5" />
                    {DEMO_ROLE_COPY[r].title}
                  </button>
                );
              })}
            </div>
            <div className="flex-1 min-w-0">
              <p className="text-[11px] text-slate-400">
                <span className="font-bold text-white">{copy.who}.</span>{" "}
                {copy.value}
              </p>
            </div>
          </div>
        </div>
      </div>

      {toast && (
        <div className="fixed bottom-6 left-1/2 -translate-x-1/2 z-50 rounded-full bg-slate-900 border border-orange-500/40 px-5 py-2.5 text-xs font-bold text-white shadow-xl">
          {toast}
        </div>
      )}

      {/* Role-specific panels above profile for parent/coach context first */}
      {(role === "parent" || role === "coach") && rolePanels}

      <SailorProfileView
        initialSailor={SAMPLE_SAILOR}
        initialResults={SAMPLE_RESULTS}
        initialEquipment={SAMPLE_EQUIPMENT}
        canSeePrivate={canSeePrivate}
        canClaim={role === "public"}
        isOwner={isOwner}
        demoMode
        demoRole={role}
        onDemoClaim={() => flash("Demo: claim would submit after you register & sign in")}
      />

      {/* Sailor + public panels below profile */}
      {(role === "sailor" || role === "public") && rolePanels}
    </div>
  );
}
