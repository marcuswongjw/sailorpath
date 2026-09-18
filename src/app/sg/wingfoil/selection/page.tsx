import { ErrorBoundary } from "@/components/ErrorBoundary";
import { WingfoilSelectionView } from "@/components/selection/WingfoilSelectionView";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "WingFoil Funding Policy 2026 | SailorPath",
  description:
    "Official Singapore Sailing Federation WingFoil event funding and selection policy for Thailand X-15 Wingfoil Series / Asian Championships Dec 2026.",
};

export default function WingfoilSelectionPage() {
  return (
    <ErrorBoundary>
      <WingfoilSelectionView />
    </ErrorBoundary>
  );
}
