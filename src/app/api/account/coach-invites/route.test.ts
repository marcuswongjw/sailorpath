import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  getAuthContext: vi.fn(),
  updateSet: vi.fn(),
  request: {
    id: "req-1",
    requesterId: "user-1",
    status: "pending",
    source: "admin",
    role: "sailor",
    email: "alex@example.com",
    fullName: "Alex Tan",
  },
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
        innerJoin: () => ({
          where: () => ({
            limit: vi.fn().mockImplementation(() => Promise.resolve([mocks.request])),
          }),
        }),
      }),
    }),
    update: () => ({
      set: (vals: unknown) => {
        mocks.updateSet(vals);
        return { where: () => Promise.resolve([]) };
      },
    }),
  },
}));

vi.mock("@/lib/roleChangeNotify", () => ({
  notifyAccountRoleChange: mocks.notifyAccountRoleChange,
}));

import { POST } from "./route";

function call(action: string) {
  return POST(
    new Request("https://sailorpath.com/api/account/coach-invites", {
      method: "POST",
      headers: { "content-type": "application/json" },
      body: JSON.stringify({ token: "invite-token", action }),
    })
  );
}

describe("POST /api/account/coach-invites", () => {
  beforeEach(() => {
    mocks.updateSet.mockReset();
    mocks.notifyAccountRoleChange.mockReset();
    mocks.notifyAccountRoleChange.mockResolvedValue("sent");
    mocks.request.status = "pending";
    mocks.request.source = "admin";
    mocks.request.role = "sailor";
    mocks.request.requesterId = "user-1";
    mocks.getAuthContext.mockResolvedValue({
      userId: "user-1",
      email: "alex@example.com",
      role: "sailor",
    });
  });

  it("accepts the invitation and emails the new coach role", async () => {
    const res = await call("accept");
    expect(res.status).toBe(200);
    expect(mocks.updateSet).toHaveBeenCalledWith(
      expect.objectContaining({ role: "coach" })
    );
    expect(mocks.updateSet).toHaveBeenCalledWith(
      expect.objectContaining({ status: "approved", inviteToken: null })
    );
    expect(mocks.notifyAccountRoleChange).toHaveBeenCalledWith(
      expect.objectContaining({
        to: "alex@example.com",
        previousRole: "sailor",
        nextRole: "coach",
      })
    );
  });

  it("declines without changing the role", async () => {
    const res = await call("decline");
    expect(res.status).toBe(200);
    expect(mocks.updateSet).toHaveBeenCalledWith(
      expect.objectContaining({ status: "rejected", inviteToken: null })
    );
    expect(mocks.notifyAccountRoleChange).not.toHaveBeenCalled();
  });

  it("refuses a different signed-in account", async () => {
    mocks.getAuthContext.mockResolvedValue({
      userId: "someone-else",
      email: "other@example.com",
      role: "sailor",
    });
    const res = await call("accept");
    expect(res.status).toBe(403);
    expect(mocks.updateSet).not.toHaveBeenCalled();
  });
});