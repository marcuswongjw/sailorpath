import { withUserChangeTracking } from "@/lib/userChanges";
import { NextResponse } from "next/server";
import { getAuthContext, jsonError } from "@/lib/auth";
import { readFollowAction } from "@/lib/followRequest";
import { safeAuthNext } from "@/lib/supabase/cookie-options";
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

function redirectTo(request: Request, path: string) {
  return NextResponse.redirect(new URL(path, request.url), 303);
}

async function handlePOST(request: Request) {
  try {
    const action = await readFollowAction(request);
    const auth = await getAuthContext();
    if (!auth) {
      if (action.redirect) {
        const next = safeAuthNext(action.nextPath, "/account");
        return redirectTo(request, `/login?next=${encodeURIComponent(next)}`);
      }
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    if (!action.sailorId) {
      if (action.redirect) return redirectTo(request, action.nextPath);
      return NextResponse.json({ error: "Choose a sailor to follow" }, { status: 400 });
    }

    if (action.intent === "unfollow") {
      await unfollowSailorForProfile(auth.userId, action.sailorId);
      if (action.redirect) return redirectTo(request, action.nextPath);
      return NextResponse.json({ following: false, sailorId: action.sailorId });
    }

    const result = await followSailorForProfile(auth.userId, action.sailorId);
    if (!result.ok) {
      if (action.redirect) return redirectTo(request, action.nextPath);
      return NextResponse.json({ error: result.error }, { status: result.status });
    }
    if (action.redirect) return redirectTo(request, action.nextPath);
    return NextResponse.json(
      { following: true, sailorId: action.sailorId, alreadyFollowing: result.alreadyFollowing },
      { status: result.alreadyFollowing ? 200 : 201 }
    );
  } catch (error) {
    return jsonError(error);
  }
}

async function handleDELETE(request: Request) {
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

export const POST = withUserChangeTracking("following", handlePOST);
export const DELETE = withUserChangeTracking("following", handleDELETE);
