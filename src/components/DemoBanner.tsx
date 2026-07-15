import React from "react";
import { Database } from "lucide-react";

interface DemoBannerProps {
  isDemo: boolean;
}

export function DemoBanner({ isDemo }: DemoBannerProps) {
  if (!isDemo) return null;

  return (
    <div className="bg-orange-600/10 border-b border-orange-500/20 text-orange-400 py-2.5 px-4 text-center text-xs font-semibold flex items-center justify-center gap-2 animate-pulse">
      <Database className="h-4 w-4" />
      <span>
        Running in **Demo Mode** (PostgreSQL not connected). Add your{" "}
        <code className="bg-orange-500/20 px-1.5 py-0.5 rounded text-white font-mono">
          DATABASE_URL
        </code>{" "}
        to <code className="bg-orange-500/20 px-1.5 py-0.5 rounded text-white font-mono">.env.local</code> to sync live rankings.
      </span>
    </div>
  );
}
