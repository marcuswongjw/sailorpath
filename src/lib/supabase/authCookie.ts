const AUTH_COOKIE_PREFIXES = [
  "sailorpath-public-auth",
  "sailorpath-admin-auth",
  "sb-",
];

/** True when the cookie header may hold a Supabase session. */
export function cookieHeaderHasAuthSession(cookieHeader: string): boolean {
  return cookieHeader.split(";").some((part) => {
    const name = part.trim().split("=")[0] ?? "";
    return AUTH_COOKIE_PREFIXES.some((prefix) => name.startsWith(prefix));
  });
}
