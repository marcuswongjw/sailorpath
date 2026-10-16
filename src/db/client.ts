import { AsyncLocalStorage } from "node:async_hooks";
import { drizzle } from "drizzle-orm/node-postgres";
import { Pool, type PoolClient } from "pg";
import * as schema from "./schema";
import { SUPABASE_ROOT_CA } from "./supabaseCa";

/** One budget covers acquisition, queries, and both read attempts. */
export const DATABASE_OPERATION_TIMEOUT_MS = 6_000;
export const DATABASE_PREFLIGHT_TIMEOUT_MS = 1_000;
// Next can evaluate the module in several server bundles in one process. The
// context must be shared with the pool, including its original connect method.
const globalForDb = globalThis as unknown as {
  sailorpathPgPool?: DatabasePool;
  sailorpathDatabaseContext?: AsyncLocalStorage<{ signal: AbortSignal }>;
};
const readContext = globalForDb.sailorpathDatabaseContext ?? new AsyncLocalStorage<{ signal: AbortSignal }>();
globalForDb.sailorpathDatabaseContext = readContext;

function cleanUrl(raw: string): string {
  let url = raw.trim();
  // Strip wrapping quotes / accidental whitespace from Vercel paste
  if (
    (url.startsWith('"') && url.endsWith('"')) ||
    (url.startsWith("'") && url.endsWith("'"))
  ) {
    url = url.slice(1, -1).trim();
  }
  // Prisma-only schemes are not valid for PostgreSQL
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
 * Resolve a PostgreSQL-compatible connection string.
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

/** node-postgres serializes queries on each socket. postgres.js pipelining can
 * return mismatched rows or hang on Supavisor transaction mode:
 * https://supabase.com/docs/guides/database/postgres-js
 */
export function postgresPoolOptions(connectionString: string) {
  const url = new URL(connectionString);
  const isSupabase = url.hostname.endsWith(".supabase.co") || url.hostname.endsWith(".pooler.supabase.com");
  const customCertificate = ["sslrootcert", "sslcert", "sslkey"].some((key) => url.searchParams.has(key));
  const useSupabaseCa = isSupabase && !customCertificate;
  if (useSupabaseCa) {
    // pg-connection-string would replace the explicit CA options below when
    // sslmode=require is present. Keep encryption AND certificate verification.
    url.searchParams.delete("sslmode");
    url.searchParams.delete("ssl");
    url.searchParams.delete("uselibpqcompat");
  }
  return {
    connectionString: useSupabaseCa ? url.toString() : connectionString,
    max: 1,
    idleTimeoutMillis: 5_000,
    connectionTimeoutMillis: 2_000,
    query_timeout: 4_000,
    allowExitOnIdle: true,
    ssl: useSupabaseCa ? { ca: SUPABASE_ROOT_CA, rejectUnauthorized: true } : isSupabase ? true : undefined,
  };
}

type ConnectCallback = (
  error: Error | undefined,
  client: PoolClient | undefined,
  release: (error?: Error | boolean) => void
) => void;

/** Abort only this operation's lease, never other requests' connections.
 * A late acquisition is released without querying. Release is idempotent so
 * Drizzle's transaction finally block remains safe after cancellation.
 */
export class DatabasePool extends Pool {
  connect(): Promise<PoolClient>;
  connect(callback: ConnectCallback): void;
  connect(callback?: ConnectCallback): Promise<PoolClient> | void {
    const context = readContext.getStore();
    if (!context) {
      if (callback) return super.connect(callback);
      return super.connect();
    }
    const { signal } = context;
    const pending = new Promise<PoolClient>((resolve, reject) => {
      if (signal.aborted) return reject(signal.reason);
      let leased: PoolClient | undefined;
      const onAbort = () => {
        leased?.release(true);
        reject(signal.reason);
      };
      signal.addEventListener("abort", onAbort, { once: true });
      super.connect((error, client, release) => {
        if (error || !client) {
          signal.removeEventListener("abort", onAbort);
          reject(error ?? new Error("Database connection unavailable"));
          return;
        }
        if (signal.aborted) {
          signal.removeEventListener("abort", onAbort);
          release(true);
          reject(signal.reason);
          return;
        }
        let released = false;
        client.release = (releaseError?: Error | boolean) => {
          if (released) return;
          released = true;
          signal.removeEventListener("abort", onAbort);
          release(releaseError);
        };
        leased = client;
        resolve(client);
      });
    });
    if (callback) {
      void pending.then(
        (client) => callback(undefined, client, client.release),
        (error: Error) => callback(error, undefined, () => undefined)
      );
      return;
    }
    return pending;
  }
}

function buildPool() {
  const connectionString = resolveConnectionString();
  if (!connectionString) console.error("[sailorpath] No valid DATABASE_URL / POSTGRES_URL configured.");
  const pool = new DatabasePool(postgresPoolOptions(
    connectionString ?? "postgres://postgres:postgres@127.0.0.1:1/sailorpath"
  ));
  // pg removes failed idle clients itself. Do not kill the entire shared pool.
  pool.on("error", (error) => console.warn("[sailorpath] Idle database connection removed", {
    error: formatDbError(error),
  }));
  return pool;
}

export const databasePool = globalForDb.sailorpathPgPool ?? buildPool();
globalForDb.sailorpathPgPool = databasePool;
export const db = drizzle(databasePool, { schema });

/** Parameterized tag retained for aggregate and health queries. */
export async function pgSql(strings: TemplateStringsArray, ...values: unknown[]): Promise<Record<string, unknown>[]> {
  const text = strings.reduce((query, part, index) => query + (index ? `$${index}` : "") + part, "");
  return (await databasePool.query(text, values)).rows;
}

/** The aborted context remains attached to late continuations, preventing them
 * issuing queries after timeout. Parent/caller cancellation is propagated too.
 */
export async function withDatabaseDeadline<T>(operation: () => Promise<T>, timeoutMs: number, signal?: AbortSignal): Promise<T> {
  const parent = readContext.getStore()?.signal;
  const controller = new AbortController();
  const abortParent = () => controller.abort(parent?.reason);
  const abortCaller = () => controller.abort(signal?.reason);
  parent?.addEventListener("abort", abortParent, { once: true });
  signal?.addEventListener("abort", abortCaller, { once: true });
  if (parent?.aborted) abortParent();
  if (signal?.aborted) abortCaller();
  const timer = setTimeout(() => controller.abort(new Error("DB_OPERATION_TIMEOUT")), Math.max(0, timeoutMs));
  let onAbort: () => void = () => undefined;
  try {
    return await readContext.run({ signal: controller.signal }, () => Promise.race([
      new Promise<never>((_, reject) => {
        onAbort = () => reject(controller.signal.reason);
        controller.signal.addEventListener("abort", onAbort, { once: true });
        if (controller.signal.aborted) onAbort();
      }),
      Promise.resolve().then(() => {
        if (controller.signal.aborted) throw controller.signal.reason;
        return operation();
      }),
    ]));
  } finally {
    clearTimeout(timer);
    controller.signal.removeEventListener("abort", onAbort);
    controller.abort(new Error("DB_OPERATION_CLOSED"));
    parent?.removeEventListener("abort", abortParent);
    signal?.removeEventListener("abort", abortCaller);
  }
}

export async function ensureDatabaseLiveness(): Promise<void> {
  await withDatabaseDeadline(async () => { await databasePool.query("select 1 as ok"); }, DATABASE_PREFLIGHT_TIMEOUT_MS);
}

export function isRetryableDatabaseConnectionError(errorMessage: string): boolean {
  return /\b(?:DB_PREFLIGHT_TIMEOUT|DB_OPERATION_TIMEOUT|CONNECT_TIMEOUT|CONNECTION_DESTROYED|CONNECTION_CLOSED|CONNECTION_ENDED|ETIMEDOUT|ECONNRESET|ECONNREFUSED|EPIPE)\b|query read timeout|timeout exceeded when trying to connect|connection terminated|socket hang up|connection (?:closed|destroyed|terminated|reset)|write EOF|read ECONNRESET/i.test(errorMessage);
}

export type DatabaseRetryOptions = {
  /** Total budget, not a fresh timeout per attempt. */
  timeoutMs?: number;
  label?: string;
  signal?: AbortSignal;
};

/** Read-only recovery: retire only failed leases and share one total budget. */
export async function withDatabaseRetry<T>(operation: () => Promise<T>, options?: DatabaseRetryOptions): Promise<T> {
  const deadline = Date.now() + (options?.timeoutMs ?? DATABASE_OPERATION_TIMEOUT_MS);
  const parentSignal = readContext.getStore()?.signal;
  for (let attempt = 0; attempt < 2; attempt += 1) {
    const remaining = deadline - Date.now();
    if (remaining <= 0) throw new Error("DB_OPERATION_TIMEOUT");
    try {
      return await withDatabaseDeadline(operation, attempt === 0 ? Math.ceil(remaining / 2) : remaining, options?.signal);
    } catch (error) {
      if (options?.signal?.aborted || parentSignal?.aborted || attempt === 1 || !isRetryableDatabaseConnectionError(formatDbError(error))) throw error;
      console.warn("[sailorpath] Retrying database read", {
        label: options?.label ?? "db.read",
        remainingMs: Math.max(0, deadline - Date.now()),
        error: formatDbError(error).slice(0, 240),
      });
    }
  }
  throw new Error("DB_OPERATION_TIMEOUT");
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
  // Long Drizzle SQL text must not truncate the underlying connection code.
  return parts.reverse().join(" | ").slice(0, 600);
}

export class DbUnavailableError extends Error {
  readonly status = 503;

  constructor(message = "Database unavailable") {
    super(message);
    this.name = "DbUnavailableError";
  }
}
