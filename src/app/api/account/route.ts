import { NextResponse } from "next/server";
import { and, desc, eq, inArray, or } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { sailorClaims, sailors } from "@/db/schema";

/** Logged-in account: owned sailors + claim requests */
export async function GET() {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }

    const [approvedClaims, claims] = await Promise.all([
      db
        .select({
          sailorId: sailorClaims.sailorId,
          relation: sailorClaims.relation,
        })
        .from(sailorClaims)
        .where(
          and(
            eq(sailorClaims.requesterId, auth.userId),
            eq(sailorClaims.status, "approved")
          )
        ),
      db
        .select({
          id: sailorClaims.id,
          status: sailorClaims.status,
          note: sailorClaims.note,
          createdAt: sailorClaims.createdAt,
          sailorId: sailorClaims.sailorId,
          sailorName: sailors.name,
          sailorHandle: sailors.handle,
        })
        .from(sailorClaims)
        .innerJoin(sailors, eq(sailorClaims.sailorId, sailors.id))
        .where(eq(sailorClaims.requesterId, auth.userId))
        .orderBy(desc(sailorClaims.createdAt)),
    ]);

    const claimMap = new Map(
      approvedClaims.map((c) => [c.sailorId, c.relation])
    );
    const claimedIds = Array.from(claimMap.keys());

    const conditions = [eq(sailors.parentId, auth.userId)];
    if (claimedIds.length > 0) {
      conditions.push(inArray(sailors.id, claimedIds));
    }

    const ownedRows = await db
      .select({
        id: sailors.id,
        name: sailors.name,
        handle: sailors.handle,
        sailNumber: sailors.sailNumber,
        club: sailors.club,
        ownerRelation: sailors.ownerRelation,
      })
      .from(sailors)
      .where(or(...conditions));

    const owned = ownedRows.map((s) => ({
      ...s,
      ownerRelation: claimMap.get(s.id) || s.ownerRelation || "parent",
    }));

    const isSuperadmin = auth.role === "superadmin";
    return NextResponse.json({
      email: auth.email,
      role: auth.role,
      isSuperadmin,
      owned,
      claims,
    });
  } catch (e) {
    return jsonError(e);
  }
}
