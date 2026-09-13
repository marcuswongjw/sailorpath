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

/** The public demo is not part of the authenticated admin workspace and is hidden for logged-in accounts. */
export function shouldShowDemoNavigation(
  host: string,
  ownedSailorCount: number,
  isLoggedIn = false
): boolean {
  return !isAdminHost(host) && !isLoggedIn && ownedSailorCount === 0;
}

/** Public marketing/app origin (login lives here). */
export function publicSiteOrigin(): string {
  const raw = process.env.NEXT_PUBLIC_SITE_URL?.trim();
  if (raw) return raw.replace(/\/$/, "");
  if (process.env.VERCEL_URL) return `https://${process.env.VERCEL_URL}`;
  return "https://sailorpath.com";
}

/**
 * The browser must authenticate on the same host that will receive the
 * host-only admin session cookie. Never route an admin guest through the
 * public app origin or a Vercel deployment alias.
 */
export function adminLoginOrigin(host: string): string {
  if (host.includes("admin.sailorpath.com")) {
    return "https://admin.sailorpath.com";
  }
  if (host.includes("localhost") || host.includes("127.0.0.1")) {
    return `http://${host}`;
  }
  return publicSiteOrigin();
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
