import { NextResponse } from "next/server";
import { and, desc, eq } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { equipmentItems, equipmentUsages, sailors } from "@/db/schema";
import {
  mapEquipmentRow,
  serializeTags,
  type EquipmentBoatClass,
  type EquipmentCategory,
  type EquipmentCondition,
  type EquipmentStatus,
} from "@/lib/equipment";
import { todayYmdSg } from "@/lib/datesSg";

async function assertCanEdit(sailorId: string, userId: string, role: string) {
  const [sailor] = await db
    .select({ id: sailors.id, parentId: sailors.parentId })
    .from(sailors)
    .where(eq(sailors.id, sailorId))
    .limit(1);
  if (!sailor) return { error: "Sailor not found", status: 404 as const };
  const ok = sailor.parentId === userId || role === "superadmin";
  if (!ok) return { error: "Not allowed", status: 403 as const };
  return { sailor };
}

async function assertCanView(sailorId: string, userId: string | null, role: string | null) {
  const [sailor] = await db
    .select({
      id: sailors.id,
      parentId: sailors.parentId,
      isPublicEquipment: sailors.isPublicEquipment,
    })
    .from(sailors)
    .where(eq(sailors.id, sailorId))
    .limit(1);
  if (!sailor) return { error: "Sailor not found", status: 404 as const };
  const isOwner = Boolean(userId && sailor.parentId === userId);
  const isAdmin = role === "superadmin";
  if (!sailor.isPublicEquipment && !isOwner && !isAdmin) {
    return { error: "Equipment is private", status: 403 as const, sailor };
  }
  return { sailor, isOwner: isOwner || isAdmin };
}

/** Sync primary optimist/ilca items → legacy sailor columns for old UI paths */
async function syncLegacyPrimaries(sailorId: string) {
  const items = await db
    .select()
    .from(equipmentItems)
    .where(
      and(eq(equipmentItems.sailorId, sailorId), eq(equipmentItems.isPrimary, true))
    );

  const patch: Record<string, unknown> = { updatedAt: new Date() };
  const pick = (cls: string, cat: string) =>
    items.find((i) => i.boatClass === cls && i.category === cat);

  const oh = pick("optimist", "hull");
  const os = pick("optimist", "sail");
  const om = pick("optimist", "mast");
  const od =
    pick("optimist", "daggerboard") || pick("optimist", "rudder");
  if (oh) patch.hullBrand = oh.brand;
  if (os) patch.sailMake = os.brand;
  if (om) patch.mast = om.brand;
  if (od) patch.foilBrand = od.brand;

  const ih = pick("ilca4", "hull");
  const isail = pick("ilca4", "sail");
  const im = pick("ilca4", "mast");
  const idb = pick("ilca4", "daggerboard") || pick("ilca4", "rudder");
  if (ih) patch.hullBrandIlca4 = ih.brand;
  if (isail) patch.sailMakeIlca4 = isail.brand;
  if (im) patch.mastIlca4 = im.brand;
  if (idb) patch.foilBrandIlca4 = idb.brand;

  if (Object.keys(patch).length > 1) {
    await db.update(sailors).set(patch).where(eq(sailors.id, sailorId));
  }
}

async function clearOtherPrimaries(
  sailorId: string,
  boatClass: EquipmentBoatClass,
  category: EquipmentCategory,
  exceptId?: string
) {
  const rows = await db
    .select({ id: equipmentItems.id })
    .from(equipmentItems)
    .where(
      and(
        eq(equipmentItems.sailorId, sailorId),
        eq(equipmentItems.boatClass, boatClass),
        eq(equipmentItems.category, category),
        eq(equipmentItems.isPrimary, true)
      )
    );
  for (const r of rows) {
    if (exceptId && r.id === exceptId) continue;
    await db
      .update(equipmentItems)
      .set({ isPrimary: false, updatedAt: new Date() })
      .where(eq(equipmentItems.id, r.id));
  }
}

export async function GET(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const sailorId = String(searchParams.get("sailorId") || "").trim();
    if (!sailorId) {
      return NextResponse.json({ error: "sailorId required" }, { status: 400 });
    }

    let userId: string | null = null;
    let role: string | null = null;
    try {
      const auth = await getAuthContext();
      userId = auth?.userId ?? null;
      role = auth?.role ?? null;
    } catch {
      /* public */
    }

    const access = await assertCanView(sailorId, userId, role);
    if ("error" in access && access.status === 404) {
      return NextResponse.json({ error: access.error }, { status: 404 });
    }
    // Private and not owner
    if ("error" in access && access.status === 403) {
      return NextResponse.json({
        items: [],
        private: true,
        isOwner: false,
      });
    }

    const isOwner = Boolean(
      access && "isOwner" in access && access.isOwner
    );

    const rows = await db
      .select()
      .from(equipmentItems)
      .where(eq(equipmentItems.sailorId, sailorId))
      .orderBy(desc(equipmentItems.isPrimary), desc(equipmentItems.updatedAt));

    let mapped = rows.map((r) =>
      mapEquipmentRow({
        ...r,
        acquiredOn: r.acquiredOn ? String(r.acquiredOn) : null,
        retiredOn: r.retiredOn ? String(r.retiredOn) : null,
        lastUsedOn: r.lastUsedOn ? String(r.lastUsedOn) : null,
      })
    );

    // Public: only primary active items
    if (!isOwner) {
      mapped = mapped.filter(
        (i) => i.isPrimary && i.status === "active"
      );
    }

    const alerts = mapped.filter((i) => i.needsAttention && i.status !== "retired");

    return NextResponse.json({
      items: mapped,
      alerts: isOwner ? alerts : [],
      isOwner,
      private: false,
    });
  } catch (e) {
    console.error("equipment GET", e);
    return jsonError(e);
  }
}

export async function POST(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    const body = await req.json();
    const sailorId = String(body.sailorId || "").trim();
    const gate = await assertCanEdit(sailorId, auth.userId, auth.role);
    if ("error" in gate) {
      return NextResponse.json({ error: gate.error }, { status: gate.status });
    }

    const boatClass = (String(body.boatClass || "optimist").toLowerCase() ||
      "optimist") as EquipmentBoatClass;
    const category = String(body.category || "").toLowerCase() as EquipmentCategory;
    const allowedCat = [
      "hull",
      "sail",
      "mast",
      "boom",
      "sprit",
      "daggerboard",
      "rudder",
      "other",
    ];
    if (!allowedCat.includes(category)) {
      return NextResponse.json({ error: "Invalid category" }, { status: 400 });
    }
    if (!["optimist", "ilca4", "other"].includes(boatClass)) {
      return NextResponse.json({ error: "Invalid boat class" }, { status: 400 });
    }

    const isPrimary = Boolean(body.isPrimary);
    if (isPrimary) {
      await clearOtherPrimaries(sailorId, boatClass, category);
    }

    const [row] = await db
      .insert(equipmentItems)
      .values({
        sailorId,
        boatClass,
        category,
        brand: body.brand != null ? String(body.brand).slice(0, 120) : null,
        model: body.model != null ? String(body.model).slice(0, 120) : null,
        label: body.label != null ? String(body.label).slice(0, 120) : null,
        status: (body.status as EquipmentStatus) || "active",
        condition: (body.condition as EquipmentCondition) || "good",
        isPrimary,
        tags: serializeTags(body.tags),
        acquiredOn: body.acquiredOn
          ? String(body.acquiredOn).slice(0, 10)
          : null,
        notes: body.notes != null ? String(body.notes).slice(0, 1000) : null,
      })
      .returning();

    if (isPrimary) await syncLegacyPrimaries(sailorId);

    return NextResponse.json({
      item: mapEquipmentRow({
        ...row,
        acquiredOn: row.acquiredOn ? String(row.acquiredOn) : null,
        retiredOn: row.retiredOn ? String(row.retiredOn) : null,
        lastUsedOn: row.lastUsedOn ? String(row.lastUsedOn) : null,
      }),
    });
  } catch (e) {
    console.error("equipment POST", e);
    return jsonError(e);
  }
}

export async function PATCH(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    const body = await req.json();
    const id = String(body.id || "").trim();
    if (!id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }

    const [existing] = await db
      .select()
      .from(equipmentItems)
      .where(eq(equipmentItems.id, id))
      .limit(1);
    if (!existing) {
      return NextResponse.json({ error: "Not found" }, { status: 404 });
    }

    const gate = await assertCanEdit(
      existing.sailorId,
      auth.userId,
      auth.role
    );
    if ("error" in gate) {
      return NextResponse.json({ error: gate.error }, { status: gate.status });
    }

    // Log use shortcut
    if (body.logUse === true) {
      const usedOn = body.usedOn
        ? String(body.usedOn).slice(0, 10)
        : todayYmdSg();
      const regattaId = body.regattaId
        ? String(body.regattaId).trim()
        : null;

      await db.insert(equipmentUsages).values({
        equipmentItemId: id,
        sailorId: existing.sailorId,
        usedOn,
        regattaId: regattaId || null,
        source: regattaId ? "regatta" : "manual",
        note: body.note != null ? String(body.note).slice(0, 500) : null,
      });

      const [updated] = await db
        .update(equipmentItems)
        .set({
          useCount: (existing.useCount || 0) + 1,
          lastUsedOn: usedOn,
          updatedAt: new Date(),
        })
        .where(eq(equipmentItems.id, id))
        .returning();

      return NextResponse.json({
        item: mapEquipmentRow({
          ...updated,
          acquiredOn: updated.acquiredOn
            ? String(updated.acquiredOn)
            : null,
          retiredOn: updated.retiredOn ? String(updated.retiredOn) : null,
          lastUsedOn: updated.lastUsedOn
            ? String(updated.lastUsedOn)
            : null,
        }),
      });
    }

    const patch: Record<string, unknown> = { updatedAt: new Date() };
    if (body.brand !== undefined)
      patch.brand = body.brand ? String(body.brand).slice(0, 120) : null;
    if (body.model !== undefined)
      patch.model = body.model ? String(body.model).slice(0, 120) : null;
    if (body.label !== undefined)
      patch.label = body.label ? String(body.label).slice(0, 120) : null;
    if (body.status !== undefined) patch.status = String(body.status);
    if (body.condition !== undefined) patch.condition = String(body.condition);
    if (body.notes !== undefined)
      patch.notes = body.notes ? String(body.notes).slice(0, 1000) : null;
    if (body.acquiredOn !== undefined)
      patch.acquiredOn = body.acquiredOn
        ? String(body.acquiredOn).slice(0, 10)
        : null;
    if (body.retiredOn !== undefined)
      patch.retiredOn = body.retiredOn
        ? String(body.retiredOn).slice(0, 10)
        : null;
    if (body.tags !== undefined) patch.tags = serializeTags(body.tags);
    if (body.category !== undefined) patch.category = String(body.category);
    if (body.boatClass !== undefined) patch.boatClass = String(body.boatClass);

    if (body.isPrimary === true) {
      await clearOtherPrimaries(
        existing.sailorId,
        (body.boatClass || existing.boatClass) as EquipmentBoatClass,
        (body.category || existing.category) as EquipmentCategory,
        id
      );
      patch.isPrimary = true;
    } else if (body.isPrimary === false) {
      patch.isPrimary = false;
    }

    if (body.status === "retired" && !body.retiredOn) {
      patch.retiredOn = todayYmdSg();
      patch.isPrimary = false;
    }

    const [updated] = await db
      .update(equipmentItems)
      .set(patch)
      .where(eq(equipmentItems.id, id))
      .returning();

    await syncLegacyPrimaries(existing.sailorId);

    return NextResponse.json({
      item: mapEquipmentRow({
        ...updated,
        acquiredOn: updated.acquiredOn ? String(updated.acquiredOn) : null,
        retiredOn: updated.retiredOn ? String(updated.retiredOn) : null,
        lastUsedOn: updated.lastUsedOn ? String(updated.lastUsedOn) : null,
      }),
    });
  } catch (e) {
    console.error("equipment PATCH", e);
    return jsonError(e);
  }
}

export async function DELETE(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    const { searchParams } = new URL(req.url);
    const id = String(searchParams.get("id") || "").trim();
    if (!id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }
    const [existing] = await db
      .select()
      .from(equipmentItems)
      .where(eq(equipmentItems.id, id))
      .limit(1);
    if (!existing) {
      return NextResponse.json({ error: "Not found" }, { status: 404 });
    }
    const gate = await assertCanEdit(
      existing.sailorId,
      auth.userId,
      auth.role
    );
    if ("error" in gate) {
      return NextResponse.json({ error: gate.error }, { status: gate.status });
    }
    await db.delete(equipmentItems).where(eq(equipmentItems.id, id));
    await syncLegacyPrimaries(existing.sailorId);
    return NextResponse.json({ ok: true });
  } catch (e) {
    return jsonError(e);
  }
}
