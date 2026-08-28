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
  let supabase: Awaited<ReturnType<typeof createServerSupabase>>;
  try {
    supabase = await createServerSupabase();
  } catch (error) {
    // Local/static environments without auth configuration should render as
    // signed out instead of taking the whole page through the error boundary.
    if (
      error instanceof Error &&
      /Missing NEXT_PUBLIC_SUPABASE_URL|Missing NEXT_PUBLIC_SUPABASE_ANON_KEY/.test(
        error.message
      )
    ) {
      return null;
    }
    throw error;
  }
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
  return requireRoles(["superadmin"]);
}

/** Require an authenticated coach workspace user. Superadmins retain access for support/testing. */
export async function requireCoach(): Promise<AuthContext> {
  return requireRoles(["coach", "superadmin"]);
}

async function requireRoles(roles: AppRole[]): Promise<AuthContext> {
  const ctx = await getAuthContext();
  if (!ctx) {
    const err = new Error("UNAUTHORIZED");
    (err as Error & { status: number }).status = 401;
    throw err;
  }
  if (!roles.includes(ctx.role)) {
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

  // In production, only expose safe pre-approved messages.
  // Schema drift, column names, and internal errors are already logged via
  // console.error() in every route handler and visible in Vercel logs.
  const isProduction = process.env.NODE_ENV === "production";

  let publicMsg: string;
  let detail: string | undefined;

  if (msg === "UNAUTHORIZED") {
    publicMsg = "Not signed in";
  } else if (msg === "FORBIDDEN") {
    publicMsg = "You do not have access to this area";
  } else if (isProduction) {
    publicMsg = "Internal error";
  } else {
    // Development: surface full messages for debugging
    publicMsg = msg.length < 280 ? msg : msg.slice(0, 240) + "\u2026";
    if (msg.length < 500) detail = msg;
  }

  const body: Record<string, string> = { error: publicMsg };
  if (detail) body.detail = detail;

  return Response.json(body, { status });
}
