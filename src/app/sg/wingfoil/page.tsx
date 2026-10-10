import { ErrorBoundary } from "@/components/ErrorBoundary";
import { WingfoilView } from "@/components/wingfoil/WingfoilView";
import { loadPublicBoardClassData } from "@/lib/boardClassPublicData";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Singapore WingFoil Racing & Regatta Standings | SailorPath",
  description:
    "Singapore WingFoil Sprint Slalom regattas, event standings, heat results, and class specifications.",
};

export const revalidate = 60;

type WingfoilPageProps = {
  searchParams?: Promise<{ tab?: string; regatta?: string }>;
};

export default async function WingfoilPage({ searchParams }: WingfoilPageProps) {
  const params = searchParams ? await searchParams : {};
  const data = await loadPublicBoardClassData("wingfoil");
  const initialTab =
    params.tab === "results" || params.tab === "series" || params.tab === "regattas"
      ? params.tab
      : "scorecards";
  return (
    <ErrorBoundary>
      <WingfoilView
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
