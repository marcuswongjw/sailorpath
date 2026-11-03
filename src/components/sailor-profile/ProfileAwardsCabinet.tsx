"use client";

import { sailingClassDisplayLabel } from "@/lib/classPresentation";

import { useId, useMemo, useState } from "react";
import Link from "next/link";
import { Trophy, Compass, Calendar, MapPin } from "lucide-react";
import {
  type SailorPrizeAward,
  type SailorMedalCounts,
} from "@/lib/sailorPrizes";
import { getSailorMedalCounts } from "@/lib/sailorMedalCounts";
import { PROFILE_CARD_CLASS as cardClass } from "./helpers";
import {
  EMPTY_AWARD_FILTERS, awardDateLabel, awardLocation, awardYear, browseSailorAwards,
  type AwardFilters, type AwardSort,
} from "@/lib/sailorAwardBrowse";

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
  const formId = useId();
  const [filters, setFilters] = useState<AwardFilters>(EMPTY_AWARD_FILTERS);
  const [sort, setSort] = useState<AwardSort>("newest");
  const updateFilter = (field: keyof AwardFilters, value: string) => setFilters((current) => ({ ...current, [field]: value }));
  const availableClasses = useMemo(() => [...new Set(awards.map((award) => award.boatClass))].sort(), [awards]);
  const availableYears = useMemo(() => [...new Set(awards.map(awardYear).filter(Boolean))].sort().reverse(), [awards]);
  const availableLocations = useMemo(() => [...new Set(awards.map(awardLocation).filter(Boolean))].sort(), [awards]);
  const filteredAwards = useMemo(() => browseSailorAwards(awards, filters, sort), [awards, filters, sort]);
  const counts: SailorMedalCounts = useMemo(() => getSailorMedalCounts(filteredAwards), [filteredAwards]);
  const hasFilters = Object.keys(EMPTY_AWARD_FILTERS).some((key) => filters[key as keyof AwardFilters] !== EMPTY_AWARD_FILTERS[key as keyof AwardFilters]);
  const invalidRange = Boolean(filters.from && filters.to && filters.from > filters.to);
  const controlClass = "mt-1 w-full min-w-0 rounded-lg border border-cool-veil bg-white px-3 py-2 text-sm text-charcoal focus-visible:outline-2 focus-visible:outline-harbour";

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
                {awards.length} Recorded {awards.length === 1 ? "Honour" : "Honours"}
              </span>
            </div>
            <p className="text-xs text-slate-soft mt-0.5">
              Official award records and recorded podium finishes
            </p>
          </div>
        </div>
      </div>

      <div role="group" aria-label="Award filters" className="space-y-3">
        <div className="grid gap-3 sm:grid-cols-2">
          <label htmlFor={`${formId}-search`} className="text-xs font-bold text-slate-soft">
            Search awards
            <input id={`${formId}-search`} type="search" value={filters.query}
              onChange={(event) => updateFilter("query", event.target.value)}
              placeholder="Event, category or location" className={controlClass} />
          </label>
          <label htmlFor={`${formId}-sort`} className="text-xs font-bold text-slate-soft">
            Sort awards
            <select id={`${formId}-sort`} value={sort} onChange={(event) => setSort(event.target.value as AwardSort)} className={controlClass}>
              <option value="newest">Newest first</option>
              <option value="oldest">Oldest first</option>
              <option value="placing">Best placing</option>
              <option value="event">Event name</option>
              <option value="location">Location</option>
            </select>
          </label>
        </div>
        <div className="grid grid-cols-1 gap-3 sm:grid-cols-2 xl:grid-cols-4">
          <label htmlFor={`${formId}-year`} className="text-xs font-bold text-slate-soft">
            Year
            <select id={`${formId}-year`} value={filters.year} onChange={(event) => updateFilter("year", event.target.value)} className={controlClass}>
              <option value="all">All years</option>
              {availableYears.map((year) => <option key={year} value={year}>{year}</option>)}
            </select>
          </label>
          <label htmlFor={`${formId}-location`} className="text-xs font-bold text-slate-soft">
            Location
            <select id={`${formId}-location`} value={filters.location} onChange={(event) => updateFilter("location", event.target.value)} className={controlClass}>
              <option value="all">All locations</option>
              {availableLocations.map((location) => <option key={location} value={location}>{location}</option>)}
            </select>
          </label>
          <label htmlFor={`${formId}-class`} className="text-xs font-bold text-slate-soft">
            Boat class
            <select id={`${formId}-class`} value={filters.boatClass} onChange={(event) => updateFilter("boatClass", event.target.value)} className={controlClass}>
              <option value="all">All classes</option>
              {availableClasses.map((boatClass) => <option key={boatClass} value={boatClass}>{sailingClassDisplayLabel(boatClass)}</option>)}
            </select>
          </label>
          <label htmlFor={`${formId}-medal`} className="text-xs font-bold text-slate-soft">
            Medal or honour
            <select id={`${formId}-medal`} value={filters.medal} onChange={(event) => updateFilter("medal", event.target.value)} className={controlClass}>
              <option value="all">All honours</option>
              <option value="gold">Gold</option>
              <option value="silver">Silver</option>
              <option value="bronze">Bronze</option>
              <option value="other">Other honours</option>
            </select>
          </label>
        </div>
        <details className="rounded-lg border border-cool-veil px-3 py-2 text-sm">
          <summary className="cursor-pointer font-bold text-harbour">Custom date range</summary>
          <p className="mt-2 text-xs text-slate-soft">Uses the event end date where recorded, otherwise the event date. Awards without a recorded date are excluded from a date range.</p>
          <div className="mt-2 grid gap-3 sm:grid-cols-2">
            <label htmlFor={`${formId}-from`} className="text-xs font-bold text-slate-soft">
              From date
              <input id={`${formId}-from`} type="date" value={filters.from} max={filters.to || undefined}
                onChange={(event) => updateFilter("from", event.target.value)} className={controlClass} aria-invalid={invalidRange}
                aria-describedby={invalidRange ? `${formId}-range-error` : undefined} />
            </label>
            <label htmlFor={`${formId}-to`} className="text-xs font-bold text-slate-soft">
              To date
              <input id={`${formId}-to`} type="date" value={filters.to} min={filters.from || undefined}
                onChange={(event) => updateFilter("to", event.target.value)} className={controlClass} aria-invalid={invalidRange}
                aria-describedby={invalidRange ? `${formId}-range-error` : undefined} />
            </label>
          </div>
          {invalidRange && <p id={`${formId}-range-error`} role="alert" className="mt-2 text-sm text-red-700">Choose a To date on or after the From date.</p>}
        </details>
        <div className="flex items-center justify-between gap-3 text-xs text-slate-soft">
          <p role="status">Showing {filteredAwards.length} of {awards.length} honours · medal counts reflect this view</p>
          {hasFilters && <button type="button" onClick={() => setFilters(EMPTY_AWARD_FILTERS)} className="shrink-0 font-bold text-harbour underline">Clear filters</button>}
        </div>
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
            {counts.podiums}
          </p>
        </div>
      </div>

      {/* ── Awards Grid ─────────────────────────────────────────────── */}
      {filteredAwards.length === 0 && <div className="rounded-xl border border-cool-veil bg-sailcloth p-6 text-center">
        <p className="font-bold text-charcoal">No awards match these filters.</p>
        <p className="mt-1 text-sm text-slate-soft">Try another date or location, or clear your filters.</p>
      </div>}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-3" aria-label="Award list">
        {filteredAwards.map((award) => {
          const style = medalStyle(award.medal, award.rank);
          const regattaHref = award.regattaSlug
            ? `/regattas/${award.regattaSlug}`
            : null;

          return (
            <article
              key={award.id}
              aria-label={`${award.prizeTitle} at ${award.regattaName}`}
              className={`rounded-xl border p-3.5 space-y-2.5 transition-all shadow-xs ${style.tint} ${style.border}`}
            >
              <div className="flex items-start justify-between gap-2.5">
                <div className="flex items-center gap-2.5 min-w-0 flex-1">
                  <span
                    role="img"
                    aria-label={`${award.prizeTitle} ${award.medal === "other" ? "Award" : "Medal"}`}
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
                  {sailingClassDisplayLabel(award.boatClass)}
                </span>
              </div>

              {/* Regatta details */}
              <div className="pt-1 border-t border-cool-veil/50 flex flex-wrap items-center justify-between gap-x-3 gap-y-1 text-xs">
                <div className="flex items-center gap-1.5 min-w-0">
                  <Calendar className="h-3 w-3 text-slate-soft shrink-0" aria-hidden />
                  {regattaHref ? (
                    <Link prefetch={false}
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

                {awardDateLabel(award) && (
                  <span className="text-[11px] text-slate-soft font-medium shrink-0">
                    {awardDateLabel(award)}
                  </span>
                )}
              </div>

              {awardLocation(award) && <p className="flex items-start gap-1.5 text-xs text-slate-soft">
                <MapPin className="mt-0.5 h-3 w-3 shrink-0" aria-hidden />
                <span>{awardLocation(award)}</span>
              </p>}

              {award.sourceUrl && <a href={award.sourceUrl} target="_blank" rel="noopener noreferrer" className="inline-block text-xs font-semibold text-harbour underline">Official award source ↗</a>}
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
            </article>
          );
        })}
      </div>
    </section>
  );
}
