import { ErrorBoundary } from "@/components/ErrorBoundary";
import { FleetRankingsView } from "@/components/FleetRankingsView";
import { getCachedFleetRankings } from "@/lib/queries";
import { currentPeriodFromSgToday } from "@/lib/datesSg";
import { DbUnavailableError } from "@/db";
import type { RankedSailor } from "@/lib/ranking";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Optimist Gold standings | SailorPath",
  description: "Current Singapore Optimist Gold Fleet best-3-of-5 series standings.",
};

/** ISR — first paint includes rankings (no client waterfall). */
export const revalidate = 60;

export default async function GoldPage() {
  const period = currentPeriodFromSgToday();
  let initialRanked: RankedSailor[] | undefined;
  let initialError: string | null = null;
  try {
    initialRanked = await getCachedFleetRankings(
      "Gold",
      period.year,
      period.half
    );
  } catch (e) {
    initialError =
      e instanceof DbUnavailableError ? e.message : "Failed to load rankings";
    initialRanked = [];
  }

  return (
    <ErrorBoundary>
      <FleetRankingsView
        fleet="Gold"
        initialPeriod={period}
        initialRanked={initialRanked}
        initialError={initialError}
      />
    </ErrorBoundary>
  );
}
