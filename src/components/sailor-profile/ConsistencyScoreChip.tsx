"use client";

import { useState } from "react";
import Link from "next/link";
import { Info } from "lucide-react";
import type { ConsistencyScoreResult } from "@/lib/consistencyScore";

function bandClass(score: Extract<ConsistencyScoreResult, { status: "ready" }>): string {
  if (score.band === "very_consistent") {
    return "bg-emerald-100 text-emerald-800 border border-emerald-300";
  }
  if (score.band === "consistent") {
    return "bg-amber-100 text-amber-800 border border-amber-300";
  }
  return "bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal)] border border-[var(--sp-cool-veil)]";
}

/**
 * Consistency number, plain-language band, and a short explanation.
 * Sits beside the profile's percentile badge.
 */
export function ConsistencyScoreChip({
  score,
}: {
  score: ConsistencyScoreResult;
}) {
  const [open, setOpen] = useState(false);
  const ready = score.status === "ready";
  const summary = ready
    ? `Consistency ${score.score}, ${score.bandLabel}. ${score.basisLabel}`
    : `Consistency, not enough races yet. ${score.periodLabel}`;

  return (
    <div className="min-w-0">
      <div className="flex flex-wrap items-center gap-2">
        {ready ? (
          <span
            className={`rounded-full px-2.5 py-1 text-[12px] font-bold ${bandClass(score)}`}
            aria-label={summary}
          >
            Consistency {score.score}
            <span className="font-semibold"> · {score.bandLabel}</span>
          </span>
        ) : (
          <span
            className="rounded-full border border-cool-veil bg-warm-white px-2.5 py-1 text-[12px] font-bold text-charcoal"
            aria-label={summary}
          >
            Not enough races yet
          </span>
        )}
        {ready && (
          <span className="text-[12px] font-medium text-slate-soft">
            {score.basisLabel}
          </span>
        )}
        <button
          type="button"
          aria-expanded={open}
          aria-controls="profile-consistency"
          onClick={() => setOpen((value) => !value)}
          className="inline-flex items-center gap-1 rounded-full border border-cool-veil bg-warm-white px-2 py-0.5 text-[12px] font-bold text-harbour hover:bg-aqua-mist"
        >
          <Info className="h-3 w-3" aria-hidden />
          What this means
        </button>
      </div>
      {open && (
        <p
          id="profile-consistency"
          className="mt-2 max-w-xl text-[13px] leading-relaxed text-charcoal"
        >
          {score.explanation}{" "}
          <Link
            href="/how-rankings-work#consistency"
            className="font-bold text-harbour hover:underline"
          >
            How this is calculated
          </Link>
        </p>
      )}
    </div>
  );
}
