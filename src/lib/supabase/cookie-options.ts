type AuthCookieOptions = {
  name: string;
  path: string;
  sameSite: "lax";
  secure: boolean;
  httpOnly?: boolean;
  domain?: string;
};

function normalizeHost(host: string | null | undefined): string {
  return String(host || "")
    .trim()
    .toLowerCase()
    .replace(/:\d+$/, "");
}

/**
 * Production sessions use distinct host-only cookie names for the public and
 * admin applications. Do not set a parent Domain attribute: omitting the Domain
 * attribute creates an RFC 6265 Host-Only cookie strictly tied to admin.sailorpath.com,
 * preventing credentials from ever leaking to sailorpath.com or sibling origins.
 */
export function getAuthCookieOptions(
  host?: string | null
): AuthCookieOptions | undefined {
  const normalizedHost = normalizeHost(host);
  const isCanonicalProductionHost =
    normalizedHost === "sailorpath.com" ||
    normalizedHost === "www.sailorpath.com" ||
    normalizedHost === "admin.sailorpath.com";

  if (
    process.env.VERCEL_ENV !== "production" &&
    !isCanonicalProductionHost
  ) {
    return undefined;
  }

  return {
    name:
      normalizedHost === "admin.sailorpath.com"
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
      host === "127.0.0.1" ||
      host.endsWith(".vercel.app") ||
      host === "vercel.app"
    ) {
      return u.toString();
    }
  } catch {
    /* ignore */
  }
  return fallback;
}
