import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  requireSuperadmin: vi.fn(),
  updateSpy: vi.fn(),
}));

vi.mock("@/lib/auth", () => ({
  requireSuperadmin: mocks.requireSuperadmin,
  jsonError: (error: unknown) => {
    const message = error instanceof Error ? error.message : "Error";
    return Response.json({ error: message }, { status: 400 });
  },
}));

vi.mock("@/db", () => ({
  ensureCoreSchema: vi.fn().mockResolvedValue(undefined),
  db: {
    select: () => ({
      from: () => ({
        orderBy: () => ({
          limit: () => ({
            offset: () =>
              Promise.resolve([
                { id: "regatta-draft", name: "Draft Regatta", status: "draft" },
              ]),
          }),
        }),
        then: (resolve: (v: unknown) => unknown) =>
          Promise.resolve([{ n: 1 }]).then(resolve),
      }),
    }),
    update: () => {
      mocks.updateSpy();
      return {
        set: () => ({
          where: () => Promise.resolve(undefined),
        }),
      };
    },
  },
}));

vi.mock("@/lib/adminChangeLog", () => ({
  logAdminChange: vi.fn().mockResolvedValue(undefined),
}));

vi.mock("@/lib/revalidatePublic", () => ({
  revalidatePublicRankings: vi.fn().mockResolvedValue(undefined),
}));

import { GET, PATCH } from "./route";

describe("GET /api/admin/regattas", () => {
  beforeEach(() => {
    mocks.requireSuperadmin.mockReset();
    mocks.updateSpy.mockReset();
    mocks.requireSuperadmin.mockResolvedValue({
      userId: "admin-1",
      email: "admin@example.com",
      role: "superadmin",
    });
  });

  it("does not mutate or publish draft regattas on read", async () => {
    const res = await GET(new Request("https://sailorpath.com/api/admin/regattas"));
    expect(res.status).toBe(200);
    const data = await res.json();
    expect(data.regattas).toHaveLength(1);
    expect(data.regattas[0].status).toBe("draft");
    expect(mocks.updateSpy).not.toHaveBeenCalled();
  });

  it("rejects lifecycle changes through the generic patch route", async () => {
    const res = await PATCH(
      new Request("https://sailorpath.com/api/admin/regattas", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id: "regatta-draft", status: "published" }),
      })
    );

    expect(res.status).toBe(400);
    expect(await res.json()).toEqual({
      error:
        "Publication status must be changed through /api/admin/regattas/:id/publish",
    });
    expect(mocks.updateSpy).not.toHaveBeenCalled();
  });
});
