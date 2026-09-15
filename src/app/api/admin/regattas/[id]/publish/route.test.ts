import { describe, expect, it, vi } from "vitest";

vi.mock("@/lib/auth", () => ({
  requireSuperadmin: vi.fn().mockResolvedValue({
    userId: "admin-1",
    email: "superadmin@sailorpath.com",
    role: "superadmin",
  }),
  jsonError: (error: unknown) =>
    Response.json(
      { error: error instanceof Error ? error.message : "Error" },
      { status: 500 }
    ),
}));

vi.mock("@/db", () => {
  const fakeRegattas = [
    {
      id: "regatta-uuid-1",
      name: "Singapore National Championships",
      slug: "snsc-2026",
      date: "2026-09-05",
      status: "in_review",
      totalFleetSize: 50,
    },
  ];

  return {
    ensureCoreSchema: vi.fn().mockResolvedValue(undefined),
    db: {
      select: () => ({
        from: () => ({
          where: () => ({
            limit: () => fakeRegattas,
          }),
        }),
      }),
      update: () => ({
        set: () => ({
          where: vi.fn().mockResolvedValue(undefined),
        }),
      }),
    },
  };
});

vi.mock("@/lib/adminChangeLog", () => ({
  auditAdminMutation: vi.fn().mockResolvedValue({ ok: true }),
}));

vi.mock("next/cache", () => ({
  revalidatePath: vi.fn(),
  revalidateTag: vi.fn(),
}));

import { POST } from "./route";

describe("POST /api/admin/regattas/:id/publish", () => {
  it("rejects invalid status values", async () => {
    const req = new Request("http://localhost/api/admin/regattas/regatta-uuid-1/publish", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ targetStatus: "invalid_state" }),
    });

    const res = await POST(req, { params: Promise.resolve({ id: "regatta-uuid-1" }) });
    expect(res.status).toBe(400);
    const data = await res.json();
    expect(data.error).toContain("Invalid target status");
  });

  it("publishes regatta and returns success", async () => {
    const req = new Request("http://localhost/api/admin/regattas/regatta-uuid-1/publish", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ targetStatus: "published" }),
    });

    const res = await POST(req, { params: Promise.resolve({ id: "regatta-uuid-1" }) });
    expect(res.status).toBe(200);
    const data = await res.json();
    expect(data.success).toBe(true);
    expect(data.status).toBe("published");
    expect(data.previousStatus).toBe("in_review");
  });
});
