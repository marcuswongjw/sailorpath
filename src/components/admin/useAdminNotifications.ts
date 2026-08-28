"use client";

import { useQuery } from "@tanstack/react-query";
import { adminQueryKeys } from "@/components/admin/adminQueryKeys";

type ClaimNotification = { status?: string };

/**
 * Pending claims + new support message badge counts (60s poll).
 */
export function useAdminNotifications(isSuperadmin: boolean) {
  const claimsQuery = useQuery({
    queryKey: adminQueryKeys.claims(),
    enabled: isSuperadmin,
    refetchInterval: 60_000,
    queryFn: async () => {
      const res = await fetch("/api/admin/claims");
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to load claims");
      return (data.claims || []) as ClaimNotification[];
    },
  });

  const supportQuery = useQuery({
    queryKey: adminQueryKeys.support("new"),
    enabled: isSuperadmin,
    refetchInterval: 60_000,
    queryFn: async () => {
      const res = await fetch("/api/support?status=new");
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to load support");
      return (data.messages || []) as unknown[];
    },
  });

  const coachAccessQuery = useQuery({
    queryKey: adminQueryKeys.coachAccess(),
    enabled: isSuperadmin,
    refetchInterval: 60_000,
    queryFn: async () => {
      const res = await fetch("/api/admin/coach-access");
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to load coach requests");
      return (data.requests || []) as ClaimNotification[];
    },
  });

  const claimsPendingCount = (claimsQuery.data ?? []).filter(
    (claim) => claim.status === "pending"
  ).length;
  const supportNewCount = supportQuery.data?.length ?? 0;
  const coachPendingCount = (coachAccessQuery.data ?? []).filter(
    (request) => request.status === "pending"
  ).length;

  const inboxNotifCount = claimsPendingCount + supportNewCount + coachPendingCount;

  return {
    claimsPendingCount,
    supportNewCount,
    coachPendingCount,
    inboxNotifCount,
  };
}
