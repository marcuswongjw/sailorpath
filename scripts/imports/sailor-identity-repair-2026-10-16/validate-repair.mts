import fs from "node:fs";
import path from "node:path";
import assert from "node:assert/strict";
import { randomUUID } from "node:crypto";
import { PGlite } from "@electric-sql/pglite";
import { is } from "drizzle-orm";
import { getTableConfig, PgDialect, PgTable } from "drizzle-orm/pg-core";
import * as schema from "../../../src/db/schema";

// Local-only validation; private source snapshots must never be committed.
const folder = process.argv[2];
if (!folder) throw new Error("Provide the local audit snapshot directory.");
const read = (file: string) => JSON.parse(fs.readFileSync(path.join(folder, file), "utf8"));
const sqlDir = path.dirname(new URL(import.meta.url).pathname);
const scripts = ["01-verified-identity-repairs.sql", "02-reconcile-legacy-sheets.sql", "03-reviewed-strong-pairs.sql"].map(f => fs.readFileSync(path.join(sqlDir, f), "utf8"));
const tables = Object.values(schema).filter(t => is(t, PgTable));
const pg = new PGlite();
const dialect = new PgDialect();
const quote = (v: unknown): string => v === null ? "null" : typeof v === "object" ? quote(JSON.stringify(v)) : typeof v === "string" ? `'${v.replaceAll("'", "''")}'` : String(v);
for (const t of tables) {
  const c = getTableConfig(t);
  const cols = c.columns.map(col => `"${col.name}" ${col.getSQLType()}${col.notNull ? " NOT NULL" : ""}${col.default !== undefined ? " DEFAULT " + (typeof col.default === "object" && col.default !== null && "queryChunks" in col.default ? dialect.sqlToQuery(col.default as Parameters<typeof dialect.sqlToQuery>[0]).sql : quote(col.default)) : ""}${col.primary ? " PRIMARY KEY" : ""}${col.isUnique ? " UNIQUE" : ""}`);
  for (const u of c.uniqueConstraints) cols.push(`UNIQUE (${u.columns.map(x => `"${x.name}"`).join(",")})`);
  await pg.exec(`CREATE TABLE "${c.name}" (${cols.join(",")})`);
}
await pg.exec(`ALTER TABLE regatta_results ADD FOREIGN KEY(sailor_id) REFERENCES sailors(id) ON DELETE CASCADE;
ALTER TABLE regatta_race_results ADD FOREIGN KEY(regatta_result_id) REFERENCES regatta_results(id) ON DELETE CASCADE;
ALTER TABLE regatta_result_participants ADD FOREIGN KEY(regatta_result_id) REFERENCES regatta_results(id) ON DELETE CASCADE;`);
const insert = async (table: string, data: unknown) => {
  await pg.query(`INSERT INTO "${table}" SELECT * FROM jsonb_populate_record(null::"${table}",$1::jsonb) ON CONFLICT DO NOTHING`, [JSON.stringify(data)]);
};
const roster = read("roster.json");
const strongProfiles = new Map(read("strong-profiles-before.private.json").map((x: { profile: { id: string } }) => [x.profile.id, x.profile]));
for (const s of roster) {
  const profile = strongProfiles.get(s.id);
  if (profile) await insert("sailors", profile);
  else await pg.query(`INSERT INTO sailors(id,name,handle,sail_number,club,nationality,gender) VALUES($1,$2,$3,$4,$5,$6,$7)`, [s.id,s.name,s.handle,s.sailNumber || "0",s.club || "N/A",s.nationality,s.gender]);
}
const snapshot = read("strong-results-before.private.json");
const sheets = read("sheet-repair-before.json");
const sheetsById = new Map([...snapshot.regattas, ...sheets.map((s: { sheet: unknown }) => s.sheet)].map(s => [s.id, s]));
const entriesById = new Map([...snapshot.results, ...sheets.flatMap((s: { entries: unknown[] }) => s.entries)].map(r => [r.id, r]));
for (const g of sheetsById.values()) await insert("regattas", g);
for (const r of entriesById.values()) {
  await insert("regatta_results", r);
  for (const race of r.races) await insert("regatta_race_results", race);
  for (const p of r.participants) await insert("regatta_result_participants", p);
}
for (const s of roster) for (const alias of s.aliases) await pg.query("INSERT INTO sailor_aliases(sailor_id,alias_name) VALUES($1,$2) ON CONFLICT DO NOTHING", [s.id,alias]);

// Seed representative private relationships using original IDs/links but dummy
// content; production note contents and account identities are not required here.
for (const item of read("strong-relationships-before.json")) {
  if (["regatta_results","regatta_result_participants","sailor_aliases"].includes(item.table_name)) continue;
  const table = tables.find(t => getTableConfig(t).name === item.table_name)!;
  const cfg = getTableConfig(table);
  const fk = item.table_name === "news_articles" ? "related_sailor_id" : item.table_name === "asian_optimist_index_duplicate_reviews" ? "candidate_sailor_id" : "sailor_id";
  for (const link of item.links) {
    const cols = ["id",fk]; const vals: unknown[] = [link.id,link.sailor_id];
    for (const c of cfg.columns) {
      if (cols.includes(c.name) || !c.notNull || c.default !== undefined) continue;
      cols.push(c.name);
      const type = c.getSQLType();
      vals.push(type === "uuid" ? randomUUID() : type.includes("json") ? JSON.stringify({ fixture: true }) : type.includes("timestamp") ? "2026-01-01T00:00:00Z" : type === "date" ? "2026-01-01" : type === "boolean" ? false : /integer|real|numeric/.test(type) ? 1 : "fixture-"+randomUUID());
    }
    await pg.query(`INSERT INTO "${cfg.name}" (${cols.map(c => `"${c}"`).join(",")}) VALUES(${vals.map((_,i) => "$"+(i+1)).join(",")})`, vals);
  }
}

const racesBefore = (await pg.query("SELECT * FROM regatta_race_results ORDER BY id")).rows;
const resultsBefore = (await pg.query("SELECT id FROM regatta_results ORDER BY id")).rows;
const relationCountBefore = (await pg.query("SELECT count(*)::int AS n FROM equipment_items")).rows;
await pg.exec(scripts[0]);
await pg.exec(scripts[1]);
// A separate entry must reject the entire explicit batch, before a profile moves.
const allPairs = read("candidates.json");
const conflict = allPairs.find((p: { pairId: string }) => p.pairId === "D011");
const plans = JSON.parse(fs.readFileSync(path.join(sqlDir,"reviewed-pairs.json"),"utf8"));
const badPlan = plans.map((p: unknown, i: number) => i === 0 ? { ...plans[0], keepId: conflict.a.id, mergeId: conflict.b.id, keepName: conflict.a.name, sourceName: conflict.b.name } : p);
const oldPlan = JSON.stringify(plans);
const fakeEvent = randomUUID();
await pg.query("INSERT INTO regattas(id,name,slug,date,total_fleet_size) VALUES($1,'Conflict sheet','conflict-sheet','2026-02-08',59)",[fakeEvent]);
for (const [sailor,rank] of [[conflict.a.id,31],[conflict.b.id,41]]) await pg.query("INSERT INTO regatta_results(sailor_id,regatta_id,rank) VALUES($1,$2,$3)",[sailor,fakeEvent,rank]);
const countBeforeConflict = (await pg.query("SELECT count(*)::int n FROM sailors")).rows;
try { await pg.exec(scripts[2].replace(oldPlan,JSON.stringify(badPlan))); assert.fail("Conflicting competitor was accepted"); }
catch (e) { assert.match(String(e),/Shared official sheet requires source resolution/); await pg.exec("ROLLBACK"); }
assert.deepEqual((await pg.query("SELECT count(*)::int n FROM sailors")).rows,countBeforeConflict);
await pg.query("DELETE FROM regatta_results WHERE regatta_id=$1",[fakeEvent]);
await pg.query("DELETE FROM regattas WHERE id=$1",[fakeEvent]);
await pg.exec(scripts[2]);
for (const script of scripts) await pg.exec(script); // Idempotence.
assert.deepEqual((await pg.query("SELECT * FROM regatta_race_results ORDER BY id")).rows,racesBefore);
assert.deepEqual((await pg.query("SELECT id FROM regatta_results ORDER BY id")).rows,resultsBefore);
assert.deepEqual((await pg.query("SELECT count(*)::int AS n FROM equipment_items")).rows,relationCountBefore);
assert.equal((await pg.query<{ n: number }>("SELECT count(*)::int n FROM sailors")).rows[0].n,roster.length-23);
const published = (await pg.query<{ slug: string; status: string; counts_for_ranking: boolean }>("SELECT slug,status,counts_for_ranking FROM regattas WHERE slug IN ('snsc-optimist-silver-2023','nsc-cup-optimist-silver-2023','nsc-cup-optimist-gold-2023')")).rows;
assert.equal(published.length,3);
assert.ok(published.every(x => x.status === "published" && x.counts_for_ranking));
assert.equal((await pg.query<{ sailor_id: string }>("SELECT sailor_id FROM regatta_results WHERE id='14d72da2-59e5-48a9-8120-3ad6dfa76998'")).rows[0].sailor_id,"1b2d7976-00d6-4492-ad83-41c94eeec5e7");
console.log(JSON.stringify({ validated: true, replayed: true, conflictBlocked: true, mergedPairs: 23, remainingProfiles: roster.length-23, preservedResultRows: resultsBefore.length, preservedRaceRows: racesBefore.length, publishedCanonicalSheets: published.length }));
await pg.close();
