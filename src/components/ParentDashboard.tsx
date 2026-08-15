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
} from "lucide-react";
import { relationLabel, type ClaimRelation } from "@/lib/claimRelation";
import { birthYear } from "@/lib/age";

type Standing = {
  periodLabel: string;
  fleet: string;
  overallRank: number;
  fleetSize: number;
  best3of5: number;
  trendNote: string;
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
  const [athletes, setAthletes] = useState<Athlete[]>([]);
  const [pendingClaims, setPendingClaims] = useState<PendingClaim[]>([]);
  const [isParentStyle, setIsParentStyle] = useState(true);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

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
    void load();
  }, [load]);

  if (loading) {
    return (
      <div className="flex-1 flex items-center justify-center py-24 text-sm text-slate-500">
        Loading dashboard…
      </div>
    );
  }

  const title = isParentStyle ? "Parent dashboard" : "My sailors";
  const subtitle = isParentStyle
    ? "Rankings, profiles, and claims for the athletes you manage."
    : "Your linked athlete profiles and claim status.";

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

      {/* Pending claims */}
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
          <p className="text-[11px] text-slate-500">
            An admin will verify your email and note. Track status anytime on{" "}
            <Link href="/account" className="text-orange-400 font-semibold">
              My account
            </Link>
            .
          </p>
        </section>
      )}

      {/* Athletes */}
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
          <ul className="space-y-3">
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

                <div className="flex flex-wrap gap-2">
                  <Link
                    href={`/${a.handle}`}
                    className="inline-flex items-center gap-1 rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-[11px] font-bold text-white"
                  >
                    Open profile
                    <ChevronRight className="h-3.5 w-3.5" />
                  </Link>
                  <Link
                    href={`/${a.handle}?edit=1`}
                    className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 px-4 py-2 text-[11px] font-bold text-white hover:border-orange-500/40"
                  >
                    <Pencil className="h-3.5 w-3.5" />
                    Edit
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
