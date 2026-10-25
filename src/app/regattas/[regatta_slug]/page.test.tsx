// @vitest-environment jsdom
import { render, screen, cleanup } from "@testing-library/react";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";

const permanentRedirect = vi.hoisted(() => vi.fn());

vi.mock("next/navigation", () => ({
  permanentRedirect,
  redirect: vi.fn(),
}));

vi.mock("@/db", () => ({
  db: {
    select: vi.fn(),
  },
}));

vi.mock("@/components/RegattaEventHub", () => ({
  RegattaEventHub: vi.fn(() => null),
}));

vi.mock("@/lib/calendar/publicCalendar", () => ({ getPublicCalendarData: vi.fn() }));
vi.mock("@/lib/queries", () => ({ getCachedPublicRegattas: vi.fn(async () => []), getRegattaBySlug: vi.fn(async () => null) }));
vi.mock("@/components/RegattasBackLink", () => ({ RegattasBackLink: ({ children, href }: { children: React.ReactNode; href: string }) => <a href={href}>{children}</a> }));
import { getPublicCalendarData } from "@/lib/calendar/publicCalendar";
import RegattaRedirectPage from "./page";

function redirectTo(path: string): never {
  throw new Error(`REDIRECT:${path}`);
}

describe("canonical RSYC event routes", () => {
  beforeEach(() => {
    permanentRedirect.mockReset();
    permanentRedirect.mockImplementation(redirectTo);
  });

  it("moves the short RSYC Gold import slug to its canonical event hub", async () => {
    await expect(
      RegattaRedirectPage({
        params: Promise.resolve({ regatta_slug: "rsyc-2026-gold" }),
        searchParams: Promise.resolve({}),
      })
    ).rejects.toThrow(
      "REDIRECT:/regattas/rsyc-optimist-gold-fleet-knockout-championship-2026"
    );
    expect(permanentRedirect).toHaveBeenCalledWith(
      "/regattas/rsyc-optimist-gold-fleet-knockout-championship-2026"
    );
  });
});


afterEach(cleanup);
describe("scheduled event overview routes", () => {
  it("uses saved calendar facts and actions for an upcoming event without results", async () => {
    vi.mocked(getPublicCalendarData).mockResolvedValue({ allRegattas: [{ id: "hkrw", slug: "hong-kong-race-week-2027", name: "Saved HKRW", date: "2027-02-16", endDate: "2027-02-21", totalFleetSize: 0, venue: "Saved venue", organizer: "Saved organiser", classes: ["Optimist", "ILCA 6"], registrationUrl: "https://example.org/entry" }], resultSheetsByEvent: {} });
    render(await RegattaRedirectPage({ params: Promise.resolve({ regatta_slug: "hong-kong-race-week-2027" }), searchParams: Promise.resolve({}) }));
    expect(screen.getByRole("heading", { level: 1 }).textContent).toBe("Saved HKRW");
    expect(screen.getByText("Saved venue")).toBeTruthy();
    expect(screen.getByRole("link", { name: "Entry information" }).getAttribute("href")).toBe("https://example.org/entry");
    expect(screen.getByText("Results will appear here once published.")).toBeTruthy();
  });
  it("keeps the Garda event date-TBC with no fabricated download", async () => {
    render(await RegattaRedirectPage({ params: Promise.resolve({ regatta_slug: "45th-lake-garda-meeting-optimist-2027" }), searchParams: Promise.resolve({}) }));
    expect(screen.getByText("Dates TBC")).toBeTruthy();
    expect(screen.queryByRole("button", { name: /Add to calendar/ })).toBeNull();
  });
  it("does not resurrect static facts when calendar deletion state is unavailable", async () => {
    vi.mocked(getPublicCalendarData).mockRejectedValue(new Error("unavailable"));
    render(await RegattaRedirectPage({ params: Promise.resolve({ regatta_slug: "hong-kong-race-week-2027" }), searchParams: Promise.resolve({}) }));
    expect(screen.getByText("Event information is temporarily unavailable")).toBeTruthy();
    expect(screen.queryByRole("button", { name: /Add to calendar/ })).toBeNull();
  });
});
