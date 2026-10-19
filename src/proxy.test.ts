import { describe, expect, it } from "vitest";
import { unstable_doesMiddlewareMatch } from "next/experimental/testing/server";
import { config, hasUsableSupabaseUrl, shouldRefreshSession } from "@/proxy";

describe("proxy routing", () => {
  it("only matches auth-sensitive route shapes", () => {
    expect(
      unstable_doesMiddlewareMatch({ config, nextConfig: {}, url: "/rankings" })
    ).toBe(true);
    expect(
      unstable_doesMiddlewareMatch({
        config,
        nextConfig: {},
        url: "/sg/optimist/gold",
      })
    ).toBe(false);
    expect(
      unstable_doesMiddlewareMatch({
        config,
        nextConfig: {},
        url: "/api/rankings",
      })
    ).toBe(false);
  });

  it("refreshes sessions only for protected pages and sailor profiles", () => {
    expect(shouldRefreshSession("/rankings", false)).toBe(false);
    expect(shouldRefreshSession("/admin", false)).toBe(true);
    expect(shouldRefreshSession("/account", false)).toBe(true);
    expect(shouldRefreshSession("/following", false)).toBe(true);
    expect(shouldRefreshSession("/coach-tools", false)).toBe(true);
    expect(shouldRefreshSession("/sg/optimist/goldsailors", false)).toBe(true);
    expect(shouldRefreshSession("/alice-tan", false)).toBe(true);
    expect(shouldRefreshSession("/blog", false)).toBe(false);
    expect(shouldRefreshSession("/sailors", false)).toBe(false);
    expect(shouldRefreshSession("/news", false)).toBe(false);
    expect(shouldRefreshSession("/results", false)).toBe(false);
    expect(shouldRefreshSession("/robots.txt", false)).toBe(false);
    expect(shouldRefreshSession("/", true)).toBe(true);
  });

  it("skips session refresh for malformed local Supabase URLs", () => {
    expect(hasUsableSupabaseUrl("https://example.supabase.co")).toBe(true);
    expect(hasUsableSupabaseUrl("http://localhost:54321")).toBe(true);
    expect(hasUsableSupabaseUrl("placeholder")).toBe(false);
    expect(hasUsableSupabaseUrl("not-a-url")).toBe(false);
  });
});
