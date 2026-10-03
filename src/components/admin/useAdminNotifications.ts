"use client";

import { useQuery } from "@tanstack/react-query";
import { adminQueryKeys } from "@/components/admin/adminQueryKeys";
import { coachRequestsFromCache } from "@/components/admin/coachAccessCache";

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
      return {
        requests: (Array.isArray(data.requests) ? data.requests : []) as ClaimNotification[],
        coaches: Array.isArray(data.coaches) ? data.coaches : [],
      };
    },
  });

  const suggestionsQuery = useQuery({
    queryKey: adminQueryKeys.regattaSuggestions(),
    enabled: isSuperadmin,
    refetchInterval: 60_000,
    queryFn: async () => {
      const res = await fetch("/api/admin/regatta-suggestions");
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to load suggestions");
      return data;
    },
  });

  const claimedUpdatesQuery = useQuery({
    queryKey: ["admin", "claimed-profile-updates-count"],
    enabled: isSuperadmin,
    refetchInterval: 60_000,
    queryFn: async () => {
      try {
        const res = await fetch("/api/admin/change-log?days=7&limit=50");
        const data = await res.json();
        if (!res.ok) return 0;
        const changes = (data.changes || []) as Array<{ action: string }>;
        return changes.filter((c) => c.action === "claimed_profile.updated").length;
      } catch {
        return 0;
      }
    },
  });

  const claimsPendingCount = (claimsQuery.data ?? []).filter(
    (claim) => claim.status === "pending"
  ).length;
  const supportNewCount = supportQuery.data?.length ?? 0;
  const coachPendingCount = coachRequestsFromCache(coachAccessQuery.data).filter(
    (request) => request.status === "pending"
  ).length;
  const suggestionsCount = Number(suggestionsQuery.data?.count ?? 0);
  const claimedUpdatesCount = claimedUpdatesQuery.data ?? 0;

  const inboxNotifCount =
    claimsPendingCount +
    supportNewCount +
    coachPendingCount +
    suggestionsCount +
    claimedUpdatesCount;

  return {
    claimsPendingCount,
    supportNewCount,
    coachPendingCount,
    suggestionsCount,
    claimedUpdatesCount,
    inboxNotifCount,
  };
}
