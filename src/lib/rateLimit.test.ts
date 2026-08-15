import { describe, expect, it } from "vitest";
import { rateLimit } from "./rateLimit";

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
