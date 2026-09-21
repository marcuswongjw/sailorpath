import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  requireSuperadmin: vi.fn(),
  updateResultSpy: vi.fn(),
  updateRegattaSpy: vi.fn(),
  regattaRowLimit: vi.fn(),
}));

vi.mock("@/lib/auth", () => ({
  requireSuperadmin: mocks.requireSuperadmin,
  jsonError: (error: unknown) => {
    const message = error instanceof Error ? error.message : "Error";
    return Response.json({ error: message }, { status: 400 });
  },
}));

vi.mock("@/lib/adminChangeLog", () => ({
  logAdminChange: vi.fn().mockResolvedValue(undefined),
}));

vi.mock("@/lib/revalidatePublic", () => ({
  revalidatePublicRankings: vi.fn().mockResolvedValue(undefined),
}));

vi.mock("@/db", () => ({
  db: {
    selectDistinct: () => ({
      from: () => ({
        where: () => Promise.resolve([{ regattaId: "regatta-1" }]),
      }),
    }),
    select: () => ({
      from: () => ({
        where: () => ({
          limit: () => mocks.regattaRowLimit(),
          orderBy: () =>
            Promise.resolve([
              {
                id: "regatta-1",
                name: "Pattaya Cup 2026",
                slug: "pattaya-cup-2026",
                date: "2026-03-15",
                totalFleetSize: 60,
                division: "Open",
                geography: "THA",
                boatClass: "Optimist",
                countsForRanking: false,
                reviewedAt: null,
                createdAt: new Date(),
              },
            ]),
        }),
        innerJoin: () => ({
          where: () =>
            Promise.resolve([
              {
                resultId: "res-1",
                rank: 3,
                nettScore: 12,
                totalScore: 18,
                sailorId: "sailor-1",
                sailorName: "Alex Sailor",
                sailorHandle: "alex-sailor",
                evidenceUrl: "https://storage.supabase.com/evidence/doc.pdf",
                evidenceName: "pattaya_results.pdf",
                evidenceType: "pdf",
                officialUrl: "https://manage2sail.com",
                evidenceNotes: "U12 1st place",
                verificationStatus: "pending_review",
                verifiedAt: null,
              },
            ]),
        }),
      }),
    }),
    update: () => {
      // Return different mock depending on whether regattaResults or regattas is updated
      return {
        set: (values: Record<string, unknown>) => ({
          where: () => ({
            returning: () => {
              if (values.verificationStatus) {
                mocks.updateResultSpy(values);
                return Promise.resolve([
                  {
                    id: "res-1",
                    verificationStatus: values.verificationStatus,
                    verifiedAt: values.verifiedAt,
                  },
                ]);
              }
              mocks.updateRegattaSpy(values);
              return Promise.resolve([
                {
                  id: "regatta-1",
                  name: "Pattaya Cup 2026",
                  countsForRanking: values.countsForRanking ?? false,
                  reviewedAt: values.reviewedAt,
                },
              ]);
            },
          }),
        }),
      };
    },
  },
}));

import { GET, PATCH } from "./route";

describe("/api/admin/regatta-suggestions", () => {
  beforeEach(() => {
    mocks.requireSuperadmin.mockReset();
    mocks.updateResultSpy.mockReset();
    mocks.updateRegattaSpy.mockReset();
    mocks.regattaRowLimit.mockReset();
    mocks.regattaRowLimit.mockResolvedValue([
      { countsForRanking: false, totalFleetSize: 60 },
    ]);
    mocks.requireSuperadmin.mockResolvedValue({
      userId: "admin-1",
      email: "admin@sailorpath.com",
      role: "superadmin",
    });
  });

  describe("GET", () => {
    it("returns suggestions with evidence fields", async () => {
      const res = await GET();
      expect(res.status).toBe(200);
      const data = await res.json();
      expect(data.count).toBe(1);
      expect(data.suggestions[0].name).toBe("Pattaya Cup 2026");
      expect(data.suggestions[0].results[0].evidenceUrl).toBe(
        "https://storage.supabase.com/evidence/doc.pdf"
      );
      expect(data.suggestions[0].results[0].verificationStatus).toBe(
        "pending_review"
      );
    });
  });

  describe("PATCH verify action", () => {
    it("verifies a result evidence submission", async () => {
      const req = new Request("http://localhost/api/admin/regatta-suggestions", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "verify", resultId: "res-1" }),
      });
      const res = await PATCH(req);
      expect(res.status).toBe(200);
      const data = await res.json();
      expect(data.ok).toBe(true);
      expect(mocks.updateResultSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          verificationStatus: "verified",
          verifiedBy: "admin-1",
        })
      );
    });

    it("requires resultId", async () => {
      const req = new Request("http://localhost/api/admin/regatta-suggestions", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "verify" }),
      });
      const res = await PATCH(req);
      expect(res.status).toBe(400);
    });
  });

  describe("PATCH reject action", () => {
    it("rejects an evidence submission", async () => {
      const req = new Request("http://localhost/api/admin/regatta-suggestions", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "reject", resultId: "res-1" }),
      });
      const res = await PATCH(req);
      expect(res.status).toBe(200);
      expect(mocks.updateResultSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          verificationStatus: "rejected",
          verifiedBy: "admin-1",
        })
      );
    });
  });

  describe("PATCH dismiss action", () => {
    it("marks regatta reviewed", async () => {
      const req = new Request("http://localhost/api/admin/regatta-suggestions", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "dismiss", regattaId: "regatta-1" }),
      });
      const res = await PATCH(req);
      expect(res.status).toBe(200);
      expect(mocks.updateRegattaSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          reviewedAt: expect.any(Date),
        })
      );
    });
  });

  describe("PATCH promote action", () => {
    it("promotes regatta to ranking series", async () => {
      const req = new Request("http://localhost/api/admin/regatta-suggestions", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          action: "promote",
          regattaId: "regatta-1",
          division: "Gold",
          geography: "SGP",
          totalFleetSize: 75,
        }),
      });
      const res = await PATCH(req);
      expect(res.status).toBe(200);
      expect(mocks.updateRegattaSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          countsForRanking: true,
          division: "Gold",
          geography: "SGP",
          totalFleetSize: 75,
        })
      );
    });

    it("keeps the existing fleet size when totalFleetSize is omitted", async () => {
      const req = new Request("http://localhost/api/admin/regatta-suggestions", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          action: "promote",
          regattaId: "regatta-1",
          division: "Gold",
        }),
      });
      const res = await PATCH(req);
      expect(res.status).toBe(200);
      expect(mocks.updateRegattaSpy).toHaveBeenCalledWith(
        expect.objectContaining({ totalFleetSize: 60 })
      );
    });

    it("returns 400 for a non-positive totalFleetSize instead of defaulting to 50", async () => {
      const req = new Request("http://localhost/api/admin/regatta-suggestions", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          action: "promote",
          regattaId: "regatta-1",
          totalFleetSize: 0,
        }),
      });
      const res = await PATCH(req);
      expect(res.status).toBe(400);
      expect(mocks.updateRegattaSpy).not.toHaveBeenCalled();
    });

    it("returns 409 when the regatta already counts for ranking", async () => {
      mocks.regattaRowLimit.mockResolvedValue([
        { countsForRanking: true, totalFleetSize: 60 },
      ]);
      const req = new Request("http://localhost/api/admin/regatta-suggestions", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          action: "promote",
          regattaId: "regatta-1",
          division: "Silver",
          geography: "THA",
          totalFleetSize: 10,
        }),
      });
      const res = await PATCH(req);
      expect(res.status).toBe(409);
      // Must NOT overwrite division/geography/fleet size on a ranking regatta
      expect(mocks.updateRegattaSpy).not.toHaveBeenCalled();
    });
  });
});
