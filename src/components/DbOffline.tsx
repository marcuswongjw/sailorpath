import Link from "next/link";
import { Database } from "lucide-react";

export function DbOffline({ message }: { message?: string }) {
  return (
    <div className="mx-auto max-w-xl px-4 py-16 text-center space-y-4">
      <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-rose-500/10 border border-rose-500/20 text-rose-400">
        <Database className="h-6 w-6" />
      </div>
      <h1 className="text-xl font-black text-white">Database offline</h1>
      <p className="text-sm text-slate-400 leading-relaxed">
        {message ||
          "This site cannot reach PostgreSQL. Rankings and admin need a working DATABASE_URL on Vercel."}
      </p>
      <p className="text-xs text-slate-500">
        Check{" "}
        <Link href="/api/health" className="text-orange-400 font-bold hover:underline">
          /api/health
        </Link>{" "}
        then follow docs/GO_LIVE.md
      </p>
    </div>
  );
}
