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
  school: "ANGLO-CHINESE SCHOOL (INDEPENDENT)",
  nationality: "Singapore",
  avatarUrl: null,
  gender: null,
  nationalSquadStatus: null,
  currentFleet: "Gold",
  activeFleet: "Gold",
  ilca4NationalList: true,
  score: 1,
};

describe("SearchClient mobile layout", () => {
  it("wraps filters and hides quick searches, club, and school", () => {
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
});
