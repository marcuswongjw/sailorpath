import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattas } from "@/db/schema";
import { asc, eq } from "drizzle-orm";

function slugify(name: string, date?: string) {
  const base = name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
  return date ? `${base}-${date}` : base;
}

export async function GET() {
  try {
    await requireSuperadmin();
    const rows = await db.select().from(regattas).orderBy(asc(regattas.date));
    return NextResponse.json({ regattas: rows });
  } catch (e) {
    return jsonError(e);
  }
}

export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    if (!body.name || !body.date) {
      return NextResponse.json(
        { error: "name and date are required" },
        { status: 400 }
      );
    }
    const slug =
      (body.slug as string)?.trim() ||
      slugify(String(body.name), String(body.date));
    const totalFleetSize = Number(body.totalFleetSize) || 50;
    const division = body.division || "Gold";
    const raceCount =
      body.raceCount === "" || body.raceCount == null
        ? null
        : Math.max(0, Math.round(Number(body.raceCount))) || null;
    const geography =
      body.geography != null && String(body.geography).trim()
        ? String(body.geography).trim().toUpperCase().slice(0, 12)
        : "SG";
    const boatClass =
      body.boatClass != null && String(body.boatClass).trim()
        ? String(body.boatClass).trim().slice(0, 40)
        : "Optimist";

    const [row] = await db
      .insert(regattas)
      .values({
        name: String(body.name).trim(),
        slug,
        date: String(body.date),
        totalFleetSize,
        division,
        raceCount,
        geography,
        boatClass,
      })
      .onConflictDoUpdate({
        target: regattas.slug,
        set: {
          name: String(body.name).trim(),
          date: String(body.date),
          totalFleetSize,
          division,
          raceCount,
          geography,
          boatClass,
          updatedAt: new Date(),
        },
      })
      .returning();

    return NextResponse.json({ regatta: row });
  } catch (e) {
    console.error("regattas POST", e);
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
    if (body.name !== undefined) patch.name = String(body.name).trim();
    if (body.date !== undefined) patch.date = String(body.date);
    if (body.division !== undefined) patch.division = body.division || "Gold";
    if (body.totalFleetSize !== undefined) {
      patch.totalFleetSize = Number(body.totalFleetSize) || 50;
    }
    if (body.raceCount !== undefined) {
      patch.raceCount =
        body.raceCount === "" || body.raceCount == null
          ? null
          : Math.max(0, Math.round(Number(body.raceCount))) || null;
    }
    if (body.geography !== undefined) {
      patch.geography =
        body.geography === "" || body.geography == null
          ? "SG"
          : String(body.geography).trim().toUpperCase().slice(0, 12);
    }
    if (body.boatClass !== undefined) {
      patch.boatClass =
        body.boatClass === "" || body.boatClass == null
          ? "Optimist"
          : String(body.boatClass).trim().slice(0, 40);
    }
    if (body.slug !== undefined && body.slug) {
      patch.slug = String(body.slug).trim();
    }

    const [row] = await db
      .update(regattas)
      .set(patch as typeof regattas.$inferInsert)
      .where(eq(regattas.id, body.id))
      .returning();

    if (!row) {
      return NextResponse.json({ error: "Regatta not found" }, { status: 404 });
    }
    return NextResponse.json({ regatta: row });
  } catch (e) {
    console.error("regattas PATCH", e);
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
    // Results cascade via FK onDelete: cascade
    const deleted = await db
      .delete(regattas)
      .where(eq(regattas.id, id))
      .returning({ id: regattas.id });
    if (!deleted[0]) {
      return NextResponse.json({ error: "Regatta not found" }, { status: 404 });
    }
    return NextResponse.json({ ok: true, id });
  } catch (e) {
    console.error("regattas DELETE", e);
    return jsonError(e);
  }
}
