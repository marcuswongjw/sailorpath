import { readFileSync } from "node:fs";
import { PGlite } from "@electric-sql/pglite";
import { drizzle } from "drizzle-orm/pglite";
import { getTableConfig, PgDialect } from "drizzle-orm/pg-core";
import { SQL } from "drizzle-orm";
import { afterAll, beforeAll, beforeEach, describe, expect, it, vi } from "vitest";
import { regattaEvents, regattas, resultImportMonitors, resultImportScans, resultMonitorRuns } from "@/db/schema";
import type { ResultsScan } from "./types";

const state = vi.hoisted(() => ({ db: null as unknown, scan: vi.fn() }));
vi.mock("@/db", () => ({ get db() { return state.db; } }));
vi.mock("./scan", () => ({ scanEventResults: state.scan }));
import { resultsImportInventory, runResultsScan, saveResultsMonitor, resultsMonitorHealth } from "./storage";

const pg = new PGlite();
const database = drizzle(pg);
beforeAll(async () => {
  const dialect = new PgDialect();
  for (const table of [regattaEvents, regattas]) {
    const config = getTableConfig(table);
    const columns = config.columns.map((col) => {
      const defaultSql = col.default instanceof SQL ? dialect.sqlToQuery(col.default).sql : typeof col.default === "string" ? `'${col.default}'` : String(col.default);
      return `"${col.name}" ${col.getSQLType()}${col.notNull ? " NOT NULL" : ""}${col.primary ? " PRIMARY KEY" : ""}${col.isUnique ? " UNIQUE" : ""}${col.default !== undefined ? ` DEFAULT ${defaultSql}` : ""}`;
    });
    await pg.exec(`CREATE TABLE ${config.name} (${columns.join(",")})`);
  }
  await pg.exec("CREATE ROLE anon; CREATE ROLE authenticated;");
  await pg.exec(readFileSync("src/db/migrations/20261021011838_automated_result_discovery.sql", "utf8"));
  await pg.exec(readFileSync("src/db/migrations/20261023001454_results_monitor_runs.sql", "utf8"));
  state.db = database;
}, 30000);
afterAll(async () => { await pg.close(); });
beforeEach(async () => {
  await pg.exec("TRUNCATE result_monitor_runs, result_import_scans, result_import_monitors, regattas, regatta_events CASCADE");
  state.scan.mockReset();
  state.scan.mockImplementation(async (): Promise<ResultsScan> => ({ checkedAt: new Date().toISOString(), status: "needs_review", sources: [], searchedUrls: ["https://club.example/"], errors: [], pdfCorroboration: "not_found_in_checked_pages" }));
});
async function event(slug: string, endDate: string) {
  const [row] = await database.insert(regattaEvents).values({ slug, name: slug, startDate: endDate, endDate, classes: ["Optimist"], registrationUrl: "https://club.example/" }).returning();
  return row;
}

describe("results workflow persistence", () => {
  it("dry-runs an event without saving any workflow or result state", async () => {
    const row = await event("dry-run", "2026-01-01");
    expect((await runResultsScan(row.id, true)).outcomes).toHaveLength(1);
    expect(await database.select().from(resultImportScans)).toHaveLength(0);
    expect(await database.select().from(resultImportMonitors)).toHaveLength(0);
    expect(await database.select().from(regattas)).toHaveLength(0);
  });
  it("retains changes, deduplicates repeated extractions, and preserves monitor configuration", async () => {
    const row = await event("revisions", "2026-01-01");
    await saveResultsMonitor(row.id, "https://club.example/results", false);
    await runResultsScan(row.id); await runResultsScan(row.id);
    expect(await database.select().from(resultImportScans)).toHaveLength(1);
    const [monitor] = await database.select().from(resultImportMonitors);
    expect(monitor.enabled).toBe(false);
    expect(monitor.eventUrl).toBe("https://club.example/results");
    state.scan.mockResolvedValue({ ...monitor.report, checkedAt: new Date(Date.now() + 1000).toISOString(), searchedUrls: ["https://club.example/new-results"] });
    await runResultsScan(row.id);
    expect(await database.select().from(resultImportScans)).toHaveLength(2);
    expect((await resultsImportInventory())[0].eventUrl).toBe("https://club.example/results");
  });
  it("schedules completed recent events and skips future, disabled and recently checked events", async () => {
    const now = new Date();
    const yesterday = new Date(now.getTime() - 86400000).toISOString().slice(0, 10);
    const tomorrow = new Date(now.getTime() + 86400000).toISOString().slice(0, 10);
    const due = await event("due", yesterday);
    await event("future", tomorrow);
    const disabled = await event("disabled", yesterday);
    await saveResultsMonitor(disabled.id, "https://club.example", false);
    expect((await runResultsScan()).outcomes.map((o) => o.eventId)).toEqual([due.id]);
    expect((await runResultsScan()).outcomes).toHaveLength(0);
  });
  it("records successful empty scheduler runs and their trigger", async () => {
    await runResultsScan();
    const health = await resultsMonitorHealth();
    expect(health.lastSuccess).toMatchObject({ status: "succeeded", trigger: "scheduled", checkedCount: 0 });
    expect(health.lastFailure).toBeNull();
  });
  it("records source errors and continues checking other events", async () => {
    const yesterday = new Date(Date.now() - 86400000).toISOString().slice(0, 10);
    await event("broken-source", yesterday); await event("good-source", yesterday);
    state.scan.mockRejectedValueOnce(new Error("source offline"));
    const result = await runResultsScan();
    expect(result.outcomes).toHaveLength(2);
    const health = await resultsMonitorHealth();
    expect(health.lastFailure).toMatchObject({ status: "failed", checkedCount: 2, failedCount: 1 });
    expect(await database.select().from(regattas)).toHaveLength(0);
  });
  it("keeps dry runs out of saved execution history", async () => {
    const row = await event("dry-history", "2026-01-01");
    await runResultsScan(row.id, true);
    expect(await database.select().from(resultMonitorRuns)).toHaveLength(0);
  });
  it("enables RLS and denies direct client-role access to crawler evidence", async () => {
    const result = await pg.query<{ relrowsecurity: boolean }>("select relrowsecurity from pg_class where relname in ('result_import_monitors','result_import_scans','result_monitor_runs')");
    expect(result.rows.map((r) => r.relrowsecurity)).toEqual([true, true, true]);
    const privileges = await pg.query<{ allowed: boolean }>("select has_table_privilege('anon', 'result_import_scans', 'SELECT') as allowed");
    expect(privileges.rows[0].allowed).toBe(false);
  });
});
