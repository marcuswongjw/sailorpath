"use client";

import Link from "next/link";
import { useSyncExternalStore } from "react";
import { useAccount } from "@/components/AccountProvider";
import { shouldShowDemoNavigation } from "@/lib/adminHost";

const subscribeToHost = () => () => {};
const getBrowserHost = () => window.location.hostname;
const getServerHost = () => "";

/**
 * Footer links — hides the demo when an account already owns a claimed profile.
 * Uses shared AccountProvider (no second /api/account fetch).
 */
export function SiteFooter() {
  const { owned, ready } = useAccount();
  const host = useSyncExternalStore(
    subscribeToHost,
    getBrowserHost,
    getServerHost
  );

  const showDemo = Boolean(host) &&
    (!ready || shouldShowDemoNavigation(host, owned.length));

  return (
    <footer className="sp-reversed border-t border-harbour-shadow bg-harbour-shadow py-7 sm:py-9 text-center text-xs text-soft-aqua">
      <div className="mx-auto max-w-7xl px-4 flex flex-col sm:flex-row items-center justify-between gap-3">
        <p>© {new Date().getFullYear()} SailorPath</p>
        <div className="flex flex-wrap items-center justify-center gap-4">
          <Link
            href="/support"
            className="hover:text-orange-400 transition-colors"
          >
            Help &amp; support
          </Link>
          <Link
            href="/privacy"
            className="hover:text-orange-400 transition-colors"
          >
            Privacy
          </Link>
          <Link
            href="/terms"
            className="hover:text-orange-400 transition-colors"
          >
            Terms
          </Link>
          {showDemo && (
            <Link
              href="/sample"
              className="hover:text-slate-300 transition-colors"
            >
              Explore demo
            </Link>
          )}
          <Link
            href="/sg/optimist/gold"
            className="hover:text-slate-300 transition-colors"
          >
            Gold standings
          </Link>
          <Link
            href="/sg/wingfoil"
            className="hover:text-teal-300 transition-colors"
          >
            WingFoil
          </Link>
          <Link
            href="/sg/techno293"
            className="hover:text-cyan-300 transition-colors"
          >
            Techno 293
          </Link>
        </div>
      </div>
    </footer>
  );
}
