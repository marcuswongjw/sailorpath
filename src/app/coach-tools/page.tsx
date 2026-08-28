import Link from "next/link";
import type { Metadata } from "next";
import { CoachDashboard } from "@/components/CoachDashboard";
import { getAuthContext } from "@/lib/auth";
import { getCoachSquadDashboard } from "@/lib/coachDashboard";
import { CoachAccessRequestButton } from "@/components/coach/CoachAccessRequestButton";
import { db } from "@/db";
import { coachAccessRequests } from "@/db/schema";
import { eq } from "drizzle-orm";

export const metadata: Metadata = {
  title: "Coach dashboard | SailorPath",
  description: "Track a private squad roster with live SailorPath rankings and regatta results.",
};

export const dynamic = "force-dynamic";

export default async function CoachToolsPage() {
  const auth = await getAuthContext();

  if (!auth) {
    return (
      <div className="mx-auto max-w-lg px-4 py-20 text-center space-y-4">
        <h1 className="text-3xl font-black text-white">Coach dashboard</h1>
        <p className="text-sm leading-relaxed text-slate-400">
          Sign in with an approved coach account to manage your squad roster.
        </p>
        <Link href="/login?next=%2Fcoach-tools" className="inline-flex rounded-full bg-orange-600 px-5 py-2.5 text-xs font-bold text-white hover:bg-orange-500">
          Sign in
        </Link>
      </div>
    );
  }

  if (auth.role !== "coach" && auth.role !== "superadmin") {
    const [request] = await db
      .select({ status: coachAccessRequests.status })
      .from(coachAccessRequests)
      .where(eq(coachAccessRequests.requesterId, auth.userId))
      .limit(1)
      .catch(() => []);
    return (
      <div className="mx-auto max-w-lg px-4 py-20 text-center space-y-4">
        <h1 className="text-3xl font-black text-white">Coach access required</h1>
        <p className="text-sm leading-relaxed text-slate-400">
          Your account is active, but it has not been approved for coach tools yet.
        </p>
        <CoachAccessRequestButton initiallyPending={request?.status === "pending"} />
      </div>
    );
  }

  const data = await getCoachSquadDashboard(auth.userId);
  return <CoachDashboard initialData={data} />;
}
