import { NextResponse } from "next/server";
import { and, eq } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { equipmentLogs, sailors } from "@/db/schema";

function strOrNull(v: unknown, max: number) {
  if (v === null || v === undefined || v === "") return null;
  return String(v).slice(0, max);
}

/**
 * Owner (parent_id) or superadmin can update sailor-facing profile fields.
 * Ranking / fleet / squad fields stay admin-only.
 */
export async function PATCH(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }

    const body = await req.json();
    const sailorId = String(body.sailorId || "").trim();
    if (!sailorId) {
      return NextResponse.json({ error: "sailorId required" }, { status: 400 });
    }

    const [sailor] = await db
      .select({
        id: sailors.id,
        parentId: sailors.parentId,
        hullBrand: sailors.hullBrand,
        sailMake: sailors.sailMake,
        foilBrand: sailors.foilBrand,
        mast: sailors.mast,
        equipmentNotes: sailors.equipmentNotes,
      })
      .from(sailors)
      .where(eq(sailors.id, sailorId))
      .limit(1);

    if (!sailor) {
      return NextResponse.json({ error: "Sailor not found" }, { status: 404 });
    }

    const isOwner = sailor.parentId === auth.userId;
    const isAdmin = auth.role === "superadmin";
    if (!isOwner && !isAdmin) {
      return NextResponse.json(
        { error: "You can only edit a profile after your claim is approved" },
        { status: 403 }
      );
    }

    const patch: Record<string, unknown> = { updatedAt: new Date() };

    if (body.bio !== undefined) {
      patch.bio = strOrNull(body.bio, 500);
    }
    if (body.instagram !== undefined) {
      patch.instagram = strOrNull(body.instagram, 80);
    }
    if (body.avatarUrl !== undefined) {
      const url = strOrNull(body.avatarUrl, 500);
      if (url && !/^https?:\/\//i.test(url)) {
        return NextResponse.json(
          { error: "Avatar URL must start with http:// or https://" },
          { status: 400 }
        );
      }
      patch.avatarUrl = url;
    }
    if (body.school !== undefined) {
      patch.school = strOrNull(body.school, 120);
    }
    if (body.weight !== undefined) {
      if (body.weight === null || body.weight === "") {
        patch.weight = null;
      } else {
        const w = Number(body.weight);
        if (!Number.isFinite(w) || w < 20 || w > 120) {
          return NextResponse.json(
            { error: "Weight must be between 20 and 120 kg" },
            { status: 400 }
          );
        }
        patch.weight = Math.round(w);
      }
    }
    if (typeof body.isPublicWeight === "boolean") {
      patch.isPublicWeight = body.isPublicWeight;
    }
    if (typeof body.isPublicDob === "boolean") {
      patch.isPublicDob = body.isPublicDob;
    }
    if (typeof body.isPublicEquipment === "boolean") {
      patch.isPublicEquipment = body.isPublicEquipment;
    }

    // Equipment (current)
    let equipmentChanged = false;
    for (const [key, max] of [
      ["hullBrand", 80],
      ["sailMake", 80],
      ["foilBrand", 80],
      ["mast", 80],
      ["equipmentNotes", 400],
    ] as const) {
      if (body[key] !== undefined) {
        const next = strOrNull(body[key], max);
        patch[key] = next;
        if (next !== (sailor as any)[key]) equipmentChanged = true;
      }
    }

    const [updated] = await db
      .update(sailors)
      .set(patch)
      .where(
        isAdmin
          ? eq(sailors.id, sailorId)
          : and(eq(sailors.id, sailorId), eq(sailors.parentId, auth.userId))
      )
      .returning({
        id: sailors.id,
        handle: sailors.handle,
        bio: sailors.bio,
        instagram: sailors.instagram,
        avatarUrl: sailors.avatarUrl,
        school: sailors.school,
        weight: sailors.weight,
        isPublicWeight: sailors.isPublicWeight,
        isPublicDob: sailors.isPublicDob,
        isPublicEquipment: sailors.isPublicEquipment,
        hullBrand: sailors.hullBrand,
        sailMake: sailors.sailMake,
        foilBrand: sailors.foilBrand,
        mast: sailors.mast,
        equipmentNotes: sailors.equipmentNotes,
      });

    // Snapshot equipment history when gear fields change
    if (equipmentChanged && updated) {
      try {
        await db.insert(equipmentLogs).values({
          sailorId,
          effectiveDate: new Date().toISOString().slice(0, 10),
          hullBrand: updated.hullBrand,
          sailMake: updated.sailMake,
          foilBrand: updated.foilBrand,
          mast: updated.mast,
          notes: updated.equipmentNotes,
        });
      } catch (e) {
        console.warn("equipment log insert skipped", e);
      }
    }

    return NextResponse.json({ ok: true, sailor: updated });
  } catch (e) {
    console.error("account sailor PATCH", e);
    return jsonError(e);
  }
}
