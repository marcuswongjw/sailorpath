import { describe, expect, it } from "vitest";
import { refreshAuthSession, requestHasAuthSession } from "@/proxy";

describe("session refresh", () => {
  it("refreshes only when an auth cookie is already present", () => {
    expect(requestHasAuthSession([])).toBe(false);
    expect(requestHasAuthSession(["theme"])).toBe(false);
    expect(requestHasAuthSession(["sb-example-auth-token"])).toBe(true);
    expect(requestHasAuthSession(["sailorpath-public-auth.0"])).toBe(true);
  });

  it("gives up when the auth provider does not answer", async () => {
    const started = Date.now();
    await expect(
      refreshAuthSession(() => new Promise(() => undefined), 40)
    ).resolves.toBe("skipped");
    expect(Date.now() - started).toBeLessThan(500);
  });

  it("reports a successful refresh", async () => {
    await expect(refreshAuthSession(async () => ({ user: null }), 40)).resolves.toBe(
      "refreshed"
    );
  });
});
