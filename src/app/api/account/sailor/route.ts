import { NextResponse } from "next/server";
import { and, eq, ne } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { equipmentLogs, sailorAliases, sailors } from "@/db/schema";
import { validateHandle } from "@/lib/handles";
import { normalizeDob } from "@/lib/normalize";
import {
  asHttpUrl,
  asOptionalNumber,
  asString,
  asUuid,
} from "@/lib/validate";

function strOrNull(v: unknown, max: number) {
  return asString(v, max);
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
    const sailorIdR = asUuid(body.sailorId, "sailorId");
    if (!sailorIdR.ok) {
      return NextResponse.json({ error: sailorIdR.error }, { status: 400 });
    }
    const sailorId = sailorIdR.value;

    const [sailor] = await db
      .select({
        id: sailors.id,
        parentId: sailors.parentId,
        handle: sailors.handle,
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
    let previousHandle: string | null = null;

    if (body.handle !== undefined) {
      const checked = validateHandle(String(body.handle));
      if (!checked.ok) {
        return NextResponse.json({ error: checked.error }, { status: 400 });
      }
      if (checked.handle !== sailor.handle) {
        const [taken] = await db
          .select({ id: sailors.id })
          .from(sailors)
          .where(and(eq(sailors.handle, checked.handle), ne(sailors.id, sailorId)))
          .limit(1);
        if (taken) {
          return NextResponse.json(
            { error: "That profile URL is already taken" },
            { status: 409 }
          );
        }
        const [aliasTaken] = await db
          .select({ id: sailorAliases.id })
          .from(sailorAliases)
          .where(eq(sailorAliases.aliasName, checked.handle))
          .limit(1);
        if (aliasTaken) {
          return NextResponse.json(
            { error: "That profile URL is already taken" },
            { status: 409 }
          );
        }
        previousHandle = sailor.handle;
        patch.handle = checked.handle;
      }
    }

    if (body.bio !== undefined) {
      patch.bio = strOrNull(body.bio, 500);
    }
    if (body.sailingJourney !== undefined) {
      const { parseSailingJourney, serializeSailingJourney } = await import(
        "@/lib/sailingJourney"
      );
      if (body.sailingJourney === null || body.sailingJourney === "") {
        patch.sailingJourney = null;
      } else {
        const items = parseSailingJourney(body.sailingJourney);
        patch.sailingJourney = serializeSailingJourney(items);
      }
    }
    if (body.instagram !== undefined) {
      patch.instagram = strOrNull(body.instagram, 80);
    }
    if (body.avatarUrl !== undefined) {
      const urlR = asHttpUrl(body.avatarUrl, "avatarUrl", 500);
      if (!urlR.ok) {
        return NextResponse.json({ error: urlR.error }, { status: 400 });
      }
      patch.avatarUrl = urlR.value;
    }
    if (body.school !== undefined) {
      patch.school = strOrNull(body.school, 120);
    }
    if (body.club !== undefined) {
      const club = strOrNull(body.club, 120);
      if (!club) {
        return NextResponse.json(
          { error: "Club cannot be empty" },
          { status: 400 }
        );
      }
      patch.club = club;
    }
    if (body.sailNumber !== undefined) {
      const sn = strOrNull(body.sailNumber, 40);
      if (!sn) {
        return NextResponse.json(
          { error: "Optimist sail number cannot be empty" },
          { status: 400 }
        );
      }
      patch.sailNumber = sn;
    }
    if (body.sailNumberIlca4 !== undefined) {
      patch.sailNumberIlca4 = strOrNull(body.sailNumberIlca4, 40);
    }
    if (body.dob !== undefined) {
      if (body.dob === null || body.dob === "") {
        patch.dob = null;
      } else {
        const d = normalizeDob(body.dob);
        if (!d || !/^\d{4}-\d{2}-\d{2}$/.test(d)) {
          return NextResponse.json(
            { error: "Date of birth must be YYYY-MM-DD or a valid year" },
            { status: 400 }
          );
        }
        // Reject future DOBs and clearly invalid ages for youth Optimist
        const y = Number(d.slice(0, 4));
        if (y < 1995 || y > new Date().getFullYear() - 5) {
          return NextResponse.json(
            { error: "Please enter a realistic date of birth" },
            { status: 400 }
          );
        }
        patch.dob = d;
      }
    }
    if (body.weight !== undefined) {
      const wR = asOptionalNumber(body.weight, {
        min: 20,
        max: 120,
        field: "weight",
      });
      if (!wR.ok) {
        return NextResponse.json(
          { error: "Weight must be between 20 and 120 kg" },
          { status: 400 }
        );
      }
      patch.weight =
        wR.value == null ? null : Math.round(wR.value);
    }
    if (typeof body.isPublicWeight === "boolean") {
      patch.isPublicWeight = body.isPublicWeight;
    }
    if (typeof body.isPublicDob === "boolean") {
      patch.isPublicDob = body.isPublicDob;
    }
    // Equipment is always private for now — ignore client attempts to share
    patch.isPublicEquipment = false;

    let equipmentChanged = false;
    for (const [key, max] of [
      ["hullBrand", 80],
      ["sailMake", 80],
      ["foilBrand", 80],
      ["mast", 80],
      ["equipmentNotes", 400],
      ["hullBrandIlca4", 80],
      ["sailMakeIlca4", 80],
      ["foilBrandIlca4", 80],
      ["mastIlca4", 80],
      ["equipmentNotesIlca4", 400],
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
        club: sailors.club,
        sailNumber: sailors.sailNumber,
        sailNumberIlca4: sailors.sailNumberIlca4,
        dob: sailors.dob,
        weight: sailors.weight,
        isPublicWeight: sailors.isPublicWeight,
        isPublicDob: sailors.isPublicDob,
        isPublicEquipment: sailors.isPublicEquipment,
        sailingJourney: sailors.sailingJourney,
        hullBrand: sailors.hullBrand,
        sailMake: sailors.sailMake,
        foilBrand: sailors.foilBrand,
        mast: sailors.mast,
        equipmentNotes: sailors.equipmentNotes,
        hullBrandIlca4: sailors.hullBrandIlca4,
        sailMakeIlca4: sailors.sailMakeIlca4,
        foilBrandIlca4: sailors.foilBrandIlca4,
        mastIlca4: sailors.mastIlca4,
        equipmentNotesIlca4: sailors.equipmentNotesIlca4,
      });

    if (previousHandle && updated) {
      try {
        await db
          .insert(sailorAliases)
          .values({
            sailorId,
            aliasName: previousHandle,
          })
          .onConflictDoNothing();
      } catch (e) {
        console.warn("alias insert skipped", e);
      }
    }

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

    return NextResponse.json({
      ok: true,
      sailor: updated,
      handleChanged: Boolean(previousHandle),
      previousHandle,
    });
  } catch (e) {
    console.error("account sailor PATCH", e);
    return jsonError(e);
  }
}
