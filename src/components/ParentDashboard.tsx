"use client";

import { useCallback, useEffect, useState } from "react";
import Link from "next/link";
import {
  Heart,
  Trophy,
  User,
  Search,
  ChevronRight,
  Clock,
  Sailboat,
  Pencil,
  AlertTriangle,
  StickyNote,
  Plus,
  Trash2,
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

type RecentResult = {
  regattaName: string;
  regattaDate: string;
  rank: number;
  boatClass: string | null;
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
  recentResults?: RecentResult[];
  equipmentAlertCount?: number;
  equipmentAlerts?: { label: string; reason: string }[];
  notes?: Note[];
};

type PendingClaim = {
  id: string;
  status: string;
  relation: ClaimRelation | null;
  sailorName: string;
  sailorHandle: string;
  createdAt: string;
};

export function ParentDashboard() {
  const { toast, confirm } = useFeedback();
  const [athletes, setAthletes] = useState<Athlete[]>([]);
  const [pendingClaims, setPendingClaims] = useState<PendingClaim[]>([]);
  const [isParentStyle, setIsParentStyle] = useState(true);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [noteDraft, setNoteDraft] = useState<Record<string, string>>({});
  const [noteBusy, setNoteBusy] = useState<string | null>(null);

  const load = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch("/api/account/family", {
        credentials: "include",
      });
      if (res.status === 401) {
        window.location.assign(
          `/login?next=${encodeURIComponent("/parent")}`
        );
        return;
      }
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Could not load dashboard");
      setAthletes(data.athletes || []);
      setPendingClaims(data.pendingClaims || []);
      setIsParentStyle(Boolean(data.isParentStyle));
    } catch (e) {
      setError(e instanceof Error ? e.message : "Error");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    // This effect starts the client-only dashboard request; later refreshes reuse load().
    // eslint-disable-next-line react-hooks/set-state-in-effect
    void load();
  }, [load]);

  const addNote = async (sailorId: string) => {
    const body = (noteDraft[sailorId] || "").trim();
    if (body.length < 2) return;
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
    } catch (e) {
      toast.error(e instanceof Error ? e.message : "Error");
    } finally {
      setNoteBusy(null);
    }
  };

  const deleteNote = async (id: string) => {
    const ok = await confirm({
      title: "Delete this note?",
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

  const title = isParentStyle ? "Parent Dashboard" : "Sailor Dashboard";
  const subtitle = isParentStyle
    ? "Rankings, recent results, gear alerts, and private notes."
    : "Your ranking, recent results, gear, and notes.";

  return (
    <div className="mx-auto max-w-3xl w-full px-4 py-8 sm:py-12 space-y-6 sm:space-y-8">
      <div className="flex items-start justify-between gap-4 flex-wrap">
        <div className="flex items-start gap-3 min-w-0">
          <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-emerald-500/15 border border-emerald-500/25 text-emerald-400">
            <Heart className="h-5 w-5" />
          </span>
          <div className="min-w-0">
            <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
              {title}
            </h1>
            <p className="mt-1 text-sm text-slate-400 leading-relaxed">
              {subtitle}
            </p>
          </div>
        </div>
        <Link
          href="/search"
          className="rounded-full border border-white/10 bg-white/5 px-4 py-2 text-[11px] font-bold text-white hover:border-orange-500/40 inline-flex items-center gap-1.5"
        >
          <Search className="h-3.5 w-3.5" />
          Find a sailor
        </Link>
      </div>

      {error && (
        <p className="text-sm font-bold text-rose-400 rounded-xl border border-rose-500/25 bg-rose-500/10 px-4 py-3">
          {error}
        </p>
      )}

      {pendingClaims.length > 0 && (
        <section className="rounded-2xl border border-amber-500/25 bg-amber-500/[0.06] p-5 space-y-3">
          <h2 className="text-xs font-black text-amber-200 uppercase tracking-wider flex items-center gap-2">
            <Clock className="h-4 w-4" />
            Claims awaiting approval
          </h2>
          <ul className="space-y-2">
            {pendingClaims.map((c) => (
              <li
                key={c.id}
                className="rounded-xl border border-white/5 bg-black/20 px-3 py-2.5 flex flex-col sm:flex-row sm:items-center justify-between gap-2"
              >
                <div>
                  <Link
                    href={`/${c.sailorHandle}`}
                    className="text-sm font-bold text-white hover:text-orange-400"
                  >
                    {c.sailorName}
                  </Link>
                  <p className="text-[11px] text-slate-500">
                    {relationLabel(c.relation)} · submitted{" "}
                    {c.createdAt
                      ? new Date(c.createdAt).toLocaleDateString()
                      : "—"}
                  </p>
                </div>
                <span className="text-[10px] font-black uppercase text-amber-300">
                  Pending
                </span>
              </li>
            ))}
          </ul>
        </section>
      )}

      <section className="space-y-3">
        <h2 className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">
          Athletes you manage ({athletes.length})
        </h2>

        {athletes.length === 0 ? (
          <div className="rounded-2xl border border-white/5 bg-[#131520]/80 p-6 sm:p-8 text-center space-y-4">
            <Sailboat className="h-8 w-8 text-slate-600 mx-auto" />
            <p className="text-sm font-bold text-white">
              No linked sailor profiles yet
            </p>
            <p className="text-xs text-slate-500 max-w-md mx-auto leading-relaxed">
              Search for your child (or yourself), open the profile, and submit
              a claim as <strong className="text-slate-300">Parent</strong> or{" "}
              <strong className="text-slate-300">Sailor</strong>. After admin
              approval, they appear here.
            </p>
            <div className="flex flex-col sm:flex-row gap-2 justify-center">
              <Link
                href="/search"
                className="rounded-full bg-orange-600 hover:bg-orange-500 px-5 py-2.5 text-xs font-bold text-white"
              >
                Search sailors
              </Link>
              <Link
                href="/claim-profile"
                className="rounded-full border border-white/10 bg-white/5 px-5 py-2.5 text-xs font-bold text-white"
              >
                How claiming works
              </Link>
            </div>
          </div>
        ) : (
          <ul className="space-y-4">
            {athletes.map((a) => (
              <li
                key={a.id}
                className="rounded-2xl border border-white/5 bg-[#131520]/80 p-4 sm:p-5 space-y-4"
              >
                <div className="flex items-start gap-3">
                  {a.avatarUrl ? (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img
                      src={a.avatarUrl}
                      alt=""
                      className="h-12 w-12 rounded-xl object-cover border border-white/10 shrink-0"
                    />
                  ) : (
                    <span className="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-orange-500/15 border border-orange-500/20 text-orange-400">
                      <User className="h-5 w-5" />
                    </span>
                  )}
                  <div className="min-w-0 flex-1">
                    <div className="flex flex-wrap items-center gap-2">
                      <Link
                        href={`/${a.handle}`}
                        className="text-lg font-black text-white hover:text-orange-400 truncate"
                      >
                        {a.name}
                      </Link>
                      {a.ownerRelation && (
                        <span className="rounded-full border border-emerald-500/25 bg-emerald-500/10 px-2 py-0.5 text-[10px] font-bold text-emerald-300">
                          {relationLabel(a.ownerRelation)}
                        </span>
                      )}
                    </div>
                    <p className="text-[12px] text-slate-500 mt-0.5">
                      {[a.sailNumber, a.club, a.gender, birthYear(a.dob)]
                        .filter(Boolean)
                        .join(" · ")}
                    </p>
                    {a.nationalSquadStatus && (
                      <p className="text-[11px] text-orange-300/90 font-semibold mt-1">
                        Squad: {a.nationalSquadStatus}
                      </p>
                    )}
                  </div>
                </div>

                {a.standing ? (
                  <div className="rounded-xl border border-orange-500/20 bg-orange-500/[0.06] px-3.5 py-3 grid grid-cols-2 sm:grid-cols-4 gap-3">
                    <div>
                      <p className="text-[10px] font-bold text-slate-500 uppercase">
                        Rank
                      </p>
                      <p className="text-lg font-black text-white tabular-nums">
                        #{a.standing.overallRank}
                        <span className="text-xs font-semibold text-slate-500">
                          {" "}
                          / {a.standing.fleetSize}
                        </span>
                      </p>
                    </div>
                    <div>
                      <p className="text-[10px] font-bold text-slate-500 uppercase">
                        Fleet
                      </p>
                      <p className="text-sm font-bold text-orange-300">
                        {a.standing.fleet}
                      </p>
                    </div>
                    <div>
                      <p className="text-[10px] font-bold text-slate-500 uppercase">
                        Best 3 of 5
                      </p>
                      <p className="text-sm font-black text-white tabular-nums">
                        {a.standing.best3of5}
                      </p>
                    </div>
                    <div className="min-w-0">
                      <p className="text-[10px] font-bold text-slate-500 uppercase">
                        Period
                      </p>
                      <p className="text-[11px] font-semibold text-slate-300 truncate">
                        {a.standing.periodLabel}
                      </p>
                    </div>
                  </div>
                ) : (
                  <p className="text-[11px] text-slate-600">
                    No series ranking for the current half (guest, dropped, or
                    no scoring events yet).
                  </p>
                )}

                {/* Recent results */}
                {(a.recentResults?.length ?? 0) > 0 && (
                  <div>
                    <p className="text-[10px] font-bold text-slate-500 uppercase mb-1.5">
                      Recent results
                    </p>
                    <ul className="space-y-1">
                      {a.recentResults!.map((r, i) => (
                        <li
                          key={`${r.regattaDate}-${i}`}
                          className="text-[12px] text-slate-300 flex justify-between gap-2"
                        >
                          <span className="truncate min-w-0">
                            <span className="text-slate-500 font-mono text-[11px]">
                              {r.regattaDate}
                            </span>{" "}
                            {r.regattaName}
                          </span>
                          <span className="font-bold text-orange-300 tabular-nums shrink-0">
                            #{r.rank}
                          </span>
                        </li>
                      ))}
                    </ul>
                  </div>
                )}

                {/* Equipment alerts (private) */}
                {(a.equipmentAlertCount ?? 0) > 0 && (
                  <div className="rounded-xl border border-amber-500/25 bg-amber-500/10 px-3 py-2.5 space-y-1">
                    <p className="text-[11px] font-bold text-amber-200 flex items-center gap-1.5">
                      <AlertTriangle className="h-3.5 w-3.5" />
                      {a.equipmentAlertCount} equipment alert
                      {a.equipmentAlertCount === 1 ? "" : "s"}
                    </p>
                    {(a.equipmentAlerts || []).map((al, i) => (
                      <p key={i} className="text-[11px] text-amber-100/90">
                        {al.label} — {al.reason}
                      </p>
                    ))}
                    <Link
                      href={`/${a.handle}`}
                      className="inline-block text-[11px] font-bold text-amber-200 hover:underline mt-0.5"
                    >
                      Review gear on profile →
                    </Link>
                  </div>
                )}

                {/* Private notes */}
                <div className="rounded-xl border border-white/5 bg-black/20 px-3 py-2.5 space-y-2">
                  <p className="text-[10px] font-bold text-slate-500 uppercase flex items-center gap-1.5">
                    <StickyNote className="h-3.5 w-3.5 text-emerald-400" />
                    Private notes
                  </p>
                  {(a.notes?.length ?? 0) === 0 ? (
                    <p className="text-[11px] text-slate-600">
                      No notes yet — exams, coach chats, travel, etc.
                    </p>
                  ) : (
                    <ul className="space-y-1.5">
                      {a.notes!.map((n) => (
                        <li
                          key={n.id}
                          className="flex gap-2 items-start text-[12px] text-slate-300"
                        >
                          <span className="flex-1 min-w-0">
                            <span className="text-[10px] text-slate-600 font-mono block">
                              {n.createdAt
                                ? n.createdAt.slice(0, 10)
                                : ""}
                            </span>
                            {n.body}
                          </span>
                          <button
                            type="button"
                            disabled={noteBusy === n.id}
                            onClick={() => void deleteNote(n.id)}
                            className="text-slate-600 hover:text-rose-400 p-0.5 shrink-0"
                            aria-label="Delete note"
                          >
                            <Trash2 className="h-3.5 w-3.5" />
                          </button>
                        </li>
                      ))}
                    </ul>
                  )}
                  <div className="flex gap-2">
                    <input
                      value={noteDraft[a.id] || ""}
                      onChange={(e) =>
                        setNoteDraft((d) => ({
                          ...d,
                          [a.id]: e.target.value,
                        }))
                      }
                      placeholder="Add a private note…"
                      className="flex-1 min-w-0 rounded-lg bg-black/40 border border-white/10 px-2.5 py-1.5 text-[12px] text-white"
                      onKeyDown={(e) => {
                        if (e.key === "Enter") void addNote(a.id);
                      }}
                    />
                    <button
                      type="button"
                      disabled={
                        noteBusy === a.id ||
                        !(noteDraft[a.id] || "").trim()
                      }
                      onClick={() => void addNote(a.id)}
                      className="rounded-lg bg-emerald-600/90 px-2.5 py-1.5 text-white disabled:opacity-40"
                      aria-label="Add note"
                    >
                      <Plus className="h-4 w-4" />
                    </button>
                  </div>
                </div>

                <div className="flex flex-wrap gap-2">
                  <Link
                    href={`/${a.handle}`}
                    className="inline-flex items-center gap-1 rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-[11px] font-bold text-white"
                  >
                    Open profile
                    <ChevronRight className="h-3.5 w-3.5" />
                  </Link>
                  <Link
                    href={`/${a.handle}`}
                    className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 px-4 py-2 text-[11px] font-bold text-white hover:border-orange-500/40"
                  >
                    <Pencil className="h-3.5 w-3.5" />
                    Open profile
                  </Link>
                  {a.standing?.fleet === "Gold" && (
                    <Link
                      href="/sg/optimist/gold"
                      className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 px-4 py-2 text-[11px] font-bold text-slate-300 hover:text-white"
                    >
                      <Trophy className="h-3.5 w-3.5 text-orange-400" />
                      Gold rankings
                    </Link>
                  )}
                  {a.standing?.fleet === "Silver" && (
                    <Link
                      href="/sg/optimist/silver"
                      className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 px-4 py-2 text-[11px] font-bold text-slate-300 hover:text-white"
                    >
                      <Trophy className="h-3.5 w-3.5 text-sky-400" />
                      Silver rankings
                    </Link>
                  )}
                </div>
              </li>
            ))}
          </ul>
        )}
      </section>

      <p className="text-center text-[11px] text-slate-600">
        <Link href="/account" className="text-slate-500 hover:text-white">
          Account settings
        </Link>
        {" · "}
        <Link href="/support" className="text-slate-500 hover:text-white">
          Support
        </Link>
      </p>
    </div>
  );
}
