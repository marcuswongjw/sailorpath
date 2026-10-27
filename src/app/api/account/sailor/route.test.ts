import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  getAuthContext: vi.fn(),
  canManageSailor: vi.fn(),
  canGiveGuardianConsent: vi.fn(),
  sailor: { dob: "2012-05-15", parentId: "parent-1", ownerRelation: "parent" } as Record<string, string | null>,
  updateSet: vi.fn(),
}));

vi.mock("@/lib/auth", () => ({
  getAuthContext: mocks.getAuthContext,
  jsonError: (error: unknown) => {
    const message = error instanceof Error ? error.message : "Error";
    return Response.json({ error: message }, { status: 400 });
  },
}));

vi.mock("@/lib/claimAccess", () => ({
  canManageSailor: mocks.canManageSailor,
  canGiveGuardianConsent: mocks.canGiveGuardianConsent,
}));

vi.mock("@/db", () => ({
  db: {
    select: () => ({
      from: () => ({
        where: () => ({
          limit: vi.fn().mockResolvedValue([
            {
              id: "sailor-1",
              name: "Sailor One",
              handle: "sailor-one",
              parentId: "parent-1",
              ...mocks.sailor,
            },
          ]),
        }),
      }),
    }),
    update: () => ({
      set: (values: unknown) => {
        const valObj = values as Record<string, unknown>;
        mocks.updateSet(values);
        return {
          where: () => ({
            returning: vi.fn().mockResolvedValue([
              {
                id: "sailor-1",
                handle: "sailor-one",
                dob: valObj?.dob !== undefined ? valObj.dob : "2012-05-15",
              },
            ]),
            then: (resolve: (v: unknown) => unknown) =>
              Promise.resolve(undefined).then(resolve),
          }),
        };
      },
    }),
    insert: () => ({
      values: () => ({
        onConflictDoNothing: vi.fn().mockResolvedValue(undefined),
      }),
    }),
  },
}));

import { PATCH } from "./route";

describe("PATCH /api/account/sailor", () => {
  beforeEach(() => {
    mocks.getAuthContext.mockReset();
    mocks.canManageSailor.mockReset();
    mocks.updateSet.mockReset();

    mocks.getAuthContext.mockResolvedValue({
      userId: "parent-1",
      email: "parent@example.com",
      role: "parent",
    });
    mocks.canManageSailor.mockResolvedValue(true);
    mocks.canGiveGuardianConsent.mockReset().mockResolvedValue(true);
    mocks.sailor = { dob: "2012-05-15", parentId: "parent-1", ownerRelation: "parent" };
  });

  async function patch(body: Record<string, unknown>) {
    return PATCH(new Request("https://sailorpath.com/api/account/sailor", {
      method: "PATCH", headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ sailorId: "11111111-1111-4111-8111-111111111111", ...body }),
    }));
  }
  it.each(["sailor", "other"])("denies visibility changes by an approved %s even when the primary owner is a parent", async (relation) => {
    mocks.getAuthContext.mockResolvedValue({ userId: `claimant-${relation}`, role: "sailor" });
    mocks.canGiveGuardianConsent.mockResolvedValue(false);
    expect((await patch({ showSchoolOnPublicProfile: true })).status).toBe(403);
    expect(mocks.updateSet).not.toHaveBeenCalled();
  });
  it("allows an additional approved guardian rather than checking the primary owner's relation", async () => {
    mocks.sailor.ownerRelation = "sailor";
    mocks.getAuthContext.mockResolvedValue({ userId: "additional-parent", role: "parent" });
    expect((await patch({ showSchoolOnPublicProfile: true })).status).toBe(200);
    expect(mocks.canGiveGuardianConsent).toHaveBeenCalledWith(expect.any(String), "additional-parent", expect.objectContaining({ ownerRelation: "sailor" }));
  });
  it("requires guardian consent when age is unknown", async () => {
    mocks.sailor.dob = null;
    mocks.canGiveGuardianConsent.mockResolvedValue(false);
    expect((await patch({ showSchoolOnPublicProfile: true })).status).toBe(403);
  });
  it("prevents a child changing DOB to evade the visibility guard", async () => {
    mocks.canGiveGuardianConsent.mockResolvedValue(false);
    expect((await patch({ dob: "2000-01-01" })).status).toBe(403);
    expect(mocks.updateSet).not.toHaveBeenCalled();
  });
  it("allows adult self-consent", async () => {
    mocks.sailor.dob = "2000-01-01";
    mocks.canGiveGuardianConsent.mockResolvedValue(false);
    expect((await patch({ showSchoolOnPublicProfile: true })).status).toBe(200);
    expect(mocks.canGiveGuardianConsent).not.toHaveBeenCalled();
  });
  it("allows superadmin changes without a guardian claim", async () => {
    mocks.getAuthContext.mockResolvedValue({ userId: "admin", role: "superadmin" });
    mocks.canGiveGuardianConsent.mockResolvedValue(false);
    expect((await patch({ showSchoolOnPublicProfile: true })).status).toBe(200);
  });

  it("updates regattaResults birthYear when dob is edited", async () => {
    const req = new Request("https://sailorpath.com/api/account/sailor", {
      method: "PATCH",
      headers: { "content-type": "application/json" },
      body: JSON.stringify({
        sailorId: "11111111-1111-4111-8111-111111111111",
        dob: "2013-08-20",
      }),
    });

    const res = await PATCH(req);
    expect(res.status).toBe(200);

    // Verify regattaResults was stamped with birthYear: 2013
    const stampedResultUpdates = mocks.updateSet.mock.calls.filter(
      (args) => (args[0] as Record<string, unknown>)?.birthYear === 2013
    );
    expect(stampedResultUpdates).toHaveLength(1);
  });
});
