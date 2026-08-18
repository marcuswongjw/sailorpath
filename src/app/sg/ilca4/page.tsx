import { ErrorBoundary } from "@/components/ErrorBoundary";
import { IlcaRankingsView } from "@/components/IlcaRankingsView";
import { DbOffline } from "@/components/DbOffline";
import {
  defaultIlcaIntake,
  getCachedIlcaRankings,
} from "@/lib/queries";
import { DbUnavailableError } from "@/db";

/** ISR — shared with getCachedIlcaRankings (tagged; busted after import). */
export const revalidate = 60;

export default async function Ilca4StandingsPage() {
  const { kind, year } = defaultIlcaIntake();
  let errorMsg: string | null = null;
  let board: Awaited<ReturnType<typeof getCachedIlcaRankings>> | null = null;

  try {
    board = await getCachedIlcaRankings("ILCA 4", kind, year);
  } catch (e) {
    errorMsg = e instanceof DbUnavailableError ? e.message : "DB error";
  }

  if (errorMsg || !board) {
    return <DbOffline message={errorMsg || "DB error"} />;
  }

  return (
    <ErrorBoundary>
      <IlcaRankingsView
        initialRanked={board.ranked}
        initialIntakeKind={board.intakeKind}
        initialIntakeYear={board.intakeYear}
        initialLabel={board.label}
        initialAsOf={board.asOf}
      />
    </ErrorBoundary>
  );
}
