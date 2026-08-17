import { NextResponse } from "next/server";
import { getAuthContext, jsonError } from "@/lib/auth";
import { VIEW_AS_COOKIE } from "@/lib/viewAs";
import { getAuthCookieOptions } from "@/lib/supabase/cookie-options";

/**
 * POST /api/account/view-as — retired.
 * Superadmin parent mode is removed; always admin.
 */
export async function POST() {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    if (auth.role !== "superadmin") {
      return NextResponse.json(
        { error: "Only superadmin can set view mode" },
        { status: 403 }
      );
    }

    const res = NextResponse.json({
      ok: true,
      viewAs: "admin",
      message: "Superadmin always works as admin (parent mode removed).",
    });

    const base = getAuthCookieOptions();
    res.cookies.set(VIEW_AS_COOKIE, "admin", {
      path: "/",
      sameSite: "lax",
      secure: base?.secure ?? process.env.NODE_ENV === "production",
      maxAge: 60 * 60 * 24 * 365,
      httpOnly: false,
      ...(base?.domain ? { domain: base.domain } : {}),
    });

    return res;
  } catch (e) {
    return jsonError(e);
  }
}

export async function GET() {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    return NextResponse.json({
      isSuperadmin: auth.role === "superadmin",
      viewAs: "admin",
    });
  } catch (e) {
    return jsonError(e);
  }
}
