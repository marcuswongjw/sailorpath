import { withUserChangeTracking } from "@/lib/userChanges";
import { NextResponse } from "next/server";
import { and, eq } from "drizzle-orm";
import { db } from "@/db";
import { coachFollowedSailors, coachSquadMembers, coachSquads, sailors } from "@/db/schema";
import { jsonError, requireCoach } from "@/lib/auth";
import { getCoachSquadDashboard } from "@/lib/coachDashboard";

async function handlePOST(request: Request) {
  try {
    const auth = await requireCoach();
    const body = await request.json();
    const sailorId = String(body.sailorId || "").trim();
    if (!sailorId) return NextResponse.json({ error: "Choose a sailor to follow" }, { status: 400 });
    const [sailor] = await db.select({ id: sailors.id }).from(sailors).where(eq(sailors.id, sailorId)).limit(1);
    if (!sailor) return NextResponse.json({ error: "Sailor not found" }, { status: 404 });
    const [managed] = await db.select({ id: coachSquadMembers.id })
      .from(coachSquadMembers)
      .innerJoin(coachSquads, eq(coachSquadMembers.squadId, coachSquads.id))
      .where(and(eq(coachSquads.coachId, auth.userId), eq(coachSquadMembers.sailorId, sailorId)))
      .limit(1);
    if (managed) return NextResponse.json({ error: "This sailor is already in your squad" }, { status: 409 });
    await db.insert(coachFollowedSailors).values({ coachId: auth.userId, sailorId }).onConflictDoNothing();
    return NextResponse.json(await getCoachSquadDashboard(auth.userId), { status: 201 });
  } catch (error) {
    return jsonError(error);
  }
}

async function handleDELETE(request: Request) {
  try {
    const auth = await requireCoach();
    const sailorId = new URL(request.url).searchParams.get("sailorId")?.trim();
    if (!sailorId) return NextResponse.json({ error: "sailorId required" }, { status: 400 });
    await db.delete(coachFollowedSailors).where(and(
      eq(coachFollowedSailors.coachId, auth.userId),
      eq(coachFollowedSailors.sailorId, sailorId)
    ));
    return NextResponse.json(await getCoachSquadDashboard(auth.userId));
  } catch (error) {
    return jsonError(error);
  }
}

export const POST = withUserChangeTracking("coach_following", handlePOST);
export const DELETE = withUserChangeTracking("coach_following", handleDELETE);
