import { describe, expect, it } from "vitest";
import { adminReturnUrl, isAdminHost, publicSiteOrigin } from "./adminHost";

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

describe("publicSiteOrigin", () => {
  it("returns a non-empty origin string", () => {
    expect(publicSiteOrigin().length).toBeGreaterThan(0);
  });
});
