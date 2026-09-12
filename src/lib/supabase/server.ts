import { createServerClient } from "@supabase/ssr";
import { cookies, headers } from "next/headers";
import { getAuthCookieOptions } from "@/lib/supabase/cookie-options";

export async function createServerSupabase() {
  const url =
    process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL || "";
  const key =
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ||
    process.env.SUPABASE_ANON_KEY ||
    "";
  if (!url || !key) {
    throw new Error("Missing NEXT_PUBLIC_SUPABASE_URL or NEXT_PUBLIC_SUPABASE_ANON_KEY");
  }
  const cookieStore = await cookies();
  const requestHeaders = await headers();
  const cookieOptions = getAuthCookieOptions(requestHeaders.get("host"));
  const cookieWriteOptions = cookieOptions
    ? {
        path: cookieOptions.path,
        sameSite: cookieOptions.sameSite,
        secure: cookieOptions.secure,
      }
    : {};

  return createServerClient(url, key, {
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
              ...cookieWriteOptions,
            })
          );
        } catch {
          /* Server Component */
        }
      },
    },
  });
}
