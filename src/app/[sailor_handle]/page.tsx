import { notFound } from "next/navigation";
import { cookies } from "next/headers";
import { DbOffline } from "@/components/DbOffline";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { SailorProfileView } from "@/components/SailorProfileView";
import {
  getCachedPublicObservations,
  getCachedResultsForSailor,
  getCachedSailorByHandle,
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
import { canManageSailor } from "@/lib/claimAccess";
import { getProfileFollowState } from "@/lib/followedSailorsQuery";

export const dynamic = "force-dynamic";

function requestMayHaveSession(cookieNames: string[]): boolean {
  // Avoid a remote Supabase `getUser()` round trip for the normal anonymous
  // profile visit. The profile is public; authentication only changes private
  // fields, edit controls, and the follow button.
  return cookieNames.some(
    (name) =>
      name.startsWith("sailorpath-public-auth") ||
      name.startsWith("sailorpath-admin-auth") ||
      name.startsWith("sb-") ||
      name.includes("supabase-auth-token")
  );
}

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
  let followControl: {
    sailorId: string;
    following: boolean;
    disabled: boolean;
  } | null = null;

  try {
    const cookieStore = await cookies();
    const mayHaveSession = requestMayHaveSession(
      cookieStore.getAll().map((cookie) => cookie.name)
    );
    const [sailorResult, authResult] = await Promise.all([
      getCachedSailorByHandle(sailor_handle),
      mayHaveSession ? getAuthContext().catch(() => null) : Promise.resolve(null),
    ]);
    sailor = sailorResult;
    auth = authResult;

    if (sailor) {
      let hasApprovedClaim = false;
      if (auth?.userId && sailor.parentId !== auth.userId) {
        hasApprovedClaim = await canManageSailor(
          sailor.id,
          auth.userId,
          false,
          sailor.parentId
        ).catch(() => false);
      }

      access = resolveProfileAccess({
        userId: auth?.userId,
        role: auth?.role,
        sailorParentId: sailor.parentId,
        hasApprovedClaim,
      });

      // Owners and admins read this sailor fresh so an edit is visible
      // immediately. Everyone else uses the shared public cache.
      if (access.canSeePrivate) {
        sailor = (await getSailorByHandle(sailor_handle)) ?? sailor;
      }

      const mayHaveIlca = Boolean(
        sailor.sailNumberIlca4 || sailor.ilca4NationalList
      );
      const mayHaveSingaporeSeries =
        sailor.nationality === "SGP" &&
        Boolean(
          sailor.currentFleet || sailor.goldEntryDate || sailor.silverEntryDate
        );

      const [res, sStand, iStand, obs, equipHist] = await Promise.all([
        access.canSeePrivate
          ? getResultsForSailor(sailor.id)
          : getCachedResultsForSailor(sailor.id),
        mayHaveSingaporeSeries
          ? getSailorSeriesStanding(sailor.id).catch(() => null)
          : Promise.resolve(null),
        mayHaveIlca
          ? getSailorIlcaStanding(sailor.id, "ILCA 4").catch(() => null)
          : Promise.resolve(null),
        access.canSeePrivate
          ? getRaceObservationsForSailor(sailor.id, {
              includePrivate: true,
            }).catch(() => [])
          : getCachedPublicObservations(sailor.id).catch(() => []),
        access.canSeePrivate
          ? getEquipmentLogsForSailor(sailor.id).catch(() => [])
          : Promise.resolve([]),
      ]);

      results = res;
      seriesStanding = sStand;
      ilcaStanding = iStand;
      observations = obs;
      equipmentHistory = equipHist;

      if (auth?.userId) {
        const followState = await getProfileFollowState(
          auth.userId,
          sailor.id,
          access.isOwner
        );
        if (followState.show) {
          followControl = {
            sailorId: sailor.id,
            following: followState.following,
            disabled: followState.disabled,
          };
        }
      }

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
        entryLabel: r.entryLabel,
        entrySailNumber: r.entrySailNumber,
        entryBoardNumber: r.entryBoardNumber,
        entryType: r.entryType,
        participants: r.participants,
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
      followControl={followControl}
    />
    </ErrorBoundary>
  );
}
