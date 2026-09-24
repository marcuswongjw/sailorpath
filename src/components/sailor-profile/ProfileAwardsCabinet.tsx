"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import { Trophy, Compass, Calendar } from "lucide-react";
import {
  type SailorPrizeAward,
  type SailorMedalCounts,
  getSailorMedalCounts,
} from "@/lib/sailorPrizes";
import { PROFILE_CARD_CLASS as cardClass } from "./helpers";

interface Props {
  awards: SailorPrizeAward[];
  sailorName: string;
  isOwner?: boolean;
}

function medalStyle(medal: "gold" | "silver" | "bronze" | "other", rank: number) {
  if (medal === "gold" || rank === 1) return { bg: "#FFD700", fg: "#1a1a1a", border: "border-[#FFD700]/40", tint: "bg-[#FFFDF0]" };
  if (medal === "silver" || rank === 2) return { bg: "#C0C0C0", fg: "#1a1a1a", border: "border-[#C0C0C0]/50", tint: "bg-[#F9F9F9]" };
  if (medal === "bronze" || rank === 3) return { bg: "#CD7F32", fg: "#ffffff", border: "border-[#CD7F32]/40", tint: "bg-[#FDF6ED]" };
  return { bg: "var(--sp-warm-white)", fg: "var(--sp-charcoal)", border: "border-cool-veil", tint: "bg-warm-white" };
}

export function ProfileAwardsCabinet({ awards, sailorName }: Props) {
  const counts: SailorMedalCounts = useMemo(() => getSailorMedalCounts(awards), [awards]);
  const [classFilter, setClassFilter] = useState<string>("all");

  const availableClasses = useMemo(() => {
    const set = new Set<string>();
    awards.forEach((a) => set.add(a.boatClass));
    return Array.from(set);
  }, [awards]);

  const filteredAwards = useMemo(() => {
    if (classFilter === "all") return awards;
    return awards.filter((a) => a.boatClass === classFilter);
  }, [awards, classFilter]);

  if (awards.length === 0) {
    return (
      <section
        id="profile-awards"
        aria-label="Awards and Honours"
        className={`${cardClass} p-5 sm:p-6 text-center space-y-3 scroll-mt-28`}
      >
        <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-2xl bg-sailcloth border border-cool-veil text-slate-soft">
          <Trophy className="h-6 w-6" />
        </div>
        <div>
          <h2 className="text-base sm:text-lg font-black text-charcoal">
            Awards &amp; Honours
          </h2>
          <p className="text-xs sm:text-sm text-slate-soft mt-1 max-w-md mx-auto">
            No official Notice of Race (NoR) awards or podium finishes are currently recorded for {sailorName}.
          </p>
        </div>
      </section>
    );
  }

  return (
    <section
      id="profile-awards"
      aria-label="Awards and Honours"
      className={`${cardClass} p-4 sm:p-6 space-y-5 scroll-mt-28`}
    >
      {/* ── Header ─────────────────────────────────────────────────── */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-cool-veil pb-4">
        <div className="flex items-start gap-3">
          <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-harbour/10 text-harbour border border-harbour/20">
            <Trophy className="h-5 w-5" />
          </div>
          <div>
            <div className="flex items-center gap-2 flex-wrap">
              <h2 className="text-lg sm:text-xl font-black text-charcoal tracking-tight">
                Awards &amp; Honours
              </h2>
              <span className="rounded-full bg-amber-100 border border-amber-300 px-2.5 py-0.5 text-[10px] font-bold text-amber-900">
                {awards.length} Verified {awards.length === 1 ? "Prize" : "Prizes"}
              </span>
            </div>
            <p className="text-xs text-slate-soft mt-0.5">
              Official podium finishes and awards per Notice of Race (NoR)
            </p>
          </div>
        </div>

        {/* Boat class filter chips (if multiple classes) */}
        {availableClasses.length > 1 && (
          <div className="flex items-center gap-1.5 flex-wrap">
            <button
              type="button"
              onClick={() => setClassFilter("all")}
              className={`px-2.5 py-1 rounded-lg text-xs font-bold transition-colors cursor-pointer ${
                classFilter === "all"
                  ? "bg-harbour text-white shadow-xs"
                  : "bg-sailcloth border border-cool-veil text-slate-soft hover:text-charcoal"
              }`}
            >
              All ({awards.length})
            </button>
            {availableClasses.map((cls) => {
              const count = awards.filter((a) => a.boatClass === cls).length;
              return (
                <button
                  key={cls}
                  type="button"
                  onClick={() => setClassFilter(cls)}
                  className={`px-2.5 py-1 rounded-lg text-xs font-bold transition-colors cursor-pointer ${
                    classFilter === cls
                      ? "bg-harbour text-white shadow-xs"
                      : "bg-sailcloth border border-cool-veil text-slate-soft hover:text-charcoal"
                  }`}
                >
                  {cls} ({count})
                </button>
              );
            })}
          </div>
        )}
      </div>

      {/* ── Medal Counts Strip ─────────────────────────────────────── */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-2.5">
        <div className="rounded-xl border border-amber-300/80 bg-[#FFFDF0] p-3 text-center shadow-xs">
          <p className="text-[11px] font-black uppercase tracking-wider text-amber-900">
            🥇 Gold Medals
          </p>
          <p className="text-2xl font-black text-amber-950 mt-0.5 tabular-nums">
            {counts.gold}
          </p>
        </div>
        <div className="rounded-xl border border-slate-300 bg-[#F9F9F9] p-3 text-center shadow-xs">
          <p className="text-[11px] font-black uppercase tracking-wider text-slate-800">
            🥈 Silver Medals
          </p>
          <p className="text-2xl font-black text-slate-900 mt-0.5 tabular-nums">
            {counts.silver}
          </p>
        </div>
        <div className="rounded-xl border border-amber-700/30 bg-[#FDF6ED] p-3 text-center shadow-xs">
          <p className="text-[11px] font-black uppercase tracking-wider text-amber-900">
            🥉 Bronze Medals
          </p>
          <p className="text-2xl font-black text-amber-950 mt-0.5 tabular-nums">
            {counts.bronze}
          </p>
        </div>
        <div className="rounded-xl border border-cool-veil bg-warm-white p-3 text-center shadow-xs">
          <p className="text-[11px] font-black uppercase tracking-wider text-slate-soft">
            🏆 Total Podiums
          </p>
          <p className="text-2xl font-black text-charcoal mt-0.5 tabular-nums">
            {counts.total}
          </p>
        </div>
      </div>

      {/* ── Awards Grid ─────────────────────────────────────────────── */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
        {filteredAwards.map((award) => {
          const style = medalStyle(award.medal, award.rank);
          const regattaHref = award.regattaSlug
            ? award.boatClass.toLowerCase().includes("ilca")
              ? `/sg/ilca/regattas/${award.regattaSlug}`
              : `/regattas/${award.regattaSlug}`
            : null;

          return (
            <div
              key={award.id}
              className={`rounded-xl border p-3.5 space-y-2.5 transition-all shadow-xs ${style.tint} ${style.border}`}
            >
              <div className="flex items-start justify-between gap-2.5">
                <div className="flex items-center gap-2.5 min-w-0 flex-1">
                  <span
                    role="img"
                    aria-label={`${award.prizeTitle} Medal`}
                    className="inline-flex h-7 w-7 shrink-0 items-center justify-center rounded-full font-black text-xs shadow-xs"
                    style={{ backgroundColor: style.bg, color: style.fg }}
                  >
                    {award.rank}
                  </span>
                  <div className="min-w-0 flex-1">
                    <p className="font-black text-charcoal text-sm leading-tight break-words">
                      {award.prizeTitle}
                    </p>
                    <p className="text-[11px] font-bold text-harbour mt-0.5">
                      {award.categoryName} · {award.fleetName}
                    </p>
                  </div>
                </div>

                <span className="rounded-md border border-cool-veil bg-white/80 px-2 py-0.5 text-[10px] font-black text-charcoal shrink-0">
                  {award.boatClass}
                </span>
              </div>

              {/* Regatta details */}
              <div className="pt-1 border-t border-cool-veil/50 flex flex-wrap items-center justify-between gap-x-3 gap-y-1 text-xs">
                <div className="flex items-center gap-1.5 min-w-0">
                  <Calendar className="h-3 w-3 text-slate-soft shrink-0" aria-hidden />
                  {regattaHref ? (
                    <Link
                      href={regattaHref}
                      className="font-bold text-charcoal hover:text-harbour hover:underline truncate"
                      title={award.regattaName}
                    >
                      {award.regattaName}
                    </Link>
                  ) : (
                    <span className="font-bold text-charcoal truncate">
                      {award.regattaName}
                    </span>
                  )}
                </div>

                {award.datesText && (
                  <span className="text-[11px] text-slate-soft font-medium shrink-0">
                    {award.datesText}
                  </span>
                )}
              </div>

              {/* Metadata subline: Club, School, Sail #, and Notes */}
              {(award.club || award.schoolName || award.sailNumber || award.notes) && (
                <div className="flex flex-wrap items-center gap-1.5 text-[11px] text-slate-soft pt-0.5">
                  {award.club && (
                    <span className="inline-flex items-center gap-1 text-slate-700 font-medium">
                      <Compass className="h-3 w-3 text-harbour" aria-hidden />
                      <span className="truncate max-w-[10rem]">{award.club}</span>
                    </span>
                  )}
                  {award.club && award.sailNumber && <span>·</span>}
                  {award.sailNumber && (
                    <span className="font-mono font-bold text-charcoal">
                      #{award.sailNumber}
                    </span>
                  )}
                  {award.schoolName && (
                    <>
                      <span>·</span>
                      <span className="text-slate-600 truncate max-w-[12rem]">
                        {award.schoolName}
                      </span>
                    </>
                  )}
                  {award.notes && (
                    <span className="ml-auto inline-block rounded bg-harbour/10 border border-harbour/20 px-1.5 py-0.2 text-[10px] font-bold text-harbour">
                      {award.notes}
                    </span>
                  )}
                </div>
              )}
            </div>
          );
        })}
      </div>
    </section>
  );
}
