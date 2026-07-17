import { NextResponse } from "next/server";

/**
 * Public health check — does not leak secrets.
 *   https://sailorpath.com/api/health
 *
 * Diagnoses why Demo Mode stays on even when DATABASE_URL is set.
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
  let step: string = "init";
  let tables: string[] = [];
  let urlMeta: {
    host: string | null;
    port: string | null;
    user: string | null;
    isPooler: boolean;
    isTransactionPort: boolean;
  } | null = null;
  let hintExtra = "";

  if (hasDatabaseUrl) {
    try {
      const { pgSql, getDatabaseUrlMeta, formatDbError } = await import("@/db");
      urlMeta = getDatabaseUrlMeta();

      step = "select_1";
      await pgSql`select 1 as ok`;

      step = "list_tables";
      const tableRows = await pgSql`
        select tablename
        from pg_tables
        where schemaname = 'public'
        order by tablename
      `;
      tables = tableRows.map((r) => String(r.tablename));

      if (!tables.includes("sailors")) {
        step = "missing_sailors_table";
        dbOk = false;
        dbError =
          "Connected to Postgres, but table public.sailors does not exist. Run the schema SQL in Supabase → SQL Editor (see docs/CONNECT_SUPABASE.md or src/db/migrations/0007_bootstrap_schema.sql).";
        hintExtra =
          "Connection works — you only need to create tables. Paste 0007_bootstrap_schema.sql into Supabase SQL Editor and run it.";
      } else {
        step = "count_sailors";
        const { db } = await import("@/db");
        const { sailors } = await import("@/db/schema");
        const all = await db.select({ id: sailors.id }).from(sailors);
        sailorCount = all.length;
        dbOk = true;
        step = "ok";
      }
    } catch (e) {
      dbOk = false;
      const { formatDbError } = await import("@/db").catch(() => ({
        formatDbError: (err: unknown) =>
          err instanceof Error ? err.message : String(err),
      }));
      dbError = `[${step}] ${formatDbError(e)}`;

      const msg = (dbError || "").toLowerCase();
      if (msg.includes("password") || msg.includes("authentication")) {
        hintExtra =
          "Wrong database password. Supabase → Project Settings → Database → reset password, update DATABASE_URL on Vercel, Redeploy. URL-encode special characters in the password (@ → %40, # → %23, etc.).";
      } else if (msg.includes("enotfound") || msg.includes("getaddrinfo")) {
        hintExtra =
          "Host not found. Use the pooler host from Supabase Connection string (…pooler.supabase.com), not a typo.";
      } else if (msg.includes("econnrefused") || msg.includes("timeout")) {
        hintExtra =
          "Cannot reach host. Prefer Transaction pooler port 6543 (IPv4). Avoid direct db.XXXX.supabase.co on free tier (often IPv6-only).";
      } else if (
        msg.includes("does not exist") ||
        msg.includes("relation") ||
        step === "missing_sailors_table"
      ) {
        hintExtra =
          "Database reachable but schema missing. Run 0007_bootstrap_schema.sql in Supabase SQL Editor.";
      } else if (msg.includes("prepared statement") || msg.includes("pgbouncer")) {
        hintExtra =
          "Pooler/prepared-statement issue — redeploy this version (uses prepare:false). Prefer port 6543 Transaction mode.";
      } else {
        hintExtra =
          "Check DATABASE_URL format: postgresql://postgres.PROJECT_REF:PASSWORD@aws-0-REGION.pooler.supabase.com:6543/postgres";
      }
    }
  } else {
    dbError = "DATABASE_URL is not set on this deployment";
    hintExtra =
      "Add DATABASE_URL under Vercel → Settings → Environment Variables → Production, then Redeploy.";
  }

  const live = dbOk && hasSupabaseUrl && hasAnonKey;

  return NextResponse.json({
    ok: live,
    mode: live ? "live" : "demo",
    // If this is missing, Production is an old Vercel deploy (not latest GitHub main)
    build: {
      commit:
        process.env.VERCEL_GIT_COMMIT_SHA?.slice(0, 7) ||
        process.env.NEXT_PUBLIC_VERCEL_GIT_COMMIT_SHA?.slice(0, 7) ||
        null,
      message: process.env.VERCEL_GIT_COMMIT_MESSAGE?.slice(0, 80) || null,
      env: process.env.VERCEL_ENV || null,
    },
    env: {
      DATABASE_URL: hasDatabaseUrl,
      NEXT_PUBLIC_SUPABASE_URL: hasSupabaseUrl,
      NEXT_PUBLIC_SUPABASE_ANON_KEY: hasAnonKey,
      SUPERADMIN_EMAIL: Boolean(process.env.SUPERADMIN_EMAIL?.trim()),
      supabaseHost: supabaseHost || null,
    },
    database: {
      connected: dbOk,
      step,
      sailorCount,
      publicTables: tables,
      url: urlMeta
        ? {
            host: urlMeta.host,
            port: urlMeta.port,
            userPrefix: urlMeta.user
              ? `${urlMeta.user.slice(0, 16)}${urlMeta.user.length > 16 ? "…" : ""}`
              : null,
            isPooler: urlMeta.isPooler,
            isTransactionPort: urlMeta.isTransactionPort,
          }
        : null,
      error: dbError,
    },
    hint: live
      ? "PostgreSQL is reachable — Demo Mode should be off."
      : hintExtra ||
        "Set DATABASE_URL (Supabase Transaction pooler :6543) on Vercel Production and Redeploy.",
  });
}
