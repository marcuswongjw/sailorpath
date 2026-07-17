import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults } from "@/db/schema";
import { eq } from "drizzle-orm";

export async function GET() {
  try {
    await requireSuperadmin();
    const rows = await db.select().from(regattaResults);
    return NextResponse.json({ results: rows });
  } catch (e) {
    return jsonError(e);
  }
}

export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    if (!body.sailorId || !body.regattaId) {
      return NextResponse.json(
        { error: "sailorId and regattaId are required" },
        { status: 400 }
      );
    }
    const rank = Math.round(Number(body.rank)) || 999;
    const nettScore =
      body.nettScore != null && body.nettScore !== ""
        ? Number(body.nettScore) // allow 14.5
        : rank;
    const totalScore =
      body.totalScore != null && body.totalScore !== ""
        ? Number(body.totalScore)
        : null;

    const [row] = await db
      .insert(regattaResults)
      .values({
        sailorId: body.sailorId,
        regattaId: body.regattaId,
        rank,
        nettScore,
        totalScore,
      })
      .onConflictDoUpdate({
        target: [regattaResults.sailorId, regattaResults.regattaId],
        set: {
          rank,
          nettScore,
          totalScore,
          updatedAt: new Date(),
        },
      })
      .returning();

    return NextResponse.json({ result: row });
  } catch (e) {
    console.error("results POST", e);
    return jsonError(e);
  }
}

export async function PATCH(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    if (!body.id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }

    const patch: Record<string, unknown> = { updatedAt: new Date() };
    if (body.rank !== undefined) patch.rank = Number(body.rank) || 999;
    if (body.nettScore !== undefined) {
      patch.nettScore = Number(body.nettScore) || 0;
    }
    if (body.totalScore !== undefined) {
      patch.totalScore =
        body.totalScore === "" || body.totalScore == null
          ? null
          : Number(body.totalScore);
    }
    if (body.sailorId !== undefined) patch.sailorId = body.sailorId;
    if (body.regattaId !== undefined) patch.regattaId = body.regattaId;

    const [row] = await db
      .update(regattaResults)
      .set(patch as typeof regattaResults.$inferInsert)
      .where(eq(regattaResults.id, body.id))
      .returning();

    if (!row) {
      return NextResponse.json({ error: "Result not found" }, { status: 404 });
    }
    return NextResponse.json({ result: row });
  } catch (e) {
    console.error("results PATCH", e);
    return jsonError(e);
  }
}

export async function DELETE(req: Request) {
  try {
    await requireSuperadmin();
    const id = new URL(req.url).searchParams.get("id");
    if (!id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }
    const deleted = await db
      .delete(regattaResults)
      .where(eq(regattaResults.id, id))
      .returning({ id: regattaResults.id });
    if (!deleted[0]) {
      return NextResponse.json({ error: "Result not found" }, { status: 404 });
    }
    return NextResponse.json({ ok: true, id });
  } catch (e) {
    console.error("results DELETE", e);
    return jsonError(e);
  }
}
