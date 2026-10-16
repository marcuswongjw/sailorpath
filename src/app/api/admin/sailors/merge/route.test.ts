import { beforeEach, describe, expect, it, vi } from "vitest";
const mocks = vi.hoisted(() => ({ auth: vi.fn(), plan: vi.fn(), merge: vi.fn() }));
vi.mock("@/lib/auth", () => ({ requireSuperadmin: mocks.auth, jsonError: (e: Error) => Response.json({ error: e.message }, { status: 403 }) }));
vi.mock("@/lib/sailorMergePlan", () => ({ getSailorMergePlan: mocks.plan }));
vi.mock("@/lib/mergeSailors", () => ({ mergeSailors: mocks.merge, SailorMergeError: class extends Error {} }));
vi.mock("@/lib/revalidatePublic", () => ({ revalidatePublicRankings: vi.fn() }));
vi.mock("@/lib/adminLog", () => ({ adminLog: vi.fn(), createAdminRequestId: () => "test" }));
vi.mock("@/lib/adminChangeLog", () => ({ logAdminChange: vi.fn() }));
import { GET, POST } from "./route";
import { POST as oldBulkMerge } from "../bulk-merge-high-similarity/route";
const a = "11111111-1111-4111-8111-111111111111";
const b = "22222222-2222-4222-8222-222222222222";
beforeEach(() => { vi.clearAllMocks(); mocks.auth.mockResolvedValue({ userId: a, role: "superadmin" }); });
describe("explicit merge review endpoints", () => {
  it("requires superadmin authorization before returning profile plans", async () => {
    mocks.auth.mockRejectedValue(new Error("Forbidden"));
    expect((await GET(new Request(`https://admin.example/api/admin/sailors/merge?keepId=${a}&mergeId=${b}`))).status).toBe(403);
    expect(mocks.plan).not.toHaveBeenCalled();
  });
  it("returns a non-cached review of the explicit directed pair without merging", async () => {
    mocks.plan.mockResolvedValue({ keep: { id: b }, source: { id: a }, reviewToken: "snapshot" });
    const res = await GET(new Request(`https://admin.example/api/admin/sailors/merge?keepId=${b}&mergeId=${a}`));
    expect(res.headers.get("Cache-Control")).toBe("no-store");
    expect(mocks.plan).toHaveBeenCalledWith(b, a);
    expect(mocks.merge).not.toHaveBeenCalled();
  });
  it("retires name-based bulk merging without forwarding any mutation", async () => {
    const res = await oldBulkMerge();
    expect(res.status).toBe(409);
    expect(mocks.merge).not.toHaveBeenCalled();
    expect(mocks.plan).not.toHaveBeenCalled();
  });
  it("rejects invalid IDs before invoking the mutation service", async () => {
    const res = await POST(new Request("https://admin.example/api/admin/sailors/merge", { method: "POST", body: JSON.stringify({ keepId: "invalid", mergeId: b }) }));
    expect(res.status).toBe(400);
    expect(mocks.merge).not.toHaveBeenCalled();
  });
});
