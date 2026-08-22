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

  const claimsPendingCount = (claimsQuery.data ?? []).filter(
    (claim) => claim.status === "pending"
  ).length;
  const supportNewCount = supportQuery.data?.length ?? 0;

  const inboxNotifCount = claimsPendingCount + supportNewCount;

  return {
    claimsPendingCount,
    supportNewCount,
    inboxNotifCount,
  };
}
