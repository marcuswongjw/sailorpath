import { notFound, redirect } from "next/navigation";
import { DbOffline } from "@/components/DbOffline";
import { PublicRegattaResults } from "@/components/PublicRegattaResults";
import { RegattaEventHeader } from "@/components/RegattaEventHeader";
import { RegattaPrizeWinners } from "@/components/RegattaPrizeWinners";
import { DbUnavailableError } from "@/db";
import { getRegattaBySlug, getResultsForRegatta } from "@/lib/queries";
import {
  eventHubHref,
  findEventSliceForRegattaSlug,
} from "@/lib/regattaEvents";
import { getPrizeWinnersForRegatta } from "@/lib/regattaPrizes";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Optimist regatta results | SailorPath",
  description: "Published Optimist event standings and individual race scores.",
};

export const dynamic = "force-dynamic";

export default async function RegattaDetailPage({
  params,
}: {
  params: Promise<{ regatta_slug: string }>;
}) {
  const { regatta_slug } = await params;
  if (regatta_slug === "cincapura-regatta-2026") {
    redirect("/sg/optimist/regattas/cincapura-regatta-2026-gold");
  }
  let regatta;
  let results;
  let errorMsg: string | null = null;

  try {
    const found = await getRegattaBySlug(regatta_slug);
    if (found) {
      regatta = found;
      results = await getResultsForRegatta(found.id);
    }
  } catch (error) {
    errorMsg = error instanceof DbUnavailableError ? error.message : "DB error";
  }

  if (errorMsg) return <DbOffline message={errorMsg} />;
  if (!regatta || !results) notFound();

  const prizeWinners = getPrizeWinnersForRegatta(regatta_slug);
  const eventSlice = findEventSliceForRegattaSlug(regatta_slug);

  return (
    <div className="mx-auto w-full min-w-0 max-w-7xl space-y-5 px-3 py-8 sm:space-y-6 sm:px-4 sm:py-10">
      <RegattaEventHeader
        name={regatta.name}
        date={String(regatta.date)}
        division={regatta.division}
        totalFleetSize={regatta.totalFleetSize}
        raceCount={regatta.raceCount ?? null}
        series="optimist"
        countsForRanking={regatta.countsForRanking !== false}
        norUrl={regatta.norUrl}
        eventHub={
          eventSlice
            ? {
                href: eventHubHref(eventSlice.event.slug, eventSlice.slice.key),
                label: eventSlice.event.shortName,
              }
            : null
        }
      />
      <PublicRegattaResults
        results={results}
        totalFleetSize={regatta.totalFleetSize}
        raceCount={regatta.raceCount}
        accent="orange"
      />
      {prizeWinners && (
        <RegattaPrizeWinners
          schedule={{ ...prizeWinners.schedule, fleets: prizeWinners.fleets }}
        />
      )}
      <p className="text-[13px] text-[var(--sp-slate-soft)]">
        Source: published regatta results reviewed before import · Parentheses indicate a discarded race score · * DNS · † Overseas commitment
      </p>
    </div>
  );
}
