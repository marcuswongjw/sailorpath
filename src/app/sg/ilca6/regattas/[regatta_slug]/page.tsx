import { notFound, permanentRedirect } from "next/navigation";
import { DbOffline } from "@/components/DbOffline";
import { PublicRegattaResults } from "@/components/PublicRegattaResults";
import { RegattaEventHeader } from "@/components/RegattaEventHeader";
import { RegattaPrizeWinners } from "@/components/RegattaPrizeWinners";
import { DbUnavailableError } from "@/db";
import { isIlcaSeriesClass } from "@/lib/ilcaRanking";
import { hubHrefForClassSlug } from "@/lib/regattaEventGroups";
import { getCachedPublicRegattas, getRegattaBySlug, getResultsForRegatta } from "@/lib/queries";
import { fillUnlistedPrizeWinners } from "@/lib/prizeWinnersFromResults";
import { getPrizeFleetDefinitions, getPrizeWinnersForRegatta } from "@/lib/regattaPrizes";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "ILCA 6 regatta results | SailorPath",
  description: "Published ILCA 6 event standings and individual race scores.",
};

export const dynamic = "force-dynamic";

export default async function Ilca6RegattaDetailPage({
  params,
}: {
  params: Promise<{ regatta_slug: string }>;
}) {
  const { regatta_slug } = await params;
  const published = await getCachedPublicRegattas().catch(() => []);
  const hubHref = hubHrefForClassSlug(regatta_slug, published);
  if (hubHref) permanentRedirect(hubHref);
  let regatta;
  let results;
  let errorMsg: string | null = null;

  try {
    const found = await getRegattaBySlug(regatta_slug);
    if (found && isIlcaSeriesClass(found.boatClass, "ILCA 6")) {
      regatta = found;
      results = await getResultsForRegatta(found.id);
    }
  } catch (error) {
    errorMsg = error instanceof DbUnavailableError ? error.message : "DB error";
  }

  if (errorMsg) return <DbOffline message={errorMsg} />;
  if (!regatta || !results) notFound();

  const eventYear = Number(String(regatta.date || "").slice(0, 4));
  const defined = getPrizeFleetDefinitions(regatta_slug);
  const calculated = defined
    ? fillUnlistedPrizeWinners(defined.fleets, results, eventYear)
    : null;
  const prizeWinners = calculated?.length
    ? { schedule: defined!.schedule, fleets: calculated }
    : getPrizeWinnersForRegatta(regatta_slug);

  return (
    <div className="mx-auto w-full min-w-0 max-w-7xl space-y-5 px-3 py-8 sm:space-y-6 sm:px-4 sm:py-10">
      <RegattaEventHeader
        name={regatta.name}
        date={String(regatta.date)}
        division={regatta.division || "Open"}
        totalFleetSize={regatta.totalFleetSize}
        raceCount={regatta.raceCount ?? null}
        series="ilca6"
        countsForRanking={regatta.countsForRanking !== false}
        norUrl={regatta.norUrl}
      />
      {prizeWinners && (
        <RegattaPrizeWinners
          schedule={{ ...prizeWinners.schedule, fleets: prizeWinners.fleets }}
        />
      )}
      <PublicRegattaResults
        results={results}
        totalFleetSize={regatta.totalFleetSize}
        raceCount={regatta.raceCount}
        accent="sky"
      />
      <p className="text-[13px] text-[var(--sp-slate-soft)]">
        Source: published regatta results reviewed before import · Parentheses indicate a discarded race score · * DNS · † Overseas commitment
      </p>
    </div>
  );
}
