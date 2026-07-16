import React from "react";
import { Database } from "lucide-react";

interface DemoBannerProps {
  isDemo: boolean;
}

export function DemoBanner({ isDemo }: DemoBannerProps) {
  if (!isDemo) return null;

  return (
    <div className="bg-orange-600/10 border-b border-orange-500/20 text-orange-400 py-2.5 px-4 text-center text-xs font-semibold flex flex-col sm:flex-row items-center justify-center gap-1 sm:gap-2">
      <span className="inline-flex items-center gap-2">
        <Database className="h-4 w-4 shrink-0" />
        <span>
          <strong className="text-orange-300">Demo Mode</strong> — app cannot reach PostgreSQL.
        </span>
      </span>
      <span className="text-orange-400/90 font-normal max-w-3xl">
        On Vercel: set <code className="bg-orange-500/20 px-1 rounded text-white font-mono">DATABASE_URL</code>{" "}
        (Supabase pooler connection string) under Project → Settings → Environment Variables for{" "}
        <strong>Production</strong>, then <strong>Redeploy</strong>. Locally use{" "}
        <code className="bg-orange-500/20 px-1 rounded text-white font-mono">.env.local</code>.
      </span>
    </div>
  );
}
