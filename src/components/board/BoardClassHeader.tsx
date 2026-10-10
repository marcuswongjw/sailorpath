import Link from "next/link";
import { Compass, Sailboat, Wind } from "lucide-react";
import {
  boardClassDefinition,
  type BoardClassKey,
  type BoardClassSourceCounts,
} from "@/lib/boardClassHub";

const CLASS_ICONS = {
  wingfoil: Wind,
  techno293: Compass,
  iqfoil: Sailboat,
} as const;

export function BoardClassHeader({
  classKey,
  publishedRecordCount,
  sourceCounts,
}: {
  classKey: BoardClassKey;
  publishedRecordCount: number;
  sourceCounts: BoardClassSourceCounts;
}) {
  const definition = boardClassDefinition(classKey);
  const Icon = CLASS_ICONS[classKey];
  const sourceSummary = [
    sourceCounts.canonical > 0
      ? `${sourceCounts.canonical} canonical class sheet${sourceCounts.canonical === 1 ? "" : "s"}`
      : null,
    sourceCounts.specialist > 0
      ? `${sourceCounts.specialist} specialist scorecard${sourceCounts.specialist === 1 ? "" : "s"}`
      : null,
  ]
    .filter(Boolean)
    .join(" · ");

  return (
    <header className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-xs sm:p-6">
      <div className="flex flex-col gap-5 lg:flex-row lg:items-end lg:justify-between">
        <div className="flex min-w-0 items-start gap-3.5">
          <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-2xl border border-[var(--sp-harbour-teal)]/25 bg-[var(--sp-harbour-teal)]/10 text-[var(--sp-harbour-teal)] sm:h-12 sm:w-12">
            <Icon className="h-5 w-5 sm:h-6 sm:w-6" aria-hidden="true" />
          </span>
          <div className="min-w-0">
            <p className="text-[11px] font-black uppercase tracking-[0.18em] text-[var(--sp-harbour-teal)]">
              Singapore board &amp; foil racing
            </p>
            <h1 className="mt-1 text-2xl font-black tracking-tight text-[var(--sp-harbour-shadow)] sm:text-3xl">
              {definition.label}
            </h1>
            <p className="mt-2 max-w-2xl text-sm leading-relaxed text-[var(--sp-charcoal-slate)]">
              {definition.summary}
            </p>
          </div>
        </div>
        <Link
          href={definition.calendarHref}
          className="inline-flex min-h-11 shrink-0 items-center justify-center rounded-xl border border-[var(--sp-harbour-teal)]/30 bg-[var(--sp-harbour-teal)]/10 px-4 text-sm font-bold text-[var(--sp-harbour-teal)] transition-colors hover:bg-[var(--sp-harbour-teal)]/15 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[var(--sp-racing-orange)]"
        >
          View class calendar
        </Link>
      </div>

      <div className="mt-5 grid gap-3 border-t border-[var(--sp-cool-veil)] pt-4 sm:grid-cols-[minmax(0,1fr)_auto] sm:items-center">
        <div>
          <p className="text-xs font-black uppercase tracking-wider text-[var(--sp-charcoal)]">
            {definition.policyLabel}
          </p>
          <p className="mt-1 text-xs leading-relaxed text-[var(--sp-charcoal-slate)]">
            {definition.policyDescription}
          </p>
        </div>
        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-3.5 py-2.5 text-right">
          <p className="text-lg font-black tabular-nums text-[var(--sp-harbour-shadow)]">
            {publishedRecordCount}
          </p>
          <p className="text-[10px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">
            published records
          </p>
          {sourceSummary ? (
            <p className="mt-1 max-w-64 text-[10px] font-medium leading-relaxed text-[var(--sp-charcoal-slate)]">
              {sourceSummary}
            </p>
          ) : null}
        </div>
      </div>
    </header>
  );
}
