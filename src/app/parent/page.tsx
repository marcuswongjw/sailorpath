import Link from "next/link";
import { ParentDashboard } from "@/components/ParentDashboard";
import { getAuthContext } from "@/lib/auth";
import { Heart, Sparkles, UserPlus, LogIn } from "lucide-react";

export const dynamic = "force-dynamic";

export const metadata = {
  title: "Parent dashboard | SailorPath",
  description:
    "Manage linked sailor profiles, rankings, and claim status on SailorPath.",
};

export default async function ParentPage() {
  const auth = await getAuthContext();

  if (!auth) {
    return (
      <div className="mx-auto max-w-xl px-4 py-20 text-center">
        <div className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-8 sm:p-10 shadow-sm space-y-5">
          <div className="inline-flex h-14 w-14 items-center justify-center rounded-2xl bg-emerald-500/15 text-emerald-600 border border-emerald-500/30 shadow-sm">
            <Heart className="h-7 w-7" />
          </div>

          <div className="space-y-2">
            <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
              Parent Command Center
            </h1>
            <p className="text-sm leading-relaxed text-[var(--sp-charcoal-slate)] max-w-md mx-auto">
              Sign in to manage linked sailor profiles, equipment maintenance alerts, and selection trials tracking.
            </p>
          </div>

          <div className="pt-2 flex flex-col sm:flex-row items-center justify-center gap-3">
            <Link
              href="/login?next=%2Fparent"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-2xl bg-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-harbour-shadow)]/90 text-white px-6 py-3 text-xs font-bold transition-colors shadow-sm"
            >
              <LogIn className="h-4 w-4" />
              <span>Sign in</span>
            </Link>
            <Link
              href="/demo/parent"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-2xl border border-emerald-500/40 bg-emerald-500/10 hover:bg-emerald-500/20 text-emerald-700 dark:text-emerald-300 px-6 py-3 text-xs font-bold transition-colors"
            >
              <Sparkles className="h-4 w-4 text-emerald-600" />
              <span>Explore Parent Demo</span>
            </Link>
          </div>

          <div className="pt-4 border-t border-[var(--sp-cool-veil)] flex items-center justify-center gap-1.5 text-xs text-[var(--sp-charcoal-slate)]">
            <span>Need to claim your child&apos;s profile?</span>
            <Link
              href="/claim-profile"
              className="font-bold text-orange-600 hover:underline inline-flex items-center gap-0.5"
            >
              <span>Claim profile</span>
              <UserPlus className="h-3 w-3" />
            </Link>
          </div>
        </div>
      </div>
    );
  }

  return <ParentDashboard />;
}
