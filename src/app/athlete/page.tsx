import Link from "next/link";
import { getAuthContext } from "@/lib/auth";
import { db } from "@/db";
import { sailorClaims, sailors } from "@/db/schema";
import { and, eq, inArray, or } from "drizzle-orm";
import { Trophy, Sparkles, UserPlus, LogIn, Compass } from "lucide-react";
import { AthleteHub, type AthleteProfile } from "@/components/athlete/AthleteHub";

export const dynamic = "force-dynamic";

export const metadata = {
  title: "Athlete Hub & Logbook | SailorPath",
  description:
    "Manage your sailor profile, log overseas & non-ranking regattas, and submit official evidence for verification on SailorPath.",
};

type AthletePageProps = {
  searchParams: Promise<{
    id?: string;
    tab?: "results" | "profile" | "equipment" | "documents";
    action?: string;
  }>;
};

export default async function AthletePage({ searchParams }: AthletePageProps) {
  const auth = await getAuthContext();
  const sp = await searchParams;

  if (!auth) {
    return (
      <div className="mx-auto max-w-xl px-4 py-16 sm:py-24 text-center">
        <div className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-8 sm:p-10 shadow-xs space-y-6">
          <div className="mx-auto inline-flex h-14 w-14 items-center justify-center rounded-2xl bg-[var(--sp-racing-mist)]/30 text-[var(--sp-racing-orange)] border border-[var(--sp-racing-orange)]/30 shadow-2xs">
            <Trophy className="h-7 w-7" />
          </div>

          <div className="space-y-2">
            <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
              Athlete Command Center
            </h1>
            <p className="text-sm leading-relaxed text-[var(--sp-slate-soft)] max-w-md mx-auto">
              Sign in to manage your athlete profile, track your personal equipment locker, and log evidence-backed non-ranking &amp; overseas regatta scores.
            </p>
          </div>

          <div className="pt-2 flex flex-col sm:flex-row items-center justify-center gap-3">
            <Link
              href="/login?next=%2Fathlete"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-xl bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] active:scale-[0.98] text-white px-6 py-3 text-[15px] font-semibold transition-all shadow-xs"
            >
              <LogIn className="h-4 w-4" />
              <span>Sign in</span>
            </Link>
            <Link
              href="/demo/sailor"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-xl border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal)] px-6 py-3 text-[15px] font-semibold transition-all shadow-2xs"
            >
              <Sparkles className="h-4 w-4 text-[var(--sp-racing-orange)]" />
              <span>Explore Sailor Demo</span>
            </Link>
          </div>

          <div className="pt-4 border-t border-[var(--sp-cool-veil)] flex items-center justify-center gap-1.5 text-xs text-[var(--sp-slate-soft)]">
            <span>Haven&apos;t claimed your profile yet?</span>
            <Link
              href="/claim-profile"
              className="font-bold text-[var(--sp-harbour-teal)] hover:underline inline-flex items-center gap-1"
            >
              <span>Claim profile</span>
              <UserPlus className="h-3.5 w-3.5" />
            </Link>
          </div>
        </div>
      </div>
    );
  }

  // Query approved claims and parent-owned profiles
  const approvedClaims = await db
    .select({
      sailorId: sailorClaims.sailorId,
      relation: sailorClaims.relation,
    })
    .from(sailorClaims)
    .where(
      and(
        eq(sailorClaims.requesterId, auth.userId),
        eq(sailorClaims.status, "approved")
      )
    );

  const claimMap = new Map(approvedClaims.map((c) => [c.sailorId, c.relation]));
  const claimedIds = Array.from(claimMap.keys());

  const conditions = [eq(sailors.parentId, auth.userId)];
  if (claimedIds.length > 0) {
    conditions.push(inArray(sailors.id, claimedIds));
  }

  const rows = await db
    .select()
    .from(sailors)
    .where(or(...conditions));

  const athletes: AthleteProfile[] = rows.map((s) => ({
    id: s.id,
    name: s.name,
    handle: s.handle || s.id,
    sailNumber: s.sailNumber,
    sailNumberIlca4: s.sailNumberIlca4,
    club: s.club,
    school: s.school,
    gender: s.gender,
    nationality: s.nationality || "SGP",
    avatarUrl: s.avatarUrl,
    currentFleet: s.currentFleet,
    nationalSquadStatus: s.nationalSquadStatus,
    ownerRelation: claimMap.get(s.id) || (s.parentId === auth.userId ? "Parent" : "Self"),
    dob: s.dob,
    instagram: s.instagram,
    hullBrand: s.hullBrand,
    sailMake: s.sailMake,
    foilBrand: s.foilBrand,
    mast: s.mast,
    equipmentNotes: s.equipmentNotes,
  }));

  if (athletes.length === 0) {
    return (
      <div className="mx-auto max-w-xl px-4 py-16 sm:py-24 text-center">
        <div className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-8 sm:p-10 shadow-xs space-y-6">
          <div className="mx-auto inline-flex h-14 w-14 items-center justify-center rounded-2xl bg-[var(--sp-racing-mist)]/30 text-[var(--sp-racing-orange)] border border-[var(--sp-racing-orange)]/30 shadow-2xs">
            <Compass className="h-7 w-7" />
          </div>

          <div className="space-y-2">
            <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
              No Claimed Profile Found
            </h1>
            <p className="text-sm leading-relaxed text-[var(--sp-slate-soft)] max-w-md mx-auto">
              Your account is signed in, but is not yet linked to a sailor profile. Claim your profile to log regattas, upload official evidence, and manage equipment.
            </p>
          </div>

          <div className="pt-2 flex flex-col sm:flex-row items-center justify-center gap-3">
            <Link
              href="/claim-profile"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-xl bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] active:scale-[0.98] text-white px-6 py-3 text-[15px] font-semibold transition-all shadow-xs"
            >
              <UserPlus className="h-4 w-4" />
              <span>Claim Sailor Profile</span>
            </Link>
            <Link
              href="/demo/sailor"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-xl border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal)] px-6 py-3 text-[15px] font-semibold transition-all shadow-2xs"
            >
              <Sparkles className="h-4 w-4 text-[var(--sp-racing-orange)]" />
              <span>Explore Sailor Demo</span>
            </Link>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-6xl w-full px-4 sm:px-6 lg:px-8 py-8 sm:py-10">
      <AthleteHub
        athletes={athletes}
        currentSailorId={sp.id}
        initialTab={sp.tab}
        initialAction={sp.action}
      />
    </div>
  );
}
