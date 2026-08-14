"use client";

import { useEffect, useRef } from "react";
import { usePathname } from "next/navigation";
import { trackClientUsage } from "@/lib/clientUsage";
import { useAccount } from "@/components/AccountProvider";

function eventTypeForPath(path: string): string {
  if (
    path.startsWith("/sg/optimist/gold") ||
    path.startsWith("/sg/optimist/silver") ||
    path.startsWith("/sg/ilca4")
  ) {
    // ILCA regatta list is not the ranking board
    if (path.includes("/regattas")) return "page_view";
    return "ranking_view";
  }
  if (path.startsWith("/rankings")) return "ranking_view";
  if (path.startsWith("/sample") || path.startsWith("/demo-profile")) {
    return "sample_view";
  }
  if (path.startsWith("/search")) return "search";
  if (path.startsWith("/admin")) return "admin_open";
  if (path.startsWith("/support")) return "page_view";
  // Public sailor profiles: /handle (not reserved)
  if (
    path.length > 1 &&
    !path.startsWith("/api") &&
    !path.startsWith("/sg/") &&
    !path.startsWith("/login") &&
    !path.startsWith("/register") &&
    !path.startsWith("/account") &&
    !path.startsWith("/claim-profile") &&
    !path.startsWith("/coach-tools") &&
    !path.startsWith("/how-rankings") &&
    path !== "/"
  ) {
    return "profile_view";
  }
  return "page_view";
}

/**
 * Fires a single privacy-light page usage event per navigation.
 * Failures are silent — never block UX.
 */
export function UsageBeacon() {
  const pathname = usePathname();
  const { owned, ready } = useAccount();
  const last = useRef<string | null>(null);

  useEffect(() => {
    if (!pathname || pathname.startsWith("/api")) return;

    const eventType = eventTypeForPath(pathname);
    // Wait for account so own-profile flag is accurate
    if (eventType === "profile_view" && !ready) return;
    if (last.current === pathname) return;
    last.current = pathname;

    const handle = pathname.startsWith("/")
      ? pathname.slice(1).split("/")[0]
      : "";
    const isOwn =
      eventType === "profile_view" &&
      owned.some((o) => o.handle === handle);

    trackClientUsage(eventType, pathname, {
      own: eventType === "profile_view" ? isOwn : null,
      fleet: pathname.includes("/gold")
        ? "gold"
        : pathname.includes("/silver")
          ? "silver"
          : pathname.includes("/ilca")
            ? "ilca4"
            : null,
    });
  }, [pathname, owned, ready]);

  return null;
}
