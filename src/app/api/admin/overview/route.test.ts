import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  requireSuperadmin: vi.fn(),
  resultCountRows: [
    { regattaId: "reg-1", count: 12 },
    { regattaId: "reg-2", count: 0 },
  ],
  regattaRows: [
    {
      id: "reg-1",
      name: "Championship 2026",
      date: "2026-06-01",
      status: "completed",
      isPublished: true,
      hasResults: true,
      resultCount: 12,
    },
    {
      id: "reg-2",
      name: "Spring Regatta 2026",
      date: "2026-03-01",
      status: "completed",
      isPublished: false,
      hasResults: false,
      resultCount: 0,
    },
  ],
  sailorRows: [
    { id: "s-1", name: "John Doe", sailNumber: "12345" },
    { id: "s-2", name: "John Doe", sailNumber: "12345" },
    { id: "s-3", name: "Jane Smith", sailNumber: "67890" },
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
  ensureCoreSchema: vi.fn().mockResolvedValue(undefined),
  withDatabaseRetry: <T>(fn: () => Promise<T>) => fn(),
  db: {
    select: () => ({
      from: () => ({
        groupBy: () => Promise.resolve(mocks.resultCountRows),
        orderBy: () => Promise.resolve(mocks.regattaRows),
        then: (resolve: (val: unknown) => void) => resolve(mocks.sailorRows),
        [Symbol.toStringTag]: "Promise",
      }),
    }),
  },
}));

vi.mock("@/lib/nameMatch", async (importOriginal) => {
  const actual = await importOriginal<typeof import("@/lib/nameMatch")>();
  return {
    ...actual,
    findDuplicateSailorPairs: vi.fn().mockReturnValue([
      {
        sailorA: { id: "s-1", name: "John Doe" },
        sailorB: { id: "s-2", name: "John Doe" },
        confidence: 1,
        matchReason: "same name and sail number",
      },
    ]),
  };
});

import { GET } from "./route";

describe("GET /api/admin/overview", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    mocks.requireSuperadmin.mockResolvedValue({
      userId: "admin-1",
      email: "admin@sailorpath.com",
      role: "superadmin",
    });
  });

  it("returns 403 when user is not a superadmin", async () => {
    mocks.requireSuperadmin.mockRejectedValue(new Error("Unauthorized: superadmin required"));
    const res = await GET();
    expect(res.status).toBe(403);
    const data = await res.json();
    expect(data.error).toContain("superadmin required");
  });

  it("returns compact overview data with counts", async () => {
    const res = await GET();
    expect(res.status).toBe(200);
    const data = await res.json();

    expect(data).toHaveProperty("counts");
    expect(data.counts).toHaveProperty("ready");
    expect(data.counts).toHaveProperty("missingResults");
    expect(data.counts).toHaveProperty("blocked");
    expect(data.counts).toHaveProperty("incomplete");
    expect(data.counts).toHaveProperty("duplicateSailors", 1);

    expect(data).toHaveProperty("sheets");
    expect(data).toHaveProperty("ready");
    expect(data).toHaveProperty("missingResults");
    expect(data).toHaveProperty("blocked");
    expect(data).toHaveProperty("incomplete");
    expect(data.duplicateCount).toBe(1);

    expect(res.headers.get("Cache-Control")).toBe("private, no-store");
  });
});
