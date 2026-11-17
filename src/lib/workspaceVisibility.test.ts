import { afterEach, describe, expect, it } from "vitest";
import { PGlite } from "@electric-sql/pglite";
import { drizzle } from "drizzle-orm/pglite";
import { eq } from "drizzle-orm";
import { regattaResults, regattas } from "@/db/schema";
import { coachWorkspaceResultsCondition, workspaceUpcomingRegattasCondition } from "./workspaceVisibility";

let database: PGlite | undefined;
afterEach(async () => { await database?.close(); database = undefined; });
describe("signed-in workspace publication boundaries", () => {
  it("keeps personal drafts and other sailors out of coach results", async () => {
    database = new PGlite();
    await database.exec(`create table regattas (id text, status text);
      create table regatta_results (id text, sailor_id text, regatta_id text);
      insert into regattas values ('p','published'), ('d','draft'), ('r','in_review');
      insert into regatta_results values ('public','a','p'),('personal','a','d'),('staged','a','r'),('other','b','p');`);
    const rows = await drizzle(database).select({ id: regattaResults.id }).from(regattaResults)
      .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id)).where(coachWorkspaceResultsCondition(["a"]));
    expect(rows.map((row) => row.id)).toEqual(["public"]);
  });
  it("shows only published upcoming or ongoing events", async () => {
    database = new PGlite();
    await database.exec(`create table regattas (id text, status text, date date, end_date date);
      insert into regattas values ('future','published','2026-12-01',null),
      ('ongoing','published','2026-11-01','2026-11-20'),
      ('private','draft','2026-12-01',null),('past','published','2026-10-01','2026-10-03');`);
    const rows = await drizzle(database).select({ id: regattas.id }).from(regattas)
      .where(workspaceUpcomingRegattasCondition("2026-11-17"));
    expect(rows.map((row) => row.id).sort()).toEqual(["future", "ongoing"]);
  });
});
