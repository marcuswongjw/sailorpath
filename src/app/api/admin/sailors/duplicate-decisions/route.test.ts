import { beforeEach, describe, expect, it, vi } from "vitest";
const mocks = vi.hoisted(() => ({ auth: vi.fn(), list: vi.fn(), save: vi.fn() }));
vi.mock("@/lib/auth", () => ({ requireSuperadmin: mocks.auth, jsonError: (e: Error) => Response.json({ error: e.message }, { status: 403 }) }));
vi.mock("@/lib/sailorDuplicateDecisionStore", () => ({ getSeparateSailorPairs: mocks.list, saveSailorDuplicateDecision: mocks.save }));
import { GET, POST } from "./route";
const a = "11111111-1111-4111-8111-111111111111";
const b = "22222222-2222-4222-8222-222222222222";
const request = (body: unknown) => new Request("https://admin.example/api/admin/sailors/duplicate-decisions", { method: "POST", body: JSON.stringify(body) });
beforeEach(() => { vi.clearAllMocks(); mocks.auth.mockResolvedValue({ userId: a, email: "admin@example.test" }); mocks.list.mockResolvedValue([]); });
describe("duplicate identity decisions", () => {
  it("requires superadmin access for reads and writes", async () => {
    mocks.auth.mockRejectedValue(new Error("Forbidden"));
    expect((await GET()).status).toBe(403);
    expect((await POST(request({}))).status).toBe(403);
    expect(mocks.list).not.toHaveBeenCalled(); expect(mocks.save).not.toHaveBeenCalled();
  });
  it.each([{ aId: a, bId: a, separate: true, reason: "Verified separate people." },
    { aId: a, bId: b, separate: true, reason: "short" },
    { aId: a, bId: b, separate: "true", reason: "Verified separate people." }])("rejects invalid decisions", async body => {
    expect((await POST(request(body))).status).toBe(400);
    expect(mocks.save).not.toHaveBeenCalled();
  });
  it("saves an explicit pair and attributed evidence, and allows an audited reopen", async () => {
    for (const separate of [true, false]) {
      expect((await POST(request({ aId: b, bId: a, separate, reason: "Official evidence reviewed by administrator." }))).status).toBe(200);
      expect(mocks.save).toHaveBeenLastCalledWith({ aId: b, bId: a, separate,
        reason: "Official evidence reviewed by administrator.", actor: { userId: a, email: "admin@example.test" } });
    }
    expect((await GET()).headers.get("Cache-Control")).toBe("no-store");
  });
});
