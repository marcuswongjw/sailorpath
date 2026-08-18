import { describe, expect, it, vi } from "vitest";
import { adminLog, createAdminRequestId } from "./adminLog";

describe("adminLog", () => {
  it("creates short request ids", () => {
    const id = createAdminRequestId();
    expect(id.length).toBeGreaterThanOrEqual(7);
    expect(id.length).toBeLessThanOrEqual(36);
  });

  it("emits JSON with scope admin", () => {
    const spy = vi.spyOn(console, "info").mockImplementation(() => {});
    adminLog({
      requestId: "abc12345",
      action: "test.action",
      path: "/api/admin/test",
      role: "superadmin",
      outcome: "ok",
      ms: 12,
    });
    expect(spy).toHaveBeenCalledTimes(1);
    const payload = JSON.parse(String(spy.mock.calls[0][0]));
    expect(payload.scope).toBe("admin");
    expect(payload.action).toBe("test.action");
    expect(payload.requestId).toBe("abc12345");
    expect(payload.outcome).toBe("ok");
    spy.mockRestore();
  });

  it("uses console.error for failures", () => {
    const spy = vi.spyOn(console, "error").mockImplementation(() => {});
    adminLog({
      action: "test.fail",
      outcome: "error",
      error: "boom",
    });
    expect(spy).toHaveBeenCalledTimes(1);
    const payload = JSON.parse(String(spy.mock.calls[0][0]));
    expect(payload.error).toBe("boom");
    spy.mockRestore();
  });
});
