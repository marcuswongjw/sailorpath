import { ErrorBoundary } from "@/components/ErrorBoundary";
import { IlcaRankingsView } from "@/components/IlcaRankingsView";
import { DbOffline } from "@/components/DbOffline";
import {
  defaultIlcaIntake,
  getCachedIlcaRankings,
} from "@/lib/queries";
import { DbUnavailableError } from "@/db";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "ILCA 7 standings | SailorPath",
  description: "Singapore ILCA 7 standings computed using high ranking points and the best 3 of 5 events.",
};

export const revalidate = 60;

export default async function Ilca7StandingsPage() {
  const { kind, year } = defaultIlcaIntake();
  let errorMsg: string | null = null;
  let board: Awaited<ReturnType<typeof getCachedIlcaRankings>> | null = null;

  try {
    board = await getCachedIlcaRankings("ILCA 7", kind, year);
  } catch (e) {
    errorMsg = e instanceof DbUnavailableError ? e.message : "DB error";
  }

  if (errorMsg || !board) {
    return <DbOffline message={errorMsg || "DB error"} />;
  }

  return (
    <ErrorBoundary>
      <IlcaRankingsView
        boatClass="ILCA 7"
        initialRanked={board.ranked}
        initialIntakeKind={board.intakeKind}
        initialIntakeYear={board.intakeYear}
        initialLabel={board.label}
        initialAsOf={board.asOf}
      />
    </ErrorBoundary>
  );
}
