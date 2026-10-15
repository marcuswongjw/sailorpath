import { renderToStaticMarkup } from "react-dom/server";
import { beforeEach, describe, expect, it, vi } from "vitest";

vi.mock("@/lib/queries", () => ({
  getCachedPublicRegattas: vi.fn(),
}));

import { getCachedPublicRegattas } from "@/lib/queries";
import ResultsPage from "./page";

const getPublicRegattas = vi.mocked(getCachedPublicRegattas);

describe("results directory", () => {
  beforeEach(() => {
    getPublicRegattas.mockReset();
  });

  it("renders completed published scorecards", async () => {
    getPublicRegattas.mockResolvedValue([
      {
        id: "test-regatta",
        name: "Test Regatta",
        slug: "test-regatta",
        date: "2026-09-10",
        endDate: "2026-09-11",
        venue: "Singapore",
        boatClass: "Optimist",
        division: "Gold",
        totalFleetSize: 12,
        raceCount: 4,
        geography: "SG",
        countsForRanking: true,
      },
    ] as Awaited<ReturnType<typeof getCachedPublicRegattas>>);

    const page = await ResultsPage({ searchParams: Promise.resolve({}) });
    const html = renderToStaticMarkup(page);

    expect(html).toContain("Test Regatta");
    expect(html).toContain("12 sailors · 4 races · Published result");
  });

  it("does not represent a database outage as an empty result set", async () => {
    getPublicRegattas.mockRejectedValueOnce(new Error("database unavailable"));

    const page = await ResultsPage({ searchParams: Promise.resolve({}) });
    const html = renderToStaticMarkup(page);

    expect(html).toContain("Results are temporarily unavailable");
    expect(html).not.toContain("No published scorecards match these filters.");
  });
});
