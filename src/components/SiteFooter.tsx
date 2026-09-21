"use client";

import Link from "next/link";
import { useSyncExternalStore } from "react";
import { useAccount } from "@/components/AccountProvider";
import { BrandWordmark } from "@/components/BrandMark";
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
    <footer className="border-t border-harbour-shadow bg-harbour-shadow py-8 sm:py-10 text-[13px] text-sailcloth">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 flex flex-col sm:flex-row items-center justify-between gap-4">
        <div className="flex items-center gap-3">
          <BrandWordmark reversed className="text-base sm:text-lg" />
          <span className="text-soft-aqua/60">·</span>
          <p className="text-soft-aqua">© {new Date().getFullYear()} SailorPath</p>
        </div>
        <div className="flex flex-wrap items-center justify-center gap-x-5 gap-y-2 text-sailcloth/90">
          <Link
            href="/support"
            className="hover:text-white hover:underline transition-colors"
          >
            Help &amp; support
          </Link>
          <Link
            href="/privacy"
            className="hover:text-white hover:underline transition-colors"
          >
            Privacy
          </Link>
          <Link
            href="/terms"
            className="hover:text-white hover:underline transition-colors"
          >
            Terms
          </Link>
          {showDemo && (
            <Link
              href="/sample"
              className="hover:text-white hover:underline transition-colors"
            >
              Explore demo
            </Link>
          )}
          <Link
            href="/sg/optimist/gold"
            className="hover:text-white hover:underline transition-colors"
          >
            Gold standings
          </Link>
          <Link
            href="/sg/wingfoil"
            className="hover:text-white hover:underline transition-colors"
          >
            WingFoil
          </Link>
          <Link
            href="/sg/techno293"
            className="hover:text-white hover:underline transition-colors"
          >
            Techno 293
          </Link>
        </div>
      </div>
    </footer>
  );
}
