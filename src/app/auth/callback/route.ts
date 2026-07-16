import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { NextResponse } from "next/server";

export async function GET(request: Request) {
  const { searchParams, origin } = new URL(request.url);
  const code = searchParams.get("code");
  const next = searchParams.get("next") ?? "/";

  if (code) {
    const cookieStore = await cookies();
    const supabase = createServerClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
      {
        cookies: {
          getAll() {
            return cookieStore.getAll();
          },
          setAll(cookiesToSet) {
            try {
              cookiesToSet.forEach(({ name, value, options }) =>
                cookieStore.set(name, value, options)
              );
            } catch {
              // The `setAll` method was called from a Server Component.
            }
          },
        },
      }
    );
    const { error } = await supabase.auth.exchangeCodeForSession(code);
    if (!error) {
      // Best-effort profile row after OAuth / magic link
      try {
        const { db } = await import("@/db");
        const { profiles } = await import("@/db/schema");
        const { eq } = await import("drizzle-orm");
        const {
          data: { user },
        } = await supabase.auth.getUser();
        if (user) {
          const existing = await db
            .select({ id: profiles.id })
            .from(profiles)
            .where(eq(profiles.id, user.id))
            .limit(1);
          if (!existing[0]) {
            let role: "sailor" | "superadmin" = "sailor";
            if (
              process.env.SUPERADMIN_EMAIL &&
              user.email?.toLowerCase() === process.env.SUPERADMIN_EMAIL.toLowerCase()
            ) {
              role = "superadmin";
            }
            await db.insert(profiles).values({
              id: user.id,
              email: user.email || "",
              fullName:
                (user.user_metadata?.full_name as string) ||
                (user.user_metadata?.handle as string) ||
                user.email?.split("@")[0] ||
                "Sailor",
              role,
            });
          }
        }
      } catch (e) {
        console.warn("Profile bootstrap after OAuth failed (check DATABASE_URL):", e);
      }
      return NextResponse.redirect(`${origin}${next}`);
    }
  }

  return NextResponse.redirect(`${origin}/login?error=Could not authenticate user`);
}
