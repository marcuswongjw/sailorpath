/** @vitest-environment jsdom */
import { renderToStaticMarkup } from "react-dom/server";
import { beforeEach, describe, expect, it, vi } from "vitest";

vi.mock("@/lib/landingStats", () => ({
  getLandingTotals: vi.fn(),
  getLandingResultCounts: vi.fn(),
}));

vi.mock("@/lib/queries", () => ({
  getCachedPublicRegattas: vi.fn(),
}));

vi.mock("@/lib/calendar/publicCalendar", () => ({ getPublicCalendarData: vi.fn() }));
vi.mock("@/lib/datesSg", () => ({ todayYmdSg: () => "2026-10-22" }));

import { getPublicCalendarData } from "@/lib/calendar/publicCalendar";
import { getLandingTotals, getLandingResultCounts } from "@/lib/landingStats";
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
    getTotals.mockResolvedValue({ athletes: "2500+", regattas: "288" });
    vi.mocked(getLandingResultCounts).mockReset();
    vi.mocked(getLandingResultCounts).mockImplementation(async (ids) => Object.fromEntries(ids.map((id) => [id, 24])));
    vi.mocked(getPublicCalendarData).mockReset();
    vi.mocked(getPublicCalendarData).mockResolvedValue({ allRegattas: [], resultSheetsByEvent: {} });
  });

  it("keeps sailor discovery prominent and makes its search promise specific", async () => {
    getPublicRegattas.mockResolvedValue([]);

    const html = renderToStaticMarkup(await HomePage());

    expect(html).toContain("Sailing results and rankings,");
    expect(html).toContain("race by race.");
    expect(html).toContain("Find a sailor profile");
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

    expect(html).toContain("Recent regatta results");
    expect(html).toContain("Newest Scorecard");
    expect(html).toContain("Middle Scorecard");
    expect(html).toContain("Older Scorecard");
    expect(html).not.toContain("Upcoming Event");
    expect(html).not.toContain("Incomplete Event");
    expect(html).toContain('href="/regattas/newest-scorecard"');
    expect(html).toContain("All results");
  });

  it("counts result classes from scorecards rather than the seven featured hubs", async () => {
    getPublicRegattas.mockResolvedValue(["Optimist", "29er", "420", "WindFoil", "Windfoil"].map((boatClass) => regatta({id: boatClass, boatClass})));
    const html = renderToStaticMarkup(await HomePage());
    const container = document.createElement("div");
    container.innerHTML = html;
    const label = [...container.querySelectorAll("*")].find((node) => node.textContent === "classes with results");
    expect(label?.parentElement?.textContent).toContain("4");
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
    expect(html).toContain('href="/classes/x-15"');
    expect(html).toContain("classes with results");
  });

  it("keeps the page usable if recent public results cannot be loaded", async () => {
    getPublicRegattas.mockRejectedValue(new Error("database unavailable"));

    const html = renderToStaticMarkup(await HomePage());

    expect(html).toContain("No recent published scorecards to feature right now");
    expect(html).toContain("Find a sailor profile");
    expect(html).toContain("All results");
  });
  it("includes today's scored results, marks source status and preserves partial entry counts", async () => {
    getPublicRegattas.mockResolvedValue([
      regatta({ id: "today", name: "Today Final", date: "2026-10-22", endDate: "2026-10-22", scheduleNotes: "Official source status: final." }),
      regatta({ id: "partial", name: "Partial Provisional", endDate: "2026-10-21", scheduleNotes: "Official source status: provisional." }),
    ]);
    vi.mocked(getLandingResultCounts).mockResolvedValue({ today: 24, partial: 20 });
    const html = renderToStaticMarkup(await HomePage());
    expect(html).toContain("Today Final");
    expect(html).toContain("22 Oct 2026");
    expect(html).toContain("Provisional");
    expect(html).toContain("Partial import");
    expect(html).toContain("20 of 24 entries imported");
    expect(html).toContain("published result tables");
  });

  it("uses calendar events without requiring race scores and explains claiming with labelled sample data", async () => {
    getPublicRegattas.mockResolvedValue([]);
    vi.mocked(getPublicCalendarData).mockResolvedValue({ allRegattas: [regatta({name: "Next Weekend",date: "2026-10-30",endDate: "2026-10-31",raceCount: 0, totalFleetSize: 0, classes: ["Optimist","ILCA 4"]})],resultSheetsByEvent: {} });
    const html = renderToStaticMarkup(await HomePage());
    expect(html).toContain("Next Weekend");
    expect(html).toContain("Optimist · ILCA 4");
    expect(html).toContain('href="/calendar?q=Next%20Weekend"');
    expect(html).toContain("Request access");
    expect(html).toContain("Sample profile · demonstration data");
    expect(html).toContain('href="/sample"');
  });

  it("keeps discovery usable when the calendar cannot be safely loaded", async () => {
    getPublicRegattas.mockResolvedValue([]);
    vi.mocked(getPublicCalendarData).mockRejectedValue(new Error("deletions unavailable"));
    const html = renderToStaticMarkup(await HomePage());
    expect(html).toContain("Upcoming events are temporarily unavailable");
    expect(html).toContain("Find a sailor profile");
  });

});
