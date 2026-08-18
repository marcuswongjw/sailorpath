/**
 * Sliding-window rate limiter.
 *
 * Prefer durable Upstash Redis when `UPSTASH_REDIS_REST_URL` +
 * `UPSTASH_REDIS_REST_TOKEN` are set (survives serverless cold starts).
 * Falls back to an in-process Map otherwise.
 */

type Bucket = number[];

const store = new Map<string, Bucket>();

/** Max keys kept in memory to avoid unbounded growth */
const MAX_KEYS = 5000;

export type RateLimitResult = {
  ok: boolean;
  remaining: number;
  retryAfterSec: number;
  /** Which backend served the check */
  backend?: "memory" | "upstash";
};

function memoryRateLimit(
  key: string,
  limit: number,
  windowMs: number
): RateLimitResult {
  const now = Date.now();
  const cutoff = now - windowMs;
  let bucket = store.get(key) || [];
  bucket = bucket.filter((t) => t > cutoff);

  if (bucket.length >= limit) {
    store.set(key, bucket);
    const oldest = bucket[0] || now;
    const retryAfterSec = Math.max(
      1,
      Math.ceil((oldest + windowMs - now) / 1000)
    );
    return { ok: false, remaining: 0, retryAfterSec, backend: "memory" };
  }

  bucket.push(now);
  store.set(key, bucket);

  if (store.size > MAX_KEYS) {
    const excess = store.size - MAX_KEYS;
    let i = 0;
    for (const k of store.keys()) {
      store.delete(k);
      i += 1;
      if (i >= excess) break;
    }
  }

  return {
    ok: true,
    remaining: Math.max(0, limit - bucket.length),
    retryAfterSec: 0,
    backend: "memory",
  };
}

/**
 * Sync in-memory limiter (tests + warm-instance burst control).
 * Prefer `rateLimitAsync` in Route Handlers.
 */
export function rateLimit(
  key: string,
  limit: number,
  windowMs: number
): RateLimitResult {
  return memoryRateLimit(key, limit, windowMs);
}

async function upstashRateLimit(
  key: string,
  limit: number,
  windowMs: number
): Promise<RateLimitResult | null> {
  const base = process.env.UPSTASH_REDIS_REST_URL?.replace(/\/$/, "");
  const token = process.env.UPSTASH_REDIS_REST_TOKEN;
  if (!base || !token) return null;

  const redisKey = `rl:${key}`;
  const windowSec = Math.max(1, Math.ceil(windowMs / 1000));

  try {
    // Pipeline: INCR then EXPIRE only when this is the first hit in the window.
    const res = await fetch(`${base}/pipeline`, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify([
        ["INCR", redisKey],
        ["EXPIRE", redisKey, windowSec, "NX"],
        ["TTL", redisKey],
      ]),
      // Fail closed to memory if Upstash is slow
      signal: AbortSignal.timeout(1500),
    });
    if (!res.ok) return null;
    const data = (await res.json()) as { result?: unknown }[] | unknown[];
    const rows = Array.isArray(data) ? data : [];
    const incrRaw =
      rows[0] && typeof rows[0] === "object" && rows[0] !== null && "result" in rows[0]
        ? (rows[0] as { result: unknown }).result
        : rows[0];
    const ttlRaw =
      rows[2] && typeof rows[2] === "object" && rows[2] !== null && "result" in rows[2]
        ? (rows[2] as { result: unknown }).result
        : rows[2];
    const count = Number(incrRaw);
    if (!Number.isFinite(count)) return null;
    const ttl = Number(ttlRaw);
    const retryAfterSec =
      Number.isFinite(ttl) && ttl > 0 ? Math.ceil(ttl) : windowSec;

    if (count > limit) {
      return {
        ok: false,
        remaining: 0,
        retryAfterSec,
        backend: "upstash",
      };
    }
    return {
      ok: true,
      remaining: Math.max(0, limit - count),
      retryAfterSec: 0,
      backend: "upstash",
    };
  } catch {
    return null;
  }
}

/**
 * Durable when Upstash env is configured; otherwise in-memory.
 * Use this from Route Handlers for public write endpoints.
 */
export async function rateLimitAsync(
  key: string,
  limit: number,
  windowMs: number
): Promise<RateLimitResult> {
  const durable = await upstashRateLimit(key, limit, windowMs);
  if (durable) return durable;
  return memoryRateLimit(key, limit, windowMs);
}

/** Best-effort client IP from common proxy headers. */
export function clientIpFromRequest(req: Request): string {
  const xf = req.headers.get("x-forwarded-for");
  if (xf) {
    const first = xf.split(",")[0]?.trim();
    if (first) return first.slice(0, 64);
  }
  const real = req.headers.get("x-real-ip")?.trim();
  if (real) return real.slice(0, 64);
  return "unknown";
}

export function rateLimitResponse(retryAfterSec: number) {
  return Response.json(
    {
      error: "Too many requests. Please try again shortly.",
      retryAfterSec,
    },
    {
      status: 429,
      headers: {
        "Retry-After": String(retryAfterSec),
      },
    }
  );
}
