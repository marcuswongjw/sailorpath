/** Shared TanStack Query keys for admin list caches. */

export const adminQueryKeys = {
  all: ["admin"] as const,
  sailors: () => ["admin", "sailors"] as const,
  regattas: () => ["admin", "regattas"] as const,
  resultsAll: () => ["admin", "results", "all"] as const,
  resultsByRegatta: (regattaId: string) =>
    ["admin", "results", "regatta", regattaId] as const,
};
