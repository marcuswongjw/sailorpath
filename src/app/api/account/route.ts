import { NextResponse } from "next/server";
import { and, desc, eq, inArray, or } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { sailorClaims, sailors, profiles } from "@/db/schema";

/** Logged-in account: user profile + owned sailors + claim requests */
export async function GET() {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }

    const [approvedClaims, claims, profileRows] = await Promise.all([
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
      db
        .select({
          id: profiles.id,
          email: profiles.email,
          fullName: profiles.fullName,
          role: profiles.role,
          createdAt: profiles.createdAt,
        })
        .from(profiles)
        .where(eq(profiles.id, auth.userId))
        .limit(1),
    ]);

    const profileRow = profileRows[0];

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
    const userProfile = {
      id: auth.userId,
      email: profileRow?.email || auth.email || "",
      fullName: profileRow?.fullName || "",
      role: profileRow?.role || auth.role,
      createdAt: profileRow?.createdAt ? profileRow.createdAt.toISOString() : null,
    };

    return NextResponse.json({
      user: userProfile,
      profile: userProfile,
      email: profileRow?.email || auth.email,
      fullName: profileRow?.fullName || "",
      role: auth.role,
      isSuperadmin,
      owned,
      claims,
    });
  } catch (e) {
    return jsonError(e);
  }
}

export async function PATCH(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }

    const body = await req.json().catch(() => ({}));
    const { fullName, email } = body;

    const updates: { fullName?: string; email?: string; updatedAt: Date } = {
      updatedAt: new Date(),
    };

    if (typeof fullName === "string") {
      const trimmedName = fullName.trim();
      if (!trimmedName) {
        return NextResponse.json(
          { error: "Name cannot be empty" },
          { status: 400 }
        );
      }
      updates.fullName = trimmedName;
    }

    if (typeof email === "string") {
      const trimmedEmail = email.trim().toLowerCase();
      if (!trimmedEmail || !trimmedEmail.includes("@")) {
        return NextResponse.json(
          { error: "Please provide a valid email address" },
          { status: 400 }
        );
      }
      updates.email = trimmedEmail;
    }

    if (updates.fullName || updates.email) {
      const existing = await db
        .select({ id: profiles.id })
        .from(profiles)
        .where(eq(profiles.id, auth.userId))
        .limit(1);

      if (existing.length === 0) {
        await db.insert(profiles).values({
          id: auth.userId,
          email: updates.email || auth.email || "",
          fullName: updates.fullName || "User",
          role: auth.role,
        });
      } else {
        await db
          .update(profiles)
          .set(updates)
          .where(eq(profiles.id, auth.userId));
      }
    }

    const [updatedRow] = await db
      .select({
        id: profiles.id,
        email: profiles.email,
        fullName: profiles.fullName,
        role: profiles.role,
        createdAt: profiles.createdAt,
      })
      .from(profiles)
      .where(eq(profiles.id, auth.userId))
      .limit(1);

    const userProfile = {
      id: auth.userId,
      email: updatedRow?.email || auth.email || "",
      fullName: updatedRow?.fullName || "",
      role: updatedRow?.role || auth.role,
      createdAt: updatedRow?.createdAt ? updatedRow.createdAt.toISOString() : null,
    };

    return NextResponse.json({
      success: true,
      user: userProfile,
      profile: userProfile,
    });
  } catch (e) {
    return jsonError(e);
  }
}
