import { NextResponse } from "next/server";
import { getAuthContext, jsonError } from "@/lib/auth";
import {
  VIEW_AS_COOKIE,
  parseViewAs,
  type ViewAs,
} from "@/lib/viewAs";
import { getAuthCookieOptions } from "@/lib/supabase/cookie-options";

/**
 * POST /api/account/view-as  { viewAs: "admin" | "parent" }
 * Superadmin only — stores working mode in cookie for SSR profile permissions.
 */
export async function POST(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    if (auth.role !== "superadmin") {
      return NextResponse.json(
        { error: "Only superadmin can switch view mode" },
        { status: 403 }
      );
    }

    const body = await req.json().catch(() => ({}));
    const viewAs: ViewAs = parseViewAs(body.viewAs);

    const res = NextResponse.json({
      ok: true,
      viewAs,
      message:
        viewAs === "parent"
          ? "Working as Parent — claim and manage linked sailors like a parent."
          : "Working as Admin — full superadmin tools and private data access.",
    });

    const base = getAuthCookieOptions();
    res.cookies.set(VIEW_AS_COOKIE, viewAs, {
      path: "/",
      sameSite: "lax",
      secure: base?.secure ?? process.env.NODE_ENV === "production",
      maxAge: 60 * 60 * 24 * 365,
      httpOnly: false, // client header toggle can read it too
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
    const { cookies } = await import("next/headers");
    const jar = await cookies();
    const viewAs = parseViewAs(jar.get(VIEW_AS_COOKIE)?.value);
    return NextResponse.json({
      isSuperadmin: auth.role === "superadmin",
      viewAs: auth.role === "superadmin" ? viewAs : "admin",
    });
  } catch (e) {
    return jsonError(e);
  }
}
