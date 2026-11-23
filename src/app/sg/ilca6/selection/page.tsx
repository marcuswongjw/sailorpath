import { ErrorBoundary } from "@/components/ErrorBoundary";
import { Ilca6SelectionView } from "@/components/selection/Ilca6SelectionView";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "ILCA 6 Selection Policies 2027 | SailorPath",
  description:
    "Official Singapore Sailing Federation 2027 ILCA 6 selection policies for Langkawi International Regatta, China Training Camp, Kieler Woche, ILCA 6 Youth World Championships, and Eastern Seaboard Regatta.",
};

export default function Ilca6SelectionPage() {
  return (
    <ErrorBoundary>
      <Ilca6SelectionView />
    </ErrorBoundary>
  );
}
