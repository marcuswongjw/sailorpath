"use client";

import Link from "next/link";
import { useEffect, useState } from "react";

/**
 * Footer links — hides Demo for users who already own a claimed profile.
 */
export function SiteFooter() {
  const [hideDemo, setHideDemo] = useState(false);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const res = await fetch("/api/account", { credentials: "include" });
        if (!res.ok) return;
        const data = await res.json();
        if (!cancelled && (data.owned || []).length > 0) {
          setHideDemo(true);
        }
      } catch {
        /* guest */
      }
    })();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <footer className="border-t border-white/5 bg-[#07080c] py-6 sm:py-8 text-center text-xs text-slate-500">
      <div className="mx-auto max-w-7xl px-4 flex flex-col sm:flex-row items-center justify-between gap-3">
        <p>© {new Date().getFullYear()} SailorPath</p>
        <div className="flex flex-wrap items-center justify-center gap-4">
          <Link
            href="/support"
            className="hover:text-orange-400 transition-colors"
          >
            Help / Support
          </Link>
          {!hideDemo && (
            <Link
              href="/sample"
              className="hover:text-slate-300 transition-colors"
            >
              Demo
            </Link>
          )}
          <Link
            href="/sg/optimist/gold"
            className="hover:text-slate-300 transition-colors"
          >
            Gold standings
          </Link>
        </div>
      </div>
    </footer>
  );
}
