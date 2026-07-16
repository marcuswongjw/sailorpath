import { createClient as createSupabaseClient } from "@supabase/supabase-js";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { getAuthCookieOptions } from "@/lib/supabase/cookie-options";

function getPublicConfig() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!url || !anonKey) {
    throw new Error(
      "Missing NEXT_PUBLIC_SUPABASE_URL or NEXT_PUBLIC_SUPABASE_ANON_KEY"
    );
  }
  return { url, anonKey };
}

/** Server Components / Route Handlers — cookie session */
export const createServerSupabaseClient = async () => {
  const { url, anonKey } = getPublicConfig();
  const cookieStore = await cookies();
  const cookieOptions = getAuthCookieOptions();

  return createServerClient(url, anonKey, {
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
          /* called from a Server Component */
        }
      },
    },
  });
};

/** Service-role client for trusted server-only jobs (never import in client) */
export function createServiceSupabase() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !key) {
    throw new Error("Missing SUPABASE_SERVICE_ROLE_KEY or URL");
  }
  return createSupabaseClient(url, key, {
    auth: { autoRefreshToken: false, persistSession: false },
  });
}
