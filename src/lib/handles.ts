/** Reserved path segments — cannot be used as sailor handles */
export const RESERVED_HANDLES = new Set([
  "admin",
  "api",
  "auth",
  "login",
  "register",
  "account",
  "sample",
  "search",
  "support",
  "help",
  "sg",
  "my",
  "my-profile",
  "myprofile",
  "profile",
  "favicon.ico",
  "robots.txt",
  "sitemap.xml",
  "_next",
  "null",
  "undefined",
]);

/** Normalize user input to a handle candidate */
export function normalizeHandle(raw: string): string {
  return String(raw || "")
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9-]/g, "-")
    .replace(/-+/g, "-")
    .replace(/^-|-$/g, "");
}

/**
 * Validate handle for public URLs.
 * 3–30 chars, lowercase alphanumeric + hyphen, not reserved.
 */
export function validateHandle(raw: string): { ok: true; handle: string } | { ok: false; error: string } {
  const handle = normalizeHandle(raw);
  if (handle.length < 3) {
    return { ok: false, error: "Handle must be at least 3 characters" };
  }
  if (handle.length > 30) {
    return { ok: false, error: "Handle must be 30 characters or fewer" };
  }
  if (!/^[a-z0-9]([a-z0-9-]*[a-z0-9])?$/.test(handle)) {
    return {
      ok: false,
      error: "Use lowercase letters, numbers, and hyphens only",
    };
  }
  if (RESERVED_HANDLES.has(handle)) {
    return { ok: false, error: "That URL is reserved — pick another" };
  }
  return { ok: true, handle };
}
