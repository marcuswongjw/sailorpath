/** @vitest-environment jsdom */
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import { AdminEventsQueuePanel } from "./AdminEventsQueuePanel";

const sheet = {
  id: "sheet-1",
  name: "Example Optimist Gold",
  slug: "example-optimist-gold",
  date: "2026-06-01",
  totalFleetSize: 20,
  division: "Gold",
  raceCount: 3,
  boatClass: "Optimist",
  countsForRanking: true,
};

function renderWithClient(ui: React.ReactElement) {
  const client = new QueryClient({
    defaultOptions: { queries: { retry: false } },
  });
  return render(<QueryClientProvider client={client}>{ui}</QueryClientProvider>);
}

describe("AdminEventsQueuePanel", () => {
  it("lists missing-results sheets and links directly to result entry", () => {
    renderWithClient(
      <AdminEventsQueuePanel view="missing-results" regattas={[sheet]} results={[]} />
    );

    expect(screen.getByText("1 item")).toBeInTheDocument();
    expect(screen.getByRole("link", { name: /Enter results/ })).toHaveAttribute(
      "href",
      "/admin?area=events&view=results&sheet=sheet-1"
    );
  });

  it("links publication-ready sheets to their readiness checks", () => {
    renderWithClient(
      <AdminEventsQueuePanel
        view="ready-to-publish"
        regattas={[{ ...sheet, raceCount: 0 }]}
        results={[]}
      />
    );

    expect(screen.getByRole("link", { name: /Review checks/ })).toHaveAttribute(
      "href",
      "/admin?area=events&view=readiness&sheet=sheet-1"
    );
  });

  it("links issues to readiness checks and explains empty queues", () => {
    const client = new QueryClient({
      defaultOptions: { queries: { retry: false } },
    });
    const { rerender } = render(
      <QueryClientProvider client={client}>
        <AdminEventsQueuePanel view="attention" regattas={[sheet]} results={[]} />
      </QueryClientProvider>
    );

    expect(screen.getByRole("link", { name: /Review checks/ })).toHaveAttribute(
      "href",
      "/admin?area=events&view=readiness&sheet=sheet-1"
    );
    rerender(
      <QueryClientProvider client={client}>
        <AdminEventsQueuePanel view="missing-results" regattas={[]} results={[]} />
      </QueryClientProvider>
    );
    expect(screen.getByText("No missing results")).toBeInTheDocument();
  });
});
