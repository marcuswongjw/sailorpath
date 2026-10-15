type QueryValue = string | string[] | undefined;
type Query = Record<string, QueryValue>;

function copyKnown(params: Query, keys: readonly string[]) {
  const next = new URLSearchParams();
  for (const key of keys) {
    const value = params[key];
    if (typeof value === "string" && value) next.set(key, value);
  }
  return next;
}

/** Preserves supported browse intent when historical Calendar links move to Results. */
export function calendarPastResultsHref(params: Query): string {
  const next = copyKnown(params, ["class", "region", "year", "q"]);
  return `/results${next.size ? `?${next.toString()}` : ""}`;
}

/** The old search landing page now resolves to the public Sailors directory. */
export function legacySearchHref(params: Query): string {
  const next = copyKnown(params, ["q", "fleet", "club", "nationality"]);
  const query = params.query;
  if (!next.has("q") && typeof query === "string" && query) next.set("q", query);
  return `/sailors${next.size ? `?${next.toString()}` : ""}`;
}

export const PRIVATE_WORKSPACE_REDIRECTS = {
  "/parent": "/account/parent",
  "/coach-tools": "/account/coach",
} as const;
