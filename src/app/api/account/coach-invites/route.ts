import { NextResponse } from "next/server";
import { eq } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { coachAccessRequests, profiles } from "@/db/schema";
import { notifyAccountRoleChange } from "@/lib/roleChangeNotify";
import { notifySuperadminAssignedRoleAccepted } from "@/lib/notifications";

/**
 * The invited account accepts or declines a coach invitation from the email link.
 * Body: { token: string, action: "accept" | "decline" }
 */
export async function POST(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }

    const body = await req.json().catch(() => ({}));
    const token = String(body.token || "").trim();
    const action = String(body.action || "").trim();
    if (!token || !["accept", "decline"].includes(action)) {
      return NextResponse.json(
        { error: "token and action (accept|decline) are required" },
        { status: 400 }
      );
    }

    const [request] = await db
      .select({
        id: coachAccessRequests.id,
        requesterId: coachAccessRequests.requesterId,
        status: coachAccessRequests.status,
        source: coachAccessRequests.source,
        role: profiles.role,
        email: profiles.email,
        fullName: profiles.fullName,
      })
      .from(coachAccessRequests)
      .innerJoin(profiles, eq(coachAccessRequests.requesterId, profiles.id))
      .where(eq(coachAccessRequests.inviteToken, token))
      .limit(1);

    if (!request) {
      return NextResponse.json({ error: "Invitation not found" }, { status: 404 });
    }
    if (request.requesterId !== auth.userId) {
      return NextResponse.json(
        { error: "Sign in with the invited account to respond" },
        { status: 403 }
      );
    }
    if (request.source !== "admin" || request.status !== "pending") {
      return NextResponse.json(
        { error: "This invitation is no longer open" },
        { status: 400 }
      );
    }

    if (action === "decline") {
      await db
        .update(coachAccessRequests)
        .set({
          status: "rejected",
          inviteToken: null,
          reviewedAt: new Date(),
          reviewedBy: auth.userId,
          updatedAt: new Date(),
        })
        .where(eq(coachAccessRequests.id, request.id));
      return NextResponse.json({ ok: true, status: "rejected" });
    }

    if (request.role !== "superadmin" && request.role !== "coach") {
      await db
        .update(profiles)
        .set({ role: "coach", updatedAt: new Date() })
        .where(eq(profiles.id, request.requesterId));
    }

    await db
      .update(coachAccessRequests)
      .set({
        status: "approved",
        inviteToken: null,
        reviewedAt: new Date(),
        reviewedBy: auth.userId,
        updatedAt: new Date(),
      })
      .where(eq(coachAccessRequests.id, request.id));

    await notifySuperadminAssignedRoleAccepted({
      userId: request.requesterId,
      email: request.email,
      name: request.fullName,
      assignedRole: "coach",
      source: "/api/account/coach-invites",
    });

    if (request.role !== "superadmin" && request.role !== "coach") {
      await notifyAccountRoleChange({
        to: request.email,
        name: request.fullName,
        previousRole: request.role,
        nextRole: "coach",
        relation: "coach",
      });
    }

    return NextResponse.json({ ok: true, status: "approved" });
  } catch (error) {
    console.error("coach invite response", error);
    return jsonError(error);
  }
}
