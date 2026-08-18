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

  return (
    <div className="space-y-3 min-w-0">
      <nav
        aria-label="Breadcrumb"
        className="flex flex-wrap items-center gap-x-2 gap-y-1 text-[11px] sm:text-xs font-bold"
      >
        <Link
          href={rankingsHref}
          className={isIlca ? "text-sky-400 hover:text-sky-300" : "text-orange-400 hover:text-orange-300"}
        >
          {isIlca ? "ILCA 4 rankings" : "Optimist rankings"}
        </Link>
        <span className="text-slate-600" aria-hidden>
          /
        </span>
        <Link
          href={listHref}
          className="text-slate-400 hover:text-white"
        >
          Regattas
        </Link>
        <span className="text-slate-600" aria-hidden>
          /
        </span>
        <span className="text-slate-500 truncate max-w-[12rem] sm:max-w-xs">
          {name}
        </span>
      </nav>

      <div className="min-w-0">
        <div className="flex flex-wrap items-center gap-2 mb-1.5">
          <span
            className={`inline-flex rounded-full px-2 py-0.5 text-[10px] font-bold uppercase tracking-wide border ${
              isIlca
                ? "bg-sky-500/15 text-sky-300 border-sky-500/30"
                : "bg-orange-500/15 text-orange-300 border-orange-500/30"
            }`}
          >
            {classLabel}
          </span>
          <span className="inline-flex rounded-full px-2 py-0.5 text-[10px] font-bold border bg-white/5 text-slate-300 border-white/10">
            {divLabel}
          </span>
          {!countsForRanking && (
            <span className="inline-flex rounded-full px-2 py-0.5 text-[10px] font-bold border bg-sky-500/10 text-sky-300 border-sky-500/25">
              Non-ranking
            </span>
          )}
        </div>
        <h1 className="text-xl sm:text-2xl font-black text-white leading-snug break-words">
          {name}
        </h1>
        <p className="text-[12px] sm:text-xs text-slate-400 mt-1.5 leading-relaxed">
          {date}
          {" · "}
          fleet {totalFleetSize}
          {raceCount != null
            ? ` · ${raceCount} race${raceCount === 1 ? "" : "s"}`
            : ""}
        </p>
        <p className={`mt-2 text-[11px] font-semibold ${isIlca ? "text-sky-400/90" : "text-orange-400/90"}`}>
          * = DNS · † = overseas commitment
        </p>
      </div>
    </div>
  );
}
