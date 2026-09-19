import { NextResponse } from "next/server";
import { revalidatePath, revalidateTag } from "next/cache";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db, ensureCoreSchema } from "@/db";
import { wingfoilRegattas } from "@/db/schema";
import { eq, or, sql } from "drizzle-orm";
import { auditAdminMutation } from "@/lib/adminChangeLog";
import {
  SINGAPORE_WINGFOIL_REGATTAS,
  sortWingfoilRegattas,
  type WingfoilRegatta,
} from "@/lib/wingfoil";

export async function GET(req: Request) {
  const sp = new URL(req.url).searchParams;
  const includeAll = sp.get("all") === "1" || sp.get("admin") === "1";

  if (includeAll) {
    try {
      await requireSuperadmin();
    } catch (error) {
      return jsonError(error);
    }
  }

  try {
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }

    const rows = includeAll
      ? await db.select().from(wingfoilRegattas)
      : await db
          .select()
          .from(wingfoilRegattas)
          .where(
            or(
              eq(wingfoilRegattas.status, "published"),
              sql`${wingfoilRegattas.status} IS NULL`
            )
          );

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
        } else {
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
        regattas: sortWingfoilRegattas(merged),
        source: "database",
      });
    }
  } catch (e) {
    console.warn("[/api/wingfoil] DB read warning (falling back to static):", e);
  }

  return NextResponse.json({
    regattas: sortWingfoilRegattas(SINGAPORE_WINGFOIL_REGATTAS),
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

    if (list.length > 100) {
      return NextResponse.json(
        { error: "Too many regattas in one request" },
        { status: 413 }
      );
    }

    const allowedLifecycleStatuses = new Set([
      "draft",
      "in_review",
      "published",
      "archived",
    ]);
    for (const regatta of list) {
      if (
        !regatta ||
        typeof regatta.id !== "string" ||
        !regatta.id.trim() ||
        regatta.id.length > 160 ||
        typeof regatta.name !== "string" ||
        !regatta.name.trim() ||
        (regatta.lifecycleStatus &&
          !allowedLifecycleStatuses.has(regatta.lifecycleStatus))
      ) {
        return NextResponse.json(
          { error: "Invalid WingFoil regatta payload" },
          { status: 400 }
        );
      }
    }

    const values = list.map((r) => {
      const status =
        r.lifecycleStatus ||
        (r.status === "Completed" ? "published" : "in_review");
      return {
        id: r.id,
        status,
        data: r,
        updatedAt: new Date(),
      };
    });

    // One bulk upsert avoids a database round trip for every event.
    await db
      .insert(wingfoilRegattas)
      .values(values)
      .onConflictDoUpdate({
        target: wingfoilRegattas.id,
        set: {
          status: sql`excluded.status`,
          data: sql`excluded.data`,
          updatedAt: sql`excluded.updated_at`,
        },
      });

    await auditAdminMutation({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "upsert_wingfoil_regattas",
      targetTable: "wingfoil_regattas",
      summary: `Upserted ${values.length} WingFoil regattas and scorecards`,
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
      savedCount: values.length,
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
