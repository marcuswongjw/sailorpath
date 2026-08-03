import { DbOffline } from "@/components/DbOffline";
import { RegattasListClient } from "@/components/RegattasListClient";
import { listRegattas } from "@/lib/queries";
import { DbUnavailableError } from "@/db";
import { isIlcaSeriesClass } from "@/lib/ilcaRanking";

export const dynamic = "force-dynamic";

export default async function Ilca4RegattasPage() {
  try {
    const all = await listRegattas();
    const regattas = all.filter((r) => isIlcaSeriesClass(r.boatClass, "ILCA 4"));
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
  } catch (e) {
    return (
      <DbOffline
        message={e instanceof DbUnavailableError ? e.message : "DB error"}
      />
    );
  }
}
