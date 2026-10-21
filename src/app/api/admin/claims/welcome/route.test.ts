import { beforeEach, describe, expect, it, vi } from "vitest";
const mocks = vi.hoisted(() => ({ auth: vi.fn(), row: null as Record<string, unknown> | null, send: vi.fn(), audit: vi.fn() }));
vi.mock("@/lib/auth", () => ({ requireSuperadmin: mocks.auth,
  jsonError: () => Response.json({ error: "Forbidden" }, { status: 403 }) }));
vi.mock("@/lib/adminChangeLog", () => ({ logAdminChange: mocks.audit }));
vi.mock("@/lib/roleChangeNotify", () => ({
  notifyAccountRoleChange: mocks.send,
  buildAccountRoleChangeEmail: (input: { name: string }) => ({ subject: "Welcome", text: `Hi ${input.name},` }),
}));
vi.mock("@/db", () => ({ db: { select: () => {
  const query = { from: () => query, innerJoin: () => query, where: () => query,
    limit: async () => mocks.row ? [mocks.row] : [] };
  return query;
} } }));
import { GET, POST } from "./route";
const id = "e260faa1-7d21-457f-a39b-b149b4e1bf8b";
const url = `https://admin.sailorpath.com/api/admin/claims/welcome?claimId=${id}`;
function post(origin = "https://admin.sailorpath.com", claimId = id) {
  return new Request(url, { method: "POST", headers: { origin },
    body: new URLSearchParams({ claimId, to: "injected@example.com" }) });
}
beforeEach(() => {
  vi.clearAllMocks();
  mocks.auth.mockResolvedValue({ userId: "admin-1", email: "admin@example.com" });
  mocks.row = { id, status: "approved", relation: "parent", sailorName: "Test Sailor",
    userId: "parent-1", name: "Test Parent", email: "parent@example.com", role: "parent" };
  mocks.send.mockResolvedValue("sent"); mocks.audit.mockResolvedValue({ ok: true });
});
describe("approved claim welcome action", () => {
  it("previews the actual account and sends nothing on GET", async () => {
    const response = await GET(new Request(url));
    expect(response.status).toBe(200);
    expect(await response.text()).toContain("parent@example.com");
    expect(response.headers.get("cache-control")).toContain("no-store");
    expect(mocks.send).not.toHaveBeenCalled();
  });
  it("sends only to the stored approved account with the existing duplicate key", async () => {
    const response = await POST(post());
    expect(response.status).toBe(200);
    expect(mocks.send).toHaveBeenCalledWith(expect.objectContaining({
      to: "parent@example.com", name: "Test Parent", nextRole: "parent",
      sailorName: "Test Sailor", eventId: `claim/${id}/parent`,
    }));
    expect(mocks.audit).toHaveBeenCalledWith(expect.objectContaining({ actorUserId: "admin-1",
      entityId: id, action: "claim.welcome_email" }));
    expect(await response.text()).toContain("accepted the welcome email");
  });
  it("requires administrator access", async () => {
    mocks.auth.mockRejectedValue(new Error("Forbidden"));
    expect((await POST(post())).status).toBe(403);
    expect(mocks.send).not.toHaveBeenCalled();
  });
  it("rejects cross-site requests", async () => {
    expect((await POST(post("https://example.com"))).status).toBe(403);
    expect(mocks.send).not.toHaveBeenCalled();
  });
  it.each(["pending", "rejected"])("does not send for a %s claim", async status => {
    mocks.row!.status = status;
    expect((await POST(post())).status).toBe(409);
    expect(mocks.send).not.toHaveBeenCalled();
  });
  it("rechecks the current relation and missing claims", async () => {
    mocks.row!.relation = "other";
    expect((await POST(post())).status).toBe(409);
    mocks.row = null;
    expect((await POST(post())).status).toBe(404);
    expect(mocks.send).not.toHaveBeenCalled();
  });
  it("rejects invalid claim IDs", async () => {
    expect((await POST(post("https://admin.sailorpath.com", "bad-id"))).status).toBe(400);
    expect(mocks.send).not.toHaveBeenCalled();
  });
  it("reports delivery failure without claiming success", async () => {
    mocks.send.mockResolvedValue("failed");
    const response = await POST(post());
    expect(response.status).toBe(503);
    expect(await response.text()).not.toContain("Welcome email sent");
  });
});
