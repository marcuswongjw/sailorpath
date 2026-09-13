import { ErrorBoundary } from "@/components/ErrorBoundary";
import { OptimistSelectionView } from "@/components/selection/OptimistSelectionView";
import { getCachedOptimistSelectionData } from "@/lib/selectionQueries";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Optimist Selection Trials 2026 | SailorPath",
  description:
    "Official Singapore Optimist multi-event selection trials, combined series scores, and provisional team rosters for Asian & Oceania 2026 and Perth Camp.",
};

/** ISR — revalidate selection scores every 60 seconds */
export const revalidate = 60;

export default async function OptimistSelectionPage() {
  const payload = await getCachedOptimistSelectionData();

  return (
    <ErrorBoundary>
      <OptimistSelectionView initialData={payload} />
    </ErrorBoundary>
  );
}
