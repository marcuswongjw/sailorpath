import { NextResponse } from "next/server";
import { and, eq } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { raceObservations, sailors } from "@/db/schema";

async function assertOwner(sailorId: string, userId: string, isAdmin: boolean) {
  const [sailor] = await db
    .select({ id: sailors.id, parentId: sailors.parentId })
    .from(sailors)
    .where(eq(sailors.id, sailorId))
    .limit(1);
  if (!sailor) return { error: "Sailor not found", status: 404 as const };
  if (!isAdmin && sailor.parentId !== userId) {
    return {
      error: "You can only edit observations after claim is approved",
      status: 403 as const,
    };
  }
  return { sailor };
}

/** Create or update a race observation */
export async function POST(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    const body = await req.json();
    const sailorId = String(body.sailorId || "").trim();
    const regattaId = String(body.regattaId || "").trim();
    const raceNumber = Number(body.raceNumber);
    if (!sailorId || !regattaId || !Number.isFinite(raceNumber) || raceNumber < 1) {
      return NextResponse.json(
        { error: "sailorId, regattaId, and raceNumber (>=1) required" },
        { status: 400 }
      );
    }

    const gate = await assertOwner(
      sailorId,
      auth.userId,
      auth.role === "superadmin"
    );
    if ("error" in gate && gate.error) {
      return NextResponse.json({ error: gate.error }, { status: gate.status });
    }

    const position =
      body.position === "" || body.position == null
        ? null
        : Math.round(Number(body.position));
    if (position != null && (!Number.isFinite(position) || position < 1)) {
      return NextResponse.json({ error: "Invalid position" }, { status: 400 });
    }

    const values = {
      sailorId,
      regattaId,
      raceNumber: Math.round(raceNumber),
      position,
      wind:
        body.wind === "" || body.wind == null
          ? null
          : String(body.wind).slice(0, 80),
      note:
        body.note === "" || body.note == null
          ? null
          : String(body.note).slice(0, 1000),
      isPrivate: body.isPrivate === false ? false : true,
      updatedAt: new Date(),
    };

    const [row] = await db
      .insert(raceObservations)
      .values(values)
      .onConflictDoUpdate({
        target: [
          raceObservations.sailorId,
          raceObservations.regattaId,
          raceObservations.raceNumber,
        ],
        set: {
          position: values.position,
          wind: values.wind,
          note: values.note,
          isPrivate: values.isPrivate,
          updatedAt: new Date(),
        },
      })
      .returning();

    return NextResponse.json({ ok: true, observation: row });
  } catch (e) {
    console.error("observations POST", e);
    return jsonError(e);
  }
}

export async function DELETE(req: Request) {
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
      .from(raceObservations)
      .where(eq(raceObservations.id, id))
      .limit(1);
    if (!existing) {
      return NextResponse.json({ error: "Not found" }, { status: 404 });
    }

    const gate = await assertOwner(
      existing.sailorId,
      auth.userId,
      auth.role === "superadmin"
    );
    if ("error" in gate && gate.error) {
      return NextResponse.json({ error: gate.error }, { status: gate.status });
    }

    await db
      .delete(raceObservations)
      .where(
        and(
          eq(raceObservations.id, id),
          eq(raceObservations.sailorId, existing.sailorId)
        )
      );

    return NextResponse.json({ ok: true });
  } catch (e) {
    return jsonError(e);
  }
}
