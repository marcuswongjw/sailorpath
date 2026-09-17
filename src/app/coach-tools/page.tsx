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
      <div className="mx-auto max-w-lg px-4 py-20 text-center">
        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-8 shadow-xs space-y-4">
          <h1 className="text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">Coach dashboard</h1>
          <p className="text-sm leading-relaxed text-[var(--sp-charcoal-slate)]">
            Sign in with an approved coach account to manage your squad roster.
          </p>
          <div className="pt-2">
            <Link href="/login?next=%2Fcoach-tools" className="sp-btn-primary">
              Sign in
            </Link>
          </div>
        </div>
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
      <div className="mx-auto max-w-lg px-4 py-20 text-center">
        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-8 shadow-xs space-y-4">
          <h1 className="text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">Coach access required</h1>
          <p className="text-sm leading-relaxed text-[var(--sp-charcoal-slate)]">
            Your account is active, but it has not been approved for coach tools yet.
          </p>
          <div className="pt-2">
            <CoachAccessRequestButton initiallyPending={request?.status === "pending"} />
          </div>
        </div>
      </div>
    );
  }

  let data: Awaited<ReturnType<typeof getCoachSquadDashboard>> | null = null;
  try {
    data = await getCoachSquadDashboard(auth.userId);
  } catch (error) {
    console.error("Failed to load coach dashboard:", error);
  }

  if (!data) {
    return (
      <div className="mx-auto max-w-lg px-4 py-20 text-center">
        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-8 shadow-xs space-y-4">
          <h1 className="text-2xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">Unable to load squad</h1>
          <p className="text-sm leading-relaxed text-[var(--sp-charcoal-slate)]">
            We couldn&apos;t load your coach dashboard right now. Please refresh or try again in a few moments.
          </p>
          <div className="pt-2">
            <Link href="/coach-tools" className="sp-btn-primary">
              Retry
            </Link>
          </div>
        </div>
      </div>
    );
  }

  return <CoachDashboard initialData={data} />;
}
