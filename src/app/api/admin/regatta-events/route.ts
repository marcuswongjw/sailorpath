import { NextResponse } from "next/server";
import { revalidatePath } from "next/cache";
import { eq, inArray } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaEvents, regattas } from "@/db/schema";
import { logAdminChange } from "@/lib/adminChangeLog";
import { groupRegattaEvents } from "@/lib/admin/groupRegattaEvents";
import { planRegattaEventDelete } from "@/lib/admin/planRegattaEventDelete";
import { MIN_RACES_FOR_RANKING } from "@/lib/ranking";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";

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

    const sheetRows = await db
      .select({
        id: regattas.id,
        name: regattas.name,
        slug: regattas.slug,
        date: regattas.date,
        boatClass: regattas.boatClass,
        division: regattas.division,
        status: regattas.status,
        raceCount: regattas.raceCount,
        countsForRanking: regattas.countsForRanking,
        eventId: regattas.eventId,
      })
      .from(regattas);
    const match = groupRegattaEvents(sheetRows).events.find(
      (event) => event.slug === slug
    );
    let sheetsUpdated = 0;
    let sheetsKeptNonRanking = 0;
    if (match && saved) {
      for (const sheet of match.sheets) {
        const tooFew =
          sheet.raceCount != null && sheet.raceCount < MIN_RACES_FOR_RANKING;
        const nextFlag = values.countsForRanking && !tooFew;
        if (values.countsForRanking && tooFew) sheetsKeptNonRanking += 1;
        if (sheet.countsForRanking === nextFlag && sheet.eventId === saved.id) {
          continue;
        }
        await db
          .update(regattas)
          .set({
            countsForRanking: nextFlag,
            eventId: saved.id,
            updatedAt: new Date(),
          })
          .where(eq(regattas.id, sheet.id));
        sheetsUpdated += 1;
      }
    }

    revalidatePath("/calendar");
    revalidatePublicRankings(`regatta-event:${slug}`);
    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "regatta_event_update",
      entityType: "regatta_event",
      entityId: saved?.id,
      summary: `Updated calendar card ${name}`,
      details: { slug, sheetsUpdated, sheetsKeptNonRanking },
    });

    return NextResponse.json({
      ok: true,
      event: saved,
      sheetsUpdated,
      sheetsKeptNonRanking,
    });
  } catch (e: unknown) {
    return jsonError(e);
  }
}

export async function DELETE(req: Request) {
  try {
    const auth = await requireSuperadmin();
    const slug = String(new URL(req.url).searchParams.get("slug") || "")
      .trim()
      .toLowerCase();
    if (!slug) {
      return NextResponse.json({ error: "slug required" }, { status: 400 });
    }

    const eventRows = await db.select().from(regattaEvents);
    const slugsById = new Map(eventRows.map((row) => [row.id, row.slug]));
    const sheetRows = await db
      .select({
        id: regattas.id,
        name: regattas.name,
        slug: regattas.slug,
        date: regattas.date,
        boatClass: regattas.boatClass,
        division: regattas.division,
        status: regattas.status,
        raceCount: regattas.raceCount,
        countsForRanking: regattas.countsForRanking,
        eventId: regattas.eventId,
      })
      .from(regattas);

    const grouped = groupRegattaEvents(sheetRows, slugsById);
    const planned = planRegattaEventDelete({
      slug,
      grouped,
      eventRows,
      sheets: sheetRows,
    });
    if (!planned.ok) {
      return NextResponse.json({ error: planned.error }, { status: planned.status });
    }

    if (planned.sheetIds.length > 0 || planned.eventId) {
      await db.transaction(async (tx) => {
        if (planned.sheetIds.length > 0) {
          await tx.delete(regattas).where(inArray(regattas.id, planned.sheetIds));
        }
        if (planned.eventId) {
          await tx
            .delete(regattaEvents)
            .where(eq(regattaEvents.id, planned.eventId));
        }
      });
    }

    revalidatePath("/calendar");
    revalidatePublicRankings(`regatta-event-delete:${slug}`);
    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "regatta_event_delete",
      entityType: "regatta_event",
      entityId: planned.eventId ?? undefined,
      entityLabel: planned.name,
      summary: `Deleted regatta event ${planned.name} (${planned.sheetIds.length} class sheets)`,
      details: { slug, sheetIds: planned.sheetIds },
      source: "/api/admin/regatta-events",
    });

    return NextResponse.json({
      ok: true,
      slug,
      eventId: planned.eventId,
      deletedSheetIds: planned.sheetIds,
    });
  } catch (e: unknown) {
    return jsonError(e);
  }
}
