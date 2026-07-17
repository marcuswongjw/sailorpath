import { createServerSupabase } from "@/lib/supabase/server";
import { db } from "@/db";
import { profiles } from "@/db/schema";
import { eq } from "drizzle-orm";

export type AppRole = "parent" | "sailor" | "coach" | "superadmin";

export type AuthContext = {
  userId: string;
  email: string | null;
  role: AppRole;
};

export async function getAuthContext(): Promise<AuthContext | null> {
  const supabase = await createServerSupabase();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return null;

  let role: AppRole = "sailor";
  try {
    const rows = await db
      .select({ role: profiles.role })
      .from(profiles)
      .where(eq(profiles.id, user.id))
      .limit(1);
    if (rows[0]?.role) role = rows[0].role as AppRole;
  } catch {
    /* DB offline — still allow bootstrap */
  }

  const bootstrap =
    process.env.SUPERADMIN_EMAIL &&
    user.email &&
    user.email.toLowerCase() === process.env.SUPERADMIN_EMAIL.toLowerCase();
  if (bootstrap) role = "superadmin";

  return { userId: user.id, email: user.email ?? null, role };
}

export async function requireSuperadmin(): Promise<AuthContext> {
  const ctx = await getAuthContext();
  if (!ctx) {
    const err = new Error("UNAUTHORIZED");
    (err as Error & { status: number }).status = 401;
    throw err;
  }
  if (ctx.role !== "superadmin") {
    const err = new Error("FORBIDDEN");
    (err as Error & { status: number }).status = 403;
    throw err;
  }
  return ctx;
}

export function jsonError(error: unknown) {
  const msg = error instanceof Error ? error.message : "Error";
  const status =
    msg === "UNAUTHORIZED" ? 401 : msg === "FORBIDDEN" ? 403 : 500;
  // Surface useful message for admin UI (still safe — no secrets)
  const publicMsg =
    msg === "UNAUTHORIZED"
      ? "Not signed in"
      : msg === "FORBIDDEN"
        ? "Superadmin role required"
        : msg.length < 200
          ? msg
          : "Server error";
  return Response.json(
    {
      error: publicMsg,
      detail: process.env.NODE_ENV !== "production" ? msg : undefined,
    },
    { status }
  );
}
