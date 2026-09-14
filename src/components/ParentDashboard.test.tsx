/** @vitest-environment jsdom */
import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { ParentDashboard } from "@/components/ParentDashboard";
import { FeedbackProvider } from "@/components/ui/FeedbackProvider";

const mockRouter = {
  replace: vi.fn(),
  push: vi.fn(),
  refresh: vi.fn(),
};

vi.mock("next/navigation", () => ({
  useRouter: () => mockRouter,
  usePathname: () => "/parent",
  useSearchParams: () => new URLSearchParams(),
}));

const mockFamilyData = {
  email: "parent@example.com",
  role: "parent",
  isParentStyle: true,
  athletes: [
    {
      id: "athlete-1",
      name: "Lucas Wong",
      handle: "lucas-wong",
      sailNumber: "SIN 4639",
      sailNumberIlca4: "SIN 221088",
      club: "Changi Sailing Club",
      school: "Raffles Institution",
      gender: "M",
      dob: "2012-05-14",
      currentFleet: "Gold",
      ownerRelation: "parent",
      nationalSquadStatus: "Nat A Candidate",
      avatarUrl: null,
      standing: {
        periodLabel: "Jul - Dec 2026",
        fleet: "Gold",
        overallRank: 3,
        fleetSize: 68,
        best3of5: 12,
        trendNote: "Best 3 of 4 scoring events",
      },
      selectionTrials: {
        rank: 3,
        nettScore: 38.0,
        eventsSailed: 2,
        isQualifiedAsian: true,
        isQualifiedPerth: true,
        asianTeamRank: 3,
        gapToCutoff: 0,
      },
      recentResults: [
        {
          regattaName: "Singapore National Youth Sailing Championships",
          regattaDate: "2026-03-15",
          rank: 2,
          boatClass: "Optimist",
        },
      ],
      primaryGear: [
        {
          id: "gear-1",
          category: "hull",
          brand: "Winner",
          model: "3D Star",
          label: "Hull #184491",
          condition: "good",
          status: "active",
          isPrimary: true,
        },
        {
          id: "gear-2",
          category: "sail",
          brand: "OneSails",
          model: "Medium",
          label: "Racing Sail",
          condition: "worn",
          status: "needs_attention",
          isPrimary: true,
        },
      ],
      equipmentAlertCount: 1,
      equipmentAlerts: [
        { label: "Racing Sail", reason: "Condition is worn — inspect before nationals" },
      ],
      coachFeedback: [
        {
          id: "cf-1",
          type: "observation",
          category: "starts",
          title: "Pin end acceleration in chop",
          detail: "Aggressive trigger pull at 8 seconds with clear wind.",
          recordDate: "2026-03-16",
          status: "active",
        },
      ],
      notes: [
        {
          id: "note-1",
          body: "[Training] Focused on roll tacks in light air.",
          createdAt: "2026-03-16T10:00:00Z",
        },
      ],
    },
    {
      id: "athlete-2",
      name: "Chloe Wong",
      handle: "chloe-wong",
      sailNumber: "SIN 3110",
      sailNumberIlca4: null,
      club: "Changi Sailing Club",
      school: "Raffles Girls' Primary School",
      gender: "F",
      dob: "2014-08-20",
      currentFleet: "Silver",
      ownerRelation: "parent",
      nationalSquadStatus: "Development Squad",
      avatarUrl: null,
      standing: {
        periodLabel: "Jul - Dec 2026",
        fleet: "Silver",
        overallRank: 8,
        fleetSize: 54,
        best3of5: 32,
        trendNote: "Best 3 of 3 scoring events",
      },
      selectionTrials: null,
      recentResults: [],
      primaryGear: [],
      equipmentAlertCount: 0,
      equipmentAlerts: [],
      coachFeedback: [],
      notes: [],
    },
  ],
  upcomingRegattas: [
    {
      id: "reg-1",
      name: "Singapore Youth Sailing Championships 2026",
      date: "2026-06-20",
      boatClass: "Optimist",
      division: "National",
      slug: "singapore-youth-2026",
    },
  ],
  pendingClaims: [],
};

describe("ParentDashboard", () => {
  beforeEach(() => {
    localStorage.clear();
    vi.stubGlobal(
      "fetch",
      vi.fn(async (url: string, init?: RequestInit) => {
        if (typeof url === "string" && url.includes("/api/account/family")) {
          return {
            ok: true,
            status: 200,
            json: async () => mockFamilyData,
          } as Response;
        }
        if (typeof url === "string" && url.includes("/api/account/parent-notes") && init?.method === "POST") {
          return {
            ok: true,
            status: 200,
            json: async () => ({
              note: {
                id: "note-new",
                body: JSON.parse(String(init.body)).body,
                createdAt: new Date().toISOString(),
              },
            }),
          } as Response;
        }
        return {
          ok: true,
          status: 200,
          json: async () => ({}),
        } as Response;
      })
    );
  });

  afterEach(() => {
    vi.unstubAllGlobals();
  });

  it("renders parent dashboard header, multi-athlete switcher, and athlete overview", async () => {
    render(
      <FeedbackProvider>
        <ParentDashboard />
      </FeedbackProvider>
    );

    // Initial loading indicator then header
    await waitFor(() => {
      expect(screen.getByText("Parent Dashboard")).toBeInTheDocument();
    });

    // Multi-athlete navigation buttons
    expect(screen.getByText(/All Athletes Summary/i)).toBeInTheDocument();
    expect(screen.getAllByText("Lucas Wong").length).toBeGreaterThanOrEqual(1);
    expect(screen.getByText("Chloe Wong")).toBeInTheDocument();

    // Default view is Lucas Wong (first athlete)
    expect(screen.getByText("Opti SIN 4639")).toBeInTheDocument();
    expect(screen.getByText("ILCA 4 SIN 221088")).toBeInTheDocument();
    expect(screen.getByText("Gold Fleet")).toBeInTheDocument();

    // Selection trials card
    expect(screen.getByText("2026 Selection Trials & Standings")).toBeInTheDocument();
    expect(screen.getAllByText("#3").length).toBeGreaterThanOrEqual(1); // trials rank & standing
    expect(screen.getByText(/Asian Games Team Candidate/i)).toBeInTheDocument();
    expect(screen.getByText(/Selected for Perth Camp/i)).toBeInTheDocument();

    // Equipment locker & alerts
    expect(screen.getByText("Boat Locker & Equipment")).toBeInTheDocument();
    expect(screen.getByText(/1 Equipment Alert/i)).toBeInTheDocument();
    expect(screen.getByText("Hull #184491")).toBeInTheDocument();

    // Coach development feedback
    expect(screen.getByText("Pin end acceleration in chop")).toBeInTheDocument();
    expect(screen.getByText("Aggressive trigger pull at 8 seconds with clear wind.")).toBeInTheDocument();

    // Pre-race checklist items
    expect(screen.getByText("Official class measurement certificate verified & onboard")).toBeInTheDocument();

    // Private notes
    expect(screen.getByText("Focused on roll tacks in light air.")).toBeInTheDocument();
  });

  it("switches to All Athletes Summary view and between athletes", async () => {
    const user = userEvent.setup();
    render(
      <FeedbackProvider>
        <ParentDashboard />
      </FeedbackProvider>
    );

    const summaryBtn = await screen.findByTestId("tab-all-summary");
    expect(summaryBtn).toBeInTheDocument();

    // Click "All Athletes Summary"
    await user.click(summaryBtn);

    // Both athletes should have overview cards in the summary
    const openBtns = await screen.findAllByRole("button", {
      name: /Open Dashboard/i,
    });
    expect(openBtns).toHaveLength(2);

    // Switch to Chloe Wong via the summary card
    await user.click(openBtns[1]);

    await waitFor(() => {
      expect(screen.getByText("Opti SIN 3110")).toBeInTheDocument();
    });
    expect(screen.queryByText("ILCA 4 SIN 221088")).not.toBeInTheDocument();
  });

  it("interacts with the morning race-day checklist", async () => {
    const user = userEvent.setup();
    render(
      <FeedbackProvider>
        <ParentDashboard />
      </FeedbackProvider>
    );

    await waitFor(() => {
      expect(screen.getByText("Official class measurement certificate verified & onboard")).toBeInTheDocument();
    });

    // Initially 0/5 ready
    expect(screen.getByText("0/5 ready")).toBeInTheDocument();

    // Click first checklist item
    const checkBtn = screen.getByText("Official class measurement certificate verified & onboard");
    await user.click(checkBtn);

    // Now 1/5 ready
    expect(screen.getByText("1/5 ready")).toBeInTheDocument();

    // Reset checklist
    const resetBtn = screen.getByTitle("Reset checklist");
    await user.click(resetBtn);
    expect(screen.getByText("0/5 ready")).toBeInTheDocument();
  });
});
