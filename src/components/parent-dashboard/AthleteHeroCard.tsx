"use client";

import Link from "next/link";
import { Trophy, User, Sailboat, Compass, ExternalLink } from "lucide-react";
import { relationLabel } from "@/lib/claimRelation";
import { fleetPillClass } from "@/components/sailor-profile/helpers";
import {
  CARD,
  SECONDARY_BTN,
  MUTED,
  INK,
} from "./styles";
import { formatAgeCategory, type Athlete } from "./types";

export function AthleteHeroCard({ athlete }: { athlete: Athlete }) {
  return (
    <section className={`${CARD} p-5 sm:p-7`}>
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div className="flex items-start gap-4">
          {athlete.avatarUrl ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img
              src={athlete.avatarUrl}
              alt=""
              className="h-16 w-16 sm:h-20 sm:w-20 rounded-2xl object-cover border-2 border-[var(--sp-cool-veil)] shrink-0"
            />
          ) : (
            <span className="flex h-16 w-16 sm:h-20 sm:w-20 shrink-0 items-center justify-center rounded-2xl bg-[var(--sp-harbour-teal)] text-[var(--sp-sailcloth)] border-2 border-[var(--sp-harbour-teal)]">
              <User className="h-8 w-8" />
            </span>
          )}
          <div className="min-w-0">
            <div className="flex flex-wrap items-center gap-2">
              <h2 className={`text-xl sm:text-2xl font-black ${INK} tracking-tight`}>
                {athlete.name}
              </h2>
              {athlete.ownerRelation && (
                <span className="rounded-full border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)] px-2.5 py-0.5 text-[11px] font-black uppercase tracking-wider text-[var(--sp-harbour-teal)]">
                  {relationLabel(athlete.ownerRelation)}
                </span>
              )}
              {athlete.nationalSquadStatus && (
                <span className="rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2.5 py-0.5 text-[11px] font-black uppercase tracking-wider text-[var(--sp-charcoal-slate)]">
                  {athlete.nationalSquadStatus}
                </span>
              )}
            </div>

            <p className={`text-xs sm:text-sm ${MUTED} mt-1 flex flex-wrap items-center gap-x-2 gap-y-1`}>
              <span className={`font-semibold ${INK}`}>{athlete.club}</span>
              {athlete.school && (
                <>
                  <span aria-hidden>·</span>
                  <span>{athlete.school}</span>
                </>
              )}
              {athlete.dob && (
                <>
                  <span aria-hidden>·</span>
                  <span className="font-mono text-xs">
                    {formatAgeCategory(athlete.dob)}
                  </span>
                </>
              )}
            </p>

            <div className="flex flex-wrap items-center gap-2 mt-2.5">
              <span className="rounded-full border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)] px-2.5 py-1 text-xs font-mono font-bold text-[var(--sp-harbour-teal)] inline-flex items-center gap-1.5">
                <Sailboat className="h-3.5 w-3.5" />
                Opti {athlete.sailNumber}
              </span>

              {athlete.sailNumberIlca4 && (
                <span className="rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2.5 py-1 text-xs font-mono font-bold text-[var(--sp-harbour-shadow)] inline-flex items-center gap-1.5">
                  <Compass className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)]" />
                  ILCA 4 {athlete.sailNumberIlca4}
                </span>
              )}

              {athlete.boardNumber && (
                <span className="rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2.5 py-1 text-xs font-mono font-bold text-[var(--sp-harbour-shadow)] inline-flex items-center gap-1.5">
                  Board {athlete.boardNumber}
                </span>
              )}

              {athlete.standing?.fleet && (
                <span
                  className={`rounded-full border px-2.5 py-1 text-xs font-black uppercase tracking-wider ${fleetPillClass(athlete.standing.fleet)}`}
                >
                  {athlete.standing.fleet} Fleet
                </span>
              )}
            </div>
          </div>
        </div>

        <div className="flex flex-wrap sm:flex-col gap-2 shrink-0">
          <Link
            href={`/athlete?id=${athlete.id}&tab=results&action=new`}
            className={SECONDARY_BTN}
          >
            <Trophy className="h-3.5 w-3.5 text-[var(--sp-racing-orange)]" />
            Log Score & Evidence ↗
          </Link>
          <Link href={`/${athlete.handle}`} className={SECONDARY_BTN}>
            Public Profile
            <ExternalLink className="h-3.5 w-3.5" />
          </Link>
          {athlete.standing?.fleet === "Gold" && (
            <Link href="/sg/optimist/gold" className={SECONDARY_BTN}>
              <Trophy className="h-3.5 w-3.5 text-[var(--sp-racing-orange)]" />
              Gold Leaderboard
            </Link>
          )}
          {athlete.standing?.fleet === "Silver" && (
            <Link href="/sg/optimist/silver" className={SECONDARY_BTN}>
              <Trophy className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)]" />
              Silver Leaderboard
            </Link>
          )}
        </div>
      </div>
    </section>
  );
}
