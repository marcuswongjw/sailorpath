"use client";

import Link from "next/link";
import { FileText, Trophy } from "lucide-react";
import { ILCA6_2027_SELECTION_POLICY } from "@/lib/selectionPolicies2027";
import { SelectionPolicy2027Panel } from "@/components/selection/SelectionPolicy2027Panel";

export function Ilca6SelectionView() {
  const policy = ILCA6_2027_SELECTION_POLICY;

  return (
    <div className="mx-auto w-full max-w-7xl min-w-0 px-3 sm:px-6 lg:px-8 pt-4 pb-12 sm:pt-6 sm:pb-16 space-y-6">
      {/* Breadcrumb & Cross-links */}
      <div className="flex flex-wrap items-center justify-between gap-3">
        <Link
          href="/sg/ilca6"
          className="inline-flex min-h-10 items-center gap-1.5 text-xs font-semibold text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)] transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--sp-harbour-teal)]"
        >
          <span>← Back to ILCA 6 National Standings</span>
        </Link>
        <div className="flex flex-wrap items-center gap-4">
          <Link
            href="/sg/ilca4/selection"
            className="inline-flex min-h-10 items-center gap-1.5 text-xs font-semibold text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)] transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--sp-harbour-teal)]"
          >
            <span>ILCA 4 Selection →</span>
          </Link>
          <Link
            href="/sg/optimist/selection"
            className="inline-flex min-h-10 items-center gap-1.5 text-xs font-semibold text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)] transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--sp-harbour-teal)]"
          >
            <span>Optimist Selection →</span>
          </Link>
        </div>
      </div>

      {/* Hero Header */}
      <header className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-8 shadow-xs space-y-4">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div className="flex items-start gap-3">
            <span className="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)] border border-[var(--sp-harbour-teal)]/25">
              <Trophy className="h-6 w-6" aria-hidden="true" />
            </span>
            <div>
              <div className="flex flex-wrap items-center gap-2">
                <span className="text-[12px] font-bold text-[var(--sp-harbour-teal)] uppercase tracking-wider">
                  Singapore ILCA 6 Pathway
                </span>
                <span className="inline-flex items-center gap-1 rounded-full bg-[var(--sp-aqua-mist)] border border-[var(--sp-harbour-teal)]/30 px-2.5 py-0.5 text-[11px] font-bold text-[var(--sp-harbour-shadow)]">
                  <FileText className="h-3 w-3" aria-hidden="true" />
                  <span>2027 Policy Published</span>
                </span>
              </div>
              <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight mt-0.5">
                ILCA 6 Selection Policies 2027
              </h1>
              <p className="text-xs sm:text-sm text-[var(--sp-slate-soft)] mt-1 leading-relaxed max-w-2xl">
                Official Singapore Sailing Federation selection criteria, quotas, trial events, and funding guidelines for{" "}
                <strong className="text-[var(--sp-harbour-shadow)]">23rd Langkawi International Regatta</strong>,{" "}
                <strong className="text-[var(--sp-harbour-shadow)]">ILCA 6 China Training Camp</strong>,{" "}
                <strong className="text-[var(--sp-harbour-shadow)]">Kieler Woche</strong>,{" "}
                <strong className="text-[var(--sp-harbour-shadow)]">ILCA 6 Youth World Championships</strong>, and{" "}
                <strong className="text-[var(--sp-harbour-shadow)]">Eastern Seaboard Regatta 2027</strong>.
              </p>
            </div>
          </div>

          <div className="md:text-right shrink-0">
            <p className="text-[13px] text-[var(--sp-slate-soft)] font-semibold">
              Policy Authority
            </p>
            <p className="text-xs font-bold text-[var(--sp-harbour-shadow)]">
              {policy.authority}
            </p>
            <p className="text-[13px] text-[var(--sp-slate-soft)] mt-0.5">
              Issued {policy.issuedDate} · {policy.campaigns.length} Campaigns
            </p>
          </div>
        </div>
      </header>

      {/* 2027 Policy Breakdown */}
      <SelectionPolicy2027Panel policy={policy} />
    </div>
  );
}
