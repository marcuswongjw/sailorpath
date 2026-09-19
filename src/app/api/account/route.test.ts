import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  getAuthContext: vi.fn(),
  updateSet: vi.fn(),
  insertValues: vi.fn(),
}));

vi.mock("@/lib/auth", () => ({
  getAuthContext: mocks.getAuthContext,
  jsonError: (error: unknown) => {
    const message = error instanceof Error ? error.message : "Error";
    return Response.json({ error: message }, { status: 500 });
  },
}));

vi.mock("@/db", () => {
  const createQueryMock = (data: unknown) => {
    const p = Promise.resolve(data);
    return Object.assign(p, {
      limit: () => p,
      orderBy: () => p,
      where: () => createQueryMock(data),
    });
  };

  return {
    db: {
      select: () => ({
        from: () => ({
          where: () =>
            createQueryMock([
              {
                id: "test-user-id",
                email: "sailor@example.com",
                fullName: "Test Sailor",
                role: "sailor",
                createdAt: new Date("2026-01-01T00:00:00.000Z"),
              },
            ]),
          innerJoin: () => ({
            where: () => createQueryMock([]),
          }),
        }),
      }),
      update: () => ({
        set: (values: unknown) => {
          mocks.updateSet(values);
          return {
            where: vi.fn().mockResolvedValue(undefined),
          };
        },
      }),
      insert: () => ({
        values: (values: unknown) => {
          mocks.insertValues(values);
          return Promise.resolve(undefined);
        },
      }),
    },
  };
});

import { GET, PATCH } from "./route";

describe("Account API (/api/account)", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("returns 401 when not signed in", async () => {
    mocks.getAuthContext.mockResolvedValueOnce(null);
    const res = await GET();
    expect(res.status).toBe(401);
  });

  it("returns profile and user details when signed in", async () => {
    mocks.getAuthContext.mockResolvedValueOnce({
      userId: "test-user-id",
      email: "sailor@example.com",
      role: "sailor",
    });

    const res = await GET();
    expect(res.status).toBe(200);
    const data = await res.json();
    expect(data.user).toBeDefined();
    expect(data.user.fullName).toBe("Test Sailor");
    expect(data.user.email).toBe("sailor@example.com");
  });

  it("updates user profile name and email via PATCH", async () => {
    mocks.getAuthContext.mockResolvedValueOnce({
      userId: "test-user-id",
      email: "sailor@example.com",
      role: "sailor",
    });

    const req = new Request("http://localhost:3000/api/account", {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        fullName: "Updated Name",
        email: "newemail@example.com",
      }),
    });

    const res = await PATCH(req);
    expect(res.status).toBe(200);
    const data = await res.json();
    expect(data.success).toBe(true);
    expect(mocks.updateSet).toHaveBeenCalled();
  });

  it("rejects invalid email on PATCH", async () => {
    mocks.getAuthContext.mockResolvedValueOnce({
      userId: "test-user-id",
      email: "sailor@example.com",
      role: "sailor",
    });

    const req = new Request("http://localhost:3000/api/account", {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        email: "invalid-email",
      }),
    });

    const res = await PATCH(req);
    expect(res.status).toBe(400);
    const data = await res.json();
    expect(data.error).toContain("valid email");
  });
});
