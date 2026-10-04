import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
const mocks = vi.hoisted(() => ({ authorize: vi.fn(), getStats: vi.fn() }));
vi.mock("@/db", () => ({ pgSql: vi.fn() }));
vi.mock("@/lib/auth", () => ({
  requireSuperadmin: mocks.authorize,
  jsonError: () => Response.json({ error: "Forbidden" }, { status: 403 }),
}));
vi.mock("@/lib/adminStats", async (importOriginal) => ({
  ...await importOriginal<typeof import("@/lib/adminStats")>(),
  getAdminStats: mocks.getStats,
}));
import { GET } from "./route";

beforeEach(() => {
  mocks.authorize.mockReset().mockResolvedValue({ role: "superadmin" });
  mocks.getStats.mockReset().mockResolvedValue({ generatedAt: "2026-10-04" });
  vi.spyOn(console, "error").mockImplementation(() => {});
});
afterEach(() => { vi.useRealTimers(); vi.restoreAllMocks(); });

describe("admin Stats endpoint", () => {
  it("returns private stats without browser HTTP caching", async () => {
    const response = await GET();
    expect(response.status).toBe(200);
    expect(response.headers.get("cache-control")).toBe("private, no-store");
  });
  it("does not compute stats for an unauthorized account", async () => {
    mocks.authorize.mockRejectedValue(new Error("Forbidden"));
    expect((await GET()).status).toBe(403);
    expect(mocks.getStats).not.toHaveBeenCalled();
  });
  it("returns a retryable error when authorization stalls", async () => {
    vi.useFakeTimers();
    mocks.authorize.mockReturnValue(new Promise(() => {}));
    const response = GET();
    await vi.advanceTimersByTimeAsync(4_000);
    expect((await response).status).toBe(503);
    expect(mocks.getStats).not.toHaveBeenCalled();
  });
});
