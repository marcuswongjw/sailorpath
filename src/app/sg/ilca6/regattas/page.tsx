import { DbOffline } from "@/components/DbOffline";
import { RegattasListClient } from "@/components/RegattasListClient";
import { getCachedPublicRegattas } from "@/lib/queries";
import { DbUnavailableError } from "@/db";
import { isIlcaSeriesClass } from "@/lib/ilcaRanking";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "ILCA 6 regatta results | SailorPath",
  description: "Browse published Singapore ILCA 6 regatta results, fleet sizes, and individual race scores.",
};

export const revalidate = 60;

export default async function Ilca6RegattasPage() {
  let regattas;
  let errorMsg: string | null = null;

  try {
    const all = await getCachedPublicRegattas();
    if (!all || all.length === 0) {
      errorMsg = "Database temporarily offline or connecting";
    } else {
      regattas = all.filter((r) => isIlcaSeriesClass(r.boatClass, "ILCA 6"));
    }
  } catch (e) {
    errorMsg = e instanceof DbUnavailableError ? e.message : "DB error";
  }

  if (errorMsg || !regattas) {
    return <DbOffline message={errorMsg || "DB error"} />;
  }

  return (
    <RegattasListClient
      title="ILCA 6 regattas"
      badgeLabel="SG ILCA 6"
      description="Published Singapore ILCA 6 ranking and local event results."
      detailBasePath="/sg/ilca6/regattas"
      hideBoatClassFilter
      hideDivisionFilter
      accent="sky"
      regattas={regattas.map((r) => ({
        id: r.id,
        name: r.name,
        slug: r.slug,
        date: r.date,
        totalFleetSize: r.totalFleetSize,
        division: r.division,
        raceCount: r.raceCount ?? null,
        geography: r.geography ?? "SG",
        boatClass: r.boatClass ?? "ILCA 6",
        countsForRanking: r.countsForRanking !== false,
      }))}
    />
  );
}
