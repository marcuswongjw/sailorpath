import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  requireSuperadmin: vi.fn(),
  updateSet: vi.fn(),
  insertValues: vi.fn(),
  mockUser: {
    id: "user-123",
    fullName: "Alex Tan",
    email: "alex@example.com",
    role: "sailor",
  },
  existingReq: null as { id: string } | null,
  requestRow: null as {
    requesterId: string;
    requesterName: string | null;
    requesterEmail: string;
    requesterRole: string;
  } | null,
  notifyAccountRoleChange: vi.fn(),
  notifyCoachInvite: vi.fn(),
}));

vi.mock("@/lib/auth", () => ({
  requireSuperadmin: mocks.requireSuperadmin,
  jsonError: (error: unknown) => {
    const message = error instanceof Error ? error.message : "Error";
    return Response.json({ error: message }, { status: 400 });
  },
}));

vi.mock("@/lib/adminChangeLog", () => ({
  logAdminChange: vi.fn().mockResolvedValue(undefined),
}));

vi.mock("@/lib/roleChangeNotify", () => ({
  notifyAccountRoleChange: mocks.notifyAccountRoleChange,
}));

vi.mock("@/lib/coachInviteNotify", () => ({
  notifyCoachInvite: mocks.notifyCoachInvite,
}));

vi.mock("@/db", () => ({
  db: {
    select: () => ({
      from: () => ({
        where: () => ({
          orderBy: () => Promise.resolve([]),
          limit: vi.fn().mockImplementation(() => {
            return Promise.resolve(mocks.mockUser ? [mocks.mockUser] : []);
          }),
        }),
        innerJoin: () => ({
          orderBy: () => Promise.resolve([]),
        }),
      }),
    }),
    transaction: async (cb: (tx: unknown) => Promise<unknown>) => {
      const tx = {
        update: () => ({
          set: (vals: unknown) => {
            mocks.updateSet(vals);
            return {
              where: () => Promise.resolve([]),
            };
          },
        }),
        select: () => ({
          from: () => ({
            where: () => ({
              limit: vi.fn().mockImplementation(() => {
                return Promise.resolve(mocks.existingReq ? [mocks.existingReq] : []);
              }),
            }),
            innerJoin: () => ({
              where: () => ({
                limit: vi.fn().mockImplementation(() => {
                  return Promise.resolve(mocks.requestRow ? [mocks.requestRow] : []);
                }),
              }),
            }),
          }),
        }),
        insert: () => ({
          values: (vals: unknown) => {
            mocks.insertValues(vals);
            return Promise.resolve([]);
          },
        }),
      };
      return cb(tx);
    },
  },
}));

import { GET, PATCH, POST } from "./route";

describe("/api/admin/coach-access", () => {
  beforeEach(() => {
    mocks.requireSuperadmin.mockReset();
    mocks.updateSet.mockReset();
    mocks.insertValues.mockReset();
    mocks.mockUser = {
      id: "user-123",
      fullName: "Alex Tan",
      email: "alex@example.com",
      role: "sailor",
    };
    mocks.existingReq = null;
    mocks.requestRow = null;
    mocks.notifyAccountRoleChange.mockReset();
    mocks.notifyAccountRoleChange.mockResolvedValue("sent");
    mocks.notifyCoachInvite.mockReset();
    mocks.notifyCoachInvite.mockResolvedValue("sent");
    mocks.requireSuperadmin.mockResolvedValue({
      userId: "admin-1",
      email: "admin@example.com",
      role: "superadmin",
    });
  });

  describe("GET", () => {
    it("returns requests and coaches", async () => {
      const res = await GET();
      expect(res.status).toBe(200);
      const data = await res.json();
      expect(data).toHaveProperty("requests");
      expect(data).toHaveProperty("coaches");
    });
  });

  describe("POST direct assign", () => {
    it("emails an invitation instead of granting coach immediately", async () => {
      const req = new Request("https://sailorpath.com/api/admin/coach-access", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({
          userId: "user-123",
          action: "assign",
        }),
      });

      const res = await POST(req);
      expect(res.status).toBe(200);
      const data = await res.json();
      expect(data.ok).toBe(true);
      expect(data.invited).toBe(true);
      expect(data.user.role).toBe("sailor");

      const roleUpdates = mocks.updateSet.mock.calls.filter(
        (args) => (args[0] as Record<string, unknown>)?.role === "coach"
      );
      expect(roleUpdates).toHaveLength(0);
      expect(mocks.insertValues).toHaveBeenCalledWith(
        expect.objectContaining({
          requesterId: "user-123",
          status: "pending",
          source: "admin",
        })
      );
      expect(mocks.notifyCoachInvite).toHaveBeenCalledWith(
        expect.objectContaining({
          to: "alex@example.com",
          name: "Alex Tan",
          token: expect.any(String),
        })
      );
      expect(mocks.notifyAccountRoleChange).not.toHaveBeenCalled();
    });

    it("revokes coach role when action is revoke", async () => {
      mocks.mockUser.role = "coach";
      mocks.existingReq = { id: "req-1" };

      const req = new Request("https://sailorpath.com/api/admin/coach-access", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({
          userId: "user-123",
          action: "revoke",
        }),
      });

      const res = await POST(req);
      expect(res.status).toBe(200);
      const data = await res.json();
      expect(data.ok).toBe(true);
      expect(data.user.role).toBe("sailor");

      expect(mocks.updateSet).toHaveBeenCalledWith(
        expect.objectContaining({ role: "sailor" })
      );
      expect(mocks.updateSet).toHaveBeenCalledWith(
        expect.objectContaining({ status: "rejected" })
      );
      expect(mocks.notifyAccountRoleChange).toHaveBeenCalledWith(
        expect.objectContaining({
          to: "alex@example.com",
          previousRole: "coach",
          nextRole: "sailor",
        })
      );
    });

    it("does not email when the account is already a coach", async () => {
      mocks.mockUser.role = "coach";

      const req = new Request("https://sailorpath.com/api/admin/coach-access", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({
          userId: "user-123",
          action: "assign",
        }),
      });

      const res = await POST(req);
      expect(res.status).toBe(200);
      const data = await res.json();
      expect(data.alreadyCoach).toBe(true);
      expect(mocks.notifyAccountRoleChange).not.toHaveBeenCalled();
      expect(mocks.notifyCoachInvite).not.toHaveBeenCalled();
    });

    it("rejects modifying a superadmin", async () => {
      mocks.mockUser.role = "superadmin";

      const req = new Request("https://sailorpath.com/api/admin/coach-access", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({
          userId: "user-123",
          action: "assign",
        }),
      });

      const res = await POST(req);
      expect(res.status).toBe(400);
      const data = await res.json();
      expect(data.error).toContain("superadmin");
      expect(mocks.notifyAccountRoleChange).not.toHaveBeenCalled();
    });
  });

  describe("PATCH review", () => {
    it("emails when a sailor request is approved", async () => {
      mocks.requestRow = {
        requesterId: "user-123",
        requesterName: "Alex Tan",
        requesterEmail: "alex@example.com",
        requesterRole: "sailor",
      };

      const req = new Request("https://sailorpath.com/api/admin/coach-access", {
        method: "PATCH",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ id: "req-1", action: "approve" }),
      });

      const res = await PATCH(req);
      expect(res.status).toBe(200);
      expect(mocks.notifyAccountRoleChange).toHaveBeenCalledWith(
        expect.objectContaining({
          to: "alex@example.com",
          previousRole: "sailor",
          nextRole: "coach",
          relation: "coach",
        })
      );
    });

    it("does not email a rejection or an account that is already a coach", async () => {
      mocks.requestRow = {
        requesterId: "user-123",
        requesterName: "Alex Tan",
        requesterEmail: "alex@example.com",
        requesterRole: "coach",
      };

      const reject = new Request("https://sailorpath.com/api/admin/coach-access", {
        method: "PATCH",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ id: "req-1", action: "reject" }),
      });
      expect((await PATCH(reject)).status).toBe(200);

      const approve = new Request("https://sailorpath.com/api/admin/coach-access", {
        method: "PATCH",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ id: "req-1", action: "approve" }),
      });
      expect((await PATCH(approve)).status).toBe(200);
      expect(mocks.notifyAccountRoleChange).not.toHaveBeenCalled();
    });
  });
});
