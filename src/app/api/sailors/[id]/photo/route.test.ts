import { beforeEach, describe, expect, it, vi } from "vitest";
const m = vi.hoisted(() => ({ load: vi.fn(), auth: vi.fn(), manage: vi.fn(), read: vi.fn(), download: vi.fn() }));
vi.mock("@/db", () => ({ db: { select: () => ({ from: () => ({ where: () => ({ limit: m.load }) }) }) } }));
vi.mock("@/lib/auth", () => ({ getAuthContext: m.auth }));
vi.mock("@/lib/claimAccess", () => ({ canManageSailor: m.manage }));
vi.mock("node:fs/promises", () => ({ readFile: m.read }));
vi.mock("@/lib/supabase/server", () => ({ createServerSupabase: async () => ({ storage: { from: () => ({ download: m.download }) } }) }));
import { GET } from "./route";
const id = "11111111-1111-4111-8111-111111111111";
const call = (value = id) => GET(new Request(`https://sailorpath.com/api/sailors/${value}/photo`), { params: Promise.resolve({ id: value }) });
beforeEach(() => {
  vi.clearAllMocks();
  m.load.mockResolvedValue([{ avatarUrl: "https://sailorpath.com/athlete-portraits/team-singapore/example.jpg", isPublic: false, parentId: "parent" }]);
  m.auth.mockResolvedValue(null); m.manage.mockResolvedValue(false);
  m.read.mockResolvedValue(Buffer.from("photo"));
});
describe("consent checked photo reader", () => {
  it("denies anonymous and unrelated users without reading originals", async () => {
    expect((await call()).status).toBe(404);
    m.auth.mockResolvedValue({ userId: "other", role: "parent" });
    expect((await call()).status).toBe(404);
    expect(m.read).not.toHaveBeenCalled(); expect(m.download).not.toHaveBeenCalled();
  });
  it("allows approved owners and admins to view private originals without caching", async () => {
    m.auth.mockResolvedValue({ userId: "parent", role: "parent" }); m.manage.mockResolvedValue(true);
    const response = await call();
    expect(response.status).toBe(200); expect(await response.text()).toBe("photo");
    expect(response.headers.get("Cache-Control")).toContain("no-store");
    expect(response.headers.get("Vary")).toBe("Cookie");
  });
  it("checks current publication for each request and immediately denies after hiding", async () => {
    m.load.mockResolvedValueOnce([{ avatarUrl: "https://sailorpath.com/athlete-portraits/team-singapore/example.jpg", isPublic: true }]);
    expect((await call()).status).toBe(200);
    expect((await call()).status).toBe(404);
    expect(m.read).toHaveBeenCalledTimes(1);
  });
  it("downloads private storage using the request session and RLS", async () => {
    vi.stubEnv("NEXT_PUBLIC_SUPABASE_URL", "https://project.supabase.co");
    m.load.mockResolvedValue([{ avatarUrl: `https://project.supabase.co/storage/v1/object/public/avatars/${id}/1.jpg`, isPublic: true }]);
    m.download.mockResolvedValue({ data: new Blob(["photo"], { type: "image/jpeg" }), error: null });
    expect((await call()).status).toBe(200);
    expect(m.download).toHaveBeenCalledWith(`${id}/1.jpg`);
    m.download.mockResolvedValue({ data: null, error: new Error("RLS denial") });
    expect((await call()).status).toBe(404);
    vi.unstubAllEnvs();
  });
  it("does not fetch arbitrary external URLs or accept invalid IDs", async () => {
    expect((await call("invalid")).status).toBe(404); expect(m.load).not.toHaveBeenCalled();
    m.load.mockResolvedValue([{ avatarUrl: "https://internal.test/private", isPublic: true }]);
    expect((await call()).status).toBe(404); expect(m.read).not.toHaveBeenCalled(); expect(m.download).not.toHaveBeenCalled();
  });
});
