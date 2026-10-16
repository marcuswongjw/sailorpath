import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";

export interface AdminFetchOptions extends Omit<RequestInit, "signal"> {
  signal?: AbortSignal;
  timeoutMs?: number;
}

export async function adminJson<T>(
  url: string,
  options: AdminFetchOptions = {}
): Promise<T> {
  const { timeoutMs = 15_000, signal, ...rest } = options;
  const controller = new AbortController();

  if (signal) {
    if (signal.aborted) {
      throw signal.reason || new Error("Request aborted");
    }
    signal.addEventListener("abort", () => controller.abort(signal.reason), {
      once: true,
    });
  }

  const timeoutId = setTimeout(() => {
    controller.abort(
      new Error(`Admin request to ${url} timed out after ${timeoutMs}ms`)
    );
  }, timeoutMs);

  try {
    const response = await fetch(url, {
      credentials: "include",
      signal: controller.signal,
      ...rest,
    });
    const body = (await response.json()) as T & {
      error?: string;
      detail?: string;
    };
    if (!response.ok) {
      const detail = body.detail;
      const msg =
        detail && detail !== body.error
          ? `${body.error}: ${detail}`
          : body.error || `Request failed (${response.status})`;
      throw new Error(msg);
    }
    return body;
  } finally {
    clearTimeout(timeoutId);
  }
}

export async function fetchAdminSailors(
  options?: AdminFetchOptions
): Promise<SailorAdmin[]> {
  const body = await adminJson<{ sailors?: SailorAdmin[] }>(
    "/api/admin/sailors?all=1",
    options
  );
  return Array.isArray(body.sailors) ? body.sailors : [];
}

export async function fetchAdminRegattaEvents(
  options?: AdminFetchOptions
): Promise<
  Array<{ id: string; slug: string; name: string; startDate: string }>
> {
  const body = await adminJson<{
    events?: Array<{ id: string; slug: string; name: string; startDate: string }>;
  }>("/api/admin/regatta-events", options);
  return Array.isArray(body.events) ? body.events : [];
}

export async function fetchAdminRegattas(
  options?: AdminFetchOptions
): Promise<RegattaAdmin[]> {
  const body = await adminJson<{ regattas?: RegattaAdmin[] }>(
    "/api/admin/regattas?all=1",
    options
  );
  const rows = Array.isArray(body.regattas) ? body.regattas : [];
  return [...rows].sort((a, b) =>
    String(b.date || "").localeCompare(String(a.date || ""))
  );
}

export async function fetchAdminResultsAll(
  options?: AdminFetchOptions
): Promise<ResultAdmin[]> {
  const body = await adminJson<{ results?: ResultAdmin[] }>(
    "/api/admin/results?all=1",
    options
  );
  return Array.isArray(body.results) ? body.results : [];
}

export async function fetchAdminResultsForRegatta(
  regattaId: string,
  includeRaces = false,
  options?: AdminFetchOptions
): Promise<ResultAdmin[]> {
  const body = await adminJson<{ results?: ResultAdmin[] }>(
    `/api/admin/results?regattaId=${encodeURIComponent(regattaId)}${includeRaces ? "&includeRaces=1" : ""}`,
    options
  );
  return Array.isArray(body.results) ? body.results : [];
}

export type AdminOverviewPayload = {
  sheets: import("@/lib/admin/adminOverview").OverviewSheet[];
  ready: import("@/lib/admin/adminOverview").OverviewSheet[];
  missingResults: import("@/lib/admin/adminOverview").OverviewSheet[];
  blocked: import("@/lib/admin/adminOverview").OverviewSheet[];
  incomplete: import("@/lib/admin/adminOverview").OverviewSheet[];
  duplicateCount: number;
  counts: {
    ready: number;
    missingResults: number;
    blocked: number;
    incomplete: number;
    duplicateSailors: number;
  };
};

export async function fetchAdminOverview(
  options?: AdminFetchOptions
): Promise<AdminOverviewPayload> {
  return adminJson<AdminOverviewPayload>("/api/admin/overview", options);
}
