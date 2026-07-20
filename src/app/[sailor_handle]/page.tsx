import { notFound } from "next/navigation";
import { DbOffline } from "@/components/DbOffline";
import { SailorProfileView } from "@/components/SailorProfileView";
import {
  getSailorByHandle,
  getResultsForSailor,
  getSailorSeriesStanding,
  getRaceObservationsForSailor,
  getEquipmentLogsForSailor,
} from "@/lib/queries";
import { DbUnavailableError } from "@/db";
import { getAuthContext } from "@/lib/auth";

export const dynamic = "force-dynamic";

export default async function SailorProfilePage({
  params,
}: {
  params: Promise<{ sailor_handle: string }>;
}) {
  const { sailor_handle } = await params;
  try {
    const sailor = await getSailorByHandle(sailor_handle);
    if (!sailor) notFound();

    const auth = await getAuthContext();
    const isLinkedOwner = Boolean(
      auth?.userId && sailor.parentId === auth.userId
    );
    const isSuperadmin = auth?.role === "superadmin";
    const canSeePrivate = isSuperadmin || isLinkedOwner;
    const isOwner = isLinkedOwner || isSuperadmin;
    const canClaim = Boolean(
      auth?.userId && !sailor.parentId && !isSuperadmin
    );

    const [results, seriesStanding, observations, equipmentHistory] =
      await Promise.all([
        getResultsForSailor(sailor.id),
        getSailorSeriesStanding(sailor.id).catch(() => null),
        getRaceObservationsForSailor(sailor.id, {
          includePrivate: canSeePrivate,
        }).catch(() => []),
        getEquipmentLogsForSailor(sailor.id).catch(() => []),
      ]);

    const equipment = {
      hullBrand: sailor.hullBrand || null,
      sailMake: sailor.sailMake || null,
      foilBrand: sailor.foilBrand || null,
      mast: sailor.mast || null,
      notes: sailor.equipmentNotes || null,
    };

    return (
      <SailorProfileView
        initialSailor={{
          ...sailor,
          isPublicWeight: sailor.isPublicWeight ?? false,
          isPublicDob: sailor.isPublicDob ?? false,
          isPublicEquipment: sailor.isPublicEquipment ?? false,
        }}
        initialResults={results.map((r) => ({
          id: r.resultId || r.regattaId,
          resultId: r.resultId,
          regattaSlug: r.regattaSlug,
          regattaId: r.regattaId,
          regattaName: r.regattaName,
          regattaDate: r.regattaDate,
          division: r.division,
          fleetSize: r.fleetSize,
          totalFleetSize: r.fleetSize,
          rank: r.rank,
          nettScore: r.nettScore,
          totalScore: r.totalScore,
          isDns: r.isDns,
          isDNS: r.isDns,
          isOverseasCommitment: r.isOverseasCommitment,
          raceCount: r.raceCount,
          geography: r.geography,
          countsForRanking: r.countsForRanking !== false,
        }))}
        initialEquipment={equipment}
        initialSeriesStanding={seriesStanding}
        initialObservations={observations}
        initialEquipmentHistory={equipmentHistory}
        canSeePrivate={canSeePrivate}
        canClaim={canClaim}
        isOwner={isOwner}
        isLoggedIn={Boolean(auth?.userId)}
        profileClaimed={Boolean(sailor.parentId)}
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
