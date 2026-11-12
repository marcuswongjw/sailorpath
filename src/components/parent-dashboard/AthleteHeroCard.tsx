"use client";

import { profilePhotoUrl } from "@/lib/profilePhoto";

import Link from "next/link";
import { Trophy, User, Sailboat, Compass, ExternalLink } from "lucide-react";
import { relationLabel } from "@/lib/claimRelation";
import { fleetPillClass } from "@/components/sailor-profile/helpers";
import {
  CARD,
  SECONDARY_BTN,
  MUTED,
  INK,
  formatSgFleetLabel,
} from "./styles";
import { formatAgeCategory, type Athlete } from "./types";

export function AthleteHeroCard({
  athlete,
  demoMode = false,
}: {
  athlete: Athlete;
  demoMode?: boolean;
}) {
  const profileHref = demoMode ? "/sample" : `/sailors/${athlete.handle}`;
  const logScoreHref = demoMode
    ? "/sample?view=sailor"
    : `/athlete?id=${athlete.id}&tab=results&action=new`;
  const fleetLabel = formatSgFleetLabel(athlete.standing?.fleet);
  const fleetHref =
    athlete.standing?.fleet === "Gold"
      ? "/sg/optimist/gold"
      : athlete.standing?.fleet === "Silver"
        ? "/sg/optimist/silver"
        : null;

  return (
    <section className={`${CARD} p-4 sm:p-6`}>
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div className="flex items-start gap-3.5 sm:gap-4 min-w-0">
          {athlete.avatarUrl ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img
              src={profilePhotoUrl(athlete.id, athlete.avatarUrl) || undefined}
              alt=""
              className="h-14 w-14 sm:h-16 sm:w-16 rounded-2xl object-cover border-2 border-[var(--sp-cool-veil)] shrink-0"
            />
          ) : (
            <span className="flex h-14 w-14 sm:h-16 sm:w-16 shrink-0 items-center justify-center rounded-2xl bg-[var(--sp-harbour-teal)] text-[var(--sp-sailcloth)] border-2 border-[var(--sp-harbour-teal)]">
              <User className="h-7 w-7" />
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

              {fleetLabel &&
                (fleetHref ? (
                  <Link
                    href={fleetHref}
                    className={`rounded-full border px-2.5 py-1 text-xs font-black uppercase tracking-wider hover:opacity-85 transition-opacity ${fleetPillClass(athlete.standing?.fleet ?? "")}`}
                  >
                    {fleetLabel}
                  </Link>
                ) : (
                  <span
                    className={`rounded-full border px-2.5 py-1 text-xs font-black uppercase tracking-wider ${fleetPillClass(athlete.standing?.fleet ?? "")}`}
                  >
                    {fleetLabel}
                  </span>
                ))}
            </div>
          </div>
        </div>

        <div className="grid grid-cols-2 sm:flex sm:flex-col gap-2 shrink-0 w-full sm:w-auto">
          <Link
            href={logScoreHref}
            className={`${SECONDARY_BTN} min-h-11 w-full sm:w-auto`}
          >
            <Trophy className="h-3.5 w-3.5 text-[var(--sp-racing-orange)]" />
            Log Score ↗
          </Link>
          <Link href={profileHref} className={`${SECONDARY_BTN} min-h-11 w-full sm:w-auto`}>
            Public Profile
            <ExternalLink className="h-3.5 w-3.5" />
          </Link>
        </div>
      </div>
    </section>
  );
}
