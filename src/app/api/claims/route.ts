import { NextResponse } from "next/server";
import { and, eq } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { sailorClaims, sailors } from "@/db/schema";
import { trackUsage } from "@/lib/usage";
import {
  parseClaimRelation,
  relationFromNote,
  type ClaimRelation,
} from "@/lib/claimRelation";
import {
  clientIpFromRequest,
  rateLimitAsync,
  rateLimitResponse,
} from "@/lib/rateLimit";
import { asBoundedText, asUuid } from "@/lib/validate";

/** Logged-in user requests to claim a sailor profile */
export async function POST(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json(
        { error: "Sign in to claim a profile" },
        { status: 401 }
      );
    }
    const rl = await rateLimitAsync(
      `claims:${auth.userId}:${clientIpFromRequest(req)}`,
      10,
      60 * 60 * 1000
    );
    if (!rl.ok) return rateLimitResponse(rl.retryAfterSec);

    const body = await req.json();
    const sailorIdR = asUuid(body.sailorId, "sailorId");
    if (!sailorIdR.ok) {
      return NextResponse.json({ error: sailorIdR.error }, { status: 400 });
    }
    const sailorId = sailorIdR.value;

    const relation: ClaimRelation =
      parseClaimRelation(body.relation) ||
      relationFromNote(body.note) ||
      "parent";

    const noteR = asBoundedText(body.note, {
      max: 2000,
      field: "note",
    });
    if (!noteR.ok) {
      return NextResponse.json({ error: noteR.error }, { status: 400 });
    }
    const noteRaw = noteR.value || "";
    // Keep [relation] prefix for admin readability if not already present
    const note =
      noteRaw && !/^\[(parent|sailor|other)\]/i.test(noteRaw)
        ? `[${relation}] ${noteRaw}`
        : noteRaw || `[${relation}]`;

    const [sailor] = await db
      .select({
        id: sailors.id,
        parentId: sailors.parentId,
        name: sailors.name,
      })
      .from(sailors)
      .where(eq(sailors.id, sailorId))
      .limit(1);
    if (!sailor) {
      return NextResponse.json({ error: "Sailor not found" }, { status: 404 });
    }
    if (sailor.parentId) {
      return NextResponse.json(
        { error: "This profile is already claimed" },
        { status: 400 }
      );
    }

    const existing = await db
      .select()
      .from(sailorClaims)
      .where(
        and(
          eq(sailorClaims.sailorId, sailorId),
          eq(sailorClaims.requesterId, auth.userId),
          eq(sailorClaims.status, "pending")
        )
      )
      .limit(1);
    if (existing[0]) {
      return NextResponse.json({
        ok: true,
        claim: existing[0],
        message: "Claim already pending",
      });
    }

    const [claim] = await db
      .insert(sailorClaims)
      .values({
        sailorId,
        requesterId: auth.userId,
        status: "pending",
        relation,
        note: note || null,
      })
      .returning();

    // Optional client session + acquisition (for claim rate by source/device)
    const sessionId =
      body.sessionId != null
        ? String(body.sessionId).trim().slice(0, 64)
        : null;
    const source =
      body.source != null
        ? String(body.source).trim().toLowerCase().slice(0, 40)
        : null;
    const device =
      body.device === "mobile" || body.device === "desktop"
        ? body.device
        : null;
    const vid =
      body.vid != null ? String(body.vid).trim().slice(0, 64) : null;

    void trackUsage({
      eventType: "claim_submit",
      path: "/api/claims",
      role: auth.role,
      sessionId,
      meta: {
        status: "pending",
        relation,
        source: source || null,
        device: device || null,
        vid: vid || null,
      },
    });

    return NextResponse.json({
      ok: true,
      claim,
      message: `Claim submitted for ${sailor.name}. Please wait for confirmation.`,
    });
  } catch (e) {
    console.error("claims POST", e);
    return jsonError(e);
  }
}

export async function GET() {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }
    const rows = await db
      .select()
      .from(sailorClaims)
      .where(eq(sailorClaims.requesterId, auth.userId));
    return NextResponse.json({ claims: rows });
  } catch (e) {
    return jsonError(e);
  }
}
