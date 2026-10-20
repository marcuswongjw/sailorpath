import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { JsonLd } from "@/components/JsonLd";
import { RegattaEventHub } from "@/components/RegattaEventHub";
import { withSavedEventCopy } from "@/lib/loadRegattaEventCopy";
import { resolveFleetResultSheet } from "@/lib/publicShareData";
import { shareMetadata, sportsEventJsonLd } from "@/lib/publicSeo";

export const dynamic = "force-dynamic";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ regatta_slug: string; fleet: string }>;
}): Promise<Metadata> {
  const { regatta_slug, fleet } = await params;
  try {
    const resolved = await resolveFleetResultSheet(regatta_slug, fleet);
    if (!resolved) {
      return shareMetadata({
        title: "Results not found | SailorPath",
        description: "This result sheet is not on SailorPath.",
        canonicalPath: "/regattas",
        index: false,
      });
    }
    return shareMetadata(resolved.sheet);
  } catch {
    return {
      title: "Fleet results | SailorPath",
      description: "Published regatta results on SailorPath.",
    };
  }
}

export default async function FleetResultsPage({
  params,
}: {
  params: Promise<{ regatta_slug: string; fleet: string }>;
}) {
  const { regatta_slug, fleet } = await params;
  const resolved = await resolveFleetResultSheet(regatta_slug, fleet);
  if (!resolved) notFound();
  return (
    <>
      <JsonLd data={sportsEventJsonLd(resolved.sheet)} />
      <RegattaEventHub event={await withSavedEventCopy(resolved.event)} activeFleet={fleet} />
    </>
  );
}
