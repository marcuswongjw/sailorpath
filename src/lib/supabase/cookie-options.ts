type AuthCookieOptions = {
  name: string;
  path: string;
  sameSite: "lax";
  secure: boolean;
};

function normalizeHost(host: string | null | undefined): string {
  return String(host || "")
    .trim()
    .toLowerCase()
    .replace(/:\d+$/, "");
}

/**
 * Production sessions use distinct host-only cookie names for the public and
 * admin applications. Do not set a Domain attribute: browser Supabase cookies
 * are script-readable, and a parent-domain credential would be exposed to every
 * sibling subdomain.
 */
export function getAuthCookieOptions(
  host?: string | null
): AuthCookieOptions | undefined {
  if (process.env.VERCEL_ENV !== "production") return undefined;

  return {
    name:
      normalizeHost(host) === "admin.sailorpath.com"
        ? "sailorpath-admin-auth"
        : "sailorpath-public-auth",
    path: "/",
    sameSite: "lax",
    secure: true,
  };
}

export function safeAuthNext(
  raw: string | null | undefined,
  fallback = "/"
): string {
  if (!raw?.trim()) return fallback;
  const value = raw.trim();
  if (value.startsWith("/") && !value.startsWith("//")) return value;
  try {
    const u = new URL(value);
    const host = u.hostname.toLowerCase();
    if (
      host === "sailorpath.com" ||
      host.endsWith(".sailorpath.com") ||
      host === "localhost" ||
      host === "127.0.0.1"
    ) {
      return u.toString();
    }
  } catch {
    /* ignore */
  }
  return fallback;
}
