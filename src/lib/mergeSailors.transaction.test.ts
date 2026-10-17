import { afterAll, beforeAll, beforeEach, describe, expect, it, vi } from "vitest";
import { PGlite } from "@electric-sql/pglite";
import { drizzle } from "drizzle-orm/pglite";
import { getTableConfig, PgDialect, PgTable } from "drizzle-orm/pg-core";
import { eq, is } from "drizzle-orm";
import * as schema from "@/db/schema";

const state = vi.hoisted(() => ({ db: null as unknown }));
vi.mock("@/db", () => ({ get db() { return state.db; } }));
import { getSeparateSailorPairs, saveSailorDuplicateDecision } from "./sailorDuplicateDecisionStore";
import { mergeSailors } from "./mergeSailors";
import { getSailorMergePlan } from "./sailorMergePlan";

const pg = new PGlite();
const writes: string[] = [];
const database = drizzle(pg, { logger: { logQuery: q => { if (/^(insert|update|delete)/i.test(q)) writes.push(q); } } });
const a = "11111111-1111-4111-8111-111111111111";
const b = "22222222-2222-4222-8222-222222222222";
const event = "33333333-3333-4333-8333-333333333333";
const result = "44444444-4444-4444-8444-444444444444";
const ownerA = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa";
const ownerB = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb";
const tables = Object.values(schema).filter(t => is(t, PgTable));

beforeAll(async () => {
  const dialect = new PgDialect();
  const quote = (v: unknown): string => v === null ? "null" : typeof v === "object" ? quote(JSON.stringify(v)) : typeof v === "string" ? `'${v.replaceAll("'", "''")}'` : String(v);
  for (const table of tables) {
    const config = getTableConfig(table as PgTable);
    const columns = config.columns.map(c => `"${c.name}" ${c.getSQLType()}${c.notNull ? " NOT NULL" : ""}${c.default !== undefined ? " DEFAULT " + (typeof c.default === "object" && c.default !== null && "queryChunks" in c.default ? dialect.sqlToQuery(c.default as Parameters<typeof dialect.sqlToQuery>[0]).sql : quote(c.default)) : ""}${c.primary ? " PRIMARY KEY" : ""}${c.isUnique ? " UNIQUE" : ""}`);
    for (const unique of config.uniqueConstraints) columns.push(`UNIQUE (${unique.columns.map(c => `"${c.name}"`).join(",")})`);
    const ddl = `CREATE TABLE "${config.name}" (${columns.join(",")})`;
    try { await pg.exec(ddl); } catch (cause) { throw new Error(ddl, { cause }); }
  }
  // The critical dependent rows really cascade on deletion, as in production.
  await pg.exec(`ALTER TABLE regatta_race_results ADD FOREIGN KEY (regatta_result_id) REFERENCES regatta_results(id) ON DELETE CASCADE;
    ALTER TABLE regatta_result_participants ADD FOREIGN KEY (regatta_result_id) REFERENCES regatta_results(id) ON DELETE CASCADE;`);
  state.db = database;
}, 30000);

beforeEach(async () => {
  await pg.exec("TRUNCATE " + tables.map(t => `"${getTableConfig(t).name}"`).join(",") + " CASCADE");
  await database.insert(schema.sailors).values([
    { id: a, name: "Caleb Full Name", handle: "caleb-full", club: "Club", sailNumber: "225207", nationality: "SGP", gender: "M" },
    { id: b, name: "Caleb", handle: "caleb-short", club: "Club", sailNumber: "225207", nationality: "SGP", gender: "Male" },
  ]);
  await database.insert(schema.regattas).values({ id: event, name: "Official event", slug: "official-event", date: "2024-01-01", totalFleetSize: 50 });
  await database.insert(schema.regattaResults).values({ id: result, sailorId: b, regattaId: event, rank: 4, totalScore: 15, nettScore: 5, entrySailNumber: "SGP 225207", officialUrl: "https://official.example/result.pdf", evidenceNotes: "Original evidence", verificationStatus: "verified" });
  await database.insert(schema.regattaRaceResults).values([
    { regattaResultId: result, raceNumber: 1, score: 5, rawValue: "5", discarded: false },
    { regattaResultId: result, raceNumber: 2, score: 10, rawValue: "(DNC 10)", discarded: true, scoringCode: "DNC" },
  ]);
  await database.insert(schema.regattaResultParticipants).values({ regattaResultId: result, sailorId: b, sourceName: "Caleb Original Source", displayOrder: 1, role: "solo" });
  writes.length = 0;
});
afterAll(() => pg.close());

describe("transactional identity merge protection", () => {
  it("persists confirmed-different decisions in either pair order, blocks a stale merge and preserves audit history on reopen", async () => {
    const originalPlan = await getSailorMergePlan(a, b);
    const actor = { userId: ownerA, email: "admin@example.test" };
    await saveSailorDuplicateDecision({ aId: b, bId: a, separate: true,
      reason: "Official sheet confirms two distinct individuals.", actor });
    expect(await getSeparateSailorPairs()).toHaveLength(1);
    const plan = await getSailorMergePlan(a, b);
    expect(plan.canMerge).toBe(false);
    expect(plan.conflicts.join(" ")).toContain("confirmed-different");
    writes.length = 0;
    await expect(mergeSailors({ keepId: a, mergeId: b, reviewToken: originalPlan.reviewToken,
      identityEvidence: "Previously reviewed source name and sail." })).rejects.toBeDefined();
    expect(writes).toEqual([]);
    await saveSailorDuplicateDecision({ aId: a, bId: b, separate: false,
      reason: "New official evidence requires another identity review.", actor });
    expect(await getSeparateSailorPairs()).toHaveLength(0);
    expect((await getSailorMergePlan(a, b)).canMerge).toBe(true);
    expect(await database.select().from(schema.adminChangeLog)).toHaveLength(2);
  });

  it("does not implicitly transfer a separate-person decision through a third-profile merge", async () => {
    await database.insert(schema.sailors).values({ id: ownerB, name: "Another sailor", handle: "another", sailNumber: "123", club: "Club" });
    await saveSailorDuplicateDecision({ aId: b, bId: ownerB, separate: true,
      reason: "Verified as separate competitors in an official source.", actor: { userId: ownerA, email: null } });
    expect((await getSailorMergePlan(a, b)).canMerge).toBe(false);
  });

  it("retains audit history but stops suggesting decisions involving a deleted profile", async () => {
    await saveSailorDuplicateDecision({ aId: a, bId: b, separate: true,
      reason: "Official source confirms distinct sailors.", actor: { userId: ownerA, email: null } });
    await database.delete(schema.sailors).where(eq(schema.sailors.id, b));
    expect(await getSeparateSailorPairs()).toHaveLength(0);
    expect(await database.select().from(schema.adminChangeLog)).toHaveLength(1);
  });

  it("preserves result IDs, evidence, every race/discard/code and participant source names", async () => {
    const original = (await pg.query("select to_jsonb(r) - 'sailor_id' - 'updated_at' as data from regatta_results r")).rows;
    const races = (await pg.query("select * from regatta_race_results order by race_number")).rows;
    const plan = await getSailorMergePlan(a, b);
    expect(plan.canMerge).toBe(true);
    expect(plan.raceScoresPreserved).toBe(2);
    await mergeSailors({ keepId: a, mergeId: b, reviewToken: plan.reviewToken, identityEvidence: "Official PDF, Caleb and SGP 225207 match." });
    expect((await pg.query("select to_jsonb(r) - 'sailor_id' - 'updated_at' as data from regatta_results r")).rows).toEqual(original);
    expect((await pg.query("select * from regatta_race_results order by race_number")).rows).toEqual(races);
    expect((await database.select().from(schema.regattaResults))[0].sailorId).toBe(a);
    expect((await database.select().from(schema.regattaResultParticipants))[0]).toMatchObject({ sailorId: a, sourceName: "Caleb Original Source" });
    expect(await database.select().from(schema.sailors).where(eq(schema.sailors.id, b))).toHaveLength(0);
  });

  it("blocks two individual entries before any mutation instead of choosing a better rank", async () => {
    await database.insert(schema.regattaResults).values({ sailorId: a, regattaId: event, rank: 31, nettScore: 193 });
    writes.length = 0;
    const plan = await getSailorMergePlan(a, b);
    expect(plan.canMerge).toBe(false);
    await expect(mergeSailors({ keepId: a, mergeId: b, reviewToken: plan.reviewToken, identityEvidence: "Name and sail match in the source." })).rejects.toMatchObject({ code: "IDENTITY_CONFLICT" });
    expect(writes).toEqual([]);
    expect(await database.select().from(schema.regattaResults)).toHaveLength(2);
  });

  it.each([
    { gender: "F" }, { nationality: "THA" }, { dob: "2014-01-01" },
  ])("blocks conflicting identity metadata %j before writing", async patch => {
    if (patch.dob) await database.update(schema.sailors).set({ dob: "2013-01-01" }).where(eq(schema.sailors.id, a));
    await database.update(schema.sailors).set(patch).where(eq(schema.sailors.id, b)); writes.length = 0;
    const plan = await getSailorMergePlan(a, b);
    expect(plan.canMerge).toBe(false);
    await expect(mergeSailors({ keepId: a, mergeId: b, reviewToken: plan.reviewToken, identityEvidence: "Official source review" })).rejects.toMatchObject({ code: "IDENTITY_CONFLICT" });
    expect(writes).toEqual([]);
  });

  it("never overrides different owners, including a legacy force flag", async () => {
    await database.update(schema.sailors).set({ parentId: ownerA }).where(eq(schema.sailors.id, a));
    await database.update(schema.sailors).set({ parentId: ownerB }).where(eq(schema.sailors.id, b)); writes.length = 0;
    await expect(mergeSailors({ keepId: a, mergeId: b, ...{ forceOwnershipConflict: true } })).rejects.toMatchObject({ code: "IDENTITY_CONFLICT" });
    expect(writes).toEqual([]);
  });

  it("rejects missing approval and stale review tokens before writing", async () => {
    await expect(mergeSailors({ keepId: a, mergeId: b })).rejects.toMatchObject({ code: "PREFLIGHT_REQUIRED" });
    const plan = await getSailorMergePlan(a, b);
    await database.update(schema.regattaRaceResults).set({ score: 6 }).where(eq(schema.regattaRaceResults.raceNumber, 1)); writes.length = 0;
    await expect(mergeSailors({ keepId: a, mergeId: b, reviewToken: plan.reviewToken, identityEvidence: "Official PDF identity reviewed." })).rejects.toMatchObject({ code: "STALE_MERGE_PLAN" });
    expect(writes).toEqual([]);
  });
});
