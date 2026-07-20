"use client";

import { useEffect, useRef } from "react";
import { usePathname } from "next/navigation";

const SESSION_KEY = "sp_usage_sid";

function getSessionId(): string {
  if (typeof window === "undefined") return "";
  try {
    let id = sessionStorage.getItem(SESSION_KEY);
    if (!id) {
      id =
        typeof crypto !== "undefined" && "randomUUID" in crypto
          ? crypto.randomUUID()
          : `s-${Date.now()}-${Math.random().toString(36).slice(2, 10)}`;
      sessionStorage.setItem(SESSION_KEY, id);
    }
    return id;
  } catch {
    return `s-${Date.now()}`;
  }
}

function eventTypeForPath(path: string): string {
  if (path.startsWith("/sg/optimist/gold") || path.startsWith("/sg/optimist/silver")) {
    return "ranking_view";
  }
  if (path.startsWith("/sample")) return "sample_view";
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
  const last = useRef<string | null>(null);

  useEffect(() => {
    if (!pathname || pathname.startsWith("/api")) return;
    if (last.current === pathname) return;
    last.current = pathname;

    const sessionId = getSessionId();
    const eventType = eventTypeForPath(pathname);

    void fetch("/api/usage", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        eventType,
        path: pathname,
        sessionId,
        role: "public",
      }),
      credentials: "include",
      keepalive: true,
    }).catch(() => {
      /* offline / blocked */
    });
  }, [pathname]);

  return null;
}
