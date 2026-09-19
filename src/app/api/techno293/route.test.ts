import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  requireSuperadmin: vi.fn(),
  insertValues: vi.fn(),
}));

vi.mock("@/lib/auth", () => ({
  requireSuperadmin: mocks.requireSuperadmin,
  jsonError: (error: unknown) => {
    const message = error instanceof Error ? error.message : "Error";
    return Response.json(
      { error: message },
      { status: message === "UNAUTHORIZED" ? 401 : 403 }
    );
  },
}));

vi.mock("@/db", () => {
  const fakeRows = [
    {
      id: "draft-techno-event",
      status: "draft",
      data: { id: "draft-techno-event", name: "Draft Techno" },
    },
    {
      id: "techno-sw-gp1-2026",
      status: "published",
      data: { id: "techno-sw-gp1-2026", name: "GP1 published" },
    },
  ];
  return {
    ensureCoreSchema: vi.fn().mockResolvedValue(undefined),
    db: {
      select: () => ({
        from: () => ({
          then: (resolve: (v: typeof fakeRows) => unknown, reject?: (reason: unknown) => unknown) =>
            Promise.resolve(fakeRows).then(resolve, reject),
          where: vi.fn().mockImplementation(() =>
            Promise.resolve(fakeRows.filter((r) => r.status === "published"))
          ),
        }),
      }),
      insert: () => ({
        values: (values: unknown) => {
          mocks.insertValues(values);
          return {
            onConflictDoUpdate: vi.fn().mockResolvedValue(undefined),
          };
        },
      }),
      delete: () => ({
        where: vi.fn().mockResolvedValue(undefined),
      }),
    },
  };
});

vi.mock("@/lib/adminChangeLog", () => ({
  auditAdminMutation: vi.fn(),
}));

vi.mock("next/cache", () => ({
  revalidatePath: vi.fn(),
  revalidateTag: vi.fn(),
}));

import { GET, POST, DELETE } from "./route";

describe("Techno 293 API (/api/techno293)", () => {
  beforeEach(() => {
    mocks.requireSuperadmin.mockReset();
    mocks.insertValues.mockReset();
  });

  it("does not require authentication for public GET requests and filters drafts", async () => {
    const response = await GET(new Request("https://sailorpath.com/api/techno293"));
    expect(response.status).toBe(200);
    const body = await response.json();
    expect(Array.isArray(body.regattas)).toBe(true);
    expect(body.regattas).not.toContainEqual(
      expect.objectContaining({ id: "draft-techno-event" })
    );
    expect(body.regattas).toContainEqual(
      expect.objectContaining({ id: "techno-sw-gp1-2026" })
    );
  });

  it("requires superadmin for POST mutation", async () => {
    mocks.requireSuperadmin.mockRejectedValueOnce(new Error("UNAUTHORIZED"));
    const response = await POST(
      new Request("https://sailorpath.com/api/techno293", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ regattas: [] }),
      })
    );
    expect(response.status).toBe(401);
  });

  it("bulk-upserts regattas when superadmin is authenticated", async () => {
    mocks.requireSuperadmin.mockResolvedValueOnce({
      userId: "admin-1",
      email: "admin@example.com",
      role: "superadmin",
    });

    const regattas = [
      {
        id: "techno-sw-gp1-2026",
        name: "2026 Southwest Monsoon Grand Prix Series 1",
        shortName: "SW Monsoon GP1",
        dates: "11 - 12 July 2026",
        venue: "Constant Wind Sea Sport Centre",
        organizer: "Singapore Sailing Federation & WAS",
        format: "Course Race",
        status: "Completed",
        lifecycleStatus: "published",
        scoringSystem: "World Sailing RRS Appendix A (Low Point)",
        rulesNotes: "",
      },
    ];

    const response = await POST(
      new Request("https://sailorpath.com/api/techno293", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ regattas }),
      })
    );

    expect(response.status).toBe(200);
    const body = await response.json();
    expect(body.success).toBe(true);
    expect(mocks.insertValues).toHaveBeenCalled();
  });

  it("deletes a regatta when authorized", async () => {
    mocks.requireSuperadmin.mockResolvedValueOnce({
      userId: "admin-1",
      email: "admin@example.com",
      role: "superadmin",
    });

    const response = await DELETE(
      new Request("https://sailorpath.com/api/techno293", {
        method: "DELETE",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ id: "techno-sw-gp1-2026" }),
      })
    );

    expect(response.status).toBe(200);
    const body = await response.json();
    expect(body.success).toBe(true);
    expect(body.deletedId).toBe("techno-sw-gp1-2026");
  });
});
