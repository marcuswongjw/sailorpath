import { renderToStaticMarkup } from "react-dom/server";
import { beforeEach, describe, expect, it, vi } from "vitest";

vi.mock("@/lib/queries", () => ({ getCachedPublicRegattas: vi.fn() }));
vi.mock("@/lib/calendar/singaporeRegattas2026", () => ({ SINGAPORE_REGATTAS_2026: [] }));

import { getCachedPublicRegattas } from "@/lib/queries";
import RegattasPage, { generateMetadata } from "./page";

const getPublicRegattas = vi.mocked(getCachedPublicRegattas);

describe("regatta directory page", () => {
  beforeEach(() => getPublicRegattas.mockReset());

  it("renders the event list on the server", async () => {
    getPublicRegattas.mockResolvedValue([
      {
        id: "published",
        name: "Published Harbour Regatta",
        slug: "published-harbour",
        date: "2026-08-01",
        venue: "National Sailing Centre",
        boatClass: "Optimist",
        totalFleetSize: 20,
      },
    ] as Awaited<ReturnType<typeof getCachedPublicRegattas>>);

    const page = await RegattasPage({ searchParams: Promise.resolve({}) });
    const html = renderToStaticMarkup(page);
    expect(html).toContain("Regatta directory");
    expect(html).toContain("Published Harbour Regatta");
    expect(html).toContain('href="/regattas/published-harbour"');
    expect(html).toContain('action="/regattas"');
    expect(html).not.toContain("Loading page");
  });

  it("sets a filter-specific title", async () => {
    const metadata = await generateMetadata({ searchParams: Promise.resolve({ q: "Harbour" }) });
    expect(metadata.title).toBe("Regattas matching “Harbour” | SailorPath");
  });

  it("deduplicates class options and restores a legacy spelling to its selected option", async () => {
    getPublicRegattas.mockResolvedValue(["Wingfoil", "WingFoil", "Wing Foil (U19)", "WindFoil", "Windfoil"].map((boatClass, index) => ({
      id: `alias-${index}`, slug: `alias-${index}`, name: `Public Event ${index}`, date: "2026-08-01", boatClass, totalFleetSize: 20,
    })));
    const html = renderToStaticMarkup(await RegattasPage({ searchParams: Promise.resolve({ class: "Wingfoil", results: "published" }) }));
    expect(html.match(/<option value="WingFoil"/g)).toHaveLength(1);
    expect(html.match(/<option value="Windfoil"/g)).toHaveLength(1);
    expect(html).toContain('value="WingFoil" selected');
    expect(html).toContain("WingFoil (U19)");
    expect(html.match(/<article/g)).toHaveLength(3);
    expect(html).not.toContain("Public Event 3");
    expect(html).not.toContain("Public Event 4");
  });

  it("renders one event card with direct fleet links and applies class filters", async () => {
    getPublicRegattas.mockResolvedValue(["ILCA 4", "ILCA 6"].map((boatClass, index) => ({
      id: `sheet-${index}`, name: `Harbour Open (${boatClass})`, slug: `harbour-${index}`,
      date: "2026-08-01", totalFleetSize: 20, boatClass,
      eventId: "harbour", eventSlug: "harbour-open-2026", eventName: "Harbour Open 2026",
    })));
    const html = renderToStaticMarkup(await RegattasPage({ searchParams: Promise.resolve({}) }));
    expect(html.match(/<article/g)).toHaveLength(1);
    expect(html).toContain("2 scorecards");
    expect(html).toContain("ILCA 4 results — Harbour Open 2026");
    expect(html).toContain("ILCA 6 results — Harbour Open 2026");
    expect(html).toContain("fleet=ilca-4");
    expect(html).toContain("fleet=ilca-6");
    const filtered = renderToStaticMarkup(await RegattasPage({ searchParams: Promise.resolve({ class: "ILCA 6", results: "published" }) }));
    expect(filtered).toContain("ILCA 6 results — Harbour Open 2026");
    expect(filtered).not.toContain("ILCA 4 results — Harbour Open 2026");
  });

  it("shows a recoverable warning when published results cannot load", async () => {
    getPublicRegattas.mockResolvedValue([]).mockRejectedValueOnce(new Error("Unavailable"));
    const page = await RegattasPage({ searchParams: Promise.resolve({ results: "published", q: "Cup" }) });
    const html = renderToStaticMarkup(page);
    expect(html).toContain("Published results could not be loaded");
    expect(html).toContain("Try again");
    expect(html).toContain('value="published" selected');
    expect(html).toContain('value="Cup"');
    expect(html).toContain("Clear filters");
  });
});
