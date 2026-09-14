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
    mockUseAccount.mockReturnValue({
      email: "sailor@example.com",
      ready: true,
      role: "member",
      isSuperadmin: false,
      owned: [],
      signOut: vi.fn(),
    });
  });

  it("renders member access gate when user is not logged in", () => {
    mockUseAccount.mockReturnValue({
      email: null,
      ready: true,
      role: null,
      isSuperadmin: false,
      owned: [],
      signOut: vi.fn(),
    });

    render(<RegattaCalendarClient regattas={mockEvents} />);

    expect(screen.getByText("2026–2027 Regatta & Campaign Calendar")).toBeInTheDocument();
    expect(screen.getByRole("link", { name: /sign in to view calendar/i })).toBeInTheDocument();
    expect(screen.getByRole("link", { name: /create free account/i })).toBeInTheDocument();
    expect(screen.queryByPlaceholderText(/search regattas or venues/i)).not.toBeInTheDocument();
  });

  it("renders loading indicator while account auth is initializing", () => {
    mockUseAccount.mockReturnValue({
      email: null,
      ready: false,
      role: null,
      isSuperadmin: false,
      owned: [],
      signOut: vi.fn(),
    });

    render(<RegattaCalendarClient regattas={mockEvents} />);

    expect(screen.getByText(/verifying member access/i)).toBeInTheDocument();
  });

  it("renders calendar events and initial view when logged in", () => {
    render(<RegattaCalendarClient regattas={mockEvents} />);

    expect(screen.getByText("Singapore & International Regatta Calendar")).toBeInTheDocument();
    expect(screen.getByPlaceholderText(/search regattas or venues/i)).toBeInTheDocument();
    expect(screen.getByText("Singapore National Sailing Championships 2099")).toBeInTheDocument();
    expect(screen.getByText("ILCA Singapore Open 2099")).toBeInTheDocument();
    expect(screen.getByText("Eastern Seaboard Regatta 2099")).toBeInTheDocument();
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

  it("toggles between upcoming schedule and past results", () => {
    render(<RegattaCalendarClient regattas={mockEvents} />);

    const pastTab = screen.getByRole("button", { name: /past results/i });
    fireEvent.click(pastTab);

    expect(screen.getByText("Past Regatta 2020")).toBeInTheDocument();
    expect(screen.queryByText("Singapore National Sailing Championships 2099")).not.toBeInTheDocument();
  });
});
