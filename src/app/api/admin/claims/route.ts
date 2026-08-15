import { NextResponse } from "next/server";
import { desc, eq } from "drizzle-orm";
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
    await requireSuperadmin();
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
      await db
        .update(sailors)
        .set({
          parentId: claim.requesterId,
          ownerRelation: relation,
          updatedAt: new Date(),
        })
        .where(eq(sailors.id, claim.sailorId));

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
      await db
        .update(sailors)
        .set({ ownerRelation: relation, updatedAt: new Date() })
        .where(eq(sailors.id, claim.sailorId));

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
      await db
        .update(sailors)
        .set({
          parentId: null,
          ownerRelation: null,
          updatedAt: new Date(),
        })
        .where(eq(sailors.id, claim.sailorId));
      await db
        .update(sailorClaims)
        .set({ status: "rejected", updatedAt: new Date() })
        .where(eq(sailorClaims.id, id));
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
