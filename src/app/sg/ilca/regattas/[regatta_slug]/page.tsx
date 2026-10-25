import { hasOverallPrizeWinners } from "@/lib/regattaPrizes";
import { RegattaFleetPodium } from "@/components/RegattaFleetPodium";
import { prizeWinnerProfileHandles } from "@/lib/prizeWinnerProfiles";
import { notFound, permanentRedirect } from "next/navigation";
import { DbOffline } from "@/components/DbOffline";
import { PublicRegattaResults } from "@/components/PublicRegattaResults";
import { RegattaEventHeader } from "@/components/RegattaEventHeader";
import { RegattaPrizeWinners } from "@/components/RegattaPrizeWinners";
import { DbUnavailableError } from "@/db";
import { isAnyIlcaClass } from "@/lib/ilcaRanking";
import { JsonLd } from "@/components/JsonLd";
import { hubHrefForClassSlug } from "@/lib/regattaEventGroups";
import { getCachedPublicRegattas } from "@/lib/queries";
import {
  loadPublishedRegattaBySlug,
  loadPublishedResults,
  resolveClassScorecard,
} from "@/lib/publicShareData";
import { resultSheetFromRegatta, shareMetadata, sportsEventJsonLd, topFinishers } from "@/lib/publicSeo";
import { fillUnlistedPrizeWinners } from "@/lib/prizeWinnersFromResults";
import { getPrizeDefinitionsForSheet, getPrizeWinnersForRegatta } from "@/lib/regattaPrizes";
import type { Metadata } from "next";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ regatta_slug: string }>;
}): Promise<Metadata> {
  const { regatta_slug } = await params;
  try {
    const loaded = await resolveClassScorecard(regatta_slug, "ilca");
    if (loaded.status === "ready") return shareMetadata(loaded.sheet);
    if (loaded.status === "missing") {
      return shareMetadata({
        title: "Results not found | SailorPath",
        description: "This result sheet is not on SailorPath.",
        canonicalPath: `/sg/ilca/regattas/${encodeURIComponent(regatta_slug)}`,
        index: false,
      });
    }
    return {
      title: "ILCA regatta results | SailorPath",
      description: "Published ILCA event standings and individual race scores.",
    };
  } catch {
    return {
      title: "ILCA regatta results | SailorPath",
      description: "Published ILCA event standings and individual race scores.",
    };
  }
}

export const dynamic = "force-dynamic";

export default async function IlcaRegattaDetailPage({
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
    const found = await loadPublishedRegattaBySlug(regatta_slug);
    if (found && isAnyIlcaClass(found.boatClass)) {
      regatta = found;
      results = await loadPublishedResults(found.id);
    }
  } catch (error) {
    errorMsg = error instanceof DbUnavailableError ? error.message : "DB error";
  }

  if (errorMsg) return <DbOffline message={errorMsg} />;
  if (!regatta || !results) notFound();

  const eventYear = Number(String(regatta.date || "").slice(0, 4));
  const defined = getPrizeDefinitionsForSheet(regatta);
  const calculated = defined
    ? fillUnlistedPrizeWinners(defined.fleets, results, eventYear)
    : null;
  const prizeWinners = calculated?.length
    ? { schedule: defined!.schedule, fleets: calculated }
    : getPrizeWinnersForRegatta(regatta_slug);

  const series = regatta.boatClass?.toLowerCase().includes("6")
    ? "ilca6"
    : regatta.boatClass?.toLowerCase().includes("7")
    ? "ilca7"
    : "ilca4";

  const sheet = resultSheetFromRegatta({
    name: regatta.name,
    boatClass: regatta.boatClass,
    division: regatta.division,
    date: regatta.date,
    endDate: regatta.endDate,
    venue: regatta.venue,
    organizer: regatta.organizer,
    canonicalPath: `/sg/ilca/regattas/${encodeURIComponent(regatta.slug)}`,
    top3: topFinishers(results),
  });
  return (
    <div className="mx-auto w-full min-w-0 max-w-7xl space-y-5 px-3 py-8 sm:space-y-6 sm:px-4 sm:py-10">
      <JsonLd data={sportsEventJsonLd(sheet)} />
      <RegattaEventHeader
        name={regatta.name}
        date={String(regatta.date)}
        endDate={regatta.endDate ? String(regatta.endDate) : null}
        venue={regatta.venue}
        organiser={regatta.organizer}
        division={regatta.division || "Open"}
        totalFleetSize={regatta.totalFleetSize}
        raceCount={regatta.raceCount ?? null}
        series={series}
        geography={regatta.geography}
        countsForRanking={regatta.countsForRanking !== false}
        norUrl={regatta.norUrl}
        officialResultsUrl={regatta.officialResultsUrl}
        officialResultsSourceName={regatta.officialResultsSourceName}
        scheduleNotes={regatta.scheduleNotes}
      />
      {prizeWinners && (
        <RegattaPrizeWinners
          schedule={{ ...prizeWinners.schedule, fleets: prizeWinners.fleets }}
          profileHandles={prizeWinnerProfileHandles(prizeWinners.fleets.flatMap((fleet) => fleet.categories.flatMap((category) => category.winners)), results)}
        />
      )}
      {!hasOverallPrizeWinners(prizeWinners?.fleets || []) && <RegattaFleetPodium results={results} />}
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
