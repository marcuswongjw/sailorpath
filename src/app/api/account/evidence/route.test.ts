import { beforeEach, describe, expect, it, vi } from "vitest";
const mocks = vi.hoisted(() => ({ auth: vi.fn(), download: vi.fn() }));
vi.mock("@/lib/auth", () => ({ getAuthContext: mocks.auth }));
vi.mock("@/lib/supabase/server", () => ({ createServerSupabase: async () => ({ storage: { from: () => ({ download: mocks.download }) } }) }));
import { GET } from "./route";
const path = "11111111-1111-4111-8111-111111111111/123_results.pdf";
const request = (value = path) => new Request(`https://sailorpath.com/api/account/evidence?path=${encodeURIComponent(value)}`);
describe("authenticated evidence reader", () => {
  beforeEach(() => {
    mocks.auth.mockReset().mockResolvedValue({ userId: path.split("/")[0], role: "sailor" });
    mocks.download.mockReset().mockResolvedValue({ data: new Blob(["%PDF fixture"], { type: "application/pdf" }), error: null });
  });
  it("rejects signed-out requests without accessing storage", async () => {
    mocks.auth.mockResolvedValue(null);
    const response = await GET(request());
    expect(response.status).toBe(401);
    expect(response.headers.get("Cache-Control")).toBe("private, no-store");
    expect(mocks.download).not.toHaveBeenCalled();
  });
  it("rejects malformed paths before storage access", async () => {
    expect((await GET(request("../other"))).status).toBe(400);
    expect(mocks.download).not.toHaveBeenCalled();
  });
  it("does not bypass a storage RLS denial", async () => {
    mocks.download.mockResolvedValue({ data: null, error: { message: "RLS denied" } });
    const response = await GET(request());
    expect(response.status).toBe(404);
    expect(await response.text()).not.toContain("RLS");
  });
  it("rejects another user's key even before the storage policy is applied", async () => {
    mocks.auth.mockResolvedValue({ userId: "22222222-2222-4222-8222-222222222222", role: "parent" });
    expect((await GET(request())).status).toBe(404);
    expect(mocks.download).not.toHaveBeenCalled();
  });
  it("allows a superadmin reviewer through the user's storage session", async () => {
    mocks.auth.mockResolvedValue({ userId: "admin", role: "superadmin" });
    expect((await GET(request())).status).toBe(200);
    expect(mocks.download).toHaveBeenCalledWith(path);
  });
  it("serves an authorized file privately as a download", async () => {
    const response = await GET(request());
    expect(response.status).toBe(200);
    expect(mocks.download).toHaveBeenCalledWith(path);
    expect(response.headers.get("Cache-Control")).toBe("private, no-store");
    expect(response.headers.get("Content-Disposition")).toContain("attachment");
    expect(await response.text()).toBe("%PDF fixture");
  });
});
