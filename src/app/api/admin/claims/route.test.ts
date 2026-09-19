import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  requireSuperadmin: vi.fn(),
  updateSet: vi.fn(),
  profileRole: "coach",
}));

vi.mock("@/lib/auth", () => ({
  requireSuperadmin: mocks.requireSuperadmin,
  jsonError: (error: unknown) => {
    const message = error instanceof Error ? error.message : "Error";
    return Response.json({ error: message }, { status: 400 });
  },
}));

vi.mock("@/db", () => ({
  db: {
    select: () => ({
      from: () => ({
        where: () => ({
          limit: vi.fn().mockImplementation(() => {
            return Promise.resolve([
              {
                id: "claim-1",
                requesterId: "user-coach",
                sailorId: "s-1",
                status: "pending",
                relation: "parent",
                role: mocks.profileRole,
              },
            ]);
          }),
        }),
      }),
    }),
    update: () => ({
      set: (vals: unknown) => {
        mocks.updateSet(vals);
        return {
          where: () => ({
            returning: vi.fn().mockResolvedValue([
              {
                id: "claim-1",
                requesterId: "user-coach",
                sailorId: "s-1",
                status: "approved",
                relation: "parent",
              },
            ]),
            then: (resolve: (v: unknown) => unknown) =>
              Promise.resolve([]).then(resolve),
          }),
        };
      },
    }),
  },
}));

vi.mock("@/lib/adminChangeLog", () => ({
  logAdminChange: vi.fn().mockResolvedValue(undefined),
}));

vi.mock("next/cache", () => ({
  revalidatePath: vi.fn(),
}));

import { PATCH } from "./route";

describe("PATCH /api/admin/claims", () => {
  beforeEach(() => {
    mocks.requireSuperadmin.mockReset();
    mocks.updateSet.mockReset();
    mocks.profileRole = "coach";
    mocks.requireSuperadmin.mockResolvedValue({
      userId: "admin-1",
      email: "admin@example.com",
      role: "superadmin",
    });
  });

  it("does not demote coach profile when claim is approved", async () => {
    const req = new Request("https://sailorpath.com/api/admin/claims", {
      method: "PATCH",
      headers: { "content-type": "application/json" },
      body: JSON.stringify({
        id: "claim-1",
        status: "approved",
        relation: "parent",
        setAccountRole: true,
      }),
    });

    const res = await PATCH(req);
    expect(res.status).toBe(200);

    // Verify update was never called on profiles with { role: "parent" }
    const roleUpdates = mocks.updateSet.mock.calls.filter(
      (args) => (args[0] as Record<string, unknown>)?.role === "parent"
    );
    expect(roleUpdates).toHaveLength(0);
  });

  it("updates role when requester is a standard sailor", async () => {
    mocks.profileRole = "sailor";

    const req = new Request("https://sailorpath.com/api/admin/claims", {
      method: "PATCH",
      headers: { "content-type": "application/json" },
      body: JSON.stringify({
        id: "claim-1",
        status: "approved",
        relation: "parent",
        setAccountRole: true,
      }),
    });

    const res = await PATCH(req);
    expect(res.status).toBe(200);

    const roleUpdates = mocks.updateSet.mock.calls.filter(
      (args) => (args[0] as Record<string, unknown>)?.role === "parent"
    );
    expect(roleUpdates).toHaveLength(1);
  });
});
