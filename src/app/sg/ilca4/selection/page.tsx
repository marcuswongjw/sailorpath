import { ErrorBoundary } from "@/components/ErrorBoundary";
import { IlcaSelectionView } from "@/components/selection/IlcaSelectionView";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "ILCA 4 Selection Trials & Squad Policies 2026 | SailorPath",
  description:
    "Official Singapore ILCA 4 selection policies, international trial criteria (Eastern Seaboard, Asian Open 2026), and National Junior Training Squad (NJTS) regulations.",
};

import { getAuthContext } from "@/lib/auth";
import { ILCA4_SELECTION_SAILORS } from "@/lib/ilcaSelectionData";

export default async function IlcaSelectionPage() {
  const auth = await getAuthContext().catch(() => null);
  const isAuthenticated = Boolean(auth);

  return (
    <ErrorBoundary>
      <IlcaSelectionView
        isAuthenticated={isAuthenticated}
        initialSailors={isAuthenticated ? ILCA4_SELECTION_SAILORS : []}
      />
    </ErrorBoundary>
  );
}

