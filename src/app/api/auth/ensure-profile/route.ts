import { NextResponse } from "next/server";
import { createServerSupabaseClient } from "@/lib/supabase";
import { db } from "@/db";
import { profiles } from "@/db/schema";
import { eq } from "drizzle-orm";

/**
 * Ensures a profiles row exists for the signed-in user.
 * Call after login/register if the signup trigger was not installed yet.
 */
export async function POST() {
  try {
    const supabase = await createServerSupabaseClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: "Not signed in" }, { status: 401 });
    }

    const existing = await db
      .select({ id: profiles.id, role: profiles.role })
      .from(profiles)
      .where(eq(profiles.id, user.id))
      .limit(1);

    if (existing[0]) {
      return NextResponse.json({ profile: existing[0], created: false });
    }

    const fullName =
      (user.user_metadata?.full_name as string) ||
      (user.user_metadata?.handle as string) ||
      user.email?.split("@")[0] ||
      "Sailor";

    let role: "sailor" | "superadmin" = "sailor";
    if (
      process.env.SUPERADMIN_EMAIL &&
      user.email &&
      user.email.toLowerCase() === process.env.SUPERADMIN_EMAIL.toLowerCase()
    ) {
      role = "superadmin";
    }

    const [row] = await db
      .insert(profiles)
      .values({
        id: user.id,
        email: user.email || "",
        fullName,
        role,
      })
      .onConflictDoUpdate({
        target: profiles.id,
        set: { email: user.email || "", updatedAt: new Date() },
      })
      .returning({ id: profiles.id, role: profiles.role });

    return NextResponse.json({ profile: row, created: true });
  } catch (e) {
    console.error("ensure-profile", e);
    return NextResponse.json(
      {
        error:
          "Could not create profile. Is DATABASE_URL set and profiles table migrated?",
      },
      { status: 503 }
    );
  }
}
