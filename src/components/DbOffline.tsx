import Link from "next/link";
import { Database } from "lucide-react";

/** Shown when a page needs Postgres and it is not reachable. No mock data. */
export function DbOffline({ title = "Results are temporarily unavailable" }: { message?: string; title?: string }) {
  return (
    <div className="mx-auto max-w-xl px-4 py-16 text-center space-y-4">
      <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-rose-500/10 border border-rose-500/20 text-rose-400">
        <Database className="h-6 w-6" />
      </div>
      <h1 className="text-xl font-black text-harbour-shadow">
        {title}
      </h1>
      <p className="text-sm text-slate-soft leading-relaxed">
        We couldn&apos;t load this page. Try again in a moment, or contact support
        if the problem continues.
      </p>
      <div className="flex flex-wrap justify-center gap-3 pt-2">
        <a
          href=""
          className="rounded-full bg-orange-600 px-5 py-2 text-[15px] font-semibold text-white hover:bg-orange-500"
        >
          Try again
        </a>
        <Link
          href="/rankings"
          className="rounded-full border border-cool-veil px-5 py-2 text-[15px] font-semibold text-harbour"
        >
          View rankings
        </Link>
        <Link
          href="/support"
          className="rounded-full border border-cool-veil px-5 py-2 text-[15px] font-semibold text-harbour"
        >
          Contact support
        </Link>
      </div>
    </div>
  );
}
