/** @vitest-environment jsdom */
import { describe, expect, it, vi, beforeEach, afterEach } from "vitest";
import { render, screen, renderHook, act } from "@testing-library/react";
import { FeedbackProvider } from "@/components/ui/FeedbackProvider";
import { CalendarEventForm } from "./CalendarEventForm";
import { AdminResultsPanel } from "./AdminResultsPanel";
import { useAdminRegattas } from "./useAdminRegattas";
import { regattaToClassForm } from "./adminForms";
import type { RegattaAdmin } from "@/types/regatta";
import type { SailorAdmin } from "@/types/sailor";
import type { ResultAdmin } from "@/types/result";

const saved: RegattaAdmin = {
  id: "class-1",
  name: "Raffles Marina ILCA 4",
  slug: "raffles-ilca-4",
  date: "2026-08-01",
  totalFleetSize: 50,
  division: "Open",
  raceCount: 7,
  geography: "SGP",
  boatClass: "ILCA 4",
  countsForRanking: true,
  isSelectionTrial: true,
  selectionEventId: "ilca4-pesta-2026",
  eventId: "event-1",
  status: "published",
};

describe("CalendarEventForm", () => {
  it("keeps selection trials and ranking eligibility off the weekend form", () => {
    render(
      <CalendarEventForm
        showCalendarForm
        calendarSaving={false}
        handleSaveCalendar={vi.fn()}
        setShowCalendarForm={vi.fn()}
        calendarForm={{
          name: "Pesta Sukan",
          startDate: "2026-08-01",
          endDate: "2026-08-02",
          venue: "Raffles Marina",
          organizer: "SSC",
          classes: "ILCA 4",
          norUrl: "",
          registrationUrl: "",
          keyDeadlines: "",
          scheduleSummary: "Knockout series at the yacht club.",
          scoringRules: "Appendix MR applies.",
          countsForRanking: true,
        }}
        setCalendarForm={vi.fn()}
      />
    );

    expect(screen.queryByText(/official selection trial/i)).not.toBeInTheDocument();
    expect(screen.queryByText(/ranking regatta/i)).not.toBeInTheDocument();
    expect(
      screen.getByText(
        /singapore national ranking eligibility is managed on each class results sheet/i
      )
    ).toBeInTheDocument();
    expect(screen.getByLabelText("Description")).toHaveValue(
      "Knockout series at the yacht club."
    );
    expect(screen.getByLabelText("Scoring")).toHaveValue("Appendix MR applies.");
  });
});

describe("AdminResultsPanel", () => {
  it("shows race columns without a per-sailor finishes dropdown", () => {
    const result: ResultAdmin = {
      id: "result-1",
      sailorId: "sailor-1",
      regattaId: "class-1",
      rank: 1,
      nettScore: 4,
      totalScore: 4,
      raceResults: [
        { raceNumber: 1, score: 1, scoringCode: null, discarded: false, rawValue: "1.0" },
        { raceNumber: 2, score: 1, scoringCode: null, discarded: false, rawValue: "1.0" },
      ],
    };

    render(
      <AdminResultsPanel
        embedded
        isSuperadmin
        sailorList={[{ id: "sailor-1", name: "Ian Goh", sailNumber: "222713", gender: "M" } as SailorAdmin]}
        regattaList={[saved]}
        resultsList={[result]}
        selectedRegattaIdForResultEdit="class-1"
        setSelectedRegattaIdForResultEdit={vi.fn()}
        editingResultId={null}
        setEditingResultId={vi.fn()}
        resultForm={{
          id: "",
          regattaId: "class-1",
          sailorId: "",
          rank: 1,
          nettScore: "",
          totalScore: "",
          isDNS: false,
          isOverseasCommitment: false,
        }}
        setResultForm={vi.fn()}
        saving={false}
        handleSaveResult={vi.fn()}
        handleDeleteResult={vi.fn()}
      />
    );

    expect(screen.getByText("Ian Goh")).toBeInTheDocument();
    expect(screen.getByText("R1")).toBeInTheDocument();
    expect(screen.getAllByText("1.0")).toHaveLength(2);
    expect(screen.queryByText(/official race finishes/i)).not.toBeInTheDocument();
    expect(screen.queryByTitle(/individual race finishes/i)).not.toBeInTheDocument();
  });

  it("flags a blank nett DNS in last place for the admin", () => {
    const results: ResultAdmin[] = [
      {
        id: "winner",
        sailorId: "sailor-1",
        regattaId: "class-1",
        rank: 1,
        nettScore: 8,
        isDns: false,
      },
      {
        id: "blank",
        sailorId: "sailor-2",
        regattaId: "class-1",
        rank: 11,
        nettScore: null,
        isDns: true,
      },
    ];

    render(
      <AdminResultsPanel
        embedded
        isSuperadmin
        sailorList={[
          { id: "sailor-1", name: "Ian Goh", sailNumber: "222713", gender: "M" } as SailorAdmin,
          { id: "sailor-2", name: "Ben Tan", sailNumber: "111", gender: "M" } as SailorAdmin,
        ]}
        regattaList={[saved]}
        resultsList={results}
        selectedRegattaIdForResultEdit="class-1"
        setSelectedRegattaIdForResultEdit={vi.fn()}
        editingResultId={null}
        setEditingResultId={vi.fn()}
        resultForm={{
          id: "",
          regattaId: "class-1",
          sailorId: "",
          rank: 1,
          nettScore: "",
          totalScore: "",
          isDNS: false,
          isOverseasCommitment: false,
        }}
        setResultForm={vi.fn()}
        saving={false}
        handleSaveResult={vi.fn()}
        handleDeleteResult={vi.fn()}
      />
    );

    expect(screen.getByText(/Blank nett to review: Ben Tan/)).toBeInTheDocument();
  });
});

describe("useAdminRegattas save snapshot", () => {
  beforeEach(() => {
    vi.stubGlobal(
      "fetch",
      vi.fn(async () => ({
        ok: true,
        text: async () => JSON.stringify({ regatta: { ...saved, totalFleetSize: 40 } }),
      }))
    );
  });

  afterEach(() => {
    vi.unstubAllGlobals();
  });

  it("treats a saved class form as clean", async () => {
    const { result } = renderHook(
      () =>
        useAdminRegattas({
          isSuperadmin: true,
          regattaList: [saved],
          setRegattaList: vi.fn(),
          resultsList: [],
          setResultsList: vi.fn(),
          selectedRegattaIdForResultEdit: "class-1",
          setSelectedRegattaIdForResultEdit: vi.fn(),
        }),
      { wrapper: FeedbackProvider }
    );

    act(() => {
      result.current.panelProps.setEditingRegattaId("class-1");
      const opened = regattaToClassForm(saved);
      result.current.panelProps.setRegattaForm({ ...opened, totalFleetSize: "40" });
      result.current.panelProps.setClassSnap(JSON.stringify(opened));
    });

    await act(async () => {
      await result.current.panelProps.handleSaveRegatta();
    });

    expect(result.current.panelProps.classSnap).toBe(
      JSON.stringify(result.current.panelProps.regattaForm)
    );
    expect(result.current.panelProps.regattaForm.selectionEventId).toBe("ilca4-pesta-2026");
    expect(result.current.panelProps.regattaForm.eventId).toBe("event-1");
  });
});
