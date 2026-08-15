import { DbOffline } from "@/components/DbOffline";
import { RegattasListClient } from "@/components/RegattasListClient";
import { getCachedPublicRegattas } from "@/lib/queries";
import { DbUnavailableError } from "@/db";
import { isIlcaSeriesClass } from "@/lib/ilcaRanking";

export const revalidate = 60;

export default async function Ilca4RegattasPage() {
  let regattas;
  let errorMsg: string | null = null;

  try {
    const all = await getCachedPublicRegattas();
    regattas = all.filter((r) => isIlcaSeriesClass(r.boatClass, "ILCA 4"));
  } catch (e) {
    errorMsg = e instanceof DbUnavailableError ? e.message : "DB error";
  }

  if (errorMsg || !regattas) {
    return <DbOffline message={errorMsg || "DB error"} />;
  }

  return (
    <RegattasListClient
      title="ILCA 4 regattas"
      badgeLabel="SG ILCA 4"
      description="Singapore ILCA 4 ranking and local events. Optimist events are listed under Optimist → SG Regattas."
      detailBasePath="/sg/ilca4/regattas"
      hideBoatClassFilter
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
        boatClass: r.boatClass ?? "ILCA 4",
        countsForRanking: r.countsForRanking !== false,
      }))}
    />
  );
}
