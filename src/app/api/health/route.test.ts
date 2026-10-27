import { beforeEach, describe, expect, it, vi } from "vitest";
const mocks = vi.hoisted(() => ({ auth: vi.fn(), query: vi.fn() }));
vi.mock("@/lib/auth", () => ({ getAuthContext: mocks.auth }));
vi.mock("@/db", () => ({ pgSql: mocks.query, getDatabaseUrlMeta: () => null, ensureCoreSchema: vi.fn() }));
import { GET } from "./route";
beforeEach(() => { vi.clearAllMocks(); mocks.auth.mockResolvedValue(null); });
describe("health check database budget", () => {
  it("serves repeated anonymous liveness checks without authentication or database reads", async () => {
    for (let i = 0; i < 3; i++) {
      const response = await GET(new Request("https://sailorpath.com/api/health"));
      expect(await response.json()).toEqual({ ok: true, mode: "live", check: "liveness" });
    }
    expect(mocks.auth).not.toHaveBeenCalled(); expect(mocks.query).not.toHaveBeenCalled();
  });
  it.each([null, { role: "parent" }])("denies non-admin diagnostics before any database diagnostic", async (auth) => {
    mocks.auth.mockResolvedValue(auth);
    const response = await GET(new Request("https://sailorpath.com/api/health?diagnostics=1"));
    expect(response.status).toBe(auth ? 403 : 401);
    expect(mocks.query).not.toHaveBeenCalled();
    expect(response.headers.get("Cache-Control")).toBe("private, no-store");
  });
  it("preserves superadmin diagnostics and prevents response caching", async () => {
    vi.stubEnv("DATABASE_URL", ""); vi.stubEnv("POSTGRES_URL", ""); vi.stubEnv("POSTGRES_PRISMA_URL", "");
    mocks.auth.mockResolvedValue({ role: "superadmin" });
    const response = await GET(new Request("https://sailorpath.com/api/health?diagnostics=1"));
    expect(response.status).toBe(200); expect(await response.json()).toHaveProperty("database");
    expect(response.headers.get("Cache-Control")).toBe("private, no-store");
    vi.unstubAllEnvs();
  });
});
