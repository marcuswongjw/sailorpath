import { renderToStaticMarkup } from "react-dom/server";
import { beforeEach, describe, expect, it, vi } from "vitest";

vi.mock("@/lib/search", () => ({ unifiedSearch: vi.fn() }));

import { unifiedSearch } from "@/lib/search";
import SearchPage, { generateMetadata } from "./page";

const search = vi.mocked(unifiedSearch);

describe("search page", () => {
  beforeEach(() => search.mockReset());

  it("renders sailor and regatta results on the server", async () => {
    search.mockResolvedValue({
      sailors: [{
        id: "sailor-1",
        name: "Kimberly Tan",
        handle: "kimberly-t",
        sailNumber: "SGP 115",
        sailNumberIlca4: null,
        boardNumber: null,
        club: "Changi Sailing Club",
        nationality: "SGP",
        activeFleet: "Gold",
        score: 1,
      }],
      regattas: [{
        id: "regatta-1",
        name: "NSC Cup",
        slug: "nsc-cup",
        date: "2026-08-01",
        venue: "NSC",
        boatClass: "Optimist",
        href: "/regattas/nsc-cup",
        score: 1,
      }],
      total: 2,
    });

    const page = await SearchPage({ searchParams: Promise.resolve({ query: "Kimberly", fleet: "gold" }) });
    const html = renderToStaticMarkup(page);
    expect(html).toContain("Results for “Kimberly”");
    expect(html).toContain("Kimberly Tan");
    expect(html).toContain('href="/sailors/kimberly-t"');
    expect(html).toContain("NSC Cup");
    expect(html).toContain('action="/search"');
    expect(html).not.toContain("Loading page");
  });

  it("sets a query-specific title", async () => {
    const metadata = await generateMetadata({ searchParams: Promise.resolve({ q: "SGP 115" }) });
    expect(metadata.title).toBe("Search “SGP 115” | SailorPath");
  });
});
