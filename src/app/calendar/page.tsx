import { Metadata } from "next";
import { getCachedPublicRegattas } from "@/lib/queries";
import { RegattaCalendarClient } from "@/components/calendar/RegattaCalendarClient";
import { SINGAPORE_REGATTAS_2026 } from "@/lib/calendar/singaporeRegattas2026";
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
  try {
    dbRegattas = await getCachedPublicRegattas();
  } catch {
    dbRegattas = [];
  }

  // Combine DB regattas with known 2026 master schedule so upcoming events are always populated
  const combinedMap = new Map<string, RegattaRecord>();

  // First load seed events
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
      campaignBudget: item.campaignBudget,
      norUrl: item.norUrl,
      registrationUrl: item.registrationUrl,
      scheduleNotes: item.scheduleNotes,
      boatClass: item.boatClass,
      geography: item.geography || "SG",
    });
  }

  // Then overlay any database records
  for (const r of dbRegattas) {
    const existing = combinedMap.get(r.slug);
    combinedMap.set(r.slug, {
      ...existing,
      ...r,
      venue: r.venue || existing?.venue,
      endDate: r.endDate || existing?.endDate,
      norUrl: r.norUrl || existing?.norUrl,
      registrationUrl: r.registrationUrl || existing?.registrationUrl,
      isSelectionTrial: r.isSelectionTrial ?? existing?.isSelectionTrial ?? false,
      organizer: r.organizer || existing?.organizer,
      scheduleNotes: r.scheduleNotes || existing?.scheduleNotes,
      region: r.region || existing?.region,
      targetFleet: r.targetFleet || existing?.targetFleet,
      keyDeadlines: r.keyDeadlines || existing?.keyDeadlines,
      clinicDates: r.clinicDates || existing?.clinicDates,
      campaignBudget: r.campaignBudget || existing?.campaignBudget,
      hasResults: true,
    });
  }

  const allRegattas = Array.from(combinedMap.values());

  return (
    <RegattaCalendarClient
      regattas={allRegattas}
      initialClass={initialClass}
    />
  );
}
