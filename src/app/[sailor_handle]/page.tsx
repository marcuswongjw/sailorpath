import { getSailorProfile } from "@/lib/dbQueries";
import { SailorProfileView } from "@/components/SailorProfileView";
import { notFound } from "next/navigation";
import { DemoBanner } from "@/components/DemoBanner";
import { getAuthContext } from "@/lib/auth";
import { db } from "@/db";
import { sailors, coachingRelationships } from "@/db/schema";
import { and, eq } from "drizzle-orm";

interface PageProps {
  params: Promise<{ sailor_handle: string }>;
}

async function resolvePrivateAccess(handle: string): Promise<boolean> {
  const ctx = await getAuthContext();
  if (!ctx) return false;
  if (ctx.role === "superadmin") return true;

  try {
    const [sailor] = await db
      .select({ id: sailors.id, parentId: sailors.parentId })
      .from(sailors)
      .where(eq(sailors.handle, handle))
      .limit(1);
    if (!sailor) return false;
    if (sailor.parentId === ctx.userId) return true;

    const coach = await db
      .select({ id: coachingRelationships.id })
      .from(coachingRelationships)
      .where(
        and(
          eq(coachingRelationships.sailorId, sailor.id),
          eq(coachingRelationships.coachId, ctx.userId),
          eq(coachingRelationships.status, "confirmed")
        )
      )
      .limit(1);
    if (coach.length) return true;
  } catch {
    return false;
  }
  return false;
}

export default async function SailorProfilePage({ params }: PageProps) {
  const resolvedParams = await params;
  const handle = resolvedParams.sailor_handle;

  const canSeePrivate = await resolvePrivateAccess(handle);
  const response = await getSailorProfile(handle, { canSeePrivate });
  if (!response || !response.data) {
    notFound();
  }

  const { sailor, results, equipment } = response.data;

  return (
    <div className="flex-1 flex flex-col bg-[#090a0f]">
      <DemoBanner isDemo={response.isDemo} />
      <SailorProfileView
        initialSailor={sailor}
        initialResults={results}
        initialEquipment={equipment}
        canSeePrivate={canSeePrivate}
        isDemo={response.isDemo}
      />
    </div>
  );
}
