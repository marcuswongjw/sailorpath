import { afterAll, beforeAll, beforeEach, describe, expect, it, vi } from "vitest";
import { PGlite } from "@electric-sql/pglite";
import { drizzle } from "drizzle-orm/pglite";
import { eq } from "drizzle-orm";
import { profiles, sailorClaims, sailors } from "@/db/schema";

const state = vi.hoisted(() => ({ db: null as unknown }));

vi.mock("@/db", () => ({
  get db() {
    return state.db;
  },
  ensureCoreSchema: async () => {},
}));

vi.mock("@/lib/auth", () => ({
  requireSuperadmin: async () => ({
    userId: "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa",
    email: "admin@example.com",
    role: "superadmin",
  }),
  getAuthContext: async () => ({
    userId: "11111111-1111-4111-8111-111111111111",
    email: "shingyenn@example.com",
    role: "sailor",
  }),
  jsonError: (error: unknown) => {
    const message = error instanceof Error ? error.message : "Error";
    return Response.json({ error: message }, { status: 500 });
  },
}));

vi.mock("@/lib/adminChangeLog", () => ({
  logAdminChange: vi.fn().mockResolvedValue(undefined),
}));

vi.mock("@/lib/sailorInviteNotify", () => ({
  notifySailorAssignmentInvite: vi.fn().mockResolvedValue("sent"),
}));

vi.mock("@/lib/roleChangeNotify", () => ({
  notifyAccountRoleChange: vi.fn().mockResolvedValue("sent"),
}));

vi.mock("@/lib/usage", () => ({
  trackUsage: vi.fn().mockResolvedValue(undefined),
}));

import { POST as assignSailor } from "./route";
import { POST as respondToInvite } from "@/app/api/account/sailor-invites/route";
import { notifySailorAssignmentInvite } from "@/lib/sailorInviteNotify";

const pg = new PGlite();
const testDb = drizzle(pg);

const userId = "11111111-1111-4111-8111-111111111111";
const sailorId = "22222222-2222-4222-8222-222222222222";

beforeAll(async () => {
  // Production shape before migration 086: sailor_claims has no heard_about column.
  await pg.exec(`
    CREATE TABLE profiles (
      id uuid PRIMARY KEY,
      email text NOT NULL,
      full_name text NOT NULL,
      role text NOT NULL DEFAULT 'sailor',
      updated_at timestamp NOT NULL DEFAULT now()
    );
    CREATE TABLE sailors (
      id uuid PRIMARY KEY,
      name text NOT NULL,
      parent_id uuid,
      owner_relation text,
      updated_at timestamp NOT NULL DEFAULT now()
    );
    CREATE TABLE sailor_claims (
      id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
      sailor_id uuid NOT NULL,
      requester_id uuid NOT NULL,
      status text NOT NULL DEFAULT 'pending',
      relation text,
      source text NOT NULL DEFAULT 'user',
      note text,
      created_at timestamp NOT NULL DEFAULT now(),
      updated_at timestamp NOT NULL DEFAULT now(),
      CONSTRAINT sailor_claims_source_check CHECK (source IN ('user', 'admin'))
    );
  `);
  state.db = testDb;
}, 30000);

beforeEach(async () => {
  vi.mocked(notifySailorAssignmentInvite).mockClear();
  await pg.exec(`
    TRUNCATE sailor_claims, sailors, profiles;
    INSERT INTO profiles (id, email, full_name, role)
    VALUES ('${userId}', 'shingyenn@example.com', 'Tan Shing Yenn', 'sailor');
    INSERT INTO sailors (id, name)
    VALUES ('${sailorId}', 'Joshua Zhi Kai Tan');
  `);
});

afterAll(async () => {
  await pg.close();
});

function assignRequest(note = "Assigned directly by admin") {
  return assignSailor(
    new Request("https://sailorpath.com/api/admin/claims", {
      method: "POST",
      headers: { "content-type": "application/json" },
      body: JSON.stringify({
        userId,
        sailorId,
        relation: "parent",
        note,
      }),
    })
  );
}

describe("POST /api/admin/claims without heard_about", () => {
  it("invites a parent when sailor_claims has no heard_about column", async () => {
    const res = await assignRequest();
    expect(res.status).toBe(200);
    const data = await res.json();
    expect(data.invited).toBe(true);
    expect(data.claim.heardAbout).toBeUndefined();

    const [claim] = await testDb
      .select({
        sailorId: sailorClaims.sailorId,
        requesterId: sailorClaims.requesterId,
        status: sailorClaims.status,
        relation: sailorClaims.relation,
        source: sailorClaims.source,
        note: sailorClaims.note,
      })
      .from(sailorClaims);
    expect(claim).toMatchObject({
      sailorId,
      requesterId: userId,
      status: "pending",
      relation: "parent",
      source: "admin",
      note: "Assigned directly by admin",
    });
    expect(notifySailorAssignmentInvite).toHaveBeenCalledWith(
      expect.objectContaining({
        to: "shingyenn@example.com",
        name: "Tan Shing Yenn",
        sailorName: "Joshua Zhi Kai Tan",
        relation: "parent",
      })
    );
  });

  it("reopens a rejected claim as a pending admin invitation", async () => {
    await pg.exec(`
      INSERT INTO sailor_claims (sailor_id, requester_id, status, relation, source, note)
      VALUES ('${sailorId}', '${userId}', 'rejected', 'other', 'user', 'old');
    `);

    const res = await assignRequest("Assigned by admin via support request");
    expect(res.status).toBe(200);
    const data = await res.json();
    expect(data.invited).toBe(true);

    const rows = await testDb
      .select({
        status: sailorClaims.status,
        relation: sailorClaims.relation,
        source: sailorClaims.source,
        note: sailorClaims.note,
      })
      .from(sailorClaims);
    expect(rows).toEqual([
      {
        status: "pending",
        relation: "parent",
        source: "admin",
        note: "Assigned by admin via support request",
      },
    ]);
  });

  it("does not send another invitation when the sailor is already linked", async () => {
    await pg.exec(`
      INSERT INTO sailor_claims (sailor_id, requester_id, status, relation, source)
      VALUES ('${sailorId}', '${userId}', 'approved', 'parent', 'user');
    `);

    const res = await assignRequest();
    expect(res.status).toBe(200);
    const data = await res.json();
    expect(data.alreadyLinked).toBe(true);
    expect(notifySailorAssignmentInvite).not.toHaveBeenCalled();
  });

  it("lets the invited account accept the link without heard_about", async () => {
    const invited = await assignRequest();
    expect(invited.status).toBe(200);
    const { claim } = await invited.json();

    const res = await respondToInvite(
      new Request("https://sailorpath.com/api/account/sailor-invites", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ id: claim.id, action: "accept" }),
      })
    );
    expect(res.status).toBe(200);
    expect(await res.json()).toMatchObject({ ok: true, status: "approved" });

    const [claimRow] = await testDb
      .select({ status: sailorClaims.status })
      .from(sailorClaims)
      .where(eq(sailorClaims.id, claim.id));
    expect(claimRow?.status).toBe("approved");

    const [sailor] = await testDb
      .select({
        parentId: sailors.parentId,
        ownerRelation: sailors.ownerRelation,
      })
      .from(sailors)
      .where(eq(sailors.id, sailorId));
    expect(sailor).toMatchObject({
      parentId: userId,
      ownerRelation: "parent",
    });

    const [profile] = await testDb
      .select({ role: profiles.role })
      .from(profiles)
      .where(eq(profiles.id, userId));
    expect(profile?.role).toBe("parent");
  });
});
