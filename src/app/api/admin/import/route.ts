import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, regattas, sailorAliases, sailors } from "@/db/schema";
import { eq, sql } from "drizzle-orm";

function slugify(name: string) {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
}

function normalizeName(n: string) {
  return n.trim().toLowerCase().replace(/\s+/g, " ");
}

export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    const {
      regattaName,
      eventDate,
      division,
      totalFleetSize,
      rows,
    }: {
      regattaName: string;
      eventDate: string;
      division?: string;
      totalFleetSize?: number;
      rows: { name: string; rank: number | null; nett: number | null }[];
    } = body;

    if (!regattaName || !eventDate || !Array.isArray(rows)) {
      return NextResponse.json({ error: "Invalid payload" }, { status: 400 });
    }

    const slug = `${slugify(regattaName)}-${eventDate}`;
    const fleetSize = totalFleetSize || rows.length || 50;

    const [reg] = await db
      .insert(regattas)
      .values({
        name: regattaName,
        slug,
        date: eventDate,
        totalFleetSize: fleetSize,
        division: division || "Gold",
      })
      .onConflictDoUpdate({
        target: regattas.slug,
        set: {
          name: regattaName,
          totalFleetSize: fleetSize,
          division: division || "Gold",
          date: eventDate,
          updatedAt: new Date(),
        },
      })
      .returning();

    let matched = 0;
    const unmatched: {
      rawName: string;
      rank: number | null;
      nett: number | null;
      suggestedId: string | null;
      suggestedName: string | null;
      similarity: number;
    }[] = [];

    for (const row of rows) {
      const name = String(row.name || "").trim();
      if (!name) continue;

      let [sailor] = await db
        .select()
        .from(sailors)
        .where(eq(sailors.name, name))
        .limit(1);

      if (!sailor) {
        const aliasHit = await db
          .select({ sailorId: sailorAliases.sailorId })
          .from(sailorAliases)
          .where(eq(sailorAliases.aliasName, name))
          .limit(1);
        if (aliasHit[0]) {
          const [s] = await db
            .select()
            .from(sailors)
            .where(eq(sailors.id, aliasHit[0].sailorId))
            .limit(1);
          sailor = s;
        }
      }

      if (!sailor) {
        const hits = await db.execute(sql`
          SELECT id FROM sailors WHERE lower(name) = ${normalizeName(name)} LIMIT 1
        `);
        const hit = (hits as unknown as { id: string }[])[0];
        if (hit) {
          const [s] = await db
            .select()
            .from(sailors)
            .where(eq(sailors.id, hit.id))
            .limit(1);
          sailor = s;
        }
      }

      if (!sailor) {
        let suggestedId: string | null = null;
        let suggestedName: string | null = null;
        let similarity = 0;
        try {
          const sug = await db.execute(sql`
            SELECT id, name, similarity(name, ${name}) AS sim
            FROM sailors
            WHERE name % ${name} OR name ILIKE ${"%" + name.split(" ")[0] + "%"}
            ORDER BY sim DESC NULLS LAST
            LIMIT 1
          `);
          const top = (
            sug as unknown as { id: string; name: string; sim: number }[]
          )[0];
          if (top && Number(top.sim) >= 0.25) {
            suggestedId = top.id;
            suggestedName = top.name;
            similarity = Number(top.sim);
          }
        } catch {
          /* pg_trgm optional */
        }
        unmatched.push({
          rawName: name,
          rank: row.rank,
          nett: row.nett,
          suggestedId,
          suggestedName,
          similarity,
        });
        continue;
      }

      const rank = row.rank ?? 999;
      const nett = row.nett ?? rank;
      await db
        .insert(regattaResults)
        .values({
          regattaId: reg.id,
          sailorId: sailor.id,
          rank,
          nettScore: nett,
        })
        .onConflictDoUpdate({
          target: [regattaResults.sailorId, regattaResults.regattaId],
          set: { rank, nettScore: nett, updatedAt: new Date() },
        });
      matched++;
    }

    return NextResponse.json({
      message: `Imported ${reg.name}: ${matched} matched, ${unmatched.length} unmatched.`,
      regatta: reg,
      matched,
      unmatched,
    });
  } catch (e) {
    console.error(e);
    return jsonError(e);
  }
}
