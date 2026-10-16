import { readFileSync } from "node:fs";
import { PGlite } from "@electric-sql/pglite";
import { drizzle, type PgliteDatabase } from "drizzle-orm/pglite";
import { afterAll, beforeAll, beforeEach, describe, expect, it, vi } from "vitest";
import * as schema from "@/db/schema";

const state = vi.hoisted(() => ({ db: null as unknown as PgliteDatabase<typeof schema> }));
vi.mock("@/db", () => ({ get db() { return state.db; } }));
vi.mock("@/lib/auth", () => ({
  requireSuperadmin: async () => ({ userId: "admin", email: "admin@example.com" }),
  jsonError: () => Response.json({ error: "Delete failed" }, { status: 500 }),
}));
vi.mock("next/cache", () => ({ revalidatePath: vi.fn() }));
vi.mock("@/lib/revalidatePublic", () => ({ revalidatePublicRankings: vi.fn() }));
vi.mock("@/lib/adminChangeLog", () => ({ logAdminChange: vi.fn() }));
import { DELETE } from "./route";

let database: PGlite;
const eventId = "00000000-0000-4000-8000-000000000001";
const sheetId = "00000000-0000-4000-8000-000000000002";
const migration = readFileSync(new URL("../../../../db/migrations/20261016070501_persist_regatta_event_deletions.sql", import.meta.url), "utf8");

beforeAll(async () => {
  database = new PGlite();
  state.db = drizzle(database, { schema });
  await database.exec(`
    CREATE ROLE anon; CREATE ROLE authenticated; CREATE ROLE service_role BYPASSRLS;
    CREATE TABLE admin_change_log (action text, details jsonb, created_at timestamptz);
    INSERT INTO admin_change_log VALUES
      ('regatta_event_delete', '{"slug":"old-event"}', '2026-10-01'),
      ('regatta_event_delete', '{"slug":"old-event"}', '2026-10-02'),
      ('regatta_event_update', '{"slug":"kept-event"}', '2026-10-03');
    CREATE TABLE regatta_events (
      id uuid PRIMARY KEY, slug text, name text, start_date date, end_date date, venue text,
      organizer text, classes jsonb, nor_url text, registration_url text,
      counts_for_ranking boolean, is_selection_trial boolean, key_deadlines text,
      schedule_summary text, scoring_rules text, created_at timestamptz, updated_at timestamptz
    );
    CREATE TABLE regattas (
      id uuid PRIMARY KEY, event_id uuid REFERENCES regatta_events(id), name text, slug text,
      date date, boat_class text, division text, status text, race_count int, counts_for_ranking boolean
    );
    CREATE TABLE deletion_blockers (regatta_id uuid REFERENCES regattas(id));
    CREATE TABLE test_results (regatta_id uuid REFERENCES regattas(id) ON DELETE CASCADE);
  `);
  await database.exec(migration);
});
afterAll(async () => { await database.close(); });
beforeEach(async () => {
  await database.exec("TRUNCATE deletion_blockers, test_results, regattas, regatta_events, regatta_event_deletions;");
});

async function seed(withSheet: boolean) {
  await database.query("INSERT INTO regatta_events (id, slug, name) VALUES ($1, 'test-weekend', 'Test Weekend')", [eventId]);
  if (withSheet) {
    await database.query("INSERT INTO regattas VALUES ($1, $2, 'Test Class', 'test-class', '2026-10-01', 'Optimist', 'Gold', 'published', 4, true)", [sheetId, eventId]);
    await database.query("INSERT INTO test_results VALUES ($1)", [sheetId]);
  }
}
const remove = () => DELETE(new Request("https://admin.sailorpath.com/api/admin/regatta-events?slug=test-weekend", { method: "DELETE" }));

describe("durable calendar deletion", () => {
  it("backfills prior deletions idempotently without suppressing ordinary edits", async () => {
    await database.exec(migration);
    await database.exec(migration);
    const result = await database.query<{ slug: string }>("SELECT slug FROM regatta_event_deletions");
    expect(result.rows).toEqual([{ slug: "old-event" }]);
  });

  it("persists deletion while removing event, class and results together", async () => {
    await seed(true);
    const response = await remove();
    expect(response.status).toBe(200);
    const result = await database.query("SELECT slug FROM regatta_event_deletions");
    expect(result.rows).toEqual([{ slug: "test-weekend" }]);
    expect((await database.query("SELECT * FROM regatta_events")).rows).toHaveLength(0);
    expect((await database.query("SELECT * FROM regattas")).rows).toHaveLength(0);
    expect((await database.query("SELECT * FROM test_results")).rows).toHaveLength(0);
  });

  it("persists deletion of a calendar-only event with no class sheets", async () => {
    await seed(false);
    expect((await remove()).status).toBe(200);
    expect((await database.query("SELECT slug FROM regatta_event_deletions")).rows).toEqual([{ slug: "test-weekend" }]);
  });

  it("rolls back the deletion marker when removal fails", async () => {
    await seed(true);
    await database.query("INSERT INTO deletion_blockers VALUES ($1)", [sheetId]);
    expect((await remove()).status).toBe(500);
    expect((await database.query("SELECT * FROM regatta_event_deletions")).rows).toHaveLength(0);
    expect((await database.query("SELECT * FROM regatta_events")).rows).toHaveLength(1);
    expect((await database.query("SELECT * FROM regattas")).rows).toHaveLength(1);
  });
});
