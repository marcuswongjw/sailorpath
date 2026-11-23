import { ErrorBoundary } from "@/components/ErrorBoundary";
import { OptimistSelectionView } from "@/components/selection/OptimistSelectionView";
import { getCachedOptimistSelectionData } from "@/lib/selectionQueries";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Optimist Selection Trials & 2027 Policies | SailorPath",
  description:
    "Official Singapore Optimist multi-event selection trials, combined series scores, provisional 2026 team rosters, and 2027 selection policies.",
};

/** Selection scores refresh when results are published; hourly backstop. */
export const revalidate = 3600;
// Selection data is database-backed. Render it on a real request instead of
// making production builds wait for an external database connection.
export const dynamic = "force-dynamic";

export default async function OptimistSelectionPage() {
  const payload = await getCachedOptimistSelectionData();

  return (
    <ErrorBoundary>
      <OptimistSelectionView initialData={payload} />
    </ErrorBoundary>
  );
}
