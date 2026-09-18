"use client";

import { useState } from "react";
import Link from "next/link";
import {
  Trophy,
  Calendar,
  MapPin,
  Users,
  Award,
  AlertCircle,
  FileText,
  ChevronRight,
  ShieldCheck,
} from "lucide-react";
import {
  ILCA4_INTERNATIONAL_CAMPAIGNS,
  ILCA4_NJTS_POLICY,
} from "@/lib/ilcaSelection";

type SelectionTab = "overview" | "eastern" | "asian" | "njts";

export function IlcaSelectionView() {
  const [activeTab, setActiveTab] = useState<SelectionTab>("overview");

  const eastern = ILCA4_INTERNATIONAL_CAMPAIGNS.find(
    (c) => c.id === "eastern-seaboard"
  )!;
  const asian = ILCA4_INTERNATIONAL_CAMPAIGNS.find(
    (c) => c.id === "asian-open"
  )!;

  return (
    <div className="mx-auto w-full max-w-6xl min-w-0 px-3 sm:px-6 lg:px-8 pt-4 pb-12 sm:pt-6 sm:pb-16 space-y-6">
      {/* Breadcrumb back to rankings */}
      <div>
        <Link
          href="/sg/ilca4"
          className="inline-flex items-center gap-1.5 text-xs font-semibold text-slate-soft hover:text-charcoal transition-colors"
        >
          <span>← Back to ILCA 4 National Standings</span>
        </Link>
      </div>

      {/* Hero Header */}
      <div className="rounded-3xl border border-cool-veil bg-warm-white p-5 sm:p-8 shadow-sm space-y-4">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div className="flex items-start gap-3">
            <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-2xl bg-sky-500/10 text-sky-500 border border-sky-500/20">
              <Trophy className="h-6 w-6" />
            </span>
            <div>
              <div className="flex flex-wrap items-center gap-2">
                <span className="text-[10px] font-bold text-sky-500 uppercase tracking-wide">
                  Singapore ILCA 4 Pathway
                </span>
                <span className="inline-flex items-center rounded-full bg-sky-500/10 border border-sky-500/20 px-2 py-0.5 text-[9px] font-bold text-sky-600 dark:text-sky-300">
                  2026 Selection Policies
                </span>
              </div>
              <h1 className="text-2xl sm:text-3xl font-black text-charcoal tracking-tight mt-0.5">
                ILCA 4 Selection Trials &amp; Squad Policies
              </h1>
              <p className="text-xs sm:text-sm text-slate-soft mt-1 leading-relaxed max-w-2xl">
                Official criteria for international representation (Eastern Seaboard Regatta, Asian Open Championships) and the National Junior Training Squad (NJTS).
              </p>
            </div>
          </div>
          <div className="sm:text-right shrink-0">
            <p className="text-[10px] text-slate-soft font-semibold">Policy Authority</p>
            <p className="text-xs font-bold text-charcoal">Singapore Sailing Federation</p>
            <p className="text-[10px] text-slate-soft mt-0.5">Issued 20 Jul 2026 · Amended 1 Sep 2026</p>
          </div>
        </div>

        {/* Tab Navigation */}
        <div className="flex items-center gap-1.5 overflow-x-auto pt-2 border-t border-cool-veil no-scrollbar">
          <button
            type="button"
            onClick={() => setActiveTab("overview")}
            className={`rounded-xl px-3.5 py-2 text-xs font-bold transition-all shrink-0 cursor-pointer ${
              activeTab === "overview"
                ? "bg-sky-500 text-white shadow-sm"
                : "bg-sailcloth text-slate-soft hover:text-charcoal hover:bg-cool-veil/50"
            }`}
          >
            Overview &amp; Calendar
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("eastern")}
            className={`rounded-xl px-3.5 py-2 text-xs font-bold transition-all shrink-0 cursor-pointer ${
              activeTab === "eastern"
                ? "bg-sky-500 text-white shadow-sm"
                : "bg-sailcloth text-slate-soft hover:text-charcoal hover:bg-cool-veil/50"
            }`}
          >
            Eastern Seaboard 2026
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("asian")}
            className={`rounded-xl px-3.5 py-2 text-xs font-bold transition-all shrink-0 cursor-pointer ${
              activeTab === "asian"
                ? "bg-sky-500 text-white shadow-sm"
                : "bg-sailcloth text-slate-soft hover:text-charcoal hover:bg-cool-veil/50"
            }`}
          >
            Asian Open Champs 2026
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("njts")}
            className={`rounded-xl px-3.5 py-2 text-xs font-bold transition-all shrink-0 cursor-pointer ${
              activeTab === "njts"
                ? "bg-sky-500 text-white shadow-sm"
                : "bg-sailcloth text-slate-soft hover:text-charcoal hover:bg-cool-veil/50"
            }`}
          >
            NJTS Squad Policy
          </button>
        </div>
      </div>

      {/* OVERVIEW TAB */}
      {activeTab === "overview" && (
        <div className="space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {/* Eastern Seaboard Card */}
            <div
              onClick={() => setActiveTab("eastern")}
              className="rounded-2xl border border-cool-veil bg-warm-white p-5 space-y-3 cursor-pointer hover:border-sky-500/40 hover:shadow-sm transition-all"
            >
              <div className="flex items-center justify-between">
                <span className="inline-flex items-center rounded-full bg-emerald-500/10 border border-emerald-500/20 px-2 py-0.5 text-[9px] font-bold text-emerald-600 dark:text-emerald-300">
                  Oct – Nov 2026
                </span>
                <ChevronRight className="h-4 w-4 text-slate-soft" />
              </div>
              <h3 className="text-base font-bold text-charcoal">Eastern Seaboard &amp; District Champs</h3>
              <p className="text-xs text-slate-soft leading-snug">Pattaya, Thailand · 28 Oct – 8 Nov 2026</p>
              <div className="pt-2 border-t border-cool-veil space-y-1 text-xs">
                <p className="font-semibold text-charcoal">Quota: Top 3 Boys &amp; Top 3 Girls</p>
                <p className="text-slate-soft">Eligibility: Born 2012 or later</p>
              </div>
            </div>

            {/* Asian Open Card */}
            <div
              onClick={() => setActiveTab("asian")}
              className="rounded-2xl border border-cool-veil bg-warm-white p-5 space-y-3 cursor-pointer hover:border-sky-500/40 hover:shadow-sm transition-all"
            >
              <div className="flex items-center justify-between">
                <span className="inline-flex items-center rounded-full bg-sky-500/10 border border-sky-500/20 px-2 py-0.5 text-[9px] font-bold text-sky-600 dark:text-sky-300">
                  Dec 2026
                </span>
                <ChevronRight className="h-4 w-4 text-slate-soft" />
              </div>
              <h3 className="text-base font-bold text-charcoal">ILCA Asian Open Championships</h3>
              <p className="text-xs text-slate-soft leading-snug">Pattaya, Thailand · 14 – 20 Dec 2026</p>
              <div className="pt-2 border-t border-cool-veil space-y-1 text-xs">
                <p className="font-semibold text-charcoal">Quota: Top 4 Boys &amp; Top 4 Girls</p>
                <p className="text-slate-soft">Eligibility: Born 2010 or later</p>
              </div>
            </div>

            {/* NJTS Squad Card */}
            <div
              onClick={() => setActiveTab("njts")}
              className="rounded-2xl border border-cool-veil bg-warm-white p-5 space-y-3 cursor-pointer hover:border-sky-500/40 hover:shadow-sm transition-all"
            >
              <div className="flex items-center justify-between">
                <span className="inline-flex items-center rounded-full bg-amber-500/10 border border-amber-500/20 px-2 py-0.5 text-[9px] font-bold text-amber-600 dark:text-amber-300">
                  Bi-Annual Intake
                </span>
                <ChevronRight className="h-4 w-4 text-slate-soft" />
              </div>
              <h3 className="text-base font-bold text-charcoal">National Junior Training Squad</h3>
              <p className="text-xs text-slate-soft leading-snug">January &amp; July intakes · Max 16 sailors</p>
              <div className="pt-2 border-t border-cool-veil space-y-1 text-xs">
                <p className="font-semibold text-charcoal">Selection: Singapore ILCA 4 Ranking</p>
                <p className="text-slate-soft">Eligibility: Top 25 overall, age ≤ 17</p>
              </div>
            </div>
          </div>

          {/* Quick Notice */}
          <div className="rounded-2xl border border-cool-veil bg-sailcloth p-4 sm:p-5 flex items-start gap-3">
            <AlertCircle className="h-5 w-5 text-sky-500 shrink-0 mt-0.5" />
            <div className="text-xs sm:text-sm text-slate-soft leading-relaxed space-y-1">
              <strong className="text-charcoal block">Standard Selection Policy Framework</strong>
              <p>
                Selection decisions by the Singapore Sailing Federation Athlete Selection Committee are not based solely on trial outcomes and may also take into consideration additional factors, including athlete fitness, attendance, attitude, and national coach evaluations. All candidates must be Singapore Citizens in good standing.
              </p>
            </div>
          </div>
        </div>
      )}

      {/* EASTERN SEABOARD TAB */}
      {activeTab === "eastern" && (
        <div className="space-y-6">
          <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6 space-y-4">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 pb-3 border-b border-cool-veil">
              <div>
                <h2 className="text-lg sm:text-xl font-black text-charcoal">{eastern.name}</h2>
                <div className="flex flex-wrap items-center gap-3 text-xs text-slate-soft mt-1">
                  <span className="inline-flex items-center gap-1">
                    <MapPin className="h-3.5 w-3.5 text-sky-500" />
                    {eastern.venue}
                  </span>
                  <span className="inline-flex items-center gap-1">
                    <Calendar className="h-3.5 w-3.5 text-sky-500" />
                    {eastern.regattaDates}
                  </span>
                </div>
              </div>
              <span className="inline-flex items-center rounded-full bg-sky-500/10 border border-sky-500/20 px-3 py-1 text-xs font-bold text-sky-600 dark:text-sky-300 shrink-0">
                Travel: {eastern.travelPeriod}
              </span>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div className="rounded-xl border border-cool-veil bg-sailcloth p-4 space-y-1">
                <p className="text-[10px] font-bold text-slate-soft uppercase tracking-wider">Team Quota</p>
                <p className="text-base font-black text-charcoal">{eastern.quota}</p>
                <p className="text-xs text-slate-soft">Separate selection boards for boys and girls.</p>
              </div>
              <div className="rounded-xl border border-cool-veil bg-sailcloth p-4 space-y-1">
                <p className="text-[10px] font-bold text-slate-soft uppercase tracking-wider">Age Eligibility</p>
                <p className="text-base font-black text-charcoal">{eastern.eligibility}</p>
                <p className="text-xs text-slate-soft">Must be born in 2012 or later.</p>
              </div>
            </div>

            {/* Selection Events */}
            <div className="space-y-2 pt-2">
              <h3 className="text-xs font-bold text-slate-soft uppercase tracking-wider">Official Selection Events</h3>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                {eastern.selectionEvents.map((ev, idx) => (
                  <div key={ev.name} className="rounded-xl border border-cool-veil bg-warm-white p-3.5 flex items-start gap-3">
                    <span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-lg bg-sky-500/15 text-sky-500 font-black text-xs">
                      #{idx + 1}
                    </span>
                    <div>
                      <h4 className="font-bold text-charcoal text-xs sm:text-sm">{ev.name}</h4>
                      <p className="text-xs text-slate-soft mt-0.5">{ev.dates}</p>
                      {ev.description && <p className="text-[11px] text-sky-500 mt-1">{ev.description}</p>}
                    </div>
                  </div>
                ))}
              </div>
              <p className="text-xs text-slate-soft pt-1 font-medium">
                Scoring Rule: <strong className="text-charcoal">{eastern.scoringRule}</strong>.
              </p>
            </div>

            {/* Policy Notes */}
            <div className="rounded-xl border border-cool-veil bg-sailcloth/50 p-4 space-y-2">
              <h4 className="text-xs font-bold text-charcoal flex items-center gap-1.5">
                <FileText className="h-3.5 w-3.5 text-sky-500" />
                <span>Policy Notes &amp; Selection Guidelines</span>
              </h4>
              <ul className="space-y-1.5 text-xs text-slate-soft list-disc list-inside">
                {eastern.notes.map((note) => (
                  <li key={note} className="leading-relaxed">{note}</li>
                ))}
              </ul>
            </div>
          </div>
        </div>
      )}

      {/* ASIAN OPEN TAB */}
      {activeTab === "asian" && (
        <div className="space-y-6">
          <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6 space-y-4">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 pb-3 border-b border-cool-veil">
              <div>
                <h2 className="text-lg sm:text-xl font-black text-charcoal">{asian.name}</h2>
                <div className="flex flex-wrap items-center gap-3 text-xs text-slate-soft mt-1">
                  <span className="inline-flex items-center gap-1">
                    <MapPin className="h-3.5 w-3.5 text-sky-500" />
                    {asian.venue}
                  </span>
                  <span className="inline-flex items-center gap-1">
                    <Calendar className="h-3.5 w-3.5 text-sky-500" />
                    {asian.regattaDates}
                  </span>
                </div>
              </div>
              <span className="inline-flex items-center rounded-full bg-sky-500/10 border border-sky-500/20 px-3 py-1 text-xs font-bold text-sky-600 dark:text-sky-300 shrink-0">
                Travel: {asian.travelPeriod}
              </span>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div className="rounded-xl border border-cool-veil bg-sailcloth p-4 space-y-1">
                <p className="text-[10px] font-bold text-slate-soft uppercase tracking-wider">Team Quota</p>
                <p className="text-base font-black text-charcoal">{asian.quota}</p>
                <p className="text-xs text-slate-soft">Separate selection boards for boys and girls.</p>
              </div>
              <div className="rounded-xl border border-cool-veil bg-sailcloth p-4 space-y-1">
                <p className="text-[10px] font-bold text-slate-soft uppercase tracking-wider">Age Eligibility</p>
                <p className="text-base font-black text-charcoal">{asian.eligibility}</p>
                <p className="text-xs text-slate-soft">Must be born in 2010 or later.</p>
              </div>
            </div>

            {/* Selection Events */}
            <div className="space-y-2 pt-2">
              <h3 className="text-xs font-bold text-slate-soft uppercase tracking-wider">Official Selection Events</h3>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                {asian.selectionEvents.map((ev, idx) => (
                  <div key={ev.name} className="rounded-xl border border-cool-veil bg-warm-white p-3.5 flex items-start gap-3">
                    <span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-lg bg-sky-500/15 text-sky-500 font-black text-xs">
                      #{idx + 1}
                    </span>
                    <div>
                      <h4 className="font-bold text-charcoal text-xs sm:text-sm">{ev.name}</h4>
                      <p className="text-xs text-slate-soft mt-0.5">{ev.dates}</p>
                      {ev.description && <p className="text-[11px] text-sky-500 mt-1">{ev.description}</p>}
                    </div>
                  </div>
                ))}
              </div>
              <p className="text-xs text-slate-soft pt-1 font-medium">
                Scoring Rule: <strong className="text-charcoal">{asian.scoringRule}</strong>.
              </p>
            </div>

            {/* Policy Notes */}
            <div className="rounded-xl border border-cool-veil bg-sailcloth/50 p-4 space-y-2">
              <h4 className="text-xs font-bold text-charcoal flex items-center gap-1.5">
                <FileText className="h-3.5 w-3.5 text-sky-500" />
                <span>Policy Notes &amp; Selection Guidelines</span>
              </h4>
              <ul className="space-y-1.5 text-xs text-slate-soft list-disc list-inside">
                {asian.notes.map((note) => (
                  <li key={note} className="leading-relaxed">{note}</li>
                ))}
              </ul>
            </div>
          </div>
        </div>
      )}

      {/* NJTS SQUAD TAB */}
      {activeTab === "njts" && (
        <div className="space-y-6">
          <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6 space-y-5">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 pb-3 border-b border-cool-veil">
              <div>
                <div className="flex items-center gap-2">
                  <Award className="h-5 w-5 text-amber-500" />
                  <h2 className="text-lg sm:text-xl font-black text-charcoal">{ILCA4_NJTS_POLICY.title}</h2>
                </div>
                <p className="text-xs text-slate-soft mt-1">
                  Bi-annual squad selection into Singapore Sailing Federation’s National Junior Training Squad.
                </p>
              </div>
              <Link
                href="/sg/ilca4"
                className="inline-flex items-center gap-1.5 rounded-xl bg-sky-500 px-3 py-1.5 text-xs font-bold text-white hover:bg-sky-600 transition-colors shrink-0"
              >
                <span>View Live Rankings</span>
                <ChevronRight className="h-3.5 w-3.5" />
              </Link>
            </div>

            {/* Key Quota Rules Matrix */}
            <div className="space-y-3">
              <h3 className="text-xs font-bold text-slate-soft uppercase tracking-wider">
                16-Athlete Selection Matrix (Top 25 Overall Only)
              </h3>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                {ILCA4_NJTS_POLICY.quotaRules.map((rule) => (
                  <div key={rule.category} className="rounded-xl border border-cool-veil bg-sailcloth p-4 space-y-1.5">
                    <div className="flex items-center justify-between">
                      <span className="text-[10px] font-bold text-sky-500 uppercase tracking-wider">{rule.category}</span>
                      <span className="text-xs font-extrabold text-charcoal">{rule.total} slots</span>
                    </div>
                    <div className="text-sm font-black text-charcoal">
                      {rule.quotaM} Male · {rule.quotaF} Female
                    </div>
                    <p className="text-xs text-slate-soft leading-snug">{rule.description}</p>
                  </div>
                ))}
              </div>
            </div>

            {/* Roll-down & Eligibility Rules */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div className="rounded-xl border border-cool-veil bg-sailcloth/60 p-4 space-y-2">
                <h4 className="text-xs font-bold text-charcoal flex items-center gap-1.5">
                  <ShieldCheck className="h-4 w-4 text-emerald-500" />
                  <span>Eligibility Requirements</span>
                </h4>
                <ul className="space-y-1.5 text-xs text-slate-soft list-disc list-inside">
                  {ILCA4_NJTS_POLICY.eligibility.map((el) => (
                    <li key={el} className="leading-snug">{el}</li>
                  ))}
                </ul>
              </div>

              <div className="rounded-xl border border-cool-veil bg-sailcloth/60 p-4 space-y-2">
                <h4 className="text-xs font-bold text-charcoal flex items-center gap-1.5">
                  <Users className="h-4 w-4 text-amber-500" />
                  <span>Unfilled Slots &amp; Roll-Down</span>
                </h4>
                <p className="text-xs text-slate-soft leading-relaxed">
                  {ILCA4_NJTS_POLICY.unfilledSlotsRule}
                </p>
                <div className="pt-2 border-t border-cool-veil text-[11px] text-slate-soft space-y-0.5">
                  <p>• July intake cutoff: 30 June ranking</p>
                  <p>• January intake cutoff: 20 December ranking (previous year)</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
