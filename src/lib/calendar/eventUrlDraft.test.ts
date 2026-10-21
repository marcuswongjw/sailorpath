import { describe, expect, it } from "vitest";
import { calendarDraftSaveBody, emptyEventUrlDraft } from "./eventUrlDraft";
const body = { create: true, slug: "cup", name: "Cup", startDate: "2026-11-01", endDate: "2026-11-03", venue: "Club", classes: "", countsForRanking: true };
describe("extracted event save payload", () => {
  it("retains the reviewed metadata when creating the public calendar event", () => {
    const draft = { ...emptyEventUrlDraft(), organizer: "Official Club", classes: "Optimist, ILCA 4", norUrl: "https://club.example/nor", registrationUrl: "https://club.example/register", scheduleSummary: "Three days of racing" };
    expect(calendarDraftSaveBody(body, draft)).toMatchObject({ organizer: draft.organizer, classes: draft.classes, norUrl: draft.norUrl, registrationUrl: draft.registrationUrl, scheduleSummary: draft.scheduleSummary });
  });
  it("preserves metadata when the admin chooses the existing duplicate-update flow", () => {
    const update = { ...body, create: false, keepUnspecified: true, classes: "ILCA 6" };
    expect(calendarDraftSaveBody(update, { ...emptyEventUrlDraft(), classes: "Optimist" })).toEqual(update);
  });
});
