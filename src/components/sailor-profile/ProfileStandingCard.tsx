"use client";

import Link from "next/link";
import { Trophy } from "lucide-react";
import type { SeriesStandingProps } from "./types";

export type ProfileStandingCardProps = {
  standing: SeriesStandingProps;
  standingIsIlca: boolean;
  seriesDnsCount: number;
  cardClass: string;
};

/**
 * National ranking strip showing series standing or ILCA 4 ranking.
 * Desktop: 5-column grid of regatta scores. Mobile: condensed list.
 */
export function ProfileStandingCard({
  standing,
  standingIsIlca,
  seriesDnsCount,
  cardClass,
}: ProfileStandingCardProps) {
  return (
    <section
      id="profile-standing"
      className={`${cardClass} p-4 sm:p-5 scroll-mt-28`}
    >
      <div className="flex flex-wrap items-start justify-between gap-3">
        <div className="flex items-start gap-2.5 min-w-0">
          <div
            className={`mt-0.5 flex h-7 w-7 shrink-0 items-center justify-center rounded-full ${
              standingIsIlca
                ? "bg-aqua-mist text-harbour"
                : "bg-racing-mist/30 text-racing-orange"
            }`}
          >
            <Trophy className="h-3.5 w-3.5" />
          </div>
          <div>
            <p className="text-[13px] font-bold text-harbour-shadow">
              {standingIsIlca ? "ILCA 4 national ranking" : "Series standing"}
            </p>
            <p className="text-[13px] text-slate-soft">
              {standing.periodLabel}
              <span className="text-cool-veil"> · </span>
              <span
                className={`font-semibold ${
                  standingIsIlca ? "text-harbour" : "text-racing-orange"
                }`}
              >
                {standingIsIlca
                  ? standing.fleet || "Open fleet"
                  : `${standing.fleet} fleet`}
              </span>
            </p>
          </div>
        </div>
        <div className="text-right">
          <p className="text-[12px] font-bold uppercase tracking-[0.12em] text-slate-soft">
            National rank
          </p>
          <p
            className={`text-3xl sm:text-4xl font-black tabular-nums leading-none ${
              standingIsIlca ? "text-harbour" : "text-racing-orange"
            }`}
          >
            #{standing.overallRank}
          </p>
          <p className="text-[12px] text-slate-soft mt-1 tabular-nums font-medium">
            of {standing.fleetSize}
            {standingIsIlca ? "" : ` · ${standing.fleet}`}
          </p>
          <p className="text-[13px] text-slate-soft mt-1.5 tabular-nums">
            Best 3 of 5{" "}
            <span className="font-bold text-charcoal">
              {standing.best3of5}
              {standingIsIlca ? " pts" : ""}
            </span>
          </p>
        </div>
      </div>

      {/* Desktop: 5-column score grid */}
      <div className="mt-4 hidden sm:grid grid-cols-5 gap-2">
        {Array.from({ length: 5 }).map((_, i) => {
          const r = standing.rScores[i];
          const shortName = r?.regattaName
            ? r.regattaName
                .replace(/National Ranking Series/i, "NRS")
                .replace(/National Regatta/i, "NR")
                .replace(/Championships?/i, "Champs")
            : null;
          const slotEmpty =
            !r || r.regattaName === "—" || r.regattaName === "";
          const optimistEmpty =
            !standingIsIlca &&
            Boolean(
              r &&
                r.isDNS &&
                r.score === 0 &&
                !r.isOverseasCommitment
            );
          const empty = slotEmpty || optimistEmpty;
          const showIlcaScore = standingIsIlca && r && !slotEmpty;
          return (
            <div
              key={i}
              className="rounded-xl border border-cool-veil bg-sailcloth/60 px-2 py-3 text-center min-h-[5.5rem] flex flex-col"
              title={r?.regattaName}
            >
              <p
                className={`text-[13px] font-bold tracking-wide ${
                  standingIsIlca ? "text-harbour" : "text-racing-orange"
                }`}
              >
                R{i + 1}
              </p>
              <p className="text-[12px] sm:text-[13px] font-medium text-charcoal leading-snug mt-1.5 line-clamp-2 flex-1 px-0.5">
                {empty && !showIlcaScore ? "—" : shortName || "—"}
              </p>
              {showIlcaScore ? (
                <div className="mt-2 space-y-0.5">
                  <p className="text-lg font-black text-harbour-shadow tabular-nums leading-none">
                    {r!.finishPlace != null && r!.finishPlace > 0
                      ? `#${r!.finishPlace}`
                      : "DNC"}
                  </p>
                  <p className="text-[13px] font-bold text-harbour tabular-nums">
                    {r!.score} pts
                  </p>
                </div>
              ) : (
                <p className="text-xl font-black text-charcoal tabular-nums mt-2">
                  {empty
                    ? "—"
                    : `${r!.score}${r!.isOverseasCommitment ? "†" : r!.isDNS ? "*" : ""}${r!.isCarryForward ? " CF" : ""}`}
                </p>
              )}
            </div>
          );
        })}
      </div>

      {/* Mobile: condensed list */}
      <ul className="mt-4 sm:hidden divide-y divide-cool-veil rounded-xl border border-cool-veil bg-sailcloth/40 overflow-hidden">
        {Array.from({ length: 5 }).map((_, i) => {
          const r = standing.rScores[i];
          const empty =
            !r ||
            r.regattaName === "—" ||
            (r.isDNS &&
              r.score === 0 &&
              !r.isOverseasCommitment &&
              r.finishPlace == null &&
              !standingIsIlca);
          const ilcaMiss =
            standingIsIlca &&
            r &&
            (r.finishPlace == null || r.finishPlace <= 0) &&
            (r.isDNS || r.score === 0);
          return (
            <li
              key={i}
              className="flex items-center justify-between gap-3 px-3.5 py-3"
            >
              <div className="min-w-0 flex items-center gap-2.5">
                <span
                  className={`shrink-0 text-[13px] font-bold w-6 ${
                    standingIsIlca ? "text-harbour" : "text-racing-orange"
                  }`}
                >
                  R{i + 1}
                </span>
                <span className="text-[13px] font-medium text-charcoal truncate">
                  {empty && !standingIsIlca
                    ? "—"
                    : r?.regattaName && r.regattaName !== "—"
                      ? r.regattaName
                      : "—"}
                </span>
              </div>
              {standingIsIlca && r && r.regattaName !== "—" ? (
                <span className="shrink-0 text-right">
                  <span className="block text-base font-black text-harbour-shadow tabular-nums leading-none">
                    {r.finishPlace != null && r.finishPlace > 0
                      ? `#${r.finishPlace}`
                      : ilcaMiss || r.isDNS
                        ? "DNC"
                        : "—"}
                  </span>
                  <span className="block text-[13px] font-bold text-harbour tabular-nums mt-0.5">
                    {r.score} pts
                  </span>
                </span>
              ) : (
                <span className="shrink-0 text-lg font-black text-charcoal tabular-nums">
                  {empty
                    ? "—"
                    : `${r!.score}${r!.isOverseasCommitment ? "†" : r!.isDNS ? "*" : ""}${r!.isCarryForward ? " CF" : ""}`}
                </span>
              )}
            </li>
          );
        })}
      </ul>

      {!standingIsIlca && (
        <p className="mt-3 text-[13px] text-slate-soft leading-relaxed">
          <span className="font-bold text-charcoal">Key: </span>
          <span className="tabular-nums font-medium">CF</span> = carry-forward ·{" "}
          <span className="tabular-nums font-medium">*</span> = DNS (did not start;
          series score = fleet size + 1) ·{" "}
          <span className="tabular-nums font-medium">†</span> = overseas commitment
        </p>
      )}
      {!standingIsIlca && seriesDnsCount > 0 && (
        <p className="mt-1.5 text-[13px] text-slate-soft leading-relaxed">
          {seriesDnsCount} missed ranking{" "}
          {seriesDnsCount === 1 ? "event" : "events"} in this window
          (DNS) — listed under Results below and on the position trend.
        </p>
      )}
      {standing.trendNote && (
        <p className="mt-2 text-[13px] font-bold text-harbour">
          {standing.trendNote}
        </p>
      )}
      <Link
        href={
          standingIsIlca
            ? "/sg/ilca4"
            : `/sg/optimist/${String(standing.fleet).toLowerCase()}`
        }
        className="inline-flex items-center gap-1 mt-2 text-[12px] font-bold text-harbour hover:text-harbour-shadow"
      >
        {standingIsIlca
          ? "View full ILCA 4 standings →"
          : `View full ${standing.fleet} standings →`}
      </Link>
    </section>
  );
}
