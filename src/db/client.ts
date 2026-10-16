import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as schema from "./schema";

type SqlClient = ReturnType<typeof postgres>;

const globalForDb = globalThis as unknown as {
  sql: SqlClient | undefined;
};

/** Avoid reusing a possibly frozen serverless socket after brief inactivity. */
const DATABASE_LIVENESS_RECHECK_MS = 5_000;
/** Bound the liveness probe so a stale socket cannot consume a request budget. */
export const DATABASE_PREFLIGHT_TIMEOUT_MS = 3_000;
/** Bound individual retryable read operations so a mid-query stall cannot hang until the 300s platform timeout. */
export const DATABASE_OPERATION_TIMEOUT_MS = 8_000;
let lastDatabaseLivenessCheckAt = 0;
let databaseLivenessCheck: Promise<void> | null = null;

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

/**
 * Supabase direct `db.<ref>.supabase.co` hosts are commonly IPv6-only on the
 * Free tier. Convert only that explicit direct form to the transaction pooler
 * while retaining the already-configured user and password at runtime.
 */
export function toSupabaseTransactionPooler(
  connectionString: string,
  region: string | undefined
): string | null {
  const poolerRegion = region?.trim();
  if (!poolerRegion) return null;

  try {
    const normalized = connectionString
      .replace(/^postgresql:/i, "http:")
      .replace(/^postgres:/i, "http:");
    const source = new URL(normalized);
    const match = /^db\.([a-z0-9-]+)\.supabase\.co$/i.exec(source.hostname);
    if (!match) return null;

    const projectRef = match[1];
    const sourceUser = decodeURIComponent(source.username);
    const sourcePassword = decodeURIComponent(source.password);
    if (!sourceUser || !sourcePassword) return null;

    const poolerUser = sourceUser.includes(".")
      ? sourceUser
      : `${sourceUser}.${projectRef}`;
    const databaseName = source.pathname || "/postgres";
    const params = new URLSearchParams(source.search);
    params.set("sslmode", "require");

    return `postgresql://${encodeURIComponent(poolerUser)}:${encodeURIComponent(sourcePassword)}@aws-0-${poolerRegion}.pooler.supabase.com:6543${databaseName}?${params.toString()}`;
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
    const poolerConnection = toSupabaseTransactionPooler(
      cleaned,
      process.env.SUPABASE_POOLER_REGION
    );
    if (poolerConnection) return poolerConnection;
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
    const poolerConnection = toSupabaseTransactionPooler(
      rebuilt,
      process.env.SUPABASE_POOLER_REGION
    );
    if (poolerConnection) return poolerConnection;
    if (tryParse(rebuilt)) return rebuilt;
  }

  return null;
}

/**
 * Serverless connection options.
 *
 * `fetch_types: false` skips postgres.js catalog introspection
 * (`select b.oid, b.typarray from pg_catalog.pg_type ...`) that otherwise
 * runs on every new connection. Built-in types still parse; this schema
 * does not use custom array types.
 *
 * `prepare: false` is required for Supabase transaction-mode pooler (6543).
 * `max: 1` keeps one connection per isolate so warm invocations reuse it
 * instead of opening a pool that each fetches types and holds pooler slots.
 * A short idle timeout closes live-but-unused sockets before a serverless
 * instance suspends; an application liveness probe handles frozen sockets.
 */
export function postgresJsOptions(connectionString: string) {
  const isSupabase =
    connectionString.includes("supabase") ||
    connectionString.includes("pooler.supabase.com");
  return {
    max: 1,
    idle_timeout: 5,
    connect_timeout: 5,
    prepare: false,
    fetch_types: false,
    ssl: isSupabase ? ("require" as const) : undefined,
  };
}

function makeDeadClient() {
  // Valid URL that fails fast at query time (never throws at construct)
  return postgres("postgres://postgres:postgres@127.0.0.1:1/sailorpath", {
    max: 1,
    connect_timeout: 1,
    prepare: false,
    fetch_types: false,
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

    return postgres(connectionString, postgresJsOptions(connectionString));
  } catch (e) {
    console.error("[sailorpath] DB client init failed; using dead client.", e);
    return makeDeadClient();
  }
}

// Reuse one client per isolate, including production. Next can evaluate this
// module from more than one server bundle; globalThis is the shared slot.
let sql = globalForDb.sql ?? buildSql();
globalForDb.sql = sql;

export let db = drizzle(sql, { schema });
export let pgSql = sql;

/**
 * Drops a stale postgres.js socket after a retryable serverless connection
 * failure. Serverless runtimes can freeze warm isolates while the pooler or
 * NAT retires their idle TCP socket; the next query must use a new client.
 */
export function recycleDatabaseClient(expectedClient?: SqlClient): boolean {
  // Several concurrent requests can discover the same stale socket. Only the
  // first should replace it; later requests can reuse the fresh replacement.
  if (expectedClient && sql !== expectedClient) return false;

  const retiredSql = sql;
  sql = buildSql();
  globalForDb.sql = sql;
  pgSql = sql;
  db = drizzle(sql, { schema });
  lastDatabaseLivenessCheckAt = 0;

  // Do not hold the retry path open while the failed client's socket closes.
  void retiredSql.end({ timeout: 0 }).catch(() => undefined);
  return true;
}

function withTimeout<T>(
  operation: Promise<T>,
  timeoutMs: number,
  errorCode = "DB_PREFLIGHT_TIMEOUT"
): Promise<T> {
  return new Promise<T>((resolve, reject) => {
    const timeout = setTimeout(() => {
      const cancellable = operation as Promise<T> & { cancel?: () => void };
      try {
        cancellable.cancel?.();
      } catch {
        /* ignore cancel errors on dead sockets */
      }
      reject(new Error(errorCode));
    }, timeoutMs);
    operation.then(resolve, reject).finally(() => clearTimeout(timeout));
  });
}

/**
 * Check a warm serverless isolate before reusing its database socket.
 *
 * Supabase documents that frozen functions can retain a stale TCP socket even
 * when an application-level idle timeout is configured. A failed or slow
 * lightweight query replaces that socket before the caller performs its real
 * read. Successful probes are coalesced for a short interval per isolate.
 */
export async function ensureDatabaseLiveness(): Promise<void> {
  if (Date.now() - lastDatabaseLivenessCheckAt < DATABASE_LIVENESS_RECHECK_MS) {
    return;
  }
  if (databaseLivenessCheck) return databaseLivenessCheck;

  const client = sql;
  const check = (async () => {
    try {
      await withTimeout(
        client`select 1 as ok`,
        DATABASE_PREFLIGHT_TIMEOUT_MS,
        "DB_PREFLIGHT_TIMEOUT"
      );
      if (sql === client) lastDatabaseLivenessCheckAt = Date.now();
    } catch {
      recycleDatabaseClient(client);
    }
  })();

  databaseLivenessCheck = check;
  void check.finally(() => {
    if (databaseLivenessCheck === check) databaseLivenessCheck = null;
  });
  return check;
}

export function isRetryableDatabaseConnectionError(errorMessage: string): boolean {
  return /\b(?:DB_PREFLIGHT_TIMEOUT|DB_OPERATION_TIMEOUT|CONNECT_TIMEOUT|CONNECTION_DESTROYED|CONNECTION_CLOSED|CONNECTION_ENDED|ETIMEDOUT|ECONNRESET|ECONNREFUSED|EPIPE)\b|socket hang up|connection (?:closed|destroyed|terminated|reset)|write EOF|read ECONNRESET/i.test(
    errorMessage
  );
}

export type DatabaseRetryOptions = {
  timeoutMs?: number;
  label?: string;
};

/**
 * Runs a database operation after a liveness probe and once more with a fresh
 * client when the pooler rejects or stalls a stale serverless socket. Keep this
 * bounded: callers receive the second failure instead of exhausting their request time.
 */
export async function withDatabaseRetry<T>(
  operation: () => Promise<T>,
  options?: DatabaseRetryOptions
): Promise<T> {
  const timeoutMs = options?.timeoutMs ?? DATABASE_OPERATION_TIMEOUT_MS;
  await ensureDatabaseLiveness();
  const firstClient = sql;
  try {
    return await withTimeout(operation(), timeoutMs, "DB_OPERATION_TIMEOUT");
  } catch (error) {
    const formatted = formatDbError(error);
    if (!isRetryableDatabaseConnectionError(formatted)) throw error;

    console.warn(
      "[sailorpath] Retrying database read after recoverable connection failure",
      {
        label: options?.label ?? "db.read",
        error: formatted.slice(0, 240),
      }
    );
    recycleDatabaseClient(firstClient);
    await new Promise<void>((resolve) => setTimeout(resolve, 100));
    await ensureDatabaseLiveness();
    const secondClient = sql;
    try {
      return await withTimeout(operation(), timeoutMs, "DB_OPERATION_TIMEOUT");
    } catch (secondError) {
      if (isRetryableDatabaseConnectionError(formatDbError(secondError))) {
        recycleDatabaseClient(secondClient);
      }
      throw secondError;
    }
  }
}

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
  readonly status = 503;

  constructor(message = "Database unavailable") {
    super(message);
    this.name = "DbUnavailableError";
  }
}
