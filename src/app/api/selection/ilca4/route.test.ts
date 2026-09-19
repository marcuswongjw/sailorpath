import { describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  getAuthContext: vi.fn(),
}));

vi.mock("@/lib/auth", () => ({
  getAuthContext: mocks.getAuthContext,
  jsonError: (msg: string, status = 400) =>
    new Response(JSON.stringify({ error: msg }), {
      status,
      headers: { "content-type": "application/json" },
    }),
}));

import { GET } from "./route";

describe("GET /api/selection/ilca4", () => {
  it("returns 401 if unauthenticated", async () => {
    mocks.getAuthContext.mockResolvedValueOnce(null);
    const res = await GET();
    expect(res.status).toBe(401);
    const body = await res.json();
    expect(body.error).toBe("Unauthorized");
  });

  it("returns sailors data if authenticated", async () => {
    mocks.getAuthContext.mockResolvedValueOnce({
      userId: "u1",
      email: "user@example.com",
      role: "sailor",
    });
    const res = await GET();
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(Array.isArray(body.sailors)).toBe(true);
    expect(body.sailors.length).toBeGreaterThan(0);
  });
});
