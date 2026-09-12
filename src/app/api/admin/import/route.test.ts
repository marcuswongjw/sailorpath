import { describe, expect, it, vi } from "vitest";

vi.mock("@/lib/auth", () => ({
  requireSuperadmin: vi.fn().mockResolvedValue({
    userId: "admin-1",
    email: "admin@example.com",
    role: "superadmin",
  }),
  jsonError: (error: unknown) =>
    Response.json(
      { error: error instanceof Error ? error.message : "Error" },
      { status: 500 }
    ),
}));

import { POST } from "@/app/api/admin/import/route";

function request(body: Record<string, unknown>) {
  return new Request("https://sailorpath.com/api/admin/import", {
    method: "POST",
    headers: { "content-type": "application/json" },
    body: JSON.stringify({
      regattaName: "Test Regatta",
      eventDate: "2026-01-01",
      rows: [{ name: "Test Sailor", rank: 1, nett: null }],
      ...body,
    }),
  });
}

describe("POST /api/admin/import scoring validation", () => {
  it("rejects a non-positive finishing rank before writing", async () => {
    const response = await POST(
      request({ rows: [{ name: "Test Sailor", rank: -1, nett: null }] })
    );

    expect(response.status).toBe(400);
    await expect(response.json()).resolves.toMatchObject({
      error: "row 1 rank must be an integer from 1 to 10000",
    });
  });

  it("rejects a non-positive fleet size before writing", async () => {
    const response = await POST(request({ totalFleetSize: -10 }));

    expect(response.status).toBe(400);
    await expect(response.json()).resolves.toMatchObject({
      error: "totalFleetSize must be an integer from 1 to 10000",
    });
  });
});
