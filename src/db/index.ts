import { drizzle } from "drizzle-orm/node-postgres";
import { Pool } from "pg";
import * as schema from "./schema";

const globalForDb = globalThis as unknown as {
  conn: Pool | undefined;
};

/**
 * Prefer Supabase "Transaction" pooler URL on port 6543 for serverless (Vercel):
 *   postgresql://postgres.[PROJECT_REF]:[PASSWORD]@aws-0-[REGION].pooler.supabase.com:6543/postgres
 * Or Session mode :5432. Direct db.* :5432 also works with SSL.
 */
function normalizeDatabaseUrl(raw: string): string {
  let url = raw.trim();
  // Transaction pooler works better with pgbouncer flag for serverless
  if (
    (url.includes("pooler.supabase.com") || url.includes(":6543")) &&
    !url.includes("pgbouncer=")
  ) {
    url += url.includes("?") ? "&pgbouncer=true" : "?pgbouncer=true";
  }
  return url;
}

function buildPool(): Pool {
  const raw = process.env.DATABASE_URL;

  if (!raw || !raw.trim()) {
    // Intentionally invalid host so callers hit catch → demo mode with a clear log
    console.warn(
      "[sailorpath] DATABASE_URL is not set. Set it in Vercel Project → Settings → Environment Variables (Production), then redeploy. Use Supabase → Database → Connection string → Transaction pooler (port 6543)."
    );
    return new Pool({
      connectionString: "postgres://postgres:postgres@127.0.0.1:1/sailorpath",
      connectionTimeoutMillis: 500,
      max: 1,
    });
  }

  const connectionString = normalizeDatabaseUrl(raw);
  const isSupabase =
    connectionString.includes("supabase") ||
    connectionString.includes("pooler.supabase.com");

  console.info(
    "[sailorpath] DATABASE_URL configured:",
    connectionString.replace(/:[^:@/]+@/, ":***@").slice(0, 120)
  );

  return new Pool({
    connectionString,
    max: 5,
    idleTimeoutMillis: 10_000,
    connectionTimeoutMillis: 8_000,
    // Supabase requires SSL; pooler is fine with rejectUnauthorized: false on free tier
    ssl: isSupabase ? { rejectUnauthorized: false } : undefined,
  });
}

const conn = globalForDb.conn ?? buildPool();

if (process.env.NODE_ENV !== "production") {
  globalForDb.conn = conn;
}

export const db = drizzle(conn, { schema });
