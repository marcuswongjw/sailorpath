import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  getAuthContext: vi.fn(),
  canManageSailor: vi.fn(),
  insertRegattaSpy: vi.fn(),
  insertResultSpy: vi.fn(),
  updateResultSpy: vi.fn(),
  resultRowLimit: vi.fn(),
}));

const DEFAULT_RESULT_ROW = {
  resultId: "res-1",
  sailorId: "sailor-1",
  regattaId: "regatta-1",
  countsForRanking: false,
  regattaSlug: "log-langkawi-regatta-2026-02-10-sailor-1",
  regattaName: "LangKawi Regatta",
  regattaDate: "2026-02-10",
  regattaEndDate: null,
  regattaVenue: null,
  regattaDivision: "Open",
  regattaFleetSize: 45,
  regattaGeography: "MAS",
  regattaBoatClass: "Optimist",
  rank: 2,
  nettScore: 10,
  totalScore: 15,
  verificationStatus: "self_reported",
  evidenceUrl: null,
  evidenceName: null,
  evidenceType: null,
  officialUrl: null,
  evidenceNotes: null,
};

vi.mock("@/lib/auth", () => ({
  getAuthContext: mocks.getAuthContext,
  jsonError: (error: unknown) => {
    const message = error instanceof Error ? error.message : "Error";
    return Response.json({ error: message }, { status: 400 });
  },
}));

vi.mock("@/lib/claimAccess", () => ({
  canManageSailor: mocks.canManageSailor,
}));

vi.mock("@/lib/revalidatePublic", () => ({
  revalidatePublicRankings: vi.fn().mockResolvedValue(undefined),
}));

vi.mock("@/lib/adminChangeLog", () => ({
  logAdminChange: vi.fn().mockResolvedValue(undefined),
}));

vi.mock("@/lib/usage", () => ({
  trackUsage: vi.fn(),
}));

vi.mock("@/db", () => ({
  db: {
    select: () => ({
      from: () => ({
        where: () => ({
          limit: vi.fn().mockResolvedValue([
            {
              id: "sailor-1",
              parentId: "parent-1",
            },
          ]),
          orderBy: () =>
            Promise.resolve([
              {
                id: "res-1",
                rank: 2,
                regattaName: "LangKawi Regatta",
                evidenceUrl: "https://storage.supabase.com/evidence/doc.pdf",
                verificationStatus: "pending_review",
              },
            ]),
        }),
        innerJoin: () => ({
          where: () => ({
            limit: () => mocks.resultRowLimit(),
            orderBy: () =>
              Promise.resolve([
                {
                  id: "res-1",
                  rank: 2,
                  regattaName: "LangKawi Regatta",
                  evidenceUrl: "https://storage.supabase.com/evidence/doc.pdf",
                  verificationStatus: "pending_review",
                },
              ]),
          }),
        }),
      }),
    }),
    insert: () => ({
      values: (val: Record<string, unknown>) => {
        if (val.name) {
          mocks.insertRegattaSpy(val);
          const ret = () =>
            Promise.resolve([
              {
                id: "regatta-new",
                name: val.name,
                date: val.date,
                countsForRanking: false,
              },
            ]);
          return {
            returning: ret,
            onConflictDoUpdate: () => ({ returning: ret }),
          };
        }
        mocks.insertResultSpy(val);
        const ret = () =>
          Promise.resolve([
            {
              id: "result-new",
              sailorId: val.sailorId,
              regattaId: "regatta-new",
              rank: val.rank,
              verificationStatus: val.verificationStatus,
              evidenceUrl: val.evidenceUrl,
              officialUrl: val.officialUrl,
            },
          ]);
        return {
          returning: ret,
          onConflictDoUpdate: () => ({ returning: ret }),
        };
      },
    }),
    update: () => ({
      set: (val: Record<string, unknown>) => {
        mocks.updateResultSpy(val);
        return {
          where: () => ({
            returning: () =>
              Promise.resolve([
                {
                  id: "res-1",
                  ...val,
                },
              ]),
          }),
        };
      },
    }),
    delete: () => ({
      where: () => Promise.resolve(undefined),
    }),
  },
}));

import { GET, POST, PATCH } from "./route";

describe("/api/account/results", () => {
  beforeEach(() => {
    mocks.getAuthContext.mockReset();
    mocks.canManageSailor.mockReset();
    mocks.insertRegattaSpy.mockReset();
    mocks.insertResultSpy.mockReset();
    mocks.updateResultSpy.mockReset();
    mocks.resultRowLimit.mockReset();
    mocks.resultRowLimit.mockResolvedValue([{ ...DEFAULT_RESULT_ROW }]);

    mocks.getAuthContext.mockResolvedValue({
      userId: "user-1",
      email: "user@example.com",
      role: "sailor",
    });
    mocks.canManageSailor.mockResolvedValue(true);
  });

  describe("POST with evidence", () => {
    it("sets verificationStatus to pending_review when PDF evidenceUrl is provided", async () => {
      const req = new Request("http://localhost/api/account/results", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          sailorId: "sailor-1",
          name: "Langkawi Regatta",
          date: "2026-02-10",
          rank: 2,
          totalFleetSize: 45,
          evidenceUrl: "https://storage.supabase.com/evidence/doc.pdf",
          evidenceName: "official_results.pdf",
          evidenceType: "pdf",
        }),
      });

      const res = await POST(req);
      expect(res.status).toBe(200);
      const data = await res.json();
      expect(data.ok).toBe(true);

      expect(mocks.insertResultSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          verificationStatus: "pending_review",
          evidenceUrl: "https://storage.supabase.com/evidence/doc.pdf",
          evidenceType: "pdf",
        })
      );
    });

    it("sets verificationStatus to pending_review when officialUrl is provided", async () => {
      const req = new Request("http://localhost/api/account/results", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          sailorId: "sailor-1",
          name: "Pattaya Regatta",
          date: "2026-03-01",
          rank: 5,
          totalFleetSize: 60,
          officialUrl: "https://manage2sail.com/en-US/event/123",
        }),
      });

      const res = await POST(req);
      expect(res.status).toBe(200);

      expect(mocks.insertResultSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          verificationStatus: "pending_review",
          officialUrl: "https://manage2sail.com/en-US/event/123",
        })
      );
    });

    it("sets verificationStatus to self_reported when no evidence is provided", async () => {
      const req = new Request("http://localhost/api/account/results", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          sailorId: "sailor-1",
          name: "Club Regatta",
          date: "2026-04-12",
          rank: 1,
          totalFleetSize: 20,
        }),
      });

      const res = await POST(req);
      expect(res.status).toBe(200);

      expect(mocks.insertResultSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          verificationStatus: "self_reported",
        })
      );
    });
  });

  describe("PATCH result", () => {
    it("updates existing result and resets verificationStatus to pending_review when new evidence is attached", async () => {
      const req = new Request("http://localhost/api/account/results", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          resultId: "res-1",
          evidenceUrl: "https://storage.supabase.com/evidence/new_sheet.pdf",
          evidenceName: "new_sheet.pdf",
        }),
      });

      const res = await PATCH(req);
      expect(res.status).toBe(200);

      expect(mocks.updateResultSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          verificationStatus: "pending_review",
          evidenceUrl: "https://storage.supabase.com/evidence/new_sheet.pdf",
        })
      );
    });

    it("rejects a non-http(s) evidenceUrl", async () => {
      const req = new Request("http://localhost/api/account/results", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          resultId: "res-1",
          evidenceUrl: "javascript:alert(document.cookie)",
        }),
      });

      const res = await PATCH(req);
      expect(res.status).toBe(400);
      expect(mocks.updateResultSpy).not.toHaveBeenCalled();
    });

    it("returns 403 when the caller cannot manage the sailor", async () => {
      mocks.canManageSailor.mockResolvedValue(false);
      const req = new Request("http://localhost/api/account/results", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ resultId: "res-1", rank: 3 }),
      });

      const res = await PATCH(req);
      expect(res.status).toBe(403);
      expect(mocks.updateResultSpy).not.toHaveBeenCalled();
    });

    it("returns 403 for ranking-series results", async () => {
      mocks.resultRowLimit.mockResolvedValue([
        { ...DEFAULT_RESULT_ROW, countsForRanking: true },
      ]);
      const req = new Request("http://localhost/api/account/results", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ resultId: "res-1", rank: 3 }),
      });

      const res = await PATCH(req);
      expect(res.status).toBe(403);
      expect(mocks.updateResultSpy).not.toHaveBeenCalled();
    });

    it("does not rename a shared (non-logbook) regatta when editing one result", async () => {
      mocks.resultRowLimit.mockResolvedValue([
        {
          ...DEFAULT_RESULT_ROW,
          regattaSlug: "snsc-2026-shared-import",
        },
      ]);
      const req = new Request("http://localhost/api/account/results", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          resultId: "res-1",
          rank: 3,
          name: "Renamed By Sailor",
          date: "2026-05-01",
        }),
      });

      const res = await PATCH(req);
      expect(res.status).toBe(200);
      // Only the result row is updated — the shared regatta row is untouched
      expect(mocks.updateResultSpy).toHaveBeenCalledTimes(1);
      expect(mocks.updateResultSpy).not.toHaveBeenCalledWith(
        expect.objectContaining({ name: "Renamed By Sailor" })
      );
    });

    it("keeps verificationStatus when evidence URLs are echoed back unchanged", async () => {
      mocks.resultRowLimit.mockResolvedValue([
        {
          ...DEFAULT_RESULT_ROW,
          evidenceUrl: "https://storage.supabase.com/evidence/doc.pdf",
          verificationStatus: "verified",
        },
      ]);
      const req = new Request("http://localhost/api/account/results", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          resultId: "res-1",
          rank: 4,
          evidenceUrl: "https://storage.supabase.com/evidence/doc.pdf",
        }),
      });

      const res = await PATCH(req);
      expect(res.status).toBe(200);
      expect(mocks.updateResultSpy).not.toHaveBeenCalledWith(
        expect.objectContaining({ verificationStatus: "pending_review" })
      );
    });
  });

  describe("GET results", () => {
    it("returns list of results for sailor", async () => {
      const req = new Request(
        "http://localhost/api/account/results?sailorId=sailor-1"
      );
      const res = await GET(req);
      expect(res.status).toBe(200);
      const data = await res.json();
      expect(data.results).toBeDefined();
      expect(data.results[0].regattaName).toBe("LangKawi Regatta");
    });
  });
});
