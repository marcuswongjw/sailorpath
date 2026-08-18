import { describe, expect, it } from "vitest";
import { isUpstashConfigured, rateLimit, rateLimitAsync } from "./rateLimit";

describe("rateLimit", () => {
  it("allows up to limit then blocks", () => {
    const key = `test:${Date.now()}-${Math.random()}`;
    expect(rateLimit(key, 3, 60_000).ok).toBe(true);
    expect(rateLimit(key, 3, 60_000).ok).toBe(true);
    expect(rateLimit(key, 3, 60_000).ok).toBe(true);
    const blocked = rateLimit(key, 3, 60_000);
    expect(blocked.ok).toBe(false);
    expect(blocked.retryAfterSec).toBeGreaterThan(0);
  });
});

describe("rateLimitAsync", () => {
  it("falls back to memory when Upstash env is unset", async () => {
    const key = `async:${Date.now()}-${Math.random()}`;
    const a = await rateLimitAsync(key, 2, 60_000);
    const b = await rateLimitAsync(key, 2, 60_000);
    const c = await rateLimitAsync(key, 2, 60_000);
    expect(a.ok).toBe(true);
    expect(b.ok).toBe(true);
    expect(c.ok).toBe(false);
    expect(a.backend).toBe("memory");
  });
});

describe("isUpstashConfigured", () => {
  it("is false without env credentials in the test process", () => {
    expect(isUpstashConfigured()).toBe(
      Boolean(
        process.env.UPSTASH_REDIS_REST_URL?.trim() &&
          process.env.UPSTASH_REDIS_REST_TOKEN?.trim()
      )
    );
  });
});
