/**
 * Admin portal host / URL helpers (server + client safe).
 */

export function isAdminHost(host: string): boolean {
  return (
    host.includes("admin.sailorpath.com") ||
    host.includes("localhost") ||
    host.includes("127.0.0.1")
  );
}

/** Public marketing/app origin (login lives here). */
export function publicSiteOrigin(): string {
  const raw = process.env.NEXT_PUBLIC_SITE_URL?.trim();
  if (raw) return raw.replace(/\/$/, "");
  if (process.env.VERCEL_URL) return `https://${process.env.VERCEL_URL}`;
  return "https://sailorpath.com";
}

/** Where to send the browser after login (admin portal). */
export function adminReturnUrl(host: string, path = "/"): string {
  const cleanPath = path.startsWith("/") ? path : `/${path}`;
  if (host.includes("admin.sailorpath.com")) {
    return `https://admin.sailorpath.com${cleanPath === "/admin" ? "/" : cleanPath}`;
  }
  if (host.includes("localhost") || host.includes("127.0.0.1")) {
    const proto = "http";
    return `${proto}://${host}${cleanPath.startsWith("/admin") ? cleanPath : "/admin"}`;
  }
  return `${publicSiteOrigin()}/admin`;
}
