import { describe, expect, it } from "vitest";
import { ADMIN_REQUEST_TIMEOUT_MS, AdminRequestError, shouldRetryAdminQuery } from "./adminRequestPolicy";
import { AUTH_CONTEXT_TIMEOUT_MS } from "./auth";
import { DATABASE_OPERATION_TIMEOUT_MS } from "@/db";

describe("admin request budgets", () => {
  it("leaves response time after complete authorization and read budgets", () => {
    expect(ADMIN_REQUEST_TIMEOUT_MS).toBeGreaterThan(AUTH_CONTEXT_TIMEOUT_MS + DATABASE_OPERATION_TIMEOUT_MS + 1_000);
  });
  it("does not repeat server failures, authorization denials, or expired requests", () => {
    for (const status of [401, 403, 404, 500, 503]) {
      expect(shouldRetryAdminQuery(0, new AdminRequestError("Service unavailable", status))).toBe(false);
    }
    expect(shouldRetryAdminQuery(0, Object.assign(new Error("Deadline"), { name: "TimeoutError" }))).toBe(false);
    expect(shouldRetryAdminQuery(0, new Error("request timed out"))).toBe(false);
  });
  it("permits one retry of a transient browser network error", () => {
    expect(shouldRetryAdminQuery(0, new TypeError("Failed to fetch"))).toBe(true);
    expect(shouldRetryAdminQuery(1, new TypeError("Failed to fetch"))).toBe(false);
  });
});
