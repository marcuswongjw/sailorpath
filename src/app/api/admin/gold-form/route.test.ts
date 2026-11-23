import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  authorize: vi.fn(),
  dbSelect: vi.fn(),
}));

vi.mock("@/lib/auth", () => ({
  requireSuperadmin: mocks.authorize,
  jsonError: () => Response.json({ error: "Forbidden" }, { status: 403 }),
}));

vi.mock("@/db", () => ({
  db: { select: mocks.dbSelect },
  ensureCoreSchema: vi.fn(),
  withSequentialDatabaseReads: async (fns: Array<() => Promise<unknown>>) =>
    Promise.all(fns.map((fn) => fn())),
}));

import { GET } from "./route";

function chainSelect(rows: unknown[]) {
  const result = Promise.resolve(rows) as Promise<unknown[]> & {
    from: () => typeof result;
    where: () => typeof result;
  };
  result.from = () => result;
  result.where = () => result;
  return result;
}

beforeEach(() => {
  mocks.authorize.mockReset().mockResolvedValue({ role: "superadmin" });
  mocks.dbSelect.mockReset();
  vi.spyOn(console, "error").mockImplementation(() => {});
});

afterEach(() => {
  vi.restoreAllMocks();
});

describe("admin Gold Form API", () => {
  it("rejects unauthorized callers without querying Gold data", async () => {
    mocks.authorize.mockRejectedValue(new Error("Forbidden"));
    const res = await GET(new Request("https://admin.sailorpath.com/api/admin/gold-form"));
    expect(res.status).toBe(403);
    expect(mocks.dbSelect).not.toHaveBeenCalled();
  });

  it("returns private uncached Gold form index for superadmin", async () => {
    mocks.dbSelect
      .mockReturnValueOnce(
        chainSelect([
          {
            id: "s1",
            name: "Gold Leader",
            handle: "gold-leader",
            sailNumber: "SGP 1",
            club: "NSC",
            school: null,
            gender: "F",
            nationality: "SGP",
            dob: "2013-01-01",
            goldEntryDate: "2023-01-01",
            silverEntryDate: null,
            dropDate: null,
            currentFleet: "Series",
            nationalSquadStatus: "Nat A",
          },
        ]),
      )
      .mockReturnValueOnce(
        chainSelect([
          {
            id: "r1",
            name: "SNSC Gold 2026",
            slug: "snsc-gold-2026",
            date: "2026-09-11",
            division: "Gold",
            boatClass: "Optimist",
            geography: "SGP",
            countsForRanking: true,
            status: "published",
            totalFleetSize: 80,
          },
        ]),
      )
      .mockReturnValueOnce(
        chainSelect([
          {
            sailorId: "s1",
            regattaId: "r1",
            rank: 2,
            nettScore: 14,
            isDns: false,
            isOverseasCommitment: false,
          },
        ]),
      );

    const res = await GET(new Request("https://admin.sailorpath.com/api/admin/gold-form"));
    expect(res.status).toBe(200);
    expect(res.headers.get("cache-control")).toBe("private, no-store");
    const body = await res.json();
    expect(body.sgRanking.activeGoldCount).toBe(1);
    expect(body.sgRanking.entries[0].name).toBe("Gold Leader");
    expect(body.allGold.regattaCount).toBe(1);
  });
});
