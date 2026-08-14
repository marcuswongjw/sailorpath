"use client";

import { useEffect, useRef, useState } from "react";
import { usePathname, useSearchParams } from "next/navigation";
import { trackClientUsage } from "@/lib/clientUsage";

/**
 * Thin top progress bar during client navigations.
 * Completes when pathname/search changes (new page ready).
 */
export function NavigationProgress() {
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const [visible, setVisible] = useState(false);
  const [width, setWidth] = useState(0);
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const hideRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const navStartedAt = useRef<number | null>(null);
  const key = `${pathname}?${searchParams?.toString() || ""}`;
  const prevKey = useRef(key);

  const clearTimers = () => {
    if (timerRef.current) {
      clearInterval(timerRef.current);
      timerRef.current = null;
    }
    if (hideRef.current) {
      clearTimeout(hideRef.current);
      hideRef.current = null;
    }
  };

  const start = () => {
    clearTimers();
    navStartedAt.current = performance.now();
    setVisible(true);
    setWidth(12);
    timerRef.current = setInterval(() => {
      setWidth((w) => {
        if (w >= 88) return w;
        // Ease toward ~90% while waiting for the next page
        return w + Math.max(0.6, (90 - w) * 0.08);
      });
    }, 120);
  };

  const finish = (toPath?: string) => {
    clearTimers();
    if (navStartedAt.current != null) {
      const ms = Math.round(performance.now() - navStartedAt.current);
      navStartedAt.current = null;
      if (ms >= 50 && ms < 60_000) {
        trackClientUsage("nav_perf", toPath || pathname, { ms });
      }
    }
    setWidth(100);
    hideRef.current = setTimeout(() => {
      setVisible(false);
      setWidth(0);
    }, 220);
  };

  // Complete when the route changes
  useEffect(() => {
    if (prevKey.current !== key) {
      prevKey.current = key;
      finish(pathname);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [key]);

  // Start on link clicks (same-origin navigations)
  useEffect(() => {
    const onClick = (e: MouseEvent) => {
      if (e.defaultPrevented || e.button !== 0) return;
      if (e.metaKey || e.ctrlKey || e.shiftKey || e.altKey) return;
      const el = (e.target as HTMLElement | null)?.closest?.("a");
      if (!el) return;
      const href = el.getAttribute("href");
      if (!href || href.startsWith("#") || href.startsWith("mailto:")) return;
      if (el.target === "_blank" || el.hasAttribute("download")) return;
      try {
        const url = new URL(href, window.location.href);
        if (url.origin !== window.location.origin) return;
        const next = `${url.pathname}${url.search}`;
        const cur = `${window.location.pathname}${window.location.search}`;
        if (next === cur) return;
        start();
      } catch {
        /* ignore */
      }
    };

    document.addEventListener("click", onClick, true);
    return () => {
      document.removeEventListener("click", onClick, true);
      clearTimers();
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  if (!visible && width === 0) return null;

  return (
    <div
      className="pointer-events-none fixed left-0 right-0 top-0 z-[100] h-[3px]"
      aria-hidden
      role="progressbar"
      aria-valuemin={0}
      aria-valuemax={100}
      aria-valuenow={Math.round(width)}
    >
      <div
        className="h-full bg-gradient-to-r from-orange-500 via-orange-400 to-amber-300 shadow-[0_0_8px_rgba(249,115,22,0.7)] transition-[width] duration-150 ease-out"
        style={{ width: `${width}%` }}
      />
    </div>
  );
}
