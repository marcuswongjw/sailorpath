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
  MessageSquare,
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
} from "lucide-react";

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
  const [equipment, setEquipment] = useState(false);
  const [fullDob, setFullDob] = useState(false);

  return (
    <div className="space-y-4">
      <p className="text-[12px] text-neutral-400 leading-relaxed">
        {childLabel
          ? `Manage ${childLabel}'s privacy. Birth year and age stay public for fleet eligibility.`
          : "Birth year and age stay public for fleet eligibility. Weight and equipment stay private unless shared."}
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
              label: "Share equipment",
              hint: "Show hull / sail / gear publicly",
              checked: equipment,
              set: setEquipment,
            },
            {
              label: "Share full date of birth",
              hint: "Also show day/month (year is always public)",
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
  const [settingsOpen, setSettingsOpen] = useState(false);
  const [compareTo, setCompareTo] = useState(
    SAMPLE_COACH_PANEL.compareOptions[0]?.name || ""
  );
  const [coachRoster, setCoachRoster] = useState<CoachRosterSailor[]>(
    SAMPLE_COACH_PANEL.squadTeaser.map((s) => ({
      ...s,
      avgFinish:
        s.name === "Ashlyn Tan"
          ? "3.6"
          : s.name === "Ethan Koh"
            ? "7.1"
            : "9.4",
      selection:
        s.name === "Ashlyn Tan"
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

  const standing = SAMPLE_SERIES_STANDING;

  const setRoleAndUrl = (r: DemoRole) => {
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
      return (
        <div className="mx-auto max-w-3xl px-4 sm:px-6 space-y-4 pb-2 pt-4">
          <div className="rounded-2xl border border-emerald-500/25 bg-emerald-500/[0.06] p-5 sm:p-6 space-y-5">
            <div className="flex items-center justify-between gap-3 flex-wrap">
              <div className="flex items-center gap-2">
                <Heart className="h-5 w-5 text-emerald-400" />
                <div>
                  <h3 className="text-sm font-black text-white uppercase tracking-wider">
                    Parent dashboard
                  </h3>
                  <p className="text-[11px] text-emerald-300/90 font-semibold">
                    {p.claimStatus}
                  </p>
                </div>
              </div>
            </div>

            {/* Squad info */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div className="rounded-xl border border-white/10 bg-black/20 p-4 space-y-2">
                <p className="text-[10px] font-bold text-slate-500 uppercase flex items-center gap-1.5">
                  <GraduationCap className="h-3.5 w-3.5 text-emerald-400" />
                  Squad
                </p>
                <p className="text-sm font-bold text-white">{p.coachName}</p>
                <p className="text-[11px] text-slate-400">{p.club}</p>
                <ul className="mt-2 space-y-1">
                  {p.trainingSchedule.map((s) => (
                    <li
                      key={s.day}
                      className="text-[11px] text-slate-300 flex gap-2"
                    >
                      <span className="font-bold text-emerald-300/90 w-8 shrink-0">
                        {s.day}
                      </span>
                      <span className="text-slate-500">{s.time}</span>
                      <span className="text-slate-400 truncate">{s.focus}</span>
                    </li>
                  ))}
                </ul>
              </div>
              <div className="rounded-xl border border-white/10 bg-black/20 p-4 space-y-2">
                <p className="text-[10px] font-bold text-slate-500 uppercase flex items-center gap-1.5">
                  <Users className="h-3.5 w-3.5 text-emerald-400" />
                  Squad mates
                </p>
                <ul className="space-y-1.5">
                  {p.squadMates.map((m) => (
                    <li
                      key={m.name}
                      className="flex justify-between gap-2 text-[12px]"
                    >
                      <span className="font-semibold text-white">{m.name}</span>
                      <span className="text-slate-500 truncate">{m.note}</span>
                    </li>
                  ))}
                </ul>
              </div>
            </div>

            {/* Upcoming events */}
            <div>
              <p className="text-[10px] font-bold text-slate-500 uppercase mb-2 flex items-center gap-1.5">
                <Calendar className="h-3.5 w-3.5 text-emerald-400" />
                Upcoming events
              </p>
              <ul className="space-y-2">
                {p.nextEvents.map((e) => (
                  <li
                    key={e.name}
                    className="rounded-xl bg-black/25 border border-white/5 px-3 py-2.5 flex flex-col sm:flex-row sm:items-center justify-between gap-1"
                  >
                    <div>
                      <p className="text-xs font-bold text-white">{e.name}</p>
                      <p className="text-[11px] text-slate-500">
                        {e.date} · {e.venue}
                      </p>
                    </div>
                    <span className="text-[10px] font-semibold text-amber-300/90">
                      {e.deadline}
                    </span>
                  </li>
                ))}
              </ul>
            </div>

            {/* Equipment alerts */}
            <div>
              <p className="text-[10px] font-bold text-slate-500 uppercase mb-2 flex items-center gap-1.5">
                <Wrench className="h-3.5 w-3.5 text-amber-400" />
                Equipment alerts
              </p>
              <ul className="space-y-1.5">
                {p.equipmentAlerts.map((a) => (
                  <li
                    key={a.text}
                    className={`flex gap-2 text-[12px] rounded-lg px-3 py-2 border ${
                      a.level === "warn"
                        ? "border-amber-500/25 bg-amber-500/10 text-amber-100"
                        : "border-white/10 bg-white/[0.03] text-slate-300"
                    }`}
                  >
                    <AlertTriangle className="h-3.5 w-3.5 shrink-0 mt-0.5" />
                    {a.text}
                  </li>
                ))}
              </ul>
            </div>

            {/* Parent notes */}
            <div>
              <p className="text-[10px] font-bold text-slate-500 uppercase mb-2">
                Parent notes
                <span className="ml-1.5 font-normal normal-case tracking-normal text-slate-600">
                  (separate from sailor logbook)
                </span>
              </p>
              <ul className="space-y-2">
                {parentNotes.map((n, i) => (
                  <li
                    key={i}
                    className="rounded-lg bg-black/20 border border-white/5 px-3 py-2"
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
                  setParentNotes((prev) => [
                    {
                      date: new Date().toISOString().slice(0, 10),
                      text: "(Demo) New parent note — e.g. travel logistics for next regatta.",
                    },
                    ...prev,
                  ]);
                  flash("Demo parent note added");
                }}
                className="mt-2 rounded-full border border-emerald-500/30 px-3 py-1.5 text-[11px] font-bold text-emerald-200"
              >
                + Add parent note
              </button>
            </div>

            {/* Communication */}
            <div className="flex flex-wrap gap-2 pt-1">
              <button
                type="button"
                onClick={() =>
                  flash(`Demo: message queued to ${p.coachContact}`)
                }
                className="inline-flex items-center gap-1.5 rounded-full bg-emerald-600 px-4 py-2 text-[11px] font-bold text-white"
              >
                <MessageSquare className="h-3.5 w-3.5" />
                Message coach
              </button>
              <button
                type="button"
                onClick={() => flash("Demo: open club channel")}
                className="rounded-full border border-white/15 px-4 py-2 text-[11px] font-bold text-slate-300"
              >
                Message club
              </button>
              <Link
                href="/sg/optimist/gold"
                className="rounded-full border border-white/15 px-4 py-2 text-[11px] font-bold text-slate-300"
              >
                View live standings
              </Link>
            </div>
          </div>

          <div className="rounded-2xl border border-white/10 bg-white/[0.02] p-4">
            <p className="text-[10px] font-bold text-slate-500 uppercase mb-1">
              Series at a glance
            </p>
            <p className="text-sm text-white font-bold">
              #{standing.overallRank} Gold · Best 3 of 5 = {standing.best3of5}
            </p>
            <p className="text-[11px] text-slate-500 mt-1">{standing.trendNote}</p>
          </div>

          <p className="text-[11px] text-slate-500 px-1">
            Parent tip: use events and equipment alerts above — race logbook
            notes stay in the sailor view.
          </p>
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
              Demo: compare Ashlyn (#{c.nationalRank}) vs {compareTo} — live
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
                    text: "(Demo) New coach note — live app stores notes per athlete with visibility controls.",
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
                        {s.name === "Ashlyn Tan"
                          ? "Strong mid-line starts · light-air height is focus. Coach notes stay private."
                          : "Demo athlete summary — live product opens a coach-only detail drawer without the full public profile chrome."}
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
    standing,
    compareTo,
    coachRoster,
    selectedCoachSailor,
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
                Ashlyn Tan · SGP 115 · SailorPath Profile
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
