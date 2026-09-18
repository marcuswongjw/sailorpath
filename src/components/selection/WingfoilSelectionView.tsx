"use client";

import Link from "next/link";
import {
  Wind,
  Calendar,
  ExternalLink,
  ShieldCheck,
  Plane,
  AlertTriangle,
  FileText,
  DollarSign,
  Award,
} from "lucide-react";
import { WINGFOIL_FUNDING_POLICY } from "@/lib/wingfoilSelection";

export function WingfoilSelectionView() {
  const policy = WINGFOIL_FUNDING_POLICY;

  return (
    <div className="mx-auto w-full max-w-5xl min-w-0 px-3 sm:px-6 lg:px-8 pt-4 pb-12 sm:pt-6 sm:pb-16 space-y-6">
      {/* Breadcrumb back to rankings */}
      <div>
        <Link
          href="/sg/wingfoil"
          className="inline-flex items-center gap-1.5 text-xs font-semibold text-slate-soft hover:text-charcoal transition-colors"
        >
          <span>← Back to WingFoil Standings</span>
        </Link>
      </div>

      {/* Hero Header */}
      <div className="rounded-3xl border border-cool-veil bg-warm-white p-5 sm:p-8 shadow-sm space-y-4">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div className="flex items-start gap-3">
            <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-2xl bg-teal-500/10 text-teal-600 border border-teal-500/20">
              <Wind className="h-6 w-6" />
            </span>
            <div>
              <div className="flex flex-wrap items-center gap-2">
                <span className="text-[10px] font-bold text-teal-600 uppercase tracking-wide">
                  Singapore WingFoil Pathway
                </span>
                <span className="inline-flex items-center rounded-full bg-teal-500/10 border border-teal-500/20 px-2 py-0.5 text-[9px] font-bold text-teal-700 dark:text-teal-300">
                  Event Funding Policy
                </span>
              </div>
              <h1 className="text-2xl sm:text-3xl font-black text-charcoal tracking-tight mt-0.5">
                {policy.title}
              </h1>
              <p className="text-xs sm:text-sm text-slate-soft mt-1 leading-relaxed max-w-2xl">
                {policy.covers}
              </p>
            </div>
          </div>
          <div className="sm:text-right shrink-0">
            <p className="text-[10px] text-slate-soft font-semibold">Policy Authority</p>
            <p className="text-xs font-bold text-charcoal">{policy.authority}</p>
            <p className="text-[10px] text-slate-soft mt-0.5">
              Policy Date: {policy.policyDate} · Amended: {policy.amendedDate}
            </p>
          </div>
        </div>

        {/* Survey Deadline Callout Banner */}
        <div className="rounded-2xl border border-amber-500/30 bg-amber-500/10 p-4 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div className="space-y-0.5">
            <div className="flex items-center gap-2">
              <Calendar className="h-4 w-4 text-amber-600 dark:text-amber-400" />
              <p className="text-xs font-bold text-amber-800 dark:text-amber-200 uppercase tracking-wide">
                Category Selection Survey Deadline: {policy.qualifier.surveyDeadline}
              </p>
            </div>
            <p className="text-xs text-slate-soft">
              Athletes must choose which category they will participate in for funding support prior to the qualifying event.
            </p>
          </div>
          <a
            href={policy.qualifier.surveyUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="inline-flex items-center gap-1.5 rounded-xl bg-amber-500 hover:bg-amber-600 px-3.5 py-2 text-xs font-bold text-white transition-colors shrink-0 shadow-sm"
          >
            <span>Complete Survey</span>
            <ExternalLink className="h-3.5 w-3.5" />
          </a>
        </div>
      </div>

      {/* 3 Funded Athlete Categories */}
      <div className="space-y-3">
        <h2 className="text-xs font-bold text-slate-soft uppercase tracking-wider">
          3 Funded Athlete Spots Available
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {policy.categories.map((cat) => (
            <div
              key={cat.code}
              className="rounded-2xl border border-cool-veil bg-warm-white p-5 space-y-2 shadow-xs"
            >
              <div className="flex items-center justify-between">
                <span className="inline-flex items-center rounded-full bg-teal-500/10 border border-teal-500/20 px-2 py-0.5 text-[10px] font-extrabold text-teal-700 dark:text-teal-300">
                  {cat.code}
                </span>
                <span className="text-xs font-bold text-slate-soft">{cat.quota} funded spot</span>
              </div>
              <h3 className="text-base font-black text-charcoal">{cat.name}</h3>
              <p className="text-xs text-slate-soft leading-snug">{cat.description}</p>
            </div>
          ))}
        </div>
      </div>

      {/* Qualifying Regatta & Equipment */}
      <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6 space-y-4 shadow-xs">
        <div className="flex items-center gap-2 border-b border-cool-veil pb-3">
          <Award className="h-5 w-5 text-teal-600" />
          <h2 className="text-base sm:text-lg font-bold text-charcoal">
            Qualifying Event: {policy.qualifier.event}
          </h2>
        </div>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 text-xs">
          <div className="rounded-xl border border-cool-veil bg-sailcloth p-4 space-y-1">
            <p className="font-bold text-slate-soft uppercase tracking-wider text-[10px]">Dates</p>
            <p className="text-sm font-extrabold text-charcoal">{policy.qualifier.dates}</p>
            <p className="text-slate-soft">Mandatory participation: non-attendees will not be considered.</p>
          </div>
          <div className="rounded-xl border border-cool-veil bg-sailcloth p-4 space-y-1">
            <p className="font-bold text-slate-soft uppercase tracking-wider text-[10px]">Equipment Format</p>
            <p className="text-sm font-extrabold text-charcoal">SSF X-15 One-Design</p>
            <p className="text-slate-soft leading-snug">{policy.qualifier.equipment}</p>
          </div>
        </div>
      </div>

      {/* Funding Split & Athlete Cap */}
      <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6 space-y-4 shadow-xs">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 border-b border-cool-veil pb-3">
          <div className="flex items-center gap-2">
            <DollarSign className="h-5 w-5 text-emerald-600" />
            <h2 className="text-base sm:text-lg font-bold text-charcoal">
              Funding: What SSF Covers vs. What You Pay
            </h2>
          </div>
          <span className="inline-flex items-center rounded-full bg-emerald-500/15 border border-emerald-500/30 px-3 py-1 text-xs font-black text-emerald-700 dark:text-emerald-300">
            Athlete Contribution Capped at {policy.costSplit.cap}
          </span>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div className="rounded-xl border border-emerald-500/20 bg-emerald-500/5 p-4 space-y-2">
            <p className="text-xs font-black text-emerald-800 dark:text-emerald-300 uppercase tracking-wider flex items-center gap-1.5">
              <ShieldCheck className="h-4 w-4 text-emerald-600" />
              <span>Singapore Sailing Federation Covers</span>
            </p>
            <ul className="space-y-1.5 text-xs text-slate-soft list-disc list-inside">
              {policy.costSplit.ssfCovers.map((item) => (
                <li key={item} className="leading-snug">{item}</li>
              ))}
            </ul>
          </div>

          <div className="rounded-xl border border-cool-veil bg-sailcloth p-4 space-y-2">
            <p className="text-xs font-black text-charcoal uppercase tracking-wider flex items-center gap-1.5">
              <Plane className="h-4 w-4 text-slate-soft" />
              <span>Athlete Covers</span>
            </p>
            <ul className="space-y-1.5 text-xs text-slate-soft list-disc list-inside">
              {policy.costSplit.athleteCovers.map((item) => (
                <li key={item} className="leading-snug">{item}</li>
              ))}
            </ul>
            <p className="text-[11px] text-slate-soft pt-1 border-t border-cool-veil">
              Exact contribution confirmed upon selection; payable before team departure.
            </p>
          </div>
        </div>
      </div>

      {/* Equipment Deposits & Safety Gear */}
      <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6 space-y-3 shadow-xs">
        <h2 className="text-xs font-bold text-slate-soft uppercase tracking-wider">
          Equipment, Deposits &amp; Safety Requirements
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-3 text-xs">
          {policy.equipmentDeposits.map((dep) => (
            <div key={dep.type} className="rounded-xl border border-cool-veil bg-sailcloth p-4 space-y-1">
              <p className="font-bold text-charcoal">{dep.type}</p>
              <p className="text-sm font-black text-teal-600">{dep.amount}</p>
              <p className="text-slate-soft leading-snug">{dep.terms}</p>
            </div>
          ))}
        </div>
      </div>

      {/* Eligibility & Appeals */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 text-xs">
        <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 space-y-2 shadow-xs">
          <h3 className="font-bold text-charcoal flex items-center gap-1.5">
            <ShieldCheck className="h-4 w-4 text-teal-600" />
            <span>Eligibility Requirements</span>
          </h3>
          <ul className="space-y-1.5 text-slate-soft list-disc list-inside">
            {policy.eligibility.map((el) => (
              <li key={el} className="leading-snug">{el}</li>
            ))}
          </ul>
        </div>

        <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 space-y-2 shadow-xs">
          <h3 className="font-bold text-charcoal flex items-center gap-1.5">
            <AlertTriangle className="h-4 w-4 text-amber-600" />
            <span>Appeals Process</span>
          </h3>
          <p className="text-slate-soft leading-snug">
            Appeals must be submitted <strong>{policy.appeals.deadline}</strong> to:
          </p>
          <p className="text-charcoal font-semibold">{policy.appeals.addressTo}</p>
          <p className="text-slate-soft text-[11px]">
            {policy.appeals.bond} · {policy.appeals.conditions}
          </p>
        </div>
      </div>

      {/* Federation Context Footer */}
      <div className="rounded-2xl border border-cool-veil bg-sailcloth p-4 flex items-start gap-3 text-xs text-slate-soft">
        <FileText className="h-4 w-4 text-slate-soft shrink-0 mt-0.5" />
        <p className="leading-relaxed">
          {policy.context}
        </p>
      </div>
    </div>
  );
}
