import { Suspense } from "react";
import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { cookies } from "next/headers";
import { DbOffline } from "@/components/DbOffline";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { JsonLd } from "@/components/JsonLd";
import { SailorProfileView } from "@/components/SailorProfileView";
import {
  getSailorByHandle,
  getSailorSeriesStanding,
  getSailorIlcaStanding,
  getRaceObservationsForSailor,
  getEquipmentLogsForSailor,
} from "@/lib/queries";
import { loadShareSailor, loadShareSailorResults } from "@/lib/publicShareData";
import { profilePageJsonLd, sailorShareModel, shareMetadata } from "@/lib/publicSeo";
import { DbUnavailableError } from "@/db";
import { getAuthContext } from "@/lib/auth";
import {
  toPublicEquipmentProps,
  toPublicSailorProps,
} from "@/lib/publicSailor";
import { resolveProfileAccess } from "@/lib/viewAs";
import { canManageSailor } from "@/lib/claimAccess";
import { formatSailNumber } from "@/lib/countries";
import { getProfileFollowState } from "@/lib/followedSailorsQuery";
import { isExplicitGuest, isSgpNationality } from "@/lib/seriesMembership";

export const dynamic = "force-dynamic";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ sailor_handle: string }>;
}): Promise<Metadata> {
  const { sailor_handle } = await params;
  try {
    const sailor = await loadShareSailor(sailor_handle);
    if (!sailor) {
      return shareMetadata({
        title: "Sailor not found | SailorPath",
        description: "This SailorPath profile is not available.",
        canonicalPath: `/sailors/${encodeURIComponent(sailor_handle)}`,
        index: false,
      });
    }
    const results = await loadShareSailorResults(sailor.id).catch(() => []);
    const publicSailor = toPublicSailorProps(sailor, { canSeePrivate: false });
    const share = sailorShareModel({
      name: publicSailor.name,
      handle: publicSailor.handle,
      nationality: publicSailor.nationality,
      club: publicSailor.club,
      results: results.map((result) => ({
        regattaName: result.regattaName,
        regattaDate: result.regattaDate,
        boatClass: result.boatClass,
        rank: result.rank,
        isDns: result.isDns,
      })),
    });
    return shareMetadata({
      title: share.title,
      description: share.summary,
      canonicalPath: share.path,
    });
  } catch {
    return {
      title: "Sailor profile | SailorPath",
      description: "Sailor profiles and published sailing results on SailorPath.",
    };
  }
}

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
    sailor = await loadShareSailor(sailor_handle);
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
              {[publicSailor.sailNumber && `Sail ${formatSailNumber(publicSailor.sailNumber, publicSailor.nationality) || publicSailor.sailNumber}`, publicSailor.sailNumberIlca4 && `ILCA ${publicSailor.sailNumberIlca4}`, publicSailor.boardNumber && `Board ${publicSailor.boardNumber}`].filter(Boolean).join(" · ")}
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
  initialSailor: NonNullable<Awaited<ReturnType<typeof loadShareSailor>>>;
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
    nextPath: string;
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
      // Notes and equipment stay private. Rank is public. Load the sailor's
      // own results first, then one national board at a time. A cold board
      // scans the full result history, and the pool has a single connection.
      const shouldLoadPrivateProfileExtras = access.canSeePrivate;

      const [res, obs, equipHist] = await Promise.all([
        loadShareSailorResults(sailor.id),
        shouldLoadPrivateProfileExtras
          ? getRaceObservationsForSailor(sailor.id, {
              includePrivate: true,
            }).catch(() => [])
          : Promise.resolve([]),
        shouldLoadPrivateProfileExtras
          ? getEquipmentLogsForSailor(sailor.id).catch(() => [])
          : Promise.resolve([]),
      ]);

      results = res;
      observations = obs;
      equipmentHistory = equipHist;

      const hasOptimistResult = (results || []).some((result) => {
        const boatClass = String(result.boatClass ?? "").trim().toLowerCase();
        return (
          boatClass === "" ||
          boatClass === "optimist" ||
          boatClass.includes("optimist")
        );
      });
      const hasSeriesStamp = Boolean(
        sailor.currentFleet || sailor.goldEntryDate || sailor.silverEntryDate
      );
      const mayHaveSingaporeSeries =
        !isExplicitGuest(sailor) &&
        (hasSeriesStamp ||
          (isSgpNationality(sailor.nationality) && hasOptimistResult));

      if (mayHaveSingaporeSeries) {
        seriesStanding = await getSailorSeriesStanding(sailor.id).catch(
          () => null
        );
      }

      const hasIlcaResults = (results || []).some((result) =>
        String(result.boatClass || "").toLowerCase().includes("ilca")
      );
      if (mayHaveIlca || hasIlcaResults) {
        ilcaStanding = await getSailorIlcaStanding(sailor.id, "ILCA 4").catch(
          () => null
        );
      }

      followControl = {
        sailorId: sailor.id,
        following: false,
        disabled: access.isOwner,
        nextPath: `/sailors/${encodeURIComponent(sailor.handle)}`,
      };
      if (auth?.userId) {
        const followState = await getProfileFollowState(
          auth.userId,
          sailor.id,
          access.isOwner
        );
        followControl = {
          sailorId: sailor.id,
          following: followState.following,
          disabled: followState.disabled,
          nextPath: `/sailors/${encodeURIComponent(sailor.handle)}`,
        };
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
  const seoSailor = toPublicSailorProps(sailor, { canSeePrivate: false });
  const share = sailorShareModel({
    name: seoSailor.name,
    handle: seoSailor.handle,
    nationality: seoSailor.nationality,
    club: seoSailor.club,
    results: (results || []).map((result) => ({
      regattaName: result.regattaName,
      regattaDate: result.regattaDate,
      boatClass: result.boatClass,
      rank: result.rank,
      isDns: result.isDns,
    })),
  });

  return (
    <>
    <JsonLd data={profilePageJsonLd(share)} />
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
    </>
  );
}
