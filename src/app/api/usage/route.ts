import { NextResponse } from "next/server";
import { trackUsage, USAGE_EVENT_TYPES } from "@/lib/usage";
import { getAuthContext } from "@/lib/auth";
import {
  clientIpFromRequest,
  rateLimit,
  rateLimitResponse,
} from "@/lib/rateLimit";

const MAX_USAGE_BODY_BYTES = 4_096;
const USAGE_IP_LIMIT = 120;
const USAGE_SESSION_LIMIT = 30;
const USAGE_WINDOW_MS = 60_000;

/**
 * POST /api/usage — record a privacy-light usage event.
 * Body: { eventType, path?, sessionId?, meta? }
 * Auth optional; if signed in, role is attached (no email stored).
 */
export async function POST(req: Request) {
  try {
    const contentLength = Number(req.headers.get("content-length") || 0);
    if (Number.isFinite(contentLength) && contentLength > MAX_USAGE_BODY_BYTES) {
      return NextResponse.json({ error: "Payload too large" }, { status: 413 });
    }

    const body = await req.json().catch(() => ({}));
    const eventType = String(body.eventType || "").trim();
    if (!eventType) {
      return NextResponse.json({ error: "eventType required" }, { status: 400 });
    }
    // Analytics schemas must be closed: accepting arbitrary event names lets
    // callers poison reports and create unbounded cardinality in the database.
    if (!(USAGE_EVENT_TYPES as readonly string[]).includes(eventType)) {
      return NextResponse.json({ error: "Unsupported eventType" }, { status: 400 });
    }

    const sessionId =
      body.sessionId != null && String(body.sessionId).trim()
        ? String(body.sessionId).trim().slice(0, 64)
        : null;

    // Limit before auth/database work. Session limits constrain a normal
    // browser while the IP limit prevents clients from rotating session IDs.
    const ipLimit = rateLimit(
      `usage:ip:${clientIpFromRequest(req)}`,
      USAGE_IP_LIMIT,
      USAGE_WINDOW_MS
    );
    if (!ipLimit.ok) return rateLimitResponse(ipLimit.retryAfterSec);
    if (sessionId) {
      const sessionLimit = rateLimit(
        `usage:session:${sessionId}`,
        USAGE_SESSION_LIMIT,
        USAGE_WINDOW_MS
      );
      if (!sessionLimit.ok) return rateLimitResponse(sessionLimit.retryAfterSec);
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
      sessionId,
      meta: body.meta && typeof body.meta === "object" ? body.meta : null,
    });

    return NextResponse.json(result);
  } catch (e) {
    console.error("usage POST", e);
    return NextResponse.json({ ok: false, skipped: "error" }, { status: 200 });
  }
}
