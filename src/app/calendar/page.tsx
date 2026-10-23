import { Metadata } from "next";
import { permanentRedirect } from "next/navigation";
import { DbOffline } from "@/components/DbOffline";
import { RegattaCalendarClient } from "@/components/calendar/RegattaCalendarClient";
import { calendarPastResultsHref } from "@/lib/publicRouteRedirects";
import { getPublicCalendarData } from "@/lib/calendar/publicCalendar";

export const revalidate = 3600;

export const metadata: Metadata = {
  title: "Regattas and results | SailorPath",
  description:
    "Official schedule of Singapore youth sailing regattas, Asian Games & Perth selection trials, National Ranking Series dates, Notice of Race (NOR) downloads, and entry registration.",
};

type CalendarPageProps = {
  searchParams?: Promise<{
    event?: string;
    class?: string;
    view?: string;
    region?: string;
    q?: string;
    trials?: string;
    ranking?: string;
    year?: string;
  }>;
};

export default async function CalendarPage(props: CalendarPageProps) {
  const searchParams = props.searchParams ? await props.searchParams : undefined;
  if (searchParams?.view === "past") {
    permanentRedirect(calendarPastResultsHref(searchParams));
  }
  const initialClass = searchParams?.class || "all";
  const initialTimelineTab = searchParams?.view === "past" ? "past" : "upcoming";

  let calendar;
  try {
    calendar = await getPublicCalendarData();
  } catch {
    return <DbOffline title="Calendar is temporarily unavailable" />;
  }
  const { allRegattas, resultSheetsByEvent } = calendar;

  return (
    <RegattaCalendarClient
      regattas={allRegattas}
      resultSheetsByEvent={resultSheetsByEvent}
      initialRanking={searchParams?.ranking}
      initialYear={searchParams?.year}
      initialRegion={searchParams?.region}
      initialSearch={searchParams?.q}
      initialTrialOnly={searchParams?.trials === "1"}
      initialEvent={searchParams?.event}
      initialClass={initialClass}
      initialTimelineTab={initialTimelineTab}
    />
  );
}
