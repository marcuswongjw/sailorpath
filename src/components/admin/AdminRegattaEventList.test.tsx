// @vitest-environment jsdom
import { fireEvent, render, screen } from "@testing-library/react";
import { afterEach, describe, expect, it, vi } from "vitest";
import { AdminRegattaEventList } from "./AdminRegattaEventList";
import type { AdminEventGroup } from "@/lib/admin/groupRegattaEvents";
const event = (slug: string, date: string): AdminEventGroup => ({
  slug,
  name: slug,
  startDate: date,
  countsForRanking: false,
  isSelectionTrial: false,
  expectedClasses: ["Optimist"],
  missingClasses: [],
  sheets: [],
  shells: [],
  shell: null,
});
afterEach(() => vi.useRealTimers());
describe("Event index", () => {
  it("separates upcoming from recent work without assigning a completion percentage", () => {
    vi.useFakeTimers();
    vi.setSystemTime(new Date("2026-10-18T00:00:00Z"));
    render(
      <AdminRegattaEventList
        events={[
          event("Future event", "2027-01-01"),
          event("Recent event", "2026-10-01"),
          event("Old event", "2023-01-01"),
        ]}
        selectedSlug={null}
        unassignedCount={0}
        onSelect={vi.fn()}
      />,
    );
    expect(
      screen.getByRole("button", { name: /Recent event/ }),
    ).toBeInTheDocument();
    expect(
      screen.queryByRole("button", { name: /Future event/ }),
    ).not.toBeInTheDocument();
    fireEvent.click(screen.getByRole("button", { name: "Upcoming" }));
    expect(screen.getByText("Scheduled · results not due")).toBeInTheDocument();
    expect(screen.queryByText("0%")).not.toBeInTheDocument();
    fireEvent.click(screen.getByRole("button", { name: "All history" }));
    expect(
      screen.getByRole("button", { name: /Old event/ }),
    ).toBeInTheDocument();
  });
  it("keeps an explicitly selected historical event visible", () => {
    render(
      <AdminRegattaEventList
        events={[event("Bookmarked event", "2020-01-01")]}
        selectedSlug="Bookmarked event"
        unassignedCount={0}
        onSelect={vi.fn()}
      />,
    );
    expect(
      screen.getByRole("button", { name: /Bookmarked event/ }),
    ).toHaveAttribute("aria-pressed", "true");
  });
});
