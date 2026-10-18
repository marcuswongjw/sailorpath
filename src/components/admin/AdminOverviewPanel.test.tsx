/** @vitest-environment jsdom */
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { render, screen } from "@testing-library/react";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { AdminOverviewPanel } from "./AdminOverviewPanel";
const requests = vi.hoisted(() => ({ overview: vi.fn(), duplicates: vi.fn() }));
vi.mock("./adminFetch", async (original) => ({
  ...(await original<typeof import("./adminFetch")>()),
  fetchAdminOverview: requests.overview,
  fetchAdminDuplicateCount: requests.duplicates,
}));

const sheets = [
  {
    id: "missing-sheet",
    name: "Missing Optimist Gold",
    slug: "missing-optimist-gold",
    date: "2026-06-01",
    totalFleetSize: 20,
    division: "Gold",
    raceCount: 3,
    boatClass: "Optimist",
    countsForRanking: true,
  },
  {
    id: "ready-sheet",
    name: "Ready ILCA 4",
    slug: "ready-ilca-4",
    date: "2026-06-02",
    totalFleetSize: 12,
    division: "Open",
    raceCount: 0,
    boatClass: "ILCA 4",
    countsForRanking: false,
  },
];

beforeEach(() => {
  requests.overview.mockReset();
  requests.duplicates.mockReset();
  vi.stubGlobal(
    "fetch",
    vi.fn().mockResolvedValue({
      ok: true,
      json: async () => ({ changes: [] }),
    }),
  );
});

afterEach(() => {
  vi.unstubAllGlobals();
});

describe("AdminOverviewPanel", () => {
  it("keeps Inbox and quick actions available when event checks fail", async () => {
    requests.overview.mockRejectedValue(new Error("Event timeout"));
    requests.duplicates.mockResolvedValue({ duplicateCount: 2 });
    const client = new QueryClient({
      defaultOptions: { queries: { retry: false } },
    });
    render(
      <QueryClientProvider client={client}>
        <AdminOverviewPanel
          inboxQueueCounts={{
            suggestions: 0,
            claims: 1,
            coaches: 0,
            support: 0,
          }}
        />
      </QueryClientProvider>,
    );
    expect(await screen.findByRole("alert")).toHaveTextContent("No all-clear");
    expect(
      screen.getByRole("link", { name: "Claims: 1 pending" }),
    ).toBeInTheDocument();
    expect(
      screen.getByRole("link", { name: "Find an event" }),
    ).toBeInTheDocument();
    expect(
      await screen.findByRole("link", { name: /Duplicate candidates 2/ }),
    ).toBeInTheDocument();
  });

  it("does not describe an incomplete Inbox as clear", () => {
    const client = new QueryClient({
      defaultOptions: { queries: { retry: false } },
    });
    render(
      <QueryClientProvider client={client}>
        <AdminOverviewPanel
          regattas={[]}
          results={[]}
          duplicateCount={0}
          inboxQueueCounts={{
            suggestions: 0,
            claims: 0,
            coaches: 0,
            support: 0,
          }}
          inboxQueueStates={{
            suggestions: { status: "ready", updatedAt: 1 },
            claims: { status: "unavailable", updatedAt: 0 },
            coaches: { status: "ready", updatedAt: 1 },
            support: { status: "ready", updatedAt: 1 },
          }}
        />
      </QueryClientProvider>,
    );
    expect(screen.getByText(/Inbox total is incomplete/)).toBeInTheDocument();
    expect(
      screen.getByRole("link", { name: "Claims: Unavailable" }),
    ).toBeInTheDocument();
    expect(
      screen.queryByText("No requests are waiting for review."),
    ).not.toBeInTheDocument();
  });
  it("routes attention cards to complete queues and gives each inbox queue a direct link", () => {
    const client = new QueryClient({
      defaultOptions: { queries: { retry: false } },
    });
    render(
      <QueryClientProvider client={client}>
        <AdminOverviewPanel
          regattas={sheets}
          results={[]}
          duplicateCount={0}
          inboxQueueCounts={{
            suggestions: 2,
            claims: 1,
            coaches: 0,
            support: 1,
          }}
        />
      </QueryClientProvider>,
    );

    expect(
      screen.getByRole("link", { name: /Missing results/ }),
    ).toHaveAttribute("href", "/admin?area=events&view=missing-results");
    expect(
      screen.getByRole("link", { name: /Ready for review/ }),
    ).toHaveAttribute("href", "/admin?area=events&view=ready-to-publish");
    expect(
      screen.getByRole("link", { name: "Suggestions: 2 pending" }),
    ).toHaveAttribute("href", "/admin?area=inbox&view=suggestions");
    expect(
      screen.getByText(
        /Recent profile edits are activity, not pending inbox items/,
      ),
    ).toBeInTheDocument();
  });
});
