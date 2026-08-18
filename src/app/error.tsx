"use client";

import Link from "next/link";
import { AlertTriangle } from "lucide-react";

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  const isDev = process.env.NODE_ENV === "development";

  return (
    <div className="mx-auto max-w-xl px-4 py-16 text-center space-y-4">
      <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-rose-500/10 border border-rose-500/20 text-rose-400">
        <AlertTriangle className="h-6 w-6" />
      </div>
      <h1 className="text-xl font-black text-white">Something went wrong</h1>
      <p className="text-sm text-slate-400 leading-relaxed">
        An unexpected error occurred. Please try again.
      </p>
      {isDev && error.message && (
        <p className="text-[11px] text-slate-500 font-mono break-words px-2">
          {error.message}
        </p>
      )}
      {error.digest && (
        <p className="text-[11px] text-slate-600 font-mono">
          Error ID: {error.digest}
        </p>
      )}
      <div className="flex flex-wrap justify-center gap-3 pt-2">
        <button
          onClick={reset}
          className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500"
        >
          Try again
        </button>
        <Link
          href="/"
          className="rounded-full border border-white/10 px-5 py-2 text-xs font-bold text-slate-300 hover:text-white"
        >
          Home
        </Link>
        <Link
          href="/support"
          className="rounded-full border border-white/10 px-5 py-2 text-xs font-bold text-slate-300 hover:text-white"
        >
          Contact support
        </Link>
      </div>
    </div>
  );
}
