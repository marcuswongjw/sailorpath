import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";
import { getAuthCookieOptions } from "@/lib/supabase/cookie-options";

const PUBLIC_SINGLE_SEGMENT_PATHS = new Set([
  "about",
  "account",
  "admin",
  "blog",
  "calendar",
  "classes",
  "claim-profile",
  "following",
  "coach-tools",
  "demo-profile",
  "forgot-password",
  "how-rankings-work",
  "login",
  "news",
  "parent",
  "privacy",
  "rankings",
  "regattas",
  "register",
  "reset-password",
  "results",
  "sailors",
  "sample",
  "search",
  "support",
  "terms",
  "whats-new",
  "wingfoil",
]);

/**
 * Bound for a best-effort Supabase Auth refresh. Undici's connect timeout is
 * 10s; leaving getUser unbounded let a stalled TLS handshake hold the whole
 * response until the platform closed it.
 */
export const SESSION_REFRESH_TIMEOUT_MS = 2_500;

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
    pathname === "/following" ||
    pathname.startsWith("/following/") ||
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

/** True when the browser is carrying an app or Supabase auth cookie. */
export function requestHasAuthSession(cookieNames: readonly string[]): boolean {
  return cookieNames.some(
    (name) =>
      name.startsWith("sailorpath-public-auth") ||
      name.startsWith("sailorpath-admin-auth") ||
      name.startsWith("sb-") ||
      name.includes("supabase-auth-token")
  );
}

function withDeadline<T>(operation: Promise<T>, timeoutMs: number): Promise<T> {
  return new Promise((resolve, reject) => {
    const timer = setTimeout(
      () => reject(new Error("SESSION_REFRESH_TIMEOUT")),
      timeoutMs
    );
    operation.then(resolve, reject).finally(() => clearTimeout(timer));
  });
}

/** Refresh the session, or give up. A failed refresh must not fail the page. */
export async function refreshAuthSession(
  getUser: () => Promise<unknown>,
  timeoutMs = SESSION_REFRESH_TIMEOUT_MS
): Promise<"refreshed" | "skipped"> {
  try {
    await withDeadline(Promise.resolve().then(getUser), timeoutMs);
    return "refreshed";
  } catch (error) {
    const message = error instanceof Error ? error.message : "session refresh failed";
    console.warn("[proxy] Session refresh skipped", {
      error: message.slice(0, 180),
    });
    return "skipped";
  }
}

/** Invalid local placeholder values must not break otherwise public routes. */
export function hasUsableSupabaseUrl(value: string): boolean {
  if (!value || value.includes("placeholder")) return false;
  try {
    const url = new URL(value);
    return url.protocol === "https:" || url.protocol === "http:";
  } catch {
    return false;
  }
}

export async function proxy(request: NextRequest) {
  const host = request.headers.get("host") || "";
  const pathname = request.nextUrl.pathname;
  if (pathname === "/_next/image") {
    const source = request.nextUrl.searchParams.get("url") || "";
    if (/athlete-portraits|\/api\/sailors\/[^/]+\/photo|\/avatars\//i.test(source)) {
      return new NextResponse(null, { status: 404, headers: { "Cache-Control": "private, no-store" } });
    }
  }
  if (pathname.startsWith("/athlete-portraits/")) {
    return new NextResponse(null, { status: 404, headers: { "Cache-Control": "private, no-store" } });
  }
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
  if (!hasUsableSupabaseUrl(supabaseUrl) || !supabaseAnonKey) {
    return response;
  }
  if (!requestHasAuthSession(request.cookies.getAll().map((cookie) => cookie.name))) {
    return response;
  }

  const cookieOptions = getAuthCookieOptions(host);
  const cookieWriteOptions = cookieOptions
    ? {
        path: cookieOptions.path,
        sameSite: cookieOptions.sameSite,
        secure: cookieOptions.secure,
      }
    : {};
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
            ...cookieWriteOptions,
          });
        });
      },
    },
  });

  await refreshAuthSession(() => supabase.auth.getUser());
  return response;
}

export const config = {
  matcher: [
    "/",
    "/_next/image",
    "/athlete-portraits/:path*",
    "/admin/:path*",
    "/account/:path*",
    "/parent/:path*",
    "/following",
    "/following/:path*",
    "/coach-tools",
    "/sg/optimist/goldsailors/:path*",
    "/:sailor_handle",
  ],
};
