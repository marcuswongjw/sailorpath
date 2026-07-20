import { NextResponse } from "next/server";
import { trackUsage, USAGE_EVENT_TYPES } from "@/lib/usage";
import { getAuthContext } from "@/lib/auth";

/**
 * POST /api/usage — record a privacy-light usage event.
 * Body: { eventType, path?, sessionId?, meta? }
 * Auth optional; if signed in, role is attached (no email stored).
 */
export async function POST(req: Request) {
  try {
    const body = await req.json().catch(() => ({}));
    const eventType = String(body.eventType || "").trim();
    if (!eventType) {
      return NextResponse.json({ error: "eventType required" }, { status: 400 });
    }
    // Soft allow-list: known types or short custom
    const known = (USAGE_EVENT_TYPES as readonly string[]).includes(eventType);
    if (!known && !/^[a-z][a-z0-9_]{1,40}$/i.test(eventType)) {
      return NextResponse.json({ error: "Invalid eventType" }, { status: 400 });
    }

    let role: string | null = "public";
    try {
      const auth = await getAuthContext();
      if (auth?.role) role = auth.role;
    } catch {
      /* ignore */
    }
    if (body.role && typeof body.role === "string" && body.role === "public") {
      // client may send public when not logged in
      role = role || "public";
    }

    const result = await trackUsage({
      eventType,
      path: body.path,
      role,
      sessionId: body.sessionId,
      meta: body.meta && typeof body.meta === "object" ? body.meta : null,
    });

    return NextResponse.json(result);
  } catch (e) {
    console.error("usage POST", e);
    return NextResponse.json({ ok: false, skipped: "error" }, { status: 200 });
  }
}
