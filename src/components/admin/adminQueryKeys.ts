/** Shared TanStack Query keys for admin list caches. */

export const adminQueryKeys = {
  all: ["admin"] as const,
  sailors: () => ["admin", "sailors"] as const,
  regattas: () => ["admin", "regattas"] as const,
  resultsAll: () => ["admin", "results", "all"] as const,
  resultsByRegatta: (regattaId: string) =>
    ["admin", "results", "regatta", regattaId] as const,
  stats: () => ["admin", "stats"] as const,
  audit: (days: number) => ["admin", "audit", days] as const,
  claims: () => ["admin", "claims"] as const,
  coachAccess: () => ["admin", "coach-access"] as const,
  promote: () => ["admin", "promote"] as const,
  support: (status: string) => ["admin", "support", status] as const,
};
