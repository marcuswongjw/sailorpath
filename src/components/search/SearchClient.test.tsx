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

    const input = screen.getByRole("searchbox", { name: "Search sailors and events" });
    expect(input).toHaveAttribute("placeholder", "Name, sail number, or club");
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

  it("shows Krishna and Shreya with Indian sail-number labels", () => {
    render(<SearchClient sailorsOnly initialSailors={[
      { ...sailor, id: "krishna", name: "Krishna Venkitachalam Ramakrishnan", handle: "krishna", sailNumber: "1639", nationality: "IND" },
      { ...sailor, id: "shreya", name: "Shreya Krishna Lakshminarayanan", handle: "shreya", sailNumber: "1632", nationality: "India" },
    ]} initialRegattas={[]} />);
    expect(screen.getByText("IND 1639")).toBeInTheDocument();
    expect(screen.getByText("IND 1632")).toBeInTheDocument();
    expect(screen.queryByText("SGP 1639")).not.toBeInTheDocument();
  });

  it("renders nationality-accurate sail numbers for William Handley, Andre Baou Martin, and Claire Bao", () => {
    const internationalSailors: SailorSearchResult[] = [
      {
        ...sailor,
        id: "william-handley",
        name: "William Handley",
        handle: "william-handley",
        sailNumber: "NZL 4818",
        nationality: "NZL",
      },
      {
        ...sailor,
        id: "andre-baou-martin",
        name: "ANDRE BAOU MARTIN",
        handle: "andre-baou-martin",
        sailNumber: "1024",
        nationality: "MAS",
      },
      {
        ...sailor,
        id: "claire-bao",
        name: "Claire Bao",
        handle: "claire-bao",
        sailNumber: "NZL 4811",
        nationality: "NZL",
      },
    ];

    render(<SearchClient sailorsOnly initialSailors={internationalSailors} initialRegattas={[]} />);

    expect(screen.getByText("NZL 4818")).toBeInTheDocument();
    expect(screen.queryByText("SGP NZL 4818")).not.toBeInTheDocument();

    expect(screen.getByText("MAS 1024")).toBeInTheDocument();
    expect(screen.queryByText("SGP 1024")).not.toBeInTheDocument();

    expect(screen.getByText("NZL 4811")).toBeInTheDocument();
    expect(screen.queryByText("SGP NZL 4811")).not.toBeInTheDocument();
  });
});
