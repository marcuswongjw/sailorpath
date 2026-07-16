import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattas, regattaResults } from "@/db/schema";
import { eq } from "drizzle-orm";

function slugify(name: string) {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
}

export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    const slugBase = slugify(body.name || "regatta");
    const slug = `${slugBase}-${body.date || Date.now()}`;
    const [row] = await db
      .insert(regattas)
      .values({
        name: body.name,
        slug,
        date: body.date,
        totalFleetSize: Number(body.totalFleetSize) || 50,
        division: body.division || "Gold",
      })
      .returning();
    return NextResponse.json({ regatta: row });
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
      .update(regattas)
      .set({
        name: body.name,
        date: body.date,
        totalFleetSize: Number(body.totalFleetSize) || 50,
        division: body.division || "Gold",
        updatedAt: new Date(),
      })
      .where(eq(regattas.id, body.id))
      .returning();
    return NextResponse.json({ regatta: row });
  } catch (e) {
    return jsonError(e);
  }
}

export async function DELETE(req: Request) {
  try {
    await requireSuperadmin();
    const id = new URL(req.url).searchParams.get("id");
    if (!id) return NextResponse.json({ error: "id required" }, { status: 400 });
    await db.delete(regattaResults).where(eq(regattaResults.regattaId, id));
    await db.delete(regattas).where(eq(regattas.id, id));
    return NextResponse.json({ ok: true });
  } catch (e) {
    return jsonError(e);
  }
}
