"use client";

import { Fragment, useMemo, useState } from "react";
import Link from "next/link";
import {
  Trophy,
  Award,
  Users,
  Compass,
  Lock,
  AlertCircle,
  Calendar,
  MapPin,
} from "lucide-react";
import { useAccount } from "@/components/AccountProvider";
import type { OptimistSelectionPayload } from "@/lib/selectionQueries";

type Tab = "asian" | "perth" | "combined";

export function OptimistSelectionView({
  initialData,
}: {
  initialData: OptimistSelectionPayload;
}) {
  const { email, owned, ready: accountReady } = useAccount();
  const isLoggedIn = Boolean(email);

  const [activeTab, setActiveTab] = useState<Tab>("asian");
  const [selectedSailorId, setSelectedSailorId] = useState<string | null>(null);
  const [genderFilter, setGenderFilter] = useState<"all" | "M" | "F">("all");
  const [perthBucketFilter, setPerthBucketFilter] = useState<string>("all");

  const {
    matched,
    selectionStatus,
    combinedScores,
    perthCamp,
    campaigns,
  } = initialData;

  // Claimed athlete detection
  const mySailor = useMemo(() => {
    if (!isLoggedIn || owned.length === 0) return null;
    const ownedIds = new Set(owned.map((o) => o.id));
    return combinedScores.find((s) => ownedIds.has(s.sailorId)) || null;
  }, [isLoggedIn, owned, combinedScores]);

  // Filtered rows for Asian / Combined
  const displayAsianRows = useMemo(() => {
    let rows = combinedScores;
    if (genderFilter !== "all") {
      rows = rows.filter((r) => r.gender === genderFilter);
    }
    return rows;
  }, [combinedScores, genderFilter]);

  // Perth filtered rows
  const displayPerthRows = useMemo(() => {
    let picks = perthCamp.picks;
    if (perthBucketFilter !== "all") {
      picks = picks.filter((p) => p.bucket === perthBucketFilter);
    }
    if (genderFilter !== "all") {
      picks = picks.filter((p) => p.gender === genderFilter);
    }
    return picks;
  }, [perthCamp.picks, perthBucketFilter, genderFilter]);

  // Buffer calculation for Top 10 cutoff (slot 10 vs slot 11)
  const cutoffBuffer = useMemo(() => {
    if (combinedScores.length < 11) return null;
    const slot10 = combinedScores[9];
    const slot11 = combinedScores[10];
    return slot11.combinedScore - slot10.combinedScore;
  }, [combinedScores]);

  // Find where my sailor stands
  const mySailorAsianRank = useMemo(() => {
    if (!mySailor) return null;
    const idx = combinedScores.findIndex((s) => s.sailorId === mySailor.sailorId);
    if (idx === -1) return null;
    const rank = idx + 1;
    const isSafe = rank <= 7;
    const isBubble = rank > 7 && rank <= 10;
    const isReserve = rank > 10;
    const pointsToCutoff =
      combinedScores.length >= 10
        ? rank <= 10
          ? (combinedScores[10]?.combinedScore ?? 0) - mySailor.combinedScore
          : mySailor.combinedScore - combinedScores[9].combinedScore
        : null;

    return { rank, isSafe, isBubble, isReserve, pointsToCutoff };
  }, [mySailor, combinedScores]);

  if (!accountReady) {
    return (
      <div className="mx-auto w-full max-w-4xl px-4 py-20 flex flex-col items-center justify-center space-y-3">
        <div className="h-6 w-6 animate-spin rounded-full border-2 border-orange-500 border-t-transparent" />
        <p className="text-xs text-slate-500 font-medium">Verifying member access…</p>
      </div>
    );
  }

  if (!isLoggedIn) {
    return (
      <div className="mx-auto w-full max-w-4xl px-4 py-10 sm:py-16 space-y-8">
        {/* Breadcrumb back */}
        <div>
          <Link
            href="/sg/optimist/gold"
            className="inline-flex items-center gap-1.5 text-xs font-semibold text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)] transition-colors"
          >
            <span>← Back to Optimist Gold Rankings</span>
          </Link>
        </div>

        {/* Member Access Gate Card */}
        <div className="relative overflow-hidden rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-6 sm:p-10 text-center space-y-6 shadow-xs">
          <div className="relative mx-auto flex h-16 w-16 items-center justify-center rounded-2xl bg-[var(--sp-racing-mist)]/30 border border-[var(--sp-racing-orange)]/30 text-[var(--sp-racing-orange)] shadow-sm">
            <Lock className="h-8 w-8" />
          </div>

          <div className="relative space-y-2 max-w-xl mx-auto">
            <div className="inline-flex items-center gap-1.5 rounded-full border border-[var(--sp-racing-orange)]/30 bg-[var(--sp-racing-mist)]/30 px-3 py-0.5 text-[11px] font-bold text-[var(--sp-racing-orange)]">
              <Trophy className="h-3 w-3" />
              <span>Singapore Optimist Class</span>
            </div>
            <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
              2026 Selection Trials
            </h1>
            <p className="text-xs sm:text-sm text-[var(--sp-charcoal-slate)] leading-relaxed">
              Official selection trials standings, combined series points, and provisional team rosters for the{" "}
              <strong className="text-[var(--sp-harbour-shadow)]">2026 Asian &amp; Oceania Championship</strong> and{" "}
              <strong className="text-[var(--sp-harbour-shadow)]">Perth Training Camp</strong> are exclusive to registered members.
            </p>
          </div>

          {/* Action buttons */}
          <div className="relative flex flex-col sm:flex-row items-center justify-center gap-3 max-w-md mx-auto pt-2">
            <Link
              href="/login?next=%2Fsg%2Foptimist%2Fselection"
              className="w-full sm:w-auto sp-btn-primary text-xs font-black uppercase tracking-wider px-6 py-3.5 inline-flex items-center justify-center gap-2 min-h-[44px]"
            >
              Sign In to View Selection
            </Link>
            <Link
              href="/register?next=%2Fsg%2Foptimist%2Fselection"
              className="w-full sm:w-auto rounded-full bg-[var(--sp-sailcloth)] hover:bg-[var(--sp-aqua-mist)] active:scale-[0.98] transition-all text-xs font-bold text-[var(--sp-harbour-shadow)] px-6 py-3.5 border border-[var(--sp-cool-veil)] inline-flex items-center justify-center min-h-[44px]"
            >
              Create Free Account
            </Link>
          </div>

          {/* Feature Highlights Grid */}
          <div className="relative grid grid-cols-1 sm:grid-cols-2 gap-3 pt-4 border-t border-[var(--sp-cool-veil)] text-left">
            <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-4 space-y-1">
              <div className="flex items-center gap-2">
                <Trophy className="h-4 w-4 text-[var(--sp-racing-orange)] shrink-0" />
                <h2 className="text-xs font-bold text-[var(--sp-harbour-shadow)]">Asian &amp; Oceania 2026 Roster</h2>
              </div>
              <p className="text-[11px] text-[var(--sp-slate-soft)] leading-relaxed">
                Top 10 qualifying standings, gender quotas (min 3 per gender), and reserves.
              </p>
            </div>
            <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-4 space-y-1">
              <div className="flex items-center gap-2">
                <Users className="h-4 w-4 text-[var(--sp-harbour-teal)] shrink-0" />
                <h2 className="text-xs font-bold text-[var(--sp-harbour-shadow)]">Perth Training Camp Roster</h2>
              </div>
              <p className="text-[11px] text-[var(--sp-slate-soft)] leading-relaxed">
                Age bucket allocations for birth years 2013, 2014, and 2015.
              </p>
            </div>
            <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-4 space-y-1">
              <div className="flex items-center gap-2">
                <Award className="h-4 w-4 text-[var(--sp-racing-orange)] shrink-0" />
                <h2 className="text-xs font-bold text-[var(--sp-harbour-shadow)]">Combined Low-Point Matrices</h2>
              </div>
              <p className="text-[11px] text-[var(--sp-slate-soft)] leading-relaxed">
                Real-time race scores, automatic discard formulas, and tie-break rules.
              </p>
            </div>
            <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-4 space-y-1">
              <div className="flex items-center gap-2">
                <Compass className="h-4 w-4 text-emerald-600 shrink-0" />
                <h2 className="text-xs font-bold text-[var(--sp-harbour-shadow)]">Athlete Cushion Buffers</h2>
              </div>
              <p className="text-[11px] text-[var(--sp-slate-soft)] leading-relaxed">
                Claimed athlete spotlight with exact point cushions to qualification cutoffs.
              </p>
            </div>
          </div>

          <p className="text-[11px] text-[var(--sp-slate-soft)]">
            Free access for Singapore sailors, sailing parents, and registered coaches.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto w-full max-w-7xl px-3 sm:px-6 lg:px-8 py-6 sm:py-10 space-y-6">
      {/* ── Header ── */}
      <div className="space-y-2">
        <div className="inline-flex items-center gap-2 rounded-full border border-[var(--sp-racing-orange)]/30 bg-[var(--sp-racing-mist)]/30 px-3 py-1 text-xs font-bold text-[var(--sp-racing-orange)]">
          <Trophy className="h-3.5 w-3.5" />
          <span>2026 Selection Campaigns</span>
        </div>
        <div className="flex flex-col md:flex-row md:items-end justify-between gap-4">
          <div>
            <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
              Optimist Selection Trials
            </h1>
            <p className="text-xs sm:text-sm text-[var(--sp-slate-soft)] mt-1 max-w-2xl leading-relaxed">
              Combined race score series across official Singapore trials for
              the 2026 Asian &amp; Oceania Championship and Perth Training Camp.
            </p>
          </div>
          <div className="flex items-center gap-2 text-xs">
            <Link
              href="/sg/optimist/gold"
              className="inline-flex items-center gap-1.5 rounded-lg border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-3 py-1.5 font-semibold text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)] shadow-xs transition-colors"
            >
              <Compass className="h-3.5 w-3.5 text-[var(--sp-racing-orange)]" />
              Gold Standings
            </Link>
          </div>
        </div>
      </div>

      {/* ── Selection Events Status ── */}
      <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 sm:p-5 space-y-3 shadow-xs">
        <div className="flex flex-wrap items-center justify-between gap-2">
          <p className="text-[11px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">
            Selection Series Progress
          </p>
          <span className="text-[11px] font-semibold text-[var(--sp-slate-soft)]">
            {selectionStatus.usableRaceCount} usable races · {selectionStatus.discardCount} discard
            {selectionStatus.discardCount === 1 ? "" : "s"}
          </span>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5">
          {matched.map((ev, idx) => {
            const hasRegatta = Boolean(ev.regatta);
            return (
              <div
                key={ev.def.id}
                className={`rounded-xl border p-3 flex items-start gap-3 transition-all ${
                  hasRegatta
                    ? "border-emerald-500/30 bg-emerald-50/50"
                    : "border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]"
                }`}
              >
                <span
                  className={`mt-0.5 flex h-6 w-6 shrink-0 items-center justify-center rounded-full text-xs font-black ${
                    hasRegatta
                      ? "bg-emerald-100 text-emerald-800"
                      : "bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] text-[var(--sp-slate-soft)]"
                  }`}
                >
                  {idx + 1}
                </span>
                <div className="min-w-0 flex-1">
                  <div className="flex items-center justify-between gap-2">
                    <p className="text-xs font-bold text-[var(--sp-harbour-shadow)] truncate">
                      {ev.def.label}
                    </p>
                    <span
                      className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${
                        hasRegatta
                          ? "bg-emerald-100 text-emerald-800 border border-emerald-300"
                          : "bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] text-[var(--sp-slate-soft)]"
                      }`}
                    >
                      {hasRegatta ? "Scored" : "Scheduled"}
                    </span>
                  </div>
                  <p className="text-[11px] text-[var(--sp-slate-soft)] mt-0.5 flex items-center gap-1.5">
                    <Calendar className="h-3 w-3 text-[var(--sp-slate-soft)]" />
                    <span>
                      {ev.def.dateFrom} to {ev.def.dateTo}
                    </span>
                  </p>
                  {ev.regatta && (
                    <p className="text-[11px] text-emerald-700 font-medium mt-1">
                      Matched: {ev.regatta.name} ({ev.regatta.totalFleetSize} sailors)
                    </p>
                  )}
                </div>
              </div>
            );
          })}
        </div>

        {selectionStatus.warnings.length > 0 && (
          <div className="rounded-lg border border-amber-500/30 bg-amber-50 p-2.5 flex items-center gap-2 text-xs text-amber-900">
            <AlertCircle className="h-4 w-4 shrink-0 text-amber-600" />
            <span>{selectionStatus.warnings.join(" ")}</span>
          </div>
        )}
      </div>

      {/* ── Claimed Sailor Spotlight Banner (Logged-In User) ── */}
      {mySailor && mySailorAsianRank && (
        <div className="rounded-2xl border border-[var(--sp-racing-orange)]/30 bg-[var(--sp-racing-mist)]/20 p-4 sm:p-5 flex flex-col sm:flex-row sm:items-center justify-between gap-4 shadow-xs">
          <div className="flex items-start gap-3 min-w-0">
            <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl font-black text-sm border bg-[var(--sp-racing-mist)]/40 text-[var(--sp-racing-orange)] border-[var(--sp-racing-orange)]/30">
              #{mySailorAsianRank.rank}
            </div>
            <div className="min-w-0">
              <div className="flex items-center gap-2 flex-wrap">
                <p className="text-sm font-bold text-[var(--sp-harbour-shadow)] leading-tight">
                  Your Claimed Sailor: {mySailor.name}
                </p>
                <span className="text-[10px] font-black px-2 py-0.5 rounded-full uppercase tracking-wider bg-[var(--sp-racing-mist)]/40 text-[var(--sp-racing-orange)] border border-[var(--sp-racing-orange)]/30">
                  Rank #{mySailorAsianRank.rank} of {combinedScores.length}
                </span>
              </div>
              <p className="text-xs text-[var(--sp-slate-soft)] mt-1">
                Combined Score:{" "}
                <span className="font-bold text-[var(--sp-harbour-shadow)] font-mono">
                  {mySailor.combinedScore} pts
                </span>
                {mySailorAsianRank.pointsToCutoff !== null && (
                  <span className="ml-2 font-medium text-[var(--sp-slate-soft)]">
                    {mySailorAsianRank.rank <= 10
                      ? `(+${mySailorAsianRank.pointsToCutoff} pts ahead of #11)`
                      : `(${mySailorAsianRank.pointsToCutoff} pts behind #10)`}
                  </span>
                )}
              </p>
            </div>
          </div>

          <div className="flex items-center gap-2 shrink-0">
            <button
              type="button"
              onClick={() => setSelectedSailorId(mySailor.sailorId)}
              className="rounded-lg border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-3 py-1.5 text-xs font-bold text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)] shadow-xs transition-colors"
            >
              View Race Breakdown
            </button>
          </div>
        </div>
      )}

      {/* ── Campaign Tabs & Controls ── */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-[var(--sp-cool-veil)] pb-3">
        <div className="flex items-center gap-1.5 bg-[var(--sp-sailcloth)] p-1 rounded-xl border border-[var(--sp-cool-veil)]">
          <button
            type="button"
            onClick={() => setActiveTab("asian")}
            className={`flex items-center gap-2 rounded-lg px-3 py-1.5 text-xs font-bold transition-colors ${
              activeTab === "asian"
                ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
            }`}
          >
            <Trophy className="h-3.5 w-3.5" />
            <span>Asian &amp; Oceania (Top 10)</span>
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("perth")}
            className={`flex items-center gap-2 rounded-lg px-3 py-1.5 text-xs font-bold transition-colors ${
              activeTab === "perth"
                ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
            }`}
          >
            <Award className="h-3.5 w-3.5" />
            <span>Perth Camp (Age Buckets)</span>
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("combined")}
            className={`flex items-center gap-2 rounded-lg px-3 py-1.5 text-xs font-bold transition-colors ${
              activeTab === "combined"
                ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
            }`}
          >
            <Users className="h-3.5 w-3.5" />
            <span>Full Scoreboard ({combinedScores.length})</span>
          </button>
        </div>

        <div className="flex items-center gap-2 flex-wrap">
          {/* Gender Filter */}
          <div className="flex items-center rounded-lg border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-0.5 text-xs">
            <button
              type="button"
              onClick={() => setGenderFilter("all")}
              className={`px-2.5 py-1 rounded-md font-semibold transition-colors ${
                genderFilter === "all" ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs" : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
              }`}
            >
              All
            </button>
            <button
              type="button"
              onClick={() => setGenderFilter("M")}
              className={`px-2.5 py-1 rounded-md font-semibold transition-colors ${
                genderFilter === "M" ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs" : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
              }`}
            >
              Boys
            </button>
            <button
              type="button"
              onClick={() => setGenderFilter("F")}
              className={`px-2.5 py-1 rounded-md font-semibold transition-colors ${
                genderFilter === "F" ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs" : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
              }`}
            >
              Girls
            </button>
          </div>

          {/* Perth Age Bucket Filter */}
          {activeTab === "perth" && (
            <select
              value={perthBucketFilter}
              onChange={(e) => setPerthBucketFilter(e.target.value)}
              className="sp-select text-xs py-1 px-2.5"
            >
              <option value="all">All Age Buckets</option>
              <option value="by2013">Born 2013 (Top boy &amp; girl)</option>
              <option value="by2014">Born 2014 (Top 3 boys &amp; girls)</option>
              <option value="by2015">Born 2015 (Top 2 boys &amp; girls)</option>
            </select>
          )}
        </div>
      </div>

      {/* ── TAB 1: Asian & Oceania Championship ── */}
      {activeTab === "asian" && (
        <div className="space-y-4">
          {/* Campaign Overview Card */}
          <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 sm:p-5 flex flex-col md:flex-row md:items-center justify-between gap-4 shadow-xs">
            <div className="space-y-1">
              <div className="flex items-center gap-2">
                <h2 className="text-sm font-bold text-[var(--sp-harbour-shadow)]">
                  {campaigns.asianOceania.title}
                </h2>
                <span className="rounded-full bg-[var(--sp-aqua-mist)] border border-[var(--sp-harbour-teal)]/30 px-2 py-0.5 text-[10px] font-bold text-[var(--sp-harbour-teal)]">
                  Key Event Funding
                </span>
              </div>
              <p className="text-xs text-[var(--sp-slate-soft)] flex items-center gap-2">
                <MapPin className="h-3 w-3 text-[var(--sp-slate-soft)]" />
                <span>{campaigns.asianOceania.subtitle}</span>
              </p>
              <p className="text-xs text-[var(--sp-slate-soft)] pt-1">
                {campaigns.asianOceania.notes}
              </p>
            </div>

            {cutoffBuffer !== null && (
              <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-3 text-xs space-y-1 sm:text-right shrink-0">
                <p className="text-[var(--sp-slate-soft)]">Cutoff margin (#10 vs #11)</p>
                <p className="font-bold text-[var(--sp-harbour-shadow)] font-mono text-sm">
                  {cutoffBuffer} pts
                </p>
              </div>
            )}
          </div>

          {/* Team Table */}
          <div className="rounded-2xl border border-[var(--sp-cool-veil)] overflow-hidden bg-[var(--sp-warm-white)] shadow-xs">
            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs border-collapse">
                <thead className="bg-[var(--sp-sailcloth)] text-[10px] text-[var(--sp-slate-soft)] uppercase tracking-wider">
                  <tr>
                    <th className="px-4 py-3 w-12">Slot</th>
                    <th className="px-4 py-3 min-w-[10rem]">Sailor</th>
                    <th className="px-3 py-3 text-center">Gender</th>
                    <th className="px-3 py-3 text-center">Birth Year</th>
                    <th className="px-3 py-3 text-center">Events</th>
                    <th className="px-3 py-3 text-right">Gross</th>
                    <th className="px-3 py-3 text-right">Nett (Best)</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-[var(--sp-cool-veil)]">
                  {displayAsianRows.map((sailor, idx) => {
                    const isQualifying = idx < 10;
                    const isMyAthlete = mySailor?.sailorId === sailor.sailorId;

                    // Hide rows past 5 for unauthenticated visitors
                    if (!isLoggedIn && idx >= 5) {
                      if (idx === 5) {
                        return (
                          <tr key="gate-row" className="bg-[var(--sp-sailcloth)]/50">
                            <td colSpan={7} className="px-4 py-8 text-center">
                              <div className="max-w-md mx-auto space-y-2">
                                <Lock className="h-5 w-5 text-[var(--sp-racing-orange)] mx-auto" />
                                <p className="text-xs font-bold text-[var(--sp-harbour-shadow)]">
                                  Sign in to view remaining {displayAsianRows.length - 5} competitors and live reserves
                                </p>
                                <p className="text-[11px] text-[var(--sp-slate-soft)]">
                                  Full rosters, discard calculations, and simulator access are available for free registered accounts.
                                </p>
                                <Link
                                  href="/register?next=%2Fsg%2Foptimist%2Fselection"
                                  className="inline-block sp-btn-primary px-4 py-1.5 text-xs font-bold"
                                >
                                  Unlock full selection roster
                                </Link>
                              </div>
                            </td>
                          </tr>
                        );
                      }
                      return null;
                    }

                    return (
                      <Fragment key={sailor.sailorId}>
                        {idx === 10 && (
                          <tr key="cutoff-divider" className="bg-rose-50 border-y border-rose-300">
                            <td colSpan={7} className="px-4 py-2 text-center text-[10px] font-black tracking-wider text-rose-700 uppercase">
                              ═══ Qualifying Cutoff Line (Top 10 Slots) ═══
                            </td>
                          </tr>
                        )}
                        <tr
                          key={sailor.sailorId}
                          onClick={() =>
                            setSelectedSailorId((id) =>
                              id === sailor.sailorId ? null : sailor.sailorId
                            )
                          }
                          className={`hover:bg-[var(--sp-sailcloth)] transition-colors cursor-pointer ${
                            isMyAthlete
                              ? "bg-[var(--sp-racing-mist)]/20 font-semibold"
                              : isQualifying
                                ? "bg-[var(--sp-aqua-mist)]/10"
                                : ""
                          }`}
                        >
                          <td className="px-4 py-3 font-mono font-bold text-[var(--sp-slate-soft)]">
                            #{idx + 1}
                          </td>
                          <td className="px-4 py-3">
                            <div className="flex items-center gap-2">
                              <span className="font-bold text-[var(--sp-harbour-shadow)]">
                                {sailor.name}
                              </span>
                              {isMyAthlete && (
                                <span className="rounded bg-[var(--sp-racing-mist)]/40 text-[var(--sp-racing-orange)] text-[9px] font-black px-1.5 py-0.5 border border-[var(--sp-racing-orange)]/30">
                                  YOU
                                </span>
                              )}
                            </div>
                            {sailor.handle && (
                              <p className="text-[10px] text-[var(--sp-slate-soft)]">
                                @{sailor.handle}
                              </p>
                            )}
                          </td>
                          <td className="px-3 py-3 text-center">
                            <span
                              className={`text-[10px] font-bold px-1.5 py-0.5 rounded ${
                                sailor.gender === "F"
                                  ? "bg-pink-100 text-pink-700"
                                  : "bg-blue-100 text-blue-700"
                              }`}
                            >
                              {sailor.gender || "—"}
                            </span>
                          </td>
                          <td className="px-3 py-3 text-center font-mono text-[var(--sp-slate-soft)]">
                            {sailor.birthYear || "—"}
                          </td>
                          <td className="px-3 py-3 text-center font-mono text-[var(--sp-slate-soft)]">
                            {sailor.eventsSailed}
                          </td>
                          <td className="px-3 py-3 text-right font-mono text-[var(--sp-slate-soft)]">
                            {sailor.grossScore}
                          </td>
                          <td className="px-3 py-3 text-right font-mono font-black text-sm text-[var(--sp-harbour-shadow)]">
                            {sailor.combinedScore}
                          </td>
                        </tr>

                        {/* Expanded race breakdown row */}
                        {selectedSailorId === sailor.sailorId && (
                          <tr
                            key={`${sailor.sailorId}-expanded`}
                            className="bg-[var(--sp-sailcloth)] border-t border-b border-[var(--sp-cool-veil)]"
                          >
                            <td colSpan={7} className="px-4 py-3 space-y-2">
                              <p className="text-[11px] font-bold text-[var(--sp-harbour-shadow)]">
                                {sailor.name} · Complete Race Breakdown:
                              </p>
                              <div className="flex flex-wrap gap-1.5">
                                {sailor.raceScores.map((race, rIdx) => {
                                  return (
                                    <div
                                      key={rIdx}
                                      className={`rounded border px-2 py-1 text-center font-mono text-xs ${
                                        race.discarded
                                          ? "bg-[var(--sp-warm-white)] border-[var(--sp-cool-veil)] text-[var(--sp-slate-soft)] line-through opacity-60"
                                          : race.score <= 3
                                            ? "bg-amber-100 border-amber-300 text-amber-800 font-bold"
                                            : "bg-[var(--sp-warm-white)] border-[var(--sp-cool-veil)] text-[var(--sp-harbour-shadow)]"
                                      }`}
                                      title={
                                        race.discarded
                                          ? `Race ${race.raceNumber}: ${race.score} (Discarded)`
                                          : `Race ${race.raceNumber}: ${race.score}`
                                      }
                                    >
                                      <span className="block text-[8px] text-[var(--sp-slate-soft)] no-underline">
                                        R{rIdx + 1}
                                      </span>
                                      <span>
                                        {race.nonDiscardable ? `${race.score} DNE` : race.score}
                                      </span>
                                    </div>
                                  );
                                })}
                              </div>
                            </td>
                          </tr>
                        )}
                      </Fragment>
                    );
                  })}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      )}

      {/* ── TAB 2: Perth Training Camp ── */}
      {activeTab === "perth" && (
        <div className="space-y-4">
          <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 sm:p-5 flex flex-col md:flex-row md:items-center justify-between gap-4 shadow-xs">
            <div className="space-y-1">
              <div className="flex items-center gap-2">
                <h2 className="text-sm font-bold text-[var(--sp-harbour-shadow)]">
                  {campaigns.perthCamp.title}
                </h2>
                <span className="rounded-full bg-purple-100 border border-purple-300 px-2 py-0.5 text-[10px] font-bold text-purple-800">
                  {campaigns.perthCamp.funding}
                </span>
              </div>
              <p className="text-xs text-[var(--sp-slate-soft)] flex items-center gap-2">
                <MapPin className="h-3 w-3 text-[var(--sp-slate-soft)]" />
                <span>{campaigns.perthCamp.subtitle}</span>
              </p>
              <p className="text-xs text-[var(--sp-slate-soft)] pt-1">
                {campaigns.perthCamp.notes}
              </p>
            </div>

            <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-3 text-xs space-y-1 sm:text-right shrink-0">
              <p className="text-[var(--sp-slate-soft)]">Picks Filled</p>
              <p className="font-bold text-purple-800">
                {perthCamp.picks.length} Athletes Nominated
              </p>
              {perthCamp.notes.map((note, i) => (
                <p key={i} className="text-[11px] text-[var(--sp-slate-soft)]">
                  {note}
                </p>
              ))}
            </div>
          </div>

          {/* Perth Picks Table */}
          <div className="rounded-2xl border border-[var(--sp-cool-veil)] overflow-hidden bg-[var(--sp-warm-white)] shadow-xs">
            <table className="w-full text-left text-xs border-collapse">
              <thead className="bg-[var(--sp-sailcloth)] text-[10px] text-[var(--sp-slate-soft)] uppercase tracking-wider">
                <tr>
                  <th className="px-4 py-3">Slot Designation</th>
                  <th className="px-4 py-3 min-w-[10rem]">Sailor</th>
                  <th className="px-3 py-3 text-center">Gender</th>
                  <th className="px-3 py-3 text-center">Birth Year</th>
                  <th className="px-3 py-3 text-right">Combined Score</th>
                  <th className="px-4 py-3">Category Group</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[var(--sp-cool-veil)]">
                {displayPerthRows.map((pick) => (
                  <tr key={pick.sailorId} className="hover:bg-[var(--sp-sailcloth)] transition-colors">
                    <td className="px-4 py-3 font-bold text-purple-800">
                      {pick.slot}
                    </td>
                    <td className="px-4 py-3 font-bold text-[var(--sp-harbour-shadow)]">
                      {pick.name}
                    </td>
                    <td className="px-3 py-3 text-center">
                      <span
                        className={`text-[10px] font-bold px-1.5 py-0.5 rounded ${
                          pick.gender === "F"
                            ? "bg-pink-100 text-pink-700"
                            : "bg-blue-100 text-blue-700"
                        }`}
                      >
                        {pick.gender}
                      </span>
                    </td>
                    <td className="px-3 py-3 text-center font-mono text-[var(--sp-slate-soft)]">
                      {pick.birthYear}
                    </td>
                    <td className="px-3 py-3 text-right font-mono font-black text-sm text-[var(--sp-harbour-shadow)]">
                      {pick.combinedScore}
                    </td>
                    <td className="px-4 py-3 text-[var(--sp-slate-soft)]">
                      {pick.bucketLabel}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* ── TAB 3: Combined Full Scoreboard ── */}
      {activeTab === "combined" && (
        <div className="space-y-4">
          <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-3 flex items-center justify-between gap-2 text-xs text-[var(--sp-slate-soft)] shadow-xs">
            <span>
              Low point combined series score (Appendix A). Absent events scored as fleet size + 1.
            </span>
            <span className="font-mono text-[var(--sp-charcoal-slate)] font-semibold">
              {combinedScores.length} competitors registered
            </span>
          </div>

          <div className="rounded-2xl border border-[var(--sp-cool-veil)] overflow-hidden bg-[var(--sp-warm-white)] shadow-xs">
            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs border-collapse">
                <thead className="bg-[var(--sp-sailcloth)] text-[10px] text-[var(--sp-slate-soft)] uppercase tracking-wider">
                  <tr>
                    <th className="px-4 py-3 w-12">#</th>
                    <th className="px-4 py-3 min-w-[10rem]">Sailor</th>
                    <th className="px-3 py-3 text-center">Gender</th>
                    <th className="px-3 py-3 text-center">Birth Year</th>
                    <th className="px-3 py-3 text-right">Gross</th>
                    <th className="px-3 py-3 text-right">Nett</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-[var(--sp-cool-veil)]">
                  {combinedScores.map((s, idx) => (
                    <tr key={s.sailorId} className="hover:bg-[var(--sp-sailcloth)] transition-colors">
                      <td className="px-4 py-2.5 font-mono text-[var(--sp-slate-soft)]">
                        #{idx + 1}
                      </td>
                      <td className="px-4 py-2.5 font-bold text-[var(--sp-harbour-shadow)]">
                        {s.name}
                      </td>
                      <td className="px-3 py-2.5 text-center text-[var(--sp-slate-soft)]">
                        {s.gender || "—"}
                      </td>
                      <td className="px-3 py-2.5 text-center font-mono text-[var(--sp-slate-soft)]">
                        {s.birthYear || "—"}
                      </td>
                      <td className="px-3 py-2.5 text-right font-mono text-[var(--sp-slate-soft)]">
                        {s.grossScore}
                      </td>
                      <td className="px-3 py-2.5 text-right font-mono font-bold text-[var(--sp-harbour-shadow)]">
                        {s.combinedScore}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
