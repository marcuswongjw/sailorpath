import { NextResponse } from "next/server";
import { eq, sql } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, regattas } from "@/db/schema";
import { publicationReadiness } from "@/lib/admin/publicationReadiness";

export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    const sheet = new URL(req.url).searchParams.get("sheet")?.trim();
    if (!sheet) {
      return NextResponse.json({ error: "sheet is required" }, { status: 400 });
    }
    const [row] = await db
      .select()
      .from(regattas)
      .where(eq(regattas.id, sheet))
      .limit(1);
    if (!row) {
      return NextResponse.json({ error: "Class sheet not found" }, { status: 404 });
    }
    const [countRow] = await db
      .select({ n: sql<number>`count(*)::int` })
      .from(regattaResults)
      .where(eq(regattaResults.regattaId, sheet));
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
