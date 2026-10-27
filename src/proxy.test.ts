import { describe, expect, it } from "vitest";
import { unstable_doesMiddlewareMatch } from "next/experimental/testing/server";
import { NextRequest } from "next/server";
import { proxy, config, hasUsableSupabaseUrl, shouldRefreshSession } from "@/proxy";

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
    expect(shouldRefreshSession("/classes", false)).toBe(false);
    expect(shouldRefreshSession("/classes/x15", false)).toBe(false);
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

describe("photo cache bypass protection", () => {
  it.each([
    "/athlete-portraits/team-singapore/example.jpg",
    "/_next/image?url=%2Fathlete-portraits%2Fteam-singapore%2Fexample.jpg&w=64&q=75",
    "/_next/image?url=%2Fapi%2Fsailors%2F11111111-1111-4111-8111-111111111111%2Fphoto&w=64&q=75",
    "/_next/image?url=https%3A%2F%2Fproject.supabase.co%2Fstorage%2Fv1%2Fobject%2Fpublic%2Favatars%2Fid%2Fphoto.jpg&w=64&q=75",
  ])("blocks originals and shared optimiser caches: %s", async (url) => {
    expect(unstable_doesMiddlewareMatch({ config, nextConfig: {}, url })).toBe(true);
    const response = await proxy(new NextRequest(`https://sailorpath.com${url}`));
    expect(response.status).toBe(404);
    expect(response.headers.get("Cache-Control")).toContain("no-store");
  });
});
