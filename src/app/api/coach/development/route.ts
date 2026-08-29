import { NextResponse } from "next/server";
import { and, eq, or } from "drizzle-orm";
import { db } from "@/db";
import { coachDevelopmentRecords, coachFollowedSailors, coachSquadMembers, coachSquads } from "@/db/schema";
import { jsonError, requireCoach } from "@/lib/auth";
import { getCoachSquadDashboard } from "@/lib/coachDashboard";

const TYPES = new Set(["observation", "goal", "attendance"]);
const STATUSES = new Set(["active", "completed", "present", "absent", "planned"]);
const isDate = (value: string) => /^\d{4}-\d{2}-\d{2}$/.test(value);

async function canAccess(coachId: string, sailorId: string) {
  const [row] = await db.select({ squadId: coachSquadMembers.id, followedId: coachFollowedSailors.id })
    .from(coachSquads)
    .leftJoin(coachSquadMembers, and(eq(coachSquadMembers.squadId, coachSquads.id), eq(coachSquadMembers.sailorId, sailorId)))
    .leftJoin(coachFollowedSailors, and(eq(coachFollowedSailors.coachId, coachId), eq(coachFollowedSailors.sailorId, sailorId)))
    .where(and(eq(coachSquads.coachId, coachId), or(eq(coachSquadMembers.sailorId, sailorId), eq(coachFollowedSailors.sailorId, sailorId))))
    .limit(1);
  return Boolean(row?.squadId || row?.followedId);
}

export async function POST(request: Request) {
  try {
    const auth = await requireCoach();
    const body = await request.json();
    const sailorId = String(body.sailorId || "").trim();
    const type = String(body.type || "").trim();
    const title = String(body.title || "").trim();
    const detail = String(body.detail || "").trim() || null;
    const category = String(body.category || "").trim() || null;
    const recordDate = String(body.recordDate || "").trim();
    const targetDate = String(body.targetDate || "").trim() || null;
    const status = String(body.status || "active").trim();
    if (!sailorId || !TYPES.has(type) || !title || title.length > 160 || !isDate(recordDate) || (targetDate && !isDate(targetDate)) || !STATUSES.has(status) || (detail?.length || 0) > 4000) {
      return NextResponse.json({ error: "Check the record type, title, dates, and status" }, { status: 400 });
    }
    if (!(await canAccess(auth.userId, sailorId))) return NextResponse.json({ error: "Sailor is not in your coach workspace" }, { status: 404 });
    await db.insert(coachDevelopmentRecords).values({
      coachId: auth.userId, sailorId, type: type as "observation" | "goal" | "attendance",
      category, title, detail, recordDate, status, targetDate,
    });
    return NextResponse.json(await getCoachSquadDashboard(auth.userId), { status: 201 });
  } catch (error) { return jsonError(error); }
}

export async function PATCH(request: Request) {
  try {
    const auth = await requireCoach();
    const body = await request.json();
    const id = String(body.id || "").trim();
    const status = String(body.status || "").trim();
    if (!id || !STATUSES.has(status)) return NextResponse.json({ error: "Valid record and status required" }, { status: 400 });
    const changed = await db.update(coachDevelopmentRecords).set({ status, updatedAt: new Date() })
      .where(and(eq(coachDevelopmentRecords.id, id), eq(coachDevelopmentRecords.coachId, auth.userId)))
      .returning({ id: coachDevelopmentRecords.id });
    if (!changed.length) return NextResponse.json({ error: "Record not found" }, { status: 404 });
    return NextResponse.json(await getCoachSquadDashboard(auth.userId));
  } catch (error) { return jsonError(error); }
}

export async function DELETE(request: Request) {
  try {
    const auth = await requireCoach();
    const id = new URL(request.url).searchParams.get("id")?.trim();
    if (!id) return NextResponse.json({ error: "id required" }, { status: 400 });
    await db.delete(coachDevelopmentRecords).where(and(eq(coachDevelopmentRecords.id, id), eq(coachDevelopmentRecords.coachId, auth.userId)));
    return NextResponse.json(await getCoachSquadDashboard(auth.userId));
  } catch (error) { return jsonError(error); }
}
