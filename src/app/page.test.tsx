/** @vitest-environment jsdom */
import { renderToStaticMarkup } from "react-dom/server";
import { beforeEach, describe, expect, it, vi } from "vitest";

vi.mock("@/lib/landingStats", () => ({
  getLandingTotals: vi.fn(),
}));

vi.mock("@/lib/queries", () => ({
  getCachedPublicRegattas: vi.fn(),
}));

import { getLandingTotals } from "@/lib/landingStats";
import { getCachedPublicRegattas } from "@/lib/queries";
import HomePage from "./page";

const getTotals = vi.mocked(getLandingTotals);
const getPublicRegattas = vi.mocked(getCachedPublicRegattas);

type PublicRegatta = Awaited<ReturnType<typeof getCachedPublicRegattas>>[number];

function regatta(overrides: Partial<PublicRegatta> = {}): PublicRegatta {
  return {
    id: "recent-id",
    name: "Recent Optimist Regatta",
    slug: "recent-optimist-regatta",
    date: "2026-09-10",
    endDate: "2026-09-11",
    venue: "Singapore",
    boatClass: "Optimist",
    division: "Gold",
    totalFleetSize: 24,
    raceCount: 6,
    geography: "SG",
    countsForRanking: true,
    ...overrides,
  };
}

describe("public landing page", () => {
  beforeEach(() => {
    getTotals.mockReset();
    getPublicRegattas.mockReset();
    getTotals.mockResolvedValue({ athletes: "800+", regattas: "130" });
  });

  it("keeps sailor discovery prominent and makes its search promise specific", async () => {
    getPublicRegattas.mockResolvedValue([]);

    const html = renderToStaticMarkup(await HomePage());

    expect(html).toContain("Find a sailor profile");
    expect(html).toContain("Sailing results and rankings,");
    expect(html).toContain("race by race.");
    expect(html).toContain('action="/sailors"');
    expect(html).toContain('aria-label="Search sailors"');
    expect(html).toContain("Sailor name, sail number, or club");
    expect(html).not.toContain("Search sailors and regattas");
    expect(html).not.toContain("Find a sailor or regatta");
  });

  it("shows the latest completed scorecards and omits future or incomplete events", async () => {
    getPublicRegattas.mockResolvedValue([
      regatta({ id: "older", name: "Older Scorecard", slug: "older-scorecard", endDate: "2026-08-01" }),
      regatta({ id: "newest", name: "Newest Scorecard", slug: "newest-scorecard", endDate: "2026-10-01" }),
      regatta({ id: "middle", name: "Middle Scorecard", slug: "middle-scorecard", endDate: "2026-09-01" }),
      regatta({ id: "upcoming", name: "Upcoming Event", slug: "upcoming-event", endDate: "2099-01-01" }),
      regatta({ id: "incomplete", name: "Incomplete Event", slug: "incomplete-event", raceCount: 0 }),
    ]);

    const html = renderToStaticMarkup(await HomePage());

    expect(html).toContain("Latest published results");
    expect(html).toContain("Newest Scorecard");
    expect(html).toContain("Middle Scorecard");
    expect(html).toContain("Older Scorecard");
    expect(html).not.toContain("Upcoming Event");
    expect(html).not.toContain("Incomplete Event");
    expect(html).toContain('href="/regattas/newest-scorecard"');
    expect(html).toContain("All results");
  });

  it("marks parent and coach destinations as private and highlights the public Asian Index", async () => {
    getPublicRegattas.mockResolvedValue([]);

    const html = renderToStaticMarkup(await HomePage());

    expect(html).toContain("Private workspace · sign-in required");
    expect(html).toContain("Explore parent tools");
    expect(html).toContain("Explore coach tools");
    expect(html).toContain("Asian &amp; Oceania Optimist Index");
    expect(html).toContain('href="/optimist/asian-index"');
    expect(html).toContain('href="/optimist/asian-index/methodology"');
    expect(html).toContain('href="/classes/x15"');
    expect(html).toContain("X-15");
    expect(html).toContain("classes represented");
  });

  it("keeps the page usable if recent public results cannot be loaded", async () => {
    getPublicRegattas.mockRejectedValue(new Error("database unavailable"));

    const html = renderToStaticMarkup(await HomePage());

    expect(html).toContain("No recent published scorecards to feature right now");
    expect(html).toContain("Find a sailor profile");
    expect(html).toContain("All results");
  });
});
