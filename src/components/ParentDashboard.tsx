"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import {
  Heart,
  Trophy,
  User,
  Search,
  ChevronRight,
  Clock,
  Sailboat,
  AlertTriangle,
  StickyNote,
  Plus,
  Trash2,
  Calendar,
  CheckSquare,
  Square,
  RotateCcw,
  ShieldCheck,
  CheckCircle2,
  Lock,
  ExternalLink,
  Award,
  Users,
  Compass,
} from "lucide-react";
import { relationLabel, type ClaimRelation } from "@/lib/claimRelation";
import { birthYear } from "@/lib/age";
import { useFeedback } from "@/components/ui/FeedbackProvider";

type Standing = {
  periodLabel: string;
  fleet: string;
  overallRank: number;
  fleetSize: number;
  best3of5: number;
  trendNote: string;
};

type SelectionTrials = {
  rank: number;
  nettScore: number;
  eventsSailed: number;
  isQualifiedAsian: boolean;
  isQualifiedPerth: boolean;
  asianTeamRank?: number;
  gapToCutoff?: number;
};

type RecentResult = {
  regattaName: string;
  regattaDate: string;
  rank: number;
  boatClass: string | null;
};

type PrimaryGearItem = {
  id: string;
  category: string;
  brand: string | null;
  model: string | null;
  label: string | null;
  condition: string;
  status: string;
  isPrimary: boolean;
};

type CoachFeedbackItem = {
  id: string;
  type: string;
  category: string | null;
  title: string;
  detail: string | null;
  recordDate: string;
  status: string;
};

type Note = {
  id: string;
  body: string;
  createdAt: string;
};

type Athlete = {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  sailNumberIlca4?: string | null;
  club: string;
  school?: string | null;
  gender?: string | null;
  nationality?: string | null;
  avatarUrl?: string | null;
  currentFleet?: string | null;
  ownerRelation?: ClaimRelation | null;
  nationalSquadStatus?: string | null;
  dob?: string | null;
  standing: Standing | null;
  selectionTrials?: SelectionTrials | null;
  recentResults?: RecentResult[];
  primaryGear?: PrimaryGearItem[];
  equipmentAlertCount?: number;
  equipmentAlerts?: { label: string; reason: string }[];
  coachFeedback?: CoachFeedbackItem[];
  notes?: Note[];
};

type UpcomingRegatta = {
  id: string;
  name: string;
  date: string;
  boatClass: string | null;
  division: string | null;
  slug: string | null;
};

type PendingClaim = {
  id: string;
  status: string;
  relation: ClaimRelation | null;
  sailorName: string;
  sailorHandle: string;
  createdAt: string;
};

const NOTE_CATEGORIES = [
  "General",
  "Training",
  "Regatta Debrief",
  "Logistics",
  "Gear",
] as const;
type NoteCategory = (typeof NOTE_CATEGORIES)[number];

const RACE_CHECKLIST_ITEMS = [
  {
    id: "measurement_cert",
    label: "Official class measurement certificate verified & onboard",
  },
  {
    id: "weigh_in",
    label: "Sailor weigh-in completed (within fleet target weight range)",
  },
  {
    id: "safety_gear",
    label: "Safety tow rope (min 8m floating line) & 2 hand bailers secured",
  },
  {
    id: "protest_flag",
    label: "Red protest flag packed in PFD / boat",
  },
  {
    id: "spares_rigging",
    label: "Spare battens, sail ties (2.5mm / 3.0mm) & wind indicator checked",
  },
] as const;

function formatAgeCategory(dob?: string | null) {
  const by = birthYear(dob);
  if (!by) return null;
  const currentYear = new Date().getFullYear();
  const age = currentYear - by;
  return `${by} · U${age + 1} (${age} yrs)`;
}

function parseNoteCategory(body: string): { category: string | null; text: string } {
  const match = body.match(/^\[(.*?)\]\s*(.*)$/);
  if (match) {
    return { category: match[1], text: match[2] };
  }
  return { category: null, text: body };
}

export function ParentDashboard() {
  const router = useRouter();
  const { toast, confirm } = useFeedback();
  const [athletes, setAthletes] = useState<Athlete[]>([]);
  const [upcomingRegattas, setUpcomingRegattas] = useState<UpcomingRegatta[]>([]);
  const [pendingClaims, setPendingClaims] = useState<PendingClaim[]>([]);
  const [isParentStyle, setIsParentStyle] = useState(true);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Selected athlete: 'all' or athlete ID
  const [selectedAthleteId, setSelectedAthleteId] = useState<string | "all">("all");
  const initialSelectionDone = useRef(false);

  // Private note draft state
  const [selectedCategory, setSelectedCategory] = useState<NoteCategory>("General");
  const [noteDraft, setNoteDraft] = useState<Record<string, string>>({});
  const [noteBusy, setNoteBusy] = useState<string | null>(null);

  // Pre-race checklist state persisted per athlete (lazy initialized from localStorage)
  const [checklistState, setChecklistState] = useState<Record<string, Record<string, boolean>>>(() => {
    if (typeof window === "undefined") return {};
    try {
      const raw = localStorage.getItem("sailorpath_race_checklist");
      return raw ? JSON.parse(raw) : {};
    } catch {
      return {};
    }
  });

  const load = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch("/api/account/family", {
        credentials: "include",
      });
      if (res.status === 401) {
        router.replace(`/login?next=${encodeURIComponent("/parent")}`);
        return;
      }
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Could not load dashboard");
      const athleteList: Athlete[] = data.athletes || [];
      setAthletes(athleteList);
      setUpcomingRegattas(data.upcomingRegattas || []);
      setPendingClaims(data.pendingClaims || []);
      setIsParentStyle(Boolean(data.isParentStyle));

      // Select first athlete on initial load if available
      if (!initialSelectionDone.current) {
        initialSelectionDone.current = true;
        if (athleteList.length > 0) {
          setSelectedAthleteId(athleteList[0].id);
        }
      } else {
        setSelectedAthleteId((prev) => {
          if (prev !== "all" && !athleteList.some((a) => a.id === prev)) {
            return athleteList[0]?.id || "all";
          }
          return prev;
        });
      }
    } catch (e) {
      setError(e instanceof Error ? e.message : "Error");
    } finally {
      setLoading(false);
    }
  }, [router]);

  useEffect(() => {
    // eslint-disable-next-line react-hooks/set-state-in-effect
    void load();
  }, [load]);

  const toggleChecklistItem = (athleteId: string, itemId: string) => {
    setChecklistState((prev) => {
      const athleteState = prev[athleteId] || {};
      const updated = {
        ...prev,
        [athleteId]: {
          ...athleteState,
          [itemId]: !athleteState[itemId],
        },
      };
      try {
        localStorage.setItem("sailorpath_race_checklist", JSON.stringify(updated));
      } catch {
        // storage quota
      }
      return updated;
    });
  };

  const resetChecklist = (athleteId: string) => {
    setChecklistState((prev) => {
      const updated = { ...prev, [athleteId]: {} };
      try {
        localStorage.setItem("sailorpath_race_checklist", JSON.stringify(updated));
      } catch {
        // ignore
      }
      return updated;
    });
    toast.info("Checklist reset for next regatta.");
  };

  const addNote = async (sailorId: string) => {
    const rawBody = (noteDraft[sailorId] || "").trim();
    if (rawBody.length < 2) return;
    const body = selectedCategory !== "General" ? `[${selectedCategory}] ${rawBody}` : rawBody;

    setNoteBusy(sailorId);
    try {
      const res = await fetch("/api/account/parent-notes", {
        method: "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ sailorId, body }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Could not save note");
      setNoteDraft((d) => ({ ...d, [sailorId]: "" }));
      await load();
      toast.success("Private note added");
    } catch (e) {
      toast.error(e instanceof Error ? e.message : "Error");
    } finally {
      setNoteBusy(null);
    }
  };

  const deleteNote = async (id: string) => {
    const ok = await confirm({
      title: "Delete this private note?",
      tone: "danger",
      confirmLabel: "Delete",
    });
    if (!ok) return;
    setNoteBusy(id);
    try {
      const res = await fetch(
        `/api/account/parent-notes?id=${encodeURIComponent(id)}`,
        { method: "DELETE", credentials: "include" }
      );
      if (!res.ok) {
        const data = await res.json();
        throw new Error(data.error || "Delete failed");
      }
      await load();
      toast.success("Note deleted");
    } catch (e) {
      toast.error(e instanceof Error ? e.message : "Error");
    } finally {
      setNoteBusy(null);
    }
  };

  if (loading) {
    return (
      <div className="flex-1 flex items-center justify-center py-24 text-sm text-slate-500">
        Loading dashboard…
      </div>
    );
  }

  const activeAthlete =
    selectedAthleteId === "all"
      ? null
      : athletes.find((a) => a.id === selectedAthleteId) || null;

  const title = isParentStyle ? "Parent Dashboard" : "Sailor Dashboard";
  const subtitle = isParentStyle
    ? "Manage linked athletes, selection standing, boat locker, coach logs, and race preparation."
    : "Your series ranking, selection trials, boat locker, and private notes.";

  return (
    <div className="mx-auto max-w-6xl w-full px-4 py-8 sm:py-12 space-y-6 sm:space-y-8">
      {/* Header section */}
      <div className="flex items-start justify-between gap-4 flex-wrap">
        <div className="flex items-start gap-3 min-w-0">
          <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-2xl bg-gradient-to-br from-emerald-500/20 to-teal-500/10 border border-emerald-500/30 text-emerald-400 shadow-sm">
            <Heart className="h-6 w-6" />
          </span>
          <div className="min-w-0">
            <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
              {title}
            </h1>
            <p className="mt-1 text-sm text-slate-400 leading-relaxed max-w-2xl">
              {subtitle}
            </p>
          </div>
        </div>
        <div className="flex items-center gap-2">
          <Link
            href="/search"
            className="rounded-full border border-white/10 bg-white/5 hover:bg-white/10 px-4 py-2 text-xs font-bold text-white hover:border-orange-500/40 inline-flex items-center gap-1.5 transition-colors"
          >
            <Search className="h-3.5 w-3.5" />
            Find a sailor
          </Link>
          <Link
            href="/account"
            className="rounded-full border border-white/10 bg-white/5 hover:bg-white/10 px-4 py-2 text-xs font-bold text-slate-300 hover:text-white transition-colors"
          >
            Settings
          </Link>
        </div>
      </div>

      {error && (
        <p className="text-sm font-bold text-rose-400 rounded-xl border border-rose-500/25 bg-rose-500/10 px-4 py-3">
          {error}
        </p>
      )}

      {/* Pending claims section */}
      {pendingClaims.length > 0 && (
        <section className="rounded-2xl border border-amber-500/25 bg-amber-500/[0.06] p-5 space-y-3">
          <h2 className="text-xs font-black text-amber-200 uppercase tracking-wider flex items-center gap-2">
            <Clock className="h-4 w-4" />
            Claims awaiting approval ({pendingClaims.length})
          </h2>
          <ul className="grid grid-cols-1 sm:grid-cols-2 gap-2">
            {pendingClaims.map((c) => (
              <li
                key={c.id}
                className="rounded-xl border border-white/5 bg-black/20 px-3.5 py-3 flex items-center justify-between gap-2"
              >
                <div>
                  <Link
                    href={`/${c.sailorHandle}`}
                    className="text-sm font-bold text-white hover:text-orange-400"
                  >
                    {c.sailorName}
                  </Link>
                  <p className="text-[11px] text-slate-400">
                    {relationLabel(c.relation)} · submitted{" "}
                    {c.createdAt ? new Date(c.createdAt).toLocaleDateString() : "—"}
                  </p>
                </div>
                <span className="text-[10px] font-black uppercase text-amber-300 px-2 py-0.5 rounded-full border border-amber-500/30 bg-amber-500/10">
                  Pending
                </span>
              </li>
            ))}
          </ul>
        </section>
      )}

      {/* Empty state when no linked athletes */}
      {athletes.length === 0 ? (
        <div className="rounded-2xl border border-white/5 bg-[#131520]/80 p-8 sm:p-12 text-center space-y-4">
          <Sailboat className="h-10 w-10 text-slate-600 mx-auto" />
          <h2 className="text-lg font-bold text-white">No linked sailor profiles yet</h2>
          <p className="text-sm text-slate-400 max-w-md mx-auto leading-relaxed">
            Search for your child (or yourself), open their profile, and submit a claim as{" "}
            <strong className="text-slate-200">Parent</strong> or{" "}
            <strong className="text-slate-200">Sailor</strong>. Once verified, their command center will appear here.
          </p>
          <div className="flex flex-col sm:flex-row gap-2 justify-center pt-2">
            <Link
              href="/search"
              className="rounded-full bg-orange-600 hover:bg-orange-500 px-5 py-2.5 text-xs font-bold text-white"
            >
              Search sailors
            </Link>
            <Link
              href="/claim-profile"
              className="rounded-full border border-white/10 bg-white/5 hover:bg-white/10 px-5 py-2.5 text-xs font-bold text-white"
            >
              How claiming works
            </Link>
          </div>
        </div>
      ) : (
        <>
          {/* Multi-Athlete Switcher Navigation */}
          {athletes.length > 1 && (
            <div className="flex items-center gap-2 overflow-x-auto pb-1 border-b border-white/10">
              <button
                type="button"
                data-testid="tab-all-summary"
                onClick={() => setSelectedAthleteId("all")}
                className={`flex items-center gap-2 px-4 py-2 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
                  selectedAthleteId === "all"
                    ? "bg-orange-600 text-white shadow-sm"
                    : "bg-white/5 text-slate-400 hover:bg-white/10 hover:text-white"
                }`}
              >
                <Users className="h-3.5 w-3.5" />
                All Athletes Summary ({athletes.length})
              </button>

              {athletes.map((a) => {
                const isSelected = selectedAthleteId === a.id;
                return (
                  <button
                    key={a.id}
                    type="button"
                    onClick={() => setSelectedAthleteId(a.id)}
                    className={`flex items-center gap-2 px-4 py-2 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
                      isSelected
                        ? "bg-white/15 text-white border border-white/20 shadow-sm"
                        : "bg-white/5 text-slate-400 hover:bg-white/10 hover:text-white"
                    }`}
                  >
                    {a.avatarUrl ? (
                      // eslint-disable-next-line @next/next/no-img-element
                      <img
                        src={a.avatarUrl}
                        alt=""
                        className="h-4 w-4 rounded-full object-cover"
                      />
                    ) : (
                      <User className="h-3.5 w-3.5 text-slate-400" />
                    )}
                    <span>{a.name}</span>
                    {a.standing?.fleet && (
                      <span
                        className={`text-[10px] px-1.5 py-0.2 rounded font-black ${
                          a.standing.fleet === "Gold"
                            ? "bg-amber-500/20 text-amber-300"
                            : "bg-sky-500/20 text-sky-300"
                        }`}
                      >
                        {a.standing.fleet} #{a.standing.overallRank}
                      </span>
                    )}
                    {(a.equipmentAlertCount ?? 0) > 0 && (
                      <span className="h-2 w-2 rounded-full bg-rose-500 animate-pulse" />
                    )}
                  </button>
                );
              })}
            </div>
          )}

          {/* VIEW MODE 1: ALL ATHLETES SUMMARY */}
          {selectedAthleteId === "all" && athletes.length > 1 && (
            <div className="space-y-6">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {athletes.map((a) => (
                  <div
                    key={a.id}
                    className="rounded-2xl border border-white/10 bg-[#131520]/90 p-5 space-y-4 hover:border-white/20 transition-all shadow-sm"
                  >
                    <div className="flex items-start justify-between gap-3">
                      <div className="flex items-center gap-3">
                        {a.avatarUrl ? (
                          // eslint-disable-next-line @next/next/no-img-element
                          <img
                            src={a.avatarUrl}
                            alt=""
                            className="h-12 w-12 rounded-2xl object-cover border border-white/10 shrink-0"
                          />
                        ) : (
                          <span className="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-orange-500/15 border border-orange-500/20 text-orange-400">
                            <User className="h-6 w-6" />
                          </span>
                        )}
                        <div>
                          <div className="flex items-center gap-2">
                            <h3 className="text-base font-black text-white">{a.name}</h3>
                            {a.ownerRelation && (
                              <span className="rounded-full border border-emerald-500/25 bg-emerald-500/10 px-2 py-0.5 text-[10px] font-bold text-emerald-300">
                                {relationLabel(a.ownerRelation)}
                              </span>
                            )}
                          </div>
                          <p className="text-xs text-slate-400 mt-0.5">
                            {[a.club, a.sailNumber, formatAgeCategory(a.dob)]
                              .filter(Boolean)
                              .join(" · ")}
                          </p>
                        </div>
                      </div>
                      <button
                        type="button"
                        onClick={() => setSelectedAthleteId(a.id)}
                        className="rounded-full bg-orange-600/90 hover:bg-orange-500 px-3 py-1.5 text-[11px] font-bold text-white inline-flex items-center gap-1 transition-colors"
                      >
                        Open Dashboard
                        <ChevronRight className="h-3 w-3" />
                      </button>
                    </div>

                    <div className="grid grid-cols-2 sm:grid-cols-3 gap-2.5 pt-1">
                      <div className="rounded-xl border border-white/5 bg-black/25 p-2.5">
                        <p className="text-[10px] font-bold text-slate-500 uppercase">
                          Series Rank
                        </p>
                        <p className="text-sm font-black text-white mt-0.5">
                          {a.standing ? (
                            <>
                              #{a.standing.overallRank}{" "}
                              <span className="text-[11px] font-normal text-slate-400">
                                ({a.standing.fleet})
                              </span>
                            </>
                          ) : (
                            <span className="text-slate-500 text-xs font-normal">—</span>
                          )}
                        </p>
                      </div>

                      <div className="rounded-xl border border-white/5 bg-black/25 p-2.5">
                        <p className="text-[10px] font-bold text-slate-500 uppercase">
                          Selection Trials
                        </p>
                        <p className="text-sm font-black text-white mt-0.5">
                          {a.selectionTrials ? (
                            <>
                              #{a.selectionTrials.rank}{" "}
                              <span className="text-[11px] font-normal text-emerald-400">
                                ({a.selectionTrials.nettScore} pts)
                              </span>
                            </>
                          ) : (
                            <span className="text-slate-500 text-xs font-normal">N/A</span>
                          )}
                        </p>
                      </div>

                      <div className="rounded-xl border border-white/5 bg-black/25 p-2.5 col-span-2 sm:col-span-1">
                        <p className="text-[10px] font-bold text-slate-500 uppercase">
                          Locker Alerts
                        </p>
                        <p className="text-sm font-black mt-0.5">
                          {(a.equipmentAlertCount ?? 0) > 0 ? (
                            <span className="text-rose-400 font-bold">
                              {a.equipmentAlertCount} alert
                              {a.equipmentAlertCount === 1 ? "" : "s"}
                            </span>
                          ) : (
                            <span className="text-emerald-400 font-semibold text-xs flex items-center gap-1">
                              <CheckCircle2 className="h-3 w-3" /> All good
                            </span>
                          )}
                        </p>
                      </div>
                    </div>

                    {/* Latest coach log or private note snippet */}
                    {a.coachFeedback && a.coachFeedback.length > 0 && (
                      <div className="rounded-xl border border-sky-500/20 bg-sky-500/[0.05] p-2.5 text-xs text-sky-200/90 flex items-start gap-2">
                        <Award className="h-4 w-4 text-sky-400 shrink-0 mt-0.5" />
                        <div className="min-w-0 flex-1">
                          <p className="font-bold text-[11px] text-sky-300 truncate">
                            Latest Coach Feedback: {a.coachFeedback[0].title}
                          </p>
                          <p className="text-slate-300 text-[11px] line-clamp-1 mt-0.5">
                            {a.coachFeedback[0].detail}
                          </p>
                        </div>
                      </div>
                    )}
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* VIEW MODE 2: ACTIVE ATHLETE DEEP COMMAND CENTER */}
          {activeAthlete && (
            <div className="space-y-6 sm:space-y-8">
              {/* HERO ATHLETE CARD */}
              <div className="rounded-3xl border border-white/10 bg-gradient-to-br from-[#181a29] to-[#10121d] p-5 sm:p-7 shadow-xl space-y-5">
                <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                  <div className="flex items-start gap-4">
                    {activeAthlete.avatarUrl ? (
                      // eslint-disable-next-line @next/next/no-img-element
                      <img
                        src={activeAthlete.avatarUrl}
                        alt=""
                        className="h-16 w-16 sm:h-20 sm:w-20 rounded-2xl object-cover border-2 border-white/15 shrink-0 shadow-md"
                      />
                    ) : (
                      <span className="flex h-16 w-16 sm:h-20 sm:w-20 shrink-0 items-center justify-center rounded-2xl bg-orange-500/15 border-2 border-orange-500/25 text-orange-400 shadow-md">
                        <User className="h-8 w-8" />
                      </span>
                    )}
                    <div className="min-w-0">
                      <div className="flex flex-wrap items-center gap-2">
                        <h2 className="text-xl sm:text-2xl font-black text-white tracking-tight">
                          {activeAthlete.name}
                        </h2>
                        {activeAthlete.ownerRelation && (
                          <span className="rounded-full border border-emerald-500/30 bg-emerald-500/15 px-2.5 py-0.5 text-[10px] font-black uppercase tracking-wider text-emerald-300">
                            {relationLabel(activeAthlete.ownerRelation)}
                          </span>
                        )}
                        {activeAthlete.nationalSquadStatus && (
                          <span className="rounded-full border border-amber-500/30 bg-amber-500/15 px-2.5 py-0.5 text-[10px] font-black uppercase tracking-wider text-amber-300">
                            {activeAthlete.nationalSquadStatus}
                          </span>
                        )}
                      </div>

                      {/* Club, school, and birth year / age category */}
                      <p className="text-xs sm:text-sm text-slate-300 mt-1 flex flex-wrap items-center gap-x-2 gap-y-1">
                        <span className="font-semibold text-white">{activeAthlete.club}</span>
                        {activeAthlete.school && (
                          <>
                            <span className="text-slate-600">·</span>
                            <span>{activeAthlete.school}</span>
                          </>
                        )}
                        {activeAthlete.dob && (
                          <>
                            <span className="text-slate-600">·</span>
                            <span className="text-slate-400 font-mono text-xs">
                              {formatAgeCategory(activeAthlete.dob)}
                            </span>
                          </>
                        )}
                      </p>

                      {/* Dual Sail numbers */}
                      <div className="flex flex-wrap items-center gap-2 mt-2.5">
                        <span className="rounded-lg border border-sky-500/30 bg-sky-500/10 px-2.5 py-1 text-xs font-mono font-bold text-sky-200 inline-flex items-center gap-1.5">
                          <Sailboat className="h-3.5 w-3.5 text-sky-400" />
                          Opti {activeAthlete.sailNumber}
                        </span>

                        {activeAthlete.sailNumberIlca4 && (
                          <span className="rounded-lg border border-purple-500/30 bg-purple-500/10 px-2.5 py-1 text-xs font-mono font-bold text-purple-200 inline-flex items-center gap-1.5">
                            <Compass className="h-3.5 w-3.5 text-purple-400" />
                            ILCA 4 {activeAthlete.sailNumberIlca4}
                          </span>
                        )}

                        {activeAthlete.standing?.fleet && (
                          <span
                            className={`rounded-lg border px-2.5 py-1 text-xs font-black uppercase tracking-wider ${
                              activeAthlete.standing.fleet === "Gold"
                                ? "border-amber-500/30 bg-amber-500/15 text-amber-200"
                                : "border-slate-600 bg-slate-800/60 text-slate-300"
                            }`}
                          >
                            {activeAthlete.standing.fleet} Fleet
                          </span>
                        )}
                      </div>
                    </div>
                  </div>

                  {/* Right quick actions */}
                  <div className="flex flex-wrap sm:flex-col gap-2 shrink-0">
                    <Link
                      href={`/${activeAthlete.handle}`}
                      className="rounded-xl bg-orange-600 hover:bg-orange-500 px-4 py-2 text-xs font-bold text-white inline-flex items-center justify-center gap-1.5 shadow-sm transition-all"
                    >
                      Public Profile
                      <ExternalLink className="h-3.5 w-3.5" />
                    </Link>
                    {activeAthlete.standing?.fleet === "Gold" && (
                      <Link
                        href="/sg/optimist/gold"
                        className="rounded-xl border border-white/10 bg-white/5 hover:bg-white/10 px-4 py-2 text-xs font-bold text-slate-300 hover:text-white inline-flex items-center justify-center gap-1.5 transition-colors"
                      >
                        <Trophy className="h-3.5 w-3.5 text-amber-400" />
                        Gold Leaderboard
                      </Link>
                    )}
                    {activeAthlete.standing?.fleet === "Silver" && (
                      <Link
                        href="/sg/optimist/silver"
                        className="rounded-xl border border-white/10 bg-white/5 hover:bg-white/10 px-4 py-2 text-xs font-bold text-slate-300 hover:text-white inline-flex items-center justify-center gap-1.5 transition-colors"
                      >
                        <Trophy className="h-3.5 w-3.5 text-sky-400" />
                        Silver Leaderboard
                      </Link>
                    )}
                  </div>
                </div>
              </div>

              {/* BENTO GRID OF 5 CORE WORKSPACE PANELS */}
              <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                {/* COLUMN 1 & 2: LEFT TWO COLUMNS ON DESKTOP */}
                <div className="lg:col-span-2 space-y-6">
                  {/* CARD A: 2026 SELECTION TRIALS & SERIES STANDING */}
                  <div className="rounded-2xl border border-white/10 bg-[#131520]/90 p-5 sm:p-6 space-y-4 shadow-sm">
                    <div className="flex items-start justify-between gap-3">
                      <div>
                        <h3 className="text-sm font-black uppercase tracking-wider text-orange-400 flex items-center gap-2">
                          <Trophy className="h-4 w-4 text-orange-400" />
                          2026 Selection Trials & Standings
                        </h3>
                        <p className="text-xs text-slate-400 mt-0.5">
                          Official tracker for the Asian Games and Perth Training Camp squad selection.
                        </p>
                      </div>
                      {activeAthlete.selectionTrials && (
                        <Link
                          href="/sg/optimist/selection"
                          className="text-[11px] font-bold text-orange-400 hover:text-orange-300 hover:underline flex items-center gap-1 shrink-0"
                        >
                          View Trials Board →
                        </Link>
                      )}
                    </div>

                    {/* Selection Trials Metric Highlight */}
                    {activeAthlete.selectionTrials ? (
                      <div className="rounded-xl border border-orange-500/25 bg-gradient-to-r from-orange-500/[0.08] to-amber-500/[0.04] p-4 space-y-3">
                        <div className="grid grid-cols-3 gap-2 text-center sm:text-left">
                          <div>
                            <p className="text-[10px] font-black uppercase tracking-wider text-slate-400">
                              Trials Rank
                            </p>
                            <p className="text-2xl font-black text-white tabular-nums mt-0.5">
                              #{activeAthlete.selectionTrials.rank}
                            </p>
                          </div>
                          <div>
                            <p className="text-[10px] font-black uppercase tracking-wider text-slate-400">
                              Nett Score
                            </p>
                            <p className="text-2xl font-black text-orange-300 tabular-nums mt-0.5">
                              {activeAthlete.selectionTrials.nettScore}
                              <span className="text-xs font-normal text-slate-400 ml-1">pts</span>
                            </p>
                          </div>
                          <div>
                            <p className="text-[10px] font-black uppercase tracking-wider text-slate-400">
                              Events Sailed
                            </p>
                            <p className="text-2xl font-black text-white tabular-nums mt-0.5">
                              {activeAthlete.selectionTrials.eventsSailed} / 2
                            </p>
                          </div>
                        </div>

                        {/* Status badge pill */}
                        <div className="pt-1 flex flex-wrap items-center gap-2">
                          {activeAthlete.selectionTrials.isQualifiedAsian ? (
                            <span className="rounded-full border border-emerald-500/40 bg-emerald-500/15 px-3 py-1 text-xs font-bold text-emerald-300 inline-flex items-center gap-1.5">
                              <ShieldCheck className="h-3.5 w-3.5" />
                              Asian Games Team Candidate (Rank #{activeAthlete.selectionTrials.asianTeamRank} of 5)
                            </span>
                          ) : (
                            <span className="rounded-full border border-amber-500/40 bg-amber-500/15 px-3 py-1 text-xs font-bold text-amber-200 inline-flex items-center gap-1.5">
                              <AlertTriangle className="h-3.5 w-3.5" />
                              In Contention{" "}
                              {activeAthlete.selectionTrials.gapToCutoff != null && (
                                <span className="opacity-90 font-mono">
                                  ({activeAthlete.selectionTrials.gapToCutoff > 0 ? `+${activeAthlete.selectionTrials.gapToCutoff.toFixed(1)}` : activeAthlete.selectionTrials.gapToCutoff.toFixed(1)} pts to top 5 cutoff)
                                </span>
                              )}
                            </span>
                          )}

                          {activeAthlete.selectionTrials.isQualifiedPerth && (
                            <span className="rounded-full border border-sky-500/40 bg-sky-500/15 px-3 py-1 text-xs font-bold text-sky-200 inline-flex items-center gap-1.5">
                              <CheckCircle2 className="h-3.5 w-3.5" />
                              Selected for Perth Camp
                            </span>
                          )}
                        </div>
                      </div>
                    ) : (
                      <div className="rounded-xl border border-white/5 bg-black/20 p-3.5 text-xs text-slate-400">
                        Selection trials tracking is enabled for Optimist Gold fleet sailors participating in the 2026 selection series.
                      </div>
                    )}

                    {/* Series Standings Card */}
                    {activeAthlete.standing ? (
                      <div className="rounded-xl border border-white/5 bg-black/25 p-3.5 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                        <div>
                          <p className="text-[10px] font-black uppercase tracking-wider text-slate-400">
                            National Series Ranking ({activeAthlete.standing.periodLabel})
                          </p>
                          <p className="text-base font-black text-white mt-0.5">
                            #{activeAthlete.standing.overallRank}{" "}
                            <span className="text-xs font-normal text-slate-400">
                              in {activeAthlete.standing.fleet} Fleet ({activeAthlete.standing.fleetSize} sailors)
                            </span>
                          </p>
                          <p className="text-[11px] text-slate-400 mt-0.5">
                            {activeAthlete.standing.trendNote} · Best 3 of 5:{" "}
                            <span className="font-bold text-white">
                              {activeAthlete.standing.best3of5} pts
                            </span>
                          </p>
                        </div>
                        <div className="shrink-0">
                          <Link
                            href={
                              activeAthlete.standing.fleet === "Gold"
                                ? "/sg/optimist/gold"
                                : "/sg/optimist/silver"
                            }
                            className="text-xs font-bold text-orange-400 hover:text-orange-300"
                          >
                            Explore Fleet Board →
                          </Link>
                        </div>
                      </div>
                    ) : null}

                    {/* Recent Regatta Finishes */}
                    {activeAthlete.recentResults && activeAthlete.recentResults.length > 0 && (
                      <div className="space-y-2 pt-1">
                        <p className="text-[11px] font-black uppercase tracking-wider text-slate-400">
                          Recent Regatta Results
                        </p>
                        <div className="grid grid-cols-1 sm:grid-cols-3 gap-2">
                          {activeAthlete.recentResults.map((r, i) => (
                            <div
                              key={i}
                              className="rounded-xl border border-white/5 bg-black/20 p-2.5 flex items-center justify-between gap-2"
                            >
                              <div className="min-w-0">
                                <p className="text-xs font-bold text-white truncate">
                                  {r.regattaName}
                                </p>
                                <p className="text-[10px] text-slate-400 font-mono">
                                  {r.regattaDate}
                                </p>
                              </div>
                              <span className="text-xs font-black text-orange-300 tabular-nums px-2 py-0.5 rounded-md bg-orange-500/10 border border-orange-500/20">
                                #{r.rank}
                              </span>
                            </div>
                          ))}
                        </div>
                      </div>
                    )}
                  </div>

                  {/* CARD B: EQUIPMENT & BOAT LOCKER */}
                  <div className="rounded-2xl border border-white/10 bg-[#131520]/90 p-5 sm:p-6 space-y-4 shadow-sm">
                    <div className="flex items-start justify-between gap-3">
                      <div>
                        <h3 className="text-sm font-black uppercase tracking-wider text-sky-400 flex items-center gap-2">
                          <Sailboat className="h-4 w-4 text-sky-400" />
                          Boat Locker & Equipment
                        </h3>
                        <p className="text-xs text-slate-400 mt-0.5">
                          Track hull condition, sails, spars, measurement certificates, and maintenance alerts.
                        </p>
                      </div>
                      <Link
                        href={`/${activeAthlete.handle}`}
                        className="text-[11px] font-bold text-sky-400 hover:text-sky-300 hover:underline flex items-center gap-1 shrink-0"
                      >
                        Manage Gear →
                      </Link>
                    </div>

                    {/* Active alerts banner if any */}
                    {(activeAthlete.equipmentAlertCount ?? 0) > 0 && (
                      <div className="rounded-xl border border-rose-500/30 bg-rose-500/10 p-3.5 space-y-2">
                        <p className="text-xs font-bold text-rose-300 flex items-center gap-1.5">
                          <AlertTriangle className="h-4 w-4 text-rose-400 shrink-0" />
                          {activeAthlete.equipmentAlertCount} Equipment Alert
                          {activeAthlete.equipmentAlertCount === 1 ? "" : "s"} Require Action
                        </p>
                        <div className="space-y-1 pl-5">
                          {(activeAthlete.equipmentAlerts || []).map((al, idx) => (
                            <p key={idx} className="text-xs text-rose-200/90">
                              <span className="font-bold">{al.label}:</span> {al.reason}
                            </p>
                          ))}
                        </div>
                      </div>
                    )}

                    {/* Equipment grid */}
                    {activeAthlete.primaryGear && activeAthlete.primaryGear.length > 0 ? (
                      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-2.5">
                        {activeAthlete.primaryGear.map((g) => (
                          <div
                            key={g.id}
                            className="rounded-xl border border-white/5 bg-black/25 p-3 flex flex-col justify-between gap-2"
                          >
                            <div>
                              <span className="text-[10px] font-black uppercase tracking-wider text-slate-500">
                                {g.category}
                              </span>
                              <p className="text-xs font-bold text-white mt-0.5">
                                {g.label || [g.brand, g.model].filter(Boolean).join(" ") || "Equipment Item"}
                              </p>
                            </div>
                            <div className="flex items-center justify-between pt-1 border-t border-white/5">
                              <span
                                className={`text-[10px] font-bold capitalize px-2 py-0.5 rounded-md ${
                                  g.condition === "new" || g.condition === "good"
                                    ? "bg-emerald-500/15 text-emerald-300"
                                    : g.condition === "fair"
                                    ? "bg-amber-500/15 text-amber-300"
                                    : "bg-rose-500/15 text-rose-300"
                                }`}
                              >
                                {g.condition || "Good"}
                              </span>
                              {g.isPrimary && (
                                <span className="text-[10px] font-semibold text-slate-400">
                                  Primary
                                </span>
                              )}
                            </div>
                          </div>
                        ))}
                      </div>
                    ) : (
                      <div className="rounded-xl border border-dashed border-white/10 bg-black/15 p-5 text-center space-y-2">
                        <p className="text-xs font-bold text-slate-300">No primary gear registered</p>
                        <p className="text-[11px] text-slate-500 max-w-sm mx-auto">
                          Add your child&apos;s hull number, spars, and primary sails on their profile to track safety checks and warranty windows.
                        </p>
                        <Link
                          href={`/${activeAthlete.handle}`}
                          className="inline-block text-xs font-bold text-orange-400 hover:text-orange-300 pt-1"
                        >
                          Add equipment on profile →
                        </Link>
                      </div>
                    )}
                  </div>

                  {/* CARD C: COACH OBSERVATIONS & FEEDBACK */}
                  <div className="rounded-2xl border border-white/10 bg-[#131520]/90 p-5 sm:p-6 space-y-4 shadow-sm">
                    <div className="flex items-start justify-between gap-3">
                      <div>
                        <h3 className="text-sm font-black uppercase tracking-wider text-emerald-400 flex items-center gap-2">
                          <Award className="h-4 w-4 text-emerald-400" />
                          Coach Observations & Development Records
                        </h3>
                        <p className="text-xs text-slate-400 mt-0.5">
                          Technical debriefs, starts, tactics, and boat speed observations logged by accredited coaches.
                        </p>
                      </div>
                      <span className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">
                        Read-Only Feed
                      </span>
                    </div>

                    {activeAthlete.coachFeedback && activeAthlete.coachFeedback.length > 0 ? (
                      <div className="space-y-3">
                        {activeAthlete.coachFeedback.map((cf) => (
                          <div
                            key={cf.id}
                            className="rounded-xl border border-white/5 bg-black/25 p-3.5 space-y-1.5"
                          >
                            <div className="flex flex-wrap items-center justify-between gap-2">
                              <div className="flex items-center gap-2">
                                <span className="text-xs font-bold text-white">
                                  {cf.title}
                                </span>
                                {cf.category && (
                                  <span className="rounded-md border border-emerald-500/25 bg-emerald-500/10 px-2 py-0.5 text-[10px] font-bold text-emerald-300 capitalize">
                                    {cf.category}
                                  </span>
                                )}
                              </div>
                              <span className="text-[10px] text-slate-500 font-mono">
                                {cf.recordDate}
                              </span>
                            </div>
                            {cf.detail && (
                              <p className="text-xs text-slate-300 leading-relaxed">
                                {cf.detail}
                              </p>
                            )}
                          </div>
                        ))}
                      </div>
                    ) : (
                      <div className="rounded-xl border border-white/5 bg-black/15 p-4 text-center text-xs text-slate-500">
                        No coach observations logged yet for this period. Entries recorded by your child&apos;s coaches will automatically show here.
                      </div>
                    )}
                  </div>
                </div>

                {/* COLUMN 3: RIGHT COLUMN ON DESKTOP */}
                <div className="space-y-6">
                  {/* CARD D: UPCOMING REGATTAS & INTERACTIVE PRE-RACE CHECKLIST */}
                  <div className="rounded-2xl border border-white/10 bg-[#131520]/90 p-5 space-y-4 shadow-sm">
                    <div className="flex items-start justify-between gap-2">
                      <div>
                        <h3 className="text-sm font-black uppercase tracking-wider text-purple-400 flex items-center gap-2">
                          <Calendar className="h-4 w-4 text-purple-400" />
                          Regatta Prep & Checklist
                        </h3>
                        <p className="text-[11px] text-slate-400 mt-0.5">
                          Upcoming calendar & race-day verification items.
                        </p>
                      </div>
                      <button
                        type="button"
                        onClick={() => resetChecklist(activeAthlete.id)}
                        className="text-[11px] font-semibold text-slate-400 hover:text-white inline-flex items-center gap-1 p-1"
                        title="Reset checklist"
                      >
                        <RotateCcw className="h-3 w-3" />
                        Reset
                      </button>
                    </div>

                    {/* Upcoming regatta calendar list */}
                    {upcomingRegattas.length > 0 ? (
                      <div className="space-y-2">
                        <p className="text-[10px] font-black uppercase tracking-wider text-slate-500">
                          Upcoming Regattas
                        </p>
                        <div className="space-y-1.5">
                          {upcomingRegattas.slice(0, 3).map((reg) => (
                            <div
                              key={reg.id}
                              className="rounded-xl border border-white/5 bg-black/25 p-2.5 text-xs flex justify-between items-center gap-2"
                            >
                              <div className="min-w-0">
                                <p className="font-bold text-white truncate">{reg.name}</p>
                                <p className="text-[10px] text-slate-400 font-mono mt-0.5">
                                  {reg.date}{" "}
                                  {reg.boatClass ? `· ${reg.boatClass}` : ""}
                                </p>
                              </div>
                              {reg.slug && (
                                <Link
                                  href={`/regattas/${reg.slug}`}
                                  className="text-[11px] font-bold text-orange-400 hover:underline shrink-0"
                                >
                                  Details
                                </Link>
                              )}
                            </div>
                          ))}
                        </div>
                      </div>
                    ) : null}

                    {/* Interactive Checklist */}
                    <div className="space-y-2.5 pt-2 border-t border-white/5">
                      <div className="flex items-center justify-between">
                        <p className="text-[10px] font-black uppercase tracking-wider text-slate-400">
                          Race Day Morning Checklist
                        </p>
                        {(() => {
                          const state = checklistState[activeAthlete.id] || {};
                          const doneCount = RACE_CHECKLIST_ITEMS.filter((item) => state[item.id]).length;
                          return (
                            <span className="text-[11px] font-bold text-emerald-400">
                              {doneCount}/{RACE_CHECKLIST_ITEMS.length} ready
                            </span>
                          );
                        })()}
                      </div>

                      <div className="space-y-1.5">
                        {RACE_CHECKLIST_ITEMS.map((item) => {
                          const isDone = Boolean(checklistState[activeAthlete.id]?.[item.id]);
                          return (
                            <button
                              key={item.id}
                              type="button"
                              onClick={() => toggleChecklistItem(activeAthlete.id, item.id)}
                              className={`w-full text-left rounded-xl p-2.5 text-xs flex items-start gap-2.5 transition-colors ${
                                isDone
                                  ? "bg-emerald-500/[0.08] border border-emerald-500/25 text-slate-300"
                                  : "bg-black/25 border border-white/5 text-slate-300 hover:border-white/15"
                              }`}
                            >
                              {isDone ? (
                                <CheckSquare className="h-4 w-4 text-emerald-400 shrink-0 mt-0.5" />
                              ) : (
                                <Square className="h-4 w-4 text-slate-500 shrink-0 mt-0.5" />
                              )}
                              <span className={isDone ? "line-through opacity-75" : "font-normal"}>
                                {item.label}
                              </span>
                            </button>
                          );
                        })}
                      </div>
                    </div>
                  </div>

                  {/* CARD E: PRIVATE PARENT JOURNAL & LOG */}
                  <div className="rounded-2xl border border-white/10 bg-[#131520]/90 p-5 space-y-4 shadow-sm">
                    <div className="flex items-start justify-between gap-2">
                      <div>
                        <h3 className="text-sm font-black uppercase tracking-wider text-emerald-400 flex items-center gap-2">
                          <StickyNote className="h-4 w-4 text-emerald-400" />
                          Private Parent Journal
                        </h3>
                        <p className="text-[11px] text-slate-400 mt-0.5 flex items-center gap-1">
                          <Lock className="h-3 w-3 text-slate-500" />
                          100% private to your parent account.
                        </p>
                      </div>
                    </div>

                    {/* Note creator */}
                    <div className="space-y-2">
                      {/* Tag selector */}
                      <div className="flex flex-wrap gap-1.5">
                        {NOTE_CATEGORIES.map((cat) => (
                          <button
                            key={cat}
                            type="button"
                            onClick={() => setSelectedCategory(cat)}
                            className={`px-2 py-0.5 rounded-md text-[10px] font-bold transition-all ${
                              selectedCategory === cat
                                ? "bg-emerald-500/25 text-emerald-300 border border-emerald-500/40"
                                : "bg-black/40 text-slate-400 border border-white/5 hover:text-white"
                            }`}
                          >
                            {cat}
                          </button>
                        ))}
                      </div>

                      <div className="flex gap-2">
                        <input
                          value={noteDraft[activeAthlete.id] || ""}
                          onChange={(e) =>
                            setNoteDraft((d) => ({
                              ...d,
                              [activeAthlete.id]: e.target.value,
                            }))
                          }
                          placeholder={`Add a private ${selectedCategory.toLowerCase()} note…`}
                          className="flex-1 min-w-0 rounded-xl bg-black/40 border border-white/10 px-3 py-2 text-xs text-white placeholder:text-slate-600 focus:outline-none focus:border-emerald-500/50"
                          onKeyDown={(e) => {
                            if (e.key === "Enter") void addNote(activeAthlete.id);
                          }}
                        />
                        <button
                          type="button"
                          disabled={
                            noteBusy === activeAthlete.id ||
                            !(noteDraft[activeAthlete.id] || "").trim()
                          }
                          onClick={() => void addNote(activeAthlete.id)}
                          className="rounded-xl bg-emerald-600 hover:bg-emerald-500 px-3 py-2 text-white font-bold text-xs disabled:opacity-40 transition-colors shrink-0 inline-flex items-center gap-1"
                        >
                          <Plus className="h-4 w-4" />
                          Save
                        </button>
                      </div>
                    </div>

                    {/* Existing notes list */}
                    {(activeAthlete.notes?.length ?? 0) === 0 ? (
                      <p className="text-[11px] text-slate-500 text-center py-3">
                        No private notes yet. Log training thoughts, regatta debriefs, logistics, or equipment orders.
                      </p>
                    ) : (
                      <div className="space-y-2 max-h-72 overflow-y-auto pr-1">
                        {activeAthlete.notes!.map((n) => {
                          const parsed = parseNoteCategory(n.body);
                          return (
                            <div
                              key={n.id}
                              className="rounded-xl border border-white/5 bg-black/25 p-2.5 flex items-start justify-between gap-2"
                            >
                              <div className="min-w-0 flex-1 space-y-1">
                                <div className="flex items-center gap-2">
                                  {parsed.category && (
                                    <span className="rounded px-1.5 py-0.5 text-[9px] font-black uppercase tracking-wider bg-emerald-500/15 text-emerald-300 border border-emerald-500/25">
                                      {parsed.category}
                                    </span>
                                  )}
                                  <span className="text-[10px] text-slate-500 font-mono">
                                    {n.createdAt ? n.createdAt.slice(0, 10) : ""}
                                  </span>
                                </div>
                                <p className="text-xs text-slate-200 leading-relaxed whitespace-pre-wrap">
                                  {parsed.text}
                                </p>
                              </div>
                              <button
                                type="button"
                                disabled={noteBusy === n.id}
                                onClick={() => void deleteNote(n.id)}
                                className="text-slate-600 hover:text-rose-400 p-1 shrink-0 transition-colors"
                                aria-label="Delete note"
                              >
                                <Trash2 className="h-3.5 w-3.5" />
                              </button>
                            </div>
                          );
                        })}
                      </div>
                    )}
                  </div>
                </div>
              </div>
            </div>
          )}
        </>
      )}

      {/* Footer support links */}
      <p className="text-center text-xs text-slate-500 pt-4">
        <Link href="/account" className="text-slate-400 hover:text-white transition-colors">
          Account Settings
        </Link>
        {" · "}
        <Link href="/search" className="text-slate-400 hover:text-white transition-colors">
          Find Sailors
        </Link>
        {" · "}
        <Link href="/support" className="text-slate-400 hover:text-white transition-colors">
          Support & Feedback
        </Link>
      </p>
    </div>
  );
}

