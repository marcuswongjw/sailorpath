export function getAuthCookieOptions():
  | { domain: string; path: string; sameSite: "lax"; secure: boolean }
  | undefined {
  const fromEnv = process.env.NEXT_PUBLIC_COOKIE_DOMAIN?.trim();
  if (fromEnv) {
    return { domain: fromEnv, path: "/", sameSite: "lax", secure: true };
  }
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
