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
});
