import { afterEach, describe, expect, it, vi } from "vitest";
import { getAuthCookieOptions } from "@/lib/supabase/cookie-options";

describe("getAuthCookieOptions", () => {
  afterEach(() => {
    vi.unstubAllEnvs();
  });

  it("keeps production authentication cookies host-only", () => {
    vi.stubEnv("VERCEL_ENV", "production");
    vi.stubEnv("NEXT_PUBLIC_COOKIE_DOMAIN", ".sailorpath.com");

    const options = getAuthCookieOptions();

    expect(options).toEqual({
      name: "sailorpath-public-auth",
      path: "/",
      sameSite: "lax",
      secure: true,
    });
    expect(options).not.toHaveProperty("domain");
  });

  it("uses a separate host-only cookie name for the admin origin", () => {
    vi.stubEnv("VERCEL_ENV", "production");

    expect(getAuthCookieOptions("admin.sailorpath.com:443")).toMatchObject({
      name: "sailorpath-admin-auth",
      secure: true,
    });
  });
});
