import { NextResponse } from "next/server";
import { revalidatePath } from "next/cache";
import { eq } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaEvents } from "@/db/schema";
import { logAdminChange } from "@/lib/adminChangeLog";

function clean(value: unknown, max = 300): string | null {
  const text = String(value ?? "").trim();
  if (!text) return null;
  return text.slice(0, max);
}

function classesFrom(value: unknown): string[] {
  const raw = Array.isArray(value) ? value.join(",") : String(value ?? "");
  return [...new Set(raw.split(",").map((item) => item.trim()).filter(Boolean))].slice(0, 16);
}

export async function GET() {
  try {
    await requireSuperadmin();
    const rows = await db.select().from(regattaEvents);
    return NextResponse.json({ ok: true, events: rows });
  } catch (e: unknown) {
    return jsonError(e);
  }
}

export async function PATCH(req: Request) {
  try {
    const auth = await requireSuperadmin();
    const body = await req.json();
    const slug = String(body.slug || "").trim().toLowerCase();
    const name = clean(body.name, 180);
    const startDate = clean(body.startDate, 10);
    if (!slug || !name || !startDate) {
      return NextResponse.json(
        { error: "slug, name, and start date are required" },
        { status: 400 }
      );
    }

    const values = {
      name,
      slug,
      startDate,
      endDate: clean(body.endDate, 10),
      venue: clean(body.venue),
      organizer: clean(body.organizer),
      classes: classesFrom(body.classes),
      norUrl: clean(body.norUrl, 500),
      registrationUrl: clean(body.registrationUrl, 500),
      countsForRanking: body.countsForRanking !== false,
      isSelectionTrial: Boolean(body.isSelectionTrial),
      keyDeadlines: clean(body.keyDeadlines, 500),
      updatedAt: new Date(),
    };

    const [saved] = await db
      .insert(regattaEvents)
      .values(values)
      .onConflictDoUpdate({
        target: regattaEvents.slug,
        set: values,
      })
      .returning();

    revalidatePath("/calendar");
    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "regatta_event_update",
      entityType: "regatta_event",
      entityId: saved?.id,
      summary: `Updated calendar card ${name}`,
      details: { slug },
    });

    return NextResponse.json({ ok: true, event: saved });
  } catch (e: unknown) {
    return jsonError(e);
  }
}
