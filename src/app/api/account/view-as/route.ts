import { NextResponse } from "next/server";
import { getAuthContext, jsonError } from "@/lib/auth";
import { VIEW_AS_COOKIE } from "@/lib/viewAs";
import { getAuthCookieOptions } from "@/lib/supabase/cookie-options";

/**
 * Legacy endpoint — superadmin parent "view-as" mode was removed.
 * Clears any leftover cookie so old clients stop sending it.
 */
function clearViewAsCookie(res: NextResponse) {
  const base = getAuthCookieOptions();
  res.cookies.set(VIEW_AS_COOKIE, "", {
    path: "/",
    sameSite: "lax",
    secure: base?.secure ?? process.env.NODE_ENV === "production",
    maxAge: 0,
    httpOnly: false,
    ...(base?.domain ? { domain: base.domain } : {}),
  });
}

export async function POST() {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }

    const res = NextResponse.json({
      ok: true,
      viewAs: "admin",
      retired: true,
      message: "Superadmin view-as (parent mode) was removed.",
    });
    clearViewAsCookie(res);
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
    const res = NextResponse.json({
      isSuperadmin: auth.role === "superadmin",
      viewAs: "admin",
      retired: true,
    });
    clearViewAsCookie(res);
    return res;
  } catch (e) {
    return jsonError(e);
  }
}
