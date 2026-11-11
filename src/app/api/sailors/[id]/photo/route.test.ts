import { beforeEach, describe, expect, it, vi } from "vitest";
const m = vi.hoisted(() => ({ load: vi.fn(), read: vi.fn(), download: vi.fn() }));
vi.mock("@/db", () => ({ db: { select: () => ({ from: () => ({ where: () => ({ limit: m.load }) }) }) } }));
vi.mock("node:fs/promises", () => ({ readFile: m.read }));
vi.mock("@/lib/supabase/server", () => ({ createServerSupabase: async () => ({ storage: { from: () => ({ download: m.download }) } }) }));
import { GET } from "./route";
const id = "11111111-1111-4111-8111-111111111111";
const call = (value = id) => GET(new Request(`https://sailorpath.com/api/sailors/${value}/photo`), { params: Promise.resolve({ id: value }) });
beforeEach(() => {
  vi.clearAllMocks();
  m.load.mockResolvedValue([{ avatarUrl: "https://sailorpath.com/athlete-portraits/team-singapore/example.jpg" }]);
  m.read.mockResolvedValue(Buffer.from("photo"));
});
describe("public profile photo reader", () => {
  it("serves bundled portraits publicly without caching", async () => {
    const response = await call();
    expect(response.status).toBe(200);
    expect(await response.text()).toBe("photo");
    expect(response.headers.get("Cache-Control")).toContain("no-store");
  });
  it("checks current avatar presence for each request and immediately denies after removal", async () => {
    m.load.mockResolvedValueOnce([{ avatarUrl: "https://sailorpath.com/athlete-portraits/team-singapore/example.jpg" }]);
    m.load.mockResolvedValueOnce([{ avatarUrl: null }]);
    expect((await call()).status).toBe(200);
    expect((await call()).status).toBe(404);
    expect(m.read).toHaveBeenCalledTimes(1);
    expect(m.download).not.toHaveBeenCalled();
  });
  it("downloads storage avatars using the request session and RLS", async () => {
    vi.stubEnv("NEXT_PUBLIC_SUPABASE_URL", "https://project.supabase.co");
    m.load.mockResolvedValue([{ avatarUrl: `https://project.supabase.co/storage/v1/object/public/avatars/${id}/1.jpg` }]);
    m.download.mockResolvedValue({ data: new Blob(["photo"], { type: "image/jpeg" }), error: null });
    expect((await call()).status).toBe(200);
    expect(m.download).toHaveBeenCalledWith(`${id}/1.jpg`);
    m.download.mockResolvedValue({ data: null, error: new Error("RLS denial") });
    expect((await call()).status).toBe(404);
    vi.unstubAllEnvs();
  });
  it("does not fetch arbitrary external URLs or accept invalid IDs", async () => {
    expect((await call("invalid")).status).toBe(404); expect(m.load).not.toHaveBeenCalled();
    m.load.mockResolvedValue([{ avatarUrl: "https://internal.test/private" }]);
    expect((await call()).status).toBe(404); expect(m.read).not.toHaveBeenCalled(); expect(m.download).not.toHaveBeenCalled();
  });
});
