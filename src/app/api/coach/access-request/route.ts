import { NextResponse } from "next/server";
import { and, eq, or } from "drizzle-orm";
import { db } from "@/db";
import { coachAccessRequests } from "@/db/schema";
import { getAuthContext, jsonError } from "@/lib/auth";

type AccessRequestRow = {
  id: string;
  status: "pending" | "approved" | "rejected";
  source: "user" | "admin";
};

function preservedResponse(row: AccessRequestRow) {
  if (row.source === "admin" && row.status === "pending") {
    return NextResponse.json({ status: "pending" as const });
  }
  if (row.status === "approved") {
    return NextResponse.json({ status: "approved" as const });
  }
  return null;
}

async function loadRequest(userId: string): Promise<AccessRequestRow | null> {
  const [row] = await db
    .select({
      id: coachAccessRequests.id,
      status: coachAccessRequests.status,
      source: coachAccessRequests.source,
    })
    .from(coachAccessRequests)
    .where(eq(coachAccessRequests.requesterId, userId))
    .limit(1);
  return row ?? null;
}

export async function POST() {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Not signed in" }, { status: 401 });
    }
    if (auth.role === "coach" || auth.role === "superadmin") {
      return NextResponse.json({ status: "approved" });
    }

    let existing = await loadRequest(auth.userId);
    if (existing) {
      const preserved = preservedResponse(existing);
      if (preserved) return preserved;
    } else {
      const inserted = await db
        .insert(coachAccessRequests)
        .values({
          requesterId: auth.userId,
          status: "pending",
          source: "user",
        })
        .onConflictDoNothing({ target: coachAccessRequests.requesterId })
        .returning({ status: coachAccessRequests.status });
      if (inserted[0]) {
        return NextResponse.json({ status: inserted[0].status });
      }
      existing = await loadRequest(auth.userId);
      if (!existing) {
        return NextResponse.json(
          { error: "Could not save request" },
          { status: 500 }
        );
      }
      const preserved = preservedResponse(existing);
      if (preserved) return preserved;
    }

    const [updated] = await db
      .update(coachAccessRequests)
      .set({
        status: "pending",
        source: "user",
        inviteToken: null,
        requestedAt: new Date(),
        reviewedAt: null,
        reviewedBy: null,
        updatedAt: new Date(),
      })
      .where(
        and(
          eq(coachAccessRequests.id, existing.id),
          or(
            eq(coachAccessRequests.status, "rejected"),
            and(
              eq(coachAccessRequests.status, "pending"),
              eq(coachAccessRequests.source, "user")
            )
          )
        )
      )
      .returning({ status: coachAccessRequests.status });

    if (updated) {
      return NextResponse.json({ status: updated.status });
    }

    const current = await loadRequest(auth.userId);
    if (!current) {
      return NextResponse.json(
        { error: "Could not save request" },
        { status: 500 }
      );
    }
    const preserved = preservedResponse(current);
    if (preserved) return preserved;
    return NextResponse.json({ status: current.status });
  } catch (error) {
    console.error("coach access request", error);
    return jsonError(error);
  }
}
