import Link from "next/link";
import { Search, UserPlus, Link2 } from "lucide-react";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Claim a sailor profile | SailorPath",
  description: "Find an existing sailor profile and connect it securely to your SailorPath account.",
};

export const dynamic = "force-dynamic";

export default function ClaimProfilePage() {
  return (
    <div className="mx-auto max-w-lg px-4 py-12 sm:py-16 space-y-8 text-charcoal">
      <div className="text-center space-y-3">
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">
          Profile verification
        </p>
        <h1 className="text-2xl sm:text-3xl font-black text-harbour-shadow tracking-tight">
          Claim your sailor profile
        </h1>
        <p className="text-sm text-slate-soft leading-relaxed">
          Find your public competition profile, sign in, and submit a claim as
          the sailor or parent/guardian to unlock your private logbook,
          equipment locker, and privacy controls.
        </p>
      </div>

      <ol className="space-y-4">
        <li className="rounded-2xl border border-cool-veil bg-warm-white p-5 shadow-xs flex gap-3.5">
          <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-aqua-mist text-harbour text-xs font-black">
            1
          </span>
          <div>
            <p className="text-sm font-bold text-harbour-shadow flex items-center gap-2">
              <Search className="h-4 w-4 text-harbour" aria-hidden="true" />
              Find your profile
            </p>
            <p className="text-xs text-slate-soft mt-1 leading-relaxed">
              Search by sailor name, sail number, or club in the public directory
              and open your sailor profile page.
            </p>
            <Link
              href="/sailors"
              className="sp-primary inline-flex mt-3 px-4 py-2 text-sm font-semibold"
            >
              Search sailors
            </Link>
          </div>
        </li>
        <li className="rounded-2xl border border-cool-veil bg-warm-white p-5 shadow-xs flex gap-3.5">
          <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-aqua-mist text-harbour text-xs font-black">
            2
          </span>
          <div>
            <p className="text-sm font-bold text-harbour-shadow flex items-center gap-2">
              <UserPlus className="h-4 w-4 text-harbour" aria-hidden="true" />
              Sign in or create an account
            </p>
            <p className="text-xs text-slate-soft mt-1 leading-relaxed">
              An account lets us verify your claim and keep private notes,
              equipment records, and consent settings tied to you.
            </p>
            <div className="mt-3 flex flex-wrap gap-2">
              <Link
                href="/login?next=%2Fsailors"
                className="sp-btn-primary inline-flex px-4 py-2 text-sm font-semibold"
              >
                Log in or sign up
              </Link>
            </div>
          </div>
        </li>
        <li className="rounded-2xl border border-cool-veil bg-warm-white p-5 shadow-xs flex gap-3.5">
          <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-aqua-mist text-harbour text-xs font-black">
            3
          </span>
          <div>
            <p className="text-sm font-bold text-harbour-shadow flex items-center gap-2">
              <Link2 className="h-4 w-4 text-harbour" aria-hidden="true" />
              Submit your claim for review
            </p>
            <p className="text-xs text-slate-soft mt-1 leading-relaxed">
              On the sailor profile page, select{" "}
              <strong className="text-charcoal">Claim this profile</strong> and
              choose <strong className="text-charcoal">Parent</strong> or{" "}
              <strong className="text-charcoal">Sailor</strong>. Once reviewed
              and approved, your profile will appear in your{" "}
              <Link
                href="/account/parent"
                className="text-harbour font-semibold hover:underline"
              >
                Sailing workspace
              </Link>
              .
            </p>
          </div>
        </li>
      </ol>

      <p className="text-center text-[13px] text-slate-soft">
        <Link href="/" className="font-semibold text-harbour hover:underline">
          ← Home
        </Link>
        {" · "}
        <Link href="/sample" className="font-semibold text-harbour hover:underline">
          Explore sample profile
        </Link>
        {" · "}
        <Link href="/demo/parent" className="font-semibold text-harbour hover:underline">
          Try parent demo
        </Link>
      </p>
    </div>
  );
}
