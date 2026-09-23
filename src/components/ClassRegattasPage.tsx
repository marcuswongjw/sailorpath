import { DbOffline } from "@/components/DbOffline";
import { RegattasListClient } from "@/components/RegattasListClient";
import { DbUnavailableError } from "@/db";
import {
  dinghyClassForBoatClass,
  dinghyClassPage,
  type DinghyClassKey,
} from "@/lib/classPages";
import { getCachedPublicRegattas } from "@/lib/queries";

export async function ClassRegattasPage({
  classKey,
}: {
  classKey: DinghyClassKey;
}) {
  const cls = dinghyClassPage(classKey);
  let regattas;
  let errorMsg: string | null = null;

  try {
    const all = await getCachedPublicRegattas();
    if (!all || all.length === 0) {
      errorMsg = "Database temporarily offline or connecting";
    } else {
      regattas = all.filter(
        (regatta) => dinghyClassForBoatClass(regatta.boatClass)?.key === classKey
      );
    }
  } catch (error) {
    errorMsg = error instanceof DbUnavailableError ? error.message : "DB error";
  }

  if (errorMsg || !regattas) {
    return <DbOffline message={errorMsg || "DB error"} />;
  }

  return (
    <RegattasListClient
      title={`${cls.label} regattas`}
      badgeLabel={cls.badgeLabel}
      description={cls.description}
      detailBasePath={cls.regattasPath}
      hideBoatClassFilter
      hideDivisionFilter
      accent={classKey === "29er" ? "orange" : "sky"}
      emptyMessage={`No published ${cls.label} regattas yet. Results appear here after they are imported.`}
      regattas={regattas.map((regatta) => ({
        id: regatta.id,
        name: regatta.name,
        slug: regatta.slug,
        date: regatta.date,
        totalFleetSize: regatta.totalFleetSize,
        division: regatta.division,
        raceCount: regatta.raceCount ?? null,
        geography: regatta.geography ?? "SG",
        boatClass: regatta.boatClass ?? cls.label,
        countsForRanking: regatta.countsForRanking !== false,
      }))}
    />
  );
}
