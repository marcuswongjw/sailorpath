import { afterAll, beforeAll, describe, expect, it, vi } from "vitest";
import { PGlite } from "@electric-sql/pglite";
import { drizzle } from "drizzle-orm/pglite";
const mock = vi.hoisted(() => ({ db: undefined as unknown }));
vi.mock("@/db", () => ({ db: new Proxy({}, { get: (_, key) => {
  const value = (mock.db as Record<PropertyKey, unknown>)[key];
  return typeof value === "function" ? value.bind(mock.db) : value;
} }) }));
import { canGiveGuardianConsent } from "./claimAccess";
let database: PGlite;
beforeAll(async () => {
  database = new PGlite(); mock.db = drizzle(database);
  await database.exec(`create table sailor_claims (id text, sailor_id text, requester_id text, status text, relation text);
    insert into sailor_claims values
    ('1', 'sailor', 'additional-parent', 'approved', 'parent'),
    ('2', 'sailor', 'child', 'approved', 'sailor'),
    ('3', 'sailor', 'other', 'approved', 'other'),
    ('4', 'sailor', 'pending-parent', 'pending', 'parent'),
    ('5', 'different-sailor', 'unrelated-parent', 'approved', 'parent');`);
});
afterAll(async () => database.close());
describe("actor-specific guardian authorization", () => {
  const owner = { parentId: "primary-parent", ownerRelation: "parent" };
  it("allows the primary parent and an additional approved parent", async () => {
    expect(await canGiveGuardianConsent("sailor", "primary-parent", owner)).toBe(true);
    expect(await canGiveGuardianConsent("sailor", "additional-parent", owner)).toBe(true);
  });
  it.each(["child", "other", "pending-parent", "unrelated-parent", "unlinked"])("denies %s even when another owner is a parent", async (user) => {
    expect(await canGiveGuardianConsent("sailor", user, owner)).toBe(false);
  });
  it("does not treat primary ownership alone as guardian authority", async () => {
    expect(await canGiveGuardianConsent("sailor", "primary-parent", { ...owner, ownerRelation: "sailor" })).toBe(false);
  });
});
