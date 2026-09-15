import Link from "next/link";

export type RegattaEventHeaderProps = {
  name: string;
  date: string;
  division?: string | null;
  totalFleetSize: number;
  raceCount?: number | null;
  /** "optimist" | "ilca4" */
  series: "optimist" | "ilca4";
  countsForRanking?: boolean;
};

/**
 * Shared header for public Optimist / ILCA regatta detail pages.
 */
export function RegattaEventHeader({
  name,
  date,
  division,
  totalFleetSize,
  raceCount,
  series,
  countsForRanking = true,
}: RegattaEventHeaderProps) {
  const isIlca = series === "ilca4";
  const listHref = isIlca ? "/sg/ilca4/regattas" : "/sg/optimist/regattas";
  const rankingsHref = isIlca ? "/sg/ilca4" : "/sg/optimist/gold";
  const classLabel = isIlca ? "ILCA 4" : "Optimist";
  const divLabel = String(division || (isIlca ? "Open" : "—")).trim() || "—";
  const divisionIsNonRanking = /^(non[\s-]?ranking|practice)$/i.test(divLabel);

  return (
    <div className="space-y-3 min-w-0">
      <nav
        aria-label="Breadcrumb"
        className="flex flex-wrap items-center gap-x-2 gap-y-1 text-[11px] sm:text-xs font-bold"
      >
        <Link
          href={rankingsHref}
          className="text-[var(--sp-harbour-teal)] hover:underline"
        >
          {isIlca ? "ILCA 4 rankings" : "Optimist rankings"}
        </Link>
        <span className="text-[var(--sp-slate-soft)]" aria-hidden>
          /
        </span>
        <Link
          href={listHref}
          className="text-[var(--sp-charcoal-slate)] hover:text-[var(--sp-harbour-teal)]"
        >
          Regattas
        </Link>
        <span className="text-[var(--sp-slate-soft)]" aria-hidden>
          /
        </span>
        <span className="text-[var(--sp-slate-soft)] truncate max-w-[12rem] sm:max-w-xs font-medium">
          {name}
        </span>
      </nav>

      <div className="min-w-0">
        <div className="flex flex-wrap items-center gap-2 mb-1.5">
          <span
            className="inline-flex rounded-full px-2.5 py-0.5 text-[10px] font-bold uppercase tracking-wide border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-harbour-teal)]/10 text-[var(--sp-harbour-teal)]"
          >
            {classLabel}
          </span>
          {!divisionIsNonRanking && (
            <span className="inline-flex rounded-full px-2.5 py-0.5 text-[10px] font-bold border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] text-[var(--sp-charcoal-slate)]">
              {divLabel}
            </span>
          )}
          {!countsForRanking && (
            <span className="inline-flex rounded-full px-2.5 py-0.5 text-[10px] font-bold border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] text-[var(--sp-slate-soft)]">
              Non-ranking
            </span>
          )}
        </div>
        <h1 className="text-xl sm:text-2xl font-black text-[var(--sp-harbour-shadow)] leading-snug break-words tracking-tight">
          {name}
        </h1>
        <p className="text-[12px] sm:text-xs text-[var(--sp-charcoal-slate)] mt-1.5 leading-relaxed">
          {date}
          {" · "}
          fleet {totalFleetSize}
          {raceCount != null
            ? ` · ${raceCount} race${raceCount === 1 ? "" : "s"}`
            : ""}
        </p>
        <p className="mt-2 text-[11px] font-semibold text-[var(--sp-slate-soft)]">
          * = DNS · † = overseas commitment
        </p>
      </div>
    </div>
  );
}
