import { NextResponse } from "next/server";

export async function GET() {
  const hasDatabaseUrl = Boolean(
    process.env.DATABASE_URL?.trim() ||
      process.env.POSTGRES_URL?.trim() ||
      process.env.POSTGRES_PRISMA_URL?.trim()
  );
  const hasSupabaseUrl = Boolean(
    process.env.NEXT_PUBLIC_SUPABASE_URL?.trim() ||
      process.env.SUPABASE_URL?.trim()
  );
  const hasAnonKey = Boolean(
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.trim() ||
      process.env.SUPABASE_ANON_KEY?.trim()
  );
  const supabaseHost = (
    process.env.NEXT_PUBLIC_SUPABASE_URL ||
    process.env.SUPABASE_URL ||
    ""
  )
    .replace(/^https?:\/\//, "")
    .split("/")[0]
    ?.slice(0, 80);

  let dbOk = false;
  let dbError: string | null = null;
  let step = "init";
  let tables: string[] = [];
  let sailorCount: number | null = null;
  let urlMeta: ReturnType<
    typeof import("@/db").getDatabaseUrlMeta
  > extends infer T
    ? T
    : never = null;
  let hint = "";

  if (!hasDatabaseUrl) {
    dbError = "DATABASE_URL is not set";
    hint =
      "Add DATABASE_URL (Supabase Transaction pooler :6543) on Vercel Production and Redeploy.";
  } else {
    try {
      const { pgSql, getDatabaseUrlMeta, formatDbError } = await import("@/db");
      urlMeta = getDatabaseUrlMeta();

      step = "select_1";
      await pgSql`select 1 as ok`;

      step = "list_tables";
      const tableRows = await pgSql`
        select tablename from pg_tables
        where schemaname = 'public' order by tablename
      `;
      tables = tableRows.map((r) => String(r.tablename));

      if (!tables.includes("sailors")) {
        step = "missing_schema";
        dbError =
          "Connected, but public.sailors is missing. Run docs wipe + 001_init.sql in Supabase SQL Editor.";
        hint =
          "Run src/db/migrations/000_wipe.sql then 001_init.sql in Supabase SQL Editor.";
      } else {
        step = "count_sailors";
        const countRows = await pgSql`select count(*)::int as n from sailors`;
        sailorCount = Number(countRows[0]?.n ?? 0);
        dbOk = true;
        step = "ok";
      }
    } catch (e) {
      const { formatDbError } = await import("@/db").catch(() => ({
        formatDbError: (err: unknown) =>
          err instanceof Error ? err.message : String(err),
      }));
      dbError = `[${step}] ${formatDbError(e)}`;
      const msg = dbError.toLowerCase();
      if (msg.includes("password") || msg.includes("authentication")) {
        hint =
          "Wrong DB password. Reset in Supabase → Database, update DATABASE_URL (URL-encode special chars), Redeploy.";
      } else if (msg.includes("timeout") || msg.includes("econnrefused")) {
        hint =
          "Cannot reach host. Use Transaction pooler …pooler.supabase.com:6543 (not db.*.supabase.co).";
      } else if (msg.includes("enotfound")) {
        hint = "Host not found — check DATABASE_URL spelling.";
      } else {
        hint =
          "Check DATABASE_URL format: postgresql://postgres.PROJECT:PASSWORD@aws-0-REGION.pooler.supabase.com:6543/postgres";
      }
    }
  }

  const live = dbOk && hasSupabaseUrl && hasAnonKey;

  return NextResponse.json({
    ok: live,
    mode: live ? "live" : "offline",
    build: {
      commit: process.env.VERCEL_GIT_COMMIT_SHA?.slice(0, 7) || null,
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
    hint: live ? "Database is live." : hint,
  });
}
