import { Suspense } from "react";
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
  try {
    sailor = await getCachedSailorByHandle(sailor_handle);
  } catch (error) {
    return <DbOffline message={error instanceof DbUnavailableError ? error.message : "DB error"} />;
  }
  if (!sailor) notFound();

  // Only public-safe fields may appear before account permissions resolve.
  const publicSailor = toPublicSailorProps(sailor, { canSeePrivate: false });
  return (
    <Suspense key={sailor.id} fallback={
      <div className="mx-auto max-w-5xl px-3 sm:px-6 py-6 sm:py-10 w-full space-y-5 bg-sailcloth text-charcoal">
        <section aria-label="Sailor profile" className="rounded-2xl border border-harbour/15 bg-warm-white p-6 sm:p-8 shadow-sm">
          <p className="text-xs font-bold uppercase tracking-wider text-harbour">Sailor profile</p>
          <h1 className="mt-2 text-3xl font-black text-harbour-shadow">{publicSailor.name}</h1>
          <p className="mt-3 text-sm text-slate-soft">
            {[publicSailor.nationality, publicSailor.club, publicSailor.school].filter(Boolean).join(" · ")}
          </p>
          {(publicSailor.sailNumber || publicSailor.sailNumberIlca4 || publicSailor.boardNumber) && (
            <p className="mt-2 text-sm font-semibold">
              {[publicSailor.sailNumber && `Sail ${publicSailor.sailNumber}`, publicSailor.sailNumberIlca4 && `ILCA ${publicSailor.sailNumberIlca4}`, publicSailor.boardNumber && `Board ${publicSailor.boardNumber}`].filter(Boolean).join(" · ")}
            </p>
          )}
          {publicSailor.bio && <p className="mt-4 whitespace-pre-line text-sm">{publicSailor.bio}</p>}
        </section>
        <section aria-busy="true" aria-label="Results and rankings" className="rounded-2xl border border-harbour/15 bg-warm-white p-6">
          <p role="status" className="text-sm text-slate-soft">Loading results and rankings…</p>
          <div aria-hidden="true" className="mt-4 h-40 animate-pulse rounded-xl bg-harbour/5" />
        </section>
      </div>
    }>
      <SailorProfileDetails sailor_handle={sailor_handle} initialSailor={sailor} />
    </Suspense>
  );
}

async function SailorProfileDetails({ sailor_handle, initialSailor }: {
  sailor_handle: string;
  initialSailor: NonNullable<Awaited<ReturnType<typeof getCachedSailorByHandle>>>;
}) {
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
      Promise.resolve(initialSailor),
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
