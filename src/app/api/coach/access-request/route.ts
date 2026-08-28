import { NextResponse } from "next/server";
import { db } from "@/db";
import { coachAccessRequests } from "@/db/schema";
import { getAuthContext, jsonError } from "@/lib/auth";

export async function POST() {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Not signed in" }, { status: 401 });
    }
    if (auth.role === "coach" || auth.role === "superadmin") {
      return NextResponse.json({ status: "approved" });
    }

    const [request] = await db
      .insert(coachAccessRequests)
      .values({ requesterId: auth.userId })
      .onConflictDoUpdate({
        target: coachAccessRequests.requesterId,
        set: {
          status: "pending",
          requestedAt: new Date(),
          reviewedAt: null,
          reviewedBy: null,
          updatedAt: new Date(),
        },
      })
      .returning({ status: coachAccessRequests.status });

    return NextResponse.json({ status: request.status });
  } catch (error) {
    console.error("coach access request", error);
    return jsonError(error);
  }
}
