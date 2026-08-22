import { describe, expect, it } from "vitest";
import { unstable_doesMiddlewareMatch } from "next/experimental/testing/server";
import { config, shouldRefreshSession } from "@/proxy";

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
    expect(shouldRefreshSession("/sg/optimist/goldsailors", false)).toBe(true);
    expect(shouldRefreshSession("/alice-tan", false)).toBe(true);
    expect(shouldRefreshSession("/robots.txt", false)).toBe(false);
    expect(shouldRefreshSession("/", true)).toBe(true);
  });
});
