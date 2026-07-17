import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { sailors } from "@/db/schema";
import { asc, eq } from "drizzle-orm";

export async function GET() {
  try {
    await requireSuperadmin();
    const rows = await db.select().from(sailors).orderBy(asc(sailors.name));
    return NextResponse.json({ sailors: rows });
  } catch (e) {
    return jsonError(e);
  }
}

export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    const handle =
      (body.handle as string)?.trim() ||
      String(body.name || "")
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, "-")
        .replace(/^-|-$/g, "");

    const num = (v: unknown) =>
      v === "" || v == null ? null : Number.isFinite(Number(v)) ? Number(v) : null;

    const [row] = await db
      .insert(sailors)
      .values({
        name: body.name,
        handle,
        sailNumber: body.sailNumber || "SGP 000",
        club: body.club || "N/A",
        gender: body.gender || null,
        bio: body.bio || null,
        goldEntryDate: body.goldEntryDate || null,
        silverEntryDate: body.silverEntryDate || null,
        dropDate: body.dropDate || null,
        nationalSquadStatus: body.nationalSquadStatus || null,
        dob: body.dob || null,
        weight: num(body.weight),
        instagram: body.instagram || null,
        facebook: body.facebook || null,
        natSquadStatusJan25: body.natSquadStatusJan25 || null,
        natSquadStatusJul25: body.natSquadStatusJul25 || null,
        natSquadStatusJan26: body.natSquadStatusJan26 || null,
        natSquadStatusJul26: body.natSquadStatusJul26 || null,
        histRankingJun24: num(body.histRankingJun24),
        histRankingDec24: num(body.histRankingDec24),
        histRankingJun25: num(body.histRankingJun25),
        histRankingDec25: num(body.histRankingDec25),
        histRankingJun26: num(body.histRankingJun26),
        worlds: num(body.worlds),
        european: num(body.european),
        asian: num(body.asian),
        seaGames: num(body.seaGames),
      })
      .returning();

    return NextResponse.json({ sailor: row });
  } catch (e) {
    console.error(e);
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
    for (const f of [
      "name",
      "handle",
      "sailNumber",
      "club",
      "gender",
      "bio",
      "nationalSquadStatus",
      "goldEntryDate",
      "silverEntryDate",
      "dropDate",
    ] as const) {
      if (body[f] !== undefined) patch[f] = body[f] === "" ? null : body[f];
    }
    const [row] = await db
      .update(sailors)
      .set(patch as typeof sailors.$inferInsert)
      .where(eq(sailors.id, body.id))
      .returning();
    return NextResponse.json({ sailor: row });
  } catch (e) {
    return jsonError(e);
  }
}

export async function DELETE(req: Request) {
  try {
    await requireSuperadmin();
    const id = new URL(req.url).searchParams.get("id");
    if (!id) return NextResponse.json({ error: "id required" }, { status: 400 });
    await db.delete(sailors).where(eq(sailors.id, id));
    return NextResponse.json({ ok: true });
  } catch (e) {
    return jsonError(e);
  }
}
