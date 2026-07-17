import { NextResponse } from "next/server";
import { and, eq } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { sailorClaims, sailors } from "@/db/schema";

/** Logged-in user requests to claim a sailor profile */
export async function POST(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in to claim a profile" }, { status: 401 });
    }
    const body = await req.json();
    const sailorId = String(body.sailorId || "").trim();
    if (!sailorId) {
      return NextResponse.json({ error: "sailorId required" }, { status: 400 });
    }

    const [sailor] = await db
      .select({ id: sailors.id, parentId: sailors.parentId, name: sailors.name })
      .from(sailors)
      .where(eq(sailors.id, sailorId))
      .limit(1);
    if (!sailor) {
      return NextResponse.json({ error: "Sailor not found" }, { status: 404 });
    }
    if (sailor.parentId) {
      return NextResponse.json(
        { error: "This profile is already claimed" },
        { status: 400 }
      );
    }

    const existing = await db
      .select()
      .from(sailorClaims)
      .where(
        and(
          eq(sailorClaims.sailorId, sailorId),
          eq(sailorClaims.requesterId, auth.userId),
          eq(sailorClaims.status, "pending")
        )
      )
      .limit(1);
    if (existing[0]) {
      return NextResponse.json({
        ok: true,
        claim: existing[0],
        message: "Claim already pending",
      });
    }

    const [claim] = await db
      .insert(sailorClaims)
      .values({
        sailorId,
        requesterId: auth.userId,
        status: "pending",
        note: body.note || null,
      })
      .returning();

    return NextResponse.json({
      ok: true,
      claim,
      message: `Claim submitted for ${sailor.name}. A superadmin will review.`,
    });
  } catch (e) {
    console.error("claims POST", e);
    return jsonError(e);
  }
}

export async function GET() {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }
    const rows = await db
      .select()
      .from(sailorClaims)
      .where(eq(sailorClaims.requesterId, auth.userId));
    return NextResponse.json({ claims: rows });
  } catch (e) {
    return jsonError(e);
  }
}
