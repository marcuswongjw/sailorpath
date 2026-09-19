import { NextResponse } from "next/server";
import { and, desc, eq, ne } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { profiles, sailorClaims, sailors } from "@/db/schema";
import { trackUsage } from "@/lib/usage";
import {
  parseClaimRelation,
  profileRoleFromRelation,
  relationFromNote,
  type ClaimRelation,
} from "@/lib/claimRelation";
import { logAdminChange } from "@/lib/adminChangeLog";

export async function GET() {
  try {
    await requireSuperadmin();
    const rows = await db
      .select({
        id: sailorClaims.id,
        sailorId: sailorClaims.sailorId,
        requesterId: sailorClaims.requesterId,
        status: sailorClaims.status,
        relation: sailorClaims.relation,
        note: sailorClaims.note,
        createdAt: sailorClaims.createdAt,
        updatedAt: sailorClaims.updatedAt,
        sailorName: sailors.name,
        sailorHandle: sailors.handle,
        sailorSailNumber: sailors.sailNumber,
        sailorClub: sailors.club,
        sailorParentId: sailors.parentId,
        sailorOwnerRelation: sailors.ownerRelation,
        requesterEmail: profiles.email,
        requesterName: profiles.fullName,
        requesterRole: profiles.role,
      })
      .from(sailorClaims)
      .innerJoin(sailors, eq(sailorClaims.sailorId, sailors.id))
      .innerJoin(profiles, eq(sailorClaims.requesterId, profiles.id))
      .orderBy(desc(sailorClaims.createdAt));

    const claims = rows.map((r) => ({
      ...r,
      /** Effective relation for UI (column → note prefix → null) */
      effectiveRelation:
        parseClaimRelation(r.relation) ||
        relationFromNote(r.note) ||
        parseClaimRelation(r.sailorOwnerRelation) ||
        null,
    }));

    return NextResponse.json({ claims });
  } catch (e) {
    return jsonError(e);
  }
}

/**
 * PATCH body:
 *  - id (required)
 *  - status?: pending | approved | rejected
 *  - relation?: parent | sailor | other  (required when approving if unknown)
 *  - setAccountRole?: boolean (default true) — update profiles.role for parent/sailor
 *  - unclaim?: boolean — clear parent_id on sailor (approved claims)
 */
export async function PATCH(req: Request) {
  try {
    const auth = await requireSuperadmin();
    const body = await req.json();
    const id = String(body.id || "").trim();
    if (!id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }

    const [claim] = await db
      .select()
      .from(sailorClaims)
      .where(eq(sailorClaims.id, id))
      .limit(1);
    if (!claim) {
      return NextResponse.json({ error: "Claim not found" }, { status: 404 });
    }

    const statusRaw =
      body.status != null ? String(body.status).trim() : undefined;
    if (
      statusRaw &&
      !["approved", "rejected", "pending"].includes(statusRaw)
    ) {
      return NextResponse.json(
        { error: "status must be approved|rejected|pending" },
        { status: 400 }
      );
    }

    let relation: ClaimRelation | null =
      parseClaimRelation(body.relation) ||
      parseClaimRelation(claim.relation) ||
      relationFromNote(claim.note);

    if (statusRaw === "approved" && !relation) {
      return NextResponse.json(
        {
          error:
            "relation required to approve (parent | sailor | other). Set role in the Claims panel.",
        },
        { status: 400 }
      );
    }

    // Relation-only update (e.g. change parent ↔ sailor on approved claim)
    if (!statusRaw && body.relation != null) {
      relation = parseClaimRelation(body.relation);
      if (!relation) {
        return NextResponse.json(
          { error: "relation must be parent|sailor|other" },
          { status: 400 }
        );
      }
    }

    const nextStatus = (statusRaw || claim.status) as
      | "pending"
      | "approved"
      | "rejected";

    const [updated] = await db
      .update(sailorClaims)
      .set({
        status: nextStatus,
        ...(relation ? { relation } : {}),
        updatedAt: new Date(),
      })
      .where(eq(sailorClaims.id, id))
      .returning();

    const setAccountRole = body.setAccountRole !== false;

    if (nextStatus === "approved" && relation) {
      const [target] = await db
        .select({ parentId: sailors.parentId })
        .from(sailors)
        .where(eq(sailors.id, claim.sailorId))
        .limit(1);

      // If sailor has no primary parentId yet or is already this requester, set/update it
      if (!target?.parentId || target.parentId === claim.requesterId) {
        await db
          .update(sailors)
          .set({
            parentId: claim.requesterId,
            ownerRelation: relation,
            updatedAt: new Date(),
          })
          .where(eq(sailors.id, claim.sailorId));
      }
      // If sailor is already linked to another primary account, we allow it!
      // The claim is marked approved, granting this user full management access as well.

      if (setAccountRole) {
        const role = profileRoleFromRelation(relation);
        if (role) {
          const [prof] = await db
            .select({ role: profiles.role })
            .from(profiles)
            .where(eq(profiles.id, claim.requesterId))
            .limit(1);
          // Never demote superadmin
          if (prof && prof.role !== "superadmin") {
            await db
              .update(profiles)
              .set({ role, updatedAt: new Date() })
              .where(eq(profiles.id, claim.requesterId));
          }
        }
      }
    }

    // Change relation on already-linked sailor (without re-approve)
    if (
      !statusRaw &&
      relation &&
      claim.status === "approved" &&
      body.relation != null
    ) {
      const [target] = await db
        .select({ parentId: sailors.parentId })
        .from(sailors)
        .where(eq(sailors.id, claim.sailorId))
        .limit(1);

      if (target?.parentId === claim.requesterId) {
        await db
          .update(sailors)
          .set({ ownerRelation: relation, updatedAt: new Date() })
          .where(eq(sailors.id, claim.sailorId));
      }

      if (setAccountRole) {
        const role = profileRoleFromRelation(relation);
        if (role) {
          const [prof] = await db
            .select({ role: profiles.role })
            .from(profiles)
            .where(eq(profiles.id, claim.requesterId))
            .limit(1);
          if (prof && prof.role !== "superadmin") {
            await db
              .update(profiles)
              .set({ role, updatedAt: new Date() })
              .where(eq(profiles.id, claim.requesterId));
          }
        }
      }
    }

    if (body.unclaim === true) {
      const [target] = await db
        .select({ parentId: sailors.parentId })
        .from(sailors)
        .where(eq(sailors.id, claim.sailorId))
        .limit(1);

      await db
        .update(sailorClaims)
        .set({ status: "rejected", updatedAt: new Date() })
        .where(eq(sailorClaims.id, id));

      // If the unclaiming claimant was the primary parentId, promote another approved claimant if one exists
      if (target?.parentId === claim.requesterId) {
        const [otherClaim] = await db
          .select({
            requesterId: sailorClaims.requesterId,
            relation: sailorClaims.relation,
          })
          .from(sailorClaims)
          .where(
            and(
              eq(sailorClaims.sailorId, claim.sailorId),
              eq(sailorClaims.status, "approved"),
              ne(sailorClaims.id, id)
            )
          )
          .limit(1);

        await db
          .update(sailors)
          .set({
            parentId: otherClaim ? otherClaim.requesterId : null,
            ownerRelation: otherClaim ? otherClaim.relation : null,
            updatedAt: new Date(),
          })
          .where(eq(sailors.id, claim.sailorId));
      }
    } else if (statusRaw === "rejected") {
      const [target] = await db
        .select({ parentId: sailors.parentId })
        .from(sailors)
        .where(eq(sailors.id, claim.sailorId))
        .limit(1);

      if (target?.parentId === claim.requesterId) {
        const [otherClaim] = await db
          .select({
            requesterId: sailorClaims.requesterId,
            relation: sailorClaims.relation,
          })
          .from(sailorClaims)
          .where(
            and(
              eq(sailorClaims.sailorId, claim.sailorId),
              eq(sailorClaims.status, "approved"),
              ne(sailorClaims.id, id)
            )
          )
          .limit(1);

        await db
          .update(sailors)
          .set({
            parentId: otherClaim ? otherClaim.requesterId : null,
            ownerRelation: otherClaim ? otherClaim.relation : null,
            updatedAt: new Date(),
          })
          .where(eq(sailors.id, claim.sailorId));
      }
    }

    if (statusRaw === "approved" || statusRaw === "rejected") {
      void trackUsage({
        eventType:
          statusRaw === "approved" ? "claim_approved" : "claim_rejected",
        path: "/admin",
        role: "superadmin",
        meta: {
          claimId: id.slice(0, 36),
          relation: relation || null,
        },
      });
    }

    if (statusRaw === "approved" || statusRaw === "rejected" || body.unclaim === true) {
      let sailorLabel: string | null = null;
      try {
        const [s] = await db
          .select({ name: sailors.name })
          .from(sailors)
          .where(eq(sailors.id, claim.sailorId))
          .limit(1);
        sailorLabel = s?.name || null;
      } catch {
        /* optional */
      }
      const action = body.unclaim === true
        ? "claim.unlink"
        : statusRaw === "approved"
          ? "claim.approve"
          : "claim.reject";
      const summary =
        body.unclaim === true
          ? `Unlinked claim on ${sailorLabel || claim.sailorId}`
          : statusRaw === "approved"
            ? `Approved claim on ${sailorLabel || claim.sailorId}`
            : `Rejected claim on ${sailorLabel || claim.sailorId}`;
      void logAdminChange({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action,
        entityType: "claim",
        entityId: id,
        entityLabel: sailorLabel,
        summary,
        details: {
          sailorId: claim.sailorId,
          requesterId: claim.requesterId,
          status: body.unclaim === true ? "rejected" : statusRaw,
          relation: relation || null,
          unclaim: body.unclaim === true,
        },
        source: "/api/admin/claims",
      });
    }

    return NextResponse.json({
      ok: true,
      claim: updated,
      relation,
    });
  } catch (e) {
    console.error("claims admin PATCH", e);
    return jsonError(e);
  }
}

/**
 * POST /api/admin/claims
 * Body: { userId: string, sailorId: string, relation?: "parent" | "sailor" | "other", note?: string }
 * Superadmin assigns a registered user account to a sailor profile directly.
 */
export async function POST(req: Request) {
  try {
    const auth = await requireSuperadmin();
    const body = await req.json();
    const userId = String(body.userId || "").trim();
    const sailorId = String(body.sailorId || "").trim();
    const relation: ClaimRelation = parseClaimRelation(body.relation) || "parent";
    const note = String(body.note || "Assigned directly by admin").trim();

    if (!userId || !sailorId) {
      return NextResponse.json(
        { error: "Both userId and sailorId are required" },
        { status: 400 }
      );
    }

    const [user] = await db
      .select()
      .from(profiles)
      .where(eq(profiles.id, userId))
      .limit(1);
    if (!user) {
      return NextResponse.json({ error: "User account not found" }, { status: 404 });
    }

    const [sailor] = await db
      .select()
      .from(sailors)
      .where(eq(sailors.id, sailorId))
      .limit(1);
    if (!sailor) {
      return NextResponse.json({ error: "Sailor profile not found" }, { status: 404 });
    }

    // Check if an existing claim exists for this user + sailor
    const [existingClaim] = await db
      .select()
      .from(sailorClaims)
      .where(
        and(eq(sailorClaims.sailorId, sailorId), eq(sailorClaims.requesterId, userId))
      )
      .limit(1);

    let claimRecord;
    if (existingClaim) {
      const [updated] = await db
        .update(sailorClaims)
        .set({
          status: "approved",
          relation,
          note,
          updatedAt: new Date(),
        })
        .where(eq(sailorClaims.id, existingClaim.id))
        .returning();
      claimRecord = updated;
    } else {
      const [created] = await db
        .insert(sailorClaims)
        .values({
          sailorId,
          requesterId: userId,
          status: "approved",
          relation,
          note,
        })
        .returning();
      claimRecord = created;
    }

    // Set primary parentId on sailor if empty or already this user
    if (!sailor.parentId || sailor.parentId === userId) {
      await db
        .update(sailors)
        .set({
          parentId: userId,
          ownerRelation: relation,
          updatedAt: new Date(),
        })
        .where(eq(sailors.id, sailorId));
    }

    // Promote profile role if currently 'sailor' and assigned as 'parent'
    if (user.role !== "superadmin" && user.role !== "coach") {
      const targetRole = profileRoleFromRelation(relation);
      if (targetRole && user.role !== targetRole) {
        await db
          .update(profiles)
          .set({ role: targetRole, updatedAt: new Date() })
          .where(eq(profiles.id, userId));
      }
    }

    await logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "claim_approved",
      entityType: "claim",
      entityId: claimRecord.id,
      entityLabel: `${sailor.name} ← ${user.email}`,
      summary: `Admin assigned ${user.email} as ${relation} to sailor ${sailor.name}`,
      details: {
        assignedByAdmin: true,
        sailorId,
        sailorName: sailor.name,
        userId,
        userEmail: user.email,
        relation,
      },
      source: "/api/admin/claims",
    });

    void trackUsage({
      eventType: "claim_approved",
      path: "/admin",
      role: "superadmin",
      meta: {
        assignedByAdmin: "true",
        targetUserId: userId.slice(0, 36),
        sailorId: sailorId.slice(0, 36),
        relation,
      },
    });

    return NextResponse.json({ ok: true, claim: claimRecord });
  } catch (e) {
    console.error("claims admin POST assign", e);
    return jsonError(e);
  }
}
