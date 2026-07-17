import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { NextResponse } from "next/server";
import {
  getAuthCookieOptions,
  safeAuthNext,
} from "@/lib/supabase/cookie-options";

export async function GET(request: Request) {
  const { searchParams, origin } = new URL(request.url);
  const code = searchParams.get("code");
  const next = safeAuthNext(searchParams.get("next"), "/");

  const supabaseUrl =
    process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL || "";
  const supabaseAnonKey =
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ||
    process.env.SUPABASE_ANON_KEY ||
    "";

  if (!code || !supabaseUrl || !supabaseAnonKey) {
    return NextResponse.redirect(
      `${origin}/login?error=${encodeURIComponent("Could not authenticate")}`
    );
  }

  const cookieStore = await cookies();
  const cookieOptions = getAuthCookieOptions();
  const supabase = createServerClient(supabaseUrl, supabaseAnonKey, {
    ...(cookieOptions ? { cookieOptions } : {}),
    cookies: {
      getAll() {
        return cookieStore.getAll();
      },
      setAll(cookiesToSet) {
        try {
          cookiesToSet.forEach(({ name, value, options }) =>
            cookieStore.set(name, value, {
              ...options,
              ...(cookieOptions || {}),
            })
          );
        } catch {
          /* ignore */
        }
      },
    },
  });

  const { error } = await supabase.auth.exchangeCodeForSession(code);
  if (error) {
    return NextResponse.redirect(
      `${origin}/login?error=${encodeURIComponent(error.message)}`
    );
  }

  try {
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (user) {
      const { ensureProfileForUser } = await import("@/lib/queries");
      await ensureProfileForUser(user);
    }
  } catch {
    /* DB may be offline */
  }

  if (next.startsWith("http")) return NextResponse.redirect(next);
  return NextResponse.redirect(`${origin}${next}`);
}
