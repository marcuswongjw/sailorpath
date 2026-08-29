import { NextResponse } from "next/server";
import { and, eq } from "drizzle-orm";
import { db } from "@/db";
import { coachFollowedSailors, coachSquadMembers, coachSquads, sailors } from "@/db/schema";
import { jsonError, requireCoach } from "@/lib/auth";
import {
  ensureCoachSquad,
  getCoachSquadDashboard,
} from "@/lib/coachDashboard";

export async function GET() {
  try {
    const auth = await requireCoach();
    return NextResponse.json(await getCoachSquadDashboard(auth.userId), {
      headers: { "Cache-Control": "private, no-store" },
    });
  } catch (error) {
    return jsonError(error);
  }
}

export async function POST(request: Request) {
  try {
    const auth = await requireCoach();
    const body = await request.json();
    const sailorId = String(body.sailorId || "").trim();
    if (!sailorId) {
      return NextResponse.json({ error: "Choose a sailor to add" }, { status: 400 });
    }
    const [sailor] = await db
      .select({ id: sailors.id })
      .from(sailors)
      .where(eq(sailors.id, sailorId))
      .limit(1);
    if (!sailor) {
      return NextResponse.json({ error: "Sailor not found" }, { status: 404 });
    }
    const squad = await ensureCoachSquad(auth.userId);
    await db
      .insert(coachSquadMembers)
      .values({ squadId: squad.id, sailorId })
      .onConflictDoNothing();
    await db.delete(coachFollowedSailors).where(and(
      eq(coachFollowedSailors.coachId, auth.userId),
      eq(coachFollowedSailors.sailorId, sailorId)
    ));
    return NextResponse.json(await getCoachSquadDashboard(auth.userId), { status: 201 });
  } catch (error) {
    return jsonError(error);
  }
}

export async function PATCH(request: Request) {
  try {
    const auth = await requireCoach();
    const body = await request.json();
    const name = String(body.name || "").trim();
    if (!name || name.length > 80) {
      return NextResponse.json(
        { error: "Squad name must be between 1 and 80 characters" },
        { status: 400 }
      );
    }
    const squad = await ensureCoachSquad(auth.userId);
    await db
      .update(coachSquads)
      .set({ name, updatedAt: new Date() })
      .where(and(eq(coachSquads.id, squad.id), eq(coachSquads.coachId, auth.userId)));
    return NextResponse.json(await getCoachSquadDashboard(auth.userId));
  } catch (error) {
    return jsonError(error);
  }
}

export async function DELETE(request: Request) {
  try {
    const auth = await requireCoach();
    const sailorId = new URL(request.url).searchParams.get("sailorId")?.trim();
    if (!sailorId) {
      return NextResponse.json({ error: "sailorId required" }, { status: 400 });
    }
    const squad = await ensureCoachSquad(auth.userId);
    await db
      .delete(coachSquadMembers)
      .where(
        and(
          eq(coachSquadMembers.squadId, squad.id),
          eq(coachSquadMembers.sailorId, sailorId)
        )
      );
    return NextResponse.json(await getCoachSquadDashboard(auth.userId));
  } catch (error) {
    return jsonError(error);
  }
}
