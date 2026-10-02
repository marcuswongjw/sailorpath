import { NextResponse } from "next/server";
import { getAuthContext, jsonError } from "@/lib/auth";
import {
  followSailorForProfile,
  listFollowedSailorSummaries,
  unfollowSailorForProfile,
} from "@/lib/followedSailorsQuery";

export const dynamic = "force-dynamic";

export async function GET() {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    const sailors = await listFollowedSailorSummaries(auth.userId);
    return NextResponse.json({ sailors });
  } catch (error) {
    return jsonError(error);
  }
}

export async function POST(request: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    const body = await request.json().catch(() => ({}));
    const sailorId = String(body.sailorId || "").trim();
    if (!sailorId) {
      return NextResponse.json({ error: "Choose a sailor to follow" }, { status: 400 });
    }
    const result = await followSailorForProfile(auth.userId, sailorId);
    if (!result.ok) {
      return NextResponse.json({ error: result.error }, { status: result.status });
    }
    return NextResponse.json(
      { following: true, sailorId, alreadyFollowing: result.alreadyFollowing },
      { status: result.alreadyFollowing ? 200 : 201 }
    );
  } catch (error) {
    return jsonError(error);
  }
}

export async function DELETE(request: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    const sailorId = new URL(request.url).searchParams.get("sailorId")?.trim();
    if (!sailorId) {
      return NextResponse.json({ error: "sailorId required" }, { status: 400 });
    }
    await unfollowSailorForProfile(auth.userId, sailorId);
    return NextResponse.json({ following: false, sailorId });
  } catch (error) {
    return jsonError(error);
  }
}
