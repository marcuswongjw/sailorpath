import { afterEach, describe, expect, it, vi } from "vitest";
import { getAuthCookieOptions, safeAuthNext } from "@/lib/supabase/cookie-options";

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

  it("uses the admin cookie name when browser builds cannot expose VERCEL_ENV", () => {
    vi.stubEnv("VERCEL_ENV", "");

    expect(getAuthCookieOptions("admin.sailorpath.com")).toMatchObject({
      name: "sailorpath-admin-auth",
      secure: true,
    });
  });

  it("keeps the canonical public site on its separate cookie name", () => {
    vi.stubEnv("VERCEL_ENV", "");

    expect(getAuthCookieOptions("sailorpath.com")).toMatchObject({
      name: "sailorpath-public-auth",
      secure: true,
    });
  });
});

describe("safeAuthNext", () => {
  it("keeps same-site relative paths", () => {
    expect(safeAuthNext("/account?welcome=1")).toBe("/account?welcome=1");
    expect(safeAuthNext("//evil.example")).toBe("/");
    expect(safeAuthNext("/\\evil.example")).toBe("/");
  });

  it("allows SailorPath hosts and local http only", () => {
    expect(safeAuthNext("https://admin.sailorpath.com/admin")).toBe(
      "https://admin.sailorpath.com/admin"
    );
    expect(safeAuthNext("https://sailorpath.com/account")).toBe(
      "https://sailorpath.com/account"
    );
    expect(safeAuthNext("http://localhost:3000/admin")).toBe(
      "http://localhost:3000/admin"
    );
    expect(safeAuthNext("http://admin.sailorpath.com/admin")).toBe("/");
    expect(safeAuthNext("https://user:secret@sailorpath.com/account")).toBe("/");
  });

  it("rejects unrelated vercel.app hosts", () => {
    expect(safeAuthNext("https://evil.vercel.app/phish")).toBe("/");
    expect(safeAuthNext("https://vercel.app")).toBe("/");
    expect(safeAuthNext("https://sailorpath.com.evil.vercel.app")).toBe("/");
    expect(
      safeAuthNext(
        "https://attacker.vercel.app/admin",
        "/",
        "sailorpath-git-main.vercel.app"
      )
    ).toBe("/");
  });

  it("allows an absolute redirect only back to the host serving this login", () => {
    expect(
      safeAuthNext(
        "https://sailorpath-git-main.vercel.app/admin",
        "/",
        "sailorpath-git-main.vercel.app"
      )
    ).toBe("https://sailorpath-git-main.vercel.app/admin");
    expect(
      safeAuthNext(
        "https://evil.example/admin",
        "/account",
        "sailorpath.com"
      )
    ).toBe("/account");
  });
});
