import { db } from "../src/db/client.ts";
import { sailors } from "../src/db/schema.ts";
import { ilike, or } from "drizzle-orm";

async function run() {
  const names = ["Goh Siak Yiak Ian", "Ian Goh"];
  const rows = await db.select().from(sailors).where(
    or(
      ...names.map(n => ilike(sailors.name, `%${n}%`))
    )
  );
  console.log(JSON.stringify(rows, null, 2));
}
run().catch(console.error);
