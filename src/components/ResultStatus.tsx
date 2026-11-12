import { resultSourceStatus } from "@/lib/resultCardStatus";
import type { RegattaRecord } from "@/lib/ranking";

/** Keep source finality distinct from publication on SailorPath. */
export function ResultStatus({ regatta }: { regatta: Pick<RegattaRecord, "name" | "scheduleNotes" | "officialResultsSourceName"> }) {
  return (
    <p className="text-xs sm:text-sm font-semibold text-harbour-shadow">
      {resultSourceStatus(regatta)}
    </p>
  );
}
