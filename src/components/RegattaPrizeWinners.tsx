"use client";

import { useState } from "react";
import Link from "next/link";
import { Trophy, Award, School, Compass, ChevronDown } from "lucide-react";
import type { RegattaPrizeSchedule, RegattaPrizeFleet, PrizeCategory } from "@/lib/regattaPrizes";

type Props = {
  schedule: RegattaPrizeSchedule;
  filterFleet?: string; // e.g. "Optimist Gold", "ILCA 4"
  /** Real profile handles keyed by a normalised sailor name. */
  profileHandles?: Record<string, string>;
};

export function prizeNameKey(name: string): string {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, " ")
    .trim();
}

export function RegattaPrizeWinners({ schedule, filterFleet, profileHandles }: Props) {
  const matched = filterFleet
    ? schedule.fleets.filter(
        (f) =>
          f.fleetName.toLowerCase().includes(filterFleet.toLowerCase()) ||
          f.boatClass.toLowerCase().includes(filterFleet.toLowerCase())
      )
    : schedule.fleets;

  const fleetsToDisplay = matched
    .map((fleet) => ({
      ...fleet,
      categories: fleet.categories.filter((category) => category.winners.length > 0),
    }))
    .filter((fleet) => fleet.categories.length > 0);

  const [selectedFleetIdx, setSelectedFleetIdx] = useState(0);
  const currentFleet: RegattaPrizeFleet | undefined =
    fleetsToDisplay[selectedFleetIdx] || fleetsToDisplay[0];

  if (!currentFleet) return null;

  return (
    <section
      aria-label="Official NoR Prize Winners"
      className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 sm:p-6 shadow-xs space-y-5"
    >
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-[var(--sp-cool-veil)] pb-4">
        <div>
          <div className="inline-flex items-center gap-1.5 rounded-full bg-amber-500/10 border border-amber-500/30 px-2.5 py-0.5 text-xs font-bold text-amber-800">
            <Trophy className="h-3.5 w-3.5 text-amber-600" />
            Official Notice of Race (NoR) Prizes
          </div>
          <h2 className="text-lg sm:text-xl font-black text-[var(--sp-harbour-shadow)] tracking-tight mt-1.5">
            Verified Prize Winners &amp; Podiums
          </h2>
          <p className="text-xs text-[var(--sp-slate-soft)] mt-0.5">
            Awarded per Section 19 of the official Notice of Race ({schedule.regattaName})
          </p>
        </div>

        {fleetsToDisplay.length > 1 && (
          <div className="flex flex-wrap gap-1.5">
            {fleetsToDisplay.map((f, idx) => {
              const active = idx === selectedFleetIdx;
              return (
                <button
                  key={f.fleetName}
                  type="button"
                  onClick={() => setSelectedFleetIdx(idx)}
                  className={`rounded-lg px-3 py-1.5 text-xs font-bold transition-colors cursor-pointer ${
                    active
                      ? "bg-[var(--sp-harbour-teal)] text-white shadow-xs"
                      : "bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal)] hover:bg-[var(--sp-cool-veil)]"
                  }`}
                >
                  {f.fleetName}
                </button>
              );
            })}
          </div>
        )}
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-3.5 sm:gap-4">
        {currentFleet.categories.map((cat: PrizeCategory) => (
          <article
            key={cat.categoryName}
            className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/60 p-3.5 space-y-3 flex flex-col justify-between"
          >
            <div>
              <div className="flex items-center justify-between gap-2 border-b border-[var(--sp-cool-veil)] pb-2">
                <span className="text-xs font-black uppercase tracking-wider text-[var(--sp-harbour-shadow)]">
                  {cat.categoryName}
                </span>
                <span className="rounded-full bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] px-2 py-0.5 text-[10px] font-bold text-[var(--sp-slate-soft)]">
                  {cat.prizesAwarded}
                </span>
              </div>
              {cat.eligibilityNotes && (
                <p className="text-[11px] text-[var(--sp-slate-soft)] italic mt-1.5 leading-snug">
                  {cat.eligibilityNotes}
                </p>
              )}
            </div>

            <div className="space-y-1.5">
              {cat.winners.map((w) => {
                const isFirst = w.rank === 1;
                const isSecond = w.rank === 2;
                const isThird = w.rank === 3;
                const medalBg = isFirst
                  ? "bg-amber-400 text-slate-950 shadow-xs"
                  : isSecond
                  ? "bg-slate-300 text-slate-950"
                  : isThird
                  ? "bg-amber-700 text-amber-100"
                  : "bg-[var(--sp-warm-white)] text-[var(--sp-slate-soft)] border border-[var(--sp-cool-veil)]";

                return (
                  <div
                    key={`${w.rank}-${w.sailorName}`}
                    className="flex items-start gap-2.5 rounded-lg bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)]/80 p-2 text-xs"
                  >
                    <span
                      className={`inline-flex h-5 w-5 shrink-0 items-center justify-center rounded-full font-black text-[10px] ${medalBg}`}
                      title={w.prizeTitle}
                    >
                      {w.rank}
                    </span>
                    <div className="min-w-0 flex-1">
                      <div className="flex items-baseline justify-between gap-1">
                        <PrizeSailorName
                          name={w.sailorName}
                          handle={profileHandles?.[prizeNameKey(w.sailorName)]}
                        />
                        {w.sailNumber && (
                          <span className="font-mono text-[10px] text-[var(--sp-charcoal)] shrink-0">
                            #{w.sailNumber}
                          </span>
                        )}
                      </div>
                      {(w.club || w.schoolName) && (
                        <div className="flex flex-wrap items-center gap-x-2 gap-y-0.5 text-[10px] text-[var(--sp-charcoal)] mt-0.5">
                          {w.schoolName && (
                            <span className="inline-flex items-center gap-0.5 truncate max-w-[12rem]">
                              <School className="h-2.5 w-2.5 shrink-0" />
                              {w.schoolName}
                            </span>
                          )}
                          {w.club && (
                            <span className="inline-flex items-center gap-0.5 truncate max-w-[10rem]">
                              <Compass className="h-2.5 w-2.5 shrink-0" />
                              {w.club}
                            </span>
                          )}
                        </div>
                      )}
                      {w.notes && (
                        <p className="text-[10px] text-[var(--sp-racing-deep)] font-medium mt-0.5">
                          {w.notes}
                        </p>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          </article>
        ))}
      </div>
    </section>
  );
}

function PrizeSailorName({ name, handle }: { name: string; handle?: string }) {
  if (!handle) {
    return <span className="font-bold text-[var(--sp-charcoal)] truncate">{name}</span>;
  }
  return (
    <Link
      href={`/${handle}`}
      className="font-bold text-[var(--sp-harbour-shadow)] hover:text-[var(--sp-racing-orange)] truncate"
    >
      {name}
    </Link>
  );
}
