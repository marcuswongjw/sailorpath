export const SAILOR_DIRECTORY_PAGE_SIZE = 30;

export type SailorDirectoryParams = Partial<Record<"q" | "query" | "fleet" | "club" | "nationality" | "page", string | string[]>>;

function first(value?: string | string[]) {
  return (Array.isArray(value) ? value[0] || "" : value || "").trim();
}

export function directoryFilters(params: SailorDirectoryParams) {
  const fleet = first(params.fleet).toLowerCase();
  return {
    query: first(params.q) || first(params.query),
    fleet: fleet === "ilca4" ? "ilca" : ["gold", "silver", "ilca", "guest"].includes(fleet) ? fleet : "all",
    club: first(params.club),
    nationality: first(params.nationality),
    type: "sailors" as const,
  };
}

export function directoryPage<T>(rows: readonly T[], requestedPage?: string | string[]) {
  const pageCount = Math.max(1, Math.ceil(rows.length / SAILOR_DIRECTORY_PAGE_SIZE));
  const parsed = Number(first(requestedPage));
  const page = Number.isSafeInteger(parsed) && parsed > 0 ? Math.min(parsed, pageCount) : 1;
  const offset = (page - 1) * SAILOR_DIRECTORY_PAGE_SIZE;
  return {
    page,
    pageCount,
    total: rows.length,
    start: rows.length ? offset + 1 : 0,
    end: Math.min(offset + SAILOR_DIRECTORY_PAGE_SIZE, rows.length),
    rows: rows.slice(offset, offset + SAILOR_DIRECTORY_PAGE_SIZE),
  };
}

export function directoryHref(filters: ReturnType<typeof directoryFilters>, page = 1) {
  const params = new URLSearchParams();
  if (filters.query) params.set("q", filters.query);
  if (filters.fleet !== "all") params.set("fleet", filters.fleet);
  if (filters.club) params.set("club", filters.club);
  if (filters.nationality) params.set("nationality", filters.nationality);
  if (Number.isSafeInteger(page) && page > 1) params.set("page", String(page));
  return `/sailors${params.size ? `?${params}` : ""}`;
}
