import { afterEach, describe, expect, it } from "vitest";
import { PGlite } from "@electric-sql/pglite";
import { drizzle } from "drizzle-orm/pglite";
import { regattas } from "@/db/schema";
import { publicProfileRegattaCondition } from "./publicProfileResults";
let database: PGlite | undefined;
afterEach(async () => { await database?.close(); database = undefined; });
describe("public profile publication boundary", () => {
  it("excludes draft and review logbooks as well as staged/archived imports", async () => {
    database = new PGlite();
    await database.exec(`create table regattas (id text, slug text, status text, counts_for_ranking boolean);
      insert into regattas values
      ('published','official-cup','published',true),
      ('draft','draft-cup','draft',false),
      ('review','csc-monsoon','in_review',false),
      ('archived','old-cup','archived',false),
      ('personal','log-club-2026','draft',false),
      ('pending-personal','log-club-2025','in_review',false),
      ('archived-personal','log-old','archived',false),
      ('ranking-import','log-ranking','draft',true);`);
    const rows = await drizzle(database).select({id: regattas.id}).from(regattas).where(publicProfileRegattaCondition());
    expect(rows.map((row)=>row.id).sort()).toEqual(['published']);
  });
});
