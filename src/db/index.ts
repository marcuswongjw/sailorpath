import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as schema from "./schema";

const globalForDb = globalThis as unknown as {
  sql: ReturnType<typeof postgres> | undefined;
};

/**
 * Prefer Supabase "Transaction" pooler (port 6543) for Vercel:
 *   postgresql://postgres.[PROJECT_REF]:[PASSWORD]@aws-0-[REGION].pooler.supabase.com:6543/postgres
 *
 * We use postgres.js with prepare:false — required for PgBouncer transaction mode.
 * (node-pg prepared statements break on the transaction pooler.)
 */
function cleanDatabaseUrl(raw: string): string {
  let url = raw.trim();
  // Vercel UI sometimes wraps values in quotes
  if (
    (url.startsWith('"') && url.endsWith('"')) ||
    (url.startsWith("'") && url.endsWith("'"))
  ) {
    url = url.slice(1, -1).trim();
  }
  return url;
}

function describeUrl(connectionString: string): {
  host: string | null;
  port: string | null;
  user: string | null;
  isPooler: boolean;
  isTransactionPort: boolean;
} {
  try {
    // postgres:// user:pass@host:port/db
    const u = new URL(connectionString.replace(/^postgresql:/i, "http:"));
    const port = u.port || "5432";
    return {
      host: u.hostname,
      port,
      user: decodeURIComponent(u.username || ""),
      isPooler: u.hostname.includes("pooler.supabase.com"),
      isTransactionPort: port === "6543",
    };
  } catch {
    return {
      host: null,
      port: null,
      user: null,
      isPooler: false,
      isTransactionPort: false,
    };
  }
}

function buildSql() {
  const raw = process.env.DATABASE_URL;

  if (!raw || !raw.trim()) {
    console.warn(
      "[sailorpath] DATABASE_URL is not set. Set it in Vercel → Environment Variables (Production), then Redeploy."
    );
    // Dead connection so callers fail fast into demo mode
    return postgres("postgres://postgres:postgres@127.0.0.1:1/sailorpath", {
      max: 1,
      connect_timeout: 1,
      prepare: false,
    });
  }

  const connectionString = cleanDatabaseUrl(raw);
  const meta = describeUrl(connectionString);

  console.info(
    "[sailorpath] DATABASE_URL host=%s port=%s user=%s pooler=%s",
    meta.host,
    meta.port,
    meta.user ? `${meta.user.slice(0, 12)}…` : "?",
    meta.isPooler
  );

  if (meta.host?.includes("db.") && meta.host.includes("supabase.co")) {
    console.warn(
      "[sailorpath] You are using the direct db.* host. On free-tier Supabase this is often IPv6-only and fails on Vercel. Prefer the Transaction pooler (…pooler.supabase.com:6543)."
    );
  }

  const isSupabase =
    connectionString.includes("supabase") ||
    connectionString.includes("pooler.supabase.com");

  return postgres(connectionString, {
    max: 5,
    idle_timeout: 20,
    connect_timeout: 10,
    // Critical for Supabase transaction pooler (PgBouncer)
    prepare: false,
    ssl: isSupabase ? "require" : undefined,
  });
}

const sql = globalForDb.sql ?? buildSql();

if (process.env.NODE_ENV !== "production") {
  globalForDb.sql = sql;
}

export const db = drizzle(sql, { schema });

/** Low-level client for health checks */
export { sql as pgSql };

export function getDatabaseUrlMeta() {
  const raw = process.env.DATABASE_URL;
  if (!raw?.trim()) return null;
  return describeUrl(cleanDatabaseUrl(raw));
}

/** Flatten Error + cause chain for diagnostics (no secrets). */
export function formatDbError(e: unknown): string {
  const parts: string[] = [];
  let cur: unknown = e;
  let depth = 0;
  while (cur && depth < 6) {
    if (cur instanceof Error) {
      parts.push(cur.message);
      const anyErr = cur as Error & { code?: string; severity?: string };
      if (anyErr.code) parts.push(`code=${anyErr.code}`);
      cur = (cur as Error & { cause?: unknown }).cause;
    } else if (typeof cur === "object" && cur !== null) {
      const o = cur as Record<string, unknown>;
      if (typeof o.message === "string") parts.push(o.message);
      if (typeof o.code === "string" || typeof o.code === "number") {
        parts.push(`code=${o.code}`);
      }
      cur = o.cause;
    } else {
      parts.push(String(cur));
      break;
    }
    depth += 1;
  }
  return parts.join(" | ").slice(0, 600);
}
