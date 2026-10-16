import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  requireSuperadmin: vi.fn(),
  regattaRows: [
    {
      id: "sheet-1",
      name: "Optimist Gold",
      date: "2026-06-01",
      boatClass: "Optimist",
      division: "Gold",
      totalFleetSize: 20,
      raceCount: 3,
      countsForRanking: true,
      status: "completed",
    },
    {
      id: "sheet-2",
      name: "ILCA 4 Open",
      date: "2026-06-02",
      boatClass: "ILCA 4",
      division: "Open",
      totalFleetSize: 15,
      raceCount: 0,
      countsForRanking: false,
      status: "completed",
    },
  ],
  countRows: [
    { regattaId: "sheet-1", n: 20 },
    { regattaId: "sheet-2", n: 0 },
  ],
}));

vi.mock("@/lib/auth", () => ({
  requireSuperadmin: mocks.requireSuperadmin,
  jsonError: (error: unknown) => {
    const message = error instanceof Error ? error.message : "Error";
    const status = message.includes("Forbidden") || message.includes("Unauthorized") ? 403 : 500;
    return Response.json({ error: message }, { status });
  },
}));

vi.mock("@/db", () => ({
  withDatabaseRetry: <T>(fn: () => Promise<T>) => fn(),
  db: {
    select: () => ({
      from: () => ({
        where: () => ({
          limit: () => Promise.resolve([mocks.regattaRows[0]]),
          groupBy: () => Promise.resolve(mocks.countRows),
          then: (resolve: (val: unknown) => void) => resolve([mocks.countRows[0]]),
        }),
      }),
    }),
  },
}));

import { GET } from "./route";

describe("GET /api/admin/regatta-readiness", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    mocks.requireSuperadmin.mockResolvedValue({
      userId: "admin-1",
      email: "admin@sailorpath.com",
      role: "superadmin",
    });
  });

  it("returns 400 when neither sheet nor sheets is provided", async () => {
    const req = new Request("https://sailorpath.com/api/admin/regatta-readiness");
    const res = await GET(req);
    const data = await res.json();
    expect(data.error).toContain("sheet or sheets is required");
    expect(res.status).toBe(400);
  });

  it("handles single sheet readiness check", async () => {
    const req = new Request("https://sailorpath.com/api/admin/regatta-readiness?sheet=sheet-1");
    const res = await GET(req);
    expect(res.status).toBe(200);
    const data = await res.json();
    expect(data.ok).toBe(true);
    expect(data.sheetId).toBe("sheet-1");
    expect(data).toHaveProperty("readiness");
  });

  it("handles batch sheets parameter", async () => {
    const req = new Request("https://sailorpath.com/api/admin/regatta-readiness?sheets=sheet-1,sheet-2");
    const res = await GET(req);
    expect(res.status).toBe(200);
    const data = await res.json();
    expect(data.ok).toBe(true);
    expect(data).toHaveProperty("readinessBySheet");
  });
});
