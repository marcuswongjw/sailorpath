/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import { AdminDashboard } from "./AdminDashboard";
import { useAdminAuth } from "./useAdminAuth";

vi.mock("next/navigation", () => ({
  useSearchParams: () => new URLSearchParams(),
  useRouter: () => ({ push: vi.fn(), replace: vi.fn() }),
  usePathname: () => "/admin",
}));

vi.mock("./useAdminAuth", () => ({
  useAdminAuth: vi.fn(),
}));

vi.mock("./useAdminData", () => ({
  useAdminData: () => ({
    sailorList: [],
    regattaList: [],
    resultsList: [],
    calendarEvents: [],
    dataLoading: false,
    dataReady: true,
    dataLoadError: null,
    selectedRegattaIdForResultEdit: "",
    setSelectedRegattaIdForResultEdit: vi.fn(),
    refreshAll: vi.fn(),
  }),
}));

vi.mock("./useAdminNotifications", () => ({
  useAdminNotifications: () => ({
    claimsPendingCount: 0,
    supportNewCount: 0,
    coachPendingCount: 0,
    suggestionsCount: 0,
    inboxQueueCounts: { claims: 0, coach: 0, support: 0, suggestions: 0 },
    inboxNotifCount: 0,
    inboxLandingView: "claims",
  }),
}));

vi.mock("./useAdminResults", () => ({
  useAdminResults: () => ({
    resultsLoading: false,
    resultsError: null,
    goldResults: [],
    silverResults: [],
    selectedRegatta: null,
    saveResults: vi.fn(),
  }),
}));

import { FeedbackProvider } from "@/components/ui/FeedbackProvider";

function renderWithFeedback(ui: React.ReactElement) {
  return render(<FeedbackProvider>{ui}</FeedbackProvider>);
}

describe("AdminDashboard auth banners", () => {
  it("renders temporary connection banner with Retry button when authUnavailable is true, and does not show Admin access required", () => {
    vi.mocked(useAdminAuth).mockReturnValue({
      user: { id: "admin-1", email: "admin@sailorpath.com" },
      loading: false,
      isRevalidating: false,
      adminRole: "superadmin",
      isSuperadmin: true,
      authUnavailable: true,
      authError: "Database temporarily unavailable",
      lastSeenProductChangelogAt: null,
      productChangelogUnread: false,
      markProductChangelogSeen: vi.fn(),
      refreshAuth: vi.fn(),
    });

    renderWithFeedback(<AdminDashboard />);

    // Finding 2 fix: Should display temporary connection issue banner with Retry CTA
    expect(screen.getByText("Temporary connection issue")).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Retry/i })).toBeInTheDocument();

    // Must NOT display "Admin access required"
    expect(screen.queryByText("Admin access required")).not.toBeInTheDocument();
  });

  it("renders Admin access required only when user is genuinely not superadmin and service is available", () => {
    vi.mocked(useAdminAuth).mockReturnValue({
      user: { id: "sailor-1", email: "sailor@sailorpath.com" },
      loading: false,
      isRevalidating: false,
      adminRole: "sailor",
      isSuperadmin: false,
      authUnavailable: false,
      authError: null,
      lastSeenProductChangelogAt: null,
      productChangelogUnread: false,
      markProductChangelogSeen: vi.fn(),
      refreshAuth: vi.fn(),
    });

    renderWithFeedback(<AdminDashboard />);

    expect(screen.getByText("Admin access required")).toBeInTheDocument();
    expect(
      screen.queryByText("Temporary connection issue")
    ).not.toBeInTheDocument();
  });

  it("renders full-screen temporary connection issue when user is null and authUnavailable is true", () => {
    vi.mocked(useAdminAuth).mockReturnValue({
      user: null,
      loading: false,
      isRevalidating: false,
      adminRole: "sailor",
      isSuperadmin: false,
      authUnavailable: true,
      authError: "Database temporarily unavailable",
      lastSeenProductChangelogAt: null,
      productChangelogUnread: false,
      markProductChangelogSeen: vi.fn(),
      refreshAuth: vi.fn(),
    });

    renderWithFeedback(<AdminDashboard />);

    expect(
      screen.getByRole("heading", { name: "Temporary Connection Issue" })
    ).toBeInTheDocument();
    expect(
      screen.getByRole("button", { name: /Retry Admin Console/i })
    ).toBeInTheDocument();
    expect(
      screen.queryByText("Sign In to Admin Portal")
    ).not.toBeInTheDocument();
  });
});
