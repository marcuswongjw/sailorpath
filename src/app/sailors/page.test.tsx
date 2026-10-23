/** @vitest-environment jsdom */
import { renderToStaticMarkup } from "react-dom/server";
import { beforeEach, describe, expect, it, vi } from "vitest";
import type { SailorSearchResult } from "@/lib/search";
import type { SailorDirectoryParams } from "@/lib/sailorDirectory";

vi.mock("@/lib/search", () => ({ searchSailorsEnhanced: vi.fn() }));
import { searchSailorsEnhanced } from "@/lib/search";
import SailorsPage from "./page";

const search = vi.mocked(searchSailorsEnhanced);
const sailors: SailorSearchResult[] = Array.from({ length: 501 }, (_, i) => ({
  id: `sailor-${i}`, name: `Sailor ${i}`, handle: `sailor-${i}`,
  sailNumber: `${i}`, sailNumberIlca4: null, boardNumber: null,
  club: "Public Club", nationality: "NZL", activeFleet: null, score: 1,
}));

async function page(params: SailorDirectoryParams = {}) {
  const container = document.createElement("div");
  container.innerHTML = renderToStaticMarkup(await SailorsPage({ searchParams: Promise.resolve(params) }));
  return container;
}

describe("sailor directory", () => {
  beforeEach(() => { search.mockReset(); search.mockResolvedValue(sailors); });

  it("renders only one page while keeping the complete roster reachable", async () => {
    const html = await page();
    expect(html.textContent).toContain("Showing 1–30 of 501 sailors");
    expect(html.querySelectorAll("li")).toHaveLength(30);
    expect(html.querySelector('a[href="/sailors/sailor-30"]')).toBeNull();
    expect(html.querySelector('a[rel="next"]')).toHaveAttribute("href", "/sailors?page=2");
    expect(html.querySelector('a[rel="prev"]')).toBeNull();
    expect(html.querySelector('input[type="search"]')).toHaveAttribute("name", "q");
  });

  it("preserves every filter on both pagination links and resets page on a new search", async () => {
    const html = await page({ query: " Kong ", fleet: "gold", club: "CSC", nationality: "SGP", page: "2" });
    expect(search).toHaveBeenCalledWith({ query: "Kong", fleet: "gold", club: "CSC", nationality: "SGP", type: "sailors" });
    expect(html.textContent).toContain("Showing 31–60 of 501 matching sailors");
    expect(html.querySelector('a[rel="next"]')).toHaveAttribute("href", "/sailors?q=Kong&fleet=gold&club=CSC&nationality=SGP&page=3");
    expect(html.querySelector('a[rel="prev"]')).toHaveAttribute("href", "/sailors?q=Kong&fleet=gold&club=CSC&nationality=SGP");
    expect(html.querySelector('input[name="page"]')).toBeNull();
    expect(html.querySelector("details")).toHaveAttribute("open");
  });

  it("clamps old or invalid page links without losing the final sailors", async () => {
    const last = await page({ page: "999" });
    expect(last.textContent).toContain("Showing 481–501 of 501 sailors");
    expect(last.querySelector('a[href="/sailors/sailor-500"]')).not.toBeNull();
    expect(last.querySelector('a[rel="next"]')).toBeNull();
    const invalid = await page({ page: "-2" });
    expect(invalid.textContent).toContain("Showing 1–30");
  });

  it("distinguishes no matches from an unavailable directory and preserves retry context", async () => {
    search.mockResolvedValueOnce([]);
    const empty = await page({ q: "Unknown", club: "CSC" });
    expect(empty.textContent).toContain("No matching sailors");
    expect(empty.textContent).toContain("remove a filter");
    search.mockRejectedValueOnce(new Error("database unavailable"));
    const failed = await page({ q: "Unknown", club: "CSC", page: "2" });
    expect(failed.querySelector('[role="alert"]')?.textContent).toContain("temporarily unavailable");
    expect(failed.textContent).not.toContain("No matching sailors");
    expect(failed.querySelector('a[href="/sailors?q=Unknown&club=CSC&page=2"]')).toHaveTextContent("Try again");
  });

  it("shows public distinguishing details and nationality-correct sail numbers", async () => {
    search.mockResolvedValueOnce([{ ...sailors[0], sailNumber: "4818", sailNumberIlca4: "224245", boardNumber: "15", activeFleet: "Gold" }]);
    const html = await page();
    expect(html.textContent).toContain("NZL 4818");
    expect(html.textContent).toContain("Public Club · NZL · Optimist Gold");
    expect(html.textContent).toContain("ILCA: 224245 · Board: 15");
    expect(html.querySelector("nav[aria-label='Sailor directory pages']")).toBeNull();
  });
});
