import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { RegattaEventHub } from "@/components/RegattaEventHub";
import { getCachedPublicRegattas } from "@/lib/queries";
import { getRegattaEvent } from "@/lib/regattaEvents";
import { groupedHubForSlug, savedEventHubForSlug } from "@/lib/regattaEventGroups";

export const dynamic = "force-dynamic";
export const metadata: Metadata = { title: "Fleet results | SailorPath" };

export default async function FleetResultsPage({ params }: { params: Promise<{ regatta_slug: string; fleet: string }> }) {
  const { regatta_slug, fleet } = await params;
  let all: Awaited<ReturnType<typeof getCachedPublicRegattas>> = [];
  try { all = await getCachedPublicRegattas(); } catch { all = []; }
  const grouped = getRegattaEvent(regatta_slug) ? null : (savedEventHubForSlug(regatta_slug, all) || groupedHubForSlug(regatta_slug, all));
  const event = getRegattaEvent(regatta_slug) || grouped?.event;
  if (!event || !event.slices.some((slice) => slice.key === fleet)) notFound();
  return <RegattaEventHub event={event} activeFleet={fleet} />;
}
