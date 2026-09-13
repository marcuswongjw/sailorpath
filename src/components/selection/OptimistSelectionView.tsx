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
  CheckCircle2,
  Calendar,
  MapPin,
  Sliders,
  RotateCcw,
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

  // What-if simulated adjustments: Map of sailorId -> bonus adjustment points
  const [whatIfOffsets, setWhatIfOffsets] = useState<Record<string, number>>({});
  const [whatIfOpen, setWhatIfOpen] = useState(false);

  const {
    matched,
    selectionStatus,
    combinedScores,
    asianTeam,
    perthCamp,
    campaigns,
  } = initialData;

  // Claimed athlete detection
  const mySailor = useMemo(() => {
    if (!isLoggedIn || owned.length === 0) return null;
    const ownedIds = new Set(owned.map((o) => o.id));
    return combinedScores.find((s) => ownedIds.has(s.sailorId)) || null;
  }, [isLoggedIn, owned, combinedScores]);

  // Combined scores sorted with any active What-If adjustments applied
  const simulatedScores = useMemo(() => {
    if (Object.keys(whatIfOffsets).length === 0) return combinedScores;
    const copy = combinedScores.map((row) => {
      const offset = whatIfOffsets[row.sailorId] || 0;
      return {
        ...row,
        combinedScore: row.combinedScore + offset,
      };
    });
    return copy.sort((a, b) => a.combinedScore - b.combinedScore);
  }, [combinedScores, whatIfOffsets]);

  // Filtered rows for Asian / Combined
  const displayAsianRows = useMemo(() => {
    let rows = simulatedScores;
    if (genderFilter !== "all") {
      rows = rows.filter((r) => r.gender === genderFilter);
    }
    return rows;
  }, [simulatedScores, genderFilter]);

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

  return (
    <div className="mx-auto w-full max-w-7xl px-3 sm:px-6 lg:px-8 py-6 sm:py-10 space-y-6">
      {/* ── Header ── */}
      <div className="space-y-2">
        <div className="inline-flex items-center gap-2 rounded-full border border-orange-500/30 bg-orange-500/10 px-3 py-1 text-xs font-bold text-orange-400">
          <Trophy className="h-3.5 w-3.5" />
          <span>2026 Selection Campaigns</span>
        </div>
        <div className="flex flex-col md:flex-row md:items-end justify-between gap-4">
          <div>
            <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
              Optimist Selection Trials
            </h1>
            <p className="text-xs sm:text-sm text-slate-400 mt-1 max-w-2xl leading-relaxed">
              Combined race score series across official Singapore trials for
              the 2026 Asian & Oceania Championship and Perth Training Camp.
            </p>
          </div>
          <div className="flex items-center gap-2 text-xs">
            <Link
              href="/sg/optimist/gold"
              className="inline-flex items-center gap-1.5 rounded-lg border border-white/10 bg-white/5 px-3 py-1.5 font-semibold text-slate-300 hover:text-white hover:bg-white/10"
            >
              <Compass className="h-3.5 w-3.5 text-orange-400" />
              Gold Standings
            </Link>
          </div>
        </div>
      </div>

      {/* ── Selection Events Status ── */}
      <div className="rounded-xl border border-white/10 bg-[#0c0d14] p-3.5 sm:p-4 space-y-3">
        <div className="flex flex-wrap items-center justify-between gap-2">
          <p className="text-[11px] font-bold text-slate-400 uppercase tracking-wider">
            Selection Series Progress
          </p>
          <span className="text-[11px] font-semibold text-slate-400">
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
                className={`rounded-lg border p-3 flex items-start gap-3 transition-all ${
                  hasRegatta
                    ? "border-emerald-500/25 bg-emerald-500/5"
                    : "border-white/5 bg-white/[0.02]"
                }`}
              >
                <span
                  className={`mt-0.5 flex h-6 w-6 shrink-0 items-center justify-center rounded-full text-xs font-black ${
                    hasRegatta
                      ? "bg-emerald-500/20 text-emerald-400"
                      : "bg-slate-800 text-slate-500"
                  }`}
                >
                  {idx + 1}
                </span>
                <div className="min-w-0 flex-1">
                  <div className="flex items-center justify-between gap-2">
                    <p className="text-xs font-bold text-white truncate">
                      {ev.def.label}
                    </p>
                    <span
                      className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${
                        hasRegatta
                          ? "bg-emerald-500/20 text-emerald-300"
                          : "bg-slate-800 text-slate-400"
                      }`}
                    >
                      {hasRegatta ? "Scored" : "Scheduled"}
                    </span>
                  </div>
                  <p className="text-[11px] text-slate-400 mt-0.5 flex items-center gap-1.5">
                    <Calendar className="h-3 w-3 text-slate-500" />
                    <span>
                      {ev.def.dateFrom} to {ev.def.dateTo}
                    </span>
                  </p>
                  {ev.regatta && (
                    <p className="text-[11px] text-emerald-400/90 font-medium mt-1">
                      Matched: {ev.regatta.name} ({ev.regatta.totalFleetSize} sailors)
                    </p>
                  )}
                </div>
              </div>
            );
          })}
        </div>

        {selectionStatus.warnings.length > 0 && (
          <div className="rounded-lg border border-amber-500/20 bg-amber-500/5 p-2.5 flex items-center gap-2 text-xs text-amber-300">
            <AlertCircle className="h-4 w-4 shrink-0 text-amber-400" />
            <span>{selectionStatus.warnings.join(" ")}</span>
          </div>
        )}
      </div>

      {/* ── Claimed Sailor Spotlight Banner (Logged-In User) ── */}
      {mySailor && mySailorAsianRank && (
        <div
          className={`rounded-xl border p-4 sm:p-5 flex flex-col sm:flex-row sm:items-center justify-between gap-4 ${
            mySailorAsianRank.isSafe
              ? "border-emerald-500/30 bg-emerald-500/10"
              : mySailorAsianRank.isBubble
                ? "border-amber-500/30 bg-amber-500/10"
                : "border-slate-700 bg-slate-800/40"
          }`}
        >
          <div className="flex items-start gap-3 min-w-0">
            <div
              className={`flex h-10 w-10 shrink-0 items-center justify-center rounded-xl font-black text-sm border ${
                mySailorAsianRank.isSafe
                  ? "bg-emerald-500/20 text-emerald-300 border-emerald-500/30"
                  : mySailorAsianRank.isBubble
                    ? "bg-amber-500/20 text-amber-300 border-amber-500/30"
                    : "bg-slate-800 text-slate-400 border-slate-700"
              }`}
            >
              #{mySailorAsianRank.rank}
            </div>
            <div className="min-w-0">
              <div className="flex items-center gap-2 flex-wrap">
                <p className="text-sm font-bold text-white leading-tight">
                  Your Claimed Sailor: {mySailor.name}
                </p>
                <span
                  className={`text-[10px] font-black px-2 py-0.5 rounded-full uppercase tracking-wider ${
                    mySailorAsianRank.isSafe
                      ? "bg-emerald-500/20 text-emerald-300 border border-emerald-500/30"
                      : mySailorAsianRank.isBubble
                        ? "bg-amber-500/20 text-amber-300 border border-amber-500/30"
                        : "bg-slate-700 text-slate-300"
                  }`}
                >
                  {mySailorAsianRank.isSafe
                    ? "Safe Zone (Top 7)"
                    : mySailorAsianRank.isBubble
                      ? "Bubble Zone (Slots 8–10)"
                      : "Reserve Pool"}
                </span>
              </div>
              <p className="text-xs text-slate-300 mt-1">
                Combined Score:{" "}
                <span className="font-bold text-white font-mono">
                  {mySailor.combinedScore} pts
                </span>
                {mySailorAsianRank.pointsToCutoff !== null && (
                  <span className="ml-2 font-medium text-slate-400">
                    {mySailorAsianRank.rank <= 10
                      ? `(+${mySailorAsianRank.pointsToCutoff} pts buffer ahead of #11)`
                      : `(${mySailorAsianRank.pointsToCutoff} pts away from qualifying #10)`}
                  </span>
                )}
              </p>
            </div>
          </div>

          <div className="flex items-center gap-2 shrink-0">
            <button
              type="button"
              onClick={() => setSelectedSailorId(mySailor.sailorId)}
              className="rounded-lg border border-white/20 bg-white/10 px-3 py-1.5 text-xs font-bold text-white hover:bg-white/20"
            >
              View Race Breakdown
            </button>
          </div>
        </div>
      )}

      {/* ── Unauthenticated Visitors Gating Banner ── */}
      {accountReady && !isLoggedIn && (
        <div className="rounded-xl border border-orange-500/30 bg-orange-500/10 p-4 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div className="flex items-start gap-3">
            <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-orange-500/20 text-orange-400">
              <Lock className="h-4 w-4" />
            </span>
            <div>
              <p className="text-sm font-bold text-white">
                Detailed selection matrices & What-If calculator are for registered accounts
              </p>
              <p className="text-xs text-slate-400 mt-0.5">
                Create a free SailorPath account to view complete 10-person qualifying rosters,
                tie-breaks, individual race scores, and simulation tools.
              </p>
            </div>
          </div>
          <div className="flex items-center gap-2 shrink-0 pl-11 sm:pl-0">
            <Link
              href="/register?next=%2Fsg%2Foptimist%2Fselection"
              className="rounded-full bg-orange-600 px-4 py-1.5 text-xs font-bold text-white hover:bg-orange-500 transition-colors"
            >
              Create free account
            </Link>
            <Link
              href="/login?next=%2Fsg%2Foptimist%2Fselection"
              className="text-xs font-semibold text-slate-400 hover:text-white px-2"
            >
              Log in
            </Link>
          </div>
        </div>
      )}

      {/* ── Campaign Tabs & Controls ── */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-white/10 pb-3">
        <div className="flex items-center gap-1.5 bg-black/40 p-1 rounded-xl border border-white/5">
          <button
            type="button"
            onClick={() => setActiveTab("asian")}
            className={`flex items-center gap-2 rounded-lg px-3 py-1.5 text-xs font-bold transition-colors ${
              activeTab === "asian"
                ? "bg-orange-600 text-white shadow-sm"
                : "text-slate-400 hover:text-white"
            }`}
          >
            <Trophy className="h-3.5 w-3.5" />
            <span>Asian & Oceania (Top 10)</span>
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("perth")}
            className={`flex items-center gap-2 rounded-lg px-3 py-1.5 text-xs font-bold transition-colors ${
              activeTab === "perth"
                ? "bg-orange-600 text-white shadow-sm"
                : "text-slate-400 hover:text-white"
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
                ? "bg-orange-600 text-white shadow-sm"
                : "text-slate-400 hover:text-white"
            }`}
          >
            <Users className="h-3.5 w-3.5" />
            <span>Full Scoreboard ({combinedScores.length})</span>
          </button>
        </div>

        <div className="flex items-center gap-2 flex-wrap">
          {/* Gender Filter */}
          <div className="flex items-center rounded-lg border border-white/10 bg-white/5 p-0.5 text-xs">
            <button
              type="button"
              onClick={() => setGenderFilter("all")}
              className={`px-2.5 py-1 rounded-md font-semibold ${
                genderFilter === "all" ? "bg-white/10 text-white" : "text-slate-400 hover:text-white"
              }`}
            >
              All
            </button>
            <button
              type="button"
              onClick={() => setGenderFilter("M")}
              className={`px-2.5 py-1 rounded-md font-semibold ${
                genderFilter === "M" ? "bg-white/10 text-white" : "text-slate-400 hover:text-white"
              }`}
            >
              Boys
            </button>
            <button
              type="button"
              onClick={() => setGenderFilter("F")}
              className={`px-2.5 py-1 rounded-md font-semibold ${
                genderFilter === "F" ? "bg-white/10 text-white" : "text-slate-400 hover:text-white"
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
              className="rounded-lg border border-white/10 bg-black/40 px-2.5 py-1 text-xs font-semibold text-slate-200"
            >
              <option value="all">All Age Buckets</option>
              <option value="by2013">Born 2013 (Top boy & girl)</option>
              <option value="by2014">Born 2014 (Top 3 boys & girls)</option>
              <option value="by2015">Born 2015 (Top 2 boys & girls)</option>
            </select>
          )}

          {/* What-If Toggle */}
          {isLoggedIn && (
            <button
              type="button"
              onClick={() => setWhatIfOpen((o) => !o)}
              className={`inline-flex items-center gap-1.5 rounded-lg border px-2.5 py-1 text-xs font-bold transition-all ${
                whatIfOpen || Object.keys(whatIfOffsets).length > 0
                  ? "border-amber-500/40 bg-amber-500/10 text-amber-300"
                  : "border-white/10 bg-white/5 text-slate-300 hover:text-white"
              }`}
            >
              <Sliders className="h-3.5 w-3.5" />
              <span>What-If Simulator</span>
              {Object.keys(whatIfOffsets).length > 0 && (
                <span className="rounded-full bg-amber-500/20 px-1.5 text-[10px] font-black">
                  {Object.keys(whatIfOffsets).length}
                </span>
              )}
            </button>
          )}
        </div>
      </div>

      {/* ── What-If Simulator Drawer ── */}
      {whatIfOpen && (
        <div className="rounded-xl border border-amber-500/30 bg-amber-500/5 p-4 space-y-3">
          <div className="flex items-center justify-between gap-2">
            <div className="flex items-center gap-2">
              <Sliders className="h-4 w-4 text-amber-400" />
              <p className="text-xs font-bold text-white">
                Hypothetical Finish Simulator
              </p>
            </div>
            {Object.keys(whatIfOffsets).length > 0 && (
              <button
                type="button"
                onClick={() => setWhatIfOffsets({})}
                className="inline-flex items-center gap-1 text-[11px] font-bold text-amber-300 hover:text-amber-200"
              >
                <RotateCcw className="h-3 w-3" />
                Reset all adjustments
              </button>
            )}
          </div>
          <p className="text-xs text-slate-400 leading-relaxed">
            Adjust hypothetical points for upcoming trial races to see how the
            cut-off line and qualifying team order would shift.
          </p>
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-2.5 pt-1">
            {combinedScores.slice(0, 15).map((sailor) => {
              const currentOffset = whatIfOffsets[sailor.sailorId] || 0;
              return (
                <div
                  key={sailor.sailorId}
                  className="rounded-lg border border-white/5 bg-black/30 p-2.5 flex items-center justify-between gap-2"
                >
                  <div className="min-w-0">
                    <p className="text-xs font-bold text-white truncate">
                      {sailor.name}
                    </p>
                    <p className="text-[10px] text-slate-400">
                      Actual: {sailor.combinedScore} pts · Simulated:{" "}
                      <span className="font-bold text-amber-300">
                        {sailor.combinedScore + currentOffset} pts
                      </span>
                    </p>
                  </div>
                  <div className="flex items-center gap-1 shrink-0">
                    <button
                      type="button"
                      onClick={() =>
                        setWhatIfOffsets((prev) => ({
                          ...prev,
                          [sailor.sailorId]: currentOffset - 2,
                        }))
                      }
                      className="h-6 w-6 rounded bg-white/10 text-white hover:bg-white/20 text-xs font-black flex items-center justify-center"
                      title="Simulate 2 points better"
                    >
                      -
                    </button>
                    <span className="w-8 text-center text-xs font-mono font-bold text-white">
                      {currentOffset > 0 ? `+${currentOffset}` : currentOffset}
                    </span>
                    <button
                      type="button"
                      onClick={() =>
                        setWhatIfOffsets((prev) => ({
                          ...prev,
                          [sailor.sailorId]: currentOffset + 2,
                        }))
                      }
                      className="h-6 w-6 rounded bg-white/10 text-white hover:bg-white/20 text-xs font-black flex items-center justify-center"
                      title="Simulate 2 points worse"
                    >
                      +
                    </button>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      )}

      {/* ── TAB 1: Asian & Oceania Championship ── */}
      {activeTab === "asian" && (
        <div className="space-y-4">
          {/* Campaign Overview Card */}
          <div className="rounded-xl border border-white/10 bg-[#0c0d14] p-4 flex flex-col md:flex-row md:items-center justify-between gap-4">
            <div className="space-y-1">
              <div className="flex items-center gap-2">
                <h2 className="text-sm font-bold text-white">
                  {campaigns.asianOceania.title}
                </h2>
                <span className="rounded-full bg-sky-500/20 border border-sky-500/30 px-2 py-0.5 text-[10px] font-bold text-sky-300">
                  Key Event Funding
                </span>
              </div>
              <p className="text-xs text-slate-400 flex items-center gap-2">
                <MapPin className="h-3 w-3 text-slate-500" />
                <span>{campaigns.asianOceania.subtitle}</span>
              </p>
              <p className="text-xs text-slate-400 pt-1">
                {campaigns.asianOceania.notes}
              </p>
            </div>

            <div className="rounded-lg border border-white/5 bg-white/[0.02] p-3 text-xs space-y-1 sm:text-right shrink-0">
              <p className="text-slate-400">Team Status Policy</p>
              <p className="font-bold text-emerald-400">
                {asianTeam.reason}
              </p>
              {cutoffBuffer !== null && (
                <p className="text-[11px] text-slate-400">
                  Cutoff margin (#10 vs #11):{" "}
                  <span className="font-bold text-white font-mono">
                    {cutoffBuffer} pts
                  </span>
                </p>
              )}
            </div>
          </div>

          {/* Team Table */}
          <div className="rounded-2xl border border-white/10 overflow-hidden bg-[#0c0d14]">
            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs border-collapse">
                <thead className="bg-white/5 text-[10px] text-slate-400 uppercase tracking-wider">
                  <tr>
                    <th className="px-4 py-3 w-12">Slot</th>
                    <th className="px-4 py-3 min-w-[10rem]">Sailor</th>
                    <th className="px-3 py-3 text-center">Gender</th>
                    <th className="px-3 py-3 text-center">Birth Year</th>
                    <th className="px-3 py-3 text-center">Events</th>
                    <th className="px-3 py-3 text-right">Gross</th>
                    <th className="px-3 py-3 text-right">Nett (Best)</th>
                    <th className="px-4 py-3">Selection Status</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-white/5">
                  {displayAsianRows.map((sailor, idx) => {
                    const isQualifying = idx < 10;
                    const isSafe = idx < 7;
                    const isBubble = idx >= 7 && idx < 10;
                    const isMyAthlete = mySailor?.sailorId === sailor.sailorId;

                    // Hide rows past 5 for unauthenticated visitors
                    if (!isLoggedIn && idx >= 5) {
                      if (idx === 5) {
                        return (
                          <tr key="gate-row" className="bg-white/[0.01]">
                            <td colSpan={8} className="px-4 py-8 text-center">
                              <div className="max-w-md mx-auto space-y-2">
                                <Lock className="h-5 w-5 text-orange-400 mx-auto" />
                                <p className="text-xs font-bold text-white">
                                  Sign in to view remaining {displayAsianRows.length - 5} competitors and live reserves
                                </p>
                                <p className="text-[11px] text-slate-400">
                                  Full rosters, discard calculations, and simulator access are available for free registered accounts.
                                </p>
                                <Link
                                  href="/register?next=%2Fsg%2Foptimist%2Fselection"
                                  className="inline-block rounded-full bg-orange-600 px-4 py-1.5 text-xs font-bold text-white hover:bg-orange-500"
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
                          <tr key="cutoff-divider" className="bg-rose-500/10 border-y border-rose-500/30">
                            <td colSpan={8} className="px-4 py-2 text-center text-[10px] font-black tracking-wider text-rose-300 uppercase">
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
                          className={`hover:bg-white/[0.03] transition-colors cursor-pointer ${
                            isMyAthlete
                              ? "bg-orange-500/10 font-semibold"
                              : isQualifying
                                ? isSafe
                                  ? "bg-emerald-500/[0.02]"
                                  : "bg-amber-500/[0.02]"
                                : ""
                          }`}
                        >
                          <td className="px-4 py-3 font-mono font-bold text-slate-400">
                            #{idx + 1}
                          </td>
                          <td className="px-4 py-3">
                            <div className="flex items-center gap-2">
                              <span className="font-bold text-white">
                                {sailor.name}
                              </span>
                              {isMyAthlete && (
                                <span className="rounded bg-orange-500/20 text-orange-300 text-[9px] font-black px-1.5 py-0.5 border border-orange-500/30">
                                  YOU
                                </span>
                              )}
                            </div>
                            {sailor.handle && (
                              <p className="text-[10px] text-slate-500">
                                @{sailor.handle}
                              </p>
                            )}
                          </td>
                          <td className="px-3 py-3 text-center">
                            <span
                              className={`text-[10px] font-bold px-1.5 py-0.5 rounded ${
                                sailor.gender === "F"
                                  ? "bg-pink-500/15 text-pink-300"
                                  : "bg-blue-500/15 text-blue-300"
                              }`}
                            >
                              {sailor.gender || "—"}
                            </span>
                          </td>
                          <td className="px-3 py-3 text-center font-mono text-slate-400">
                            {sailor.birthYear || "—"}
                          </td>
                          <td className="px-3 py-3 text-center font-mono text-slate-400">
                            {sailor.eventsSailed}
                          </td>
                          <td className="px-3 py-3 text-right font-mono text-slate-500">
                            {sailor.grossScore}
                          </td>
                          <td className="px-3 py-3 text-right font-mono font-black text-sm text-white">
                            {sailor.combinedScore}
                          </td>
                          <td className="px-4 py-3">
                            {isSafe ? (
                              <span className="inline-flex items-center gap-1 text-[10px] font-bold text-emerald-400">
                                <CheckCircle2 className="h-3 w-3" />
                                Safe Zone
                              </span>
                            ) : isBubble ? (
                              <span className="inline-flex items-center gap-1 text-[10px] font-bold text-amber-400">
                                <AlertCircle className="h-3 w-3" />
                                Bubble Zone
                              </span>
                            ) : (
                              <span className="text-[10px] font-bold text-slate-500">
                                Reserve #{idx - 9}
                              </span>
                            )}
                          </td>
                        </tr>

                        {/* Expanded race breakdown row */}
                        {selectedSailorId === sailor.sailorId && (
                          <tr
                            key={`${sailor.sailorId}-expanded`}
                            className="bg-black/50 border-t border-b border-white/10"
                          >
                            <td colSpan={8} className="px-4 py-3 space-y-2">
                              <p className="text-[11px] font-bold text-slate-300">
                                {sailor.name} · Complete Race Breakdown:
                              </p>
                              <div className="flex flex-wrap gap-1.5">
                                {sailor.raceScores.map((race, rIdx) => {
                                  return (
                                    <div
                                      key={rIdx}
                                      className={`rounded border px-2 py-1 text-center font-mono text-xs ${
                                        race.discarded
                                          ? "bg-slate-900 border-slate-700 text-slate-500 line-through opacity-60"
                                          : race.score <= 3
                                            ? "bg-amber-500/20 border-amber-500/40 text-amber-300 font-bold"
                                            : "bg-white/5 border-white/10 text-white"
                                      }`}
                                      title={
                                        race.discarded
                                          ? `Race ${race.raceNumber}: ${race.score} (Discarded)`
                                          : `Race ${race.raceNumber}: ${race.score}`
                                      }
                                    >
                                      <span className="block text-[8px] text-slate-500 no-underline">
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
          <div className="rounded-xl border border-white/10 bg-[#0c0d14] p-4 flex flex-col md:flex-row md:items-center justify-between gap-4">
            <div className="space-y-1">
              <div className="flex items-center gap-2">
                <h2 className="text-sm font-bold text-white">
                  {campaigns.perthCamp.title}
                </h2>
                <span className="rounded-full bg-purple-500/20 border border-purple-500/30 px-2 py-0.5 text-[10px] font-bold text-purple-300">
                  {campaigns.perthCamp.funding}
                </span>
              </div>
              <p className="text-xs text-slate-400 flex items-center gap-2">
                <MapPin className="h-3 w-3 text-slate-500" />
                <span>{campaigns.perthCamp.subtitle}</span>
              </p>
              <p className="text-xs text-slate-400 pt-1">
                {campaigns.perthCamp.notes}
              </p>
            </div>

            <div className="rounded-lg border border-white/5 bg-white/[0.02] p-3 text-xs space-y-1 sm:text-right shrink-0">
              <p className="text-slate-400">Picks Filled</p>
              <p className="font-bold text-purple-400">
                {perthCamp.picks.length} Athletes Nominated
              </p>
              {perthCamp.notes.map((note, i) => (
                <p key={i} className="text-[11px] text-slate-500">
                  {note}
                </p>
              ))}
            </div>
          </div>

          {/* Perth Picks Table */}
          <div className="rounded-2xl border border-white/10 overflow-hidden bg-[#0c0d14]">
            <table className="w-full text-left text-xs border-collapse">
              <thead className="bg-white/5 text-[10px] text-slate-400 uppercase tracking-wider">
                <tr>
                  <th className="px-4 py-3">Slot Designation</th>
                  <th className="px-4 py-3 min-w-[10rem]">Sailor</th>
                  <th className="px-3 py-3 text-center">Gender</th>
                  <th className="px-3 py-3 text-center">Birth Year</th>
                  <th className="px-3 py-3 text-right">Combined Score</th>
                  <th className="px-4 py-3">Category Group</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-white/5">
                {displayPerthRows.map((pick) => (
                  <tr key={pick.sailorId} className="hover:bg-white/[0.02]">
                    <td className="px-4 py-3 font-bold text-purple-400">
                      {pick.slot}
                    </td>
                    <td className="px-4 py-3 font-bold text-white">
                      {pick.name}
                    </td>
                    <td className="px-3 py-3 text-center">
                      <span
                        className={`text-[10px] font-bold px-1.5 py-0.5 rounded ${
                          pick.gender === "F"
                            ? "bg-pink-500/15 text-pink-300"
                            : "bg-blue-500/15 text-blue-300"
                        }`}
                      >
                        {pick.gender}
                      </span>
                    </td>
                    <td className="px-3 py-3 text-center font-mono text-slate-400">
                      {pick.birthYear}
                    </td>
                    <td className="px-3 py-3 text-right font-mono font-black text-sm text-white">
                      {pick.combinedScore}
                    </td>
                    <td className="px-4 py-3 text-slate-400">
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
          <div className="rounded-xl border border-white/10 bg-[#0c0d14] p-3 flex items-center justify-between gap-2 text-xs text-slate-400">
            <span>
              Low point combined series score (Appendix A). Absent events scored as fleet size + 1.
            </span>
            <span className="font-mono text-slate-300">
              {combinedScores.length} competitors registered
            </span>
          </div>

          <div className="rounded-2xl border border-white/10 overflow-hidden bg-[#0c0d14]">
            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs border-collapse">
                <thead className="bg-white/5 text-[10px] text-slate-400 uppercase tracking-wider">
                  <tr>
                    <th className="px-4 py-3 w-12">#</th>
                    <th className="px-4 py-3 min-w-[10rem]">Sailor</th>
                    <th className="px-3 py-3 text-center">Gender</th>
                    <th className="px-3 py-3 text-center">Birth Year</th>
                    <th className="px-3 py-3 text-right">Gross</th>
                    <th className="px-3 py-3 text-right">Nett</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-white/5">
                  {simulatedScores.map((s, idx) => (
                    <tr key={s.sailorId} className="hover:bg-white/[0.02]">
                      <td className="px-4 py-2.5 font-mono text-slate-400">
                        #{idx + 1}
                      </td>
                      <td className="px-4 py-2.5 font-bold text-white">
                        {s.name}
                      </td>
                      <td className="px-3 py-2.5 text-center text-slate-400">
                        {s.gender || "—"}
                      </td>
                      <td className="px-3 py-2.5 text-center font-mono text-slate-400">
                        {s.birthYear || "—"}
                      </td>
                      <td className="px-3 py-2.5 text-right font-mono text-slate-500">
                        {s.grossScore}
                      </td>
                      <td className="px-3 py-2.5 text-right font-mono font-bold text-white">
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
