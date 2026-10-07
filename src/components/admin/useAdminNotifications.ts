"use client";

import { useQuery } from "@tanstack/react-query";
import { adminQueryKeys } from "@/components/admin/adminQueryKeys";
import { coachRequestsFromCache } from "@/components/admin/coachAccessCache";
import { totalPendingAdminInboxItems } from "@/lib/admin/adminInboxCounts";

type ClaimNotification = { status?: string; createdAt?: string | null };
type DatedRow = { createdAt?: string | null; requestedAt?: string | null };

function earliest(values: Array<string | null | undefined>): number | null {
  let best: number | null = null;
  for (const value of values) {
    if (!value) continue;
    const time = new Date(value).getTime();
    if (!Number.isFinite(time)) continue;
    if (best == null || time < best) best = time;
  }
  return best;
}

/** Actionable inbox queue counts and oldest-first landing view (60s poll). */
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
      return (data.messages || []) as DatedRow[];
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
        requests: (Array.isArray(data.requests) ? data.requests : []) as Array<
          ClaimNotification & DatedRow
        >,
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

  const claimsPendingCount = (claimsQuery.data ?? []).filter(
    (claim) => claim.status === "pending"
  ).length;
  const supportNewCount = supportQuery.data?.length ?? 0;
  const coachPendingCount = coachRequestsFromCache(coachAccessQuery.data).filter(
    (request) => request.status === "pending"
  ).length;
  const suggestionsCount = Number(suggestionsQuery.data?.count ?? 0);
  const inboxQueueCounts = {
    suggestions: suggestionsCount,
    claims: claimsPendingCount,
    coaches: coachPendingCount,
    support: supportNewCount,
  };
  const inboxNotifCount = totalPendingAdminInboxItems(inboxQueueCounts);

  const pendingClaims = (claimsQuery.data ?? []).filter(
    (claim) => claim.status === "pending"
  );
  const pendingCoaches = coachRequestsFromCache(coachAccessQuery.data).filter(
    (request) => request.status === "pending"
  ) as Array<ClaimNotification & DatedRow>;
  const suggestionRows = (
    Array.isArray(suggestionsQuery.data?.suggestions)
      ? suggestionsQuery.data.suggestions
      : []
  ) as DatedRow[];
  const queues = [
    {
      view: "suggestions" as const,
      count: suggestionsCount,
      at: earliest(suggestionRows.map((row) => row.createdAt)),
    },
    {
      view: "claims" as const,
      count: claimsPendingCount,
      at: earliest(pendingClaims.map((claim) => claim.createdAt)),
    },
    {
      view: "coaches" as const,
      count: coachPendingCount,
      at: earliest(pendingCoaches.map((request) => request.requestedAt || request.createdAt)),
    },
    {
      view: "support" as const,
      count: supportNewCount,
      at: earliest((supportQuery.data ?? []).map((row) => row.createdAt)),
    },
  ].filter((queue) => queue.count > 0);
  queues.sort(
    (a, b) =>
      (a.at ?? Number.MAX_SAFE_INTEGER) - (b.at ?? Number.MAX_SAFE_INTEGER)
  );
  const inboxLandingView = queues[0]?.view ?? "claims";

  return {
    claimsPendingCount,
    supportNewCount,
    coachPendingCount,
    suggestionsCount,
    inboxQueueCounts,
    inboxNotifCount,
    inboxLandingView,
  };
}
