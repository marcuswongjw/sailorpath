import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults } from "@/db/schema";
import { eq } from "drizzle-orm";

export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    const [row] = await db
      .insert(regattaResults)
      .values({
        sailorId: body.sailorId,
        regattaId: body.regattaId,
        rank: Number(body.rank) || 1,
        nettScore: Number(body.nettScore) || Number(body.rank) || 1,
      })
      .onConflictDoUpdate({
        target: [regattaResults.sailorId, regattaResults.regattaId],
        set: {
          rank: Number(body.rank) || 1,
          nettScore: Number(body.nettScore) || Number(body.rank) || 1,
          updatedAt: new Date(),
        },
      })
      .returning();
    return NextResponse.json({ result: row });
  } catch (e) {
    console.error(e);
    return jsonError(e);
  }
}

export async function PATCH(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    if (!body.id) return NextResponse.json({ error: "id required" }, { status: 400 });
    const [row] = await db
      .update(regattaResults)
      .set({
        sailorId: body.sailorId,
        regattaId: body.regattaId,
        rank: Number(body.rank) || 1,
        nettScore: Number(body.nettScore) || 1,
        updatedAt: new Date(),
      })
      .where(eq(regattaResults.id, body.id))
      .returning();
    return NextResponse.json({ result: row });
  } catch (e) {
    return jsonError(e);
  }
}

export async function DELETE(req: Request) {
  try {
    await requireSuperadmin();
    const id = new URL(req.url).searchParams.get("id");
    if (!id) return NextResponse.json({ error: "id required" }, { status: 400 });
    await db.delete(regattaResults).where(eq(regattaResults.id, id));
    return NextResponse.json({ ok: true });
  } catch (e) {
    return jsonError(e);
  }
}
