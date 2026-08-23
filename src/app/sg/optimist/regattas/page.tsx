import { DbOffline } from "@/components/DbOffline";
import { RegattasListClient } from "@/components/RegattasListClient";
import { getCachedPublicRegattas } from "@/lib/queries";
import { DbUnavailableError } from "@/db";
import { isIlcaSeriesClass } from "@/lib/ilcaRanking";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Optimist regatta results | SailorPath",
  description: "Browse published Singapore Optimist regatta results, fleet sizes, and individual race scores.",
};

export const revalidate = 60;

function isOptimistClass(boatClass: string | null | undefined): boolean {
  const s = String(boatClass || "Optimist")
    .trim()
    .toLowerCase();
  if (!s || s === "optimist" || s === "opti") return true;
  // Explicitly exclude ILCA
  if (isIlcaSeriesClass(boatClass, "ILCA 4") || isIlcaSeriesClass(boatClass, "ILCA 6"))
    return false;
  return true;
}

export default async function OptimistRegattasPage() {
  let all;
  try {
    all = await getCachedPublicRegattas();
  } catch (e) {
    return (
      <DbOffline
        message={e instanceof DbUnavailableError ? e.message : "DB error"}
      />
    );
  }

  const regattas = all.filter((r) => isOptimistClass(r.boatClass));
  return (
    <RegattasListClient
      title="Optimist regattas"
      badgeLabel="SG Optimist"
      description="Published Singapore Optimist ranking series and local event results. ILCA 4 events are listed separately under ILCA 4 regattas."
      detailBasePath="/sg/optimist/regattas"
      hideBoatClassFilter
      accent="orange"
      regattas={regattas.map((r) => ({
        id: r.id,
        name: r.name,
        slug: r.slug,
        date: r.date,
        totalFleetSize: r.totalFleetSize,
        division: r.division,
        raceCount: r.raceCount ?? null,
        geography: r.geography ?? "SG",
        boatClass: r.boatClass ?? "Optimist",
        countsForRanking: r.countsForRanking !== false,
      }))}
    />
  );
}
