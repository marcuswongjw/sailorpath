import Link from "next/link";
import { LogIn } from "lucide-react";
import { FollowingHome } from "@/components/FollowingHome";
import { getAuthContext } from "@/lib/auth";
import { listFollowedSailorSummaries } from "@/lib/followedSailorsQuery";

export const dynamic = "force-dynamic";

export const metadata = {
  title: "Following | SailorPath",
  description: "Sailors you follow, with this half’s place and the next counting event.",
};

export default async function FollowingPage() {
  const auth = await getAuthContext();
  if (!auth) {
    return (
      <div className="mx-auto max-w-xl px-4 py-20 text-center">
        <div className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-8 sm:p-10 shadow-sm space-y-5">
          <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
            Following
          </h1>
          <p className="text-sm leading-relaxed text-[var(--sp-charcoal-slate)]">
            Sign in to follow sailors and see where they stand this half.
          </p>
          <Link
            href="/login?next=%2Ffollowing"
            className="inline-flex items-center justify-center gap-2 rounded-2xl bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] text-white px-6 py-3 text-[15px] font-semibold transition-colors shadow-sm"
          >
            <LogIn className="h-4 w-4" />
            Sign in
          </Link>
        </div>
      </div>
    );
  }

  let sailors: Awaited<ReturnType<typeof listFollowedSailorSummaries>> | null = null;
  let loadFailed = false;
  try {
    sailors = await listFollowedSailorSummaries(auth.userId);
  } catch {
    loadFailed = true;
  }

  if (loadFailed || !sailors) {
    return (
      <div className="mx-auto max-w-xl px-4 py-20 text-center">
        <h1 className="text-2xl font-black text-[var(--sp-harbour-shadow)]">Following</h1>
        <p className="mt-3 text-sm text-[var(--sp-charcoal-slate)]">
          The follow list could not be loaded. Try again in a moment.
        </p>
      </div>
    );
  }

  return <FollowingHome sailors={sailors} />;
}
