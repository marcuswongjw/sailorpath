import Link from "next/link";
import { Search, UserPlus, Link2 } from "lucide-react";

export const dynamic = "force-dynamic";

export default function ClaimProfilePage() {
  return (
    <div className="mx-auto max-w-lg px-4 py-12 sm:py-16 space-y-8">
      <div className="text-center space-y-3">
        <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
          Claim your profile
        </h1>
        <p className="text-sm text-slate-400 leading-relaxed">
          Find your sailor page, create an account, and submit a claim so you
          can edit your logbook, journey, and privacy settings.
        </p>
      </div>

      <ol className="space-y-4">
        <li className="rounded-2xl border border-white/10 bg-white/[0.03] p-4 flex gap-3">
          <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-orange-500/15 text-orange-400 text-xs font-black">
            1
          </span>
          <div>
            <p className="text-sm font-bold text-white flex items-center gap-2">
              <Search className="h-4 w-4 text-slate-500" />
              Find your name
            </p>
            <p className="text-xs text-slate-500 mt-1 leading-relaxed">
              Search by name or sail number. Open your public profile.
            </p>
            <Link
              href="/search"
              className="inline-flex mt-3 rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-[11px] font-bold text-white"
            >
              Search sailors
            </Link>
          </div>
        </li>
        <li className="rounded-2xl border border-white/10 bg-white/[0.03] p-4 flex gap-3">
          <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-orange-500/15 text-orange-400 text-xs font-black">
            2
          </span>
          <div>
            <p className="text-sm font-bold text-white flex items-center gap-2">
              <UserPlus className="h-4 w-4 text-slate-500" />
              Sign in or register
            </p>
            <p className="text-xs text-slate-500 mt-1 leading-relaxed">
              You need an account so we can verify claims and save your edits.
            </p>
            <div className="mt-3 flex flex-wrap gap-2">
              <Link
                href="/login"
                className="rounded-full border border-white/15 bg-white/5 px-4 py-2 text-[11px] font-bold text-white hover:border-orange-500/40"
              >
                Log in
              </Link>
              <Link
                href="/register"
                className="rounded-full border border-white/15 bg-white/5 px-4 py-2 text-[11px] font-bold text-white hover:border-orange-500/40"
              >
                Create account
              </Link>
            </div>
          </div>
        </li>
        <li className="rounded-2xl border border-white/10 bg-white/[0.03] p-4 flex gap-3">
          <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-orange-500/15 text-orange-400 text-xs font-black">
            3
          </span>
          <div>
            <p className="text-sm font-bold text-white flex items-center gap-2">
              <Link2 className="h-4 w-4 text-slate-500" />
              Submit a claim on your profile
            </p>
            <p className="text-xs text-slate-500 mt-1 leading-relaxed">
              On the sailor page, use Claim profile and choose{" "}
              <strong className="text-slate-300">Parent</strong> or{" "}
              <strong className="text-slate-300">Sailor</strong>. An admin will
              review and link the account. Parents then use the{" "}
              <Link href="/parent" className="text-emerald-400 font-semibold">
                Parent dashboard
              </Link>
              .
            </p>
          </div>
        </li>
      </ol>

      <p className="text-center text-[11px] text-slate-600">
        <Link href="/" className="text-slate-500 hover:text-white">
          ← Home
        </Link>
        {" · "}
        <Link href="/sample" className="text-slate-500 hover:text-white">
          Tour demo profile
        </Link>
      </p>
    </div>
  );
}
