import { db } from "@/db";
import { regattaEvents, regattas } from "@/db/schema";
import { SINGAPORE_REGATTAS_2026 } from "@/lib/calendar/singaporeRegattas2026";
import { getRegattaEvent } from "@/lib/regattaEvents";
import { groupRegattaEvents } from "@/lib/admin/groupRegattaEvents";
import { eq } from "drizzle-orm";

function canonicalSlug(slug: string): string {
  return getRegattaEvent(slug)?.slug ?? slug;
}

/**
 * Store each 2026 calendar weekend once, then point existing class sheets
 * at that weekend. Does not insert new scoreboards and does not publish anything.
 */
export async function linkRegattaEvents(): Promise<{
  events: number;
  linked: number;
}> {
  const bySlug = new Map<
    string,
    {
      name: string;
      slug: string;
      startDate: string;
      endDate: string | null;
      venue: string | null;
      organizer: string | null;
      classes: string[];
      norUrl: string | null;
      registrationUrl: string | null;
      countsForRanking: boolean;
      isSelectionTrial: boolean;
    }
  >();

  for (const item of SINGAPORE_REGATTAS_2026) {
    const slug = canonicalSlug(item.slug);
    const classes = item.classes?.length
      ? item.classes
      : item.boatClass
        ? [item.boatClass]
        : [];
    const current = bySlug.get(slug);
    if (!current) {
      bySlug.set(slug, {
        name: item.name,
        slug,
        startDate: item.startDate,
        endDate: item.endDate || null,
        venue: item.venue || null,
        organizer: item.organizer || null,
        classes,
        norUrl: item.norUrl || null,
        registrationUrl: item.registrationUrl || null,
        countsForRanking: item.countsForRanking,
        isSelectionTrial: item.isSelectionTrial,
      });
      continue;
    }
    current.classes = [...new Set([...current.classes, ...classes])];
    if (item.startDate < current.startDate) current.startDate = item.startDate;
    current.norUrl = current.norUrl || item.norUrl || null;
    current.registrationUrl = current.registrationUrl || item.registrationUrl || null;
  }

  const saved = new Map<string, string>();
  for (const event of bySlug.values()) {
    const [row] = await db
      .insert(regattaEvents)
      .values(event)
      .onConflictDoUpdate({
        target: regattaEvents.slug,
        set: {
          name: event.name,
          startDate: event.startDate,
          endDate: event.endDate,
          venue: event.venue,
          organizer: event.organizer,
          classes: event.classes,
          norUrl: event.norUrl,
          registrationUrl: event.registrationUrl,
          countsForRanking: event.countsForRanking,
          isSelectionTrial: event.isSelectionTrial,
          updatedAt: new Date(),
        },
      })
      .returning({ id: regattaEvents.id, slug: regattaEvents.slug });
    if (row) saved.set(row.slug, row.id);
  }

  const sheets = await db
    .select({
      id: regattas.id,
      name: regattas.name,
      slug: regattas.slug,
      date: regattas.date,
      boatClass: regattas.boatClass,
      division: regattas.division,
      status: regattas.status,
      eventId: regattas.eventId,
    })
    .from(regattas);

  const grouped = groupRegattaEvents(sheets);
  let linked = 0;
  for (const event of grouped.events) {
    const eventId = saved.get(event.slug);
    if (!eventId) continue;
    const rows = [...event.sheets, ...event.shells];
    for (const sheet of rows) {
      if (sheet.eventId === eventId) continue;
      await db
        .update(regattas)
        .set({ eventId, updatedAt: new Date() })
        .where(eq(regattas.id, sheet.id));
      linked += 1;
    }
  }

  return { events: saved.size, linked };
}
