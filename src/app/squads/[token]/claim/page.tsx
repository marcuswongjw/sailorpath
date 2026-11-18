import Link from "next/link";
import { notFound } from "next/navigation";
import { BadgeCheck, UserPlus } from "lucide-react";
import { asc, eq } from "drizzle-orm";
import type { Metadata } from "next";
import { db } from "@/db";
import { coachSquadMembers, coachSquads, sailors } from "@/db/schema";
import { getAuthContext } from "@/lib/auth";
import { verifySquadClaimToken } from "@/lib/squadClaimToken";

export const dynamic = "force-dynamic";

export const metadata: Metadata = {
  title: "Claim your squad profile | SailorPath",
  description: "Find your sailor profile in your coach's squad and request ownership.",
  robots: { index: false, follow: false },
};

export default async function SquadClaimPage({
  params,
}: {
  params: Promise<{ token: string }>;
}) {
  const { token } = await params;
  const squadId = verifySquadClaimToken(token);
  if (!squadId) notFound();

  const [squad] = await db
    .select({ id: coachSquads.id, name: coachSquads.name })
    .from(coachSquads)
    .where(eq(coachSquads.id, squadId))
    .limit(1);

  if (!squad) notFound();

  const rows = await db
    .select({
      id: sailors.id,
      name: sailors.name,
      handle: sailors.handle,
      sailNumber: sailors.sailNumber,
      club: sailors.club,
      parentId: sailors.parentId,
    })
    .from(coachSquadMembers)
    .innerJoin(sailors, eq(coachSquadMembers.sailorId, sailors.id))
    .where(eq(coachSquadMembers.squadId, squad.id))
    .orderBy(asc(sailors.name));

  const auth = await getAuthContext().catch(() => null);
  const isLoggedIn = Boolean(auth?.userId);
  const refTag = `squad_${squad.id.slice(0, 8)}`;

  const unclaimed = rows.filter((r) => !r.parentId);
  const claimed = rows.filter((r) => Boolean(r.parentId));

  const claimHref = (handle: string) => {
    const target = `/sailors/${handle}?claim=1&ref=${encodeURIComponent(refTag)}`;
    return isLoggedIn ? target : `/login?next=${encodeURIComponent(target)}`;
  };

  return (
    <div className="mx-auto max-w-3xl px-4 py-10 space-y-6">
      <header className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-6 shadow-xs space-y-2">
        <p className="text-xs font-bold uppercase tracking-wider text-[var(--sp-harbour-teal)]">
          Squad claim link
        </p>
        <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
          {squad.name}
        </h1>
        <p className="text-sm text-[var(--sp-charcoal-slate)]">
          {unclaimed.length === 0
            ? "All sailors in this squad have already claimed their profiles."
            : `Select your name or your child's name below to claim their SailorPath profile (${claimed.length} of ${rows.length} claimed).`}
        </p>
      </header>

      {unclaimed.length > 0 && (
        <section aria-label="Unclaimed squad sailors" className="space-y-2.5">
          <h2 className="text-sm font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">
            Unclaimed sailors ({unclaimed.length})
          </h2>
          <ul className="divide-y divide-[var(--sp-cool-veil)] rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs">
            {unclaimed.map((sailor) => (
              <li
                key={sailor.id}
                className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 p-4"
              >
                <div className="min-w-0">
                  <Link
                    href={`/sailors/${sailor.handle}`}
                    className="font-bold text-[var(--sp-harbour-shadow)] hover:underline"
                  >
                    {sailor.name}
                  </Link>
                  <p className="text-xs text-[var(--sp-slate-soft)]">
                    {[sailor.sailNumber ? `Sail ${sailor.sailNumber}` : null, sailor.club]
                      .filter(Boolean)
                      .join(" · ") || "SailorPath athlete"}
                  </p>
                </div>
                <Link
                  href={claimHref(sailor.handle)}
                  className="inline-flex min-h-10 items-center justify-center gap-1.5 rounded-full bg-[var(--sp-harbour-teal)] px-4 py-2 text-xs font-bold text-white hover:bg-[var(--sp-harbour-shadow)] transition-colors shrink-0"
                >
                  <UserPlus className="h-3.5 w-3.5" aria-hidden="true" />
                  Is this you or your child? Claim profile
                </Link>
              </li>
            ))}
          </ul>
        </section>
      )}

      {claimed.length > 0 && (
        <section aria-label="Claimed squad sailors" className="space-y-2.5">
          <h2 className="text-sm font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">
            Already claimed ({claimed.length})
          </h2>
          <ul className="divide-y divide-[var(--sp-cool-veil)] rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs">
            {claimed.map((sailor) => (
              <li
                key={sailor.id}
                className="flex items-center justify-between gap-3 p-4"
              >
                <div className="min-w-0">
                  <Link
                    href={`/sailors/${sailor.handle}`}
                    className="font-semibold text-[var(--sp-harbour-shadow)] hover:underline"
                  >
                    {sailor.name}
                  </Link>
                  {sailor.sailNumber && (
                    <p className="text-xs text-[var(--sp-slate-soft)]">
                      Sail {sailor.sailNumber}
                    </p>
                  )}
                </div>
                <span className="inline-flex items-center gap-1 rounded-full border border-emerald-200 bg-emerald-50 px-2.5 py-0.5 text-xs font-semibold text-emerald-700">
                  <BadgeCheck className="h-3.5 w-3.5 text-emerald-600" aria-hidden="true" />
                  Claimed
                </span>
              </li>
            ))}
          </ul>
        </section>
      )}
    </div>
  );
}
