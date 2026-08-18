import { NextResponse } from "next/server";
import { desc, eq } from "drizzle-orm";
import { getAuthContext, jsonError, requireSuperadmin } from "@/lib/auth";
import { db } from "@/db";
import { supportMessages } from "@/db/schema";
import { trackUsage } from "@/lib/usage";
import {
  clientIpFromRequest,
  rateLimitAsync,
  rateLimitResponse,
} from "@/lib/rateLimit";
import { asBoundedText, asEmail, asHttpUrl, asString } from "@/lib/validate";

const TOPICS = new Set([
  "account",
  "claim",
  "ranking",
  "profile",
  "bug",
  "waitlist",
  "other",
]);

/** Public: submit a support message */
export async function POST(req: Request) {
  try {
    const ip = clientIpFromRequest(req);
    const rl = await rateLimitAsync(`support:${ip}`, 5, 15 * 60 * 1000);
    if (!rl.ok) return rateLimitResponse(rl.retryAfterSec);

    const body = await req.json();
    const emailR = asEmail(body.email);
    if (!emailR.ok) {
      return NextResponse.json({ error: emailR.error }, { status: 400 });
    }
    const messageR = asBoundedText(body.body ?? body.message, {
      min: 10,
      max: 4000,
      field: "message",
      required: true,
    });
    if (!messageR.ok || !messageR.value) {
      return NextResponse.json(
        { error: messageR.ok ? "Message required" : messageR.error },
        { status: 400 }
      );
    }
    const name = asString(body.name, 120);
    const topicRaw = String(body.topic || "other").toLowerCase();
    const topic = TOPICS.has(topicRaw) ? topicRaw : "other";
    const pageUrlR = asHttpUrl(body.pageUrl, "pageUrl", 500);
    if (!pageUrlR.ok) {
      return NextResponse.json({ error: pageUrlR.error }, { status: 400 });
    }
    const email = emailR.value;
    const message = messageR.value;
    const pageUrl = pageUrlR.value;

    let userId: string | null = null;
    try {
      const auth = await getAuthContext();
      userId = auth?.userId ?? null;
    } catch {
      /* optional */
    }

    const [row] = await db
      .insert(supportMessages)
      .values({
        userId,
        email,
        name: name || null,
        topic,
        body: message,
        pageUrl,
        status: "new",
      })
      .returning({ id: supportMessages.id });

    void trackUsage({
      eventType: topic === "waitlist" ? "waitlist_submit" : "support_submit",
      path: topic === "waitlist" ? "/" : "/support",
      meta: {
        topic,
        // WaitlistForm sends role in `name` field (privacy: role only, not free text)
        role:
          topic === "waitlist" && name
            ? name.toLowerCase().slice(0, 40)
            : null,
      },
    });

    return NextResponse.json({
      ok: true,
      id: row.id,
      message: "Thanks — we received your message and will follow up by email.",
    });
  } catch (e) {
    console.error("support POST", e);
    return jsonError(e);
  }
}

/** Superadmin: list support messages */
export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    const { searchParams } = new URL(req.url);
    const status = searchParams.get("status");

    let rows = await db
      .select()
      .from(supportMessages)
      .orderBy(desc(supportMessages.createdAt))
      .limit(100);

    if (status && ["new", "read", "resolved"].includes(status)) {
      rows = rows.filter((r) => r.status === status);
    }

    return NextResponse.json({ messages: rows });
  } catch (e) {
    return jsonError(e);
  }
}

/** Superadmin: update status */
export async function PATCH(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    const id = String(body.id || "").trim();
    const status = String(body.status || "").trim();
    if (!id || !["new", "read", "resolved"].includes(status)) {
      return NextResponse.json(
        { error: "id and status (new|read|resolved) required" },
        { status: 400 }
      );
    }
    const [updated] = await db
      .update(supportMessages)
      .set({
        status: status as "new" | "read" | "resolved",
        updatedAt: new Date(),
      })
      .where(eq(supportMessages.id, id))
      .returning();
    if (!updated) {
      return NextResponse.json({ error: "Not found" }, { status: 404 });
    }
    return NextResponse.json({ ok: true, message: updated });
  } catch (e) {
    return jsonError(e);
  }
}
