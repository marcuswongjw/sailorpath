import { NextResponse } from "next/server";

/**
 * Public health check — does not leak secrets.
 * Use to verify Vercel DATABASE_URL after deploy:
 *   https://sailorpath.com/api/health
 */
export async function GET() {
  const hasDatabaseUrl = Boolean(process.env.DATABASE_URL?.trim());
  const hasSupabaseUrl = Boolean(process.env.NEXT_PUBLIC_SUPABASE_URL?.trim());
  const hasAnonKey = Boolean(process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.trim());
  const supabaseHost = process.env.NEXT_PUBLIC_SUPABASE_URL?.replace(
    /^https?:\/\//,
    ""
  )
    ?.split("/")[0]
    ?.slice(0, 80);

  let dbOk = false;
  let dbError: string | null = null;
  let sailorCount: number | null = null;

  if (hasDatabaseUrl) {
    try {
      const { db } = await import("@/db");
      const { sailors } = await import("@/db/schema");
      const rows = await db.select({ id: sailors.id }).from(sailors).limit(1);
      // Count via a second query only if first succeeded
      const all = await db.select({ id: sailors.id }).from(sailors);
      sailorCount = all.length;
      dbOk = true;
      void rows;
    } catch (e) {
      dbOk = false;
      dbError =
        e instanceof Error
          ? e.message.slice(0, 200)
          : "Database query failed";
    }
  } else {
    dbError = "DATABASE_URL is not set on this deployment";
  }

  const live = dbOk && hasSupabaseUrl && hasAnonKey;

  return NextResponse.json({
    ok: live,
    mode: live ? "live" : "demo",
    env: {
      DATABASE_URL: hasDatabaseUrl,
      NEXT_PUBLIC_SUPABASE_URL: hasSupabaseUrl,
      NEXT_PUBLIC_SUPABASE_ANON_KEY: hasAnonKey,
      SUPERADMIN_EMAIL: Boolean(process.env.SUPERADMIN_EMAIL?.trim()),
      supabaseHost: supabaseHost || null,
    },
    database: {
      connected: dbOk,
      sailorCount,
      error: dbError,
    },
    hint: live
      ? "PostgreSQL is reachable — Demo Mode should be off."
      : "Set DATABASE_URL (Supabase Transaction pooler :6543) on Vercel Production and Redeploy. Auth can work while DB is offline; rankings/admin stay simulated until DB connects.",
  });
}
