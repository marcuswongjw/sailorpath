import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({ auth: vi.fn(), log: vi.fn() }));
vi.mock("@/lib/auth", () => ({ getAuthContext: mocks.auth }));
vi.mock("@/lib/adminChangeLog", () => ({ logAdminChange: mocks.log }));
import { withUserChangeTracking } from "./userChanges";

describe("user change tracking", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    mocks.auth.mockResolvedValue({ userId: "parent-1", email: "parent@example.com", role: "parent" });
    mocks.log.mockResolvedValue({ ok: true });
  });

  it("preserves the request and response while recording identity and safe metadata", async () => {
    const handler = withUserChangeTracking("parent_notes", async (request) => {
      expect((await request.json()).body).toBe("private family note");
      return Response.json({ note: { id: "note-1" } }, { status: 201 });
    });
    const response = await handler(new Request("https://sailorpath.com/api/account/parent-notes", {
      method: "POST", body: JSON.stringify({ sailorId: "sailor-1", body: "private family note", password: "secret", token: "secret" }),
    }));
    expect(response.status).toBe(201);
    expect(await response.json()).toEqual({ note: { id: "note-1" } });
    expect(mocks.log).toHaveBeenCalledWith(expect.objectContaining({
      actorUserId: "parent-1", actorEmail: "parent@example.com", action: "user.parent_notes.saved",
      details: { actorRole: "parent", submittedFields: ["sailorId"], identifiers: { id: "note-1", sailorId: "sailor-1" } },
    }));
    expect(JSON.stringify(mocks.log.mock.calls)).not.toContain("private family note");
    expect(JSON.stringify(mocks.log.mock.calls)).not.toContain("secret");
  });

  it.each([400, 401, 403, 500])("does not log a failed write (%s)", async (status) => {
    const response = await withUserChangeTracking("results", async () => Response.json({ error: "failed" }, { status }))(
      new Request("https://sailorpath.com/api/account/results", { method: "POST", body: "{}" })
    );
    expect(response.status).toBe(status);
    expect(mocks.log).not.toHaveBeenCalled();
  });

  it.each([null, { userId: "admin", role: "superadmin" }])("excludes anonymous and admin requests", async (auth) => {
    mocks.auth.mockResolvedValue(auth);
    await withUserChangeTracking("results", async () => Response.json({ ok: true }))(
      new Request("https://sailorpath.com/api/account/results", { method: "POST", body: "{}" })
    );
    expect(mocks.log).not.toHaveBeenCalled();
  });

  it("does not log an already-existing follow", async () => {
    await withUserChangeTracking("following", async () => Response.json({ alreadyFollowing: true }))(
      new Request("https://sailorpath.com/api/following", { method: "POST", body: "{}" })
    );
    expect(mocks.log).not.toHaveBeenCalled();
  });

  it("records deleted identifiers from query parameters", async () => {
    await withUserChangeTracking("results", async () => Response.json({ ok: true }))(
      new Request("https://sailorpath.com/api/account/results?id=11111111-1111-4111-8111-111111111111", { method: "DELETE" })
    );
    expect(mocks.log).toHaveBeenCalledWith(expect.objectContaining({ action: "user.results.deleted", entityId: "11111111-1111-4111-8111-111111111111" }));
  });

  it("records bulk target IDs without copying arbitrary array content", async () => {
    const sailorId = "11111111-1111-4111-8111-111111111111";
    await withUserChangeTracking("coach_squad", async () => Response.json({ ok: true }))(
      new Request(`https://sailorpath.com/api/coach/squad?sailorIds=${sailorId},private-text`, { method: "DELETE" })
    );
    expect(mocks.log).toHaveBeenCalledWith(expect.objectContaining({
      details: expect.objectContaining({ identifiers: { sailorIds: [sailorId] } }),
    }));
  });

  it("keeps a successful write successful when audit storage fails", async () => {
    mocks.log.mockRejectedValueOnce(new Error("database unavailable"));
    const warning = vi.spyOn(console, "warn").mockImplementation(() => {});
    try {
      const response = await withUserChangeTracking("results", async () => Response.json({ ok: true }))(
        new Request("https://sailorpath.com/api/account/results", { method: "POST", body: "{}" })
      );
      expect(response.status).toBe(200);
    } finally { warning.mockRestore(); }
  });
});
