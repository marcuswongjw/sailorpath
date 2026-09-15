import { NextResponse } from "next/server";
import { revalidatePath, revalidateTag } from "next/cache";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db, ensureCoreSchema } from "@/db";
import { wingfoilRegattas } from "@/db/schema";
import { eq } from "drizzle-orm";
import { auditAdminMutation } from "@/lib/adminChangeLog";
import {
  SINGAPORE_WINGFOIL_REGATTAS,
  type WingfoilRegatta,
} from "@/lib/wingfoil";

export async function GET(req: Request) {
  try {
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }
    const sp = new URL(req.url).searchParams;
    const includeAll = sp.get("all") === "1" || sp.get("admin") === "1";

    const rows = await db.select().from(wingfoilRegattas);

    if (rows && rows.length > 0) {
      // Filter published only for public showcase, unless admin requested all
      const visibleRows = includeAll
        ? rows
        : rows.filter((r) => !r.status || r.status === "published");

      const rowMap = new Map(
        visibleRows.map((r) => [r.id, r.data as WingfoilRegatta])
      );
      const merged: WingfoilRegatta[] = [];
      const visited = new Set<string>();

      // Keep official regattas first
      for (const def of SINGAPORE_WINGFOIL_REGATTAS) {
        if (rowMap.has(def.id)) {
          merged.push(rowMap.get(def.id)!);
        } else if (!includeAll) {
          merged.push(def);
        }
        visited.add(def.id);
      }

      // Add uploaded/custom regattas
      for (const row of visibleRows) {
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
    const auth = await requireSuperadmin();
    if (typeof ensureCoreSchema === "function") {
      try {
        await ensureCoreSchema();
      } catch (e) {
        console.warn("[/api/wingfoil] ensureCoreSchema non-fatal note:", e);
      }
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
      const status =
        r.lifecycleStatus ||
        (r.status === "Completed" ? "published" : "in_review");
      await db
        .insert(wingfoilRegattas)
        .values({
          id: r.id,
          status,
          data: r,
          updatedAt: new Date(),
        })
        .onConflictDoUpdate({
          target: wingfoilRegattas.id,
          set: {
            status,
            data: r,
            updatedAt: new Date(),
          },
        });
    }

    await auditAdminMutation({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "upsert_wingfoil_regattas",
      targetTable: "wingfoil_regattas",
      summary: `Upserted ${list.length} WingFoil regattas and scorecards`,
      source: "/api/wingfoil",
    });

    try {
      revalidatePath("/sg/wingfoil");
      revalidatePath("/");
      revalidateTag("public-wingfoil", "max");
    } catch {
      // cache purge best-effort
    }

    return NextResponse.json({
      success: true,
      savedCount: list.length,
    });
  } catch (e) {
    const msg = e instanceof Error ? e.message : String(e);
    console.error("[/api/wingfoil] POST failure:", msg, e);
    if (msg === "UNAUTHORIZED" || msg === "FORBIDDEN") {
      return jsonError(e);
    }
    return NextResponse.json(
      { error: msg || "Failed to persist WingFoil regatta data" },
      { status: 500 }
    );
  }
}

export async function DELETE(req: Request) {
  try {
    const auth = await requireSuperadmin();
    if (typeof ensureCoreSchema === "function") {
      try {
        await ensureCoreSchema();
      } catch (e) {
        console.warn("[/api/wingfoil] ensureCoreSchema non-fatal note:", e);
      }
    }

    const { id } = await req.json();
    if (!id || typeof id !== "string") {
      return NextResponse.json({ error: "Missing regatta id" }, { status: 400 });
    }

    await db.delete(wingfoilRegattas).where(eq(wingfoilRegattas.id, id));

    await auditAdminMutation({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "delete_wingfoil_regatta",
      targetTable: "wingfoil_regattas",
      recordId: id,
      summary: `Deleted WingFoil regatta ${id}`,
      source: "/api/wingfoil",
    });

    try {
      revalidatePath("/sg/wingfoil");
      revalidatePath("/");
      revalidateTag("public-wingfoil", "max");
    } catch {}

    return NextResponse.json({ success: true, deletedId: id });
  } catch (e) {
    const msg = e instanceof Error ? e.message : String(e);
    console.error("[/api/wingfoil] DELETE failure:", msg, e);
    if (msg === "UNAUTHORIZED" || msg === "FORBIDDEN") {
      return jsonError(e);
    }
    return NextResponse.json(
      { error: msg || "Failed to delete WingFoil regatta" },
      { status: 500 }
    );
  }
}
