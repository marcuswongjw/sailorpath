/**
 * Parse JSON from admin API responses; surface non-JSON error bodies.
 */

export type AdminApiJson = Record<string, unknown>;

/** Prefer error → detail → message for user-facing failures. */
export function apiErr(data: AdminApiJson, fallback: string): string {
  for (const key of ["error", "detail", "message"] as const) {
    const v = data[key];
    if (typeof v === "string" && v.trim()) return v;
  }
  return fallback;
}

export function apiStr(data: AdminApiJson, key: string): string | undefined {
  const v = data[key];
  return typeof v === "string" ? v : undefined;
}

export function apiNum(data: AdminApiJson, key: string): number | undefined {
  const v = data[key];
  return typeof v === "number" && Number.isFinite(v) ? v : undefined;
}

export async function parseApi(res: Response): Promise<AdminApiJson> {
  const text = await res.text();
  try {
    if (!text) return {};
    const parsed: unknown = JSON.parse(text);
    if (parsed && typeof parsed === "object" && !Array.isArray(parsed)) {
      return parsed as AdminApiJson;
    }
    return { value: parsed };
  } catch {
    throw new Error(
      res.ok
        ? "Invalid server response"
        : `Request failed (${res.status}). ${text.slice(0, 120) || "No details"}`
    );
  }
}
