"use client";

import { createBrowserClient } from "@supabase/ssr";
import { getAuthCookieOptions } from "@/lib/supabase/cookie-options";

/**
 * Browser Supabase client (cookie-backed via @supabase/ssr).
 * Throws a clear error if public env vars are missing at runtime.
 */
export function createBrowserSupabase() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  if (!url || !key || url.includes("placeholder")) {
    throw new Error(
      "Supabase is not configured. Set NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY in Vercel (Production) and redeploy."
    );
  }

  const cookieOptions = getAuthCookieOptions();

  return createBrowserClient(url, key, cookieOptions ? { cookieOptions } : undefined);
}
