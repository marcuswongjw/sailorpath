import { describe, expect, it } from "vitest";
import { cookieHeaderHasAuthSession } from "./authCookie";

describe("cookieHeaderHasAuthSession", () => {
  it("ignores a visit with no auth cookie", () => {
    expect(cookieHeaderHasAuthSession("theme=light; other=1")).toBe(false);
  });

  it("detects the public and default Supabase cookie names", () => {
    expect(
      cookieHeaderHasAuthSession("sailorpath-public-auth.0=abc")
    ).toBe(true);
    expect(cookieHeaderHasAuthSession("sb-example-auth-token=abc")).toBe(true);
  });
});
