/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import { SearchClient } from "./SearchClient";
import type { SailorSearchResult } from "@/lib/search";

const sailor: SailorSearchResult = {
  id: "sailor-1",
  name: "Charles Kong Shing Chak",
  handle: "charles-kong-shing-chak",
  sailNumber: "716",
  sailNumberIlca4: "227676",
  boardNumber: null,
  club: "Changi Sailing Club",
  nationality: "Singapore",
  activeFleet: "Gold",
  score: 1,
};

describe("SearchClient mobile layout", () => {
  it("wraps filters and keeps private school data out of results", () => {
    render(<SearchClient initialSailors={[sailor]} initialRegattas={[]} />);

    const filters = screen.getByRole("group", { name: "Search filters" });
    expect(filters.className).not.toContain("overflow-x-auto");
    expect(filters.querySelector(".flex-wrap")).toBeTruthy();

    const input = screen.getByRole("searchbox", { name: "Search sailors and regattas" });
    expect(input).toHaveAttribute("placeholder", "Name, sail number, club, or regatta");
    expect(input.className).toContain("min-w-0");

    expect(screen.getByRole("button", { name: /Silver Fleet/ })).toBeInTheDocument();
    expect(screen.queryByRole("button", { name: "Changi (CSC)" })).not.toBeInTheDocument();
    expect(screen.queryByText(/Quick Searches/i)).not.toBeInTheDocument();
    expect(screen.getByText("Charles Kong Shing Chak")).toBeInTheDocument();
    expect(screen.queryByText("Changi Sailing Club")).not.toBeInTheDocument();
    expect(screen.queryByText("ANGLO-CHINESE SCHOOL (INDEPENDENT)")).not.toBeInTheDocument();
  });

  it("counts and pages the full sailor list past the old 500 cap", () => {
    const sailors = Array.from({ length: 501 }, (_, index) => ({
      ...sailor,
      id: `sailor-${index}`,
      name: `Sailor ${index}`,
      handle: `sailor-${index}`,
    }));
    render(<SearchClient sailorsOnly initialSailors={sailors} initialRegattas={[]} />);

    expect(screen.getByRole("button", { name: "All (501)" })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: "Sailors (501)" })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: "Show 60 more" })).toBeInTheDocument();
    expect(screen.getByText("Sailor 0")).toBeInTheDocument();
    expect(screen.queryByText("Sailor 60")).not.toBeInTheDocument();
  });
});
