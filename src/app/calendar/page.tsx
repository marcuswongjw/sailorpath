import { Metadata } from "next";
import { getCachedPublicRegattas } from "@/lib/queries";
import { RegattaCalendarClient } from "@/components/calendar/RegattaCalendarClient";
import { SINGAPORE_REGATTAS_2026 } from "@/lib/calendar/singaporeRegattas2026";
import {
  applyCalendarEventOverride,
  canonicalCalendarEventSlug,
  type CalendarEventOverride,
} from "@/lib/calendar/applyEventOverrides";
import { db } from "@/db";
import { regattaEvents } from "@/db/schema";
import type { RegattaRecord } from "@/lib/ranking";

export const revalidate = 120;

export const metadata: Metadata = {
  title: "Singapore Regatta Calendar 2026 | SailorPath",
  description:
    "Official schedule of Singapore youth sailing regattas, Asian Games & Perth selection trials, National Ranking Series dates, Notice of Race (NOR) downloads, and entry registration.",
};

type CalendarPageProps = {
  searchParams?: Promise<{
    class?: string;
  }>;
};

export default async function CalendarPage(props: CalendarPageProps) {
  const searchParams = props.searchParams ? await props.searchParams : undefined;
  const initialClass = searchParams?.class || "all";

  let dbRegattas: RegattaRecord[] = [];
  let savedEvents: CalendarEventOverride[] = [];
  try {
    dbRegattas = await getCachedPublicRegattas();
  } catch {
    dbRegattas = [];
  }
  try {
    const rows = await db.select().from(regattaEvents);
    savedEvents = rows.map((row) => ({
      slug: row.slug,
      name: row.name,
      startDate: String(row.startDate).slice(0, 10),
      endDate: row.endDate ? String(row.endDate).slice(0, 10) : null,
      venue: row.venue,
      organizer: row.organizer,
      classes: row.classes,
      norUrl: row.norUrl,
      registrationUrl: row.registrationUrl,
      countsForRanking: row.countsForRanking,
      isSelectionTrial: row.isSelectionTrial,
      keyDeadlines: row.keyDeadlines,
    }));
  } catch {
    savedEvents = [];
  }

  // Load 2026 master schedule events
  const combinedMap = new Map<string, RegattaRecord>();

  for (const item of SINGAPORE_REGATTAS_2026) {
    combinedMap.set(item.slug, {
      id: item.slug,
      name: item.name,
      slug: item.slug,
      date: item.startDate,
      endDate: item.endDate,
      totalFleetSize: item.totalFleetSize,
      division: item.division,
      venue: item.venue,
      region: item.region,
      organizer: item.organizer,
      countsForRanking: item.countsForRanking,
      isSelectionTrial: item.isSelectionTrial,
      targetFleet: item.targetFleet,
      keyDeadlines: item.keyDeadlines,
      clinicDates: item.clinicDates,
      norUrl: item.norUrl,
      registrationUrl: item.registrationUrl,
      scheduleNotes: item.scheduleNotes,
      prizesSummary: item.prizesSummary,
      boatClass: item.boatClass,
      classes: item.classes,
      geography: item.geography || "SG",
    });
  }

  // Then overlay database metadata for matching schedule events ONLY (do not inject class-specific DB results)
  for (const r of dbRegattas) {
    const existing = combinedMap.get(r.slug);
    if (!existing) continue;
    combinedMap.set(r.slug, {
      ...existing,
      venue: r.venue || existing.venue,
      endDate: r.endDate || existing.endDate,
      norUrl: r.norUrl || existing.norUrl,
      registrationUrl: r.registrationUrl || existing.registrationUrl,
      isSelectionTrial: r.isSelectionTrial ?? existing.isSelectionTrial ?? false,
      organizer: r.organizer || existing.organizer,
      scheduleNotes: r.scheduleNotes || existing.scheduleNotes,
      region: r.region || existing.region,
      targetFleet: r.targetFleet || existing.targetFleet,
      keyDeadlines: r.keyDeadlines || existing.keyDeadlines,
      clinicDates: r.clinicDates || existing.clinicDates,
      hasResults: true,
    });
  }

  const savedBySlug = new Map(savedEvents.map((event) => [event.slug, event]));
  const cardsByEvent = new Map<string, string[]>();
  for (const item of combinedMap.values()) {
    const canonical = canonicalCalendarEventSlug(item.slug);
    const list = cardsByEvent.get(canonical) ?? [];
    list.push(item.slug);
    cardsByEvent.set(canonical, list);
  }
  for (const [slug, entry] of combinedMap) {
    const canonical = canonicalCalendarEventSlug(slug);
    const saved = savedBySlug.get(canonical);
    const cards = cardsByEvent.get(canonical) ?? [];
    const primary = cards[0] === slug;
    combinedMap.set(slug, applyCalendarEventOverride(entry, saved, primary));
  }

  const allRegattas = Array.from(combinedMap.values());

  return (
    <RegattaCalendarClient
      regattas={allRegattas}
      initialClass={initialClass}
    />
  );
}
