import {
  sheetIdsForEvent,
  UNASSIGNED_EVENT_SLUG,
  type AdminEventGroup,
  type GroupableRegatta,
} from "@/lib/admin/groupRegattaEvents";

export type PlannedRegattaEventDelete =
  | { ok: false; status: 400 | 404; error: string }
  | {
      ok: true;
      eventId: string | null;
      name: string;
      sheetIds: string[];
    };

/**
 * Collects the calendar row and class sheets to remove for one weekend slug.
 * Unassigned is a filter bucket, not a deletable event.
 */
export function planRegattaEventDelete(args: {
  slug: string;
  grouped: { events: AdminEventGroup[]; unassigned: GroupableRegatta[] };
  eventRows: { id: string; slug: string; name: string }[];
  sheets: { id: string; eventId?: string | null }[];
}): PlannedRegattaEventDelete {
  const slug = String(args.slug || "").trim().toLowerCase();
  if (!slug) {
    return { ok: false, status: 400, error: "slug required" };
  }
  if (slug === UNASSIGNED_EVENT_SLUG) {
    return {
      ok: false,
      status: 400,
      error: "Cannot delete the unassigned sailing-class bucket",
    };
  }

  const saved = args.eventRows.find((row) => row.slug === slug) ?? null;
  const groupedEvent = args.grouped.events.find((event) => event.slug === slug);
  const ids = new Set(sheetIdsForEvent(args.grouped, slug));
  if (saved) {
    for (const sheet of args.sheets) {
      if (sheet.eventId === saved.id) ids.add(sheet.id);
    }
  }

  if (!saved && ids.size === 0 && !groupedEvent) {
    return { ok: false, status: 404, error: "Regatta event not found" };
  }

  return {
    ok: true,
    eventId: saved?.id ?? null,
    name: saved?.name || groupedEvent?.name || slug,
    sheetIds: [...ids],
  };
}
