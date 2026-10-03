import { randomBytes } from "crypto";
import { NextResponse } from "next/server";
import { desc, eq } from "drizzle-orm";
import { db } from "@/db";
import { coachAccessRequests, profiles } from "@/db/schema";
import { jsonError, requireSuperadmin } from "@/lib/auth";
import { logAdminChange } from "@/lib/adminChangeLog";
import { notifyCoachInvite } from "@/lib/coachInviteNotify";
import { notifyAccountRoleChange } from "@/lib/roleChangeNotify";

export async function GET() {
  try {
    await requireSuperadmin();
    const [requests, coaches] = await Promise.all([
      db
        .select({
          id: coachAccessRequests.id,
          requesterId: coachAccessRequests.requesterId,
          status: coachAccessRequests.status,
          requestedAt: coachAccessRequests.requestedAt,
          reviewedAt: coachAccessRequests.reviewedAt,
          requesterName: profiles.fullName,
          requesterEmail: profiles.email,
          requesterRole: profiles.role,
          source: coachAccessRequests.source,
        })
        .from(coachAccessRequests)
        .innerJoin(profiles, eq(coachAccessRequests.requesterId, profiles.id))
        .orderBy(desc(coachAccessRequests.requestedAt)),
      db
        .select({
          id: profiles.id,
          email: profiles.email,
          fullName: profiles.fullName,
          role: profiles.role,
          createdAt: profiles.createdAt,
        })
        .from(profiles)
        .where(eq(profiles.role, "coach"))
        .orderBy(desc(profiles.updatedAt)),
    ]);

    return NextResponse.json({ requests, coaches });
  } catch (error) {
    return jsonError(error);
  }
}

export async function POST(req: Request) {
  try {
    const auth = await requireSuperadmin();
    const body = await req.json();
    const userId = String(body.userId || "").trim();
    const action = String(body.action || "").trim(); // "assign" | "revoke"

    if (!userId || !["assign", "revoke"].includes(action)) {
      return NextResponse.json(
        { error: "userId and action (assign|revoke) are required" },
        { status: 400 }
      );
    }

    const [user] = await db
      .select({
        id: profiles.id,
        fullName: profiles.fullName,
        email: profiles.email,
        role: profiles.role,
      })
      .from(profiles)
      .where(eq(profiles.id, userId))
      .limit(1);

    if (!user) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    if (user.role === "superadmin") {
      return NextResponse.json(
        { error: "Cannot modify role of a superadmin" },
        { status: 400 }
      );
    }

    if (action === "assign") {
      if (user.role === "coach") {
        return NextResponse.json({ ok: true, alreadyCoach: true, user });
      }

      const inviteToken = randomBytes(32).toString("base64url");
      await db.transaction(async (tx) => {
        const [existingReq] = await tx
          .select({ id: coachAccessRequests.id })
          .from(coachAccessRequests)
          .where(eq(coachAccessRequests.requesterId, userId))
          .limit(1);

        if (existingReq) {
          await tx
            .update(coachAccessRequests)
            .set({
              status: "pending",
              source: "admin",
              inviteToken,
              requestedAt: new Date(),
              reviewedAt: null,
              reviewedBy: null,
              updatedAt: new Date(),
            })
            .where(eq(coachAccessRequests.id, existingReq.id));
        } else {
          await tx.insert(coachAccessRequests).values({
            requesterId: userId,
            status: "pending",
            source: "admin",
            inviteToken,
          });
        }
      });

      await notifyCoachInvite({
        to: user.email,
        name: user.fullName,
        token: inviteToken,
      });

      await logAdminChange({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: "coach_role_invited",
        entityType: "profile",
        entityId: user.id,
        entityLabel: user.fullName,
        summary: `Invited ${user.fullName} (${user.email}) to accept coach access`,
        details: {
          targetUserId: user.id,
          targetEmail: user.email,
          previousRole: user.role,
          awaitingAccept: true,
        },
        source: "/api/admin/coach-access",
      });

      return NextResponse.json({
        ok: true,
        invited: true,
        user,
      });
    }

    await db.transaction(async (tx) => {
      await tx
        .update(profiles)
        .set({ role: "sailor", updatedAt: new Date() })
        .where(eq(profiles.id, userId));

      const [existingReq] = await tx
        .select({ id: coachAccessRequests.id })
        .from(coachAccessRequests)
        .where(eq(coachAccessRequests.requesterId, userId))
        .limit(1);

      if (existingReq) {
        await tx
          .update(coachAccessRequests)
          .set({
            status: "rejected",
            inviteToken: null,
            reviewedAt: new Date(),
            reviewedBy: auth.userId,
            updatedAt: new Date(),
          })
          .where(eq(coachAccessRequests.id, existingReq.id));
      }
    });

    await logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "coach_role_revoked",
      entityType: "profile",
      entityId: user.id,
      entityLabel: user.fullName,
      summary: `Revoked coach role for ${user.fullName} (${user.email})`,
      details: {
        targetUserId: user.id,
        targetEmail: user.email,
        previousRole: user.role,
        newRole: "sailor",
      },
      source: "/api/admin/coach-access",
    });

    if (user.role !== "sailor") {
      await notifyAccountRoleChange({
        to: user.email,
        name: user.fullName,
        previousRole: user.role,
        nextRole: "sailor",
      });
    }

    return NextResponse.json({
      ok: true,
      user: { ...user, role: "sailor" },
    });
  } catch (error) {
    console.error("admin direct coach assign", error);
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
          source: coachAccessRequests.source,
        })
        .from(coachAccessRequests)
        .innerJoin(profiles, eq(coachAccessRequests.requesterId, profiles.id))
        .where(eq(coachAccessRequests.id, id))
        .limit(1);
      if (!request) return null;

      if (action === "approve" && request.source === "admin") {
        return { ...request, blocked: true as const };
      }

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
          inviteToken: null,
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

    if ("blocked" in result && result.blocked) {
      return NextResponse.json(
        { error: "Waiting for this user to accept or decline the email" },
        { status: 400 }
      );
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

    if (
      action === "approve" &&
      result.requesterRole !== "superadmin" &&
      result.requesterRole !== "coach"
    ) {
      await notifyAccountRoleChange({
        to: result.requesterEmail,
        name: result.requesterName,
        previousRole: result.requesterRole,
        nextRole: "coach",
        relation: "coach",
      });
    }

    return NextResponse.json({ ok: true, status: result.status });
  } catch (error) {
    console.error("admin coach access", error);
    return jsonError(error);
  }
}
