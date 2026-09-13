import { describe, expect, it } from "vitest";
import {
  adminLoginOrigin,
  adminReturnUrl,
  isAdminHost,
  publicSiteOrigin,
  shouldShowDemoNavigation,
} from "./adminHost";

describe("isAdminHost", () => {
  it("allows admin subdomain and local", () => {
    expect(isAdminHost("admin.sailorpath.com")).toBe(true);
    expect(isAdminHost("localhost:3000")).toBe(true);
    expect(isAdminHost("127.0.0.1:3000")).toBe(true);
    expect(isAdminHost("sailorpath.com")).toBe(false);
  });
});

describe("adminReturnUrl", () => {
  it("returns admin subdomain root for admin host", () => {
    expect(adminReturnUrl("admin.sailorpath.com", "/")).toBe(
      "https://admin.sailorpath.com/"
    );
    expect(adminReturnUrl("admin.sailorpath.com", "/admin")).toBe(
      "https://admin.sailorpath.com/"
    );
  });

  it("keeps metrics path on admin host", () => {
    expect(adminReturnUrl("admin.sailorpath.com", "/admin/metrics")).toBe(
      "https://admin.sailorpath.com/admin/metrics"
    );
  });
});

describe("adminLoginOrigin", () => {
  it("keeps the admin sign-in form on the canonical admin host", () => {
    expect(adminLoginOrigin("admin.sailorpath.com")).toBe(
      "https://admin.sailorpath.com"
    );
  });
});

describe("shouldShowDemoNavigation", () => {
  it("hides the public demo link on the admin host even without owned sailors", () => {
    expect(shouldShowDemoNavigation("admin.sailorpath.com", 0)).toBe(false);
    expect(shouldShowDemoNavigation("sailorpath.com", 0)).toBe(true);
    expect(shouldShowDemoNavigation("sailorpath.com", 1)).toBe(false);
  });

  it("hides the demo link for any logged-in user", () => {
    expect(shouldShowDemoNavigation("sailorpath.com", 0, true)).toBe(false);
    expect(shouldShowDemoNavigation("sailorpath.com", 0, false)).toBe(true);
  });
});

describe("publicSiteOrigin", () => {
  it("returns a non-empty origin string", () => {
    expect(publicSiteOrigin().length).toBeGreaterThan(0);
  });
});
