import { and, eq, gte, inArray, or } from "drizzle-orm";
import { regattaResults, regattas } from "@/db/schema";

/** Coach workspaces may follow any sailor; personal drafts belong in the owner's logbook. */
export function coachWorkspaceResultsCondition(sailorIds: string[]) {
  return and(inArray(regattaResults.sailorId, sailorIds), eq(regattas.status, "published"));
}

/** Only publicly published events are suggested to signed-in users. */
export function workspaceUpcomingRegattasCondition(today: string) {
  return and(eq(regattas.status, "published"), or(gte(regattas.date, today), gte(regattas.endDate, today)));
}
