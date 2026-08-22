import { notFound } from "next/navigation";
import { DbOffline } from "@/components/DbOffline";
import { ErrorBoundary } from "@/components/ErrorBoundary";
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
import {
  toPublicEquipmentProps,
  toPublicSailorProps,
} from "@/lib/publicSailor";
import { resolveProfileAccess } from "@/lib/viewAs";

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
  let access = resolveProfileAccess({
    userId: null,
    role: null,
    sailorParentId: null,
  });

  try {
    const [sailorResult, authResult] = await Promise.all([
      getSailorByHandle(sailor_handle),
      getAuthContext().catch(() => null),
    ]);
    sailor = sailorResult;
    auth = authResult;

    if (sailor) {
      access = resolveProfileAccess({
        userId: auth?.userId,
        role: auth?.role,
        sailorParentId: sailor.parentId,
      });

      const mayHaveIlca = Boolean(
        sailor.sailNumberIlca4 || sailor.ilca4NationalList
      );

      const [res, sStand, iStand, obs, equipHist] = await Promise.all([
        getResultsForSailor(sailor.id),
        getSailorSeriesStanding(sailor.id).catch(() => null),
        mayHaveIlca
          ? getSailorIlcaStanding(sailor.id, "ILCA 4").catch(() => null)
          : Promise.resolve(null),
        getRaceObservationsForSailor(sailor.id, {
          includePrivate: access.canSeePrivate,
        }).catch(() => []),
        access.canSeePrivate
          ? getEquipmentLogsForSailor(sailor.id).catch(() => [])
          : Promise.resolve([]),
      ]);

      results = res;
      seriesStanding = sStand;
      ilcaStanding = iStand;
      observations = obs;
      equipmentHistory = equipHist;

      if (!ilcaStanding && !mayHaveIlca) {
        const hasIlcaResults = (results || []).some((r) => {
          const bc = String(r.boatClass || "").toLowerCase();
          return bc.includes("ilca");
        });

        if (hasIlcaResults) {
          ilcaStanding = await getSailorIlcaStanding(sailor.id, "ILCA 4").catch(
            () => null
          );
        }
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

  const canSeePrivate = access.canSeePrivate;
  const publicSailor = toPublicSailorProps(sailor, { canSeePrivate });
  const equipment = toPublicEquipmentProps(sailor, canSeePrivate);

  return (
    <ErrorBoundary
      fallback={
        <div className="mx-auto max-w-xl px-4 py-16 text-center space-y-3">
          <h1 className="text-xl font-black text-white">
            Profile failed to load
          </h1>
          <p className="text-sm text-slate-400">
            Something broke while rendering this profile. Try again, or contact
            support if it persists.
          </p>
        </div>
      }
    >
      <SailorProfileView
      initialSailor={publicSailor}
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
        raceResults: r.raceResults,
      }))}
      initialEquipment={equipment}
      initialSeriesStanding={seriesStanding}
      initialIlcaStanding={ilcaStanding}
      initialObservations={observations || []}
      initialEquipmentHistory={equipmentHistory || []}
      canSeePrivate={canSeePrivate}
      canClaim={access.canClaim}
      isOwner={access.isOwner}
      isLoggedIn={Boolean(auth?.userId)}
      profileClaimed={Boolean(sailor.parentId)}
      profileVerified={Boolean(sailor.parentId)}
    />
    </ErrorBoundary>
  );
}
