import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  select: vi.fn(),
  cached: vi.fn(),
  savedHub: vi.fn(),
  notFound: vi.fn(() => { throw new Error("NOT_FOUND"); }),
}));
vi.mock("@/db", () => ({ db: { select: mocks.select } }));
vi.mock("next/navigation", () => ({ notFound: mocks.notFound }));
vi.mock("@/lib/queries", () => ({ getCachedPublicRegattas: mocks.cached }));
vi.mock("@/lib/regattaEvents", () => ({ getRegattaEvent: () => null }));
vi.mock("@/lib/regattaEventGroups", () => ({ savedEventHubForSlug: mocks.savedHub, groupedHubForSlug: () => null }));
vi.mock("@/components/RegattaEventHub", () => ({ RegattaEventHub: () => null }));

import FleetResultsPage from "./page";

const event = {
  slug: "2026-optimist-world-championship",
  name: "2026 Optimist World Championship",
  slices: [{ key: "optimist" }],
};
const params = (fleet = "optimist") => Promise.resolve({ regatta_slug: event.slug, fleet });

describe("saved descriptions on fleet results", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    mocks.cached.mockResolvedValue([]);
    mocks.savedHub.mockReturnValue({ event });
  });

  it("discloses an Asian-only subset when opening the class results directly", async () => {
    const note = "Asian sailors only. Original world positions and the full 284-boat fleet size are retained.";
    mocks.select.mockReturnValue({ from: () => ({ where: () => ({ limit: async () => [{ scheduleSummary: note }] }) }) });
    const page = await FleetResultsPage({ params: params() });
    expect(page.props.event.scheduleSummary).toBe(note);
    expect(page.props.activeFleet).toBe("optimist");
  });

  it("retains the resolved event when no saved paragraph exists", async () => {
    mocks.select.mockReturnValue({ from: () => ({ where: () => ({ limit: async () => [] }) }) });
    const page = await FleetResultsPage({ params: params() });
    expect(page.props.event).toEqual(event);
  });

  it("retains the event if its optional saved-copy lookup fails", async () => {
    mocks.select.mockImplementation(() => { throw new Error("unavailable"); });
    const page = await FleetResultsPage({ params: params() });
    expect(page.props.event).toEqual(event);
  });

  it("rejects an unknown fleet before loading optional copy", async () => {
    await expect(FleetResultsPage({ params: params("unknown") })).rejects.toThrow("NOT_FOUND");
    expect(mocks.select).not.toHaveBeenCalled();
  });
});
