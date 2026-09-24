import { DbOffline } from "@/components/DbOffline";
import { RegattasListClient } from "@/components/RegattasListClient";
import { getCachedPublicRegattas } from "@/lib/queries";
import { DbUnavailableError } from "@/db";
import { isAnyIlcaClass } from "@/lib/ilcaRanking";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "ILCA regatta results | SailorPath",
  description: "Browse published Singapore ILCA 4, ILCA 6, and ILCA 7 regatta results, fleet sizes, and individual race scores.",
};

export const revalidate = 60;

export default async function IlcaRegattasPage() {
  let regattas;
  let errorMsg: string | null = null;

  try {
    const all = await getCachedPublicRegattas();
    if (!all || all.length === 0) {
      errorMsg = "Database temporarily offline or connecting";
    } else {
      regattas = all.filter((r) => isAnyIlcaClass(r.boatClass));
    }
  } catch (e) {
    errorMsg = e instanceof DbUnavailableError ? e.message : "DB error";
  }

  if (errorMsg || !regattas) {
    return <DbOffline message={errorMsg || "DB error"} />;
  }

  return (
    <RegattasListClient
      title="ILCA regattas"
      badgeLabel="SG ILCA Series"
      description="Published Singapore ILCA 4, ILCA 6, and ILCA 7 ranking and championship results in one unified view."
      detailBasePath="/sg/ilca/regattas"
      hideBoatClassFilter={false}
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
        boatClass: r.boatClass ?? "ILCA",
        countsForRanking: r.countsForRanking !== false,
      }))}
    />
  );
}
