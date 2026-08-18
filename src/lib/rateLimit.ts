/**
 * Lightweight sliding-window rate limiter (in-process).
 *
 * NOTE: This resets on every Vercel serverless cold start. An attacker who
 * triggers requests across different instances can bypass the limit. For
 * production hardening, replace the in-memory Map with Upstash Redis or
 * Vercel KV so state survives cold starts.
 *
 * For now this provides reasonable burst protection within a warm instance,
 * which covers the majority of abuse patterns against /api/support and
 * /api/claims.
 */

type Bucket = number[];

const store = new Map<string, Bucket>();

/** Max keys kept in memory to avoid unbounded growth */
const MAX_KEYS = 5000;

export type RateLimitResult = {
  ok: boolean;
  remaining: number;
  retryAfterSec: number;
};

/**
 * @param key - e.g. `support:1.2.3.4` or `claims:user-uuid`
 * @param limit - max events in the window
 * @param windowMs - window length
 */
export function rateLimit(
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
    return { ok: false, remaining: 0, retryAfterSec };
  }

  bucket.push(now);
  store.set(key, bucket);

  // Opportunistic prune
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
  };
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
