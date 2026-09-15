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

vi.mock("@/db", () => ({
  ensureCoreSchema: vi.fn().mockResolvedValue(undefined),
  db: {
    select: () => ({
      from: () =>
        Promise.resolve([
          {
            id: "draft-event",
            status: "draft",
            data: { id: "draft-event", name: "Draft event" },
          },
        ]),
    }),
    insert: () => ({
      values: (values: unknown) => {
        mocks.insertValues(values);
        return {
          onConflictDoUpdate: vi.fn().mockResolvedValue(undefined),
        };
      },
    }),
  },
}));

vi.mock("@/lib/adminChangeLog", () => ({
  auditAdminMutation: vi.fn(),
}));

vi.mock("next/cache", () => ({
  revalidatePath: vi.fn(),
  revalidateTag: vi.fn(),
}));

import { GET, POST } from "./route";

describe("GET /api/wingfoil", () => {
  beforeEach(() => {
    mocks.requireSuperadmin.mockReset();
    mocks.insertValues.mockReset();
  });

  it("bulk-upserts changed events in one database statement", async () => {
    mocks.requireSuperadmin.mockResolvedValueOnce({
      userId: "admin-1",
      email: "admin@example.com",
      role: "superadmin",
    });
    const regattas = [
      {
        id: "event-1",
        name: "Event 1",
        shortName: "E1",
        dates: "2026-09-01",
        venue: "Singapore",
        organizer: "SSF",
        format: "Sprint Slalom",
        status: "Completed",
        lifecycleStatus: "published",
        scoringSystem: "RRS B8",
        rulesNotes: "",
      },
      {
        id: "event-2",
        name: "Event 2",
        shortName: "E2",
        dates: "2026-09-02",
        venue: "Singapore",
        organizer: "SSF",
        format: "Sprint Slalom",
        status: "Upcoming",
        lifecycleStatus: "in_review",
        scoringSystem: "RRS B8",
        rulesNotes: "",
      },
    ];

    const response = await POST(
      new Request("https://sailorpath.com/api/wingfoil", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ regattas }),
      })
    );

    expect(response.status).toBe(200);
    expect(mocks.insertValues).toHaveBeenCalledOnce();
    expect(mocks.insertValues.mock.calls[0][0]).toHaveLength(2);
    await expect(response.json()).resolves.toMatchObject({ savedCount: 2 });
  });

  it("does not require authentication for published-only reads", async () => {
    const response = await GET(new Request("https://sailorpath.com/api/wingfoil"));

    expect(response.status).toBe(200);
    expect(mocks.requireSuperadmin).not.toHaveBeenCalled();
    const body = await response.json();
    expect(body.regattas).not.toContainEqual(
      expect.objectContaining({ id: "draft-event" })
    );
  });

  it("rejects unauthenticated requests for all lifecycle states", async () => {
    mocks.requireSuperadmin.mockRejectedValueOnce(new Error("UNAUTHORIZED"));

    const response = await GET(
      new Request("https://sailorpath.com/api/wingfoil?all=1")
    );

    expect(response.status).toBe(401);
    expect(mocks.requireSuperadmin).toHaveBeenCalledOnce();
  });

  it("returns drafts to an authorized superadmin", async () => {
    mocks.requireSuperadmin.mockResolvedValueOnce({
      userId: "admin-1",
      email: "admin@example.com",
      role: "superadmin",
    });

    const response = await GET(
      new Request("https://sailorpath.com/api/wingfoil?admin=1")
    );

    expect(response.status).toBe(200);
    const body = await response.json();
    expect(body.regattas).toContainEqual(
      expect.objectContaining({ id: "draft-event" })
    );
  });
});
