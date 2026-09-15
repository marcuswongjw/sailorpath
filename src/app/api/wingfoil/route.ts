import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db, ensureCoreSchema } from "@/db";
import { wingfoilRegattas } from "@/db/schema";
import { eq } from "drizzle-orm";
import {
  SINGAPORE_WINGFOIL_REGATTAS,
  type WingfoilRegatta,
} from "@/lib/wingfoil";

export async function GET() {
  try {
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }
    const rows = await db.select().from(wingfoilRegattas);

    if (rows && rows.length > 0) {
      const rowMap = new Map(
        rows.map((r) => [r.id, r.data as WingfoilRegatta])
      );
      const merged: WingfoilRegatta[] = [];
      const visited = new Set<string>();

      // Keep official regattas first
      for (const def of SINGAPORE_WINGFOIL_REGATTAS) {
        if (rowMap.has(def.id)) {
          merged.push(rowMap.get(def.id)!);
        } else {
          merged.push(def);
        }
        visited.add(def.id);
      }

      // Add uploaded/custom regattas
      for (const row of rows) {
        if (!visited.has(row.id)) {
          merged.push(row.data as WingfoilRegatta);
        }
      }

      return NextResponse.json({
        regattas: merged,
        source: "database",
      });
    }
  } catch (e) {
    console.warn("[/api/wingfoil] DB read warning (falling back to static):", e);
  }

  return NextResponse.json({
    regattas: SINGAPORE_WINGFOIL_REGATTAS,
    source: "default",
  });
}

export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }

    const body = await req.json();
    const list: WingfoilRegatta[] = body.regattas || (body.regatta ? [body.regatta] : []);

    if (!Array.isArray(list) || list.length === 0) {
      return NextResponse.json(
        { error: "Invalid payload: expected regattas array" },
        { status: 400 }
      );
    }

    // Upsert regattas into PostgreSQL
    for (const r of list) {
      if (!r || !r.id) continue;
      await db
        .insert(wingfoilRegattas)
        .values({
          id: r.id,
          data: r,
          updatedAt: new Date(),
        })
        .onConflictDoUpdate({
          target: wingfoilRegattas.id,
          set: {
            data: r,
            updatedAt: new Date(),
          },
        });
    }

    return NextResponse.json({
      success: true,
      savedCount: list.length,
    });
  } catch (e) {
    return jsonError(e);
  }
}

export async function DELETE(req: Request) {
  try {
    await requireSuperadmin();
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }

    const { id } = await req.json();
    if (!id || typeof id !== "string") {
      return NextResponse.json({ error: "Missing regatta id" }, { status: 400 });
    }

    await db.delete(wingfoilRegattas).where(eq(wingfoilRegattas.id, id));

    return NextResponse.json({ success: true, deletedId: id });
  } catch (e) {
    return jsonError(e);
  }
}
