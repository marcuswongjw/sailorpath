import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  getAuthContext: vi.fn(),
  updateSet: vi.fn(),
  claim: {
    id: "claim-1",
    sailorId: "s-1",
    requesterId: "user-1",
    status: "pending" as string,
    source: "admin" as string,
    relation: "parent",
    parentId: null as string | null,
    name: "Ava Tan",
    role: "sailor",
    email: "may@example.com",
    fullName: "May Tan",
  },
  applyClaimAccountRole: vi.fn(),
  notifyAccountRoleChange: vi.fn(),
}));

vi.mock("@/lib/auth", () => ({
  getAuthContext: mocks.getAuthContext,
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
          limit: vi.fn().mockImplementation(() => Promise.resolve([mocks.claim])),
        }),
      }),
    }),
    update: () => ({
      set: (vals: unknown) => {
        mocks.updateSet(vals);
        return {
          where: () => Promise.resolve([]),
        };
      },
    }),
  },
}));

vi.mock("@/lib/claimAccountRole", () => ({
  applyClaimAccountRole: mocks.applyClaimAccountRole,
}));

vi.mock("@/lib/roleChangeNotify", () => ({
  notifyAccountRoleChange: mocks.notifyAccountRoleChange,
}));

import { POST } from "./route";

describe("POST /api/account/sailor-invites", () => {
  beforeEach(() => {
    mocks.updateSet.mockReset();
    mocks.applyClaimAccountRole.mockReset();
    mocks.notifyAccountRoleChange.mockReset();
    mocks.claim.status = "pending";
    mocks.claim.source = "admin";
    mocks.getAuthContext.mockResolvedValue({
      userId: "user-1",
      email: "may@example.com",
      role: "sailor",
    });
    mocks.applyClaimAccountRole.mockResolvedValue({
      to: "may@example.com",
      name: "May Tan",
      previousRole: "sailor",
      nextRole: "parent",
      relation: "parent",
    });
    mocks.notifyAccountRoleChange.mockResolvedValue("sent");
  });

  it("approves an admin invitation and emails the new role", async () => {
    const res = await POST(
      new Request("https://sailorpath.com/api/account/sailor-invites", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ id: "claim-1", action: "accept" }),
      })
    );
    expect(res.status).toBe(200);
    expect(mocks.updateSet).toHaveBeenCalledWith(
      expect.objectContaining({ status: "approved", relation: "parent" })
    );
    expect(mocks.notifyAccountRoleChange).toHaveBeenCalledWith(
      expect.objectContaining({
        to: "may@example.com",
        sailorName: "Ava Tan",
      })
    );
  });

  it("declines without changing the account role", async () => {
    const res = await POST(
      new Request("https://sailorpath.com/api/account/sailor-invites", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ id: "claim-1", action: "decline" }),
      })
    );
    expect(res.status).toBe(200);
    expect(mocks.updateSet).toHaveBeenCalledWith(
      expect.objectContaining({ status: "rejected" })
    );
    expect(mocks.applyClaimAccountRole).not.toHaveBeenCalled();
  });

  it("treats a repeated accept as already done", async () => {
    mocks.claim.status = "approved";
    const res = await POST(
      new Request("https://sailorpath.com/api/account/sailor-invites", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ id: "claim-1", action: "accept" }),
      })
    );
    expect(res.status).toBe(200);
    expect(await res.json()).toEqual({ ok: true, status: "approved" });
    expect(mocks.updateSet).not.toHaveBeenCalled();
    expect(mocks.applyClaimAccountRole).not.toHaveBeenCalled();
  });

  it("refuses a claim the user submitted themselves", async () => {
    mocks.claim.source = "user";
    const res = await POST(
      new Request("https://sailorpath.com/api/account/sailor-invites", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ id: "claim-1", action: "accept" }),
      })
    );
    expect(res.status).toBe(400);
    expect(mocks.notifyAccountRoleChange).not.toHaveBeenCalled();
  });
});
