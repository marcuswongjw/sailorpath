import { NextResponse } from "next/server";
import { and, eq } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { sailorClaims, sailors } from "@/db/schema";
import { applyClaimAccountRole } from "@/lib/claimAccountRole";
import { parseClaimRelation } from "@/lib/claimRelation";
import { notifyAccountRoleChange } from "@/lib/roleChangeNotify";

/**
 * The signed-in user accepts or declines an admin sailor assignment.
 * Body: { id: string, action: "accept" | "decline" }
 */
export async function POST(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }

    const body = await req.json().catch(() => ({}));
    const id = String(body.id || "").trim();
    const action = String(body.action || "").trim();
    if (!id || !["accept", "decline"].includes(action)) {
      return NextResponse.json(
        { error: "id and action (accept|decline) are required" },
        { status: 400 }
      );
    }

    const [claim] = await db
      .select()
      .from(sailorClaims)
      .where(
        and(eq(sailorClaims.id, id), eq(sailorClaims.requesterId, auth.userId))
      )
      .limit(1);
    if (!claim) {
      return NextResponse.json({ error: "Request not found" }, { status: 404 });
    }
    if (claim.source !== "admin" || claim.status !== "pending") {
      return NextResponse.json(
        { error: "This request cannot be accepted" },
        { status: 400 }
      );
    }

    if (action === "decline") {
      await db
        .update(sailorClaims)
        .set({ status: "rejected", updatedAt: new Date() })
        .where(eq(sailorClaims.id, id));
      return NextResponse.json({ ok: true, status: "rejected" });
    }

    const relation = parseClaimRelation(claim.relation) || "parent";
    await db
      .update(sailorClaims)
      .set({ status: "approved", relation, updatedAt: new Date() })
      .where(eq(sailorClaims.id, id));

    const [sailor] = await db
      .select({
        parentId: sailors.parentId,
        name: sailors.name,
      })
      .from(sailors)
      .where(eq(sailors.id, claim.sailorId))
      .limit(1);

    if (sailor && (!sailor.parentId || sailor.parentId === auth.userId)) {
      await db
        .update(sailors)
        .set({
          parentId: auth.userId,
          ownerRelation: relation,
          updatedAt: new Date(),
        })
        .where(eq(sailors.id, claim.sailorId));
    }

    const roleNotice = await applyClaimAccountRole(auth.userId, relation);
    if (roleNotice) {
      await notifyAccountRoleChange({
        ...roleNotice,
        sailorName: sailor?.name || null,
      });
    }

    return NextResponse.json({ ok: true, status: "approved" });
  } catch (e) {
    console.error("sailor invite response", e);
    return jsonError(e);
  }
}
