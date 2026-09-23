import { notFound, permanentRedirect } from "next/navigation";
import { DbOffline } from "@/components/DbOffline";
import { PublicRegattaResults } from "@/components/PublicRegattaResults";
import { RegattaEventHeader } from "@/components/RegattaEventHeader";
import { RegattaPrizeWinners } from "@/components/RegattaPrizeWinners";
import { DbUnavailableError } from "@/db";
import {
  dinghyClassForBoatClass,
  type DinghyClassKey,
} from "@/lib/classPages";
import { getRegattaBySlug, getResultsForRegatta } from "@/lib/queries";
import {
  eventHubHref,
  findEventSliceForRegattaSlug,
} from "@/lib/regattaEvents";
import { getPrizeWinnersForRegatta } from "@/lib/regattaPrizes";

export async function ClassRegattaDetailPage({
  classKey,
  params,
}: {
  classKey: DinghyClassKey;
  params: Promise<{ regatta_slug: string }>;
}) {
  const { regatta_slug } = await params;
  const eventSlice = findEventSliceForRegattaSlug(regatta_slug);
  if (eventSlice) {
    permanentRedirect(eventHubHref(eventSlice.event.slug, eventSlice.slice.key));
  }

  let regatta;
  let results;
  let errorMsg: string | null = null;

  try {
    const found = await getRegattaBySlug(regatta_slug);
    if (found && dinghyClassForBoatClass(found.boatClass)?.key === classKey) {
      regatta = found;
      results = await getResultsForRegatta(found.id);
    }
  } catch (error) {
    errorMsg = error instanceof DbUnavailableError ? error.message : "DB error";
  }

  if (errorMsg) return <DbOffline message={errorMsg} />;
  if (!regatta || !results) notFound();

  const prizeWinners = getPrizeWinnersForRegatta(regatta_slug);

  return (
    <div className="mx-auto w-full min-w-0 max-w-7xl space-y-5 px-3 py-8 sm:space-y-6 sm:px-4 sm:py-10">
      <RegattaEventHeader
        name={regatta.name}
        date={String(regatta.date)}
        division={regatta.division || "Open"}
        totalFleetSize={regatta.totalFleetSize}
        raceCount={regatta.raceCount ?? null}
        series={classKey}
        countsForRanking={regatta.countsForRanking !== false}
        norUrl={regatta.norUrl}
      />
      <PublicRegattaResults
        results={results}
        totalFleetSize={regatta.totalFleetSize}
        raceCount={regatta.raceCount}
        accent={classKey === "29er" ? "orange" : "sky"}
      />
      {prizeWinners && (
        <RegattaPrizeWinners
          schedule={{ ...prizeWinners.schedule, fleets: prizeWinners.fleets }}
        />
      )}
      <p className="text-[13px] text-[var(--sp-slate-soft)]">
        Source: published regatta results reviewed before import · Parentheses
        indicate a discarded race score · * DNS · † Overseas commitment
      </p>
    </div>
  );
}
