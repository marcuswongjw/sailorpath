import { resultSourceStatus } from "@/lib/resultCardStatus";
import type { RegattaRecord } from "@/lib/ranking";

/** Keep source finality distinct from publication on SailorPath. */
export function ResultStatus({ regatta }: { regatta: Pick<RegattaRecord, "name" | "scheduleNotes" | "officialResultsSourceName"> }) {
  return (
    <div className="flex flex-wrap gap-x-4 gap-y-1 text-sm leading-6">
      <p className="font-semibold text-harbour-shadow">{resultSourceStatus(regatta)}</p>
      <p className="text-slate-soft">SailorPath: Published record</p>
    </div>
  );
}
