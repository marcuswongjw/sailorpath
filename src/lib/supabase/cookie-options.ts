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

function isCanonicalAuthHost(host: string): boolean {
  return host === "sailorpath.com" || host.endsWith(".sailorpath.com");
}

/**
 * Post-login redirect target.
 * Relative paths stay on this host. Absolute URLs are limited to SailorPath
 * hosts, local dev, or the host that is already serving this request.
 * Other *.vercel.app hosts are rejected so a login cannot be bounced to an
 * unrelated deployment.
 */
export function safeAuthNext(
  raw: string | null | undefined,
  fallback = "/",
  currentHost?: string | null
): string {
  if (!raw?.trim()) return fallback;
  const value = raw.trim();
  if (
    value.startsWith("/") &&
    !value.startsWith("//") &&
    !value.includes("\\") &&
    !value.includes("\0")
  ) {
    return value;
  }
  try {
    const u = new URL(value);
    if (u.username || u.password) return fallback;
    const host = u.hostname.toLowerCase();
    const servingHost = normalizeHost(currentHost);
    const allowedHost =
      isCanonicalAuthHost(host) ||
      host === "localhost" ||
      host === "127.0.0.1" ||
      (servingHost.length > 0 && host === servingHost);
    if (!allowedHost) return fallback;
    const localHttp = host === "localhost" || host === "127.0.0.1";
    if (u.protocol === "http:" && !localHttp) return fallback;
    if (u.protocol !== "http:" && u.protocol !== "https:") return fallback;
    return u.toString();
  } catch {
    /* ignore */
  }
  return fallback;
}
