export type EventUrlDraft = {
  name: string; startDate: string; endDate: string; venue: string;
  organizer: string; classes: string; norUrl: string; registrationUrl: string;
  scheduleSummary: string; sourceUrl: string;
};
export const emptyEventUrlDraft = (): EventUrlDraft => ({ name: "", startDate: "", endDate: "", venue: "", organizer: "", classes: "", norUrl: "", registrationUrl: "", scheduleSummary: "", sourceUrl: "" });
import type { RegattaEventSaveBody } from "@/lib/admin/regattaDuplicate";


/** A duplicate-update decision keeps the existing event's other metadata. */
export function calendarDraftSaveBody(body: RegattaEventSaveBody, draft: EventUrlDraft) {
  return body.create === false ? body : { ...body, organizer: draft.organizer, classes: draft.classes, norUrl: draft.norUrl, registrationUrl: draft.registrationUrl, scheduleSummary: draft.scheduleSummary };
}
