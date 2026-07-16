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

    const [row] = await db
      .insert(sailors)
      .values({
        name: body.name,
        handle,
        sailNumber: body.sailNumber || "SGP 000",
        club: body.club || "N/A",
        gender: body.gender || null,
        bio: body.bio || null,
        nationalSquadStatus: body.nationalSquadStatus || null,
        instagram: body.instagram || null,
        facebook: body.facebook || null,
        dob: body.dob || null,
        weight: body.weight != null && body.weight !== "" ? Number(body.weight) : null,
        goldEntryDate: body.goldEntryDate || null,
        silverEntryDate: body.silverEntryDate || null,
        dropDate: body.dropDate || null,
        natSquadStatusJan25: body.natSquadStatusJan25 || null,
        natSquadStatusJul25: body.natSquadStatusJul25 || null,
        natSquadStatusJan26: body.natSquadStatusJan26 || null,
        natSquadStatusJul26: body.natSquadStatusJul26 || null,
        histRankingJun24: body.histRankingJun24 != null && body.histRankingJun24 !== "" ? Number(body.histRankingJun24) : null,
        histRankingDec24: body.histRankingDec24 != null && body.histRankingDec24 !== "" ? Number(body.histRankingDec24) : null,
        histRankingJun25: body.histRankingJun25 != null && body.histRankingJun25 !== "" ? Number(body.histRankingJun25) : null,
        histRankingDec25: body.histRankingDec25 != null && body.histRankingDec25 !== "" ? Number(body.histRankingDec25) : null,
        histRankingJun26: body.histRankingJun26 != null && body.histRankingJun26 !== "" ? Number(body.histRankingJun26) : null,
        worlds: body.worlds != null && body.worlds !== "" ? Number(body.worlds) : null,
        european: body.european != null && body.european !== "" ? Number(body.european) : null,
        asian: body.asian != null && body.asian !== "" ? Number(body.asian) : null,
        seaGames: body.seaGames != null && body.seaGames !== "" ? Number(body.seaGames) : null,
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
    const fields = [
      "name", "handle", "sailNumber", "club", "gender", "bio", "nationalSquadStatus",
      "instagram", "facebook", "dob", "goldEntryDate", "silverEntryDate", "dropDate",
      "natSquadStatusJan25", "natSquadStatusJul25", "natSquadStatusJan26", "natSquadStatusJul26",
    ] as const;
    for (const f of fields) {
      if (body[f] !== undefined) patch[f] = body[f] === "" ? null : body[f];
    }
    const nums = [
      "weight", "histRankingJun24", "histRankingDec24", "histRankingJun25",
      "histRankingDec25", "histRankingJun26", "worlds", "european", "asian", "seaGames",
    ] as const;
    for (const f of nums) {
      if (body[f] !== undefined) {
        patch[f] = body[f] === "" || body[f] == null ? null : Number(body[f]);
      }
    }

    const [row] = await db
      .update(sailors)
      .set(patch as typeof sailors.$inferInsert)
      .where(eq(sailors.id, body.id))
      .returning();

    return NextResponse.json({ sailor: row });
  } catch (e) {
    console.error(e);
    return jsonError(e);
  }
}

export async function DELETE(req: Request) {
  try {
    await requireSuperadmin();
    const { searchParams } = new URL(req.url);
    const id = searchParams.get("id");
    if (!id) return NextResponse.json({ error: "id required" }, { status: 400 });
    await db.delete(sailors).where(eq(sailors.id, id));
    return NextResponse.json({ ok: true });
  } catch (e) {
    return jsonError(e);
  }
}
