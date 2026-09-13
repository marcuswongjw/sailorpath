import { ErrorBoundary } from "@/components/ErrorBoundary";
import { WingfoilView } from "@/components/wingfoil/WingfoilView";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Singapore WingFoil Racing & Regatta Standings | SailorPath",
  description:
    "Singapore WingFoil Sprint Slalom regattas, event standings, heat results, and class specifications.",
};

export const revalidate = 300;

export default function WingfoilPage() {
  return (
    <ErrorBoundary>
      <WingfoilView />
    </ErrorBoundary>
  );
}
