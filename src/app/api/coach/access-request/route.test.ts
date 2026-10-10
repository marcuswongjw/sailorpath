import { beforeEach, describe, expect, it, vi } from "vitest";

vi.mock("@/lib/userChanges", () => ({ recordUserChange: vi.fn().mockResolvedValue(undefined) }));

const mocks = vi.hoisted(() => ({
  getAuthContext: vi.fn(),
  existing: null as null | {
    id: string;
    status: "pending" | "approved" | "rejected";
    source: "user" | "admin";
  },
  reads: 0,
  conflict: false,
  inserts: [] as unknown[],
  updates: [] as unknown[],
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
          limit: () => {
            mocks.reads += 1;
            return Promise.resolve(mocks.existing ? [mocks.existing] : []);
          },
        }),
      }),
    }),
    insert: () => ({
      values: (vals: unknown) => {
        mocks.inserts.push(vals);
        return {
          onConflictDoNothing: () => ({
            returning: () =>
              Promise.resolve(mocks.conflict ? [] : [{ status: "pending" }]),
          }),
        };
      },
    }),
    update: () => ({
      set: (vals: unknown) => {
        mocks.updates.push(vals);
        return {
          where: () => ({
            returning: () => Promise.resolve([{ status: "pending" }]),
          }),
        };
      },
    }),
  },
}));

import { POST } from "./route";

describe("POST /api/coach/access-request", () => {
  beforeEach(() => {
    mocks.existing = null;
    mocks.reads = 0;
    mocks.conflict = false;
    mocks.inserts = [];
    mocks.updates = [];
    mocks.getAuthContext.mockResolvedValue({
      userId: "user-1",
      email: "alex@example.com",
      role: "sailor",
    });
  });

  it("creates a user request when none exists", async () => {
    const res = await POST();
    expect(res.status).toBe(200);
    await expect(res.json()).resolves.toEqual({ status: "pending" });
    expect(mocks.inserts).toEqual([
      { requesterId: "user-1", status: "pending", source: "user" },
    ]);
    expect(mocks.updates).toEqual([]);
  });

  it("does not clear an open admin invite", async () => {
    mocks.existing = {
      id: "req-1",
      status: "pending",
      source: "admin",
    };
    const res = await POST();
    expect(res.status).toBe(200);
    await expect(res.json()).resolves.toEqual({ status: "pending" });
    expect(mocks.inserts).toEqual([]);
    expect(mocks.updates).toEqual([]);
  });

  it("does not turn an approved request back into a user request", async () => {
    mocks.existing = {
      id: "req-1",
      status: "approved",
      source: "admin",
    };
    const res = await POST();
    expect(res.status).toBe(200);
    await expect(res.json()).resolves.toEqual({ status: "approved" });
    expect(mocks.updates).toEqual([]);
  });

  it("lets a rejected user ask again without keeping the old invite token", async () => {
    mocks.existing = {
      id: "req-1",
      status: "rejected",
      source: "admin",
    };
    const res = await POST();
    expect(res.status).toBe(200);
    expect(mocks.inserts).toEqual([]);
    expect(mocks.updates).toHaveLength(1);
    expect(mocks.updates[0]).toMatchObject({
      status: "pending",
      source: "user",
      inviteToken: null,
      reviewedAt: null,
      reviewedBy: null,
    });
  });

  it("leaves an invite that wins the insert race untouched", async () => {
    mocks.conflict = true;
    mocks.existing = null;
    const realLimit = () => {
      mocks.reads += 1;
      if (mocks.reads === 1) return Promise.resolve([]);
      return Promise.resolve([
        { id: "req-1", status: "pending" as const, source: "admin" as const },
      ]);
    };
    const db = await import("@/db");
    vi.spyOn(db.db, "select").mockImplementation(
      () =>
        ({
          from: () => ({
            where: () => ({
              limit: realLimit,
            }),
          }),
        }) as never
    );

    const res = await POST();
    expect(res.status).toBe(200);
    await expect(res.json()).resolves.toEqual({ status: "pending" });
    expect(mocks.updates).toEqual([]);
  });
});
