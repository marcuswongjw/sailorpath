import { NextResponse } from "next/server";
import { and, eq } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { sailors } from "@/db/schema";

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
      .select({ id: sailors.id, parentId: sailors.parentId })
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
      patch.bio = body.bio === null || body.bio === "" ? null : String(body.bio).slice(0, 500);
    }
    if (body.instagram !== undefined) {
      patch.instagram =
        body.instagram === null || body.instagram === ""
          ? null
          : String(body.instagram).slice(0, 80);
    }
    if (body.avatarUrl !== undefined) {
      const url = body.avatarUrl === null || body.avatarUrl === "" ? null : String(body.avatarUrl).trim();
      if (url && !/^https?:\/\//i.test(url)) {
        return NextResponse.json(
          { error: "Avatar URL must start with http:// or https://" },
          { status: 400 }
        );
      }
      patch.avatarUrl = url;
    }
    if (body.school !== undefined) {
      patch.school =
        body.school === null || body.school === ""
          ? null
          : String(body.school).slice(0, 120);
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
      });

    return NextResponse.json({ ok: true, sailor: updated });
  } catch (e) {
    console.error("account sailor PATCH", e);
    return jsonError(e);
  }
}
