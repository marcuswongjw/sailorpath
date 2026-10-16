/** @vitest-environment jsdom */
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

  it("offers country, class and year dropdowns from completed scorecards", async () => {
    getPublicRegattas.mockResolvedValue([
      { id: "sg", slug: "sg", name: "Singapore event", date: "2025-09-10", geography: "SG", boatClass: "ILCA 4", totalFleetSize: 12 },
      { id: "sgp", slug: "sgp", name: "Another Singapore event", date: "2024-09-10", geography: "SGP", boatClass: "ilca4", totalFleetSize: 12 },
      { id: "th", slug: "th", name: "Thailand event", date: "2025-09-10", geography: "THA", boatClass: "Optimist", totalFleetSize: 12 },
      { id: "future", slug: "future", name: "Future event", date: "2099-09-10", geography: "MAS", boatClass: "420", totalFleetSize: 12 },
    ]);
    const page = await ResultsPage({ searchParams: Promise.resolve({}) });
    const container = document.createElement("div");
    container.innerHTML = renderToStaticMarkup(page);

    const optionLabels = (name: string) => Array.from(
      container.querySelectorAll(`select[name="${name}"] option`),
      (option) => option.textContent
    );
    expect(optionLabels("country")).toEqual(["All countries", "Singapore", "Thailand"]);
    expect(optionLabels("class")).toEqual(["All classes", "ILCA 4", "Optimist"]);
    expect(optionLabels("year")).toEqual(["All years", "2025", "2024"]);
    expect(container.querySelector('input[name="class"]')).toBeNull();
    expect(container.querySelector('input[name="year"]')).toBeNull();
  });

  it("combines country aliases, compact class links, year and search filters", async () => {
    getPublicRegattas.mockResolvedValue([
      { id: "match", slug: "match", name: "Harbour Open", date: "2025-09-10", geography: "SG", boatClass: "ILCA 4", totalFleetSize: 12 },
      { id: "country", slug: "country", name: "Harbour Thailand", date: "2025-09-10", geography: "THA", boatClass: "ILCA 4", totalFleetSize: 12 },
      { id: "class", slug: "class", name: "Harbour Optimist", date: "2025-09-10", geography: "SGP", boatClass: "Optimist", totalFleetSize: 12 },
      { id: "year", slug: "year", name: "Harbour Previous", date: "2024-09-10", geography: "SGP", boatClass: "ILCA 4", totalFleetSize: 12 },
      { id: "search", slug: "search", name: "Other Event", date: "2025-09-10", geography: "SGP", boatClass: "ILCA 4", totalFleetSize: 12 },
    ]);
    const page = await ResultsPage({
      searchParams: Promise.resolve({ country: "Singapore", class: "ilca4", year: "2025", q: "Harbour" }),
    });
    const container = document.createElement("div");
    container.innerHTML = renderToStaticMarkup(page);

    expect(Array.from(container.querySelectorAll("h2"), (heading) => heading.textContent)).toEqual(["Harbour Open"]);
    expect(container.querySelector<HTMLSelectElement>('select[name="country"]')?.value).toBe("SGP");
    expect(container.querySelector<HTMLSelectElement>('select[name="class"]')?.value).toBe("ILCA 4");
    expect(container.querySelector<HTMLSelectElement>('select[name="year"]')?.value).toBe("2025");
    expect(container.querySelector<HTMLInputElement>('input[name="q"]')?.value).toBe("Harbour");
  });
});
