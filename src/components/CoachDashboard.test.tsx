/** @vitest-environment jsdom */
import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { afterEach, describe, expect, it, vi } from "vitest";
import { CoachDashboard } from "@/components/CoachDashboard";
import type { CoachSquadDashboard } from "@/lib/coachDashboard";

const initialData: CoachSquadDashboard = {
  squad: { id: "squad-1", name: "National youth" },
  period: { year: 2026, half: "Jul-Dec" },
  following: [],
  members: [
    {
      id: "member-1",
      sailorId: "sailor-1",
      name: "Alyssa Wong",
      handle: "alyssa-wong",
      sailNumber: "SGP 101",
      club: "Changi Sailing Club",
      avatarUrl: null,
      fleet: "Gold",
      ranking: 1,
      bestThreeOfFive: 4,
      squadStatus: "Nat A",
      recentMovement: 2,
      scoringEvents: [
        { regattaId: "r1", regattaName: "SAFYC", date: "2026-07-01", score: 1, selected: true, isDns: false, isOverseas: false },
        { regattaId: "r2", regattaName: "Pesta Sukan", date: "2026-08-01", score: 3, selected: true, isDns: false, isOverseas: false },
      ],
      recentResults: [{ resultId: "result-1", regattaName: "Pesta Sukan", regattaSlug: "pesta-sukan", date: "2026-08-01", rank: 1, nettScore: 6, fleetSize: 77, races: [{ raceNumber: 1, score: 1, code: null, discarded: false, rawValue: "1" }] }],
      coachNote: "Work on starts",
      selectionReadiness: { tone: "ready", label: "Ranking record established", detail: "Gold Fleet criteria apply." },
      latestResult: {
        regattaName: "Pesta Sukan",
        regattaSlug: "pesta-sukan",
        date: "2026-08-01",
        rank: 1,
        fleetSize: 77,
      },
    },
    {
      id: "member-2",
      sailorId: "sailor-2",
      name: "Kevin Ho",
      handle: "kevin-ho",
      sailNumber: "SGP 102",
      club: "National Sailing Centre",
      avatarUrl: null,
      fleet: "Gold",
      ranking: 3,
      bestThreeOfFive: 8,
      squadStatus: "Nat A",
      recentMovement: -1,
      scoringEvents: [],
      recentResults: [],
      coachNote: "",
      selectionReadiness: { tone: "watch", label: "Building selection record", detail: "More events required." },
      latestResult: null,
    },
  ],
};

afterEach(() => vi.restoreAllMocks());

describe("CoachDashboard", () => {
  it("shows live squad summaries and creates a same-fleet comparison link", async () => {
    const user = userEvent.setup();
    render(<CoachDashboard initialData={initialData} />);

    expect(screen.getByText("Latest: Pesta Sukan · #1 of 77")).toBeInTheDocument();
    expect(screen.getByText("6.0")).toBeInTheDocument();

    await user.click(screen.getByLabelText("Select Alyssa Wong for comparison"));
    await user.click(screen.getByLabelText("Select Kevin Ho for comparison"));
    expect(screen.getByRole("link", { name: /compare/i })).toHaveAttribute(
      "href",
      "/sg/optimist/compare?fleet=Gold&year=2026&half=Jul-Dec&a=sailor-1&b=sailor-2"
    );
  });

  it("searches for and adds a sailor", async () => {
    const added = {
      ...initialData,
      members: [
        ...initialData.members,
        {
          ...initialData.members[1],
          id: "member-3",
          sailorId: "sailor-3",
          name: "Kimberly Tan",
          handle: "kimberly-tan",
        },
      ],
    } satisfies CoachSquadDashboard;
    vi.spyOn(globalThis, "fetch")
      .mockResolvedValueOnce(
        new Response(
          JSON.stringify({
            sailors: [{ id: "sailor-3", name: "Kimberly Tan", handle: "kimberly-tan", sailNumber: "SGP 115", club: "Changi Sailing Club" }],
          }),
          { status: 200 }
        )
      )
      .mockResolvedValueOnce(new Response(JSON.stringify(added), { status: 201 }));

    const user = userEvent.setup();
    render(<CoachDashboard initialData={initialData} />);
    await user.type(screen.getByLabelText("Search sailors to add"), "Kim");
    await waitFor(() => expect(screen.getByRole("button", { name: /^Squad$/i })).toBeInTheDocument());
    await user.click(screen.getByRole("button", { name: /^Squad$/i }));
    await waitFor(() => expect(screen.getByRole("link", { name: "Kimberly Tan" })).toBeInTheDocument());
    expect(screen.getByRole("status")).toHaveTextContent("Sailor added");
  });

  it("opens the sailor detail drawer with counting scores and official races", async () => {
    const user = userEvent.setup();
    render(<CoachDashboard initialData={initialData} />);
    await user.click(screen.getByRole("button", { name: "Open Alyssa Wong details" }));
    expect(screen.getByRole("dialog", { name: /Alyssa Wong coach details/ })).toBeInTheDocument();
    expect(screen.getAllByText("Counting")).toHaveLength(2);
    expect(screen.getByText("R1: 1")).toBeInTheDocument();
    expect(screen.getByDisplayValue("Work on starts")).toBeInTheDocument();
  });

  it("saves a private coach note", async () => {
    vi.spyOn(globalThis, "fetch").mockResolvedValueOnce(new Response(JSON.stringify({ note: "Practice mark rounding" }), { status: 200 }));
    const user = userEvent.setup();
    render(<CoachDashboard initialData={initialData} />);
    await user.click(screen.getByRole("button", { name: "Open Alyssa Wong details" }));
    const note = screen.getByLabelText("Private coach note");
    await user.clear(note); await user.type(note, "Practice mark rounding");
    await user.click(screen.getByRole("button", { name: "Save note" }));
    await waitFor(() => expect(screen.getByRole("status")).toHaveTextContent("Private coach note saved"));
  });

  it("adds a search result to Following without adding it to the squad", async () => {
    const followed = { ...initialData, following: [{ ...initialData.members[1], id: "follow-1", sailorId: "sailor-3", name: "Kimberly Tan", handle: "kimberly-tan" }] } satisfies CoachSquadDashboard;
    vi.spyOn(globalThis, "fetch")
      .mockResolvedValueOnce(new Response(JSON.stringify({ sailors: [{ id: "sailor-3", name: "Kimberly Tan", handle: "kimberly-tan", sailNumber: "SGP 115", club: "SAF Yacht Club" }] }), { status: 200 }))
      .mockResolvedValueOnce(new Response(JSON.stringify(followed), { status: 201 }));
    const user = userEvent.setup();
    render(<CoachDashboard initialData={initialData} />);
    await user.type(screen.getByLabelText("Search sailors to add"), "Kim");
    await waitFor(() => expect(screen.getByRole("button", { name: "Follow" })).toBeInTheDocument());
    await user.click(screen.getByRole("button", { name: "Follow" }));
    await waitFor(() => expect(screen.getByText("1 sailor")).toBeInTheDocument());
    expect(screen.getByRole("status")).toHaveTextContent("added to Following");
  });
});
