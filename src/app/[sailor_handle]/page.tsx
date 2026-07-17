import { notFound } from "next/navigation";
import { DbOffline } from "@/components/DbOffline";
import { SailorProfileView } from "@/components/SailorProfileView";
import {
  getSailorByHandle,
  getResultsForSailor,
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
    const canSeePrivate = auth?.role === "superadmin";

    const results = await getResultsForSailor(sailor.id);

    return (
      <SailorProfileView
        initialSailor={{
          ...sailor,
          isPublicWeight: false,
          isPublicDob: false,
          isPublicEquipment: true,
        }}
        initialResults={results.map((r) => ({
          id: r.regattaSlug,
          regattaSlug: r.regattaSlug,
          regattaId: r.regattaSlug,
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
        }))}
        initialEquipment={null}
        canSeePrivate={canSeePrivate}
        canClaim={
          Boolean(auth?.userId) &&
          !sailor.parentId &&
          auth?.role !== "superadmin"
        }
        isOwner={
          Boolean(auth?.userId && sailor.parentId === auth.userId) ||
          auth?.role === "superadmin"
        }
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
