"use client";

import { useState, useEffect } from "react";

/**
 * Pending claims + new support message badge counts (60s poll).
 */
export function useAdminNotifications(isSuperadmin: boolean) {
  const [claimsPendingCount, setClaimsPendingCount] = useState(0);
  const [supportNewCount, setSupportNewCount] = useState(0);

  useEffect(() => {
    if (!isSuperadmin) return;
    let cancelled = false;
    const loadNotifs = async () => {
      try {
        const [cRes, sRes] = await Promise.all([
          fetch("/api/admin/claims"),
          fetch("/api/support?status=new"),
        ]);
        const cData = await cRes.json().catch(() => ({}));
        const sData = await sRes.json().catch(() => ({}));
        if (cancelled) return;
        if (cRes.ok && Array.isArray(cData.claims)) {
          setClaimsPendingCount(
            cData.claims.filter(
              (c: { status?: string }) => c.status === "pending"
            ).length
          );
        }
        if (sRes.ok && Array.isArray(sData.messages)) {
          setSupportNewCount(sData.messages.length);
        }
      } catch {
        /* ignore */
      }
    };
    void loadNotifs();
    const t = setInterval(loadNotifs, 60_000);
    return () => {
      cancelled = true;
      clearInterval(t);
    };
  }, [isSuperadmin]);

  const inboxNotifCount = claimsPendingCount + supportNewCount;

  return {
    claimsPendingCount,
    supportNewCount,
    inboxNotifCount,
  };
}
