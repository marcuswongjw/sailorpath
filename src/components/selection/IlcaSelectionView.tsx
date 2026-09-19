"use client";

import { Fragment, useMemo, useState } from "react";
import Link from "next/link";
import {
  Trophy,
  Award,
  Users,
  Compass,
  Calendar,
  MapPin,
  Search,
  CheckCircle2,
  FileText,
  Lock,
} from "lucide-react";
import { useAccountOptional } from "@/components/AccountProvider";
import {
  ILCA4_INTERNATIONAL_CAMPAIGNS,
  ILCA4_NJTS_POLICY,
} from "@/lib/ilcaSelection";
import {
  ILCA4_SELECTION_EVENTS,
  ILCA4_SELECTION_SAILORS,
  getEasternQualifiedTeam,
  getAsianProvisionalLeaders,
  getNjtsProjectedSquad,
} from "@/lib/ilcaSelectionData";

type SelectionTab = "eastern" | "asian" | "njts" | "scoreboard" | "policy";

export function IlcaSelectionView() {
  const account = useAccountOptional();
  const email = account?.email;
  const owned = account?.owned;
  const accountReady = account?.ready ?? false;
  const isLoggedIn = Boolean(email);

  const [activeTab, setActiveTab] = useState<SelectionTab>("eastern");
  const [selectedSailorId, setSelectedSailorId] = useState<string | null>(null);
  const [genderFilter, setGenderFilter] = useState<"all" | "M" | "F">("all");
  const [eligibilityFilter, setEligibilityFilter] = useState<"u14" | "qualified" | "all">("u14");
  const [searchQuery, setSearchQuery] = useState("");

  const easternCampaign = ILCA4_INTERNATIONAL_CAMPAIGNS.find(
    (c) => c.id === "eastern-seaboard"
  )!;
  const asianCampaign = ILCA4_INTERNATIONAL_CAMPAIGNS.find(
    (c) => c.id === "asian-open"
  )!;

  const { qualifiedBoys, reserveBoys, qualifiedGirls, reserveGirls } = useMemo(
    () => getEasternQualifiedTeam(),
    []
  );
  const { leaderBoys, leaderGirls } = useMemo(
    () => getAsianProvisionalLeaders(),
    []
  );
  const njtsSquad = useMemo(() => getNjtsProjectedSquad(), []);

  // Claimed athlete detection for logged-in user
  const mySailor = useMemo(() => {
    const ownedList = owned ?? [];
    if (!isLoggedIn || ownedList.length === 0) return null;
    const ownedIds = new Set(ownedList.map((o) => o.id));
    const ownedHandles = new Set(ownedList.map((o) => o.handle).filter(Boolean));
    return (
      ILCA4_SELECTION_SAILORS.find(
        (s) => ownedIds.has(s.sailorId) || (s.handle && ownedHandles.has(s.handle))
      ) || null
    );
  }, [isLoggedIn, owned]);

  // Points cushion to Eastern Seaboard cutoff (Slot 3 vs Slot 4)
  const mySailorEasternStatus = useMemo(() => {
    if (!mySailor || !mySailor.isU14) return null;
    const sameGenderU14 = ILCA4_SELECTION_SAILORS.filter(
      (s) => s.gender === mySailor.gender && s.isU14 && s.trialPts > 0
    ).sort((a, b) => b.trialPts - a.trialPts || a.finishPos - b.finishPos);

    const rank = sameGenderU14.findIndex((s) => s.sailorId === mySailor.sailorId) + 1;
    if (rank === 0) return null;

    const slot3 = sameGenderU14[2];
    const slot4 = sameGenderU14[3];

    let cushionText = "";
    if (rank <= 3) {
      if (slot4) {
        const cushion = mySailor.trialPts - slot4.trialPts;
        cushionText = `+${cushion} pts ahead of 1st reserve (#4)`;
      } else {
        cushionText = "Guaranteed qualification slot";
      }
    } else {
      if (slot3) {
        const deficit = slot3.trialPts - mySailor.trialPts;
        cushionText = `${deficit} pts behind qualification cutoff (#3)`;
      }
    }

    return { rank, total: sameGenderU14.length, cushionText };
  }, [mySailor]);

  // Filtered rows for Eastern Seaboard Table
  const filteredEasternRows = useMemo(() => {
    let rows = [...ILCA4_SELECTION_SAILORS];

    // Eligibility filter
    if (eligibilityFilter === "u14") {
      rows = rows.filter((r) => r.isU14 && r.trialPts > 0);
    } else if (eligibilityFilter === "qualified") {
      rows = rows.filter(
        (r) =>
          r.easternStatus.startsWith("Qualified") ||
          r.easternStatus.includes("Reserve")
      );
    }

    // Gender filter
    if (genderFilter !== "all") {
      rows = rows.filter((r) => r.gender === genderFilter);
    }

    // Search query
    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase().trim();
      rows = rows.filter(
        (r) =>
          r.name.toLowerCase().includes(q) ||
          (r.handle && r.handle.toLowerCase().includes(q))
      );
    }

    // Sort: if U14 filtered, sort by Eastern rank / trial points; else national rank
    if (eligibilityFilter === "u14" || eligibilityFilter === "qualified") {
      rows.sort((a, b) => {
        // Primary sort: trial points descending
        if (b.trialPts !== a.trialPts) return b.trialPts - a.trialPts;
        return a.finishPos - b.finishPos;
      });
    } else {
      rows.sort((a, b) => a.nationalRank - b.nationalRank);
    }

    return rows;
  }, [genderFilter, eligibilityFilter, searchQuery]);

  if (!accountReady) {
    return (
      <div className="mx-auto w-full max-w-4xl px-4 py-20 flex flex-col items-center justify-center space-y-3">
        <div className="h-6 w-6 animate-spin rounded-full border-2 border-sky-500 border-t-transparent" />
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
            href="/sg/ilca4"
            className="inline-flex items-center gap-1.5 text-xs font-semibold text-slate-soft hover:text-charcoal transition-colors"
          >
            <span>← Back to ILCA 4 National Standings</span>
          </Link>
        </div>

        {/* Member Access Gate Card */}
        <div className="relative overflow-hidden rounded-3xl border border-cool-veil bg-warm-white p-6 sm:p-10 text-center space-y-6 shadow-xs">
          <div className="relative mx-auto flex h-16 w-16 items-center justify-center rounded-2xl bg-sky-500/10 border border-sky-500/20 text-sky-500 shadow-sm">
            <Lock className="h-8 w-8" />
          </div>

          <div className="relative space-y-2 max-w-xl mx-auto">
            <div className="inline-flex items-center gap-1.5 rounded-full border border-sky-500/20 bg-sky-500/10 px-3 py-0.5 text-[11px] font-bold text-sky-600">
              <Trophy className="h-3 w-3" />
              <span>Singapore ILCA 4 Pathway</span>
            </div>
            <h1 className="text-2xl sm:text-3xl font-black text-charcoal tracking-tight">
              2026 Selection Trials &amp; Squad Policies
            </h1>
            <p className="text-xs sm:text-sm text-slate-soft leading-relaxed">
              Official trial outcomes, combined low-point finishes, and squad rosters for the{" "}
              <strong className="text-charcoal">Eastern Seaboard Regatta 2026</strong>,{" "}
              <strong className="text-charcoal">Asian Open Championships 2026</strong>, and the{" "}
              <strong className="text-charcoal">National Junior Training Squad (NJTS)</strong> are
              exclusive to registered members.
            </p>
          </div>

          {/* Action buttons */}
          <div className="relative flex flex-col sm:flex-row items-center justify-center gap-3 max-w-md mx-auto pt-2">
            <Link
              href="/login?next=%2Fsg%2Filca4%2Fselection"
              className="w-full sm:w-auto sp-btn-primary text-xs font-black uppercase tracking-wider px-6 py-3.5 inline-flex items-center justify-center gap-2 min-h-[44px]"
            >
              Sign In to View Selection
            </Link>
            <Link
              href="/register?next=%2Fsg%2Filca4%2Fselection"
              className="w-full sm:w-auto rounded-full bg-sailcloth hover:bg-cool-veil active:scale-[0.98] transition-all text-xs font-bold text-charcoal px-6 py-3.5 border border-cool-veil inline-flex items-center justify-center min-h-[44px]"
            >
              Create Free Account
            </Link>
          </div>

          {/* Feature Highlights Grid */}
          <div className="relative grid grid-cols-1 sm:grid-cols-2 gap-3 pt-4 border-t border-cool-veil text-left">
            <div className="rounded-xl border border-cool-veil bg-sailcloth p-4 space-y-1">
              <div className="flex items-center gap-2">
                <Trophy className="h-4 w-4 text-sky-500 shrink-0" />
                <h2 className="text-xs font-bold text-charcoal">Eastern Seaboard Qualified Team</h2>
              </div>
              <p className="text-[11px] text-slate-soft leading-relaxed">
                Top 3 U14 qualifying standings per gender, reserve slots, and points cushions.
              </p>
            </div>
            <div className="rounded-xl border border-cool-veil bg-sailcloth p-4 space-y-1">
              <div className="flex items-center gap-2">
                <Award className="h-4 w-4 text-emerald-600 shrink-0" />
                <h2 className="text-xs font-bold text-charcoal">Asian Open Provisional Leaders</h2>
              </div>
              <p className="text-[11px] text-slate-soft leading-relaxed">
                Gender-quota leaderboards tracking the 2026 Asian Open Championships team.
              </p>
            </div>
            <div className="rounded-xl border border-cool-veil bg-sailcloth p-4 space-y-1">
              <div className="flex items-center gap-2">
                <Users className="h-4 w-4 text-sky-500 shrink-0" />
                <h2 className="text-xs font-bold text-charcoal">NJTS Projected Squad</h2>
              </div>
              <p className="text-[11px] text-slate-soft leading-relaxed">
                National Junior Training Squad projection from the top 25 national ranking.
              </p>
            </div>
            <div className="rounded-xl border border-cool-veil bg-sailcloth p-4 space-y-1">
              <div className="flex items-center gap-2">
                <Compass className="h-4 w-4 text-emerald-600 shrink-0" />
                <h2 className="text-xs font-bold text-charcoal">Trial Scoreboard &amp; Policies</h2>
              </div>
              <p className="text-[11px] text-slate-soft leading-relaxed">
                Race-by-race trial results, U14 eligibility filters, and SSF squad regulations.
              </p>
            </div>
          </div>

          <p className="text-[11px] text-slate-soft">
            Free access for Singapore sailors, sailing parents, and registered coaches.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto w-full max-w-7xl min-w-0 px-3 sm:px-6 lg:px-8 pt-4 pb-12 sm:pt-6 sm:pb-16 space-y-6">
      {/* ── Breadcrumb & Top Actions ── */}
      <div className="flex items-center justify-between">
        <Link
          href="/sg/ilca4"
          className="inline-flex items-center gap-1.5 text-xs font-semibold text-slate-soft hover:text-charcoal transition-colors"
        >
          <span>← Back to ILCA 4 National Standings</span>
        </Link>
        <Link
          href="/sg/optimist/selection"
          className="inline-flex items-center gap-1.5 text-xs font-semibold text-slate-soft hover:text-charcoal transition-colors"
        >
          <span>Optimist Selection Trials →</span>
        </Link>
      </div>

      {/* ── Hero Header ── */}
      <div className="rounded-3xl border border-cool-veil bg-warm-white p-5 sm:p-8 shadow-xs space-y-4">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div className="flex items-start gap-3">
            <span className="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-sky-500/10 text-sky-500 border border-sky-500/20">
              <Trophy className="h-6 w-6" />
            </span>
            <div>
              <div className="flex flex-wrap items-center gap-2">
                <span className="text-[10px] font-bold text-sky-500 uppercase tracking-wider">
                  Singapore ILCA 4 Pathway
                </span>
                <span className="inline-flex items-center rounded-full bg-emerald-500/10 border border-emerald-500/20 px-2 py-0.5 text-[9px] font-bold text-emerald-600 dark:text-emerald-300">
                  Trials Finalized
                </span>
              </div>
              <h1 className="text-2xl sm:text-3xl font-black text-charcoal tracking-tight mt-0.5">
                ILCA 4 Selection Trials &amp; Squad Policies
              </h1>
              <p className="text-xs sm:text-sm text-slate-soft mt-1 leading-relaxed max-w-2xl">
                Official trial outcomes, combined low-point finishes, and squad rosters for the{" "}
                <strong className="text-charcoal">Eastern Seaboard Regatta 2026</strong>,{" "}
                <strong className="text-charcoal">Asian Open Championships 2026</strong>, and the{" "}
                <strong className="text-charcoal">National Junior Training Squad (NJTS)</strong>.
              </p>
            </div>
          </div>
          <div className="md:text-right shrink-0">
            <p className="text-[10px] text-slate-soft font-semibold">Policy Authority</p>
            <p className="text-xs font-bold text-charcoal">Singapore Sailing Federation</p>
            <p className="text-[10px] text-slate-soft mt-0.5">Updated 16 Sep 2026 · 81 Ranked Sailors</p>
          </div>
        </div>

        {/* ── Selection Series Progress Banner ── */}
        <div className="pt-2 border-t border-cool-veil">
          <div className="flex flex-wrap items-center justify-between gap-2 mb-2">
            <p className="text-[10px] font-bold text-slate-soft uppercase tracking-wider">
              Selection Trials Event Schedule &amp; Results
            </p>
            <span className="text-[11px] font-semibold text-emerald-600 dark:text-emerald-400 flex items-center gap-1">
              <CheckCircle2 className="h-3.5 w-3.5" />
              <span>Eastern Seaboard Trials Concluded (2 of 2 Scored)</span>
            </span>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-3 gap-2.5">
            {ILCA4_SELECTION_EVENTS.map((ev, idx) => (
              <div
                key={ev.id}
                className={`rounded-xl border p-3 flex items-start gap-3 transition-all ${
                  ev.completed
                    ? "border-emerald-500/30 bg-emerald-500/5"
                    : "border-cool-veil bg-sailcloth/50"
                }`}
              >
                <span
                  className={`mt-0.5 flex h-6 w-6 shrink-0 items-center justify-center rounded-full text-xs font-black ${
                    ev.completed
                      ? "bg-emerald-500/20 text-emerald-600 dark:text-emerald-300"
                      : "bg-cool-veil/50 text-slate-soft"
                  }`}
                >
                  {idx + 1}
                </span>
                <div className="min-w-0 flex-1">
                  <div className="flex items-center justify-between gap-1">
                    <p className="text-xs font-bold text-charcoal truncate">{ev.shortName}</p>
                    <span
                      className={`text-[9px] font-bold px-1.5 py-0.5 rounded-full ${
                        ev.completed
                          ? "bg-emerald-500/10 text-emerald-600 dark:text-emerald-300 border border-emerald-500/20"
                          : "bg-amber-500/10 text-amber-600 dark:text-amber-300 border border-amber-500/20"
                      }`}
                    >
                      {ev.completed ? "Scored" : "Scheduled"}
                    </span>
                  </div>
                  <p className="text-[10px] text-slate-soft mt-0.5 flex items-center gap-1">
                    <Calendar className="h-2.5 w-2.5" />
                    <span>{ev.dateStr}</span>
                  </p>
                  <p className="text-[10px] font-medium mt-0.5 text-slate-soft truncate">
                    {ev.completed ? `${ev.fleetSize} competitors scored` : "Trials Event 2"}
                  </p>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* ── Tab Navigation ── */}
        <div className="flex items-center gap-1.5 overflow-x-auto pt-2 border-t border-cool-veil no-scrollbar">
          <button
            type="button"
            onClick={() => setActiveTab("eastern")}
            className={`flex items-center gap-1.5 rounded-xl px-3.5 py-2 text-xs font-bold transition-all shrink-0 cursor-pointer ${
              activeTab === "eastern"
                ? "bg-sky-500 text-white shadow-xs"
                : "bg-sailcloth text-slate-soft hover:text-charcoal hover:bg-cool-veil/50"
            }`}
          >
            <Trophy className="h-3.5 w-3.5" />
            <span>Eastern Seaboard 2026</span>
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("asian")}
            className={`flex items-center gap-1.5 rounded-xl px-3.5 py-2 text-xs font-bold transition-all shrink-0 cursor-pointer ${
              activeTab === "asian"
                ? "bg-sky-500 text-white shadow-xs"
                : "bg-sailcloth text-slate-soft hover:text-charcoal hover:bg-cool-veil/50"
            }`}
          >
            <Award className="h-3.5 w-3.5" />
            <span>Asian Open Champs 2026</span>
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("njts")}
            className={`flex items-center gap-1.5 rounded-xl px-3.5 py-2 text-xs font-bold transition-all shrink-0 cursor-pointer ${
              activeTab === "njts"
                ? "bg-sky-500 text-white shadow-xs"
                : "bg-sailcloth text-slate-soft hover:text-charcoal hover:bg-cool-veil/50"
            }`}
          >
            <Users className="h-3.5 w-3.5" />
            <span>NJTS Squad Policy</span>
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("scoreboard")}
            className={`flex items-center gap-1.5 rounded-xl px-3.5 py-2 text-xs font-bold transition-all shrink-0 cursor-pointer ${
              activeTab === "scoreboard"
                ? "bg-sky-500 text-white shadow-xs"
                : "bg-sailcloth text-slate-soft hover:text-charcoal hover:bg-cool-veil/50"
            }`}
          >
            <Compass className="h-3.5 w-3.5" />
            <span>Complete Matrix (81 Sailors)</span>
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("policy")}
            className={`flex items-center gap-1.5 rounded-xl px-3.5 py-2 text-xs font-bold transition-all shrink-0 cursor-pointer ${
              activeTab === "policy"
                ? "bg-sky-500 text-white shadow-xs"
                : "bg-sailcloth text-slate-soft hover:text-charcoal hover:bg-cool-veil/50"
            }`}
          >
            <FileText className="h-3.5 w-3.5" />
            <span>Policy Guidelines</span>
          </button>
        </div>
      </div>

      {/* ── Claimed Sailor Spotlight Banner (Logged-In User) ── */}
      {mySailor && (
        <div className="rounded-2xl border border-sky-500/30 bg-sky-500/5 p-4 sm:p-5 flex flex-col sm:flex-row sm:items-center justify-between gap-4 shadow-xs">
          <div className="flex items-start gap-3 min-w-0">
            <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl font-black text-sm border bg-sky-500/10 text-sky-600 dark:text-sky-300 border-sky-500/30">
              #{mySailor.nationalRank}
            </div>
            <div className="min-w-0">
              <div className="flex items-center gap-2 flex-wrap">
                <p className="text-sm font-bold text-charcoal leading-tight">
                  Your Claimed Sailor: {mySailor.name}
                </p>
                <span className="text-[10px] font-black px-2 py-0.5 rounded-full uppercase tracking-wider bg-sky-500/15 text-sky-600 dark:text-sky-300 border border-sky-500/30">
                  National Rank #{mySailor.nationalRank}
                </span>
                <span className="text-[10px] font-bold px-2 py-0.5 rounded-full bg-sailcloth text-slate-soft border border-cool-veil">
                  {mySailor.gender === "M" ? "Boy" : "Girl"} · Born {mySailor.birthYear}
                </span>
              </div>
              <p className="text-xs text-slate-soft mt-1 flex items-center gap-2 flex-wrap">
                <span>
                  Trial Points:{" "}
                  <strong className="text-charcoal font-mono">{mySailor.trialPts} pts</strong>
                </span>
                <span>·</span>
                <span>
                  Eastern Seaboard Status:{" "}
                  <strong className="text-charcoal">{mySailor.easternStatus}</strong>
                </span>
                {mySailorEasternStatus && (
                  <span className="text-sky-600 dark:text-sky-300 font-semibold">
                    ({mySailorEasternStatus.cushionText})
                  </span>
                )}
              </p>
            </div>
          </div>

          <div className="flex items-center gap-2 shrink-0">
            <button
              type="button"
              onClick={() => setSelectedSailorId(mySailor.sailorId)}
              className="rounded-lg border border-cool-veil bg-warm-white px-3 py-1.5 text-xs font-bold text-charcoal hover:bg-sailcloth shadow-xs transition-colors"
            >
              View Race Breakdown
            </button>
          </div>
        </div>
      )}

      {/* ═════════════════════════════════════════════════════════════════════ */}
      {/* TAB 1: EASTERN SEABOARD REGATTA 2026 (PRIMARY OUTCOME)              */}
      {/* ═════════════════════════════════════════════════════════════════════ */}
      {activeTab === "eastern" && (
        <div className="space-y-6">
          {/* Campaign Overview Card */}
          <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6 space-y-4 shadow-xs">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3 border-b border-cool-veil">
              <div>
                <div className="flex items-center gap-2">
                  <h2 className="text-lg sm:text-xl font-black text-charcoal">
                    {easternCampaign.name}
                  </h2>
                  <span className="rounded-full bg-emerald-500/10 border border-emerald-500/20 px-2 py-0.5 text-[10px] font-bold text-emerald-600 dark:text-emerald-300">
                    Selection Concluded
                  </span>
                </div>
                <div className="flex flex-wrap items-center gap-3 text-xs text-slate-soft mt-1">
                  <span className="inline-flex items-center gap-1">
                    <MapPin className="h-3.5 w-3.5 text-sky-500" />
                    {easternCampaign.venue}
                  </span>
                  <span className="inline-flex items-center gap-1">
                    <Calendar className="h-3.5 w-3.5 text-sky-500" />
                    {easternCampaign.regattaDates}
                  </span>
                </div>
              </div>
              <div className="sm:text-right shrink-0">
                <span className="inline-flex items-center rounded-full bg-sky-500/10 border border-sky-500/20 px-3 py-1 text-xs font-bold text-sky-600 dark:text-sky-300">
                  Travel: {easternCampaign.travelPeriod}
                </span>
              </div>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 text-xs">
              <div className="rounded-xl border border-cool-veil bg-sailcloth p-3 space-y-1">
                <p className="text-[10px] font-bold text-slate-soft uppercase tracking-wider">Team Quota</p>
                <p className="text-sm font-black text-charcoal">Top 3 boys &amp; Top 3 girls</p>
                <p className="text-[11px] text-slate-soft">Separate selection boards for boys and girls.</p>
              </div>
              <div className="rounded-xl border border-cool-veil bg-sailcloth p-3 space-y-1">
                <p className="text-[10px] font-bold text-slate-soft uppercase tracking-wider">Age Eligibility</p>
                <p className="text-sm font-black text-charcoal">Singapore Citizens born in 2012 or later</p>
                <p className="text-[11px] text-slate-soft">U14 category eligibility.</p>
              </div>
              <div className="rounded-xl border border-cool-veil bg-sailcloth p-3 space-y-1">
                <p className="text-[10px] font-bold text-slate-soft uppercase tracking-wider">Scoring Formula</p>
                <p className="text-sm font-black text-charcoal">Lowest Combined Finish Places</p>
                <p className="text-[11px] text-slate-soft">Pesta Sukan 2026 + SNSC 2026 sum.</p>
              </div>
            </div>
          </div>

          {/* ── Official Qualified Team Roster Spotlight ── */}
          <div className="space-y-3">
            <div className="flex items-center justify-between">
              <h3 className="text-xs font-black uppercase tracking-wider text-slate-soft flex items-center gap-1.5">
                <Trophy className="h-3.5 w-3.5 text-amber-500" />
                <span>Provisional Qualified Roster · Eastern Seaboard Regatta 2026</span>
              </h3>
              <span className="text-[11px] font-bold text-emerald-600 dark:text-emerald-400">
                6 Athletes Nominated (3 Boys, 3 Girls)
              </span>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {/* Qualified Boys Column */}
              <div className="rounded-2xl border border-blue-500/30 bg-blue-500/5 p-4 sm:p-5 space-y-3">
                <div className="flex items-center justify-between pb-2 border-b border-blue-500/20">
                  <div className="flex items-center gap-2">
                    <span className="flex h-6 w-6 items-center justify-center rounded-full bg-blue-500/20 text-blue-600 font-black text-xs">
                      ♂
                    </span>
                    <h4 className="text-sm font-black text-charcoal">Qualified Boys (Top 3)</h4>
                  </div>
                  <span className="text-[10px] font-bold px-2 py-0.5 rounded-full bg-blue-500/15 text-blue-600">
                    U14 Boys
                  </span>
                </div>

                <div className="space-y-2">
                  {qualifiedBoys.map((boy, idx) => (
                    <div
                      key={boy.sailorId}
                      className="rounded-xl border border-blue-500/20 bg-warm-white p-3 flex items-center justify-between gap-3 shadow-xs"
                    >
                      <div className="flex items-center gap-3 min-w-0">
                        <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-blue-500/10 text-blue-600 font-black text-xs">
                          #{idx + 1}
                        </span>
                        <div className="min-w-0">
                          <p className="text-xs font-bold text-charcoal truncate">{boy.name}</p>
                          <p className="text-[10px] text-slate-soft">
                            Born {boy.birthYear} · Nat Rank #{boy.nationalRank}
                          </p>
                        </div>
                      </div>
                      <div className="text-right shrink-0">
                        <p className="text-xs font-black text-charcoal font-mono">{boy.trialPts} pts</p>
                        <p className="text-[10px] text-slate-soft">Pesta: {boy.pestaPoints} · SNSC: {boy.snscPoints}</p>
                      </div>
                    </div>
                  ))}
                </div>

                {/* Reserves */}
                <div className="pt-2 border-t border-blue-500/15">
                  <p className="text-[10px] font-bold text-slate-soft uppercase tracking-wider mb-1.5">
                    Official Reserves (Boys):
                  </p>
                  <div className="space-y-1">
                    {reserveBoys.slice(0, 3).map((res, rIdx) => (
                      <div
                        key={res.sailorId}
                        className="flex items-center justify-between text-xs text-slate-soft py-0.5"
                      >
                        <span className="truncate">
                          <strong className="text-charcoal font-medium">{rIdx + 1}st Res:</strong> {res.name} ({res.birthYear})
                        </span>
                        <span className="font-mono text-xs font-bold text-charcoal ml-2">
                          {res.trialPts} pts
                        </span>
                      </div>
                    ))}
                  </div>
                </div>
              </div>

              {/* Qualified Girls Column */}
              <div className="rounded-2xl border border-pink-500/30 bg-pink-500/5 p-4 sm:p-5 space-y-3">
                <div className="flex items-center justify-between pb-2 border-b border-pink-500/20">
                  <div className="flex items-center gap-2">
                    <span className="flex h-6 w-6 items-center justify-center rounded-full bg-pink-500/20 text-pink-600 font-black text-xs">
                      ♀
                    </span>
                    <h4 className="text-sm font-black text-charcoal">Qualified Girls (Top 3)</h4>
                  </div>
                  <span className="text-[10px] font-bold px-2 py-0.5 rounded-full bg-pink-500/15 text-pink-600">
                    U14 Girls
                  </span>
                </div>

                <div className="space-y-2">
                  {qualifiedGirls.map((girl, idx) => (
                    <div
                      key={girl.sailorId}
                      className="rounded-xl border border-pink-500/20 bg-warm-white p-3 flex items-center justify-between gap-3 shadow-xs"
                    >
                      <div className="flex items-center gap-3 min-w-0">
                        <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-pink-500/10 text-pink-600 font-black text-xs">
                          #{idx + 1}
                        </span>
                        <div className="min-w-0">
                          <p className="text-xs font-bold text-charcoal truncate">{girl.name}</p>
                          <p className="text-[10px] text-slate-soft">
                            Born {girl.birthYear} · Nat Rank #{girl.nationalRank}
                          </p>
                        </div>
                      </div>
                      <div className="text-right shrink-0">
                        <p className="text-xs font-black text-charcoal font-mono">{girl.trialPts} pts</p>
                        <p className="text-[10px] text-slate-soft">Pesta: {girl.pestaPoints} · SNSC: {girl.snscPoints}</p>
                      </div>
                    </div>
                  ))}
                </div>

                {/* Reserves */}
                <div className="pt-2 border-t border-pink-500/15">
                  <p className="text-[10px] font-bold text-slate-soft uppercase tracking-wider mb-1.5">
                    Official Reserves (Girls):
                  </p>
                  <div className="space-y-1">
                    {reserveGirls.slice(0, 3).map((res, rIdx) => (
                      <div
                        key={res.sailorId}
                        className="flex items-center justify-between text-xs text-slate-soft py-0.5"
                      >
                        <span className="truncate">
                          <strong className="text-charcoal font-medium">{rIdx + 1}st Res:</strong> {res.name} ({res.birthYear})
                        </span>
                        <span className="font-mono text-xs font-bold text-charcoal ml-2">
                          {res.trialPts} pts
                        </span>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* ── Table Controls & Search ── */}
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-cool-veil pb-3">
            <div className="flex items-center gap-2 flex-wrap">
              {/* Eligibility Filter */}
              <div className="flex items-center rounded-lg border border-cool-veil bg-sailcloth p-0.5 text-xs">
                <button
                  type="button"
                  onClick={() => setEligibilityFilter("u14")}
                  className={`px-3 py-1 rounded-md font-bold transition-colors cursor-pointer ${
                    eligibilityFilter === "u14"
                      ? "bg-sky-500 text-white shadow-xs"
                      : "text-slate-soft hover:text-charcoal"
                  }`}
                >
                  U14 Trial Scores (Born 2012+)
                </button>
                <button
                  type="button"
                  onClick={() => setEligibilityFilter("qualified")}
                  className={`px-3 py-1 rounded-md font-bold transition-colors cursor-pointer ${
                    eligibilityFilter === "qualified"
                      ? "bg-sky-500 text-white shadow-xs"
                      : "text-slate-soft hover:text-charcoal"
                  }`}
                >
                  Roster &amp; Reserves Only
                </button>
                <button
                  type="button"
                  onClick={() => setEligibilityFilter("all")}
                  className={`px-3 py-1 rounded-md font-bold transition-colors cursor-pointer ${
                    eligibilityFilter === "all"
                      ? "bg-sky-500 text-white shadow-xs"
                      : "text-slate-soft hover:text-charcoal"
                  }`}
                >
                  All Competitors
                </button>
              </div>

              {/* Gender Filter */}
              <div className="flex items-center rounded-lg border border-cool-veil bg-sailcloth p-0.5 text-xs">
                <button
                  type="button"
                  onClick={() => setGenderFilter("all")}
                  className={`px-2.5 py-1 rounded-md font-bold transition-colors cursor-pointer ${
                    genderFilter === "all"
                      ? "bg-sky-500 text-white shadow-xs"
                      : "text-slate-soft hover:text-charcoal"
                  }`}
                >
                  All
                </button>
                <button
                  type="button"
                  onClick={() => setGenderFilter("M")}
                  className={`px-2.5 py-1 rounded-md font-bold transition-colors cursor-pointer ${
                    genderFilter === "M"
                      ? "bg-blue-600 text-white shadow-xs"
                      : "text-slate-soft hover:text-charcoal"
                  }`}
                >
                  Boys
                </button>
                <button
                  type="button"
                  onClick={() => setGenderFilter("F")}
                  className={`px-2.5 py-1 rounded-md font-bold transition-colors cursor-pointer ${
                    genderFilter === "F"
                      ? "bg-pink-600 text-white shadow-xs"
                      : "text-slate-soft hover:text-charcoal"
                  }`}
                >
                  Girls
                </button>
              </div>
            </div>

            {/* Search Input */}
            <div className="relative w-full sm:w-64">
              <Search className="h-3.5 w-3.5 absolute left-3 top-1/2 -translate-y-1/2 text-slate-soft" />
              <input
                type="text"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                placeholder="Search sailor name…"
                className="w-full rounded-xl border border-cool-veil bg-warm-white pl-8 pr-3 py-1.5 text-xs text-charcoal placeholder:text-slate-soft focus:outline-none focus:border-sky-500"
              />
            </div>
          </div>

          {/* ── Standings Table ── */}
          <div className="rounded-2xl border border-cool-veil overflow-hidden bg-warm-white shadow-xs">
            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs border-collapse">
                <thead className="bg-sailcloth text-[10px] text-slate-soft uppercase tracking-wider border-b border-cool-veil">
                  <tr>
                    <th className="px-4 py-3 w-12 text-center">Pos</th>
                    <th className="px-4 py-3 min-w-[12rem]">Sailor</th>
                    <th className="px-3 py-3 text-center">Status</th>
                    <th className="px-3 py-3 text-center">Gender</th>
                    <th className="px-3 py-3 text-center">Birth Year</th>
                    <th className="px-3 py-3 text-right">Event 1: Pesta Sukan</th>
                    <th className="px-3 py-3 text-right">Event 2: SNSC</th>
                    <th className="px-4 py-3 text-right">Trial Score</th>
                    <th className="px-3 py-3 text-center">Nat Rank</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-cool-veil">
                  {filteredEasternRows.map((sailor, idx) => {
                    const isMyAthlete = mySailor?.sailorId === sailor.sailorId;
                    const isQualified = sailor.easternStatus.startsWith("Qualified");
                    const isReserve = sailor.easternStatus.includes("Reserve");

                    return (
                      <Fragment key={sailor.sailorId}>
                        {/* Cutoff Line indicator */}
                        {eligibilityFilter === "u14" && idx === 3 && genderFilter !== "all" && (
                          <tr className="bg-rose-500/10 border-y border-rose-500/30">
                            <td
                              colSpan={9}
                              className="px-4 py-1.5 text-center text-[10px] font-black tracking-wider text-rose-600 uppercase"
                            >
                              ═══ {genderFilter === "M" ? "Boys" : "Girls"} Qualifying Cutoff Line (Top 3 Slots) ═══
                            </td>
                          </tr>
                        )}

                        <tr
                          onClick={() =>
                            setSelectedSailorId((id) =>
                              id === sailor.sailorId ? null : sailor.sailorId
                            )
                          }
                          className={`hover:bg-sailcloth transition-colors cursor-pointer ${
                            isMyAthlete
                              ? "bg-sky-500/10 font-semibold"
                              : isQualified
                              ? "bg-emerald-500/5"
                              : isReserve
                              ? "bg-amber-500/5"
                              : ""
                          }`}
                        >
                          <td className="px-4 py-3 text-center font-mono font-bold text-slate-soft">
                            #{idx + 1}
                          </td>
                          <td className="px-4 py-3">
                            <div className="flex items-center gap-2">
                              <span className="font-bold text-charcoal">{sailor.name}</span>
                              {isMyAthlete && (
                                <span className="rounded bg-sky-500/20 text-sky-600 text-[9px] font-black px-1.5 py-0.5 border border-sky-500/30">
                                  YOU
                                </span>
                              )}
                            </div>
                            {sailor.handle && (
                              <p className="text-[10px] text-slate-soft">@{sailor.handle}</p>
                            )}
                          </td>
                          <td className="px-3 py-3 text-center">
                            <span
                              className={`inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold ${
                                isQualified
                                  ? "bg-emerald-500/10 text-emerald-600 dark:text-emerald-300 border border-emerald-500/20"
                                  : isReserve
                                  ? "bg-amber-500/10 text-amber-600 dark:text-amber-300 border border-amber-500/20"
                                  : sailor.isU14
                                  ? "bg-sailcloth text-slate-soft border border-cool-veil"
                                  : "bg-cool-veil/40 text-slate-soft"
                              }`}
                            >
                              {sailor.easternStatus}
                            </span>
                          </td>
                          <td className="px-3 py-3 text-center">
                            <span
                              className={`text-[10px] font-bold px-1.5 py-0.5 rounded ${
                                sailor.gender === "F"
                                  ? "bg-pink-100 text-pink-700"
                                  : "bg-blue-100 text-blue-700"
                              }`}
                            >
                              {sailor.gender}
                            </span>
                          </td>
                          <td className="px-3 py-3 text-center font-mono text-slate-soft">
                            {sailor.birthYear ?? "—"}
                          </td>
                          <td className="px-3 py-3 text-right font-mono">
                            {sailor.pestaPoints > 0 ? (
                              <span>
                                <strong className="text-charcoal">{sailor.pestaPoints} pts</strong>{" "}
                                <span className="text-[10px] text-slate-soft">
                                  ({sailor.pestaPlace ? `${sailor.pestaPlace}th` : "—"})
                                </span>
                              </span>
                            ) : (
                              <span className="text-slate-soft">DNS (0)</span>
                            )}
                          </td>
                          <td className="px-3 py-3 text-right font-mono">
                            {sailor.snscPoints > 0 ? (
                              <span>
                                <strong className="text-charcoal">{sailor.snscPoints} pts</strong>{" "}
                                <span className="text-[10px] text-slate-soft">
                                  ({sailor.snscPlace ? `${sailor.snscPlace}th` : "—"})
                                </span>
                              </span>
                            ) : (
                              <span className="text-slate-soft">DNS (0)</span>
                            )}
                          </td>
                          <td className="px-4 py-3 text-right font-mono">
                            <span className="text-sm font-black text-charcoal">
                              {sailor.trialPts} pts
                            </span>
                          </td>
                          <td className="px-3 py-3 text-center font-mono text-slate-soft">
                            #{sailor.nationalRank}
                          </td>
                        </tr>

                        {/* Expanded Breakdown Row */}
                        {selectedSailorId === sailor.sailorId && (
                          <tr className="bg-sailcloth/60 border-t border-b border-cool-veil">
                            <td colSpan={9} className="px-5 py-3 space-y-2">
                              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2">
                                <p className="text-xs font-bold text-charcoal">
                                  {sailor.name} · Complete Performance &amp; Eligibility Audit:
                                </p>
                                <span className="text-[11px] text-slate-soft">
                                  Combined Finish Positions Sum: {sailor.finishPos}
                                </span>
                              </div>
                              <div className="grid grid-cols-2 sm:grid-cols-4 gap-2 text-xs">
                                <div className="rounded-lg bg-warm-white border border-cool-veil p-2">
                                  <p className="text-[10px] text-slate-soft">Event 1: Pesta Sukan</p>
                                  <p className="font-bold text-charcoal font-mono">
                                    {sailor.pestaPoints > 0 ? `${sailor.pestaPoints} pts (Finish: ${sailor.pestaPlace})` : "Did not compete (0 pts)"}
                                  </p>
                                </div>
                                <div className="rounded-lg bg-warm-white border border-cool-veil p-2">
                                  <p className="text-[10px] text-slate-soft">Event 2: SNSC 2026</p>
                                  <p className="font-bold text-charcoal font-mono">
                                    {sailor.snscPoints > 0 ? `${sailor.snscPoints} pts (Finish: ${sailor.snscPlace})` : "Did not compete (0 pts)"}
                                  </p>
                                </div>
                                <div className="rounded-lg bg-warm-white border border-cool-veil p-2">
                                  <p className="text-[10px] text-slate-soft">Best 3 of 5 National Series</p>
                                  <p className="font-bold text-charcoal font-mono">
                                    {sailor.bestThreePoints} pts (Rank #{sailor.nationalRank})
                                  </p>
                                </div>
                                <div className="rounded-lg bg-warm-white border border-cool-veil p-2">
                                  <p className="text-[10px] text-slate-soft">U14 Selection Outcome</p>
                                  <p className="font-bold text-sky-600 font-mono">
                                    {sailor.easternStatus}
                                  </p>
                                </div>
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

      {/* ═════════════════════════════════════════════════════════════════════ */}
      {/* TAB 2: ILCA ASIAN OPEN CHAMPIONSHIPS 2026                           */}
      {/* ═════════════════════════════════════════════════════════════════════ */}
      {activeTab === "asian" && (
        <div className="space-y-6">
          <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6 space-y-4 shadow-xs">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3 border-b border-cool-veil">
              <div>
                <div className="flex items-center gap-2">
                  <h2 className="text-lg sm:text-xl font-black text-charcoal">
                    {asianCampaign.name}
                  </h2>
                  <span className="rounded-full bg-amber-500/10 border border-amber-500/20 px-2 py-0.5 text-[10px] font-bold text-amber-600 dark:text-amber-300">
                    Event 1 Scored · Event 2 Oct 2026
                  </span>
                </div>
                <div className="flex flex-wrap items-center gap-3 text-xs text-slate-soft mt-1">
                  <span className="inline-flex items-center gap-1">
                    <MapPin className="h-3.5 w-3.5 text-sky-500" />
                    {asianCampaign.venue}
                  </span>
                  <span className="inline-flex items-center gap-1">
                    <Calendar className="h-3.5 w-3.5 text-sky-500" />
                    {asianCampaign.regattaDates}
                  </span>
                </div>
              </div>
              <div className="sm:text-right shrink-0">
                <span className="inline-flex items-center rounded-full bg-sky-500/10 border border-sky-500/20 px-3 py-1 text-xs font-bold text-sky-600 dark:text-sky-300">
                  Travel: {asianCampaign.travelPeriod}
                </span>
              </div>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 text-xs">
              <div className="rounded-xl border border-cool-veil bg-sailcloth p-3 space-y-1">
                <p className="text-[10px] font-bold text-slate-soft uppercase tracking-wider">Team Quota</p>
                <p className="text-sm font-black text-charcoal">Top 4 boys &amp; Top 4 girls</p>
                <p className="text-[11px] text-slate-soft">8 athletes total representation.</p>
              </div>
              <div className="rounded-xl border border-cool-veil bg-sailcloth p-3 space-y-1">
                <p className="text-[10px] font-bold text-slate-soft uppercase tracking-wider">Age Eligibility</p>
                <p className="text-sm font-black text-charcoal">Singapore Citizens born in 2010 or later</p>
                <p className="text-[11px] text-slate-soft">U17 category eligibility.</p>
              </div>
              <div className="rounded-xl border border-cool-veil bg-sailcloth p-3 space-y-1">
                <p className="text-[10px] font-bold text-slate-soft uppercase tracking-wider">Selection Events</p>
                <p className="text-sm font-black text-charcoal">SNSC 2026 + October Trials</p>
                <p className="text-[11px] text-slate-soft">Event 2: 10, 11, 17, 18 Oct 2026.</p>
              </div>
            </div>
          </div>

          {/* Provisional Leaders Grid */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {/* Boys Provisional Leaders */}
            <div className="rounded-2xl border border-cool-veil bg-warm-white p-4 sm:p-5 space-y-3 shadow-xs">
              <div className="flex items-center justify-between pb-2 border-b border-cool-veil">
                <h4 className="text-xs font-black uppercase tracking-wider text-charcoal">
                  Boys Provisional Leaders (Top 4) · After Event 1
                </h4>
                <span className="text-[10px] font-bold px-2 py-0.5 rounded-full bg-blue-500/10 text-blue-600">
                  U17 Boys
                </span>
              </div>
              <div className="space-y-2">
                {leaderBoys.map((boy, idx) => (
                  <div
                    key={boy.sailorId}
                    className="rounded-xl border border-cool-veil bg-sailcloth p-3 flex items-center justify-between gap-3"
                  >
                    <div className="flex items-center gap-2.5 min-w-0">
                      <span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-lg bg-sky-500/10 text-sky-600 font-bold text-xs">
                        #{idx + 1}
                      </span>
                      <div className="min-w-0">
                        <p className="text-xs font-bold text-charcoal truncate">{boy.name}</p>
                        <p className="text-[10px] text-slate-soft">Born {boy.birthYear} · Nat Rank #{boy.nationalRank}</p>
                      </div>
                    </div>
                    <div className="text-right shrink-0">
                      <p className="text-xs font-black text-charcoal font-mono">{boy.snscPoints} pts</p>
                      <p className="text-[10px] text-slate-soft">SNSC Place: {boy.snscPlace}th</p>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* Girls Provisional Leaders */}
            <div className="rounded-2xl border border-cool-veil bg-warm-white p-4 sm:p-5 space-y-3 shadow-xs">
              <div className="flex items-center justify-between pb-2 border-b border-cool-veil">
                <h4 className="text-xs font-black uppercase tracking-wider text-charcoal">
                  Girls Provisional Leaders (Top 4) · After Event 1
                </h4>
                <span className="text-[10px] font-bold px-2 py-0.5 rounded-full bg-pink-500/10 text-pink-600">
                  U17 Girls
                </span>
              </div>
              <div className="space-y-2">
                {leaderGirls.map((girl, idx) => (
                  <div
                    key={girl.sailorId}
                    className="rounded-xl border border-cool-veil bg-sailcloth p-3 flex items-center justify-between gap-3"
                  >
                    <div className="flex items-center gap-2.5 min-w-0">
                      <span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-lg bg-sky-500/10 text-sky-600 font-bold text-xs">
                        #{idx + 1}
                      </span>
                      <div className="min-w-0">
                        <p className="text-xs font-bold text-charcoal truncate">{girl.name}</p>
                        <p className="text-[10px] text-slate-soft">Born {girl.birthYear} · Nat Rank #{girl.nationalRank}</p>
                      </div>
                    </div>
                    <div className="text-right shrink-0">
                      <p className="text-xs font-black text-charcoal font-mono">{girl.snscPoints} pts</p>
                      <p className="text-[10px] text-slate-soft">SNSC Place: {girl.snscPlace}th</p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      )}

      {/* ═════════════════════════════════════════════════════════════════════ */}
      {/* TAB 3: NJTS SQUAD POLICY & PROJECTED ROSTER                         */}
      {/* ═════════════════════════════════════════════════════════════════════ */}
      {activeTab === "njts" && (
        <div className="space-y-6">
          <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6 space-y-4 shadow-xs">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 pb-3 border-b border-cool-veil">
              <div>
                <h2 className="text-lg sm:text-xl font-black text-charcoal">
                  {ILCA4_NJTS_POLICY.title}
                </h2>
                <p className="text-xs text-slate-soft mt-0.5">
                  Selection criteria based on the official Singapore ILCA 4 Ranking System (Top 25 threshold).
                </p>
              </div>
              <span className="inline-flex items-center rounded-full bg-amber-500/10 border border-amber-500/20 px-3 py-1 text-xs font-bold text-amber-600 dark:text-amber-300 shrink-0">
                Squad Quota: Max 16 Sailors
              </span>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 text-xs">
              {ILCA4_NJTS_POLICY.quotaRules.map((rule) => (
                <div key={rule.category} className="rounded-xl border border-cool-veil bg-sailcloth p-3.5 space-y-1">
                  <p className="text-[10px] font-bold text-slate-soft uppercase tracking-wider">{rule.category}</p>
                  <p className="text-base font-black text-charcoal">{rule.total} Sailors ({rule.quotaM}M / {rule.quotaF}F)</p>
                  <p className="text-[11px] text-slate-soft leading-snug">{rule.description}</p>
                </div>
              ))}
            </div>
          </div>

          {/* Projected Squad Table */}
          <div className="rounded-2xl border border-cool-veil overflow-hidden bg-warm-white shadow-xs space-y-2">
            <div className="p-4 border-b border-cool-veil flex items-center justify-between">
              <h3 className="text-xs font-black uppercase tracking-wider text-charcoal">
                National Junior Training Squad (NJTS) · 16-Athlete Selection Matrix
              </h3>
              <span className="text-[11px] font-bold text-slate-soft">
                {njtsSquad.length} Qualified Candidates
              </span>
            </div>

            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs border-collapse">
                <thead className="bg-sailcloth text-[10px] text-slate-soft uppercase tracking-wider border-b border-cool-veil">
                  <tr>
                    <th className="px-4 py-2.5 text-center">Nat Rank</th>
                    <th className="px-4 py-2.5">Sailor</th>
                    <th className="px-3 py-2.5 text-center">Gender</th>
                    <th className="px-3 py-2.5 text-center">Birth Year</th>
                    <th className="px-3 py-2.5 text-center">Allocation Bucket</th>
                    <th className="px-4 py-2.5 text-right">Best 3 Points</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-cool-veil">
                  {njtsSquad.map((sailor) => (
                    <tr key={sailor.sailorId} className="hover:bg-sailcloth transition-colors">
                      <td className="px-4 py-2.5 text-center font-mono font-bold text-slate-soft">
                        #{sailor.nationalRank}
                      </td>
                      <td className="px-4 py-2.5 font-bold text-charcoal">
                        {sailor.name}
                      </td>
                      <td className="px-3 py-2.5 text-center">
                        <span
                          className={`text-[10px] font-bold px-1.5 py-0.5 rounded ${
                            sailor.gender === "F"
                              ? "bg-pink-100 text-pink-700"
                              : "bg-blue-100 text-blue-700"
                          }`}
                        >
                          {sailor.gender}
                        </span>
                      </td>
                      <td className="px-3 py-2.5 text-center font-mono text-slate-soft">
                        {sailor.birthYear ?? "—"}
                      </td>
                      <td className="px-3 py-2.5 text-center">
                        <span className="inline-flex items-center rounded-full bg-sky-500/10 border border-sky-500/20 px-2 py-0.5 text-[10px] font-bold text-sky-600 dark:text-sky-300">
                          {sailor.njtsStatus}
                        </span>
                      </td>
                      <td className="px-4 py-2.5 text-right font-mono font-bold text-charcoal">
                        {sailor.bestThreePoints} pts
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      )}

      {/* ═════════════════════════════════════════════════════════════════════ */}
      {/* TAB 4: COMPLETE 81-SAILOR SCOREBOARD MATRIX                         */}
      {/* ═════════════════════════════════════════════════════════════════════ */}
      {activeTab === "scoreboard" && (
        <div className="space-y-4">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-2 border-b border-cool-veil">
            <div>
              <h2 className="text-base font-bold text-charcoal">
                Singapore ILCA 4 Complete Series Matrix
              </h2>
              <p className="text-xs text-slate-soft">
                All 81 sailors across the 5 official regattas (CSC, SYSC, Temasek, Pesta Sukan, SNSC).
              </p>
            </div>
            <div className="relative w-full sm:w-64">
              <Search className="h-3.5 w-3.5 absolute left-3 top-1/2 -translate-y-1/2 text-slate-soft" />
              <input
                type="text"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                placeholder="Search sailor name…"
                className="w-full rounded-xl border border-cool-veil bg-warm-white pl-8 pr-3 py-1.5 text-xs text-charcoal placeholder:text-slate-soft focus:outline-none focus:border-sky-500"
              />
            </div>
          </div>

          <div className="rounded-2xl border border-cool-veil overflow-hidden bg-warm-white shadow-xs">
            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs border-collapse">
                <thead className="bg-sailcloth text-[10px] text-slate-soft uppercase tracking-wider border-b border-cool-veil">
                  <tr>
                    <th className="px-4 py-3 text-center w-12">Rank</th>
                    <th className="px-4 py-3 min-w-[12rem]">Sailor</th>
                    <th className="px-3 py-3 text-center">Gender</th>
                    <th className="px-3 py-3 text-right">CSC</th>
                    <th className="px-3 py-3 text-right">SYSC</th>
                    <th className="px-3 py-3 text-right">Temasek</th>
                    <th className="px-3 py-3 text-right">Pesta Sukan</th>
                    <th className="px-3 py-3 text-right">SNSC</th>
                    <th className="px-4 py-3 text-right">Best 3 of 5</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-cool-veil">
                  {ILCA4_SELECTION_SAILORS.filter((s) => {
                    if (!searchQuery.trim()) return true;
                    return s.name.toLowerCase().includes(searchQuery.toLowerCase().trim());
                  }).map((s) => (
                    <tr key={s.sailorId} className="hover:bg-sailcloth transition-colors">
                      <td className="px-4 py-2.5 text-center font-mono font-bold text-slate-soft">
                        #{s.nationalRank}
                      </td>
                      <td className="px-4 py-2.5 font-bold text-charcoal">
                        {s.name}
                      </td>
                      <td className="px-3 py-2.5 text-center">
                        <span
                          className={`text-[10px] font-bold px-1.5 py-0.5 rounded ${
                            s.gender === "F"
                              ? "bg-pink-100 text-pink-700"
                              : "bg-blue-100 text-blue-700"
                          }`}
                        >
                          {s.gender}
                        </span>
                      </td>
                      <td className="px-3 py-2.5 text-right font-mono text-slate-soft">{s.cscPoints || "—"}</td>
                      <td className="px-3 py-2.5 text-right font-mono text-slate-soft">{s.syscPoints || "—"}</td>
                      <td className="px-3 py-2.5 text-right font-mono text-slate-soft">{s.temasekPoints || "—"}</td>
                      <td className="px-3 py-2.5 text-right font-mono text-slate-soft">{s.pestaPoints || "—"}</td>
                      <td className="px-3 py-2.5 text-right font-mono text-slate-soft">{s.snscPoints || "—"}</td>
                      <td className="px-4 py-2.5 text-right font-mono font-black text-charcoal">
                        {s.bestThreePoints} pts
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      )}

      {/* ═════════════════════════════════════════════════════════════════════ */}
      {/* TAB 5: POLICY DETAILS & REGULATIONS                                 */}
      {/* ═════════════════════════════════════════════════════════════════════ */}
      {activeTab === "policy" && (
        <div className="space-y-4">
          <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6 space-y-4 shadow-xs">
            <h3 className="text-base font-bold text-charcoal flex items-center gap-2">
              <FileText className="h-4 w-4 text-sky-500" />
              <span>Standard Selection Policy Notes</span>
            </h3>
            <div className="space-y-3 text-xs text-slate-soft leading-relaxed">
              <p>
                1. This policy document shall be read together with the guidelines in the Singapore Sailing Federation Standard Selection Policy.
              </p>
              <p>
                2. Selection decisions by the Athlete Selection Committee are not based solely on trial outcomes and may also take into consideration additional factors, including athlete fitness, training attendance, discipline, attitude, and national coach recommendations.
              </p>
              <p>
                3. All athletes must be Singapore Citizens in good financial standing with the Singapore Sailing Federation and affiliated clubs.
              </p>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
