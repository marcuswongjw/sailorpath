import Link from "next/link";
import { Database } from "lucide-react";

/** Shown when a page needs Postgres and it is not reachable. No mock data. */
export function DbOffline({ message }: { message?: string }) {
  return (
    <div className="mx-auto max-w-xl px-4 py-16 text-center space-y-4">
      <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-rose-500/10 border border-rose-500/20 text-rose-400">
        <Database className="h-6 w-6" />
      </div>
      <h1 className="text-xl font-black text-white">Database not connected</h1>
      <p className="text-sm text-slate-400 leading-relaxed">
        {message ||
          "This page needs PostgreSQL. Set DATABASE_URL on Vercel (Transaction pooler :6543), run 001_init.sql, and redeploy."}
      </p>
      <div className="flex flex-wrap justify-center gap-3 pt-2">
        <Link
          href="/sample"
          className="rounded-full bg-amber-500/15 border border-amber-500/30 px-5 py-2 text-xs font-bold text-amber-100"
        >
          View sample project
        </Link>
        <Link
          href="/api/health"
          className="rounded-full border border-white/10 px-5 py-2 text-xs font-bold text-white"
        >
          /api/health
        </Link>
        <Link
          href="/"
          className="rounded-full border border-white/10 px-5 py-2 text-xs font-bold text-slate-300"
        >
          Home
        </Link>
      </div>
    </div>
  );
}
