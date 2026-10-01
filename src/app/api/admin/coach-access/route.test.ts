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

import { GET, POST } from "./route";

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
    it("assigns user as coach when action is assign", async () => {
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
      expect(data.user.role).toBe("coach");

      // Verify profile update to coach
      expect(mocks.updateSet).toHaveBeenCalledWith(
        expect.objectContaining({ role: "coach" })
      );
      // Verify coach access request was inserted
      expect(mocks.insertValues).toHaveBeenCalledWith(
        expect.objectContaining({
          requesterId: "user-123",
          status: "approved",
        })
      );
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
    });
  });
});
