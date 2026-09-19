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
      <div className="mx-auto max-w-xl px-4 py-20 text-center">
        <div className="rounded-3xl border border-white/10 bg-[#121520] p-8 sm:p-10 shadow-xl space-y-5">
          <div className="inline-flex h-14 w-14 items-center justify-center rounded-2xl bg-orange-500/15 text-orange-400 border border-orange-500/30 shadow-sm">
            <Trophy className="h-7 w-7" />
          </div>

          <div className="space-y-2">
            <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
              Athlete Command Center
            </h1>
            <p className="text-sm leading-relaxed text-slate-400 max-w-md mx-auto">
              Sign in to manage your athlete profile, track your personal equipment locker, and log evidence-backed non-ranking & overseas regatta scores.
            </p>
          </div>

          <div className="pt-2 flex flex-col sm:flex-row items-center justify-center gap-3">
            <Link
              href="/login?next=%2Fathlete"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-2xl bg-orange-600 hover:bg-orange-500 text-white px-6 py-3 text-xs font-bold transition-colors shadow-lg shadow-orange-600/20"
            >
              <LogIn className="h-4 w-4" />
              <span>Sign in</span>
            </Link>
            <Link
              href="/demo/sailor"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-2xl border border-white/10 bg-white/5 hover:bg-white/10 text-slate-200 px-6 py-3 text-xs font-bold transition-colors"
            >
              <Sparkles className="h-4 w-4 text-orange-400" />
              <span>Explore Sailor Demo</span>
            </Link>
          </div>

          <div className="pt-4 border-t border-white/10 flex items-center justify-center gap-1.5 text-xs text-slate-400">
            <span>Haven&apos;t claimed your profile yet?</span>
            <Link
              href="/claim-profile"
              className="font-bold text-orange-400 hover:underline inline-flex items-center gap-0.5"
            >
              <span>Claim profile</span>
              <UserPlus className="h-3 w-3" />
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
    .select({
      id: sailors.id,
      name: sailors.name,
      handle: sailors.handle,
      sailNumber: sailors.sailNumber,
      sailNumberIlca4: sailors.sailNumberIlca4,
      club: sailors.club,
      school: sailors.school,
      gender: sailors.gender,
      nationality: sailors.nationality,
      avatarUrl: sailors.avatarUrl,
      currentFleet: sailors.currentFleet,
      ownerRelation: sailors.ownerRelation,
      nationalSquadStatus: sailors.nationalSquadStatus,
      dob: sailors.dob,
      instagram: sailors.instagram,
      hullBrand: sailors.hullBrand,
      sailMake: sailors.sailMake,
      foilBrand: sailors.foilBrand,
      mast: sailors.mast,
      equipmentNotes: sailors.equipmentNotes,
    })
    .from(sailors)
    .where(or(...conditions));

  const athletes: AthleteProfile[] = rows.map((s) => ({
    ...s,
    ownerRelation: claimMap.get(s.id) || s.ownerRelation || "sailor",
  }));

  if (athletes.length === 0) {
    return (
      <div className="mx-auto max-w-xl px-4 py-20 text-center">
        <div className="rounded-3xl border border-white/10 bg-[#121520] p-8 sm:p-10 shadow-xl space-y-5">
          <div className="inline-flex h-14 w-14 items-center justify-center rounded-2xl bg-amber-500/15 text-amber-400 border border-amber-500/30 shadow-sm">
            <Compass className="h-7 w-7" />
          </div>

          <div className="space-y-2">
            <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
              No Claimed Profile Found
            </h1>
            <p className="text-sm leading-relaxed text-slate-400 max-w-md mx-auto">
              Your account is signed in, but is not yet linked to a sailor profile. Claim your profile to log regattas, upload official evidence, and manage equipment.
            </p>
          </div>

          <div className="pt-2 flex flex-col sm:flex-row items-center justify-center gap-3">
            <Link
              href="/claim-profile"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-2xl bg-orange-600 hover:bg-orange-500 text-white px-6 py-3 text-xs font-bold transition-colors shadow-lg shadow-orange-600/20"
            >
              <UserPlus className="h-4 w-4" />
              <span>Claim Sailor Profile</span>
            </Link>
            <Link
              href="/demo/sailor"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-2xl border border-white/10 bg-white/5 hover:bg-white/10 text-slate-200 px-6 py-3 text-xs font-bold transition-colors"
            >
              <Sparkles className="h-4 w-4 text-orange-400" />
              <span>Explore Sailor Demo</span>
            </Link>
          </div>
        </div>
      </div>
    );
  }

  return (
    <AthleteHub
      athletes={athletes}
      initialSailorId={sp.id}
      initialTab={sp.tab}
      initialAction={sp.action}
    />
  );
}
