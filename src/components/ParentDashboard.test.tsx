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

  it("renders parent dashboard header, multi-athlete switcher, and tabbed athlete workspace", async () => {
    const user = userEvent.setup();
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

    // Default view is Lucas Wong (Overview tab active)
    expect(screen.getByText("Opti SIN 4639")).toBeInTheDocument();
    expect(screen.getByText("ILCA 4 SIN 221088")).toBeInTheDocument();
    expect(screen.getByText("SG Gold")).toBeInTheDocument();

    // Actionable equipment alert jump & Overview cards (Selection Trial + Recent Results)
    expect(screen.getByText(/1 equipment alert requires attention/i)).toBeInTheDocument();
    expect(screen.queryByText(/Why this place/i)).not.toBeInTheDocument();
    expect(screen.getByText("Selection Trial")).toBeInTheDocument();
    expect(screen.getByText("Selected")).toBeInTheDocument();
    expect(screen.getByText(/Asian Games & Perth Camp/i)).toBeInTheDocument();
    expect(screen.getByText("SG Gold #3")).toBeInTheDocument();
    expect(screen.getByText("Recent Results")).toBeInTheDocument();
    expect(screen.getByText("Singapore National Youth Sailing Championships")).toBeInTheDocument();
    expect(screen.getByText("#2")).toBeInTheDocument();

    // Gear & Prep content is hidden on Overview until selected
    expect(screen.queryByText("Boat Locker")).not.toBeInTheDocument();

    // Switch to Gear & Prep via the alert CTA
    await user.click(screen.getByRole("button", { name: /Review Gear & Prep/i }));

    expect(screen.getByText("Boat Locker")).toBeInTheDocument();
    expect(screen.getByText(/1 Equipment Alert/i)).toBeInTheDocument();
    expect(screen.getByText("Hull #184491")).toBeInTheDocument();
    expect(screen.getByText("Winner 3D Star")).toBeInTheDocument();
    expect(screen.getByText("Measurement certificate & sail numbers checked")).toBeInTheDocument();
    expect(screen.getByText("Spares kit (battens, sail ties, wind indicator)")).toBeInTheDocument();

    // Switch to Coach & Notes tab
    await user.click(screen.getByRole("tab", { name: /Coach & Notes/i }));

    expect(screen.getByText("Pin end acceleration in chop")).toBeInTheDocument();
    expect(screen.getByText("Aggressive trigger pull at 8 seconds with clear wind.")).toBeInTheDocument();
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

  it("interacts with the morning race-day checklist and adds custom item", async () => {
    const user = userEvent.setup();
    render(
      <FeedbackProvider>
        <ParentDashboard />
      </FeedbackProvider>
    );

    const gearTab = await screen.findByRole("tab", { name: /Gear & Prep/i });
    await user.click(gearTab);

    await waitFor(() => {
      expect(screen.getByText("Measurement certificate & sail numbers checked")).toBeInTheDocument();
    });

    // Initially 0/4 ready
    expect(screen.getByText("0/4 ready")).toBeInTheDocument();

    // Click first checklist item
    const checkBtn = screen.getByText("Measurement certificate & sail numbers checked");
    await user.click(checkBtn);

    // Now 1/4 ready
    expect(screen.getByText("1/4 ready")).toBeInTheDocument();

    // Add a custom checklist item
    const customInput = screen.getByPlaceholderText(/add race prep item/i);
    await user.type(customInput, "Extra electrolyte bottle");
    const addBtn = screen.getByRole("button", { name: /^add$/i });
    await user.click(addBtn);

    expect(screen.getByText("Extra electrolyte bottle")).toBeInTheDocument();
    expect(screen.getByText("1/5 ready")).toBeInTheDocument();

    // Check off the newly added item
    const customItemBtn = screen.getByText("Extra electrolyte bottle");
    await user.click(customItemBtn);
    expect(screen.getByText("2/5 ready")).toBeInTheDocument();

    // Reset checklist
    const resetBtn = screen.getByTitle("Reset checklist");
    await user.click(resetBtn);
    expect(screen.getByText("0/5 ready")).toBeInTheDocument();
  });

  it("supports in-place equipment management and opens preset modal in Card B", async () => {
    const user = userEvent.setup();

    render(
      <FeedbackProvider>
        <ParentDashboard />
      </FeedbackProvider>
    );

    const gearTab = await screen.findByRole("tab", { name: /Gear & Prep/i });
    await user.click(gearTab);

    await waitFor(() => {
      expect(screen.getByText("Boat Locker")).toBeInTheDocument();
    });

    // Verify gear item and condition are rendered
    expect(screen.getByText(/Hull #184491/i)).toBeInTheDocument();
    expect(screen.getByText("Race Ready")).toBeInTheDocument();

    // Click Add Equipment button
    const addGearBtn = screen.getByRole("button", { name: /add equipment/i });
    expect(addGearBtn).toBeInTheDocument();
    await user.click(addGearBtn);

    // Modal opens with youth gear presets in a native <dialog>
    const gearTitle = screen.getByText("Add Equipment to Locker");
    const dialog = gearTitle.closest("dialog")!;
    expect(dialog).toHaveAttribute("open");
    expect(dialog).toHaveAttribute("closedby", "any");
    expect(dialog).not.toHaveAttribute("role");
    expect(dialog).not.toHaveAttribute("aria-modal");
    expect(screen.getByText(/1-Click Popular Presets/i)).toBeInTheDocument();
    expect(screen.getByText(/Optimax Mk3 Rig/i)).toBeInTheDocument();

    // Switch to custom tab
    const customTab = screen.getByRole("button", { name: /custom gear/i });
    await user.click(customTab);
    expect(screen.getByText("Equipment Category")).toBeInTheDocument();
    expect(screen.getByText("Brand / Maker")).toBeInTheDocument();
  });
});

