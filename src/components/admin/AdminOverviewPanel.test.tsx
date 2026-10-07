/** @vitest-environment jsdom */
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { render, screen } from "@testing-library/react";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { AdminOverviewPanel } from "./AdminOverviewPanel";

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
  vi.stubGlobal(
    "fetch",
    vi.fn().mockResolvedValue({
      ok: true,
      json: async () => ({ changes: [] }),
    })
  );
});

afterEach(() => {
  vi.unstubAllGlobals();
});

describe("AdminOverviewPanel", () => {
  it("routes attention cards to complete queues and gives each inbox queue a direct link", () => {
    const client = new QueryClient({ defaultOptions: { queries: { retry: false } } });
    render(
      <QueryClientProvider client={client}>
        <AdminOverviewPanel
          regattas={sheets}
          results={[]}
          duplicateCount={0}
          inboxQueueCounts={{ suggestions: 2, claims: 1, coaches: 0, support: 1 }}
        />
      </QueryClientProvider>
    );

    expect(screen.getByRole("link", { name: /Missing results/ })).toHaveAttribute(
      "href",
      "/admin?area=events&view=missing-results"
    );
    expect(screen.getByRole("link", { name: /Ready to publish/ })).toHaveAttribute(
      "href",
      "/admin?area=events&view=ready-to-publish"
    );
    expect(screen.getByRole("link", { name: "Suggestions: 2 pending" })).toHaveAttribute(
      "href",
      "/admin?area=inbox&view=suggestions"
    );
    expect(screen.getByText(/Recent profile edits are activity, not pending inbox items/)).toBeInTheDocument();
  });
});
