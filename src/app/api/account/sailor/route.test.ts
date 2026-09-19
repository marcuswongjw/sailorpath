import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  getAuthContext: vi.fn(),
  canManageSailor: vi.fn(),
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
              dob: "2012-05-15",
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
