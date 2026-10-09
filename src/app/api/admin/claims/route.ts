import { NextResponse } from "next/server";
import { and, asc, desc, eq, ne } from "drizzle-orm";
import { pgTable, text, timestamp, uuid } from "drizzle-orm/pg-core";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { profiles, sailorClaims, sailors } from "@/db/schema";
import { trackUsage } from "@/lib/usage";
import {
  parseClaimRelation,
  relationFromNote,
  type ClaimRelation,
} from "@/lib/claimRelation";
import { logAdminChange } from "@/lib/adminChangeLog";
import { applyClaimAccountRole } from "@/lib/claimAccountRole";
import { notifyAccountRoleChange } from "@/lib/roleChangeNotify";
import { notifySailorAssignmentInvite } from "@/lib/sailorInviteNotify";

/**
 * Same table as `sailorClaims`, without `heard_about`.
 * Drizzle inserts every column on the table object (`DEFAULT` when omitted).
 * Production was missing `heard_about` (migration 086), so an insert through
 * the full schema failed with `column "heard_about" does not exist`.
 */
const sailorClaimsAssignable = pgTable("sailor_claims", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  sailorId: uuid("sailor_id").notNull(),
  requesterId: uuid("requester_id").notNull(),
  status: text("status", {
    enum: ["pending", "approved", "rejected"],
  })
    .default("pending")
    .notNull(),
  relation: text("relation", {
    enum: ["parent", "sailor", "other"],
  }),
  source: text("source", { enum: ["user", "admin"] })
    .default("user")
    .notNull(),
  note: text("note"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

const sailorClaimColumns = {
  id: sailorClaimsAssignable.id,
  sailorId: sailorClaimsAssignable.sailorId,
  requesterId: sailorClaimsAssignable.requesterId,
  status: sailorClaimsAssignable.status,
  relation: sailorClaimsAssignable.relation,
  source: sailorClaimsAssignable.source,
  note: sailorClaimsAssignable.note,
  createdAt: sailorClaimsAssignable.createdAt,
  updatedAt: sailorClaimsAssignable.updatedAt,
};

export async function GET() {
  try {
    await requireSuperadmin();
    let rows;
    try {
      rows = await db
        .select({
          id: sailorClaims.id,
          sailorId: sailorClaims.sailorId,
          requesterId: sailorClaims.requesterId,
          status: sailorClaims.status,
          relation: sailorClaims.relation,
          heardAbout: sailorClaims.heardAbout,
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
          source: sailorClaims.source,
        })
        .from(sailorClaims)
        .innerJoin(sailors, eq(sailorClaims.sailorId, sailors.id))
        .innerJoin(profiles, eq(sailorClaims.requesterId, profiles.id))
        .orderBy(desc(sailorClaims.createdAt));
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      if (/heard_about|does not exist/i.test(msg)) {
        const fallbackRows = await db
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
            source: sailorClaims.source,
          })
          .from(sailorClaims)
          .innerJoin(sailors, eq(sailorClaims.sailorId, sailors.id))
          .innerJoin(profiles, eq(sailorClaims.requesterId, profiles.id))
          .orderBy(desc(sailorClaims.createdAt));
        rows = fallbackRows.map((r) => ({
          ...r,
          heardAbout: null as string | null,
        }));
      } else {
        throw err;
      }
    }

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
 *  - unclaim?: boolean — reject the claim; if primary, promote the earliest-created
 *    remaining approved claim (ID breaks ties), or clear ownership if none remain.
 */
export async function PATCH(req: Request) {
  try {
    const auth = await requireSuperadmin();
    const body = await req.json();
    const id = String(body.id || "").trim();
    if (!id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }

    // Resolve the sailor before locking. Re-read the claim under the lock below.
    const [claimRef] = await db
      .select(sailorClaimColumns)
      .from(sailorClaimsAssignable)
      .where(eq(sailorClaimsAssignable.id, id))
      .limit(1);
    if (!claimRef) {
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

    const result = await db.transaction(async (tx) => {
      // Lock the sailor first, consistently with mergeSailors. This serializes
      // admin ownership transitions even when they touch different claims.
      const [target] = await tx
        .select({ parentId: sailors.parentId, name: sailors.name })
        .from(sailors)
        .where(eq(sailors.id, claimRef.sailorId))
        .for("update");
      if (!target) return { error: "Sailor not found", status: 404 } as const;

      const [claim] = await tx
        .select(sailorClaimColumns)
        .from(sailorClaimsAssignable)
        .where(eq(sailorClaimsAssignable.id, id))
        .for("update");
      if (!claim) return { error: "Claim not found", status: 404 } as const;
      if (claim.sailorId !== claimRef.sailorId) {
        return {
          error: "Claim moved to another sailor. Reload and retry.",
          status: 409,
        } as const;
      }

      // Unlink wins over an accompanying approval; never briefly approve a
      // claim, change the account role, or send an approval email on unlink.
      const nextStatus = (
        body.unclaim === true ? "rejected" : statusRaw || claim.status
      ) as "pending" | "approved" | "rejected";
      let relation: ClaimRelation | null =
        parseClaimRelation(body.relation) ||
        parseClaimRelation(claim.relation) ||
        relationFromNote(claim.note);

      if (nextStatus === "approved" && !relation) {
        return {
          error: "relation required to approve (parent | sailor | other). Set role in the Claims panel.",
          status: 400,
        } as const;
      }
      if (!statusRaw && body.relation != null) {
        relation = parseClaimRelation(body.relation);
        if (!relation) {
          return {
            error: "relation must be parent|sailor|other",
            status: 400,
          } as const;
        }
      }

      const now = new Date();
      const [updated] = await tx
        .update(sailorClaimsAssignable)
        .set({
          status: nextStatus,
          ...(relation ? { relation } : {}),
          updatedAt: now,
        })
        .where(eq(sailorClaimsAssignable.id, id))
        .returning(sailorClaimColumns);

      let roleNotice: Awaited<ReturnType<typeof applyClaimAccountRole>> = null;
      if (nextStatus === "approved" && relation) {
        // Other approved claimants keep management access; do not replace an
        // existing primary owner when approving or editing a secondary claim.
        if (!target.parentId || target.parentId === claim.requesterId) {
          await tx
            .update(sailors)
            .set({
              parentId: claim.requesterId,
              ownerRelation: relation,
              updatedAt: now,
            })
            .where(eq(sailors.id, claim.sailorId));
        }
        if (body.setAccountRole !== false) {
          roleNotice = await applyClaimAccountRole(claim.requesterId, relation, tx);
        }
      } else if (target.parentId === claim.requesterId) {
        const [otherClaim] = await tx
          .select(sailorClaimColumns)
          .from(sailorClaimsAssignable)
          .where(
            and(
              eq(sailorClaimsAssignable.sailorId, claim.sailorId),
              eq(sailorClaimsAssignable.status, "approved"),
              ne(sailorClaimsAssignable.id, id)
            )
          )
          // Policy: earliest-created remaining approved claim, then stable ID.
          // updatedAt is not approval time and changes on relation edits.
          .orderBy(
            asc(sailorClaimsAssignable.createdAt),
            asc(sailorClaimsAssignable.id)
          )
          .limit(1)
          .for("update");
        await tx
          .update(sailors)
          .set({
            parentId: otherClaim?.requesterId ?? null,
            ownerRelation: otherClaim
              ? parseClaimRelation(otherClaim.relation) ||
                relationFromNote(otherClaim.note)
              : null,
            updatedAt: now,
          })
          .where(eq(sailors.id, claim.sailorId));
      }

      return { claim: updated, relation, roleNotice, sailorName: target.name };
    });
    if ("error" in result) {
      return NextResponse.json({ error: result.error }, { status: result.status });
    }
    const { claim: updated, relation, roleNotice, sailorName } = result;

    // External effects run only after the transaction has committed.
    if (statusRaw === "approved" || statusRaw === "rejected" || body.unclaim === true) {
      void trackUsage({
        eventType:
          updated.status === "approved" ? "claim_approved" : "claim_rejected",
        path: "/admin",
        role: "superadmin",
        meta: {
          claimId: id.slice(0, 36),
          relation: relation || null,
        },
      });
    }

    if (roleNotice) {
      await notifyAccountRoleChange({
        ...roleNotice,
        sailorName,
      });
    }

    if (statusRaw === "approved" || statusRaw === "rejected" || body.unclaim === true) {
      const action = body.unclaim === true
        ? "claim.unlink"
        : statusRaw === "approved"
          ? "claim.approve"
          : "claim.reject";
      const summary =
        body.unclaim === true
          ? `Unlinked claim on ${sailorName || updated.sailorId}`
          : statusRaw === "approved"
            ? `Approved claim on ${sailorName || updated.sailorId}`
            : `Rejected claim on ${sailorName || updated.sailorId}`;
      void logAdminChange({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action,
        entityType: "claim",
        entityId: id,
        entityLabel: sailorName,
        summary,
        details: {
          sailorId: updated.sailorId,
          requesterId: updated.requesterId,
          status: updated.status,
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
 * Superadmin invites a registered user to a sailor profile.
 * The link stays pending until that user accepts it.
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
      .select({
        email: profiles.email,
        fullName: profiles.fullName,
      })
      .from(profiles)
      .where(eq(profiles.id, userId))
      .limit(1);
    if (!user) {
      return NextResponse.json({ error: "User account not found" }, { status: 404 });
    }

    const [sailor] = await db
      .select({
        name: sailors.name,
      })
      .from(sailors)
      .where(eq(sailors.id, sailorId))
      .limit(1);
    if (!sailor) {
      return NextResponse.json({ error: "Sailor profile not found" }, { status: 404 });
    }

    const [existingClaim] = await db
      .select(sailorClaimColumns)
      .from(sailorClaimsAssignable)
      .where(
        and(
          eq(sailorClaimsAssignable.sailorId, sailorId),
          eq(sailorClaimsAssignable.requesterId, userId)
        )
      )
      .limit(1);

    if (existingClaim?.status === "approved") {
      return NextResponse.json({
        ok: true,
        alreadyLinked: true,
        claim: existingClaim,
      });
    }

    let claimRecord;
    if (existingClaim) {
      const [updated] = await db
        .update(sailorClaimsAssignable)
        .set({
          status: "pending",
          relation,
          note,
          source: "admin",
          updatedAt: new Date(),
        })
        .where(eq(sailorClaimsAssignable.id, existingClaim.id))
        .returning(sailorClaimColumns);
      claimRecord = updated;
    } else {
      const [created] = await db
        .insert(sailorClaimsAssignable)
        .values({
          sailorId,
          requesterId: userId,
          status: "pending",
          relation,
          note,
          source: "admin",
        })
        .returning(sailorClaimColumns);
      claimRecord = created;
    }

    if (!claimRecord) {
      return NextResponse.json(
        { error: "Could not save the invitation" },
        { status: 500 }
      );
    }

    await notifySailorAssignmentInvite({
      to: user.email,
      name: user.fullName,
      sailorName: sailor.name,
      relation,
      claimId: claimRecord.id,
    });

    await logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "claim.invite",
      entityType: "claim",
      entityId: claimRecord.id,
      entityLabel: `${sailor.name} ← ${user.email}`,
      summary: `Invited ${user.email} as ${relation} for ${sailor.name}. Waiting for them to accept.`,
      details: {
        assignedByAdmin: true,
        awaitingAccept: true,
        sailorId,
        sailorName: sailor.name,
        userId,
        userEmail: user.email,
        relation,
      },
      source: "/api/admin/claims",
    });

    void trackUsage({
      eventType: "claim_submit",
      path: "/admin",
      role: "superadmin",
      meta: {
        status: "pending",
        relation,
        source: "admin",
      },
    });

    return NextResponse.json({ ok: true, invited: true, claim: claimRecord });
  } catch (e) {
    console.error("claims admin POST assign", e);
    return jsonError(e);
  }
}
