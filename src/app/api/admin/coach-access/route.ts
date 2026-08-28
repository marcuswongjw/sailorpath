import { NextResponse } from "next/server";
import { desc, eq } from "drizzle-orm";
import { db } from "@/db";
import { coachAccessRequests, profiles } from "@/db/schema";
import { jsonError, requireSuperadmin } from "@/lib/auth";
import { logAdminChange } from "@/lib/adminChangeLog";

export async function GET() {
  try {
    await requireSuperadmin();
    const requests = await db
      .select({
        id: coachAccessRequests.id,
        requesterId: coachAccessRequests.requesterId,
        status: coachAccessRequests.status,
        requestedAt: coachAccessRequests.requestedAt,
        reviewedAt: coachAccessRequests.reviewedAt,
        requesterName: profiles.fullName,
        requesterEmail: profiles.email,
        requesterRole: profiles.role,
      })
      .from(coachAccessRequests)
      .innerJoin(profiles, eq(coachAccessRequests.requesterId, profiles.id))
      .orderBy(desc(coachAccessRequests.requestedAt));

    return NextResponse.json({ requests });
  } catch (error) {
    return jsonError(error);
  }
}

export async function PATCH(req: Request) {
  try {
    const auth = await requireSuperadmin();
    const body = await req.json();
    const id = String(body.id || "").trim();
    const action = String(body.action || "").trim();
    if (!id || !["approve", "reject"].includes(action)) {
      return NextResponse.json(
        { error: "id and action (approve|reject) are required" },
        { status: 400 }
      );
    }

    const result = await db.transaction(async (tx) => {
      const [request] = await tx
        .select({
          requesterId: coachAccessRequests.requesterId,
          requesterName: profiles.fullName,
          requesterEmail: profiles.email,
          requesterRole: profiles.role,
        })
        .from(coachAccessRequests)
        .innerJoin(profiles, eq(coachAccessRequests.requesterId, profiles.id))
        .where(eq(coachAccessRequests.id, id))
        .limit(1);
      if (!request) return null;

      const status = action === "approve" ? "approved" : "rejected";
      if (action === "approve" && request.requesterRole !== "superadmin") {
        await tx
          .update(profiles)
          .set({ role: "coach", updatedAt: new Date() })
          .where(eq(profiles.id, request.requesterId));
      }
      await tx
        .update(coachAccessRequests)
        .set({
          status,
          reviewedAt: new Date(),
          reviewedBy: auth.userId,
          updatedAt: new Date(),
        })
        .where(eq(coachAccessRequests.id, id));

      return { ...request, status };
    });

    if (!result) {
      return NextResponse.json({ error: "Request not found" }, { status: 404 });
    }

    await logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: action === "approve" ? "coach_access_approved" : "coach_access_rejected",
      entityType: "profile",
      entityId: result.requesterId,
      entityLabel: result.requesterName,
      summary: `${action === "approve" ? "Approved" : "Rejected"} coach access for ${result.requesterName}`,
      details: { requestId: id, requesterEmail: result.requesterEmail },
      source: "/api/admin/coach-access",
    });

    return NextResponse.json({ ok: true, status: result.status });
  } catch (error) {
    console.error("admin coach access", error);
    return jsonError(error);
  }
}
