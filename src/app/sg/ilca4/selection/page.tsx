import { ErrorBoundary } from "@/components/ErrorBoundary";
import { IlcaSelectionView } from "@/components/selection/IlcaSelectionView";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "ILCA 4 Selection Trials & Squad Policies 2026 | SailorPath",
  description:
    "Official Singapore ILCA 4 selection policies, international trial criteria (Eastern Seaboard, Asian Open 2026), and National Junior Training Squad (NJTS) regulations.",
};

export default function IlcaSelectionPage() {
  return (
    <ErrorBoundary>
      <IlcaSelectionView />
    </ErrorBoundary>
  );
}
