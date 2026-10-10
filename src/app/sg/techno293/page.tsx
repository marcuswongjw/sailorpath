import { ErrorBoundary } from "@/components/ErrorBoundary";
import { Techno293View } from "@/components/techno293/Techno293View";
import { loadPublicBoardClassData } from "@/lib/boardClassPublicData";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Singapore Techno 293 Racing & Series Standings | SailorPath",
  description:
    "Singapore Techno 293 One Design windsurfing regattas, Southwest Monsoon Grand Prix Series standings, race scorecards, and class specifications.",
};

export const revalidate = 60;

type Techno293PageProps = {
  searchParams?: Promise<{ tab?: string; regatta?: string }>;
};

export default async function Techno293Page({ searchParams }: Techno293PageProps) {
  const params = searchParams ? await searchParams : {};
  const data = await loadPublicBoardClassData("techno293");
  const initialTab =
    params.tab === "results" ||
    params.tab === "series" ||
    params.tab === "regattas" ||
    params.tab === "specs"
      ? params.tab
      : "scorecards";
  return (
    <ErrorBoundary>
      <Techno293View
        initialRegattas={data.specialistRegattas}
        initialTab={initialTab}
        initialRegattaId={params.regatta}
        initialPublishedRows={data.publishedRows}
        initialCalendarRows={data.calendarRows}
        sourceCounts={data.sourceCounts}
      />
    </ErrorBoundary>
  );
}
