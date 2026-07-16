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
function buildPool(): Pool {
  const connectionString = process.env.DATABASE_URL;

  if (!connectionString) {
    // Intentionally invalid host so callers hit catch → demo mode with a clear log
    console.warn(
      "[sailorpath] DATABASE_URL is not set. Set it in Vercel Project → Settings → Environment Variables (Production), then redeploy."
    );
    return new Pool({
      connectionString: "postgres://postgres:postgres@127.0.0.1:1/sailorpath",
      connectionTimeoutMillis: 500,
      max: 1,
    });
  }

  const isSupabase =
    connectionString.includes("supabase") ||
    connectionString.includes("pooler.supabase.com");

  return new Pool({
    connectionString,
    max: 10,
    idleTimeoutMillis: 20_000,
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
