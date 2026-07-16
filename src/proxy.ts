import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";

/**
 * Next.js 16 proxy (replaces middleware):
 * - admin subdomain rewrite
 * - refresh Supabase auth cookies so SSR sees the browser session
 */
export async function proxy(request: NextRequest) {
  const host = request.headers.get("host") || "";
  const url = request.nextUrl.clone();

  // If visiting the root of admin.sailorpath.com, rewrite to /admin dashboard
  if (host.includes("admin.sailorpath.com") && url.pathname === "/") {
    url.pathname = "/admin";
    return NextResponse.rewrite(url);
  }

  let response = NextResponse.next({
    request: {
      headers: request.headers,
    },
  });

  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  if (!supabaseUrl || !supabaseAnonKey || supabaseUrl.includes("placeholder")) {
    return response;
  }

  const supabase = createServerClient(supabaseUrl, supabaseAnonKey, {
    cookies: {
      getAll() {
        return request.cookies.getAll();
      },
      setAll(cookiesToSet) {
        cookiesToSet.forEach(({ name, value }) => {
          request.cookies.set(name, value);
        });
        response = NextResponse.next({
          request: {
            headers: request.headers,
          },
        });
        cookiesToSet.forEach(({ name, value, options }) => {
          response.cookies.set(name, value, options);
        });
      },
    },
  });

  // Refresh session so server components / API routes share cookie auth.
  await supabase.auth.getUser();

  return response;
}

export const config = {
  matcher: [
    /*
     * Match all request paths except static assets and images.
     * Include API so auth cookies refresh before /api/auth/ensure-profile etc.
     */
    "/((?!_next/static|_next/image|favicon.ico|avatar-demo.png|hero-grid.svg|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)",
  ],
};
