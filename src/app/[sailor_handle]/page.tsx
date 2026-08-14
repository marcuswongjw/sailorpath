import { notFound } from "next/navigation";
import { DbOffline } from "@/components/DbOffline";
import { SailorProfileView } from "@/components/SailorProfileView";
import {
  getSailorByHandle,
  getResultsForSailor,
  getSailorSeriesStanding,
  getSailorIlcaStanding,
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
  let sailor;
  let auth;
  let results;
  let seriesStanding;
  let ilcaStanding;
  let observations;
  let equipmentHistory;
  let errorMsg: string | null = null;

  try {
    sailor = await getSailorByHandle(sailor_handle);
    if (sailor) {
      auth = await getAuthContext();
      const isLinkedOwner = Boolean(
        auth?.userId && sailor.parentId === auth.userId
      );
      const isSuperadmin = auth?.role === "superadmin";
      const canSeePrivate = isSuperadmin || isLinkedOwner;

      // Parallel core data. ILCA standing is skipped for pure Optimist sailors
      // (was re-ranking the full board on every profile open).
      const mayHaveIlca = Boolean(
        sailor.sailNumberIlca4 || sailor.ilca4NationalList
      );

      const [res, sStand, obs, equipHist] = await Promise.all([
        getResultsForSailor(sailor.id),
        getSailorSeriesStanding(sailor.id).catch(() => null),
        getRaceObservationsForSailor(sailor.id, {
          includePrivate: canSeePrivate,
        }).catch(() => []),
        getEquipmentLogsForSailor(sailor.id).catch(() => []),
      ]);

      results = res;
      seriesStanding = sStand;
      observations = obs;
      equipmentHistory = equipHist;

      const hasIlcaResults = (results || []).some((r) => {
        const bc = String(r.boatClass || "").toLowerCase();
        return bc.includes("ilca");
      });

      if (mayHaveIlca || hasIlcaResults) {
        ilcaStanding = await getSailorIlcaStanding(sailor.id, "ILCA 4").catch(
          () => null
        );
      } else {
        ilcaStanding = null;
      }
    }
  } catch (e) {
    errorMsg = e instanceof DbUnavailableError ? e.message : "DB error";
  }

  if (errorMsg) {
    return <DbOffline message={errorMsg} />;
  }

  if (!sailor) {
    notFound();
  }

  const isLinkedOwner = Boolean(
    auth?.userId && sailor.parentId === auth.userId
  );
  const isSuperadmin = auth?.role === "superadmin";
  const canSeePrivate = isSuperadmin || isLinkedOwner;
  const isOwner = isLinkedOwner || isSuperadmin;
  const canClaim = Boolean(
    auth?.userId && !sailor.parentId && !isSuperadmin
  );

  const equipment = {
    hullBrand: sailor.hullBrand || null,
    sailMake: sailor.sailMake || null,
    foilBrand: sailor.foilBrand || null,
    mast: sailor.mast || null,
    notes: sailor.equipmentNotes || null,
    hullBrandIlca4: sailor.hullBrandIlca4 || null,
    sailMakeIlca4: sailor.sailMakeIlca4 || null,
    foilBrandIlca4: sailor.foilBrandIlca4 || null,
    mastIlca4: sailor.mastIlca4 || null,
    notesIlca4: sailor.equipmentNotesIlca4 || null,
  };

  return (
    <SailorProfileView
      initialSailor={{
        ...sailor,
        isPublicWeight: sailor.isPublicWeight ?? false,
        isPublicDob: sailor.isPublicDob ?? false,
        isPublicEquipment: sailor.isPublicEquipment ?? false,
      }}
      initialResults={(results || []).map((r) => ({
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
        boatClass: r.boatClass ?? "Optimist",
      }))}
      initialEquipment={equipment}
      initialSeriesStanding={seriesStanding}
      initialIlcaStanding={ilcaStanding}
      initialObservations={observations || []}
      initialEquipmentHistory={equipmentHistory || []}
      canSeePrivate={canSeePrivate}
      canClaim={canClaim}
      isOwner={isOwner}
      isLoggedIn={Boolean(auth?.userId)}
      profileClaimed={Boolean(sailor.parentId)}
      profileVerified={Boolean(sailor.parentId)}
    />
  );
}
