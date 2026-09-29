import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";

async function adminJson<T>(url: string): Promise<T> {
  const response = await fetch(url, { credentials: "include" });
  const body = (await response.json()) as T & { error?: string; detail?: string };
  if (!response.ok) {
    const detail = body.detail;
    const msg =
      detail && detail !== body.error
        ? `${body.error}: ${detail}`
        : body.error || `Request failed (${response.status})`;
    throw new Error(msg);
  }
  return body;
}

export async function fetchAdminSailors(): Promise<SailorAdmin[]> {
  const body = await adminJson<{ sailors?: SailorAdmin[] }>(
    "/api/admin/sailors?all=1"
  );
  return Array.isArray(body.sailors) ? body.sailors : [];
}

export async function fetchAdminRegattas(): Promise<RegattaAdmin[]> {
  const body = await adminJson<{ regattas?: RegattaAdmin[] }>(
    "/api/admin/regattas?all=1"
  );
  const rows = Array.isArray(body.regattas) ? body.regattas : [];
  return [...rows].sort((a, b) =>
    String(b.date || "").localeCompare(String(a.date || ""))
  );
}

export async function fetchAdminResultsAll(): Promise<ResultAdmin[]> {
  const body = await adminJson<{ results?: ResultAdmin[] }>(
    "/api/admin/results?all=1"
  );
  return Array.isArray(body.results) ? body.results : [];
}

export async function fetchAdminResultsForRegatta(
  regattaId: string,
  includeRaces = false
): Promise<ResultAdmin[]> {
  const body = await adminJson<{ results?: ResultAdmin[] }>(
    `/api/admin/results?regattaId=${encodeURIComponent(regattaId)}${includeRaces ? "&includeRaces=1" : ""}`
  );
  return Array.isArray(body.results) ? body.results : [];
}
