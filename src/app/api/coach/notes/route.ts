import { NextResponse } from "next/server";
import { and, eq } from "drizzle-orm";
import { db } from "@/db";
import { coachSailorNotes } from "@/db/schema";
import { jsonError, requireCoach } from "@/lib/auth";
import { canAccessCoachSailor } from "@/lib/coachDashboard";

export async function PUT(request: Request) {
  try {
    const auth = await requireCoach();
    const body = await request.json();
    const sailorId = String(body.sailorId || "").trim();
    const note = String(body.note || "").trim();
    const visibility = body.visibility === "shared" ? "shared" : "coach_only";
    if (!sailorId || note.length > 4000) {
      return NextResponse.json({ error: "Note must be 4,000 characters or fewer" }, { status: 400 });
    }
    const allowed = await canAccessCoachSailor(auth.userId, sailorId);
    if (!allowed) return NextResponse.json({ error: "Sailor is not in your coach workspace" }, { status: 404 });

    if (!note) {
      await db.delete(coachSailorNotes).where(and(
        eq(coachSailorNotes.coachId, auth.userId), eq(coachSailorNotes.sailorId, sailorId)
      ));
    } else {
      await db.insert(coachSailorNotes).values({ coachId: auth.userId, sailorId, note, visibility })
        .onConflictDoUpdate({
          target: [coachSailorNotes.coachId, coachSailorNotes.sailorId],
          set: { note, visibility, updatedAt: new Date() },
        });
    }
    return NextResponse.json({ note, visibility }, { headers: { "Cache-Control": "private, no-store" } });
  } catch (error) {
    return jsonError(error);
  }
}
