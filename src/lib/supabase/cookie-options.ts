/**
 * Share auth cookies across sailorpath.com and admin.sailorpath.com.
 * Without domain=.sailorpath.com, a login on the main site is invisible on admin.
 */
export function getAuthCookieOptions():
  | { domain: string; path: string; sameSite: "lax"; secure: boolean }
  | undefined {
  const fromEnv = process.env.NEXT_PUBLIC_COOKIE_DOMAIN?.trim();
  if (fromEnv) {
    return {
      domain: fromEnv,
      path: "/",
      sameSite: "lax",
      secure: true,
    };
  }

  // Auto on production Vercel for sailorpath
  if (process.env.VERCEL_ENV === "production") {
    return {
      domain: ".sailorpath.com",
      path: "/",
      sameSite: "lax",
      secure: true,
    };
  }

  return undefined;
}

/** Only allow post-login redirects to our sites (open-redirect safe). */
export function safeAuthNext(raw: string | null | undefined, fallback = "/"): string {
  if (!raw) return fallback;
  const value = raw.trim();
  if (!value) return fallback;

  // Relative path on same host
  if (value.startsWith("/") && !value.startsWith("//")) {
    return value;
  }

  try {
    const u = new URL(value);
    const host = u.hostname.toLowerCase();
    const allowed =
      host === "sailorpath.com" ||
      host.endsWith(".sailorpath.com") ||
      host === "localhost" ||
      host === "127.0.0.1";
    if (allowed) return u.toString();
  } catch {
    /* ignore */
  }

  return fallback;
}
