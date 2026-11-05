import { afterAll, beforeAll, beforeEach, describe, expect, it, vi } from "vitest";
import { PGlite } from "@electric-sql/pglite";
import { PgDialect } from "drizzle-orm/pg-core";
import type { SQL } from "drizzle-orm";

const state = vi.hoisted(() => ({ execute: null as null | ((query: SQL) => Promise<unknown>) }));
vi.mock("server-only", () => ({}));
vi.mock("@/db", () => ({
  db: { execute: (query: SQL) => state.execute!(query) },
  withDatabaseRetry: (operation: () => Promise<unknown>) => operation(),
}));
import { withAsianOptimistIndexBirthYears } from "./asianOptimistIndexBirthYears";

const database = new PGlite();
const dialect = new PgDialect();
const id1 = "00000000-0000-0000-0000-000000000001";
const id2 = "00000000-0000-0000-0000-000000000002";
const entry = {
  identityKey: "HKG:examplesailor", name: "Example Sailor", nationality: "HKG",
  profileHref: "/saved-handle", birthYear: 2010, provisionalScore: 123.45,
};

beforeAll(async () => {
  await database.exec(`
    create table sailors(id uuid primary key, name text, handle text unique, nationality text, dob date, is_public_dob boolean);
    create table asian_optimist_index_sailors(identity_key text primary key, sailor_id uuid, match_status text);
  `);
});
beforeEach(async () => {
  await database.exec("truncate sailors, asian_optimist_index_sailors");
  state.execute = async (statement) => {
    const query = dialect.sqlToQuery(statement);
    return database.query(query.sql, query.params);
  };
});
afterAll(() => database.close());

describe("current Asian Index birth years", () => {
  it("uses the database year even when full DOB is private, and reflects subsequent DOB edits", async () => {
    await database.query("insert into sailors values ($1,'Example Sailor','saved-handle','HKG','2012-12-31',false)", [id1]);
    expect(await withAsianOptimistIndexBirthYears([entry])).toEqual([{ ...entry, birthYear: 2012 }]);
    await database.exec("update sailors set dob='2013-01-01'");
    const [updated] = await withAsianOptimistIndexBirthYears([entry]);
    expect(updated).toEqual({ ...entry, birthYear: 2013 });
    expect(updated).not.toHaveProperty("dob");
  });

  it("uses the confirmed identity ahead of an outdated handle, including an unknown DOB", async () => {
    await database.query("insert into sailors values ($1,'Example Sailor','saved-handle','HKG','2010-01-01',true),($2,'Example Sailor','canonical-handle','HKG',null,false)", [id1,id2]);
    await database.query("insert into asian_optimist_index_sailors values ('hkg:examplesailor',$1,'matched')", [id2]);
    expect(await withAsianOptimistIndexBirthYears([entry])).toEqual([{ ...entry, birthYear: null }]);
  });

  it("recovers a changed handle through a unique exact name and country", async () => {
    await database.query("insert into sailors values ($1,'Example Sailor','new-handle','HKG','2014-05-06',false),($2,'Example Sailor','other-country','SGP','2011-01-01',true)", [id1,id2]);
    expect(await withAsianOptimistIndexBirthYears([entry])).toEqual([{ ...entry, birthYear: 2014 }]);
  });

  it("leaves ambiguous profiles and missing DOBs blank rather than using saved years", async () => {
    await database.query("insert into sailors values ($1,'Example Sailor','one','HKG','2011-01-01',true),($2,'Example Sailor','two','HKG','2012-01-01',true)", [id1,id2]);
    expect(await withAsianOptimistIndexBirthYears([entry])).toEqual([{ ...entry, birthYear: null }]);
    await database.exec("truncate sailors");
    expect(await withAsianOptimistIndexBirthYears([entry])).toEqual([{ ...entry, birthYear: null }]);
  });

  it("preserves the scorecard during a database outage", async () => {
    state.execute = async () => { throw new Error("offline"); };
    expect(await withAsianOptimistIndexBirthYears([entry])).toEqual([entry]);
    expect(await withAsianOptimistIndexBirthYears([])).toEqual([]);
  });
});
