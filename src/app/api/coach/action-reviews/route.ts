import { NextResponse } from "next/server";
import { and, eq } from "drizzle-orm";
import { db } from "@/db";
import { coachActionReviews, coachSquadMembers, coachSquads } from "@/db/schema";
import { jsonError, requireCoach } from "@/lib/auth";
import { getCoachSquadDashboard } from "@/lib/coachDashboard";

export async function PUT(request: Request) {
  try {
    const auth = await requireCoach();
    const body = await request.json();
    const sailorId = String(body.sailorId || "").trim();
    const actionKey = String(body.actionKey || "").trim();
    const status = String(body.status || "").trim();
    if (!sailorId || !actionKey || actionKey.length > 240 || !["reviewed", "dismissed"].includes(status)) return NextResponse.json({ error: "Valid action and status required" }, { status: 400 });
    const [member] = await db.select({ id: coachSquadMembers.id }).from(coachSquadMembers)
      .innerJoin(coachSquads, eq(coachSquadMembers.squadId, coachSquads.id))
      .where(and(eq(coachSquads.coachId, auth.userId), eq(coachSquadMembers.sailorId, sailorId))).limit(1);
    if (!member) return NextResponse.json({ error: "Sailor is not in your squad" }, { status: 404 });
    await db.insert(coachActionReviews).values({ coachId: auth.userId, sailorId, actionKey, status: status as "reviewed" | "dismissed" })
      .onConflictDoUpdate({ target: [coachActionReviews.coachId, coachActionReviews.actionKey], set: { sailorId, status: status as "reviewed" | "dismissed", updatedAt: new Date() } });
    return NextResponse.json(await getCoachSquadDashboard(auth.userId));
  } catch (error) { return jsonError(error); }
}
