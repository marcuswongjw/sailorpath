/**
 * Parse JSON from admin API responses; surface non-JSON error bodies.
 * Returns a loose object so call sites can read `.error` / `.message` without casts.
 */
// eslint-disable-next-line @typescript-eslint/no-explicit-any
export async function parseApi(res: Response): Promise<any> {
  const text = await res.text();
  try {
    return text ? JSON.parse(text) : {};
  } catch {
    throw new Error(
      res.ok
        ? "Invalid server response"
        : `Request failed (${res.status}). ${text.slice(0, 120) || "No details"}`
    );
  }
}
