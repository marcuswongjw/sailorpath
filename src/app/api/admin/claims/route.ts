import { NextResponse } from "next/server";
import { desc, eq } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { profiles, sailorClaims, sailors } from "@/db/schema";

export async function GET() {
  try {
    await requireSuperadmin();
    const rows = await db
      .select({
        id: sailorClaims.id,
        sailorId: sailorClaims.sailorId,
        requesterId: sailorClaims.requesterId,
        status: sailorClaims.status,
        note: sailorClaims.note,
        createdAt: sailorClaims.createdAt,
        sailorName: sailors.name,
        sailorHandle: sailors.handle,
        requesterEmail: profiles.email,
        requesterName: profiles.fullName,
      })
      .from(sailorClaims)
      .innerJoin(sailors, eq(sailorClaims.sailorId, sailors.id))
      .innerJoin(profiles, eq(sailorClaims.requesterId, profiles.id))
      .orderBy(desc(sailorClaims.createdAt));
    return NextResponse.json({ claims: rows });
  } catch (e) {
    return jsonError(e);
  }
}

export async function PATCH(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    const id = String(body.id || "").trim();
    const status = String(body.status || "").trim();
    if (!id || !["approved", "rejected", "pending"].includes(status)) {
      return NextResponse.json(
        { error: "id and status (approved|rejected|pending) required" },
        { status: 400 }
      );
    }

    const [claim] = await db
      .select()
      .from(sailorClaims)
      .where(eq(sailorClaims.id, id))
      .limit(1);
    if (!claim) {
      return NextResponse.json({ error: "Claim not found" }, { status: 404 });
    }

    const [updated] = await db
      .update(sailorClaims)
      .set({ status: status as "pending" | "approved" | "rejected", updatedAt: new Date() })
      .where(eq(sailorClaims.id, id))
      .returning();

    if (status === "approved") {
      await db
        .update(sailors)
        .set({ parentId: claim.requesterId, updatedAt: new Date() })
        .where(eq(sailors.id, claim.sailorId));
    }

    return NextResponse.json({ ok: true, claim: updated });
  } catch (e) {
    console.error("claims admin PATCH", e);
    return jsonError(e);
  }
}
