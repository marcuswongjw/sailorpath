/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, it, vi } from "vitest";
import { AthleteDevelopmentDrawer } from "./AthleteDevelopmentDrawer";
import type { CoachSquadMember } from "@/lib/coachDashboard";

const mockSailor: CoachSquadMember = {
  id: "m1",
  sailorId: "s1",
  name: "Marcus Wong",
  handle: "marcus-wong",
  sailNumber: "SGP 4672",
  club: "Changi Sailing Club",
  avatarUrl: null,
  fleet: "Gold",
  ranking: 4,
  bestThreeOfFive: 14,
  squadStatus: "National Squad",
  recentMovement: 2,
  scoringEvents: [
    { regattaId: "r1", regattaName: "CSC Regatta", date: "2026-06-01", score: 2, selected: true, isDns: false, isOverseas: false },
    { regattaId: "r2", regattaName: "Raffles Marina Regatta", date: "2026-07-01", score: 5, selected: true, isDns: false, isOverseas: false },
  ],
  recentResults: [
    {
      resultId: "res1",
      regattaName: "CSC Regatta",
      regattaSlug: "csc-regatta",
      date: "2026-06-01",
      rank: 2,
      nettScore: 12,
      fleetSize: 68,
      races: [
        { raceNumber: 1, score: 2, code: null, discarded: false, rawValue: "2" },
        { raceNumber: 2, score: 1, code: null, discarded: false, rawValue: "1" },
      ],
    },
  ],
  coachNote: "Excellent tactical awareness in light air.",
  coachNoteVisibility: "coach_only",
  developmentRecords: [
    {
      id: "rec-1",
      type: "observation",
      category: "Starts",
      title: "Pin end acceleration",
      detail: "Clean jump at the 10-second signal",
      recordDate: "2026-08-10",
      status: "active",
      targetDate: null,
      visibility: "shared",
      sentiment: "strength",
    },
    {
      id: "rec-2",
      type: "goal",
      category: null,
      title: "Improve downwind gybe angles",
      detail: "Avoid over-steering in rolling waves",
      recordDate: "2026-08-12",
      status: "active",
      targetDate: "2026-10-01",
      visibility: "coach_only",
      sentiment: "neutral",
    },
  ],
  selectionReadiness: {
    tone: "ready",
    label: "Ranking record established",
    detail: "Gold Fleet criteria met.",
  },
  latestResult: {
    regattaName: "CSC Regatta",
    regattaSlug: "csc-regatta",
    date: "2026-06-01",
    rank: 2,
    fleetSize: 68,
  },
};

describe("AthleteDevelopmentDrawer", () => {
  it("renders sailor identity, scores, and existing shared/private records", () => {
    render(
      <AthleteDevelopmentDrawer
        sailor={mockSailor}
        onClose={vi.fn()}
        onSaveNote={vi.fn()}
        onAddRecord={vi.fn()}
        busyId={null}
      />
    );

    expect(screen.getByText("Marcus Wong")).toBeInTheDocument();
    expect(screen.getByText("Gold #4")).toBeInTheDocument();
    expect(screen.getByText("SGP 4672 · Changi Sailing Club")).toBeInTheDocument();
    expect(screen.getAllByText("Counting")).toHaveLength(2);
    expect(screen.getByText("Pin end acceleration")).toBeInTheDocument();
    expect(screen.getByText("Shared with Family")).toBeInTheDocument();
    expect(screen.getAllByText("Coach Only").length).toBeGreaterThanOrEqual(1);
    expect(screen.getByDisplayValue("Excellent tactical awareness in light air.")).toBeInTheDocument();
  });

  it("submits a shared coaching observation with sentiment tag", async () => {
    const user = userEvent.setup();
    const handleAddRecord = vi.fn().mockResolvedValue(undefined);

    render(
      <AthleteDevelopmentDrawer
        sailor={mockSailor}
        onClose={vi.fn()}
        onSaveNote={vi.fn()}
        onAddRecord={handleAddRecord}
        busyId={null}
      />
    );

    // Toggle sharing to Shared with Family
    await user.click(screen.getAllByRole("button", { name: /Share with Family/i })[0]);

    // Select Focus Area sentiment
    await user.click(screen.getAllByRole("button", { name: /Focus Area/i })[0]);

    // Fill title and detail
    await user.type(screen.getByLabelText("Record title"), "Late mark rounding trim");
    await user.type(screen.getByLabelText("Record detail"), "Need faster mainsheet release");

    // Submit
    await user.click(screen.getByRole("button", { name: "Add coaching record" }));

    expect(handleAddRecord).toHaveBeenCalledWith(
      expect.objectContaining({
        type: "observation",
        category: "Starts",
        title: "Late mark rounding trim",
        detail: "Need faster mainsheet release",
        visibility: "shared",
        sentiment: "focus",
      })
    );
  });

  it("saves coach note with selective sharing toggle", async () => {
    const user = userEvent.setup();
    const handleSaveNote = vi.fn().mockResolvedValue(undefined);

    render(
      <AthleteDevelopmentDrawer
        sailor={mockSailor}
        onClose={vi.fn()}
        onSaveNote={handleSaveNote}
        onAddRecord={vi.fn()}
        busyId={null}
      />
    );

    // Toggle sharing on coach note
    const shareFamilyButtons = screen.getAllByRole("button", { name: /Share with Family/i });
    // Note sharing button is the second one
    await user.click(shareFamilyButtons[shareFamilyButtons.length - 1]);

    const noteTextarea = screen.getByLabelText("Private coach note");
    await user.clear(noteTextarea);
    await user.type(noteTextarea, "Great improvement on port tack laylines.");

    await user.click(screen.getByRole("button", { name: "Save note" }));

    expect(handleSaveNote).toHaveBeenCalledWith(
      "Great improvement on port tack laylines.",
      "shared"
    );
  });
});
