import { NextResponse } from "next/server";
import { eq, inArray, sql } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db, withDatabaseRetry } from "@/db";
import { regattaResults, regattas } from "@/db/schema";
import { publicationReadiness } from "@/lib/admin/publicationReadiness";

export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    const url = new URL(req.url);
    const sheet = url.searchParams.get("sheet")?.trim();
    const hasSheets = url.searchParams.has("sheets");
    const sheetsParam = url.searchParams.get("sheets")?.trim();

    if (!sheet && !hasSheets) {
      return NextResponse.json(
        { error: "sheet or sheets is required" },
        { status: 400 }
      );
    }

    if (hasSheets) {
      const ids = (sheetsParam || "")
        .split(",")
        .map((s) => s.trim())
        .filter(Boolean);

      if (ids.length === 0) {
        return NextResponse.json({ ok: true, readinessBySheet: {} });
      }

      const [sheetRows, countRows] = await withDatabaseRetry(
        () =>
          Promise.all([
            db.select().from(regattas).where(inArray(regattas.id, ids)),
            db
              .select({
                regattaId: regattaResults.regattaId,
                n: sql<number>`count(*)::int`,
              })
              .from(regattaResults)
              .where(inArray(regattaResults.regattaId, ids))
              .groupBy(regattaResults.regattaId),
          ]),
        { label: "admin.regatta_readiness.get_batch" }
      );

      const countMap = new Map<string, number>();
      for (const c of countRows) {
        countMap.set(c.regattaId, Number(c.n) || 0);
      }

      const readinessBySheet: Record<
        string,
        ReturnType<typeof publicationReadiness>
      > = {};
      for (const row of sheetRows) {
        readinessBySheet[row.id] = publicationReadiness({
          name: row.name,
          date: row.date ? String(row.date).slice(0, 10) : null,
          boatClass: row.boatClass,
          division: row.division,
          totalFleetSize: row.totalFleetSize,
          raceCount: row.raceCount,
          countsForRanking: row.countsForRanking,
          resultCount: countMap.get(row.id) ?? 0,
          status: row.status,
        });
      }

      return NextResponse.json({ ok: true, readinessBySheet });
    }

    const [row, countRow] = await withDatabaseRetry(
      () =>
        Promise.all([
          db
            .select()
            .from(regattas)
            .where(eq(regattas.id, sheet!))
            .limit(1)
            .then((r) => r[0]),
          db
            .select({ n: sql<number>`count(*)::int` })
            .from(regattaResults)
            .where(eq(regattaResults.regattaId, sheet!))
            .then((r) => r[0]),
        ]),
      { label: "admin.regatta_readiness.get" }
    );
    if (!row) {
      return NextResponse.json({ error: "Class sheet not found" }, { status: 404 });
    }
    const readiness = publicationReadiness({
      name: row.name,
      date: row.date ? String(row.date).slice(0, 10) : null,
      boatClass: row.boatClass,
      division: row.division,
      totalFleetSize: row.totalFleetSize,
      raceCount: row.raceCount,
      countsForRanking: row.countsForRanking,
      resultCount: countRow?.n ?? 0,
      status: row.status,
    });
    return NextResponse.json({ ok: true, sheetId: row.id, readiness });
  } catch (e: unknown) {
    return jsonError(e);
  }
}
