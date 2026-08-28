import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";
import { getAuthCookieOptions } from "@/lib/supabase/cookie-options";

const PUBLIC_SINGLE_SEGMENT_PATHS = new Set([
  "account",
  "admin",
  "claim-profile",
  "coach-tools",
  "demo-profile",
  "how-rankings-work",
  "login",
  "parent",
  "rankings",
  "register",
  "sample",
  "search",
  "support",
  "whats-new",
]);

/** Routes whose server-rendered content depends on a refreshed auth cookie. */
export function shouldRefreshSession(
  pathname: string,
  isAdminRoot: boolean
): boolean {
  if (isAdminRoot) return true;
  if (
    pathname === "/admin" ||
    pathname.startsWith("/admin/") ||
    pathname === "/account" ||
    pathname.startsWith("/account/") ||
    pathname === "/parent" ||
    pathname.startsWith("/parent/") ||
    pathname === "/coach-tools" ||
    pathname === "/sg/optimist/goldsailors" ||
    pathname.startsWith("/sg/optimist/goldsailors/")
  ) {
    return true;
  }

  // One-segment paths not owned by the app router are sailor profile handles.
  const segments = pathname.split("/").filter(Boolean);
  return (
    segments.length === 1 &&
    !segments[0].includes(".") &&
    !PUBLIC_SINGLE_SEGMENT_PATHS.has(segments[0])
  );
}

export async function proxy(request: NextRequest) {
  const host = request.headers.get("host") || "";
  const pathname = request.nextUrl.pathname;
  const isAdminRoot =
    host.includes("admin.sailorpath.com") && pathname === "/";

  let response = isAdminRoot
    ? NextResponse.rewrite(new URL("/admin", request.url))
    : NextResponse.next({ request: { headers: request.headers } });

  if (!shouldRefreshSession(pathname, isAdminRoot)) {
    return response;
  }

  const supabaseUrl =
    process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL || "";
  const supabaseAnonKey =
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ||
    process.env.SUPABASE_ANON_KEY ||
    "";
  if (!supabaseUrl || !supabaseAnonKey || supabaseUrl.includes("placeholder")) {
    return response;
  }

  const cookieOptions = getAuthCookieOptions();
  const supabase = createServerClient(supabaseUrl, supabaseAnonKey, {
    ...(cookieOptions ? { cookieOptions } : {}),
    cookies: {
      getAll() {
        return request.cookies.getAll();
      },
      setAll(cookiesToSet) {
        cookiesToSet.forEach(({ name, value }) => {
          request.cookies.set(name, value);
        });
        const cookieStr = request.cookies
          .getAll()
          .map(({ name, value }) => `${name}=${value}`)
          .join("; ");
        request.headers.set("cookie", cookieStr);

        response = isAdminRoot
          ? NextResponse.rewrite(new URL("/admin", request.url), {
              request: {
                headers: request.headers,
              },
            })
          : NextResponse.next({
              request: {
                headers: request.headers,
              },
            });
        cookiesToSet.forEach(({ name, value, options }) => {
          response.cookies.set(name, value, {
            ...options,
            ...(cookieOptions || {}),
          });
        });
      },
    },
  });

  await supabase.auth.getUser();
  return response;
}

export const config = {
  matcher: [
    "/",
    "/admin/:path*",
    "/account/:path*",
    "/parent/:path*",
    "/coach-tools",
    "/sg/optimist/goldsailors/:path*",
    "/:sailor_handle",
  ],
};
