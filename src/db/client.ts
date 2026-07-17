import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as schema from "./schema";

const globalForDb = globalThis as unknown as {
  sql: ReturnType<typeof postgres> | undefined;
};

function cleanUrl(raw: string): string {
  let url = raw.trim();
  // Strip wrapping quotes / accidental whitespace from Vercel paste
  if (
    (url.startsWith('"') && url.endsWith('"')) ||
    (url.startsWith("'") && url.endsWith("'"))
  ) {
    url = url.slice(1, -1).trim();
  }
  // Prisma-only schemes are not valid for postgres.js
  if (url.startsWith("prisma+postgres://")) {
    url = "postgres://" + url.slice("prisma+postgres://".length);
  }
  if (url.startsWith("prisma+postgresql://")) {
    url = "postgresql://" + url.slice("prisma+postgresql://".length);
  }
  return url;
}

function tryParse(connectionString: string) {
  try {
    const normalized = connectionString
      .replace(/^postgresql:/i, "http:")
      .replace(/^postgres:/i, "http:");
    const u = new URL(normalized);
    if (!u.hostname) return null;
    return {
      host: u.hostname,
      port: u.port || "5432",
      user: decodeURIComponent(u.username || ""),
      isPooler: u.hostname.includes("pooler.supabase.com"),
      isTransactionPort: (u.port || "5432") === "6543",
    };
  } catch {
    return null;
  }
}

export function describeDatabaseUrl(connectionString: string) {
  return (
    tryParse(connectionString) || {
      host: null as string | null,
      port: null as string | null,
      user: null as string | null,
      isPooler: false,
      isTransactionPort: false,
    }
  );
}

/**
 * Resolve a postgres.js-compatible connection string.
 * Tries DATABASE_URL first, then Supabase/Vercel integration vars.
 */
export function resolveConnectionString(): string | null {
  const candidates = [
    process.env.DATABASE_URL,
    process.env.POSTGRES_URL,
    process.env.POSTGRES_PRISMA_URL,
    process.env.POSTGRES_URL_NON_POOLING,
  ];

  for (const raw of candidates) {
    if (!raw?.trim()) continue;
    // Skip redacted placeholders if any tool wrote them
    if (raw.includes("[SENSITIVE]") || raw.includes("YOUR_PASSWORD")) continue;
    const cleaned = cleanUrl(raw);
    if (!cleaned.startsWith("postgres")) continue;
    if (tryParse(cleaned)) return cleaned;
    // Password may have unencoded special chars — attempt rebuild from pieces
  }

  const user = process.env.POSTGRES_USER?.trim();
  const pass = process.env.POSTGRES_PASSWORD;
  const host = process.env.POSTGRES_HOST?.trim();
  if (user && pass != null && pass !== "" && host) {
    // Prefer session pooler host if they only set direct db.* host
    // (caller can still set DATABASE_URL to transaction pooler).
    const encUser = encodeURIComponent(user);
    const encPass = encodeURIComponent(pass);
    const rebuilt = `postgresql://${encUser}:${encPass}@${host}:5432/postgres`;
    if (tryParse(rebuilt)) return rebuilt;
  }

  return null;
}

function makeDeadClient() {
  // Valid URL that fails fast at query time (never throws at construct)
  return postgres("postgres://postgres:postgres@127.0.0.1:1/sailorpath", {
    max: 1,
    connect_timeout: 1,
    prepare: false,
  });
}

function buildSql() {
  try {
    const connectionString = resolveConnectionString();
    if (!connectionString) {
      console.error(
        "[sailorpath] No valid DATABASE_URL / POSTGRES_URL. Set Supabase Transaction pooler URI (port 6543) on Vercel."
      );
      return makeDeadClient();
    }

    const meta = describeDatabaseUrl(connectionString);
    console.info(
      "[sailorpath] DB host=%s port=%s pooler=%s",
      meta.host,
      meta.port,
      meta.isPooler
    );

    if (meta.host?.startsWith("db.") && meta.host.includes("supabase.co")) {
      console.warn(
        "[sailorpath] Direct db.* host is often IPv6-only on free tier. Prefer …pooler.supabase.com:6543"
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
  } catch (e) {
    console.error("[sailorpath] DB client init failed; using dead client.", e);
    return makeDeadClient();
  }
}

const sql = globalForDb.sql ?? buildSql();
if (process.env.NODE_ENV !== "production") {
  globalForDb.sql = sql;
}

export const db = drizzle(sql, { schema });
export { sql as pgSql };

export function getDatabaseUrlMeta() {
  const cs = resolveConnectionString();
  if (!cs) return null;
  return describeDatabaseUrl(cs);
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
