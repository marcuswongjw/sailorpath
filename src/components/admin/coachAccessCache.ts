/** Badge counts and the coach panel share one query cache. Either shape can be cached. */

export type CoachAccessCache = {
  requests: { status?: string }[];
  coaches: unknown[];
};

export function coachRequestsFromCache(data: unknown): { status?: string }[] {
  if (Array.isArray(data)) return data;
  if (
    data &&
    typeof data === "object" &&
    Array.isArray((data as { requests?: unknown }).requests)
  ) {
    return (data as { requests: { status?: string }[] }).requests;
  }
  return [];
}

export function coachListFromCache<T>(data: unknown): T[] {
  if (
    data &&
    typeof data === "object" &&
    !Array.isArray(data) &&
    Array.isArray((data as { coaches?: unknown }).coaches)
  ) {
    return (data as { coaches: T[] }).coaches;
  }
  return [];
}
