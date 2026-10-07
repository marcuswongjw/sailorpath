/** @vitest-environment jsdom */
import { render, screen, fireEvent } from "@testing-library/react";
import { describe, it, expect, vi, beforeEach } from "vitest";
import { RegattaCalendarClient } from "./RegattaCalendarClient";
import type { RegattaRecord } from "@/lib/ranking";

const mockRouter = {
  push: vi.fn(),
  replace: vi.fn(),
  refresh: vi.fn(),
};

vi.mock("next/navigation", () => ({
  useRouter: () => mockRouter,
  usePathname: () => "/calendar",
  useSearchParams: () => new URLSearchParams(),
}));

const mockUseAccount = vi.fn();
vi.mock("@/components/AccountProvider", () => ({
  useAccount: () => mockUseAccount(),
}));

const mockEvents: RegattaRecord[] = [
  {
    id: "reg-1",
    name: "Singapore National Sailing Championships 2099",
    slug: "singapore-national-sailing-championships-2099",
    date: "2099-06-19",
    endDate: "2099-06-22",
    boatClass: "Optimist",
    division: "Gold",
    venue: "National Sailing Centre",
    organizer: "Singapore Sailing Federation",
    norUrl: "https://singaporesailing.org/nor/snsc-2099.pdf",
    registrationUrl: "https://singaporesailing.org/events/snsc-2099",
    isSelectionTrial: true,
    scheduleNotes: "Official selection trial for World Championship team",
    totalFleetSize: 85,
    countsForRanking: true,
    region: "Singapore",
  },
  {
    id: "reg-2",
    name: "ILCA Singapore Open 2099",
    slug: "ilca-singapore-open-2099",
    date: "2099-07-10",
    endDate: "2099-07-12",
    boatClass: "ILCA 4",
    division: "Both",
    venue: "Changi Sailing Club",
    organizer: "Changi Sailing Club",
    norUrl: "https://csc.org.sg/nor-ilca-2099.pdf",
    isSelectionTrial: false,
    scheduleNotes: "Annual open ranking event",
    totalFleetSize: 42,
    countsForRanking: true,
    region: "Singapore",
  },
  {
    id: "reg-3",
    name: "Past Regatta 2020",
    slug: "past-regatta-2020",
    date: "2020-01-15",
    endDate: "2020-01-16",
    boatClass: "WingFoil",
    division: "Both",
    venue: "East Coast Park",
    organizer: "SSF",
    isSelectionTrial: false,
    totalFleetSize: 20,
    countsForRanking: true,
    region: "Singapore",
  },
  {
    id: "reg-4",
    name: "Eastern Seaboard Regatta 2099",
    slug: "eastern-seaboard-regatta-2099",
    date: "2099-10-29",
    endDate: "2099-10-31",
    boatClass: "Optimist",
    venue: "Royal Varuna Yacht Club, Pattaya, Thailand",
    organizer: "RVYC",
    isSelectionTrial: false,
    region: "Asia",
    campaignBudget: {
      totalEstimatedSgd: 2736,
      regattaCostsLabel: "THB 12,500 (~SGD 486) — Entry THB 4.5k, Charter THB 8k",
      clinicLabel: "THB 6,000 (~SGD 233) — 3-day tuning clinic",
      flightsLabel: "SGD 550 — Return flights for 2 pax",
      lodgingLabel: "THB 22,000 (~SGD 855) — 5 nights hotel",
      notes: "Drive time approx 1.5h from BKK airport.",
    },
    totalFleetSize: 90,
    countsForRanking: false,
  },
];

describe("RegattaCalendarClient", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    sessionStorage.clear();
    mockUseAccount.mockReturnValue({
      email: "sailor@example.com",
      ready: true,
      role: "member",
      isSuperadmin: false,
      owned: [],
      signOut: vi.fn(),
    });
  });

  it("allows visitors to browse without signing in", () => {
    mockUseAccount.mockReturnValue({
      email: null,
      ready: true,
      role: null,
      isSuperadmin: false,
      owned: [],
      signOut: vi.fn(),
    });

    render(<RegattaCalendarClient regattas={mockEvents} />);

    expect(screen.getByRole("heading", { name: "Regattas" })).toBeInTheDocument();
    expect(screen.getByPlaceholderText(/search regattas or venues/i)).toBeInTheDocument();
  });

  it("does not delay browsing while account auth initializes", () => {
    mockUseAccount.mockReturnValue({
      email: null,
      ready: false,
      role: null,
      isSuperadmin: false,
      owned: [],
      signOut: vi.fn(),
    });

    render(<RegattaCalendarClient regattas={mockEvents} />);

    expect(screen.getByRole("heading", { name: "Regattas" })).toBeInTheDocument();
  });

  it("renders calendar events and initial view when logged in", () => {
    render(<RegattaCalendarClient regattas={mockEvents} />);

    expect(screen.getByText("Regattas")).toBeInTheDocument();
    expect(screen.getByPlaceholderText(/search regattas or venues/i)).toBeInTheDocument();
    expect(screen.getByText("Singapore National Sailing Championships 2099")).toBeInTheDocument();
    expect(screen.getByText("ILCA Singapore Open 2099")).toBeInTheDocument();
    expect(screen.getByText("Eastern Seaboard Regatta 2099")).toBeInTheDocument();
    expect(screen.queryByText(/official selection trial for world championship team/i)).not.toBeInTheDocument();
    expect(screen.queryByText("Ranking Regatta")).not.toBeInTheDocument();
    expect(screen.queryByText("National Series Ranking")).not.toBeInTheDocument();
    expect(screen.getByRole("link", { name: "ILCA Singapore Open 2099" })).toHaveAttribute(
      "href",
      "/regattas/ilca-singapore-open-2099"
    );
    expect(
      screen.getByRole("link", { name: "Singapore National Sailing Championships 2099" })
    ).toHaveAttribute("href", "/regattas/singapore-national-sailing-championships-2099");
  });

  it("shows ranking status on matching class results, never on the event", () => {
    const result = { ...mockEvents[0], geography: "SG", raceCount: 3 };
    render(<RegattaCalendarClient regattas={mockEvents} resultSheetsByEvent={{ [result.slug]: [result, { ...result, id: "wing", boatClass: "WingFoil" }] }} initialClass="optimist" />);
    expect(screen.getByText("Counts for Singapore national ranking")).toBeInTheDocument();
    expect(screen.queryByText(/WingFoil.*results/)).not.toBeInTheDocument();
    expect(screen.queryByText("Ranking Regatta")).not.toBeInTheDocument();
  });

  it("preserves filters in the return address", () => {
    render(<RegattaCalendarClient regattas={mockEvents} />);
    fireEvent.click(screen.getByRole("button", { name: /^ILCA 4$/i }));
    fireEvent.change(screen.getByPlaceholderText(/search regattas or venues/i), { target: { value: "Changi" } });
    expect(location.search).toContain("class=ilca4");
    expect(location.search).toContain("q=Changi");
  });

  it("filters events when typing in search", () => {
    render(<RegattaCalendarClient regattas={mockEvents} />);

    const searchInput = screen.getByPlaceholderText(/search regattas or venues/i);
    fireEvent.change(searchInput, { target: { value: "Changi" } });

    expect(screen.queryByText("Singapore National Sailing Championships 2099")).not.toBeInTheDocument();
    expect(screen.getByText("ILCA Singapore Open 2099")).toBeInTheDocument();
  });

  it("filters events by boat class", () => {
    render(<RegattaCalendarClient regattas={mockEvents} />);

    const ilcaButton = screen.getByRole("button", { name: /^ILCA 4$/i });
    fireEvent.click(ilcaButton);

    expect(screen.queryByText("Singapore National Sailing Championships 2099")).not.toBeInTheDocument();
    expect(screen.getByText("ILCA Singapore Open 2099")).toBeInTheDocument();
  });

  it("filters events by region", () => {
    render(<RegattaCalendarClient regattas={mockEvents} />);

    const asiaButton = screen.getByRole("button", { name: /🌏 Asia/i });
    fireEvent.click(asiaButton);

    expect(screen.getByText("Eastern Seaboard Regatta 2099")).toBeInTheDocument();
    expect(screen.queryByText("Singapore National Sailing Championships 2099")).not.toBeInTheDocument();
    expect(screen.queryByText("ILCA Singapore Open 2099")).not.toBeInTheDocument();
  });

  it("filters events by selection trial toggle", () => {
    render(<RegattaCalendarClient regattas={mockEvents} />);

    const trialsToggle = screen.getByRole("button", { name: /selection trials only/i });
    fireEvent.click(trialsToggle);

    expect(screen.getByText("Singapore National Sailing Championships 2099")).toBeInTheDocument();
    expect(screen.queryByText("ILCA Singapore Open 2099")).not.toBeInTheDocument();
    expect(screen.queryByText("Eastern Seaboard Regatta 2099")).not.toBeInTheDocument();
  });

  it("renders Notice of Race and Registration action links", () => {
    render(<RegattaCalendarClient regattas={mockEvents} />);

    const norLinks = screen.getAllByRole("link", { name: /notice of race/i });
    expect(norLinks.length).toBeGreaterThan(0);
    expect(norLinks[0]).toHaveAttribute("href", "https://singaporesailing.org/nor/snsc-2099.pdf");

    const registerLink = screen.getByRole("link", { name: /register \/ enter/i });
    expect(registerLink).toHaveAttribute("href", "https://singaporesailing.org/events/snsc-2099");
  });

  it("renders Official Notice Board link for racingrulesofsailing portals", () => {
    const onbEvents: RegattaRecord[] = [
      {
        ...mockEvents[0],
        id: "reg-onb",
        norUrl: "https://www.racingrulesofsailing.org/documents/14487/event",
      },
    ];
    render(<RegattaCalendarClient regattas={onbEvents} />);

    const onbLink = screen.getByRole("link", { name: /official notice board/i });
    expect(onbLink).toBeInTheDocument();
    expect(onbLink).toHaveAttribute("href", "https://www.racingrulesofsailing.org/documents/14487/event");
  });

  it("toggles between upcoming regattas and past regattas", () => {
    render(<RegattaCalendarClient regattas={mockEvents} />);

    const pastTab = screen.getByRole("button", { name: /past regattas/i });
    fireEvent.click(pastTab);

    expect(screen.getByText("Past Regatta 2020")).toBeInTheDocument();
    expect(screen.queryByText("Singapore National Sailing Championships 2099")).not.toBeInTheDocument();
    expect(screen.getByRole("link", { name: "Past Regatta 2020" })).toHaveAttribute(
      "href",
      "/regattas/past-regatta-2020?calendar=past"
    );
  });

  it("restores the past tab from the calendar address", () => {
    render(
      <RegattaCalendarClient
        regattas={mockEvents}
        initialTimelineTab="past"
      />
    );

    expect(screen.getByText("Past Regatta 2020")).toBeInTheDocument();
    expect(screen.queryByText("Singapore National Sailing Championships 2099")).not.toBeInTheDocument();
  });
});
