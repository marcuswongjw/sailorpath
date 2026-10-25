// @vitest-environment jsdom
import { cleanup, render, screen } from "@testing-library/react";
import { afterEach, describe, expect, it, vi } from "vitest";
vi.mock("@/components/RegattasBackLink", () => ({ RegattasBackLink: ({ children, href }: { children: React.ReactNode; href: string }) => <a href={href}>{children}</a> }));
import { RegattaOverview, regattaTimelineStatus } from "./RegattaOverview";
afterEach(cleanup);
const base = { name: "Hong Kong Race Week", dates: "16–21 February 2027", venue: "Middle Island", organiser: "RHKYC", classes: ["Wingfoil", "WingFoil", "Optimist Gold"], status: "Upcoming" };
describe("event overview", () => {
  it("groups facts, canonical classes and official actions without claiming entries are open", () => {
    render(<RegattaOverview {...base} registrationUrl="https://example.org/entry" noticeBoardUrl="https://example.org/board" calendarEvent={{ slug: "hkrw", name: base.name, startDate: "2027-02-16", endDate: "2027-02-21" }} />);
    expect(screen.getByRole("heading", { level: 1 }).textContent).toBe(base.name);
    expect(screen.getByText("Middle Island")).toBeTruthy();
    expect(screen.getAllByText("WingFoil")).toHaveLength(1);
    expect(screen.getByText("Optimist Gold")).toBeTruthy();
    expect(screen.getByRole("link", { name: "Entry information" }).getAttribute("href")).toBe("https://example.org/entry");
    expect(screen.getByRole("link", { name: "Official notice board" }).getAttribute("href")).toBe("https://example.org/board");
    expect(screen.getByRole("button", { name: /Add to calendar/ })).toBeTruthy();
    expect(screen.getByText("Check the organiser’s entry information.")).toBeTruthy();
    expect(screen.queryByText(/Entries open/)).toBeNull();
  });
  it("shows date-TBC state without inventing an entry or calendar action", () => {
    render(<RegattaOverview {...base} dates="2027 · Dates to be confirmed" status="Dates TBC" websiteUrl="https://example.org" />);
    expect(screen.getByText("Dates TBC")).toBeTruthy();
    expect(screen.queryByRole("button", { name: /Add to calendar/ })).toBeNull();
    expect(screen.queryByRole("link", { name: "Entry information" })).toBeNull();
  });
  it("uses the Singapore date for upcoming, underway and past states", () => {
    const now = new Date("2026-10-24T17:00:00Z");
    expect(regattaTimelineStatus("2026-10-26", null, now)).toBe("Upcoming");
    expect(regattaTimelineStatus("2026-10-24", "2026-10-25", now)).toBe("Event underway");
    expect(regattaTimelineStatus("2026-10-24", null, now)).toBe("Past event");
  });
});
