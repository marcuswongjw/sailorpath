import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as schema from "./schema";

const globalForDb = globalThis as unknown as {
  sql: ReturnType<typeof postgres> | undefined;
};

function cleanUrl(raw: string): string {
  let url = raw.trim();
  if (
    (url.startsWith('"') && url.endsWith('"')) ||
    (url.startsWith("'") && url.endsWith("'"))
  ) {
    url = url.slice(1, -1).trim();
  }
  return url;
}

export function describeDatabaseUrl(connectionString: string) {
  try {
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
      host: null as string | null,
      port: null as string | null,
      user: null as string | null,
      isPooler: false,
      isTransactionPort: false,
    };
  }
}

function buildSql() {
  const raw = process.env.DATABASE_URL;
  if (!raw?.trim()) {
    console.error(
      "[sailorpath] DATABASE_URL missing. Set Supabase Transaction pooler URI (port 6543) on Vercel Production."
    );
    return postgres("postgres://postgres:postgres@127.0.0.1:1/sailorpath", {
      max: 1,
      connect_timeout: 1,
      prepare: false,
    });
  }

  const connectionString = cleanUrl(raw);
  const meta = describeDatabaseUrl(connectionString);
  console.info(
    "[sailorpath] DB host=%s port=%s pooler=%s",
    meta.host,
    meta.port,
    meta.isPooler
  );

  if (meta.host?.startsWith("db.") && meta.host.includes("supabase.co")) {
    console.warn(
      "[sailorpath] Direct db.* host often fails on Vercel (IPv6). Use Transaction pooler …pooler.supabase.com:6543"
    );
  }

  const isSupabase =
    connectionString.includes("supabase") ||
    connectionString.includes("pooler.supabase.com");

  return postgres(connectionString, {
    max: 5,
    idle_timeout: 20,
    connect_timeout: 10,
    prepare: false,
    ssl: isSupabase ? "require" : undefined,
  });
}

const sql = globalForDb.sql ?? buildSql();
if (process.env.NODE_ENV !== "production") {
  globalForDb.sql = sql;
}

export const db = drizzle(sql, { schema });
export { sql as pgSql };

export function getDatabaseUrlMeta() {
  const raw = process.env.DATABASE_URL;
  if (!raw?.trim()) return null;
  return describeDatabaseUrl(cleanUrl(raw));
}

export function formatDbError(e: unknown): string {
  const parts: string[] = [];
  let cur: unknown = e;
  let depth = 0;
  while (cur && depth < 6) {
    if (cur instanceof Error) {
      parts.push(cur.message);
      const anyErr = cur as Error & { code?: string };
      if (anyErr.code) parts.push(`code=${anyErr.code}`);
      cur = (cur as Error & { cause?: unknown }).cause;
    } else if (typeof cur === "object" && cur !== null) {
      const o = cur as Record<string, unknown>;
      if (typeof o.message === "string") parts.push(o.message);
      if (o.code != null) parts.push(`code=${o.code}`);
      cur = o.cause;
    } else {
      parts.push(String(cur));
      break;
    }
    depth += 1;
  }
  return parts.join(" | ").slice(0, 600);
}

export class DbUnavailableError extends Error {
  constructor(message = "Database unavailable") {
    super(message);
    this.name = "DbUnavailableError";
  }
}
