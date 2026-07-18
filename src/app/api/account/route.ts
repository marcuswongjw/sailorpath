import { NextResponse } from "next/server";
import { desc, eq } from "drizzle-orm";
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

    const [owned, claims] = await Promise.all([
      db
        .select({
          id: sailors.id,
          name: sailors.name,
          handle: sailors.handle,
          sailNumber: sailors.sailNumber,
          club: sailors.club,
        })
        .from(sailors)
        .where(eq(sailors.parentId, auth.userId)),
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

    return NextResponse.json({
      email: auth.email,
      role: auth.role,
      owned,
      claims,
    });
  } catch (e) {
    return jsonError(e);
  }
}
