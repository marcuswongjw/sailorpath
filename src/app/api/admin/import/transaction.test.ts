import { afterAll, beforeAll, beforeEach, describe, expect, it, vi } from "vitest";
import { PGlite } from "@electric-sql/pglite";
import { drizzle } from "drizzle-orm/pglite";
import { getTableConfig, PgDialect } from "drizzle-orm/pg-core";
import { SQL } from "drizzle-orm";
import { sailors, sailorAliases, regattas, regattaResults, regattaRaceResults } from "@/db/schema";

const state = vi.hoisted(() => ({ db: null as unknown }));
vi.mock("@/db", () => ({ get db() { return state.db; }, ensureCoreSchema: async () => {} }));
vi.mock("@/lib/auth", () => ({ requireSuperadmin: async () => ({ role: "superadmin", userId: "test" }), jsonError: (e: Error) => Response.json({ error: e.message }, { status: 500 }) }));
vi.mock("@/lib/usage", () => ({ trackUsage: vi.fn() }));
vi.mock("@/lib/adminLog", () => ({ adminLog: vi.fn(), createAdminRequestId: () => "test" }));
vi.mock("@/lib/adminChangeLog", () => ({ logAdminChange: vi.fn() }));
vi.mock("@/lib/revalidatePublic", () => ({ revalidatePublicRankings: vi.fn() }));
import { POST } from "./route";

const pg = new PGlite();
const testDb = drizzle(pg);
const quote = (name: string) => `"${name.replaceAll('"', '""')}"`;
beforeAll(async () => {
  const dialect = new PgDialect();
  // Build the five import tables from the actual schema, including defaults and unique keys.
  for (const table of [sailors, sailorAliases, regattas, regattaResults, regattaRaceResults]) {
    const config = getTableConfig(table);
    const columns = config.columns.map((col) => {
      const defaultSql = col.default instanceof SQL ? dialect.sqlToQuery(col.default).sql : typeof col.default === "string" ? `'${col.default.replaceAll("'", "''")}'` : String(col.default);
      return `${quote(col.name)} ${col.getSQLType()}${col.notNull ? " NOT NULL" : ""}${col.primary ? " PRIMARY KEY" : ""}${col.isUnique ? " UNIQUE" : ""}${col.default !== undefined ? ` DEFAULT ${defaultSql}` : ""}`;
    });
    columns.push(...config.uniqueConstraints.map((key) => `UNIQUE (${key.columns.map((col) => quote(col.name)).join(",")})`));
    await pg.exec(`CREATE TABLE ${quote(config.name)} (${columns.join(",")})`);
  }
  await pg.exec("ALTER TABLE regatta_race_results ADD FOREIGN KEY (regatta_result_id) REFERENCES regatta_results(id) ON DELETE CASCADE");
  state.db = testDb;
}, 30000);
beforeEach(async () => { await pg.exec("TRUNCATE regatta_race_results, regatta_results, sailor_aliases, sailors, regattas CASCADE"); });
afterAll(async () => { await pg.close(); });

function upload(extra: Record<string, unknown> = {}, headers: Record<string, string> = {}) {
  return POST(new Request("http://localhost/api/admin/import", { method: "POST", headers: { "Content-Type": "application/json", ...headers }, body: JSON.stringify({ regattaName: "Harbour Cup", eventDate: "2026-01-01", division: "Gold", totalFleetSize: 1, rows: [{ name: "Alice Example", rank: 1, nett: 1, races: [{ raceNumber: 1, score: 1, rawValue: "1", discarded: false, scoringCode: null }] }], ...extra }) }));
}

describe("import database transaction", () => {
  it("commits a new event, competitor, result, and race together", async () => {
    expect((await upload()).status).toBe(200);
    expect(await testDb.select().from(regattas)).toHaveLength(1);
    expect(await testDb.select().from(sailors)).toHaveLength(1);
    expect(await testDb.select().from(regattaResults)).toHaveLength(1);
    expect(await testDb.select().from(regattaRaceResults)).toHaveLength(1);
  });

  it("rolls back all earlier writes when a race insert fails", async () => {
    await pg.exec("ALTER TABLE regatta_race_results ADD CONSTRAINT test_failure CHECK (score <> 9876)");
    try {
      const response = await upload({ rows: [{ name: "Alice Example", rank: 1, races: [{ raceNumber: 1, score: 9876, rawValue: "9876" }] }] });
      expect(response.status).toBe(500);
      for (const table of [regattas, sailors, sailorAliases, regattaResults, regattaRaceResults]) expect(await testDb.select().from(table)).toHaveLength(0);
    } finally { await pg.exec("ALTER TABLE regatta_race_results DROP CONSTRAINT test_failure"); }
  });

  it("rolls back core results when derived demographic updates fail", async () => {
    await pg.exec(`
      CREATE FUNCTION fail_result_update() RETURNS trigger AS $$
      BEGIN
        RAISE EXCEPTION 'forced demographic update failure';
      END;
      $$ LANGUAGE plpgsql;
      CREATE TRIGGER fail_result_update_trigger
      BEFORE UPDATE ON regatta_results
      FOR EACH ROW EXECUTE FUNCTION fail_result_update();
    `);
    try {
      const response = await upload({
        rows: [{ name: "Alice Example", rank: 1, nett: 1, gender: "F" }],
      });
      expect(response.status).toBe(500);
      expect(await testDb.select().from(regattas)).toHaveLength(0);
      expect(await testDb.select().from(sailors)).toHaveLength(0);
      expect(await testDb.select().from(regattaResults)).toHaveLength(0);
    } finally {
      await pg.exec(`
        DROP TRIGGER fail_result_update_trigger ON regatta_results;
        DROP FUNCTION fail_result_update();
      `);
    }
  });

  it("requires a choice even when only one different event shares the date", async () => {
    await upload();
    const response = await upload({ regattaName: "Other Cup" });
    expect(response.status).toBe(409);
    expect(await response.json()).toMatchObject({ requiresTargetSelection: true });
    expect((await testDb.select().from(regattas))[0].name).toBe("Harbour Cup");
    expect((await upload({ regattaName: "Other Cup", confirmedRegattaId: "new-regatta" })).status).toBe(200);
    expect(await testDb.select().from(regattas)).toHaveLength(2);
  });

  it("rejects duplicate matched competitors without committing profiles", async () => {
    const response = await upload({ rows: [{ name: "Alice Example", rank: 1 }, { name: "Alice Example", rank: 2 }] });
    expect(response.status).toBe(409);
    expect(await testDb.select().from(regattas)).toHaveLength(0);
    expect(await testDb.select().from(sailors)).toHaveLength(0);
  });

  it("streams NDJSON progress events when requested", async () => {
    const response = await upload({}, { Accept: "application/x-ndjson" });
    expect(response.headers.get("content-type")).toContain("application/x-ndjson");
    const text = await response.text();
    const lines = text.trim().split("\n").map((line) => JSON.parse(line));
    expect(lines.some((l) => l.type === "progress" && l.stage === "matching")).toBe(true);
    expect(lines.some((l) => l.type === "result" && l.matched === 1)).toBe(true);
  });
});
