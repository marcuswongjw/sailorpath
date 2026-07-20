import { NextResponse } from "next/server";
import { desc, eq } from "drizzle-orm";
import { getAuthContext, jsonError, requireSuperadmin } from "@/lib/auth";
import { db } from "@/db";
import { supportMessages } from "@/db/schema";
import { trackUsage } from "@/lib/usage";

const TOPICS = new Set([
  "account",
  "claim",
  "ranking",
  "profile",
  "bug",
  "other",
]);

/** Public: submit a support message */
export async function POST(req: Request) {
  try {
    const body = await req.json();
    const email = String(body.email || "")
      .trim()
      .toLowerCase();
    const message = String(body.body || body.message || "").trim();
    const name = body.name != null ? String(body.name).trim().slice(0, 120) : null;
    const topicRaw = String(body.topic || "other").toLowerCase();
    const topic = TOPICS.has(topicRaw) ? topicRaw : "other";
    const pageUrl =
      body.pageUrl != null ? String(body.pageUrl).trim().slice(0, 500) : null;

    if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      return NextResponse.json({ error: "Valid email required" }, { status: 400 });
    }
    if (message.length < 10) {
      return NextResponse.json(
        { error: "Please write a bit more detail (10+ characters)" },
        { status: 400 }
      );
    }
    if (message.length > 4000) {
      return NextResponse.json({ error: "Message too long" }, { status: 400 });
    }

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
      eventType: "support_submit",
      path: "/support",
      meta: { topic },
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
