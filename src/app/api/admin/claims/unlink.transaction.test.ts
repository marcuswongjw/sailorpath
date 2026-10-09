import { afterAll, beforeAll, beforeEach, describe, expect, it, vi } from "vitest";
import { PGlite } from "@electric-sql/pglite";
import { drizzle } from "drizzle-orm/pglite";
import { eq } from "drizzle-orm";
import { profiles, sailorClaims, sailors } from "@/db/schema";

const state = vi.hoisted(() => ({ db: null as unknown }));

vi.mock("@/db", () => ({
  get db() { return state.db; },
}));
vi.mock("@/lib/auth", () => ({
  requireSuperadmin: vi.fn().mockResolvedValue({
    userId: "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa",
    email: "admin@example.com",
    role: "superadmin",
  }),
  jsonError: (error: unknown) => Response.json({
    error: error instanceof Error ? error.message : "Error",
  }, { status: 500 }),
}));
vi.mock("@/lib/adminChangeLog", () => ({ logAdminChange: vi.fn().mockResolvedValue(undefined) }));
vi.mock("@/lib/usage", () => ({ trackUsage: vi.fn().mockResolvedValue(undefined) }));
vi.mock("@/lib/roleChangeNotify", () => ({ notifyAccountRoleChange: vi.fn().mockResolvedValue("sent") }));
vi.mock("@/lib/sailorInviteNotify", () => ({ notifySailorAssignmentInvite: vi.fn().mockResolvedValue("sent") }));

import { PATCH } from "./route";
import { logAdminChange } from "@/lib/adminChangeLog";
import { trackUsage } from "@/lib/usage";
import { notifyAccountRoleChange } from "@/lib/roleChangeNotify";
import { requireSuperadmin } from "@/lib/auth";

const pg = new PGlite();
const queries: string[] = [];
const testDb = drizzle(pg, {
  logger: { logQuery: (query) => { queries.push(query); } },
});
const ownerId = "11111111-1111-4111-8111-111111111111";
const secondId = "22222222-2222-4222-8222-222222222222";
const thirdId = "33333333-3333-4333-8333-333333333333";
const pendingId = "44444444-4444-4444-8444-444444444444";
const rejectedId = "55555555-5555-4555-8555-555555555555";
const sailorId = "66666666-6666-4666-8666-666666666666";
const otherSailorId = "77777777-7777-4777-8777-777777777777";
const claimId = "aaaaaaaa-aaaa-4aaa-8aaa-000000000001";
const secondClaimId = "aaaaaaaa-aaaa-4aaa-8aaa-000000000002";
const thirdClaimId = "aaaaaaaa-aaaa-4aaa-8aaa-000000000003";
const pendingClaimId = "aaaaaaaa-aaaa-4aaa-8aaa-000000000004";
const rejectedClaimId = "aaaaaaaa-aaaa-4aaa-8aaa-000000000005";

beforeAll(async () => {
  // Deliberately omit heard_about to retain the legacy-production compatibility.
  await pg.exec(`
    CREATE TABLE profiles (
      id uuid PRIMARY KEY, email text NOT NULL, full_name text NOT NULL,
      role text NOT NULL DEFAULT 'sailor', updated_at timestamp NOT NULL DEFAULT now()
    );
    CREATE TABLE sailors (
      id uuid PRIMARY KEY, name text NOT NULL,
      parent_id uuid REFERENCES profiles(id), owner_relation text,
      updated_at timestamp NOT NULL DEFAULT now()
    );
    CREATE TABLE sailor_claims (
      id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
      sailor_id uuid NOT NULL REFERENCES sailors(id),
      requester_id uuid NOT NULL REFERENCES profiles(id),
      status text NOT NULL DEFAULT 'pending', relation text,
      source text NOT NULL DEFAULT 'user', note text,
      created_at timestamp NOT NULL DEFAULT now(), updated_at timestamp NOT NULL DEFAULT now()
    );
    CREATE FUNCTION fail_owner_write() RETURNS trigger LANGUAGE plpgsql AS $$
    BEGIN RAISE EXCEPTION 'forced owner update failure'; END;
    $$;
    CREATE FUNCTION fail_profile_write() RETURNS trigger LANGUAGE plpgsql AS $$
    BEGIN RAISE EXCEPTION 'forced profile update failure'; END;
    $$;
  `);
  state.db = testDb;
}, 30000);

beforeEach(async () => {
  vi.clearAllMocks();
  state.db = testDb;
  queries.length = 0;
  await pg.exec(`
    DROP TRIGGER IF EXISTS fail_owner_write ON sailors;
    DROP TRIGGER IF EXISTS fail_profile_write ON profiles;
    TRUNCATE sailor_claims, sailors, profiles;
    INSERT INTO profiles (id, email, full_name, role) VALUES
      ('${ownerId}', 'owner@example.com', 'Primary Parent', 'parent'),
      ('${secondId}', 'second@example.com', 'Second Parent', 'parent'),
      ('${thirdId}', 'third@example.com', 'Sailor Account', 'sailor'),
      ('${pendingId}', 'pending@example.com', 'Pending Parent', 'parent'),
      ('${rejectedId}', 'rejected@example.com', 'Rejected Parent', 'parent');
    INSERT INTO sailors (id, name, parent_id, owner_relation) VALUES
      ('${sailorId}', 'Test Sailor', '${ownerId}', 'parent'),
      ('${otherSailorId}', 'Other Sailor', NULL, NULL);
    INSERT INTO sailor_claims (id, sailor_id, requester_id, status, relation, created_at) VALUES
      ('${claimId}', '${sailorId}', '${ownerId}', 'approved', 'parent', '2026-01-01'),
      ('${secondClaimId}', '${sailorId}', '${secondId}', 'approved', 'parent', '2026-03-01'),
      ('${thirdClaimId}', '${sailorId}', '${thirdId}', 'approved', 'sailor', '2026-02-01'),
      ('${pendingClaimId}', '${sailorId}', '${pendingId}', 'pending', 'parent', '2025-01-01'),
      ('${rejectedClaimId}', '${sailorId}', '${rejectedId}', 'rejected', 'parent', '2024-01-01');
  `);
});

afterAll(async () => { await pg.close(); });

function patch(body: Record<string, unknown>) {
  return PATCH(new Request("https://sailorpath.com/api/admin/claims", {
    method: "PATCH", headers: { "content-type": "application/json" },
    body: JSON.stringify({ id: claimId, ...body }),
  }));
}

async function savedClaim(id = claimId) {
  const [claim] = await testDb.select({
    id: sailorClaims.id, status: sailorClaims.status, relation: sailorClaims.relation,
    updatedAt: sailorClaims.updatedAt,
  }).from(sailorClaims).where(eq(sailorClaims.id, id));
  return claim;
}

async function savedOwner() {
  const [sailor] = await testDb.select({
    parentId: sailors.parentId, ownerRelation: sailors.ownerRelation,
  }).from(sailors).where(eq(sailors.id, sailorId));
  return sailor;
}

async function savedRoles() {
  return testDb.select({ id: profiles.id, role: profiles.role }).from(profiles).orderBy(profiles.id);
}

function expectNoEffects() {
  expect(logAdminChange).not.toHaveBeenCalled();
  expect(trackUsage).not.toHaveBeenCalled();
  expect(notifyAccountRoleChange).not.toHaveBeenCalled();
}

function changeBeforeTransaction(sql: string) {
  state.db = {
    select: testDb.select.bind(testDb),
    transaction: async (work: Parameters<typeof testDb.transaction>[0]) => {
      await pg.exec(sql);
      return testDb.transaction(work);
    },
  };
}

describe("PATCH /api/admin/claims transactional unlink", () => {
  it("returns the saved rejection and promotes the earliest-created approved claim", async () => {
    const roles = await savedRoles();
    const res = await patch({ unclaim: true });
    expect(res.status).toBe(200);
    const data = await res.json();
    const stored = await savedClaim();
    expect(data.claim).toMatchObject({ id: claimId, status: "rejected", relation: stored.relation });
    expect(data.claim.updatedAt).toBe(stored.updatedAt.toISOString());
    expect(stored.status).toBe("rejected");
    // Third claimant was inserted after the second, but has an earlier createdAt.
    expect(await savedOwner()).toEqual({ parentId: thirdId, ownerRelation: "sailor" });
    expect((await savedClaim(secondClaimId)).status).toBe("approved");
    expect((await savedClaim(thirdClaimId)).status).toBe("approved");
    expect(await savedRoles()).toEqual(roles);
    expect(notifyAccountRoleChange).not.toHaveBeenCalled();
    expect(logAdminChange).toHaveBeenCalledWith(expect.objectContaining({
      action: "claim.unlink", details: expect.objectContaining({ status: "rejected", unclaim: true }),
    }));
    expect(trackUsage).toHaveBeenCalledWith(expect.objectContaining({ eventType: "claim_rejected" }));
  });

  it("uses the lower claim ID as a stable tie-breaker", async () => {
    await pg.exec(`UPDATE sailor_claims SET created_at = '2026-02-01' WHERE id = '${secondClaimId}'`);
    const res = await patch({ unclaim: true });
    expect(res.status).toBe(200);
    expect(await savedOwner()).toEqual({ parentId: secondId, ownerRelation: "parent" });
  });

  it("does not use updatedAt as approval time", async () => {
    await pg.exec(`UPDATE sailor_claims SET updated_at = '2030-01-01' WHERE id = '${thirdClaimId}'`);
    expect((await patch({ unclaim: true })).status).toBe(200);
    expect((await savedOwner()).parentId).toBe(thirdId);
  });

  it("clears ownership when no approved claims remain, excluding other sailors", async () => {
    await pg.exec(`
      UPDATE sailor_claims SET status = 'rejected' WHERE id IN ('${secondClaimId}', '${thirdClaimId}');
      INSERT INTO sailor_claims (sailor_id, requester_id, status, relation, created_at)
      VALUES ('${otherSailorId}', '${secondId}', 'approved', 'parent', '2020-01-01');
    `);
    expect((await patch({ unclaim: true })).status).toBe(200);
    expect(await savedOwner()).toEqual({ parentId: null, ownerRelation: null });
  });

  it("keeps the primary owner when a secondary approved claimant unlinks", async () => {
    const res = await patch({ id: thirdClaimId, unclaim: true });
    expect(res.status).toBe(200);
    expect((await res.json()).claim.status).toBe("rejected");
    expect(await savedOwner()).toEqual({ parentId: ownerId, ownerRelation: "parent" });
    expect((await savedClaim()).status).toBe("approved");
  });

  it("applies the same replacement rule when a primary claim is explicitly rejected", async () => {
    const res = await patch({ status: "rejected" });
    expect(res.status).toBe(200);
    expect((await res.json()).claim.status).toBe("rejected");
    expect((await savedOwner()).parentId).toBe(thirdId);
    expect(logAdminChange).toHaveBeenCalledWith(expect.objectContaining({ action: "claim.reject" }));
  });

  it("does not leave a pending claimant as primary", async () => {
    expect((await patch({ status: "pending" })).status).toBe(200);
    expect((await savedClaim()).status).toBe("pending");
    expect((await savedOwner()).parentId).toBe(thirdId);
    expectNoEffects();
  });

  it("takes unlink precedence over approval without changing roles or emailing approval", async () => {
    await pg.exec(`UPDATE profiles SET role = 'sailor' WHERE id = '${ownerId}'`);
    const roles = await savedRoles();
    const res = await patch({ status: "approved", relation: "parent", unclaim: true });
    expect(res.status).toBe(200);
    expect((await res.json()).claim.status).toBe("rejected");
    expect(await savedRoles()).toEqual(roles);
    expect(notifyAccountRoleChange).not.toHaveBeenCalled();
    expect(trackUsage).toHaveBeenCalledWith(expect.objectContaining({ eventType: "claim_rejected" }));
  });

  it("unlinks a legacy claim with no known relation without approval validation", async () => {
    await pg.exec(`UPDATE sailor_claims SET relation = NULL WHERE id = '${claimId}'`);
    expect((await patch({ status: "approved", unclaim: true })).status).toBe(200);
    expect((await savedClaim()).status).toBe("rejected");
  });

  it("derives a replacement owner's relation from legacy note metadata", async () => {
    await pg.exec(`UPDATE sailor_claims SET relation = NULL, note = '[sailor] Legacy self claim' WHERE id = '${thirdClaimId}'`);
    expect((await patch({ unclaim: true })).status).toBe(200);
    expect(await savedOwner()).toEqual({ parentId: thirdId, ownerRelation: "sailor" });
  });

  it("does not skip the earliest approved claimant just because their relation is unknown", async () => {
    await pg.exec(`UPDATE sailor_claims SET relation = NULL, note = 'Legacy claim' WHERE id = '${thirdClaimId}'`);
    expect((await patch({ unclaim: true })).status).toBe(200);
    expect(await savedOwner()).toEqual({ parentId: thirdId, ownerRelation: null });
  });

  it("is safe to repeat unlink without disturbing the promoted owner", async () => {
    expect((await patch({ unclaim: true })).status).toBe(200);
    expect((await patch({ unclaim: true })).status).toBe(200);
    expect((await savedClaim()).status).toBe("rejected");
    expect(await savedOwner()).toEqual({ parentId: thirdId, ownerRelation: "sailor" });
  });

  it("rolls back rejection if the owner update fails and emits no success effects", async () => {
    await pg.exec(`CREATE TRIGGER fail_owner_write BEFORE UPDATE ON sailors FOR EACH ROW EXECUTE FUNCTION fail_owner_write()`);
    const before = await savedClaim();
    vi.spyOn(console, "error").mockImplementation(() => {});
    try {
      const res = await patch({ unclaim: true });
      expect(res.status).toBe(500);
      expect(await savedClaim()).toEqual(before);
      expect(await savedOwner()).toEqual({ parentId: ownerId, ownerRelation: "parent" });
      expectNoEffects();
    } finally { vi.restoreAllMocks(); }
  });

  it("rolls back approval and ownership if the account-role write fails", async () => {
    await pg.exec(`
      UPDATE sailors SET parent_id = NULL, owner_relation = NULL WHERE id = '${sailorId}';
      UPDATE sailor_claims SET status = 'pending' WHERE id = '${claimId}';
      UPDATE profiles SET role = 'sailor' WHERE id = '${ownerId}';
      CREATE TRIGGER fail_profile_write BEFORE UPDATE ON profiles FOR EACH ROW EXECUTE FUNCTION fail_profile_write();
    `);
    vi.spyOn(console, "error").mockImplementation(() => {});
    try {
      expect((await patch({ status: "approved", relation: "parent" })).status).toBe(500);
      expect((await savedClaim()).status).toBe("pending");
      expect(await savedOwner()).toEqual({ parentId: null, ownerRelation: null });
      expect((await savedRoles()).find(p => p.id === ownerId)?.role).toBe("sailor");
      expectNoEffects();
    } finally { vi.restoreAllMocks(); }
  });

  it("updates the primary relation and role once, with one post-commit notice", async () => {
    const res = await patch({ relation: "sailor" });
    expect(res.status).toBe(200);
    expect((await savedClaim()).relation).toBe("sailor");
    expect(await savedOwner()).toEqual({ parentId: ownerId, ownerRelation: "sailor" });
    expect((await savedRoles()).find(p => p.id === ownerId)?.role).toBe("sailor");
    expect(notifyAccountRoleChange).toHaveBeenCalledTimes(1);
    expect(notifyAccountRoleChange).toHaveBeenCalledWith(expect.objectContaining({
      previousRole: "parent", nextRole: "sailor", sailorName: "Test Sailor",
    }));
  });

  it("does not change roles when setAccountRole is false", async () => {
    const roles = await savedRoles();
    expect((await patch({ relation: "sailor", setAccountRole: false })).status).toBe(200);
    expect(await savedRoles()).toEqual(roles);
    expect(notifyAccountRoleChange).not.toHaveBeenCalled();
  });

  it("approves a secondary account without replacing the primary owner", async () => {
    expect((await patch({ id: pendingClaimId, status: "approved", relation: "parent" })).status).toBe(200);
    expect((await savedClaim(pendingClaimId)).status).toBe("approved");
    expect((await savedOwner()).parentId).toBe(ownerId);
  });

  it("locks the sailor before the claim and locks the selected replacement", async () => {
    expect((await patch({ unclaim: true })).status).toBe(200);
    const locks = queries.filter(query => query.endsWith("for update"));
    expect(locks).toHaveLength(3);
    expect(locks[0]).toContain('from "sailors"');
    expect(locks[1]).toContain('from "sailor_claims"');
    expect(locks[2]).toContain('order by "sailor_claims"."created_at" asc, "sailor_claims"."id" asc');
  });

  it("re-reads claim metadata after taking the ownership lock", async () => {
    changeBeforeTransaction(`UPDATE sailor_claims SET relation = 'sailor' WHERE id = '${claimId}'`);
    const res = await patch({ unclaim: true });
    expect(res.status).toBe(200);
    expect(await res.json()).toMatchObject({ relation: "sailor", claim: { relation: "sailor", status: "rejected" } });
  });

  it("returns 404 if the claim disappears between lookup and transaction", async () => {
    changeBeforeTransaction(`DELETE FROM sailor_claims WHERE id = '${claimId}'`);
    expect((await patch({ unclaim: true })).status).toBe(404);
    expect((await savedOwner()).parentId).toBe(ownerId);
    expectNoEffects();
  });

  it("returns 409 without mutation if the claim moves to another sailor", async () => {
    changeBeforeTransaction(`UPDATE sailor_claims SET sailor_id = '${otherSailorId}' WHERE id = '${claimId}'`);
    expect((await patch({ unclaim: true })).status).toBe(409);
    expect((await savedClaim()).status).toBe("approved");
    expect((await savedOwner()).parentId).toBe(ownerId);
    expectNoEffects();
  });

  it("emits audit and usage events only after commit", async () => {
    const effects: string[] = [];
    const committedStatus: string[] = [];
    state.db = {
      select: testDb.select.bind(testDb),
      transaction: async (work: Parameters<typeof testDb.transaction>[0]) => {
        const result = await testDb.transaction(work);
        effects.push("committed");
        return result;
      },
    };
    vi.mocked(trackUsage).mockImplementationOnce(async () => {
      effects.push("usage");
      return { ok: true };
    });
    vi.mocked(logAdminChange).mockImplementationOnce(async () => {
      effects.push("audit");
      committedStatus.push((await savedClaim()).status);
      return { ok: true };
    });
    expect((await patch({ unclaim: true })).status).toBe(200);
    expect(effects).toEqual(["committed", "usage", "audit"]);
    await vi.waitFor(() => { expect(committedStatus).toEqual(["rejected"]); });
  });

  it("returns 404 for an unknown claim without writes or effects", async () => {
    expect((await patch({ id: "aaaaaaaa-aaaa-4aaa-8aaa-000000000099", unclaim: true })).status).toBe(404);
    expect((await savedClaim()).status).toBe("approved");
    expectNoEffects();
  });

  it.each([
    { status: "invalid" },
    { relation: "invalid" },
  ])("rejects invalid input before changing claim or owner: %j", async body => {
    expect((await patch(body)).status).toBe(400);
    expect((await savedClaim()).status).toBe("approved");
    expect((await savedOwner()).parentId).toBe(ownerId);
    expectNoEffects();
  });

  it("does not approve a claim with no relation", async () => {
    await pg.exec(`UPDATE sailor_claims SET status = 'pending', relation = NULL WHERE id = '${claimId}'`);
    expect((await patch({ status: "approved" })).status).toBe(400);
    expect((await savedClaim()).status).toBe("pending");
    expectNoEffects();
  });

  it("requires superadmin before touching the database", async () => {
    vi.mocked(requireSuperadmin).mockRejectedValueOnce(new Error("Forbidden"));
    const transaction = vi.spyOn(testDb, "transaction");
    vi.spyOn(console, "error").mockImplementation(() => {});
    try {
      expect((await patch({ unclaim: true })).status).toBe(500);
      expect(transaction).not.toHaveBeenCalled();
      expect((await savedClaim()).status).toBe("approved");
      expectNoEffects();
    } finally { vi.restoreAllMocks(); }
  });
});
