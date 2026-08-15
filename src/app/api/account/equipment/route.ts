import { NextResponse } from "next/server";
import { and, desc, eq, inArray } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import {
  equipmentItems,
  equipmentUsages,
  regattaResults,
  regattas,
  sailors,
} from "@/db/schema";
import {
  mapEquipmentRow,
  parseWindRange,
  serializeTags,
  type EquipmentBoatClass,
  type EquipmentCategory,
  type EquipmentCondition,
  type EquipmentStatus,
  type EquipmentUsageHistory,
} from "@/lib/equipment";
import { todayYmdSg } from "@/lib/datesSg";

function resolveSessionSource(body: {
  sessionType?: unknown;
  regattaId?: unknown;
}): { source: "regatta" | "training" | "manual"; regattaId: string | null } {
  const rawType = String(body.sessionType || "")
    .trim()
    .toLowerCase();
  const regattaId = body.regattaId ? String(body.regattaId).trim() : null;
  if (rawType === "training") {
    return { source: "training", regattaId: null };
  }
  if (rawType === "regatta" || regattaId) {
    return { source: "regatta", regattaId: regattaId || null };
  }
  // Legacy: regatta link ⇒ regatta, else training-style manual
  if (regattaId) return { source: "regatta", regattaId };
  return { source: "training", regattaId: null };
}

function isRegattaSession(source: string | null | undefined, regattaId: string | null) {
  if (source === "regatta") return true;
  if (source === "training") return false;
  // Legacy rows: linked regatta counted as regatta
  return Boolean(regattaId);
}

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

/** Equipment is always private — owner or superadmin only (no public view). */
async function assertCanView(sailorId: string, userId: string | null, role: string | null) {
  const [sailor] = await db
    .select({
      id: sailors.id,
      parentId: sailors.parentId,
    })
    .from(sailors)
    .where(eq(sailors.id, sailorId))
    .limit(1);
  if (!sailor) return { error: "Sailor not found", status: 404 as const };
  const isOwner = Boolean(userId && sailor.parentId === userId);
  const isAdmin = role === "superadmin";
  if (!isOwner && !isAdmin) {
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

    // Usage history + ranks for equipment ↔ results linkage
    const itemIds = rows.map((r) => r.id);
    const historyByItem = new Map<string, EquipmentUsageHistory[]>();
    const regattaCountByItem = new Map<string, number>();
    const trainingCountByItem = new Map<string, number>();
    /** regattaId → compact gear labels for results list */
    const gearByRegatta: Record<
      string,
      { category: string; brand: string | null; label: string | null }[]
    > = {};

    if (itemIds.length > 0) {
      try {
        const usageRows = await db
          .select({
            equipmentItemId: equipmentUsages.equipmentItemId,
            usedOn: equipmentUsages.usedOn,
            regattaId: equipmentUsages.regattaId,
            source: equipmentUsages.source,
            regattaName: regattas.name,
            regattaDate: regattas.date,
          })
          .from(equipmentUsages)
          .leftJoin(regattas, eq(equipmentUsages.regattaId, regattas.id))
          .where(eq(equipmentUsages.sailorId, sailorId))
          .orderBy(desc(equipmentUsages.usedOn));

        // Ranks for linked regattas
        const regIds = [
          ...new Set(
            usageRows
              .map((u) => u.regattaId)
              .filter((id): id is string => Boolean(id))
          ),
        ];
        const rankMap = new Map<string, number>();
        if (regIds.length > 0) {
          const ranks = await db
            .select({
              regattaId: regattaResults.regattaId,
              rank: regattaResults.rank,
            })
            .from(regattaResults)
            .where(
              and(
                eq(regattaResults.sailorId, sailorId),
                inArray(regattaResults.regattaId, regIds)
              )
            );
          for (const r of ranks) rankMap.set(r.regattaId, r.rank);
        }

        const itemMeta = new Map(
          rows.map((r) => [
            r.id,
            {
              category: r.category,
              brand: r.brand,
              label: r.label,
            },
          ])
        );

        for (const u of usageRows) {
          const isReg = isRegattaSession(u.source, u.regattaId);
          if (isReg) {
            regattaCountByItem.set(
              u.equipmentItemId,
              (regattaCountByItem.get(u.equipmentItemId) || 0) + 1
            );
          } else {
            trainingCountByItem.set(
              u.equipmentItemId,
              (trainingCountByItem.get(u.equipmentItemId) || 0) + 1
            );
          }

          const hist: EquipmentUsageHistory = {
            regattaId: u.regattaId,
            regattaName: u.regattaName || null,
            regattaDate: u.regattaDate
              ? String(u.regattaDate).slice(0, 10)
              : null,
            rank: u.regattaId ? rankMap.get(u.regattaId) ?? null : null,
            usedOn: String(u.usedOn).slice(0, 10),
          };
          const list = historyByItem.get(u.equipmentItemId) || [];
          if (list.length < 8) list.push(hist);
          historyByItem.set(u.equipmentItemId, list);

          if (u.regattaId) {
            const meta = itemMeta.get(u.equipmentItemId);
            if (meta) {
              const g = gearByRegatta[u.regattaId] || [];
              if (
                !g.some(
                  (x) =>
                    x.category === meta.category &&
                    x.brand === meta.brand &&
                    x.label === meta.label
                )
              ) {
                g.push(meta);
                gearByRegatta[u.regattaId] = g;
              }
            }
          }
        }
      } catch {
        /* usages optional until migration */
      }
    }

    const mapped = rows.map((r) => {
      const base = mapEquipmentRow({
        ...r,
        windRange: (r as { windRange?: string | null }).windRange ?? null,
        acquiredOn: r.acquiredOn ? String(r.acquiredOn) : null,
        retiredOn: r.retiredOn ? String(r.retiredOn) : null,
        lastUsedOn: r.lastUsedOn ? String(r.lastUsedOn) : null,
        regattaUseCount: regattaCountByItem.get(r.id) || 0,
        trainingUseCount: trainingCountByItem.get(r.id) || 0,
      });
      return {
        ...base,
        usageHistory: historyByItem.get(r.id) || [],
      };
    });

    const alerts = mapped.filter(
      (i) => i.needsAttention && i.status !== "retired"
    );

    return NextResponse.json({
      items: mapped,
      alerts,
      gearByRegatta,
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
    if (!["optimist", "ilca4", "other"].includes(boatClass)) {
      return NextResponse.json({ error: "Invalid boat class" }, { status: 400 });
    }

    // Full rig set: mast + boom + sprit in one request
    if (body.fullRig === true) {
      const brand =
        body.brand != null ? String(body.brand).slice(0, 120) : null;
      const tags = serializeTags(body.tags);
      const acquiredOn = body.acquiredOn
        ? String(body.acquiredOn).slice(0, 10)
        : null;
      const parts: {
        category: EquipmentCategory;
        brand?: string | null;
        model?: string | null;
        label?: string | null;
      }[] = [
        {
          category: "mast",
          brand: body.mastBrand ?? brand,
          model: body.mastModel ?? null,
          label: body.mastLabel ?? null,
        },
        {
          category: "boom",
          brand: body.boomBrand ?? brand,
          model: body.boomModel ?? null,
          label: body.boomLabel ?? null,
        },
        {
          category: "sprit",
          brand: body.spritBrand ?? brand,
          model: body.spritModel ?? null,
          label: body.spritLabel ?? null,
        },
      ];
      const created = [];
      for (const p of parts) {
        await clearOtherPrimaries(sailorId, boatClass, p.category);
        const [row] = await db
          .insert(equipmentItems)
          .values({
            sailorId,
            boatClass,
            category: p.category,
            brand: p.brand ? String(p.brand).slice(0, 120) : null,
            model: p.model ? String(p.model).slice(0, 120) : null,
            label: p.label ? String(p.label).slice(0, 120) : null,
            status: "active",
            condition: "good",
            isPrimary: true,
            tags,
            acquiredOn,
          })
          .returning();
        created.push(
          mapEquipmentRow({
            ...row,
            windRange: null,
            acquiredOn: row.acquiredOn ? String(row.acquiredOn) : null,
            retiredOn: row.retiredOn ? String(row.retiredOn) : null,
            lastUsedOn: row.lastUsedOn ? String(row.lastUsedOn) : null,
          })
        );
      }
      await syncLegacyPrimaries(sailorId);
      return NextResponse.json({ items: created, fullRig: true });
    }

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

    const isPrimary = body.isPrimary !== false;
    if (isPrimary) {
      await clearOtherPrimaries(sailorId, boatClass, category);
    }

    const windRange = parseWindRange(body.windRange);

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
        windRange,
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
        windRange: (row as { windRange?: string | null }).windRange ?? null,
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

    // Bulk actions: { bulk: true, ids: [], action: archive|tag|logUse|setPrimary, ... }
    if (body.bulk === true && Array.isArray(body.ids)) {
      const ids = body.ids.map((x: unknown) => String(x)).filter(Boolean);
      if (!ids.length) {
        return NextResponse.json({ error: "ids required" }, { status: 400 });
      }
      const rows = await db
        .select()
        .from(equipmentItems)
        .where(inArray(equipmentItems.id, ids));
      if (!rows.length) {
        return NextResponse.json({ error: "Not found" }, { status: 404 });
      }
      const sailorId = rows[0].sailorId;
      if (rows.some((r) => r.sailorId !== sailorId)) {
        return NextResponse.json(
          { error: "All items must belong to the same sailor" },
          { status: 400 }
        );
      }
      const gate = await assertCanEdit(sailorId, auth.userId, auth.role);
      if ("error" in gate) {
        return NextResponse.json({ error: gate.error }, { status: gate.status });
      }
      const action = String(body.action || "");
      if (action === "archive") {
        await db
          .update(equipmentItems)
          .set({
            status: "retired",
            isPrimary: false,
            retiredOn: todayYmdSg(),
            updatedAt: new Date(),
          })
          .where(inArray(equipmentItems.id, ids));
        await syncLegacyPrimaries(sailorId);
        return NextResponse.json({ ok: true, action: "archive", count: ids.length });
      }
      if (action === "tag") {
        const extra = serializeTags(body.tags);
        if (!extra) {
          return NextResponse.json({ error: "tags required" }, { status: 400 });
        }
        for (const r of rows) {
          const merged = serializeTags([
            ...String(r.tags || "").split(","),
            ...extra.split(","),
          ]);
          await db
            .update(equipmentItems)
            .set({ tags: merged, updatedAt: new Date() })
            .where(eq(equipmentItems.id, r.id));
        }
        return NextResponse.json({ ok: true, action: "tag", count: ids.length });
      }
      if (action === "logUse" || action === "logSession") {
        const usedOn = body.usedOn
          ? String(body.usedOn).slice(0, 10)
          : todayYmdSg();
        const { source, regattaId } = resolveSessionSource(body);
        if (source === "regatta" && !regattaId) {
          return NextResponse.json(
            { error: "Select a regatta for regatta sessions" },
            { status: 400 }
          );
        }
        const wind = parseWindRange(body.wind);
        for (const r of rows) {
          try {
            await db.insert(equipmentUsages).values({
              equipmentItemId: r.id,
              sailorId,
              usedOn,
              regattaId: regattaId || null,
              source,
              wind,
              note: body.note != null ? String(body.note).slice(0, 500) : null,
            });
          } catch {
            // wind column may be missing until migration 042 — retry without wind
            await db.insert(equipmentUsages).values({
              equipmentItemId: r.id,
              sailorId,
              usedOn,
              regattaId: regattaId || null,
              source,
              note: body.note != null ? String(body.note).slice(0, 500) : null,
            });
          }
          await db
            .update(equipmentItems)
            .set({
              useCount: (r.useCount || 0) + 1,
              lastUsedOn: usedOn,
              updatedAt: new Date(),
            })
            .where(eq(equipmentItems.id, r.id));
        }
        return NextResponse.json({
          ok: true,
          action: "logSession",
          count: ids.length,
        });
      }
      return NextResponse.json({ error: "Unknown bulk action" }, { status: 400 });
    }

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

    // Log session shortcut
    if (body.logUse === true || body.logSession === true) {
      const usedOn = body.usedOn
        ? String(body.usedOn).slice(0, 10)
        : todayYmdSg();
      const { source, regattaId } = resolveSessionSource(body);
      if (source === "regatta" && !regattaId) {
        return NextResponse.json(
          { error: "Select a regatta for regatta sessions" },
          { status: 400 }
        );
      }
      const wind = parseWindRange(body.wind);

      try {
        await db.insert(equipmentUsages).values({
          equipmentItemId: id,
          sailorId: existing.sailorId,
          usedOn,
          regattaId: regattaId || null,
          source,
          wind,
          note: body.note != null ? String(body.note).slice(0, 500) : null,
        });
      } catch {
        await db.insert(equipmentUsages).values({
          equipmentItemId: id,
          sailorId: existing.sailorId,
          usedOn,
          regattaId: regattaId || null,
          source,
          note: body.note != null ? String(body.note).slice(0, 500) : null,
        });
      }

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
    if (body.windRange !== undefined)
      patch.windRange = parseWindRange(body.windRange);
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
